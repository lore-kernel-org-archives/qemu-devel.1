Received: from eggs.gnu.org ([2001:4830:134:3::10]:34412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAqQG-0003Ve-RR
	for qemu-devel@nongnu.org; Wed, 17 May 2017 00:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAqQF-0002tL-DU
	for qemu-devel@nongnu.org; Wed, 17 May 2017 00:18:52 -0400
Date: Wed, 17 May 2017 14:14:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170517041416.GD15596@umbus.fritz.box>
References: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
	<149484840466.20089.893964776019028654.stgit@bahia.lan>
	<a94cf0ed-3318-fb2d-f16c-4d2b12fff3bb@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Content-Disposition: inline
In-Reply-To: <a94cf0ed-3318-fb2d-f16c-4d2b12fff3bb@kaod.org>
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
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2017 at 02:22:32PM +0200, C=E9dric Le Goater wrote:
> On 05/15/2017 01:40 PM, Greg Kurz wrote:
> > Commit 5bc8d26de20c ("spapr: allocate the ICPState object from under
> > sPAPRCPUCore") moved ICP objects from the machine to CPU cores. This
> > is an improvement since we no longer allocate ICP objects that will
> > never be used. But it has the side-effect of breaking migration of
> > older machine types from older QEMU versions.
> >=20
> > This patch introduces a compat flag in the sPAPR machine class so
> > that all pseries machine up to 2.9 go on with the previous behavior
> > of pre-allocating ICP objects.
>=20
> I think this is a quite elegant way to a handle the migration=20
> regression. Thanks for taking care of it.
>=20
> Have you tried to simply reparent the ICPs objects to OBJECT(spapr)=20
> instead of the OBJECT(cpu)  ?=20

I actually kind of hate changing the QOM tree structure based on
machine type compatibility.  Unfortunately, since we're matching up
the migration state based (essentially) on QOM path, I don't see any
easy alternative.  I really wish there was a mechanism for defining
"alias paths" or something to handle this kind of migration
compatibility shim.

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
> > +    if (smc->must_pre_allocate_icps) {
>=20
> I am not sure I like 'must', I think 'pre_allocate_icps' should be enough=
 ?=20
> or simply 'allocate_legacy_icps' ?

I'd actually prefer to make it explicit that this is a migration
compatibility shim and call it something like
'pre_2_10_icp_allocation'.

> > +        int smt =3D kvmppc_smt_threads();
> > +        int nr_servers =3D DIV_ROUND_UP(max_cpus * smt, smp_threads);
>=20
> may be we should reintroduce nr_servers at the machine level ?=20
>=20
> > +        int i;
> > +
> > +        spapr->legacy_icps =3D g_malloc0(nr_servers * sizeof(ICPState)=
);

This isn't technically safe, although you'll probably get away with
it.  spapr->icp_type is parameterized, which means it could be a
sub-class with a larger state structure than base ICPState.

> > +        for (i =3D 0; i < nr_servers; i++) {
> > +            void* obj =3D &spapr->legacy_icps[i];
>=20
> 'void *'
>=20
> > +
> > +            object_initialize(obj, sizeof(ICPState), spapr->icp_type);
> > +            object_property_add_child(OBJECT(spapr), "icp[*]", obj,
> > +                                      &error_abort);
>=20
> David does not like the "icp[*]" syntax.
>=20
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
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZG84VAAoJEGw4ysog2bOSC9MP/1arHAPgofHKeNTUT4x4sVBr
0nCojFm0/dPixFO5wzaV9ausUAFhhEvuvxt7729ry6E+Vi0vuAUVKB/J7eoj3CU+
jn4je6Cv7CyX0TUxtgA4d2LaHCbkreZz7++mnXSLSIx6arYd1diZxWp/gjsoeyUg
+veAvMc9/vHg+458PejfUNHk0S6udaHZfia7qBClo+wpmhS1A+Ov/nSmgaQ1cStW
i1ah9GnClh0s72xwMO/hyag2i1+k3anBCA/EHmJZlTP4r0Oc2KCjQWWSKGmYSw68
igpEsLxR4KQbr2glD8USvUwsUSRu95O349hoDOU/ahpgR/Ke0UJy9TpwgnIm+fgq
NS1SLkPAQCUjcnmH2DdofSy2QBJSB7XUGHcFa4g2RgjsfBpBXh8Q9nzvqSAa2k6c
cZWg6fB6V0n/EAotbaMGcuiP009VK64dfBNonYJPzJvtF/VDEM08fdffADNe03sa
X1qdMD7PTxLH22ndUYGvwE+5TH8uiln5NamopFf3xQOOQc8e4CJ59p/KbECcEpFi
vGtKdmun8JK0/po/Ihj0Ucn8Ch5mbm4/3TZLejBWZFhFsL3HWxEvbpihjsVQikpk
FyUPyEDTDKrr6zP6ncDyJWkdhx5re+SMA5YePdEffLa33rXeinCQ6ooHPQ5nmpPJ
aC3oFoUpSNhbZ4rKK6HT
=k+bi
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--
