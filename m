Received: from eggs.gnu.org ([2001:4830:134:3::10]:49006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0N5C-0006Pe-45
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 03:30:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0N55-0002cJ-JB
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 03:30:06 -0400
Date: Fri, 6 Oct 2017 15:01:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171006040112.GR3260@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-15-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UuuTb5hZdWr4w/Ub"
Content-Disposition: inline
In-Reply-To: <1507220690-265042-15-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 14/23] ppc: spapr: use cpu type name
 directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>


--UuuTb5hZdWr4w/Ub
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2017 at 06:24:41PM +0200, Igor Mammedov wrote:
> replace sPAPRCPUCoreClass::cpu_class with cpu type name
> since it were needed just to get that at points it were
> accessed.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/ppc/spapr_cpu_core.h |  2 +-
>  hw/ppc/spapr.c                  |  6 ++----
>  hw/ppc/spapr_cpu_core.c         | 13 +++++--------
>  target/ppc/kvm.c                |  2 +-
>  4 files changed, 9 insertions(+), 14 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_c=
ore.h
> index 66dcf52..264ce68 100644
> --- a/include/hw/ppc/spapr_cpu_core.h
> +++ b/include/hw/ppc/spapr_cpu_core.h
> @@ -34,7 +34,7 @@ typedef struct sPAPRCPUCore {
> =20
>  typedef struct sPAPRCPUCoreClass {
>      DeviceClass parent_class;
> -    ObjectClass *cpu_class;
> +    const char *cpu_type;
>  } sPAPRCPUCoreClass;
> =20
>  char *spapr_get_cpu_core_type(const char *model);
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 01b3012..ad7afd6 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3142,8 +3142,7 @@ void spapr_core_release(DeviceState *dev)
>      if (smc->pre_2_10_has_unused_icps) {
>          sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
>          sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(OBJECT(cc));
> -        const char *typename =3D object_class_get_name(scc->cpu_class);
> -        size_t size =3D object_type_get_instance_size(typename);
> +        size_t size =3D object_type_get_instance_size(scc->cpu_type);
>          int i;
> =20
>          for (i =3D 0; i < cc->nr_threads; i++) {
> @@ -3239,8 +3238,7 @@ static void spapr_core_plug(HotplugHandler *hotplug=
_dev, DeviceState *dev,
> =20
>      if (smc->pre_2_10_has_unused_icps) {
>          sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(OBJECT(cc));
> -        const char *typename =3D object_class_get_name(scc->cpu_class);
> -        size_t size =3D object_type_get_instance_size(typename);
> +        size_t size =3D object_type_get_instance_size(scc->cpu_type);
>          int i;
> =20
>          for (i =3D 0; i < cc->nr_threads; i++) {
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 01f4ec8..8e13e52 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -90,8 +90,7 @@ static void spapr_cpu_core_unrealizefn(DeviceState *dev=
, Error **errp)
>  {
>      sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
>      sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
> -    const char *typename =3D object_class_get_name(scc->cpu_class);
> -    size_t size =3D object_type_get_instance_size(typename);
> +    size_t size =3D object_type_get_instance_size(scc->cpu_type);
>      CPUCore *cc =3D CPU_CORE(dev);
>      int i;
> =20
> @@ -152,8 +151,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, =
Error **errp)
>      sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
>      sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
>      CPUCore *cc =3D CPU_CORE(OBJECT(dev));
> -    const char *typename =3D object_class_get_name(scc->cpu_class);
> -    size_t size =3D object_type_get_instance_size(typename);
> +    size_t size =3D object_type_get_instance_size(scc->cpu_type);
>      Error *local_err =3D NULL;
>      void *obj;
>      int i, j;
> @@ -172,7 +170,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, =
Error **errp)
> =20
>          obj =3D sc->threads + i * size;
> =20
> -        object_initialize(obj, size, typename);
> +        object_initialize(obj, size, scc->cpu_type);
>          cs =3D CPU(obj);
>          cpu =3D POWERPC_CPU(cs);
>          cs->cpu_index =3D cc->core_id + i;
> @@ -230,14 +228,13 @@ void spapr_cpu_core_class_init(ObjectClass *oc, voi=
d *data)
>      dc->realize =3D spapr_cpu_core_realize;
>      dc->unrealize =3D spapr_cpu_core_unrealizefn;
>      dc->props =3D spapr_cpu_core_properties;
> -    scc->cpu_class =3D cpu_class_by_name(TYPE_POWERPC_CPU, data);
> -    g_assert(scc->cpu_class);
> +    scc->cpu_type =3D data;
>  }
> =20
>  #define DEFINE_SPAPR_CPU_CORE_TYPE(cpu_model) \
>      {                                                   \
>          .parent =3D TYPE_SPAPR_CPU_CORE,                  \
> -        .class_data =3D (void *) cpu_model,               \
> +        .class_data =3D (void *) POWERPC_CPU_TYPE_NAME(cpu_model), \
>          .class_init =3D spapr_cpu_core_class_init,        \
>          .name =3D SPAPR_CPU_CORE_TYPE_NAME(cpu_model),    \
>      }
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 171d3d8..c2152ed 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2514,7 +2514,7 @@ static int kvm_ppc_register_host_cpu_type(void)
>      type_info.instance_size =3D sizeof(sPAPRCPUCore);
>      type_info.instance_init =3D NULL;
>      type_info.class_init =3D spapr_cpu_core_class_init;
> -    type_info.class_data =3D (void *) "host";
> +    type_info.class_data =3D (void *) POWERPC_CPU_TYPE_NAME("host");
>      type_register(&type_info);
>      g_free((void *)type_info.name);
>  #endif

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UuuTb5hZdWr4w/Ub
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnXAAgACgkQbDjKyiDZ
s5LacBAA3iR+UHVrZewupjB8CK7aPJ1aYAIDfiQg20sLtuA4P1M2mlZWJJBwgrL6
LtSrMWqC7uenHRM+nD5YDu7fb+qysrX4DeLMJiCSBTekndL+QdvMjYEKC91Unmq1
+oSg+62KQyJOmv81uZqtPZPTadwzT9PISDTLuQf5f6oCZSJj8BQQexsTn/fqHQIU
tKeNqr5Jc6c7oYd2ocF07xYJZZ3l5ugABSdNSdNGEd3Ecsch9LHhEPOo+uBZ0FV1
4erHrfvI2hmC47Vdf4UBQ4G4M5O+PTuYMtbXrbxcNFamcWGKpAN6uNvTZa/V/Nfz
ey1iC3Qf8EMKwpqjlWRsR1Dy9MO1TCCPgz48K7H+hZtB4DO9NhQX/E+kZm/pYIxn
TG5drlq3kluab+02/Ybbv3SfzC/CHyExHZis8aD/h0kqxSXcedZpqa0abzOzTLx4
fAIeNaN39mfJJxXaKuRXCqjBbiAG1Xz7gB66A+aLnVt+xkiyrbICK2JLZCC0Xi35
6LazrTviqgAga5V41v+UpvyCGdHy0fo+OG06MmTYswIi3sl9VFpmowHgRWzRFy53
47n0BwAMUxMkP5NTBuRzu5/pg5lyNnEwHcTU6aWYMDnCAOOQanKrmh2Mab8tMV57
kVDAIZ3LLZLbLz9zeDxTkdVtn+fj5kO456DMfBbVbLWawExLnfI=
=7StQ
-----END PGP SIGNATURE-----

--UuuTb5hZdWr4w/Ub--
