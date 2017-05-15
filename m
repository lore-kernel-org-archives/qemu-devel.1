Received: from eggs.gnu.org ([2001:4830:134:3::10]:39669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAFrE-0007qG-O8
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:16:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAFrA-0006Ix-Lm
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:16:16 -0400
Received: from 3.mo69.mail-out.ovh.net ([188.165.52.203]:32775)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dAFrA-0006IR-Ba
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:16:12 -0400
Received: from player699.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 038611FF04
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 15:16:10 +0200 (CEST)
Date: Mon, 15 May 2017 15:16:02 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170515151602.61dc381d@bahia>
In-Reply-To: <a94cf0ed-3318-fb2d-f16c-4d2b12fff3bb@kaod.org>
References: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
	<149484840466.20089.893964776019028654.stgit@bahia.lan>
	<a94cf0ed-3318-fb2d-f16c-4d2b12fff3bb@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/SsbBB+3FcMM+Wd.ZNiBQEKe";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 6/6] spapr: fix migration of ICP objects
 from/to older QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

--Sig_/SsbBB+3FcMM+Wd.ZNiBQEKe
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 May 2017 14:22:32 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 05/15/2017 01:40 PM, Greg Kurz wrote:
> > Commit 5bc8d26de20c ("spapr: allocate the ICPState object from under
> > sPAPRCPUCore") moved ICP objects from the machine to CPU cores. This
> > is an improvement since we no longer allocate ICP objects that will
> > never be used. But it has the side-effect of breaking migration of
> > older machine types from older QEMU versions.
> >=20
> > This patch introduces a compat flag in the sPAPR machine class so
> > that all pseries machine up to 2.9 go on with the previous behavior
> > of pre-allocating ICP objects. =20
>=20
> I think this is a quite elegant way to a handle the migration=20
> regression. Thanks for taking care of it.
>=20
> Have you tried to simply reparent the ICPs objects to OBJECT(spapr)=20
> instead of the OBJECT(cpu)  ?=20
>=20

Do you mean to reparent unconditionally to OBJECT(spapr) for all
machine versions ? I'm not sure this would be beneficial, but I
might be missing something...

> See some minor comments below.
>=20
> > While here, we also ensure that object_property_add_child() errors cause
> > QEMU to abort for newer machines.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/ppc/spapr.c          |   36 ++++++++++++++++++++++++++++++++++++
> >  hw/ppc/spapr_cpu_core.c |   28 ++++++++++++++++++++--------
> >  include/hw/ppc/spapr.h  |    2 ++
> >  3 files changed, 58 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index c53989bb10b1..ab3683bcd677 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -126,6 +126,7 @@ error:
> >  static void xics_system_init(MachineState *machine, int nr_irqs, Error=
 **errp)
> >  {
> >      sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
> > +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> >      Error *local_err =3D NULL;
> > =20
> >      if (kvm_enabled()) {
> > @@ -151,6 +152,38 @@ static void xics_system_init(MachineState *machine=
, int nr_irqs, Error **errp)
> >                                        &local_err);
> >      }
> > =20
> > +    if (!spapr->ics) {
> > +        goto out;
> > +    }
> > +
> > +    if (smc->must_pre_allocate_icps) { =20
>=20
> I am not sure I like 'must', I think 'pre_allocate_icps' should be enough=
 ?=20
> or simply 'allocate_legacy_icps' ?
>=20

Ok. I'll go for the latter if it's ok with David.

> > +        int smt =3D kvmppc_smt_threads();
> > +        int nr_servers =3D DIV_ROUND_UP(max_cpus * smt, smp_threads); =
=20
>=20
> may be we should reintroduce nr_servers at the machine level ?=20
>=20

I had reintroduced it but then I realized it was only used in this
function.

> > +        int i;
> > +
> > +        spapr->legacy_icps =3D g_malloc0(nr_servers * sizeof(ICPState)=
);
> > +
> > +        for (i =3D 0; i < nr_servers; i++) {
> > +            void* obj =3D &spapr->legacy_icps[i]; =20
>=20
> 'void *'
>=20

Yeah, patchew already yelled at me :)

> > +
> > +            object_initialize(obj, sizeof(ICPState), spapr->icp_type);
> > +            object_property_add_child(OBJECT(spapr), "icp[*]", obj,
> > +                                      &error_abort); =20
>=20
> David does not like the "icp[*]" syntax.
>=20

Ah... I wasn't aware of that. But I agree that I should probably create
the object names based on 'i', rather than relying on the more complex
logic in object_property_add().

> > +            object_unref(obj);
> > +            object_property_add_const_link(obj, "xics", OBJECT(spapr),
> > +                                           &error_abort);
> > +            object_property_set_bool(obj, true, "realized", &local_err=
);
> > +            if (local_err) {
> > +                while (i--) {
> > +                    object_unparent(obj);
> > +                }
> > +                g_free(spapr->legacy_icps);
> > +                break;
> > +            }
> > +        }
> > +    }
> > +
> > +out:
> >      error_propagate(errp, local_err);
> >  }
> > =20
> > @@ -3256,8 +3289,11 @@ static void spapr_machine_2_9_instance_options(M=
achineState *machine)
> > =20
> >  static void spapr_machine_2_9_class_options(MachineClass *mc)
> >  {
> > +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> > +
> >      spapr_machine_2_10_class_options(mc);
> >      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_9);
> > +    smc->must_pre_allocate_icps =3D true;
> >  }
> > =20
> >  DEFINE_SPAPR_MACHINE(2_9, "2.9", false);
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index 63d160f7e010..5476647efa06 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -119,6 +119,7 @@ static void spapr_cpu_core_unrealizefn(DeviceState =
*dev, Error **errp)
> >      size_t size =3D object_type_get_instance_size(typename);
> >      CPUCore *cc =3D CPU_CORE(dev);
> >      int i;
> > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> > =20
> >      for (i =3D 0; i < cc->nr_threads; i++) {
> >          void *obj =3D sc->threads + i * size;
> > @@ -127,7 +128,9 @@ static void spapr_cpu_core_unrealizefn(DeviceState =
*dev, Error **errp)
> >          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > =20
> >          spapr_cpu_destroy(cpu);
> > -        object_unparent(cpu->intc);
> > +        if (!spapr->legacy_icps) {
> > +            object_unparent(cpu->intc);
> > +        }
> >          cpu_remove_sync(cs);
> >          object_unparent(obj);
> >      }
> > @@ -142,12 +145,19 @@ static void spapr_cpu_core_realize_child(Object *=
child, Error **errp)
> >      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> >      Object *obj;
> > =20
> > -    obj =3D object_new(spapr->icp_type);
> > -    object_property_add_child(OBJECT(cpu), "icp", obj, NULL);
> > -    object_property_add_const_link(obj, "xics", OBJECT(spapr), &error_=
abort);
> > -    object_property_set_bool(obj, true, "realized", &local_err);
> > -    if (local_err) {
> > -        goto error;
> > +    if (spapr->legacy_icps) {
> > +        int index =3D cpu->parent_obj.cpu_index;
> > +
> > +        obj =3D OBJECT(&spapr->legacy_icps[index]);
> > +    } else {
> > +        obj =3D object_new(spapr->icp_type);
> > +        object_property_add_child(OBJECT(cpu), "icp", obj, &error_abor=
t);
> > +        object_property_add_const_link(obj, "xics", OBJECT(spapr),
> > +                                       &error_abort);
> > +        object_property_set_bool(obj, true, "realized", &local_err);
> > +        if (local_err) {
> > +            goto error;
> > +        }
> >      }
> > =20
> >      object_property_set_bool(child, true, "realized", &local_err);
> > @@ -164,7 +174,9 @@ static void spapr_cpu_core_realize_child(Object *ch=
ild, Error **errp)
> >      return;
> > =20
> >  error:
> > -    object_unparent(obj);
> > +    if (!spapr->legacy_icps) {
> > +        object_unparent(obj);
> > +    }
> >      error_propagate(errp, local_err);
> >  }
> > =20
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index 5802f888c39d..72cd5af2679b 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -53,6 +53,7 @@ struct sPAPRMachineClass {
> >      bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of L=
MBs */
> >      bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
> >      const char *tcg_default_cpu; /* which (TCG) CPU to simulate by def=
ault */
> > +    bool must_pre_allocate_icps; /* only for pseries-2.9 and older */
> >      void (*phb_placement)(sPAPRMachineState *spapr, uint32_t index,
> >                            uint64_t *buid, hwaddr *pio,=20
> >                            hwaddr *mmio32, hwaddr *mmio64,
> > @@ -109,6 +110,7 @@ struct sPAPRMachineState {
> >      MemoryHotplugState hotplug_memory;
> > =20
> >      const char *icp_type;
> > +    ICPState *legacy_icps;
> >  };
> > =20
> >  #define H_SUCCESS         0
> >  =20
>=20


--Sig_/SsbBB+3FcMM+Wd.ZNiBQEKe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkZqhIACgkQAvw66wEB28LDtQCcCQvV5YH4LQf21VWkIAIh/u3b
BGEAn2gD+nm76F3L8jsI1VhhpOW13Tle
=SV8W
-----END PGP SIGNATURE-----

--Sig_/SsbBB+3FcMM+Wd.ZNiBQEKe--
