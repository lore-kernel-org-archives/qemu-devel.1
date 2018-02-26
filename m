Received: from eggs.gnu.org ([2001:4830:134:3::10]:48200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eqEaM-0006Qm-3D
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 03:56:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eqEaL-0007Oi-8l
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 03:56:38 -0500
References: <20180223184700.28854-1-mark.cave-ayland@ilande.co.uk>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <ad6019e6-cc8f-f485-8e0e-9040a18704c8@virtuozzo.com>
Date: Mon, 26 Feb 2018 11:56:19 +0300
MIME-Version: 1.0
In-Reply-To: <20180223184700.28854-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] macio: fix NULL pointer dereference when
 issuing IDE trim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, jsnow@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org



On 23/2/2018 9:47 PM, Mark Cave-Ayland wrote:
> Commit ef0e64a983 "ide: pass IDEState to trim AIO callback" changed the
> IDE trim callback from using a BlockBackend to an IDEState but forgot to update
> the dma_blk_io() call in hw/ide/macio.c accordingly.
> 

I somehow missed this whole macio part in that series :(

> Without this fix qemu-system-ppc segfaults when issuing an IDE trim command on
> any of the PPC Mac machines (easily triggered by running the Debian installer).
> 
> Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Anton Nefedov <anton.nefedov@virtuozzo.com>

..but there should also be a fix-up for
947858b "ide: abort TRIM operation for invalid range"
which apparently lacks a few steps on the invalid range errorpath for
macio. I'll look into that.

> ---
>   hw/ide/macio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ide/macio.c b/hw/ide/macio.c
> index 2e043ef1ea..d3a85cba3b 100644
> --- a/hw/ide/macio.c
> +++ b/hw/ide/macio.c
> @@ -187,7 +187,7 @@ static void pmac_ide_transfer_cb(void *opaque, int ret)
>           break;
>       case IDE_DMA_TRIM:
>           s->bus->dma->aiocb = dma_blk_io(blk_get_aio_context(s->blk), &s->sg,
> -                                        offset, 0x1, ide_issue_trim, s->blk,
> +                                        offset, 0x1, ide_issue_trim, s,
>                                           pmac_ide_transfer_cb, io,
>                                           DMA_DIRECTION_TO_DEVICE);
>           break;
> 
