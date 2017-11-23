Received: from eggs.gnu.org ([2001:4830:134:3::10]:39029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eHfYE-0002Qb-C9
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 19:39:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eHfYD-0001KO-Ez
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 19:39:34 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:40262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eHfYD-0001K6-99
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 19:39:33 -0500
Received: by mail-wm0-x241.google.com with SMTP id b189so13429711wmd.5
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 16:39:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171103000109.28244-12-frasse.iglesias@gmail.com>
References: <20171103000109.28244-1-frasse.iglesias@gmail.com>
	<20171103000109.28244-12-frasse.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 22 Nov 2017 16:39:01 -0800
Message-ID: <CAKmqyKNgaQ5+5FPAW=1+Uj=tx5WEu-+Fh-u-tobF+6-KGL2P0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 11/13] xilinx_spips: Don't set TX FIFO
 UNDERFLOW at cmd done
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
> Don't set TX FIFO UNDERFLOW interrupt after done transmiting the commands.

after transmitting the commands

> Also update interrupts after reading out the interrupt status.
>
> Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>

Acked-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair


> ---
>  hw/ssi/xilinx_spips.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index 7f0f317..159a89d 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -329,9 +329,6 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
>          uint8_t addr_length;
>
>          if (fifo8_is_empty(&s->tx_fifo)) {
> -            if (!(s->regs[R_LQSPI_CFG] & LQSPI_CFG_LQ_MODE)) {
> -                s->regs[R_INTR_STATUS] |= IXR_TX_FIFO_UNDERFLOW;
> -            }
>              xilinx_spips_update_ixr(s);
>              return;
>          } else if (s->snoop_state == SNOOP_STRIPING) {
> @@ -530,6 +527,7 @@ static uint64_t xilinx_spips_read(void *opaque, hwaddr addr,
>          ret = s->regs[addr] & IXR_ALL;
>          s->regs[addr] = 0;
>          DB_PRINT_L(0, "addr=" TARGET_FMT_plx " = %x\n", addr * 4, ret);
> +        xilinx_spips_update_ixr(s);
>          return ret;
>      case R_INTR_MASK:
>          mask = IXR_ALL;
> --
> 2.9.3
>
>
