Received: from eggs.gnu.org ([2001:4830:134:3::10]:54901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g9YdE-0002mE-Mk
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 12:43:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g9YdD-0006eG-AT
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 12:43:44 -0400
Date: Mon, 8 Oct 2018 18:43:28 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181008164328.GA27808@localhost.localdomain>
References: <1534844779-118784-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1534844779-118784-4-git-send-email-anton.nefedov@virtuozzo.com>
	<20181004153359.GH6009@localhost.localdomain>
	<956674d6-0cb9-f68c-15e2-89d39cfac049@virtuozzo.com>
	<20181008150316.GB4604@localhost.localdomain>
	<15568cd5-fa4e-8271-fcfb-b70b738a48e8@virtuozzo.com>
	<20181008154617.GC4604@localhost.localdomain>
	<cfa81c77-e2c3-816b-f3cd-2556ee54f5cc@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfa81c77-e2c3-816b-f3cd-2556ee54f5cc@virtuozzo.com>
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

Am 08.10.2018 um 18:04 hat Anton Nefedov geschrieben:
> 
> 
> On 8/10/2018 6:46 PM, Kevin Wolf wrote:
> > Am 08.10.2018 um 17:25 hat Anton Nefedov geschrieben:
> >>
> >>
> >> On 8/10/2018 6:03 PM, Kevin Wolf wrote:
> >>> Am 08.10.2018 um 16:38 hat Anton Nefedov geschrieben:
> >>>> On 4/10/2018 6:33 PM, Kevin Wolf wrote:
> >>>>> Am 21.08.2018 um 11:46 hat Anton Nefedov geschrieben:
> >>>>>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> >>>>>> Reviewed-by: Alberto Garcia <berto@igalia.com>
> >>>>>> ---
> >>>>>>     hw/ide/core.c | 12 ++++++++++++
> >>>>>>     1 file changed, 12 insertions(+)
> >>>>>>
> >>>>>> diff --git a/hw/ide/core.c b/hw/ide/core.c
> >>>>>> index 2c62efc..352429b 100644
> >>>>>> --- a/hw/ide/core.c
> >>>>>> +++ b/hw/ide/core.c
> >>>>>> @@ -440,6 +440,14 @@ static void ide_issue_trim_cb(void *opaque, int ret)
> >>>>>>         TrimAIOCB *iocb = opaque;
> >>>>>>         IDEState *s = iocb->s;
> >>>>>>     
> >>>>>> +    if (iocb->i >= 0) {
> >>>>>> +        if (ret >= 0) {
> >>>>>> +            block_acct_done(blk_get_stats(s->blk), &s->acct);
> >>>>>> +        } else {
> >>>>>> +            block_acct_failed(blk_get_stats(s->blk), &s->acct);
> >>>>>> +        }
> >>>>>> +    }
> >>>>>> +
> >>>>>>         if (ret >= 0) {
> >>>>>>             while (iocb->j < iocb->qiov->niov) {
> >>>>>>                 int j = iocb->j;
> >>>>>> @@ -461,6 +469,9 @@ static void ide_issue_trim_cb(void *opaque, int ret)
> >>>>>>                         goto done;
> >>>>>>                     }
> >>>>>>     
> >>>>>> +                block_acct_start(blk_get_stats(s->blk), &s->acct,
> >>>>>> +                                 count << BDRV_SECTOR_BITS, BLOCK_ACCT_UNMAP);
> >>>>>> +
> >>>>>>                     /* Got an entry! Submit and exit.  */
> >>>>>>                     iocb->aiocb = blk_aio_pdiscard(s->blk,
> >>>>>>                                                    sector << BDRV_SECTOR_BITS,
> >>>>>> @@ -845,6 +856,7 @@ static void ide_dma_cb(void *opaque, int ret)
> >>>>>>         }
> >>>>>>     
> >>>>>>         if (ret == -EINVAL) {
> >>>>>> +        block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_UNMAP);
> >>>>>
> >>>>> This looks wrong to me, ide_dma_cb() is not only called for unmap, but
> >>>>> also for reads and writes, and each of them could return -EINVAL.
> >>>>>
> >>>>
> >>>> Stating here BLOCK_ACCT_UNMAP is definitely a blunder :(
> >>>>
> >>>>> Also, -EINVAL doesn't necessarily mean that the guest driver did
> >>>>> something wrong, it could also be the result of a host problem.
> >>>>> Therefore, it isn't right to call block_acct_invalid() here - especially
> >>>>> since the request may already have been accounted for as either done or
> >>>>> failed in ide_issue_trim_cb().
> >>>>>
> >>>>
> >>>> Couldn't be accounted done with such retcode;
> >>>> and it seems I shouldnt do block_acct_failed() there anyway - or it's
> >>>> accounted twice: there and in ide_dma_cb()->ide_handle_rw_error()
> >>>>
> >>>> But if EINVAL (from further layers) should not be accounted as an
> >>>> invalid op, then it should be accounted failed instead, the thing that
> >>>> current code does not do.
> >>>> (and which brings us back to possible double-accounting if we account
> >>>> invalid in ide_issue_trim_cb() )
> >>>
> >>> Yes, commit caeadbc8ba4 was already wrong in assuming that there is
> >>> only one possible source for -EINVAL.
> >>>
> >>>>> Instead, I think it would be better to immediately account for invalid
> >>>>> requests in ide_issue_trim_cb() where iocb->ret = -EINVAL is set and we
> >>>>> know for sure that indeed !ide_sect_range_ok() is the cause for the
> >>>>> -EINVAL return code.
> >>>>>
> >>>> So I guess yes, move acct_invalid in ide_issue_trim_cb() and leave
> >>>> acct_failed there, and filter off TRIM commands in the common
> >>>> accounting.
> >>>
> >>> blk_aio_discard() can fail with -EINVAL, too, so getting this error code
> >>> from a TRIM command doesn't mean anything. It can still have multiple
> >>> possible sources.
> >>>
> >>
> >> I meant that common ide_dma_cb() should account EINVAL (along with other
> >> errors) as failed, unless it's TRIM, which means it's already
> >> accounted (either invalid or failed)
> > 
> > Oh, you would already account for failure in ide_issue_trim_cb(), too,
> > but only if it's EINVAL? That feels like it would complicate the code
> > quite a bit.
> > 
> 
> No, no :) ide_issue_trim_cb does the proper accounting (failed/invalid)
> for TRIM.
> Then common path (ide_dma_cb()) does not account TRIM operations at all
> regardless of the error code. No need to check for TRIM specifically if
> we have BLOCK_ACCT_NONE.
> 
> > And actually, didn't commit caeadbc8ba4 break werror=stop for requests
> > returning -EINVAL because we don't call ide_handle_rw_error() any more?
> > 
> 
> Yes.
> 
> Read/write ignore werror=stop for invalid range case (not for EINVAL).
> I wonder if it's crucial to ignore it for TRIM too, otherwise we could
> just remove this chunk
> 
>       if (ret == -EINVAL) {
>           ide_dma_error(s);
>           return;
>       }

Ah, right, I forgot about this.

It is actually desirable to avoid stopping for invalid requests because
we should only stop for host errors. An invalid request is a guest error
and stopping the VM will do nothing to fix it. (Resuming the VM would
immediately fail again, so the VM would be locked in paused state.)

Kevin
