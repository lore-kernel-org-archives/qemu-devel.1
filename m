Received: from eggs.gnu.org ([209.51.188.92]:45052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gzoQC-0005ic-FZ
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 15:06:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gzoQB-0002cy-A7
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 15:06:16 -0500
References: <20190301191545.8728-1-jsnow@redhat.com>
	<20190301191545.8728-7-jsnow@redhat.com>
	<5d204716-dc54-70ac-8b67-266ce8f44e0e@redhat.com>
	<ce11fd2d-0b28-9b67-2382-506f0bfd8754@redhat.com>
	<15751e4f-6415-219f-036b-26a3515a72ce@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <93e3f474-0235-7500-b4c7-3a4da17b29dd@redhat.com>
Date: Fri, 1 Mar 2019 15:04:17 -0500
MIME-Version: 1.0
In-Reply-To: <15751e4f-6415-219f-036b-26a3515a72ce@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 6/7] block/dirty-bitmaps: disallow busy
 bitmaps as merge source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, vsementsov@virtuozzo.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>



On 3/1/19 2:57 PM, Eric Blake wrote:
> On 3/1/19 1:48 PM, John Snow wrote:
> 
>>> I understand forbidding inconsistent sources (because if the source is
>>> potentially missing bits, then the merge destination will also be
>>> missing bits and thus be inconsistent), but why forbid busy?  If I've
>>> associated a bitmap with an NBD server (making it busy), it is still
>>> readable, and so I should still be able to merge its bits into another copy.
>>>
>>
>> True, do you rely on this, though?
> 
> Not in my current libvirt code (as I create a temporary bitmap to hand
> to NBD, since it may be the merge of one or more disabled bitmaps in a
> differential backup case), so being tighter for now and relaxing later
> if we DO come up with a use is acceptable.
> 
>>
>> I was working from a space of "busy" meant "actively in-use by an
>> operation, and COULD change" so I was forbidding it out of good hygiene.
>>
>> Clearly the ones in-use by NBD are actually static and unchanging, so
>> it's safer -- but that might not be true for push backups, where you
>> might not actually be getting what you think you are, because of the
>> bifurcated nature of those bitmaps.
> 
> Oh, good point, especially after you worked so hard to merge
> locked/frozen into a single status - you WILL miss the bits from the
> successor (unless we teach the merge algorithm to pull in the busy
> bitmap's bits AND all the bits of its successors - but that feels like a
> lot of work if we don't have a client needing it now).  Okay, with the
> extra justification mentioned in the commit message,
> 

(Though I am being a little fast and loose here: when we split a bitmap,
the top-level one that retains the name actually stays unchanging and
the child bitmap is the one that starts accruing writes from a blank
canvas, but that STILL may not be what you expect when you choose it as
a merge source, however.)

>>
>> If this causes a problem for you in the short-term I will simply roll
>> this back, but it stands out to me.
>>
>> (I can't stop myself from trying to protect the user from themselves.
>> It's clearly a recurring theme in my design and reviews.)
>>
>>>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>>>> index 769668ccdc..8403c9981d 100644
>>>> --- a/block/dirty-bitmap.c
>>>> +++ b/block/dirty-bitmap.c
>>>> @@ -825,6 +825,9 @@ void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
>>>>          goto out;
>>>>      }
>>>>  
>>>> +    if (bdrv_dirty_bitmap_check(src, BDRV_BITMAP_ALLOW_RO, errp)) {
>>>
>>> Thus, I think this should be BDRV_BITMAP_INCONSISTENT.
> 
> then I retract my complaint, and the code is acceptable for now.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 

We could always split it back out later, but in basic terms for
permissions and user perspective, "in use" seems robust enough of a
resolution. (It might be safe to read, it might not be, who knows --
it's in use.)

If it really comes to a point, we can always re-add a new status bit to
let the end-user know if they're working with a bifurcated (I have to
use weird vocabulary words sometimes) bitmap but at the moment it seems
very safely an implementation detail.

You can also check that for "enabled" bitmap as reported back to user
via QAPI I check to see if the parent OR child is enabled and report
that cumulatively as "enabled", because together they are "effectively"
enabled.

--js
