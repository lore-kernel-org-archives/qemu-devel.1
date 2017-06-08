Received: from eggs.gnu.org ([2001:4830:134:3::10]:44146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIu8z-0000yd-Sx
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 05:54:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIu8v-0004wD-Tc
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 05:54:21 -0400
Received: from 9.mo178.mail-out.ovh.net ([46.105.75.45]:49096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dIu8v-0004vl-Jw
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 05:54:17 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 7BD7E32B79
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 11:54:15 +0200 (CEST)
Date: Thu, 8 Jun 2017 11:54:10 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170608115410.2e7a2511@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170608040857.GV13397@umbus.fritz.box>
References: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
	<149685584629.12025.14875914798241845062.stgit@bahia.lan>
	<20170608040857.GV13397@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/UPvl5jbXVZZ1d8rJmx9OTFc";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v3 5/5] spapr: fix migration of ICPState
 objects from/to older QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>

--Sig_/UPvl5jbXVZZ1d8rJmx9OTFc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 8 Jun 2017 14:08:57 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Jun 07, 2017 at 07:17:26PM +0200, Greg Kurz wrote:
> > Commit 5bc8d26de20c ("spapr: allocate the ICPState object from under
> > sPAPRCPUCore") moved ICPState objects from the machine to CPU cores.
> > This is an improvement since we no longer allocate ICPState objects
> > that will never be used. But it has the side-effect of breaking
> > migration of older machine types from older QEMU versions.
> >=20
> > This patch allows spapr to register dummy "icp/server" entries to vmsta=
te.
> > These entries use a dedicated VMStateDescription that can swallow and
> > discard state of an incoming migration stream, and that don't send anyt=
hing
> > on outgoing migration.
> >=20
> > As for real ICPState objects, the instance_id is the cpu_index of the
> > corresponding vCPU, which happens to be equal to the generated instance=
_id
> > of older machine types.
> >=20
> > The machine can unregister/register these entries when CPUs are dynamic=
ally
> > plugged/unplugged.
> >=20
> > This is only available for pseries-2.9 and older machines, thanks to a
> > compat property.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> > v3: - new logic entirely implemented in hw/ppc/spapr.c
> > ---
> >  hw/ppc/spapr.c         |   88 ++++++++++++++++++++++++++++++++++++++++=
+++++++-
> >  include/hw/ppc/spapr.h |    2 +
> >  2 files changed, 88 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 9b7ae28939a8..c15b604978f0 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -124,9 +124,52 @@ error:
> >      return NULL;
> >  }
> > =20
> > +static bool pre_2_10_vmstate_dummy_icp_needed(void *opaque)
> > +{
> > +    return false;
> > +} =20
>=20
> Uh.. the needed function always returns false, how can that work?
>=20

The needed function is used for outgoing migration only:

bool vmstate_save_needed(const VMStateDescription *vmsd, void *opaque)
{
    if (vmsd->needed && !vmsd->needed(opaque)) {
        /* optional section not needed */
        return false;
    }
    return true;
}

The idea is that all ICPState objects that were created but not associated
to a vCPU by pre-2.10 machine types don't need to be migrated at all, as
their state hasn't changed.

We don't even create these unneeded ICPState objects here, but simply
register their ids to vmstate.

> > +
> > +static const VMStateDescription pre_2_10_vmstate_dummy_icp =3D {
> > +    .name =3D "icp/server",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .needed =3D pre_2_10_vmstate_dummy_icp_needed,

Outgoing migration:
- machine in older QEMU have unused ICPState objects (default state)
- machine in QEMU 2.10 doesn't even have extra ICPState objects

=3D> don't send anything

> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_UNUSED(4), /* uint32_t xirr */
> > +        VMSTATE_UNUSED(1), /* uint8_t pending_priority */
> > +        VMSTATE_UNUSED(1), /* uint8_t mfrr */

Incoming migration from older QEMU: we don't have the extra ICPState object=
s.

=3D> accept the state and discard it

> > +        VMSTATE_END_OF_LIST()
> > +    },
> > +};
> > +
> > +static void pre_2_10_vmstate_register_dummy_icp(sPAPRMachineState *spa=
pr, int i)
> > +{
> > +    bool *flag =3D &spapr->pre_2_10_ignore_icp[i];
> > +
> > +    g_assert(!*flag); =20
>=20
> Apart from this assert(), you never seem to test the values in the
> pre_2_10_ignore_icp() array, so it seems a bit pointless.
>=20

There's the opposite check in pre_2_10_vmstate_unregister_dummy_icp().
But I agree it isn't really useful... but more because of paranoia :)

> > +    vmstate_register(NULL, i, &pre_2_10_vmstate_dummy_icp, flag);
> > +    *flag =3D true;
> > +}
> > +
> > +static void pre_2_10_vmstate_unregister_dummy_icp(sPAPRMachineState *s=
papr,
> > +                                                  int i)
> > +{
> > +    bool *flag =3D &spapr->pre_2_10_ignore_icp[i];
> > +
> > +    g_assert(*flag);
> > +    vmstate_unregister(NULL, &pre_2_10_vmstate_dummy_icp, flag);
> > +    *flag =3D false;
> > +}
> > +
> > +static inline int xics_nr_servers(void) =20
>=20
> Maybe a different name to emphasise that this is only used for the
> backwards compat logic.
>=20

It is also used to compute the "ibm,interrupt-server-ranges" DT prop.

    /* /interrupt controller */
    spapr_dt_xics(xics_nr_servers(), fdt, PHANDLE_XICP);


> > +{
> > +    return DIV_ROUND_UP(max_cpus * kvmppc_smt_threads(), smp_threads);
> > +}
> > +
> >  static void xics_system_init(MachineState *machine, int nr_irqs, Error=
 **errp)
> >  {
> >      sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
> > +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
> > =20
> >      if (kvm_enabled()) {
> >          if (machine_kernel_irqchip_allowed(machine) &&
> > @@ -148,6 +191,15 @@ static void xics_system_init(MachineState *machine=
, int nr_irqs, Error **errp)
> >              return;
> >          }
> >      }
> > +
> > +    if (smc->pre_2_10_has_unused_icps) {
> > +        int i;
> > +
> > +        spapr->pre_2_10_ignore_icp =3D g_malloc(xics_nr_servers());
> > +        for (i =3D 0; i < xics_nr_servers(); i++) {
> > +            pre_2_10_vmstate_register_dummy_icp(spapr, i); =20
>=20
> This registers a dummy ICP for every slot, some of which will have
> real cpus / icps.  That doesn't seem right.
>=20

This is initialization, before we even have actual CPUs. We start with
dummy ICPs for every slot, but they get replaced by real ICPs when we
plug CPU cores...... (see below)

> > +        }
> > +    }
> >  }
> > =20
> >  static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *c=
pu,
> > @@ -976,7 +1028,6 @@ static void *spapr_build_fdt(sPAPRMachineState *sp=
apr,
> >      void *fdt;
> >      sPAPRPHBState *phb;
> >      char *buf;
> > -    int smt =3D kvmppc_smt_threads();
> > =20
> >      fdt =3D g_malloc0(FDT_MAX_SIZE);
> >      _FDT((fdt_create_empty_tree(fdt, FDT_MAX_SIZE)));
> > @@ -1016,7 +1067,7 @@ static void *spapr_build_fdt(sPAPRMachineState *s=
papr,
> >      _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
> > =20
> >      /* /interrupt controller */
> > -    spapr_dt_xics(DIV_ROUND_UP(max_cpus * smt, smp_threads), fdt, PHAN=
DLE_XICP);
> > +    spapr_dt_xics(xics_nr_servers(), fdt, PHANDLE_XICP);
> > =20
> >      ret =3D spapr_populate_memory(spapr, fdt);
> >      if (ret < 0) {
> > @@ -2800,9 +2851,24 @@ static void spapr_core_unplug(HotplugHandler *ho=
tplug_dev, DeviceState *dev,
> >                                Error **errp)
> >  {
> >      MachineState *ms =3D MACHINE(qdev_get_machine());
> > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(ms);
> >      CPUCore *cc =3D CPU_CORE(dev);
> >      CPUArchId *core_slot =3D spapr_find_cpu_slot(ms, cc->core_id, NULL=
);
> > =20
> > +    if (spapr->pre_2_10_ignore_icp) {
> > +        sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
> > +        sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(OBJECT(cc)=
);
> > +        const char *typename =3D object_class_get_name(scc->cpu_class);
> > +        size_t size =3D object_type_get_instance_size(typename);
> > +        int i;
> > +
> > +        for (i =3D 0; i < cc->nr_threads; i++) {
> > +            CPUState *cs =3D CPU(sc->threads + i * size);
> > +
> > +            pre_2_10_vmstate_register_dummy_icp(spapr, cs->cpu_index);
> > +        }
> > +    }
> > +
> >      assert(core_slot);
> >      core_slot->cpu =3D NULL;
> >      object_unparent(OBJECT(dev));
> > @@ -2912,6 +2978,21 @@ static void spapr_core_plug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
> >          }
> >      }
> >      core_slot->cpu =3D OBJECT(dev);
> > +
> > +    if (spapr->pre_2_10_ignore_icp) {
> > +        sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(OBJECT(cc)=
);
> > +        const char *typename =3D object_class_get_name(scc->cpu_class);
> > +        size_t size =3D object_type_get_instance_size(typename);
> > +        int i;
> > +
> > +        for (i =3D 0; i < cc->nr_threads; i++) {
> > +            sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(dev);
> > +            void *obj =3D sc->threads + i * size;
> > +
> > +            cs =3D CPU(obj);
> > +            pre_2_10_vmstate_unregister_dummy_icp(spapr, cs->cpu_index=
);

...... here.

The opposite happens in spapr_core_unplug().

> > +        }
> > +    }
> >  }
> > =20
> >  static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceSta=
te *dev,
> > @@ -3361,9 +3442,12 @@ static void spapr_machine_2_9_instance_options(M=
achineState *machine)
> > =20
> >  static void spapr_machine_2_9_class_options(MachineClass *mc)
> >  {
> > +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> > +
> >      spapr_machine_2_10_class_options(mc);
> >      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_9);
> >      mc->numa_auto_assign_ram =3D numa_legacy_auto_assign_ram;
> > +    smc->pre_2_10_has_unused_icps =3D true;
> >  }
> > =20
> >  DEFINE_SPAPR_MACHINE(2_9, "2.9", false);
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index f973b0284596..64382623199d 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -53,6 +53,7 @@ struct sPAPRMachineClass {
> >      bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of L=
MBs */
> >      bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
> >      const char *tcg_default_cpu; /* which (TCG) CPU to simulate by def=
ault */
> > +    bool pre_2_10_has_unused_icps;
> >      void (*phb_placement)(sPAPRMachineState *spapr, uint32_t index,
> >                            uint64_t *buid, hwaddr *pio,=20
> >                            hwaddr *mmio32, hwaddr *mmio64,
> > @@ -90,6 +91,7 @@ struct sPAPRMachineState {
> >      sPAPROptionVector *ov5_cas;     /* negotiated (via CAS) option vec=
tors */
> >      bool cas_reboot;
> >      bool cas_legacy_guest_workaround;
> > +    bool *pre_2_10_ignore_icp;
> > =20
> >      Notifier epow_notifier;
> >      QTAILQ_HEAD(, sPAPREventLogEntry) pending_events;
> >  =20
>=20


--Sig_/UPvl5jbXVZZ1d8rJmx9OTFc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlk5HsIACgkQAvw66wEB28IKzwCeNFatAYJEyg9rJ/vQK8mpTNn8
6dkAnjo0PVrBs9NfgLMjtOgwpT0P184p
=smHx
-----END PGP SIGNATURE-----

--Sig_/UPvl5jbXVZZ1d8rJmx9OTFc--
