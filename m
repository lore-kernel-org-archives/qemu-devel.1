Received: from eggs.gnu.org ([2001:4830:134:3::10]:38367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1eHxWe-0000Tr-M8
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 14:51:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1eHxWd-0008QX-MN
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 14:51:08 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:35323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1eHxWd-0008Pn-CF
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 14:51:07 -0500
Received: by mail-pf0-x242.google.com with SMTP id r88so9921659pfi.2
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 11:51:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKNgaQ5+5FPAW=1+Uj=tx5WEu-+Fh-u-tobF+6-KGL2P0g@mail.gmail.com>
References: <20171103000109.28244-1-frasse.iglesias@gmail.com>
	<20171103000109.28244-12-frasse.iglesias@gmail.com>
	<CAKmqyKNgaQ5+5FPAW=1+Uj=tx5WEu-+Fh-u-tobF+6-KGL2P0g@mail.gmail.com>
From: francisco iglesias <frasse.iglesias@gmail.com>
Date: Thu, 23 Nov 2017 20:51:05 +0100
Message-ID: <CAAYMZQvTzjWNPNNw046aiGC5+FSxoe1mNHn_QkQ=FzvmnzYO0w@mail.gmail.com>
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
To: Alistair Francis <alistair23@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Edgar Iglesias <edgari@xilinx.com>, Alistair Francis <alistai@xilinx.com>, Francisco Iglesias <francisco.iglesias@feimtech.se>, "mar.krzeminski" <mar.krzeminski@gmail.com>

Good day Alistair,

Thank you very much for reviewing agian! I will update the patch set
according to your comments and come back with a new version (v8)!

Best regards,
Francisco Iglesias


On 23 November 2017 at 01:39, Alistair Francis <alistair23@gmail.com> wrote:

> On Thu, Nov 2, 2017 at 5:01 PM, Francisco Iglesias
> <frasse.iglesias@gmail.com> wrote:
> > Don't set TX FIFO UNDERFLOW interrupt after done transmiting the
> commands.
>
> after transmitting the commands
>
> > Also update interrupts after reading out the interrupt status.
> >
> > Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
>
> Acked-by: Alistair Francis <alistair.francis@xilinx.com>
>
> Alistair
>
>
> > ---
> >  hw/ssi/xilinx_spips.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> > index 7f0f317..159a89d 100644
> > --- a/hw/ssi/xilinx_spips.c
> > +++ b/hw/ssi/xilinx_spips.c
> > @@ -329,9 +329,6 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS
> *s)
> >          uint8_t addr_length;
> >
> >          if (fifo8_is_empty(&s->tx_fifo)) {
> > -            if (!(s->regs[R_LQSPI_CFG] & LQSPI_CFG_LQ_MODE)) {
> > -                s->regs[R_INTR_STATUS] |= IXR_TX_FIFO_UNDERFLOW;
> > -            }
> >              xilinx_spips_update_ixr(s);
> >              return;
> >          } else if (s->snoop_state == SNOOP_STRIPING) {
> > @@ -530,6 +527,7 @@ static uint64_t xilinx_spips_read(void *opaque,
> hwaddr addr,
> >          ret = s->regs[addr] & IXR_ALL;
> >          s->regs[addr] = 0;
> >          DB_PRINT_L(0, "addr=" TARGET_FMT_plx " = %x\n", addr * 4, ret);
> > +        xilinx_spips_update_ixr(s);
> >          return ret;
> >      case R_INTR_MASK:
> >          mask = IXR_ALL;
> > --
> > 2.9.3
> >
> >
>
