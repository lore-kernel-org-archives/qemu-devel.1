Received: from eggs.gnu.org ([2001:4830:134:3::10]:38494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dul1d-0005Is-7B
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 15:51:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dul1c-000145-1y
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 15:51:13 -0400
References: <20170919201910.25656-1-eblake@redhat.com>
	<20170919201910.25656-6-eblake@redhat.com>
	<26069637-9535-cb59-8920-9d9a7eef78b7@redhat.com>
	<20170920021014.GB18491@lemon>
	<de133330-5cc3-d877-516c-38fc1928bebf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <adf09781-51c7-adda-bd0b-f2630fedceff@redhat.com>
Date: Wed, 20 Sep 2017 15:50:57 -0400
MIME-Version: 1.0
In-Reply-To: <de133330-5cc3-d877-516c-38fc1928bebf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 05/20] dirty-bitmap: Avoid size query
 failure during truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 09/20/2017 09:11 AM, Eric Blake wrote:
> On 09/19/2017 09:10 PM, Fam Zheng wrote:
> 
>>>
>>> Do you suspect that almost certainly if bdrv_truncate() fails overall
>>> that the image format driver will either unmount the image or become
>>> read-only?
> 
> Uggh - it feels like I've bitten off more than I can chew with this
> patch - I'm getting bogged down by trying to fix bad behavior in code
> that is mostly unrelated to the patch at hand, so I don't have a good
> opinion on WHAT is supposed to happen if bdrv_truncate() fails, only
> that I'm trying to avoid compounding that failure even worse.
> 

Yes, I apologize -- I realize I'm holding this series hostage. For now I
am just trying to legitimately understand the behavior. I am willing to
accept "It's sorta busted right now, but -EOUTOFSCOPE"

>>> I suppose if *not* that's a bug for callers of bdrv_truncate to allow
>>> that kind of monkey business, but if it CAN happen, hbitmap only guards
>>> against such things with an assert (which, IIRC, is not guaranteed to be
>>> on for all builds)
>>
>> It's guaranteed since a few hours ago:
>>
>> commit 262a69f4282e44426c7a132138581d400053e0a1
> 
> Indeed - but even without my patch, we would have hit the assertion
> failures when trying to resize the dirty bitmap to -1 when
> bdrv_nb_sectors() fails (which was likely if refresh_total_sectors()
> failed).
> 
>>> So the question is: "bdrv_truncate failure is NOT considered recoverable
>>> in ANY case, is it?"
>>>
>>> It may possibly be safer to, if the initial truncate request succeeds,
>>> apply a best-effort to the bitmap before returning the error.
>>
>> Like fallback "offset" (or it aligned up to bs cluster size) if
>> refresh_total_sectors() returns error? I think that is okay.
> 
> Here's my proposal for squashing in a best-effort dirty-bitmap resize no
> matter what happens in refresh_total_sectors() (but really, if you
> successfully truncate the disk but then get a failure while trying to
> read back the actual new size, which may differ from the requested size,
> you're probably doomed down the road anyways).
> 
> diff --git i/block.c w/block.c
> index 3caf6bb093..ef5af81f66 100644
> --- i/block.c
> +++ w/block.c
> @@ -3552,8 +3552,9 @@ int bdrv_truncate(BdrvChild *child, int64_t
> offset, PreallocMode prealloc,
>      if (ret < 0) {
>          error_setg_errno(errp, -ret, "Could not refresh total sector
> count");
>      } else {
> -        bdrv_dirty_bitmap_truncate(bs, bs->total_sectors *
> BDRV_SECTOR_SIZE);
> +        offset = bs->total_sectors * BDRV_SECTOR_SIZE;
>      }
> +    bdrv_dirty_bitmap_truncate(bs, offset);
>      bdrv_parent_cb_resize(bs);
>      atomic_inc(&bs->write_gen);
>      return ret;
> 
> 

Don't respin on my accord, I'm trying to find out if there is a problem;
I'm not convinced of one yet. Just thinking out loud.

Two cases:

(1) Attempt to resize larger. Resize succeeds, but refresh fails.
Possibly a temporary protocol failure, but we'll assume the resize
actually worked. Bitmap does not get resized, however any caller of
truncate *must* assume that the resize did not succeed. Any calls to
write beyond previous EOF are a bug by the calling module.

(2) Attempt to resize smaller, an actual truncate. Call succeeds but
refresh doesn't. Bitmap is now larger than the drive. The bitmap itself
is perfectly capable of describing reads/writes even to the now-OOB
area, but it's unlikely the BB would submit any. Problems may arise if
the BB does not treat this as a hard failure and a user later attempts
to use this bitmap for a backup operation, as the trailing bits now
reference disk segments that may or may not physically exist. Likely to
hit EIO problems during block jobs.


If we do decide to resize the bitmap even on refresh failure, We
probably do still run the risk of the bitmap being slightly bigger or
slightly smaller than the actual size due to alignment.

It sounds like the resize operation itself needs to be able to return to
the caller the actual size of the operation instead of forcing the
caller to query separately in a follow-up call to really "fix" this.

Considering that either resizing or not resizing the bitmap after a
partial failure probably still leaves us with a possibly dangerous
bitmap, I don't think I'll hold you to the flames over this one.

--js
