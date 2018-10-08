Received: from eggs.gnu.org ([2001:4830:134:3::10]:48102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g9X4M-00087E-SA
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g9X4K-0002a5-OA
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:03:38 -0400
Date: Mon, 8 Oct 2018 17:03:16 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181008150316.GB4604@localhost.localdomain>
References: <1534844779-118784-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1534844779-118784-4-git-send-email-anton.nefedov@virtuozzo.com>
	<20181004153359.GH6009@localhost.localdomain>
	<956674d6-0cb9-f68c-15e2-89d39cfac049@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <956674d6-0cb9-f68c-15e2-89d39cfac049@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v4 3/8] ide: account UNMAP (TRIM) operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, "berto@igalia.com" <berto@igalia.com>

Am 08.10.2018 um 16:38 hat Anton Nefedov geschrieben:
> On 4/10/2018 6:33 PM, Kevin Wolf wrote:
> > Am 21.08.2018 um 11:46 hat Anton Nefedov geschrieben:
> >> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> >> Reviewed-by: Alberto Garcia <berto@igalia.com>
> >> ---
> >>   hw/ide/core.c | 12 ++++++++++++
> >>   1 file changed, 12 insertions(+)
> >>
> >> diff --git a/hw/ide/core.c b/hw/ide/core.c
> >> index 2c62efc..352429b 100644
> >> --- a/hw/ide/core.c
> >> +++ b/hw/ide/core.c
> >> @@ -440,6 +440,14 @@ static void ide_issue_trim_cb(void *opaque, int ret)
> >>       TrimAIOCB *iocb = opaque;
> >>       IDEState *s = iocb->s;
> >>   
> >> +    if (iocb->i >= 0) {
> >> +        if (ret >= 0) {
> >> +            block_acct_done(blk_get_stats(s->blk), &s->acct);
> >> +        } else {
> >> +            block_acct_failed(blk_get_stats(s->blk), &s->acct);
> >> +        }
> >> +    }
> >> +
> >>       if (ret >= 0) {
> >>           while (iocb->j < iocb->qiov->niov) {
> >>               int j = iocb->j;
> >> @@ -461,6 +469,9 @@ static void ide_issue_trim_cb(void *opaque, int ret)
> >>                       goto done;
> >>                   }
> >>   
> >> +                block_acct_start(blk_get_stats(s->blk), &s->acct,
> >> +                                 count << BDRV_SECTOR_BITS, BLOCK_ACCT_UNMAP);
> >> +
> >>                   /* Got an entry! Submit and exit.  */
> >>                   iocb->aiocb = blk_aio_pdiscard(s->blk,
> >>                                                  sector << BDRV_SECTOR_BITS,
> >> @@ -845,6 +856,7 @@ static void ide_dma_cb(void *opaque, int ret)
> >>       }
> >>   
> >>       if (ret == -EINVAL) {
> >> +        block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_UNMAP);
> > 
> > This looks wrong to me, ide_dma_cb() is not only called for unmap, but
> > also for reads and writes, and each of them could return -EINVAL.
> > 
> 
> Stating here BLOCK_ACCT_UNMAP is definitely a blunder :(
> 
> > Also, -EINVAL doesn't necessarily mean that the guest driver did
> > something wrong, it could also be the result of a host problem.
> > Therefore, it isn't right to call block_acct_invalid() here - especially
> > since the request may already have been accounted for as either done or
> > failed in ide_issue_trim_cb().
> > 
> 
> Couldn't be accounted done with such retcode;
> and it seems I shouldnt do block_acct_failed() there anyway - or it's
> accounted twice: there and in ide_dma_cb()->ide_handle_rw_error()
> 
> But if EINVAL (from further layers) should not be accounted as an
> invalid op, then it should be accounted failed instead, the thing that
> current code does not do.
> (and which brings us back to possible double-accounting if we account
> invalid in ide_issue_trim_cb() )

Yes, commit caeadbc8ba4 was already wrong in assuming that there is
only one possible source for -EINVAL.

> > Instead, I think it would be better to immediately account for invalid
> > requests in ide_issue_trim_cb() where iocb->ret = -EINVAL is set and we
> > know for sure that indeed !ide_sect_range_ok() is the cause for the
> > -EINVAL return code.
> > 
> So I guess yes, move acct_invalid in ide_issue_trim_cb() and leave
> acct_failed there, and filter off TRIM commands in the common
> accounting.

blk_aio_discard() can fail with -EINVAL, too, so getting this error code
from a TRIM command doesn't mean anything. It can still have multiple
possible sources.

Maybe we just need to remember somewhere whether we already accounted
for a request (maybe an additional field in BlockAcctCookie? Or change
the type to BLOCK_ACCT_ALREADY_ACCOUNTED?) and then make an additional
block_account_one_io() call a no-op for such requests.

Kevin
