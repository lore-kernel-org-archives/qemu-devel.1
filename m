Received: from eggs.gnu.org ([2001:4830:134:3::10]:45321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1drL3E-0004El-AM
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1drL3A-0002nC-Aq
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:30:44 -0400
Date: Mon, 11 Sep 2017 10:30:33 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170911093032.GA2857@work-vm>
References: <1505054255-2990-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505054255-2990-3-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170911095059.101e0cfc@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170911095059.101e0cfc@bahia.lan>
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
To: Greg Kurz <groug@kaod.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, aik@ozlabs.ru, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

* Greg Kurz (groug@kaod.org) wrote:
> On Sun, 10 Sep 2017 15:37:33 +0100
> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:
> 
> > Commit a90db15 "target-ppc: Convert ppc cpu savevm to VMStateDescription"
> > appears to drop the internal CPU IRQ state from the migration stream. Whilst
> > testing migration on g3beige/mac99 machines, test images would randomly fail to
> > resume unless a key was pressed on the VGA console.
> > 
> > Further investigation suggests that internal CPU IRQ state isn't being
> > preserved and so interrupts asserted at the time of migration are lost. Adding
> > the pending_interrupts and irq_input_state fields back into the migration
> > stream appears to fix the problem here during local tests.
> > 
> > As part of this commit we bump the vmstate_ppc version from 5 to 6 to handle
> > the additional fields.
> > 
> 
> And so this unconditionally breaks backward migration... what about adding
> a subsection for this ?

and wiring it to a flag on the machine type so that older machine types
don't send it.

Dave

> > Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > ---
> >  target/ppc/machine.c |    6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> > index e59049f..8fec1a4 100644
> > --- a/target/ppc/machine.c
> > +++ b/target/ppc/machine.c
> > @@ -647,7 +647,7 @@ static const VMStateDescription vmstate_compat = {
> >  
> >  const VMStateDescription vmstate_ppc_cpu = {
> >      .name = "cpu",
> > -    .version_id = 5,
> > +    .version_id = 6,
> >      .minimum_version_id = 5,
> >      .minimum_version_id_old = 4,
> >      .load_state_old = cpu_load_old,
> > @@ -678,6 +678,10 @@ const VMStateDescription vmstate_ppc_cpu = {
> >          VMSTATE_UINTTL(env.hflags_nmsr, PowerPCCPU),
> >          /* FIXME: access_type? */
> >  
> > +        /* Interrupt state */
> > +        VMSTATE_UINT32_V(env.pending_interrupts, PowerPCCPU, 6),
> > +        VMSTATE_UINT32_V(env.irq_input_state, PowerPCCPU, 6),
> > +
> >          /* Sanity checking */
> >          VMSTATE_UINTTL_TEST(mig_msr_mask, PowerPCCPU, cpu_pre_2_8_migration),
> >          VMSTATE_UINT64_TEST(mig_insns_flags, PowerPCCPU, cpu_pre_2_8_migration),
> 


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
