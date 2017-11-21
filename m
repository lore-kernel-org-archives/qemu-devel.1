Received: from eggs.gnu.org ([2001:4830:134:3::10]:58467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eGwPg-0003Er-HE
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 19:27:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eGwPf-0003qp-0t
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 19:27:44 -0500
Date: Tue, 21 Nov 2017 11:14:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171121001406.GO19214@umbus.fritz.box>
References: <151116959472.32765.11476730637006052305.stgit@bahia.lan>
	<20171120155648.21bcbe5b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PdAWLd+WEPmMbsbx"
Content-Disposition: inline
In-Reply-To: <20171120155648.21bcbe5b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 REPOST] spapr_cpu_core:
 instantiate CPUs separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--PdAWLd+WEPmMbsbx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2017 at 03:56:48PM +0100, Igor Mammedov wrote:
> On Mon, 20 Nov 2017 10:19:54 +0100
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > The current code assumes that only the CPU core object holds a
> > reference on each individual CPU object, and happily frees their
> > allocated memory when the core is unrealized. This is dangerous
> > as some other code can legitimely keep a pointer to a CPU if it
> > calls object_ref(), but it would end up with a dangling pointer.
> >=20
> > Let's allocate all CPUs with object_new() and let QOM frees them
> s/frees/free/
>=20
> > when their reference count reaches zero. This greatly simplify the
> > code as we don't have to fiddle with the instance size anymore.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> Acked-by: Igor Mammedov <imammedo@redhat.com>

Applied to ppc-for-2.12 with the typo above fixed.


