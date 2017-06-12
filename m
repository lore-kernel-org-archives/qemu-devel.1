Received: from eggs.gnu.org ([2001:4830:134:3::10]:53438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dKKZ6-000730-KI
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 04:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dKKZ1-0004ad-Mc
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 04:19:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dKKZ1-0004a9-EC
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 04:19:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 347C6C0587CD
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 08:19:06 +0000 (UTC)
Date: Mon, 12 Jun 2017 16:18:52 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170612081356.GD12928@pxdev.xzpeter.org>
References: <1496980142-8986-1-git-send-email-peterx@redhat.com>
	<1496980142-8986-4-git-send-email-peterx@redhat.com>
	<20170609134010.GK22043@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170609134010.GK22043@thinpad.lan.raisama.net>
Subject: Re: [Qemu-devel] [PATCH v2 3/6] migration: move
 global_state.optional out
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On Fri, Jun 09, 2017 at 10:40:10AM -0300, Eduardo Habkost wrote:
> On Fri, Jun 09, 2017 at 11:48:59AM +0800, Peter Xu wrote:
> > Put it into MigrationState then we can use the properties to specify
> > whether to enable storing global state.
> > 
> > Removing global_state_set_optional() since now we can use HW_COMPAT_2_3
> > for x86/power in general, and the register_compat_prop() for xen_init().
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  hw/i386/pc_piix.c             |  1 -
> >  hw/ppc/spapr.c                |  1 -
> >  hw/xen/xen-common.c           |  8 +++++++-
> >  include/hw/compat.h           |  4 ++++
> >  include/migration/migration.h |  7 ++++++-
> >  migration/migration.c         | 24 ++++++++++++++++--------
> >  6 files changed, 33 insertions(+), 12 deletions(-)
> > 
> > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > index 2234bd0..c83cec5 100644
> > --- a/hw/i386/pc_piix.c
> > +++ b/hw/i386/pc_piix.c
> > @@ -317,7 +317,6 @@ static void pc_compat_2_3(MachineState *machine)
> >      if (kvm_enabled()) {
> >          pcms->smm = ON_OFF_AUTO_OFF;
> >      }
> > -    global_state_set_optional();
> >      savevm_skip_configuration();
> >  }
> >  
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index ab3aab1..3e78bb9 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -3593,7 +3593,6 @@ static void spapr_machine_2_3_instance_options(MachineState *machine)
> >  {
> >      spapr_machine_2_4_instance_options(machine);
> >      savevm_skip_section_footers();
> > -    global_state_set_optional();
> >      savevm_skip_configuration();
> >  }
> 
> This is a good thing: makes the migration behavior of the
> machine-types introspectable in compat_props.
> 
> I suggest moving this part (and all the rest except the new
> register_compat_prop() call below) to a separate patch, because
> it is an improvement on its own.

Sure.

> 
> >  
> > diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
> > index 0bed577..8240d50 100644
> > --- a/hw/xen/xen-common.c
> > +++ b/hw/xen/xen-common.c
> > @@ -138,7 +138,13 @@ static int xen_init(MachineState *ms)
> >      }
> >      qemu_add_vm_change_state_handler(xen_change_state_handler, NULL);
> >  
> > -    global_state_set_optional();
> > +    /*
> > +     * TODO: make sure global MigrationState has not yet been created
> > +     * (otherwise the compat trick won't work). For now we are in
> > +     * configure_accelerator() so we are mostly good. Better to
> > +     * confirm that in the future.
> > +     */
> 
> So, this makes accelerator initialization very sensitive to
> ordering.
> 
> > +    register_compat_prop("migration", "store-global-state", "off");
> 
> It's already hard to track down machine-type stuff that is
> initialized at machine->init() time but it's not introspectable,
> let's not do the same mistake with accelerators.
> 
> Can't this be solved by a AcceleratorClass::global_props field,
> so we are sure there's a single place in the code where globals
> are registered?  (Currently, they are all registered by the few
> lines around the machine_register_compat_props() call in main()).
> 
> I think I see other use cases for a new
> AcceleratorClass::global_props field.  e.g.: replacing
> kvm_default_props and tcg_default_props in target/i386/cpu.c.

Hmm, this sounds nice.  Then we can also get rid of the TODO above.

Thanks for your suggestion and review! I'll see whether I can writeup
something as RFC for this.

-- 
Peter Xu
