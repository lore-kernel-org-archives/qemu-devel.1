Received: from eggs.gnu.org ([2001:4830:134:3::10]:48610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1eeiSS-0001tI-Bt
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:24:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1eeiSR-0001NV-7p
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:24:52 -0500
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:34345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1eeiSQ-0001Mc-Vo
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:24:51 -0500
Received: by mail-pf0-x22e.google.com with SMTP id e76so5871642pfk.1
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 06:24:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA95ynTVO_WwkXAJj24ixjfS33jnqwZbJYr1=qsz76k0Eg@mail.gmail.com>
References: <20180124215708.30400-1-frasse.iglesias@gmail.com>
	<CAFEAcA95ynTVO_WwkXAJj24ixjfS33jnqwZbJYr1=qsz76k0Eg@mail.gmail.com>
From: francisco iglesias <frasse.iglesias@gmail.com>
Date: Thu, 25 Jan 2018 15:24:49 +0100
Message-ID: <CAAYMZQtMwOC1+JLmxX-k6NTnzHNs-Y2n3rZe8fZM+h5xWhBisw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] xilinx_spips: Correct usage of an
 uninitialized local variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>, Alistair Francis <alistai@xilinx.com>, Francisco Iglesias <francisco.iglesias@feimtech.se>

On Thursday, 25 January 2018, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 24 January 2018 at 21:57, Francisco Iglesias
> <frasse.iglesias@gmail.com> wrote:
> > Coverity found that the variable tx_rx in the function
> > xilinx_spips_flush_txfifo was being used uninitialized (CID 1383841).
> This
> > patch corrects this by always initializing tx_rx to zeros.
> >
> > Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> >
> > ---
> > v3. Change to report errors on the num_busses property via the Error**
> >     parameter when realizing the devices.
> > ---
> > v2. Add a sanity check on the num_busses property when realizing the
> >     devices.
> > ---
> >  hw/ssi/xilinx_spips.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> > index 85c5d0c..8af36ca 100644
> > --- a/hw/ssi/xilinx_spips.c
> > +++ b/hw/ssi/xilinx_spips.c
> > @@ -210,6 +210,9 @@
> >  #define SNOOP_NONE 0xEE
> >  #define SNOOP_STRIPING 0
> >
> > +#define MIN_NUM_BUSSES 1
> > +#define MAX_NUM_BUSSES 2
> > +
> >  static inline int num_effective_busses(XilinxSPIPS *s)
> >  {
> >      return (s->regs[R_LQSPI_CFG] & LQSPI_CFG_SEP_BUS &&
> > @@ -573,7 +576,7 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS
> *s)
> >      for (;;) {
> >          int i;
> >          uint8_t tx = 0;
> > -        uint8_t tx_rx[num_effective_busses(s)];
> > +        uint8_t tx_rx[MAX_NUM_BUSSES] = { 0 };
> >          uint8_t dummy_cycles = 0;
> >          uint8_t addr_length;
> >
> > @@ -1221,6 +1224,19 @@ static void xilinx_spips_realize(DeviceState
> *dev, Error **errp)
> >
> >      DB_PRINT_L(0, "realized spips\n");
> >
> > +    if (s->num_busses > MAX_NUM_BUSSES) {
> > +        error_setg(errp,
> > +                   "requested number of SPI busses %u exceeds maximum
> %d",
> > +                   s->num_busses, MAX_NUM_BUSSES);
> > +        return;
> > +    }
> > +    if (s->num_busses < MIN_NUM_BUSSES) {
> > +        error_setg(errp,
> > +                   "requested number of SPI busses %u is below minimum
> %d",
> > +                   s->num_busses, MIN_NUM_BUSSES);
> > +        return;
> > +    }
> > +
>
> The usual plural of "bus" is "buses", but since it's in the QOM
> property name I guess we're stuck with "busses" here for consistency...
>
>
> Applied to target-arm.next, thanks.
>
> -- PMM
>

Hi Peter,

Thank you very much again for looking into this!

Best regards,
Francisco Iglesias
