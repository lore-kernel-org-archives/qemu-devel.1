Received: from eggs.gnu.org ([2001:4830:134:3::10]:43469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alarson@ddci.com>) id 1d9BeT-00037h-M3
	for qemu-devel@nongnu.org; Fri, 12 May 2017 10:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alarson@ddci.com>) id 1d9BeP-0003Tg-Ri
	for qemu-devel@nongnu.org; Fri, 12 May 2017 10:34:41 -0400
In-Reply-To: <20170512065204.GJ12908@umbus.fritz.box>
References: <201705030257.v432vMO2008047@linux03a.ddci.com>
	<20170512065204.GJ12908@umbus.fritz.box>
MIME-Version: 1.0
From: alarson@ddci.com
Message-ID: <OFFF668533.5CB81117-ON8625811E.004C96EA-8625811E.0050117D@ddci.com>
Date: Fri, 12 May 2017 09:34:33 -0500
Content-Type: text/plain; charset="US-ASCII"
Subject: Re: [Qemu-devel] [PATCH v2] target-ppc: Enable open-pic timers to
 count and generate interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

David Gibson <david@gibson.dropbear.id.au> wrote on 05/12/2017 01:52:04 
AM:

> From: David Gibson <david@gibson.dropbear.id.au>
> To: Aaron Larson <alarson@ddci.com>
> Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
> Date: 05/12/2017 01:52 AM
> Subject: Re: [PATCH v2] target-ppc: Enable open-pic timers to count and 
generate interrupts
> 
> On Tue, May 02, 2017 at 07:57:22PM -0700, Aaron Larson wrote:
> > 
> > Previous QEMU open-pic implemented the 4 open-pic timers including all
> > timer registers, but the timers did not "count" or generate any
> > interrupts.  The patch makes the timers both count and generate
> > interrupts.  The timer clock frequency is fixed at 100MHZ.
> > 
> > Signed-off-by: Aaron Larson <alarson@ddci.com>
> 
> Looks sound in concept AFAICT not knowing the openpic hardware.

Thanks again for your review.  I will provide an updated patch to
address all of the comments, but I need a bit more guidance on some.

> > ---
> >  hw/intc/openpic.c | 135 
++++++++++++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 117 insertions(+), 18 deletions(-)
> > 

> > +/* If enabled is true, arranges for an interrupt to be raised val 
clocks into
> > +   the future, if enabled is false cancels the timer. */
> > +static void openpic_tmr_set_tmr(OpenPICTimer *tmr, uint32_t val, bool 
enabled)
> > +{
> > +    /* If timer doesn't exist, create it. */
> > +    if (tmr->qemu_timer == NULL) {
> > +        tmr->qemu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, 
&qemu_timer_cb, tmr);
> > +        DPRINTF("Created timer for n_IRQ %d\n", tmr->n_IRQ);
> 
> Is there a reason to lazily create the timer, rather than always
> creating it at init time and just activating it when the timer is set?

I'm not familiar with the QEMU timer code so guidance is appreciated,
but a quick check indicates there wouldn't be much overhead to do as
you suggest.  I will change to that approach.

> > +    }
> > +    uint64_t ns = ticks_to_ns(val & ~TCCR_TOG);
> > +    /* A count of zero causes a timer to be set to expire 
immediately.  This
> > +       effectively stops the simulation so we don't honor that 
configuration.
> > +       On real hardware, this would generate an interrupt on every 
clock cycle
> > +       if the interrupt was unmasked. */
> 
> Could you also jam up if the count is non-zero but a too-small value
> to make forward progress?  ...

The case I'm concerned about is where a transient value is programmed
to the timer and the interrupt is masked.  In that case QEMU will fire
the timer on (potentially) every other clock, which will slow the
emulation down until a more sane value is programmed.  I could add
code to inhibit the timer while the associated interrupt is masked,
but that is messy, and this seems like an unlikely corner case.

Let me know how you'd like this handled.

> >  static void openpic_tmr_write(void *opaque, hwaddr addr, uint64_t 
val,
> > -                                unsigned len)
> > +                              unsigned len)
> >  {
> >      OpenPICState *opp = opaque;
> >      int idx;
> > 
> > -    addr += 0x10f0;
> > -
> >      DPRINTF("%s: addr %#" HWADDR_PRIx " <= %08" PRIx64 "\n",
> > -            __func__, addr, val);
> > +            __func__, (addr + 0x10f0), val);
> >      if (addr & 0xF) {
> >          return;
> >      }
> > 
> > -    if (addr == 0x10f0) {
> > +    if (addr == 0) {
> 
> I don't really understand how this change fits in with the rest - it
> appears to be changing existing unrelated behaviour.

I debated on changing this.  I needed to make changes to both the
timer read and write code, and the existing code was inconsistent on
the treatment of the offset.  The open-pic has a standard memory map
and the timer block starts at 0x10f0 from the BAR.  Of course the
region in QEMU for the timer is setup such that the timer is at offset
zero in the QEMU timer memory region.  The write code added the offset
to match the hardware, the read code did not, and consequently the
code I added for timer read and write needed to be gratuitously
different because of that.  I chose to update the write to match the
read.  I can undo the change, if you'd like, but it does make the
resulting code harder to understand (IMHO).