>=20
> > ---
> >  hw/ppc/spapr.c                  |   11 +++--------
> >  hw/ppc/spapr_cpu_core.c         |   19 +++++++------------
> >  include/hw/ppc/spapr_cpu_core.h |    2 +-
> >  3 files changed, 11 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 174e7ff0678d..fc92b9d914a5 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -3173,12 +3173,10 @@ void spapr_core_release(DeviceState *dev)
> > =20
> >      if (smc->pre_2_10_has_unused_icps) {
> >          sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
> > -        sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(OBJECT(cc)=
);
> > -        size_t size =3D object_type_get_instance_size(scc->cpu_type);
> >          int i;
> > =20
> >          for (i =3D 0; i < cc->nr_threads; i++) {
> > -            CPUState *cs =3D CPU(sc->threads + i * size);
> > +            CPUState *cs =3D CPU(sc->threads[i]);
> > =20
> >              pre_2_10_vmstate_register_dummy_icp(cs->cpu_index);
> >          }
> > @@ -3224,7 +3222,7 @@ static void spapr_core_plug(HotplugHandler *hotpl=
ug_dev, DeviceState *dev,
> >      sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> >      sPAPRCPUCore *core =3D SPAPR_CPU_CORE(OBJECT(dev));
> >      CPUCore *cc =3D CPU_CORE(dev);
> > -    CPUState *cs =3D CPU(core->threads);
> > +    CPUState *cs =3D CPU(core->threads[0]);
> >      sPAPRDRConnector *drc;
> >      Error *local_err =3D NULL;
> >      int smt =3D kvmppc_smt_threads();
> > @@ -3269,15 +3267,12 @@ static void spapr_core_plug(HotplugHandler *hot=
plug_dev, DeviceState *dev,
> >      core_slot->cpu =3D OBJECT(dev);
> > =20
> >      if (smc->pre_2_10_has_unused_icps) {
> > -        sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(OBJECT(cc)=
);
> > -        size_t size =3D object_type_get_instance_size(scc->cpu_type);
> >          int i;
> > =20
> >          for (i =3D 0; i < cc->nr_threads; i++) {
> >              sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(dev);
> > -            void *obj =3D sc->threads + i * size;
> > =20
> > -            cs =3D CPU(obj);
> > +            cs =3D CPU(sc->threads[i]);
> >              pre_2_10_vmstate_unregister_dummy_icp(cs->cpu_index);
> >          }
> >      }
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index 3a4c17401226..588f9b45714a 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -79,13 +79,11 @@ const char *spapr_get_cpu_core_type(const char *cpu=
_type)
> >  static void spapr_cpu_core_unrealizefn(DeviceState *dev, Error **errp)
> >  {
> >      sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
> > -    sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
> > -    size_t size =3D object_type_get_instance_size(scc->cpu_type);
> >      CPUCore *cc =3D CPU_CORE(dev);
> >      int i;
> > =20
> >      for (i =3D 0; i < cc->nr_threads; i++) {
> > -        void *obj =3D sc->threads + i * size;
> > +        Object *obj =3D OBJECT(sc->threads[i]);
> >          DeviceState *dev =3D DEVICE(obj);
> >          CPUState *cs =3D CPU(dev);
> >          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > @@ -146,9 +144,8 @@ static void spapr_cpu_core_realize(DeviceState *dev=
, Error **errp)
> >      sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
> >      sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
> >      CPUCore *cc =3D CPU_CORE(OBJECT(dev));
> > -    size_t size;
> >      Error *local_err =3D NULL;
> > -    void *obj;
> > +    Object *obj;
> >      int i, j;
> > =20
> >      if (!spapr) {
> > @@ -156,18 +153,16 @@ static void spapr_cpu_core_realize(DeviceState *d=
ev, Error **errp)
> >          return;
> >      }
> > =20
> > -    size =3D object_type_get_instance_size(scc->cpu_type);
> > -    sc->threads =3D g_malloc0(size * cc->nr_threads);
> > +    sc->threads =3D g_new(PowerPCCPU *, cc->nr_threads);
> >      for (i =3D 0; i < cc->nr_threads; i++) {
> >          char id[32];
> >          CPUState *cs;
> >          PowerPCCPU *cpu;
> > =20
> > -        obj =3D sc->threads + i * size;
> > +        obj =3D object_new(scc->cpu_type);
> > =20
> > -        object_initialize(obj, size, scc->cpu_type);
> >          cs =3D CPU(obj);
> > -        cpu =3D POWERPC_CPU(cs);
> > +        cpu =3D sc->threads[i] =3D POWERPC_CPU(obj);
> >          cs->cpu_index =3D cc->core_id + i;
> >          cpu->vcpu_id =3D (cc->core_id * spapr->vsmt / smp_threads) + i;
> >          if (kvm_enabled() && !kvm_vcpu_id_is_valid(cpu->vcpu_id)) {
> > @@ -192,7 +187,7 @@ static void spapr_cpu_core_realize(DeviceState *dev=
, Error **errp)
> >      }
> > =20
> >      for (j =3D 0; j < cc->nr_threads; j++) {
> > -        obj =3D sc->threads + j * size;
> > +        obj =3D OBJECT(sc->threads[j]);
> > =20
> >          spapr_cpu_core_realize_child(obj, spapr, &local_err);
> >          if (local_err) {
> > @@ -203,7 +198,7 @@ static void spapr_cpu_core_realize(DeviceState *dev=
, Error **errp)
> > =20
> >  err:
> >      while (--i >=3D 0) {
> > -        obj =3D sc->threads + i * size;
> > +        obj =3D OBJECT(sc->threads[i]);
> >          object_unparent(obj);
> >      }
> >      g_free(sc->threads);
> > diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu=
_core.h
> > index f2d48d6a6786..1129f344aa0c 100644
> > --- a/include/hw/ppc/spapr_cpu_core.h
> > +++ b/include/hw/ppc/spapr_cpu_core.h
> > @@ -28,7 +28,7 @@ typedef struct sPAPRCPUCore {
> >      CPUCore parent_obj;
> > =20
> >      /*< public >*/
> > -    void *threads;
> > +    PowerPCCPU **threads;
> >      int node_id;
> >  } sPAPRCPUCore;
> > =20
> >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PdAWLd+WEPmMbsbx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloTb84ACgkQbDjKyiDZ
s5LA9xAA0N1MHy7jCGajOH1RXkU1NrRyzkKadJWcuyxf6kUq+9ugl/NT71UWXoOX
fIYqaLjyphVahqNObHgTPvGnnVeArI51C2Nzy1wLmjUIhi+BHD53pWI4+KYaxgGZ
Pfobt09hJ/XjuF+41STTCO4a01AIxS0BlorFPVjvkXDRsG+SKwL4Ua1IlkqKiA5s
PUs0dvT4vaG8TcKwIOZLRehn64iu5XEjPtldSRVxpCsxmZngl43vP64V28rzeJ2X
7pjNlzEK8smo0/E4ah41+ZtRGl8Zx+eW8F3TRedTJ/kVTGaDJrtSbshy7o37nU1z
BuwAx95AfGhvBWuvTDU7sjKG1ErsJrxC0dkZakrSNILcy6tdrgRl4v/rr2f0Kn9t
/FzbINxKeQuWjfpxHebi/JiOMCEORZmjdlmhEJJ7pdww3+RK/FiqKqXdJ11ITr8/
L7bDFCVWaujpZ8lDl+Uiyw4yZbXiAoYhNP/Fmza8R2cqnDfap8/JtyB/z50VOp02
WrJrrGlmGJG7vKLxe9osX7Dc4njfYawfUs1Ii8yhAoDlAUcigGjco0zuNUmWDm4i
SZ9ANzjkmx75FGFPE+s9fceHYqoTOorzL2Ygr2c/MiO1SsoGNdM0zKz155VQ/y5G
zMUkuqaamyTnVqDWimPwGKm36DmuppgVDS840EDOLO8W8SvcvBA=
=s4LD
-----END PGP SIGNATURE-----

--PdAWLd+WEPmMbsbx--
