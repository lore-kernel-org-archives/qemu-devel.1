Received: from eggs.gnu.org ([2001:4830:134:3::10]:43693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cbEwO-0003Nn-5F
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 18:12:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cbEwM-0005ul-NP
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 18:12:52 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:35578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1cbEwM-0005uc-Iz
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 18:12:50 -0500
Received: by mail-ot0-x242.google.com with SMTP id 65so15973531otq.2
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 15:12:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170131122416.10284-2-ppandit@redhat.com>
References: <20170131122416.10284-1-ppandit@redhat.com>
	<20170131122416.10284-2-ppandit@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 7 Feb 2017 15:12:19 -0800
Message-ID: <CAKmqyKNerMUco=iokdcWLMu14mFRvxkO81VV=JfqfHOOD_CVfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 1/2] sd: sdhci: check transfer mode
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
Cc: Qemu Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Prasad J Pandit <pjp@fedoraproject.org>, Wjjzhang <wjjzhang@tencent.com>, Jiang Xin <jiangxin1@huawei.com>

On Tue, Jan 31, 2017 at 4:24 AM, P J P <ppandit@redhat.com> wrote:
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
>  hw/sd/sdhci.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 5bd5ab6..150464f 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -486,6 +486,12 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
>      uint32_t boundary_chk = 1 << (((s->blksize & 0xf000) >> 12) + 12);
>      uint32_t boundary_count = boundary_chk - (s->sdmasysad % boundary_chk);
>
> +    if (!(s->trnmod & SDHC_TRNS_MULTI)
> +        || !(s->trnmod & SDHC_TRNS_BLK_CNT_EN)
> +        || !s->blkcnt) {
> +        return;
> +    }
> +

This doesn't seem completely right to me.

Looking at the SD spec (pg.39 so I can find it in future) the block
count enable bit does only apply to multiple block transfers. So
moving it into the multi block transfer function looks correct (good
catch).

The spec says that the block count enable bit can be set to zero and
that disables the block count register, which is useful for an
infinite transfer. The bit should also be set to 0 if the data
transfer is more then 65535 blocks.

As it doesn't look like we have ever supported an infinite transfer
and we don't want infinite loops occurring I think we should add an
unsupported print statement here saying that we don't support infinite
transfers and then I'm ok with this patch.

>      /* XXX: Some sd/mmc drivers (for example, u-boot-slp) do not account for
>       * possible stop at page boundary if initial address is not page aligned,
>       * allow them to work properly */
> @@ -797,11 +803,6 @@ static void sdhci_data_transfer(void *opaque)
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
> @@ -1050,7 +1051,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
>          if (!(s->capareg & SDHC_CAN_DO_DMA)) {
>              value &= ~SDHC_TRNS_DMA;
>          }
> -        MASKED_WRITE(s->trnmod, mask, value);
> +        MASKED_WRITE(s->trnmod, mask, value & 0x0037);

What is this change doing?

Thanks,

Alistair

>          MASKED_WRITE(s->cmdreg, mask >> 16, value >> 16);
>
>          /* Writing to the upper byte of CMDREG triggers SD command generation */
> --
> 2.9.3
>
>
