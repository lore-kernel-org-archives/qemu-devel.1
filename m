Received: from eggs.gnu.org ([2001:4830:134:3::10]:35883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1drnvy-0006m7-AP
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:21:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1drnvv-0004he-KP
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:21:10 -0400
Date: Tue, 12 Sep 2017 17:21:01 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170912162100.GD2225@work-vm>
References: <1505054255-2990-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505054255-2990-3-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170911095059.101e0cfc@bahia.lan> <20170911093032.GA2857@work-vm>
	<20170911104854.GB2784@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170911104854.GB2784@umbus.fritz.box>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 2/4] ppc: add CPU IRQ state to
 PPC VMStateDescription
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, aik@ozlabs.ru, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

* David Gibson (david@gibson.dropbear.id.au) wrote:
> On Mon, Sep 11, 2017 at 10:30:33AM +0100, Dr. David Alan Gilbert wrote:
> > * Greg Kurz (groug@kaod.org) wrote:
> > > On Sun, 10 Sep 2017 15:37:33 +0100
> > > Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:
> > > 
> > > > Commit a90db15 "target-ppc: Convert ppc cpu savevm to VMStateDescription"
> > > > appears to drop the internal CPU IRQ state from the migration stream. Whilst
> > > > testing migration on g3beige/mac99 machines, test images would randomly fail to
> > > > resume unless a key was pressed on the VGA console.
> > > > 
> > > > Further investigation suggests that internal CPU IRQ state isn't being
> > > > preserved and so interrupts asserted at the time of migration are lost. Adding
> > > > the pending_interrupts and irq_input_state fields back into the migration
> > > > stream appears to fix the problem here during local tests.
> > > > 
> > > > As part of this commit we bump the vmstate_ppc version from 5 to 6 to handle
> > > > the additional fields.
> > > > 
> > > 
> > > And so this unconditionally breaks backward migration... what about adding
> > > a subsection for this ?
> > 
> > and wiring it to a flag on the machine type so that older machine types
> > don't send it.
> 
> Right, a subsection is certainly necessary to avoid breaking backwards
> migration.
> 
> But apart from that I want to understand better exactly why this is
> necessary.  What's the state that's being lost, and is it really not
> recoverable from anywhere else.
> 
> The other thing that concerns me is how we're encoding the
> information.  These are essentially internal fields, not reflecting
> something with an architected encoding - adding those to the migration
> stream is often a bad idea - it inhibits our ability to rework
> internal encodings.

Yes, agreed, where possible the contents of the stream should reflect
'real' state that's actually being modelled and be as independent of
the implementation as possible.

Dave

> > 
> > Dave
> > 
> > > > Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > > > ---
> > > >  target/ppc/machine.c |    6 +++++-
> > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> > > > index e59049f..8fec1a4 100644
> > > > --- a/target/ppc/machine.c
> > > > +++ b/target/ppc/machine.c
> > > > @@ -647,7 +647,7 @@ static const VMStateDescription vmstate_compat = {
> > > >  
> > > >  const VMStateDescription vmstate_ppc_cpu = {
> > > >      .name = "cpu",
> > > > -    .version_id = 5,
> > > > +    .version_id = 6,
> > > >      .minimum_version_id = 5,
> > > >      .minimum_version_id_old = 4,
> > > >      .load_state_old = cpu_load_old,
> > > > @@ -678,6 +678,10 @@ const VMStateDescription vmstate_ppc_cpu = {
> > > >          VMSTATE_UINTTL(env.hflags_nmsr, PowerPCCPU),
> > > >          /* FIXME: access_type? */
> > > >  
> > > > +        /* Interrupt state */
> > > > +        VMSTATE_UINT32_V(env.pending_interrupts, PowerPCCPU, 6),
> > > > +        VMSTATE_UINT32_V(env.irq_input_state, PowerPCCPU, 6),
> > > > +
> > > >          /* Sanity checking */
> > > >          VMSTATE_UINTTL_TEST(mig_msr_mask, PowerPCCPU, cpu_pre_2_8_migration),
> > > >          VMSTATE_UINT64_TEST(mig_insns_flags, PowerPCCPU, cpu_pre_2_8_migration),
> > > 
> > 
> > 
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
