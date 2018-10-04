Received: from eggs.gnu.org ([2001:4830:134:3::10]:55528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g85ds-0003dh-JO
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:34:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g85dq-00027g-NE
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:34:19 -0400
Date: Thu, 4 Oct 2018 17:33:59 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181004153359.GH6009@localhost.localdomain>
References: <1534844779-118784-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1534844779-118784-4-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534844779-118784-4-git-send-email-anton.nefedov@virtuozzo.com>
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, famz@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com

Am 21.08.2018 um 11:46 hat Anton Nefedov geschrieben:
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>  hw/ide/core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 2c62efc..352429b 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -440,6 +440,14 @@ static void ide_issue_trim_cb(void *opaque, int ret)
>      TrimAIOCB *iocb = opaque;
>      IDEState *s = iocb->s;
>  
> +    if (iocb->i >= 0) {
> +        if (ret >= 0) {
> +            block_acct_done(blk_get_stats(s->blk), &s->acct);
> +        } else {
> +            block_acct_failed(blk_get_stats(s->blk), &s->acct);
> +        }
> +    }
> +
>      if (ret >= 0) {
>          while (iocb->j < iocb->qiov->niov) {
>              int j = iocb->j;
> @@ -461,6 +469,9 @@ static void ide_issue_trim_cb(void *opaque, int ret)
>                      goto done;
>                  }
>  
> +                block_acct_start(blk_get_stats(s->blk), &s->acct,
> +                                 count << BDRV_SECTOR_BITS, BLOCK_ACCT_UNMAP);
> +
>                  /* Got an entry! Submit and exit.  */
>                  iocb->aiocb = blk_aio_pdiscard(s->blk,
>                                                 sector << BDRV_SECTOR_BITS,
> @@ -845,6 +856,7 @@ static void ide_dma_cb(void *opaque, int ret)
>      }
>  
>      if (ret == -EINVAL) {
> +        block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_UNMAP);

This looks wrong to me, ide_dma_cb() is not only called for unmap, but
also for reads and writes, and each of them could return -EINVAL.

Also, -EINVAL doesn't necessarily mean that the guest driver did
something wrong, it could also be the result of a host problem.
Therefore, it isn't right to call block_acct_invalid() here - especially
since the request may already have been accounted for as either done or
failed in ide_issue_trim_cb().

Instead, I think it would be better to immediately account for invalid
requests in ide_issue_trim_cb() where iocb->ret = -EINVAL is set and we
know for sure that indeed !ide_sect_range_ok() is the cause for the
-EINVAL return code.

>          ide_dma_error(s);
>          return;
>      }

Kevin
