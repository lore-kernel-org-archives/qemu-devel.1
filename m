Received: from eggs.gnu.org ([208.118.235.92]:56899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1ep6rH-0001KF-Hy
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 01:30:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1ep6mh-0001Eo-Ue
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 01:29:27 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:38644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1ep6mh-0001Bd-BH
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 01:24:43 -0500
Received: by mail-pg0-x241.google.com with SMTP id l24so3015016pgc.5
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 22:24:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKN+_vdSVUn92Te-6DP4bP33ZE+OQ_HSe3erC4B7mtM70Q@mail.gmail.com>
References: <20180222222844.7109-1-frasse.iglesias@gmail.com>
	<20180222222844.7109-2-frasse.iglesias@gmail.com>
	<CAKmqyKN+_vdSVUn92Te-6DP4bP33ZE+OQ_HSe3erC4B7mtM70Q@mail.gmail.com>
From: francisco iglesias <frasse.iglesias@gmail.com>
Date: Fri, 23 Feb 2018 07:24:41 +0100
Message-ID: <CAAYMZQsHyKBRqhErwEsixDw9qeG-i=70TUT21aE1BeG2fU46Bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/2] xilinx_spips: Enable only two slaves
 when reading/writing with stripe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Edgar Iglesias <edgari@xilinx.com>, Alistair Francis <alistai@xilinx.com>, Francisco Iglesias <francisco.iglesias@feimtech.se>

On 22 February 2018 at 23:38, Alistair Francis <alistair23@gmail.com> wrote:

> On Thu, Feb 22, 2018 at 2:28 PM, Francisco Iglesias
> <frasse.iglesias@gmail.com> wrote:
> > Assert only the lower cs on bus 0 and upper cs on bus 1 when both buses
> and
> > chip selects are enabled (e.g reading/writing with stripe).
> >
> > Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> > ---
> >  hw/ssi/xilinx_spips.c | 42 ++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 38 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> > index 8af36ca3d4..e566d179fe 100644
> > --- a/hw/ssi/xilinx_spips.c
> > +++ b/hw/ssi/xilinx_spips.c
> > @@ -223,7 +223,7 @@ static void xilinx_spips_update_cs(XilinxSPIPS *s,
> int field)
> >  {
> >      int i;
> >
> > -    for (i = 0; i < s->num_cs; i++) {
> > +    for (i = 0; i < s->num_cs * s->num_busses; i++) {
> >          bool old_state = s->cs_lines_state[i];
> >          bool new_state = field & (1 << i);
> >
> > @@ -234,7 +234,7 @@ static void xilinx_spips_update_cs(XilinxSPIPS *s,
> int field)
> >          }
> >          qemu_set_irq(s->cs_lines[i], !new_state);
> >      }
> > -    if (!(field & ((1 << s->num_cs) - 1))) {
> > +    if (!(field & ((1 << (s->num_cs * s->num_busses)) - 1))) {
> >          s->snoop_state = SNOOP_CHECKING;
> >          s->cmd_dummies = 0;
> >          s->link_state = 1;
> > @@ -248,7 +248,41 @@ static void xlnx_zynqmp_qspips_update_cs_lines(XlnxZynqMPQSPIPS
> *s)
> >  {
> >      if (s->regs[R_GQSPI_GF_SNAPSHOT]) {
> >          int field = ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT,
> CHIP_SELECT);
> > -        xilinx_spips_update_cs(XILINX_SPIPS(s), field);
> > +        bool both_buses_enabled;
> > +        uint8_t buses;
> > +        int cs = 0;
> > +
> > +        buses = ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT,
> DATA_BUS_SELECT);
> > +        both_buses_enabled = (buses & 0x3) == 0x3;
> > +
> > +        if (both_buses_enabled) {
> > +            /* Bus 0 lower cs */
> > +            if (field & 1) {
> > +                cs |= 1;
> > +            }
> > +            /* Bus 1 upper cs */
> > +            if (field & (1 << 1)) {
> > +                cs |= 1 << 3;
> > +            }
> > +        } else {
> > +            /* Bus 0 lower cs */
> > +            if (buses & 1 && field & 1) {
> > +                cs |= 1;
> > +            }
> > +            /* Bus 0 upper cs */
> > +            if (buses & 1 && field & (1 << 1)) {
> > +                cs |= 1 << 1;
> > +            }
> > +            /* Bus 1 lower cs */
> > +            if (buses & (1 << 1) && field & 1) {
> > +                cs |= 1 << 2;
> > +            }
> > +            /* Bus 1 upper cs */
> > +            if (buses & (1 << 1) && field & (1 << 1)) {
> > +                cs |= 1 << 3;
> > +            }
>
> It might make more sense to have the buses & 1 in it's own if
> statement and have nested if statements here. Just to be easier to
> follow.
>
> Tested-by: Alistair Francis <alistair.francis@xilinx.com>
>
> Alistair
>
> Hi Alistair,

Thank you very much for reviewing and testing! Good point above, I'll do a
new version of the patch doing this.

Best regards,
Francisco Iglesias





> > +        }
> > +        xilinx_spips_update_cs(XILINX_SPIPS(s), cs);
> >      }
> >  }
> >
> > @@ -260,7 +294,7 @@ static void xilinx_spips_update_cs_lines(XilinxSPIPS
> *s)
> >      if (num_effective_busses(s) == 2) {
> >          /* Single bit chip-select for qspi */
> >          field &= 0x1;
> > -        field |= field << 1;
> > +        field |= field << 3;
> >      /* Dual stack U-Page */
> >      } else if (s->regs[R_LQSPI_CFG] & LQSPI_CFG_TWO_MEM &&
> >                 s->regs[R_LQSPI_STS] & LQSPI_CFG_U_PAGE) {
> > --
> > 2.11.0
> >
> >
>
