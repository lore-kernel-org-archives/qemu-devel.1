Received: from eggs.gnu.org ([2001:4830:134:3::10]:58355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e3Xe8-0004sr-2z
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 21:23:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e3Xe4-0003Nj-N9
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 21:23:16 -0400
Date: Sat, 14 Oct 2017 20:33:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171014093337.GG28032@umbus.fritz.box>
References: <150789430473.4410.10317971414202753256.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fCcDWlUEdh43YKr8"
Content-Disposition: inline
In-Reply-To: <150789430473.4410.10317971414202753256.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] spapr_cpu_core: instantiate CPUs separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>


--fCcDWlUEdh43YKr8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2017 at 01:31:44PM +0200, Greg Kurz wrote:
> The current code assumes that only the CPU core object holds a
> reference on each individual CPU object, and happily frees their
> allocated memory when the core is unrealized. This is dangerous
> as some other code can legitimely keep a pointer to a CPU if it
> calls object_ref(), but it would end up with a dangling pointer.
>=20
> Let's allocate all CPUs with object_new() and let QOM frees them
> when their reference count reaches zero. This greatly simplify the
> code as we don't have to fiddle with the instance size anymore.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

So, I'm pretty sure my first drafts of the core stuff did things this
waym and it got nacked, for QOM lifetime reasons that I never really
understood.

