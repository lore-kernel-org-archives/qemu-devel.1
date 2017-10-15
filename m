Received: from eggs.gnu.org ([2001:4830:134:3::10]:43047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e3pyK-0005qh-3c
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 16:57:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e3pyG-0007Nc-Ve
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 16:57:20 -0400
Received: from 4.mo4.mail-out.ovh.net ([178.32.98.131]:40409)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1e3pyG-0007MP-MK
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 16:57:16 -0400
Received: from player159.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 8DCABE5AAC
	for <qemu-devel@nongnu.org>; Sun, 15 Oct 2017 22:57:14 +0200 (CEST)
Date: Sun, 15 Oct 2017 22:57:01 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171015225701.57edeeb5@bahia.lan>
In-Reply-To: <20171014093337.GG28032@umbus.fritz.box>
References: <150789430473.4410.10317971414202753256.stgit@bahia.lan>
	<20171014093337.GG28032@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/CLNIWXGIDgE=5E7zzGfq7I2";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] spapr_cpu_core: instantiate CPUs separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>

--Sig_/CLNIWXGIDgE=5E7zzGfq7I2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 14 Oct 2017 20:33:37 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Oct 13, 2017 at 01:31:44PM +0200, Greg Kurz wrote:
> > The current code assumes that only the CPU core object holds a
> > reference on each individual CPU object, and happily frees their
> > allocated memory when the core is unrealized. This is dangerous
> > as some other code can legitimely keep a pointer to a CPU if it
> > calls object_ref(), but it would end up with a dangling pointer.
> >=20
> > Let's allocate all CPUs with object_new() and let QOM frees them
> > when their reference count reaches zero. This greatly simplify the
> > code as we don't have to fiddle with the instance size anymore.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> So, I'm pretty sure my first drafts of the core stuff did things this
> waym and it got nacked, for QOM lifetime reasons that I never really
> understood.
>=20

Oh... well I'll go through the archives and try to find the thread then.
On the other end, the motivation for this patch was to add reference
counting of CPUs in the monitor code but Igor nacked the approach and
suggested to fix the bug differently. I didn't find any other place where
we would end up with a dangling CPU pointer, so I guess this patch wouldn't
fix an actual issue.

> > ---
> > v2: - mention code simplification in changelog
> >     - use PowerPCCPU * and Object * instead of void *
> > ---
> >  hw/ppc/spapr.c                  |   11 +++--------
> >  hw/ppc/spapr_cpu_core.c         |   19 +++++++------------
> >  include/hw/ppc/spapr_cpu_core.h |    2 +-
> >  3 files changed, 11 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index fd9813bde82f..d9555a3677be 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -3153,12 +3153,10 @@ void spapr_core_release(DeviceState *dev)
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
> > @@ -3204,7 +3202,7 @@ static void spapr_core_plug(HotplugHandler *hotpl=
ug_dev, DeviceState *dev,
> >      sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> >      sPAPRCPUCore *core =3D SPAPR_CPU_CORE(OBJECT(dev));
> >      CPUCore *cc =3D CPU_CORE(dev);
> > -    CPUState *cs =3D CPU(core->threads);
> > +    CPUState *cs =3D CPU(core->threads[0]);
> >      sPAPRDRConnector *drc;
> >      Error *local_err =3D NULL;
> >      int smt =3D kvmppc_smt_threads();
> > @@ -3249,15 +3247,12 @@ static void spapr_core_plug(HotplugHandler *hot=
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
> >  =20
>=20


--Sig_/CLNIWXGIDgE=5E7zzGfq7I2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWePLnQAKCRAC/DrrAQHb
wlWHAJ9xiViYOoP45+aHSUdBbi2YqCz9zwCglGHRYhObTCIIYwFXrtmFjlZrWT4=
=5Qg0
-----END PGP SIGNATURE-----

--Sig_/CLNIWXGIDgE=5E7zzGfq7I2--
