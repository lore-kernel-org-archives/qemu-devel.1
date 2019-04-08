Received: from eggs.gnu.org ([209.51.188.92]:52796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDRFt-0002sV-9G
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDRFr-0005LD-Tv
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:11:57 -0400
Date: Mon, 8 Apr 2019 12:04:42 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190408100442.GA11997@linux.fritz.box>
References: <1554474244-553661-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<ad53e61a-a911-c019-3f68-2bd05b7be944@redhat.com>
	<468cc6c9-c338-a4fe-57b1-b4df5b2b24c0@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <468cc6c9-c338-a4fe-57b1-b4df5b2b24c0@virtuozzo.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block/io.c: fix for the
 allocation failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Cc: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "fam@euphon.net" <fam@euphon.net>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, Denis Lunev <den@virtuozzo.com>

Am 08.04.2019 um 11:44 hat Andrey Shinkevich geschrieben:
> 
> 
> On 06/04/2019 01:50, John Snow wrote:
> > 
> > 
> > On 4/5/19 10:24 AM, Andrey Shinkevich wrote:
> >> On a file system used by the customer, fallocate() returns an error
> >> if the block is not properly aligned. So, bdrv_co_pwrite_zeroes()
> >> fails. We can handle that case the same way as it is done for the
> >> unsupported cases, namely, call to bdrv_driver_pwritev() that writes
> >> zeroes to an image for the unaligned chunk of the block.
> >>
> >> Suggested-by: Denis V. Lunev <den@openvz.org>
> >> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> >> ---
> >>   block/io.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/block/io.c b/block/io.c
> >> index dfc153b..0412a51 100644
> >> --- a/block/io.c
> >> +++ b/block/io.c
> >> @@ -1516,7 +1516,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
> >>               assert(!bs->supported_zero_flags);
> >>           }
> >>   
> >> -        if (ret == -ENOTSUP && !(flags & BDRV_REQ_NO_FALLBACK)) {
> >> +        if (ret < 0 && !(flags & BDRV_REQ_NO_FALLBACK)) {
> >>               /* Fall back to bounce buffer if write zeroes is unsupported */
> >>               BdrvRequestFlags write_flags = flags & ~BDRV_REQ_ZERO_WRITE;
> >>   
> >>
> > 
> > I suppose that if fallocate fails for any reason and we're allowing
> > fallback, we're either going to succeed ... or fail again very soon
> > thereafter.
> > 
> > Are there any cases where it is vital to not ignore the first fallocate
> > failure? I'm a little wary of ignoring the return code from
> > bdrv_co_pwrite_zeroes, but I am assuming that if there is a "real"
> > failure here that the following bounce writes will also fail "safely."
> > 
> > I'm not completely confident, but I have no tangible objections:
> > Reviewed-by: John Snow <jsnow@redhat.com>
> > 
> 
> Thank you for your review, John!
> 
> Let me clarify the circumstances and quote the bug report:
> "Customer had Win-2012 VM with 50GB system disk which was later resized 
> to 256GB without resizing the partition inside VM.
> Now, while trying to resize to 50G, the following error will appear
> 'Failed to reduce the number of L2 tables: Invalid argument'
> It was found that it is possible to shrink the disk to 128G and any size 
> above that number, but size below 128G will bring the mentioned error."
> 
> The fallocate() returns no error on that file system if the offset and
> the (offset + bytes) parameters of the bdrv_co_do_pwrite_zeroes() both
> are aligned to 4K.

What is the return value you get from this file system?

Maybe turning that into ENOTSUP in file-posix would be less invasive.
Just falling back for any error gives me the vague feeling that it could
cause problems sooner or later.

Kevin
