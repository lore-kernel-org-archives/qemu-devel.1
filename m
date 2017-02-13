Received: from eggs.gnu.org ([2001:4830:134:3::10]:44374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cdMjM-0002zi-Ah
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 14:56:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cdMjL-0005tt-0J
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 14:56:12 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:34418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1cdMjK-0005tn-QY
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 14:56:10 -0500
Received: by mail-oi0-x244.google.com with SMTP id w144so503362oiw.1
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 11:56:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170211150701.23391-4-ppandit@redhat.com>
References: <20170211150701.23391-1-ppandit@redhat.com>
	<20170211150701.23391-4-ppandit@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Feb 2017 11:55:39 -0800
Message-ID: <CAKmqyKOxdC09Mq-dkP5+-CMwYWdQO3oJCWgWPkz2Q9fvNSbw0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 3/4] sd: sdhci: conditionally invoke
 multi block transfer
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

On Sat, Feb 11, 2017 at 7:07 AM, P J P <ppandit@redhat.com> wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> In sdhci_write invoke multi block transfer if it is enabled
> in the transfer mode register 's->trnmod'.
>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,

Alistair

> ---
>  hw/sd/sdhci.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> Update: test if (s->trnmod & SDHC_TRNS_MULTI) is true
>   -> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg02357.html
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 0307b8c..99fa0c7 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1022,7 +1022,11 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
>          /* Writing to last byte of sdmasysad might trigger transfer */
>          if (!(mask & 0xFF000000) && TRANSFERRING_DATA(s->prnsts) && s->blkcnt &&
>                  s->blksize && SDHC_DMA_TYPE(s->hostctl) == SDHC_CTRL_SDMA) {
> -            sdhci_sdma_transfer_multi_blocks(s);
> +            if (s->trnmod & SDHC_TRNS_MULTI) {
> +                sdhci_sdma_transfer_multi_blocks(s);
> +            } else {
> +                sdhci_sdma_transfer_single_block(s);
> +            }
>          }
>          break;
>      case SDHC_BLKSIZE:
> --
> 2.9.3
>
