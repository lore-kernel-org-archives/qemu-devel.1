Received: from eggs.gnu.org ([2001:4830:134:3::10]:38632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eHfX9-0001vg-1s
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 19:38:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eHfX8-0000gw-6w
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 19:38:27 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eHfX8-0000g9-0f
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 19:38:26 -0500
Received: by mail-wm0-x244.google.com with SMTP id y82so15321836wmg.1
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 16:38:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171103000109.28244-11-frasse.iglesias@gmail.com>
References: <20171103000109.28244-1-frasse.iglesias@gmail.com>
	<20171103000109.28244-11-frasse.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 22 Nov 2017 16:37:54 -0800
Message-ID: <CAKmqyKNmX5xf7nW9LHOPbG9zj_XuMFoR_tYUx2ZqjYUqFPtq4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 10/13] xilinx_spips: Add support for 4
 byte addresses in the LQSPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Francisco Iglesias <frasse.iglesias@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Edgar Iglesias <edgari@xilinx.com>, Alistair Francis <alistai@xilinx.com>, francisco.iglesias@feimtech.se, "mar.krzeminski" <mar.krzeminski@gmail.com>

On Thu, Nov 2, 2017 at 5:01 PM, Francisco Iglesias
<frasse.iglesias@gmail.com> wrote:
> Add support for 4 byte addresses in the LQSPI and correct LQSPI_CFG_SEP_BUS.
>
> Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/ssi/xilinx_spips.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index 3a98799..7f0f317 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -92,8 +92,9 @@
>  #define R_LQSPI_CFG_RESET       0x03A002EB
>  #define LQSPI_CFG_LQ_MODE       (1U << 31)
>  #define LQSPI_CFG_TWO_MEM       (1 << 30)
> -#define LQSPI_CFG_SEP_BUS       (1 << 30)
> +#define LQSPI_CFG_SEP_BUS       (1 << 29)
>  #define LQSPI_CFG_U_PAGE        (1 << 28)
> +#define LQSPI_CFG_ADDR4         (1 << 27)
>  #define LQSPI_CFG_MODE_EN       (1 << 25)
>  #define LQSPI_CFG_MODE_WIDTH    8
>  #define LQSPI_CFG_MODE_SHIFT    16
> @@ -702,6 +703,9 @@ static void lqspi_load_cache(void *opaque, hwaddr addr)
>          fifo8_push(&s->tx_fifo, s->regs[R_LQSPI_CFG] & LQSPI_CFG_INST_CODE);
>          /* read address */
>          DB_PRINT_L(0, "pushing read address %06x\n", flash_addr);
> +        if (s->regs[R_LQSPI_CFG] & LQSPI_CFG_ADDR4) {
> +            fifo8_push(&s->tx_fifo, (uint8_t)(flash_addr >> 24));
> +        }
>          fifo8_push(&s->tx_fifo, (uint8_t)(flash_addr >> 16));
>          fifo8_push(&s->tx_fifo, (uint8_t)(flash_addr >> 8));
>          fifo8_push(&s->tx_fifo, (uint8_t)flash_addr);
> --
> 2.9.3
>
>
