Received: from eggs.gnu.org ([2001:4830:134:3::10]:58664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dwgHs-00083a-U7
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 23:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dwgHp-0004EH-Kl
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 23:11:56 -0400
Date: Tue, 26 Sep 2017 12:57:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170926025739.GF12504@umbus>
References: <150633285374.14880.11614678065344980502.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="924gEkU1VlJlwnwX"
Content-Disposition: inline
In-Reply-To: <150633285374.14880.11614678065344980502.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] spapr: move registration of "host" CPU
 core type to machine code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>


--924gEkU1VlJlwnwX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2017 at 11:47:33AM +0200, Greg Kurz wrote:
> The CPU core abstraction belongs to the machine code. This also gets
> rid of some code duplication.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>=20
> hw/ppc/spapr_cpu_core.h is also included elsewhere in target/ppc/kvm.c
> but this is already handled by the following cleanup patch:

I don't really see what the advantage of this is.  As others have
pointed out it leads to the host type being registered very late,
which could cause problems.

>=20
> https://patchwork.ozlabs.org/patch/817598/
> ---
>  hw/ppc/spapr.c                  |    4 ++++
>  hw/ppc/spapr_cpu_core.c         |   34 ++++++++++++++++++++++------------
>  include/hw/ppc/spapr_cpu_core.h |    2 +-
>  target/ppc/kvm.c                |   12 ------------
>  4 files changed, 27 insertions(+), 25 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 0ce3ec87ac59..e82c8532ffb0 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2349,6 +2349,10 @@ static void ppc_spapr_init(MachineState *machine)
>      }
> =20
>      /* init CPUs */
> +    if (kvm_enabled()) {
> +        spapr_cpu_core_register_host_type();
> +    }
> +
>      if (machine->cpu_model =3D=3D NULL) {
>          machine->cpu_model =3D kvm_enabled() ? "host" : smc->tcg_default=
_cpu;
>      }
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index c08ee7571a50..6e224ba029ec 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -317,7 +317,7 @@ static Property spapr_cpu_core_properties[] =3D {
>      DEFINE_PROP_END_OF_LIST()
>  };
> =20
> -void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
> +static void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(oc);
>      sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_CLASS(oc);
> @@ -337,6 +337,20 @@ static const TypeInfo spapr_cpu_core_type_info =3D {
>      .class_size =3D sizeof(sPAPRCPUCoreClass),
>  };
> =20
> +static void spapr_cpu_core_register_type(const char *model_name)
> +{
> +    TypeInfo type_info =3D {
> +        .parent =3D TYPE_SPAPR_CPU_CORE,
> +        .instance_size =3D sizeof(sPAPRCPUCore),
> +        .class_init =3D spapr_cpu_core_class_init,
> +        .class_data =3D (void *) model_name,
> +    };
> +
> +    type_info.name =3D g_strdup_printf("%s-"TYPE_SPAPR_CPU_CORE, model_n=
ame);
> +    type_register(&type_info);
> +    g_free((void *)type_info.name);
> +}
> +
>  static void spapr_cpu_core_register_types(void)
>  {
>      int i;
> @@ -344,18 +358,14 @@ static void spapr_cpu_core_register_types(void)
>      type_register_static(&spapr_cpu_core_type_info);
> =20
>      for (i =3D 0; i < ARRAY_SIZE(spapr_core_models); i++) {
> -        TypeInfo type_info =3D {
> -            .parent =3D TYPE_SPAPR_CPU_CORE,
> -            .instance_size =3D sizeof(sPAPRCPUCore),
> -            .class_init =3D spapr_cpu_core_class_init,
> -            .class_data =3D (void *) spapr_core_models[i],
> -        };
> -
> -        type_info.name =3D g_strdup_printf("%s-" TYPE_SPAPR_CPU_CORE,
> -                                         spapr_core_models[i]);
> -        type_register(&type_info);
> -        g_free((void *)type_info.name);
> +        spapr_cpu_core_register_type(spapr_core_models[i]);
>      }
> +
> +}
> +
> +void spapr_cpu_core_register_host_type(void)
> +{
> +    spapr_cpu_core_register_type("host");
>  }
> =20
>  type_init(spapr_cpu_core_register_types)
> diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_c=
ore.h
> index 93051e9ecf56..e3e906343048 100644
> --- a/include/hw/ppc/spapr_cpu_core.h
> +++ b/include/hw/ppc/spapr_cpu_core.h
> @@ -36,5 +36,5 @@ typedef struct sPAPRCPUCoreClass {
>  } sPAPRCPUCoreClass;
> =20
>  char *spapr_get_cpu_core_type(const char *model);
> -void spapr_cpu_core_class_init(ObjectClass *oc, void *data);
> +void spapr_cpu_core_register_host_type(void);
>  #endif
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 5b281b2f1b6d..8dd80993ec9e 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -37,7 +37,6 @@
>  #include "hw/sysbus.h"
>  #include "hw/ppc/spapr.h"
>  #include "hw/ppc/spapr_vio.h"
> -#include "hw/ppc/spapr_cpu_core.h"
>  #include "hw/ppc/ppc.h"
>  #include "sysemu/watchdog.h"
>  #include "trace.h"
> @@ -2502,17 +2501,6 @@ static int kvm_ppc_register_host_cpu_type(void)
>      oc =3D object_class_by_name(type_info.name);
>      g_assert(oc);
> =20
> -#if defined(TARGET_PPC64)
> -    type_info.name =3D g_strdup_printf("%s-"TYPE_SPAPR_CPU_CORE, "host");
> -    type_info.parent =3D TYPE_SPAPR_CPU_CORE,
> -    type_info.instance_size =3D sizeof(sPAPRCPUCore);
> -    type_info.instance_init =3D NULL;
> -    type_info.class_init =3D spapr_cpu_core_class_init;
> -    type_info.class_data =3D (void *) "host";
> -    type_register(&type_info);
> -    g_free((void *)type_info.name);
> -#endif
> -
>      /*
>       * Update generic CPU family class alias (e.g. on a POWER8NVL host,
>       * we want "POWER8" to be a "family" alias that points to the current
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--924gEkU1VlJlwnwX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnJwiEACgkQbDjKyiDZ
s5IDuQ/9FXUx/T8V7RWHCQ24/VgXqtCDFFiLIE7j0bw7E/mnP9MMFZkjzEJCyuHi
OOvmaF6k0me3wA9jBCndadocjvdZCqVd5ZZ4GZCycrCdcQ1mjoQjjLkjmyYd2D/a
gc5I4xRTHi1CM2jxT+EmQckKW9bm7yfhDZJX2rASLPz1FZyPJMoGU7d4D440sszm
OP5agBzmOZsF9PQOChX6EpGTT/C3lTtOoVb/IVSGbZYK9WisXZvr7yaBTXf8Waz5
b6ETeTfa/iY2jvMIk6+Zip2EOTXvUofjClT6FYyDZNfk/7LwdH9xHWjPhACoUMlh
4RHXgJV3V45hV6o/tNlHT9OPmfxOJ7wfBPcs4YMgEjlyYGTaVEBkph3nMPMlSoXU
/laDat8q5/jzj8nWdtiVgNimvIsvcInoQxYkmgIKJsyfTmPY0JhJksG9SwBB10J5
Jz5tAvYyW3wyIeyWdTUGOb4/mVtL3Is7Y7G0Zx0SBVUjNBQEJYexfAGlze8SfQ1P
cVL1R8PNY6FiApYjRPY/x/Z2aYgIRifuVUWueuGfS5ftb2NdHqLNm01UjyRO2dMk
l2OTz4EwCmLW1uXc04/iSjSUOfMbcZw1xye/Ullaxdm/H3ktzJqyn6Xdpp+U4A/0
FpYg9C5D0QGW3ThNLvrZ2isfr2AZ2eh+zyY43b5L3VQQhW1siTI=
=fE65
-----END PGP SIGNATURE-----

--924gEkU1VlJlwnwX--
