Received: from eggs.gnu.org ([2001:4830:134:3::10]:37832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dJ3f7-0007PK-5a
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 16:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dJ3f2-00020c-4Q
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 16:04:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39334
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dJ3f1-00020O-UA
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 16:04:04 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v58K3hlu090298
	for <qemu-devel@nongnu.org>; Thu, 8 Jun 2017 16:04:03 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2axxd7gwc7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 16:04:02 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 8 Jun 2017 16:04:02 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170531043557.GI12163@umbus.fritz.box>
References: <20170530160445.12810-1-lvivier@redhat.com>
	<20170531043557.GI12163@umbus.fritz.box>
Date: Thu, 08 Jun 2017 15:00:53 -0500
Message-Id: <149695205346.23353.3484869110998357783@loki>
Subject: Re: [Qemu-devel] [PATCH] spapr: manage hotplugged devices while the
 VM is not started
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

Quoting David Gibson (2017-05-30 23:35:57)
> On Tue, May 30, 2017 at 06:04:45PM +0200, Laurent Vivier wrote:
> > For QEMU, a hotlugged device is a device added using the HMP/QMP
> > interface.
> > For SPAPR, a hotplugged device is a device added while the
> > machine is running. In this case QEMU doesn't update internal
> > state but relies on the OS for this part
> > =

> > In the case of migration, when we (libvirt) hotplug a device
> > on the source guest, we (libvirt) generally hotplug the same
> > device on the destination guest. But in this case, the machine
> > is stopped (RUN_STATE_INMIGRATE) and QEMU must not expect
> > the OS will manage it as an hotplugged device as it will
> > be "imported" by the migration.
> > =

> > This patch changes the meaning of "hotplugged" in spapr.c
> > to manage a QEMU hotplugged device like a "coldplugged" one
> > when the machine is awaiting an incoming migration.
> > =

> > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> =

> So, I think this is a reasonable concept, at least in terms of
> cleanliness and not doing unnecessary work.  However, if it's fixing
> bugs, I suspect that means we still have problems elsewhere.

I was hoping a lot of these issues would go away once we default
the initial/reset DRC states to "coldplugged". I think your pending
patch:

  "spapr: Make DRC reset force DRC into known state"

But I didn't consider the fact that libvirt will be issuing these
hotplugs *after* reset, so those states would indeed need to
be fixed up again to reflect boot-time,attached as opposed to
boot-time,unattached before starting the target.

So I do think this patch addresses a specific bug that isn't
obviously fixable elsewhere.

To me it seems like the only way to avoid doing something like
what this patch does is to migrate all attached DRCs from the
source in all cases.

This would break backward-migration though, unless we switch from
using subregions for DRCs to explicitly disabling DRC migration
based on machine type.

That approach seems to similar to what x86 does, e.g.
hw/acpi/ich9.c and hw/acpi/piix.c migrate vmstate_memhp_state
(corresponding to all DIMMs' slot status) in all cases where
memory hotplug is enabled. If they were to do this using
subregions for DIMMs in a transitional state I think similar
issues would pop up in that code as well.

Even if we take this route, we still need to explicitly suppress
hotplug events during INMIGRATE to avoid extra events going on
the queue. *Unless* we similarly rely purely on the ones sent by
the source. I believe the proposed event migration patches using
VMSTATE_QTAILQ_V only add to the list, so we'd need a variant
that either nukes the list first, or a pre-load hook in
vmstate_spapr_pending_events that does the same.

Personally, it's seeming like the general approach of not
special-casing INMIGRATE, and just letting migration do the
fixing, is easier to deal with conceptually, albeit somewhat
less flexible in terms of backward compatibility. Both approaches
seem reasonable though.

> =

> Specifically, what is it we're doing before the incoming migration
> that's breaking things.  Even if it's unnecessary, anything done there
> should be overwritten by the incoming stream.  That should certainly
> be the case (now) for the DRC state variables.  Maybe not for the
> queued hotplug events - but that means we should update the queue
> migration to make sure we clear anything existing on the destination
> before adding migrated events.
> =

> I'm also concerned by the fact that this makes changes for memory and
> cpu hotplug, but not for PCI devices.  Why aren't they also affected
> by this problem?
> =

> One nit in the implementation, see below:
> =

> > ---
> >  hw/ppc/spapr.c | 20 ++++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
> > =

> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 0980d73..f1302d0 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2511,6 +2511,12 @@ static void spapr_nmi(NMIState *n, int cpu_index=
, Error **errp)
> >      }
> >  }
> >  =