> ---
> v2: - mention code simplification in changelog
>     - use PowerPCCPU * and Object * instead of void *
> ---
>  hw/ppc/spapr.c                  |   11 +++--------
>  hw/ppc/spapr_cpu_core.c         |   19 +++++++------------
>  include/hw/ppc/spapr_cpu_core.h |    2 +-
>  3 files changed, 11 insertions(+), 21 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index fd9813bde82f..d9555a3677be 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3153,12 +3153,10 @@ void spapr_core_release(DeviceState *dev)
> =20
>      if (smc->pre_2_10_has_unused_icps) {
>          sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
> -        sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(OBJECT(cc));
> -        size_t size =3D object_type_get_instance_size(scc->cpu_type);
>          int i;
> =20
>          for (i =3D 0; i < cc->nr_threads; i++) {
> -            CPUState *cs =3D CPU(sc->threads + i * size);
> +            CPUState *cs =3D CPU(sc->threads[i]);
> =20
>              pre_2_10_vmstate_register_dummy_icp(cs->cpu_index);
>          }
> @@ -3204,7 +3202,7 @@ static void spapr_core_plug(HotplugHandler *hotplug=
_dev, DeviceState *dev,
>      sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
>      sPAPRCPUCore *core =3D SPAPR_CPU_CORE(OBJECT(dev));
>      CPUCore *cc =3D CPU_CORE(dev);
> -    CPUState *cs =3D CPU(core->threads);
> +    CPUState *cs =3D CPU(core->threads[0]);
>      sPAPRDRConnector *drc;
>      Error *local_err =3D NULL;
>      int smt =3D kvmppc_smt_threads();
> @@ -3249,15 +3247,12 @@ static void spapr_core_plug(HotplugHandler *hotpl=
ug_dev, DeviceState *dev,
>      core_slot->cpu =3D OBJECT(dev);
> =20
>      if (smc->pre_2_10_has_unused_icps) {
> -        sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(OBJECT(cc));
> -        size_t size =3D object_type_get_instance_size(scc->cpu_type);
>          int i;
> =20
>          for (i =3D 0; i < cc->nr_threads; i++) {
>              sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(dev);
> -            void *obj =3D sc->threads + i * size;
> =20
> -            cs =3D CPU(obj);
> +            cs =3D CPU(sc->threads[i]);
>              pre_2_10_vmstate_unregister_dummy_icp(cs->cpu_index);
>          }
>      }
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 3a4c17401226..588f9b45714a 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -79,13 +79,11 @@ const char *spapr_get_cpu_core_type(const char *cpu_t=
ype)
>  static void spapr_cpu_core_unrealizefn(DeviceState *dev, Error **errp)
>  {
>      sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
> -    sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
> -    size_t size =3D object_type_get_instance_size(scc->cpu_type);
>      CPUCore *cc =3D CPU_CORE(dev);
>      int i;
> =20
>      for (i =3D 0; i < cc->nr_threads; i++) {
> -        void *obj =3D sc->threads + i * size;
> +        Object *obj =3D OBJECT(sc->threads[i]);
>          DeviceState *dev =3D DEVICE(obj);
>          CPUState *cs =3D CPU(dev);
>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> @@ -146,9 +144,8 @@ static void spapr_cpu_core_realize(DeviceState *dev, =
Error **errp)
>      sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
>      sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
>      CPUCore *cc =3D CPU_CORE(OBJECT(dev));
> -    size_t size;
>      Error *local_err =3D NULL;
> -    void *obj;
> +    Object *obj;
>      int i, j;
> =20
>      if (!spapr) {
> @@ -156,18 +153,16 @@ static void spapr_cpu_core_realize(DeviceState *dev=
, Error **errp)
>          return;
>      }
> =20
> -    size =3D object_type_get_instance_size(scc->cpu_type);
> -    sc->threads =3D g_malloc0(size * cc->nr_threads);
> +    sc->threads =3D g_new(PowerPCCPU *, cc->nr_threads);
>      for (i =3D 0; i < cc->nr_threads; i++) {
>          char id[32];
>          CPUState *cs;
>          PowerPCCPU *cpu;
> =20
> -        obj =3D sc->threads + i * size;
> +        obj =3D object_new(scc->cpu_type);
> =20
> -        object_initialize(obj, size, scc->cpu_type);
>          cs =3D CPU(obj);
> -        cpu =3D POWERPC_CPU(cs);
> +        cpu =3D sc->threads[i] =3D POWERPC_CPU(obj);
>          cs->cpu_index =3D cc->core_id + i;
>          cpu->vcpu_id =3D (cc->core_id * spapr->vsmt / smp_threads) + i;
>          if (kvm_enabled() && !kvm_vcpu_id_is_valid(cpu->vcpu_id)) {
> @@ -192,7 +187,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, =
Error **errp)
>      }
> =20
>      for (j =3D 0; j < cc->nr_threads; j++) {
> -        obj =3D sc->threads + j * size;
> +        obj =3D OBJECT(sc->threads[j]);
> =20
>          spapr_cpu_core_realize_child(obj, spapr, &local_err);
>          if (local_err) {
> @@ -203,7 +198,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, =
Error **errp)
> =20
>  err:
>      while (--i >=3D 0) {
> -        obj =3D sc->threads + i * size;
> +        obj =3D OBJECT(sc->threads[i]);
>          object_unparent(obj);
>      }
>      g_free(sc->threads);
> diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_c=
ore.h
> index f2d48d6a6786..1129f344aa0c 100644
> --- a/include/hw/ppc/spapr_cpu_core.h
> +++ b/include/hw/ppc/spapr_cpu_core.h
> @@ -28,7 +28,7 @@ typedef struct sPAPRCPUCore {
>      CPUCore parent_obj;
> =20
>      /*< public >*/
> -    void *threads;
> +    PowerPCCPU **threads;
>      int node_id;
>  } sPAPRCPUCore;
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fCcDWlUEdh43YKr8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnh2e4ACgkQbDjKyiDZ
s5KNlQ/+NByOOD7eWLm7+B8Y39zjPkKLjiTQDQNH4ID0pMv00i/o/Yh8J3nqxtTO
mmx3mtc5O+GHWnVdbfBKsHMy1velQGiHdx8Tla68WFcXOddamTAP38OQjlF0OQYf
aHQp1mIPk5XJ9qbi66wXDWXR8tYu8qJMZoS3b/+c/QATExPJM5d65hKMAtK/gg/h
56DbFXa2suB0m+Qvb1ZbOW4n/K+mSqOXczyIAHRrmK7IcA0DpIx5k39MWbH4goc6
K6remi8sZYlqcwwV8duIvtsL5GNOgLKu5RS2ZAdpoAPUg8vR+5U9TxWtdNqcWCnW
OhY+iPAtJ0leDyDc+4LvjQU0muwK+L0cPgeUpjknx948rW5L6PPYfZ5PBVeqGShk
0i85N1D/jnF7hwJ+VbWXzGOAv+2QGfW0jTtq9k3BZwi2Y90znRHapkf5PWdCK33A
KnPTlnTmwaKgfJoQwO+v84WNftPwDRStsLNUCPBAS/F+ZgrDV1XnfcY5f1n7HlMf
aO4OrHrFtz7DUjM13QnHd5ldv64eU7EP2ZOHs75BlbpfbI21mn0wNO6f19P5dBVZ
UA8piAX54ndIKalwa7FPhuoHmq2ca4bkMhgP/Tm34cSTmwz4PlRCcLp0YFMXS92b
LDLLgruPYAd2OfvcmPpGVwCHi2EBfPI0RaL68vtYYYkN7EPQlLc=
=Ac2b
-----END PGP SIGNATURE-----

--fCcDWlUEdh43YKr8--
