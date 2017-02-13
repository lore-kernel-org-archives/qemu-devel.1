Received: from eggs.gnu.org ([2001:4830:134:3::10]:44460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cdMjb-00037V-Ns
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 14:56:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cdMja-0005wP-B6
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 14:56:27 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:35316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1cdMja-0005wK-5j
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 14:56:26 -0500
Received: by mail-oi0-x244.google.com with SMTP id x84so539023oix.2
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 11:56:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170211150701.23391-2-ppandit@redhat.com>
References: <20170211150701.23391-1-ppandit@redhat.com>
	<20170211150701.23391-2-ppandit@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Feb 2017 11:55:55 -0800
Message-ID: <CAKmqyKNqmkH_BUzSszPSMp-pLWc52fyK7PnHdP7k-9vMuULoKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 1/4] sd: sdhci: check transfer mode
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
Cc: Qemu Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Wjjzhang <wjjzhang@tencent.com>, Jiang Xin <jiangxin1@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

On Sat, Feb 11, 2017 at 7:06 AM, P J P <ppandit@redhat.com> wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> In the SDHCI protocol, the transfer mode register value
> is used during multi block transfer to check if block count
> register is enabled and should be updated. Transfer mode
> register could be set such that, block count register would
> not be updated, thus leading to an infinite loop. Add check
> to avoid it.
>
> Reported-by: Wjjzhang <wjjzhang@tencent.com>
> Reported-by: Jiang Xin <jiangxin1@huawei.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,

Alistair

> ---
>  hw/sd/sdhci.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> Update: use qemu_log_mask(LOG_UNIMP, ...)
>   -> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg02354.html
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 5bd5ab6..a9c744b 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -486,6 +486,11 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
>      uint32_t boundary_chk = 1 << (((s->blksize & 0xf000) >> 12) + 12);
>      uint32_t boundary_count = boundary_chk - (s->sdmasysad % boundary_chk);
>
> +    if (!(s->trnmod & SDHC_TRNS_BLK_CNT_EN) || !s->blkcnt) {
> +        qemu_log_mask(LOG_UNIMP, "infinite transfer is not supported\n");
> +        return;
> +    }
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
> --
> 2.9.3
>
