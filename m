Received: from eggs.gnu.org ([2001:4830:134:3::10]:39365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1eaAF4-0006Oy-Do
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 20:04:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1eaAF2-0005rB-RT
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 20:04:14 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:42987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1eaAF2-0005qs-I0
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 20:04:12 -0500
Received: by mail-pf0-x242.google.com with SMTP id d23so5637150pfe.9
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 17:04:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Z2-M88JS7n+zW1AgA99gmeT-cj90BjbEzYEN95c6Zuw@mail.gmail.com>
References: <20171126231634.9531-1-frasse.iglesias@gmail.com>
	<20171126231634.9531-8-frasse.iglesias@gmail.com>
	<CAFEAcA-Z2-M88JS7n+zW1AgA99gmeT-cj90BjbEzYEN95c6Zuw@mail.gmail.com>
From: francisco iglesias <frasse.iglesias@gmail.com>
Date: Sat, 13 Jan 2018 02:04:10 +0100
Message-ID: <CAAYMZQvY=yp2xaGWPPW3gXrj_no3jWgtemJY3eDgo34WU2OVCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v9 07/13] xilinx_spips: Add support for RX
 discard and RX drain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>, Alistair Francis <alistai@xilinx.com>, Francisco Iglesias <francisco.iglesias@feimtech.se>, =?UTF-8?Q?Marcin_Krzemi=C5=84ski?= <mar.krzeminski@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

Hi Peter,

I looked at the coverity output and below are my comments. Please do
correct me if I misunderstood something!

----
CID 1383841 (#1 of 4): Uninitialized scalar variable (UNINIT)26.
uninit_use_in_call: Using uninitialized element of array tx_rx when calling
stripe8.

'num_effective_busses' can only return 1 or 2 so the foor loop initializing
the array should always be executed, meaning that above shouldn't happen as
I see it.

----
CID 1383841 (#2 of 4): Uninitialized scalar variable (UNINIT)29.
uninit_use_in_call: Using uninitialized value (uint32_t)tx_rx[0] when
calling
ssi_transfer.

This is correct, tx_rx is used uninitialized but since we are transmitting
dummy cycles the transmitted value (tx_rx[0] in this case) is not used (by
the flashes), this the reason the code looks like that. Would you like me
to create a patch for quieting coverity here anyway?

----
CID 1383841 (#3 of 4): Uninitialized scalar variable (UNINIT)29.
uninit_use_in_call: Using uninitialized value (uint32_t)tx_rx[i] when
calling
ssi_transfer.

This occurs if the last 'else' of the first 'if' ladder is executed and
dummy_cycles is zero, something that shouldn't happen either. 's->link
state' is 1, 2 or 4 so dummy_cycles will always be greater than zero if the
'else' is executed.

----
CID 1383841 (#4 of 4): Uninitialized scalar variable (UNINIT)34.
uninit_use_in_call: Using uninitialized value (uint8_t)tx_rx[0] when calling
fifo8_push.

Since num_effective_busses is always greater than 0, the foor loop in the
middle (with the ssi_transfer calls) always initializes tx_rx[0] before
this access. So this one can't happen either.

----
All together #1, #3, #4 seem to be false positives what I can see, #2 was
known and left intentionaly like that (since tx_rx value doesn't matter)
but can be remade for quieting coverity if wished.

Best regards,
Francisco Iglesias

On 11 January 2018 at 14:16, Peter Maydell <peter.maydell@linaro.org> wrote:

> On 26 November 2017 at 23:16, Francisco Iglesias
> <frasse.iglesias@gmail.com> wrote:
> > Add support for the RX discard and RX drain functionality. Also transmit
> > one byte per dummy cycle (to the flash memories) with commands that
> require
> > these.
> >
> > Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> > Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> > Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>
> Hi. Coverity (CID 1383841) complains that this change introduces
> a use of an uninitialized local variable:
>
>
> >  static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
> >  {
> >      int debug_level = 0;
> > +    XilinxQSPIPS *q = (XilinxQSPIPS *) object_dynamic_cast(OBJECT(s),
> > +
>  TYPE_XILINX_QSPIPS);
> >
> >      for (;;) {
> >          int i;
> >          uint8_t tx = 0;
> >          uint8_t tx_rx[num_effective_busses(s)];
>
> tx_rx[] is the variable in question.
>
> > +        uint8_t dummy_cycles = 0;
> > +        uint8_t addr_length;
> >
> >          if (fifo8_is_empty(&s->tx_fifo)) {
> >              if (!(s->regs[R_LQSPI_CFG] & LQSPI_CFG_LQ_MODE)) {
> > @@ -258,54 +336,102 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS
> *s)
> >                  tx_rx[i] = fifo8_pop(&s->tx_fifo);
> >              }
> >              stripe8(tx_rx, num_effective_busses(s), false);
> > -        } else {
> > +        } else if (s->snoop_state >= SNOOP_ADDR) {
> >              tx = fifo8_pop(&s->tx_fifo);
> >              for (i = 0; i < num_effective_busses(s); ++i) {
> >                  tx_rx[i] = tx;
> >              }
> > +        } else {
> > +            /* Extract a dummy byte and generate dummy cycles according
> to the
> > +             * link state */
> > +            tx = fifo8_pop(&s->tx_fifo);
> > +            dummy_cycles = 8 / s->link_state;
> >          }
>
> Before this if...else ladder was changed, each branch of it
> filled in the whole tx_rx[] array. But the new else {} case
> does not do that...
>
> >          for (i = 0; i < num_effective_busses(s); ++i) {
> >              int bus = num_effective_busses(s) - 1 - i;
> > -            DB_PRINT_L(debug_level, "tx = %02x\n", tx_rx[i]);
> > -            tx_rx[i] = ssi_transfer(s->spi[bus], (uint32_t)tx_rx[i]);
> > -            DB_PRINT_L(debug_level, "rx = %02x\n", tx_rx[i]);
> > +            if (dummy_cycles) {
> > +                int d;
> > +                for (d = 0; d < dummy_cycles; ++d) {
> > +                    tx_rx[0] = ssi_transfer(s->spi[bus],
> (uint32_t)tx_rx[0]);
> > +                }
> > +            } else {
> > +                DB_PRINT_L(debug_level, "tx = %02x\n", tx_rx[i]);
> > +                tx_rx[i] = ssi_transfer(s->spi[bus],
> (uint32_t)tx_rx[i]);
> > +                DB_PRINT_L(debug_level, "rx = %02x\n", tx_rx[i]);
> > +            }
>
> ...and subsequent code, both introduced in this patch and code
> already present, will read the tx_rx[] array.
>
> Could one of you have a look at this and determine what the right
> fix is, please?
>
> thanks
> -- PMM
>
