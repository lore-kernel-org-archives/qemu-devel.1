Received: from eggs.gnu.org ([2001:4830:134:3::10]:58888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gMIVJ-0001Vo-3u
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 15:08:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gMIMH-0003Qs-Hl
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 14:58:54 -0500
References: <20181111094023.18038-1-mark.cave-ayland@ilande.co.uk>
From: John Snow <jsnow@redhat.com>
Message-ID: <96edc28b-1752-dc4e-ceb8-7078cb041392@redhat.com>
Date: Mon, 12 Nov 2018 14:58:44 -0500
MIME-Version: 1.0
In-Reply-To: <20181111094023.18038-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1] fdc: fix segfault in
 fdctrl_stop_transfer() when DMA is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, hpoussin@reactos.org, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, martin@duskware.de



On 11/11/18 4:40 AM, Mark Cave-Ayland wrote:
> Commit c8a35f1cf0f "fdc: use IsaDma interface instead of global DMA_*
> functions" accidentally introduced a segfault in fdctrl_stop_transfer() for
> non-DMA transfers.
> 
> If fdctrl->dma_chann has not been configured then the fdctrl->dma interface
> reference isn't initialised during isabus_fdc_realize(). Unfortunately
> fdctrl_stop_transfer() unconditionally references the DMA interface when
> finishing the transfer causing a NULL pointer dereference.
> 
> Fix the issue by adding a check in fdctrl_stop_transfer() so that the DMA
> interface reference and release method is only invoked if fdctrl->dma_chann
> has been set.
> 
> (This issue was discovered by Martin testing a recent change in the NetBSD
> installer under qemu-system-sparc)
> 
> Reported-by: Martin Husemann <martin@duskware.de>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/block/fdc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index 2e9c1e1e2f..6f19f127a5 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -1617,7 +1617,7 @@ static void fdctrl_stop_transfer(FDCtrl *fdctrl, uint8_t status0,
>      fdctrl->fifo[5] = cur_drv->sect;
>      fdctrl->fifo[6] = FD_SECTOR_SC;
>      fdctrl->data_dir = FD_DIR_READ;
> -    if (!(fdctrl->msr & FD_MSR_NONDMA)) {
> +    if (fdctrl->dma_chann != -1 && !(fdctrl->msr & FD_MSR_NONDMA)) {
>          IsaDmaClass *k = ISADMA_GET_CLASS(fdctrl->dma);
>          k->release_DREQ(fdctrl->dma, fdctrl->dma_chann);
>      }
> 

Thanks.

Reviewed-by: John Snow <jsnow@redhat.com>

... Kevin, would you mind staging this one-off for the next RC?

--js
