Received: from eggs.gnu.org ([2001:4830:134:3::10]:40307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eyk0V-00076t-6k
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:06:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eyk0S-0006Hb-1e
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:06:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38892 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1eyk0R-0006HO-TP
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:06:43 -0400
References: <1520010495-58172-1-git-send-email-anton.nefedov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <e4722d34-7d56-c110-3341-32457cd07e5d@redhat.com>
Date: Wed, 21 Mar 2018 16:06:28 -0400
MIME-Version: 1.0
In-Reply-To: <1520010495-58172-1-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ide: fix invalid TRIM range abortion for
 macio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk



On 03/02/2018 12:08 PM, Anton Nefedov wrote:
> commit 947858b0 "ide: abort TRIM operation for invalid range"
> is incorrect for macio; just ide_dma_error() without doing a callback
> is not enough for that errorpath.
> 
> Instead, pass -EINVAL to the callback and handle it there
> (see related motivation for read/write in 58ac32113).
> 
> It will however catch possible EINVAL from the block layer too.
> 
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  hw/ide/core.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 257b429..54510d4 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -402,7 +402,6 @@ typedef struct TrimAIOCB {
>      QEMUIOVector *qiov;
>      BlockAIOCB *aiocb;
>      int i, j;
> -    bool is_invalid;
>  } TrimAIOCB;
>  
>  static void trim_aio_cancel(BlockAIOCB *acb)
> @@ -430,11 +429,8 @@ static void ide_trim_bh_cb(void *opaque)
>  {
>      TrimAIOCB *iocb = opaque;
>  
> -    if (iocb->is_invalid) {
> -        ide_dma_error(iocb->s);
> -    } else {
> -        iocb->common.cb(iocb->common.opaque, iocb->ret);
> -    }
> +    iocb->common.cb(iocb->common.opaque, iocb->ret);
> +
>      qemu_bh_delete(iocb->bh);
>      iocb->bh = NULL;
>      qemu_aio_unref(iocb);
> @@ -462,7 +458,7 @@ static void ide_issue_trim_cb(void *opaque, int ret)
>                  }
>  
>                  if (!ide_sect_range_ok(s, sector, count)) {
> -                    iocb->is_invalid = true;
> +                    iocb->ret = -EINVAL;
>                      goto done;
>                  }
>  
> @@ -502,7 +498,6 @@ BlockAIOCB *ide_issue_trim(
>      iocb->qiov = qiov;
>      iocb->i = -1;
>      iocb->j = 0;
> -    iocb->is_invalid = false;
>      ide_issue_trim_cb(iocb, 0);
>      return &iocb->common;
>  }
> @@ -848,6 +843,12 @@ static void ide_dma_cb(void *opaque, int ret)
>      if (ret == -ECANCELED) {
>          return;
>      }
> +
> +    if (ret == -EINVAL) {
> +        ide_dma_error(s);
> +        return;
> +    }
> +
>      if (ret < 0) {
>          if (ide_handle_rw_error(s, -ret, ide_dma_cmd_to_retry(s->dma_cmd))) {
>              s->bus->dma->aiocb = NULL;
> 

Thanks, applied to my IDE tree:

https://github.com/jnsnow/qemu/commits/ide
https://github.com/jnsnow/qemu.git

--js
