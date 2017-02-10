Received: from eggs.gnu.org ([2001:4830:134:3::10]:57022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ccJwy-0003oS-0J
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 17:45:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ccJww-0007VE-4z
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 17:45:55 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:33106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ccJww-0007Sd-0f
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 17:45:54 -0500
Received: by mail-oi0-x243.google.com with SMTP id j15so3482653oih.0
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 14:45:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170208064212.25307-2-ppandit@redhat.com>
References: <20170208064212.25307-1-ppandit@redhat.com>
	<20170208064212.25307-2-ppandit@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Feb 2017 14:45:20 -0800
Message-ID: <CAKmqyKNHmzKx6npTEQXN9Hzscc5sBmj159gBkaGx6WLzCOJBYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 1/3] sd: sdhci: check transfer mode
 register in multi block transfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Wjjzhang <wjjzhang@tencent.com>, Jiang Xin <jiangxin1@huawei.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>

On Tue, Feb 7, 2017 at 10:42 PM, P J P <ppandit@redhat.com> wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> In SDHCI device emulation the transfer mode register value
> is used during multi block transfer to check if block count
> register is enabled and should be updated. Transfer mode
> register could be set such that, block count register would
> not be updated, thus leading to an infinite loop. Add check
> to avoid it.
>
> Reported-by: Wjjzhang <wjjzhang@tencent.com>
> Reported-by: Jiang Xin <jiangxin1@huawei.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/sd/sdhci.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> Update per: print an error message before return
>   -> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg01567.html
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 5bd5ab6..cf400c8 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -486,6 +486,11 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
>      uint32_t boundary_chk = 1 << (((s->blksize & 0xf000) >> 12) + 12);
>      uint32_t boundary_count = boundary_chk - (s->sdmasysad % boundary_chk);
>
> +    if (!(s->trnmod & SDHC_TRNS_BLK_CNT_EN) || !s->blkcnt) {
> +        ERRPRINT("Infinite transfers are not supported\n");
> +        return;
> +    }

You should use the qemu_log_mask() function. It'll look something like this:

qemu_log_mask(LOG_UNIMP, ....

> +
>      /* XXX: Some sd/mmc drivers (for example, u-boot-slp) do not account for
>       * possible stop at page boundary if initial address is not page aligned,
>       * allow them to work properly */
> @@ -797,11 +802,6 @@ static void sdhci_data_transfer(void *opaque)
>      if (s->trnmod & SDHC_TRNS_DMA) {
>          switch (SDHC_DMA_TYPE(s->hostctl)) {
>          case SDHC_CTRL_SDMA:
> -            if ((s->trnmod & SDHC_TRNS_MULTI) &&
> -                    (!(s->trnmod & SDHC_TRNS_BLK_CNT_EN) || s->blkcnt == 0)) {
> -                break;
> -            }
> -
>              if ((s->blkcnt == 1) || !(s->trnmod & SDHC_TRNS_MULTI)) {
>                  sdhci_sdma_transfer_single_block(s);
>              } else {
> @@ -1050,7 +1050,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
>          if (!(s->capareg & SDHC_CAN_DO_DMA)) {
>              value &= ~SDHC_TRNS_DMA;
>          }
> -        MASKED_WRITE(s->trnmod, mask, value);
> +        MASKED_WRITE(s->trnmod, mask, value & 0x0037);

Maybe this is worth being in a separate patch with an explanation.

Thanks,

Alistair

>          MASKED_WRITE(s->cmdreg, mask >> 16, value >> 16);
>
>          /* Writing to the upper byte of CMDREG triggers SD command generation */
> --
> 2.9.3
>
