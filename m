Received: from eggs.gnu.org ([2001:4830:134:3::10]:59257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eMF26-0004uX-3S
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:21:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eMF1u-0005m8-AX
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:21:18 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1511196664-85304-3-git-send-email-anton.nefedov@virtuozzo.com>
References: <1511196664-85304-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1511196664-85304-3-git-send-email-anton.nefedov@virtuozzo.com>
Date: Tue, 05 Dec 2017 16:21:02 +0100
Message-ID: <w51po7t5hgh.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/7] ide: account UNMAP (TRIM)
 operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@virtuozzo.com, armbru@redhat.com, mreitz@redhat.com, pbonzini@redhat.com

On Mon 20 Nov 2017 05:50:59 PM CET, Anton Nefedov wrote:
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  hw/ide/core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 471d0c9..2e4dea7 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -389,6 +389,7 @@ typedef struct TrimAIOCB {
>      QEMUIOVector *qiov;
>      BlockAIOCB *aiocb;
>      int i, j;
> +    BlockAcctCookie acct;
>  } TrimAIOCB;
>  
>  static void trim_aio_cancel(BlockAIOCB *acb)
> @@ -426,6 +427,14 @@ static void ide_trim_bh_cb(void *opaque)
>  static void ide_issue_trim_cb(void *opaque, int ret)
>  {
>      TrimAIOCB *iocb = opaque;
> +    if (iocb->i >= 0) {
> +        if (ret >= 0) {
> +            block_acct_done(blk_get_stats(iocb->blk), &iocb->acct);
> +        } else {
> +            block_acct_failed(blk_get_stats(iocb->blk), &iocb->acct);
> +        }
> +    }

This part looks fine, but don't you also need to account for invalid
requests (in ide_dma_cb() or somewhere else) ?

Berto
