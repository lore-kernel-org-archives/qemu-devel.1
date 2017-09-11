Received: from eggs.gnu.org ([2001:4830:134:3::10]:37826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1drSNR-0006Mz-ML
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:20:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1drSNM-0000Zt-Vi
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:20:05 -0400
Date: Mon, 11 Sep 2017 18:19:54 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170911171953.GE2150@work-vm>
References: <1505054255-2990-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505054255-2990-3-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170911095059.101e0cfc@bahia.lan> <20170911093032.GA2857@work-vm>
	<20170911104854.GB2784@umbus.fritz.box>
	<cc212d72-1eff-86ae-1e34-fdc1636015e5@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc212d72-1eff-86ae-1e34-fdc1636015e5@ilande.co.uk>
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: David Gibson <david@gibson.dropbear.id.au>, lvivier@redhat.com, aik@ozlabs.ru, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

* Mark Cave-Ayland (mark.cave-ayland@ilande.co.uk) wrote:
> On 11/09/17 11:48, David Gibson wrote:
> 
> > On Mon, Sep 11, 2017 at 10:30:33AM +0100, Dr. David Alan Gilbert wrote:
> >> * Greg Kurz (groug@kaod.org) wrote:
> >>> On Sun, 10 Sep 2017 15:37:33 +0100
> >>> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:
> >>>
> >>>> Commit a90db15 "target-ppc: Convert ppc cpu savevm to VMStateDescription"
> >>>> appears to drop the internal CPU IRQ state from the migration stream. Whilst
> >>>> testing migration on g3beige/mac99 machines, test images would randomly fail to
> >>>> resume unless a key was pressed on the VGA console.
> >>>>
> >>>> Further investigation suggests that internal CPU IRQ state isn't being
> >>>> preserved and so interrupts asserted at the time of migration are lost. Adding
> >>>> the pending_interrupts and irq_input_state fields back into the migration
> >>>> stream appears to fix the problem here during local tests.
> >>>>
> >>>> As part of this commit we bump the vmstate_ppc version from 5 to 6 to handle
> >>>> the additional fields.
> >>>>
> >>>
> >>> And so this unconditionally breaks backward migration... what about adding
> >>> a subsection for this ?
> >>
> >> and wiring it to a flag on the machine type so that older machine types
> >> don't send it.
> > 
> > Right, a subsection is certainly necessary to avoid breaking backwards
> > migration.
> 
> The suggestion of using the VMSTATE_*_V macros with an increased version
> number came from Alexey's original review of the patch many months ago
> which is why I did it that way.
> 
> Out of curiosity though, what is the criteria for supporting backwards
> migration? Obviously forward migration is supported as-is in this
> manner, so what determines if a patch needs to be backwards compatible
> and how far?

It's a bit fuzzy.  Downstream we do backwards migration between various
versions - and those versions are pretty arbitrarily chosen.
Generally I prefer if we don't break that upstream either, although
it isn't tested much.

If it was in code that was specific to your g3beige I wouldn't mind;
but for ppc in general then if it breaks the server migration it'll
be a pain we'd have to then fix.  Best to keep it working upstream.

But it's fairly easy to put new fields in a subsection and tie it
to a property;  that makes it easy to switch it on/off in machine
types.

> > But apart from that I want to understand better exactly why this is
> > necessary.  What's the state that's being lost, and is it really not
> > recoverable from anywhere else.
> 
> The test case I have is installing Darwin PPC 6.02 with qemu-system-ppc
> TCG and repeatedly pausing, executing "savevm foo", then quitting and
> continuing with "-loadvm foo" during the installation phase. About 1 in
> 10 times the installer hangs after the loadvm until I press a key, at
> which point it carries on as normal.
> 
> I then proceeded to going backwards through the git history until I
> found out that it was the removal of the pending_interrupts,
> irq_input_state and access_type fields during the conversion to
> VMStateDescription commit a90db15 which seemed to cause the problem.
> 
> > The other thing that concerns me is how we're encoding the
> > information.  These are essentially internal fields, not reflecting
> > something with an architected encoding - adding those to the migration
> > stream is often a bad idea - it inhibits our ability to rework
> > internal encodings.
> 
> I'm not sure how this should be managed, however there was a similar
> issue with excp_prefix (which was also removed in a90db15) that was
> fixed in 2360b6e by calling a helper in cpu_post_load(). I can't easily
> see how could work with env.pending_interrupts and env.irq_input_state
> though.

Without knowing anything about this hardware... generally the migration
stream should reflect the real state of the system rather than internal
implementation detail, that way if you change the implementation you
don't need to fudge the state.  Having said that, there's generally
some internal state that's perhaps not immediately obvious from specs
until you try and implement it.

Dave

> ATB,
> 
> Mark.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