> > +static bool spapr_coldplugged(DeviceState *dev)
> > +{
> > +    return runstate_check(RUN_STATE_INMIGRATE) ||
> > +           !dev->hotplugged;
> > +}
> > +
> >  static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint=
64_t size,
> >                             uint32_t node, bool dedicated_hp_event_sour=
ce,
> >                             Error **errp)
> > @@ -2521,6 +2527,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint=
64_t addr_start, uint64_t size,
> >      int i, fdt_offset, fdt_size;
> >      void *fdt;
> >      uint64_t addr =3D addr_start;
> > +    bool coldplugged =3D spapr_coldplugged(dev);
> >  =

> >      for (i =3D 0; i < nr_lmbs; i++) {
> >          drc =3D spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
> > @@ -2532,9 +2539,9 @@ static void spapr_add_lmbs(DeviceState *dev, uint=
64_t addr_start, uint64_t size,
> >                                                  SPAPR_MEMORY_BLOCK_SIZ=
E);
> >  =

> >          drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> > -        drck->attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, errp=
);
> > +        drck->attach(drc, dev, fdt, fdt_offset, coldplugged, errp);
> >          addr +=3D SPAPR_MEMORY_BLOCK_SIZE;
> > -        if (!dev->hotplugged) {
> > +        if (coldplugged) {
> >              /* guests expect coldplugged LMBs to be pre-allocated */
> >              drck->set_allocation_state(drc, SPAPR_DR_ALLOCATION_STATE_=
USABLE);
> >              drck->set_isolation_state(drc, SPAPR_DR_ISOLATION_STATE_UN=
ISOLATED);
> > @@ -2543,7 +2550,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint=
64_t addr_start, uint64_t size,
> >      /* send hotplug notification to the
> >       * guest only in case of hotplugged memory
> >       */
> > -    if (dev->hotplugged) {
> > +    if (!coldplugged) {
> >          if (dedicated_hp_event_source) {
> >              drc =3D spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_L=
MB,
> >                      addr_start / SPAPR_MEMORY_BLOCK_SIZE);
> > @@ -2776,6 +2783,7 @@ static void spapr_core_plug(HotplugHandler *hotpl=
ug_dev, DeviceState *dev,
> >      int smt =3D kvmppc_smt_threads();
> >      CPUArchId *core_slot;
> >      int index;
> > +    bool coldplugged =3D spapr_coldplugged(dev);
> >  =

> >      core_slot =3D spapr_find_cpu_slot(MACHINE(hotplug_dev), cc->core_i=
d, &index);
> >      if (!core_slot) {
> > @@ -2797,7 +2805,7 @@ static void spapr_core_plug(HotplugHandler *hotpl=
ug_dev, DeviceState *dev,
> >  =

> >      if (drc) {
> >          sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(d=
rc);
> > -        drck->attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, &loc=
al_err);
> > +        drck->attach(drc, dev, fdt, fdt_offset, coldplugged, &local_er=
r);
> >          if (local_err) {
> >              g_free(fdt);
> >              error_propagate(errp, local_err);
> > @@ -2805,7 +2813,7 @@ static void spapr_core_plug(HotplugHandler *hotpl=
ug_dev, DeviceState *dev,
> >          }
> >      }
> >  =

> > -    if (dev->hotplugged) {
> > +    if (!coldplugged) {
> >          /*
> >           * Send hotplug notification interrupt to the guest only in ca=
se
> >           * of hotplugged CPUs.
> > @@ -2838,7 +2846,7 @@ static void spapr_core_pre_plug(HotplugHandler *h=
otplug_dev, DeviceState *dev,
> >      int node_id;
> >      int index;
> >  =

> > -    if (dev->hotplugged && !mc->has_hotpluggable_cpus) {
> > +    if (!spapr_coldplugged(dev) && !mc->has_hotpluggable_cpus) {
> =

> It probably doesn't matter in practice, but in this specific instance,
> I think you want the "raw" qemu meaning of hotplugged rather than the
> spapr meaning.
> =

> >          error_setg(&local_err, "CPU hotplug not supported for this mac=
hine");
> >          goto out;
> >      }
> =

> -- =

> David Gibson                    | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_ _othe=
r_
>                                 | _way_ _around_!
> http://www.ozlabs.org/~dgibson
