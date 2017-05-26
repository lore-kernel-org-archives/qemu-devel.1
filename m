Received: from eggs.gnu.org ([2001:4830:134:3::10]:57352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alarson@ddci.com>) id 1dEOHY-0006RG-HZ
	for qemu-devel@nongnu.org; Fri, 26 May 2017 19:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alarson@ddci.com>) id 1dEOHV-0004wr-Df
	for qemu-devel@nongnu.org; Fri, 26 May 2017 19:04:32 -0400
In-Reply-To: <20170513075916.GB13183@umbus.fritz.box>
References: <201705030257.v432vMO2008047@linux03a.ddci.com>
	<20170512065204.GJ12908@umbus.fritz.box>
	<OFFF668533.5CB81117-ON8625811E.004C96EA-8625811E.0050117D@ddci.com>
	<20170513075916.GB13183@umbus.fritz.box>
MIME-Version: 1.0
From: alarson@ddci.com
Message-ID: <OF77971E2B.E6193BA9-ON8625812C.007D425F-8625812C.007EBDEA@ddci.com>
Date: Fri, 26 May 2017 18:04:21 -0500
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

David Gibson <david@gibson.dropbear.id.au> wrote on 05/13/2017 02:59:16 
AM:

> From: David Gibson <david@gibson.dropbear.id.au>
> On Fri, May 12, 2017 at 09:34:33AM -0500, alarson@ddci.com wrote:
> > David Gibson <david@gibson.dropbear.id.au> wrote on 05/12/2017 
01:52:04 

Sorry for the long delay getting back to you.  I was out of town for a
while.

> > > > +    }
> > > > +    uint64_t ns = ticks_to_ns(val & ~TCCR_TOG);
> > > > +    /* A count of zero causes a timer to be set to expire 
> > immediately.  This
> > > > +       effectively stops the simulation so we don't honor that 
> > configuration.
> > > > +       On real hardware, this would generate an interrupt on 
every 
> > clock cycle
> > > > +       if the interrupt was unmasked. */
> > > 
> > > Could you also jam up if the count is non-zero but a too-small value
> > > to make forward progress?  ...
> > 
> > The case I'm concerned about is where a transient value is programmed
> > to the timer and the interrupt is masked.  In that case QEMU will fire
> > the timer on (potentially) every other clock,
> 
> Erm.. TCG doesn't really have "clocks" as such, so I'm not entirely
> sure what you mean here.

Hopefully its just terminology.  QEMU has QEMU_CLOCK_VIRTUAL which
drives a timer.  My understanding is that the top level loop in QEMU
is effectively:

  while 1
    if timer expired then run the handler
    else execute some simulated code

If a QEMU timer handler reprograms the timer to expire at "now+0ns",
then no code is ever executed because the VIRTUAL CLOCK timer is
always pending.  This is not exactly the same as what would happen on
real hardware because on hardware the interrupt would be asserted, but
if it was masked it would have no effect.  In the simulation such a
situation effectively results in a "hang".

> > > >  static void openpic_tmr_write(void *opaque, hwaddr addr, uint64_t 

> > > > ...
> > > > -    if (addr == 0x10f0) {
> > > > +    if (addr == 0) {
> > > 
> > > I don't really understand how this change fits in with the rest - it
> > > appears to be changing existing unrelated behaviour.
> > 
> > I debated on changing this.  I needed to make changes to both the
> > timer read and write code, and the existing code was inconsistent on
> > the treatment of the offset.  The open-pic has a standard memory map
> > and the timer block starts at 0x10f0 from the BAR.  Of course the
> > region in QEMU for the timer is setup such that the timer is at offset
> > zero in the QEMU timer memory region.  The write code added the offset
> > to match the hardware, the read code did not, and consequently the
> > code I added for timer read and write needed to be gratuitously
> > different because of that.  I chose to update the write to match the
> > read.  I can undo the change, if you'd like, but it does make the
> > resulting code harder to understand (IMHO).
> 
> So, making the read/write functions use consistent addressing sounds
> like a good idea.  But I think it would be clearer to do this as a
> preliminary patch, rather than folded in with adding the timers
> implementation.

Will do.  Patch to follow shortly.  I assume that once the preliminary
patch is approved, I should submit a follow up patch with the addition
of the timer.  BTW, I forgot to mention that the previous timer read
code was not only inconsistent, but was in error.  Bad enough in error
that I doubt anyone could have been using the code.
