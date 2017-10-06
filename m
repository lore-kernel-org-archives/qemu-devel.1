Received: from eggs.gnu.org ([2001:4830:134:3::10]:48946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0N56-0006OX-Ni
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 03:30:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0N55-0002c9-IA
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 03:30:00 -0400
Date: Fri, 6 Oct 2017 15:41:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171006044104.GT3260@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-16-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NZ00oluAJr3A0NMv"
Content-Disposition: inline
In-Reply-To: <1507220690-265042-16-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 15/23] ppc: spapr: register 'host' core
 type along with the rest of core types
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


--NZ00oluAJr3A0NMv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2017 at 06:24:42PM +0200, Igor Mammedov wrote:
> consolidate 'host' core type registration by moving it from
> KVM specific code into spapr_cpu_core.c, similar like it's
> done in x86 target.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

IIUC this will change behaviour slightly: with this patch the 'host'
core type will show up whenever CONFIG_KVM is set, even if the KVM
accelerator is disabled on the command line.  Previously it would not.

Is this change intentional?

> ---
>  include/hw/ppc/spapr_cpu_core.h |  1 -
>  hw/ppc/spapr_cpu_core.c         |  5 ++++-
>  target/ppc/kvm.c                | 11 -----------
>  3 files changed, 4 insertions(+), 13 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_c=
ore.h
> index 264ce68..42765de 100644
> --- a/include/hw/ppc/spapr_cpu_core.h
> +++ b/include/hw/ppc/spapr_cpu_core.h
> @@ -38,5 +38,4 @@ typedef struct sPAPRCPUCoreClass {
>  } sPAPRCPUCoreClass;
> =20
>  char *spapr_get_cpu_core_type(const char *model);
> -void spapr_cpu_core_class_init(ObjectClass *oc, void *data);
>  #endif
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 8e13e52..f2da4be 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -220,7 +220,7 @@ static Property spapr_cpu_core_properties[] =3D {
>      DEFINE_PROP_END_OF_LIST()
>  };
> =20
> -void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
> +static void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(oc);
>      sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_CLASS(oc);
> @@ -257,6 +257,9 @@ static const TypeInfo spapr_cpu_core_type_infos[] =3D=
 {
>      DEFINE_SPAPR_CPU_CORE_TYPE("power8e_v2.1"),
>      DEFINE_SPAPR_CPU_CORE_TYPE("power8nvl_v1.0"),
>      DEFINE_SPAPR_CPU_CORE_TYPE("power9_v1.0"),
> +#ifdef CONFIG_KVM
> +    DEFINE_SPAPR_CPU_CORE_TYPE("host"),
> +#endif
>  };
> =20
>  DEFINE_TYPES(spapr_cpu_core_type_infos)
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index c2152ed..cb5777a 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2508,17 +2508,6 @@ static int kvm_ppc_register_host_cpu_type(void)
>      oc =3D object_class_by_name(type_info.name);
>      g_assert(oc);
> =20
> -#if defined(TARGET_PPC64)
> -    type_info.name =3D g_strdup_printf("%s-"TYPE_SPAPR_CPU_CORE, "host");
> -    type_info.parent =3D TYPE_SPAPR_CPU_CORE,
> -    type_info.instance_size =3D sizeof(sPAPRCPUCore);
> -    type_info.instance_init =3D NULL;
> -    type_info.class_init =3D spapr_cpu_core_class_init;
> -    type_info.class_data =3D (void *) POWERPC_CPU_TYPE_NAME("host");
> -    type_register(&type_info);
> -    g_free((void *)type_info.name);
> -#endif
> -
>      /*
>       * Update generic CPU family class alias (e.g. on a POWER8NVL host,
>       * we want "POWER8" to be a "family" alias that points to the current

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NZ00oluAJr3A0NMv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnXCV4ACgkQbDjKyiDZ
s5I0rw/+KUrRosQ+vkNUcNbVozLuhEeRgA6MjuoKSGambEZyQxcm4jX5IXr0ePa2
G4k7ts4QPELnN+ZGYlrYKKDjWP5UlfVp4toaZPn+++MvFqv1lvFZx8GU+Cc7TqIi
r2KtYPP6+6aZHaDvQEI2m13o/3upFfFJy1cHC8WHxIrbnpPDBzWdzCYOrsj1uCN+
zjO6LXqLtZIi2eAAabP5AQWJHIg7Oeev++LitowQiB7IrBujYj7I4KaQukn/2VRd
9Tj0tLR58r8fHNWEToH36RoPV71Fn/FtCM41veeXGvX7oHoOS6FPD11NBwRXHRJR
ole3bhhTxCR1ZTXel4uXGKx+EKEPpyCp6HUIJhXZc5fPpyq/8u6+IA4bArS0TUb9
EkmazmF3yBzHiv2x5tTGTI8GTnt+Gg6S37QJekhiFhWH4kNMo+lezeKxQpL5ckNz
nLOFZqvNBPcCooDa43ulqKOob3uHxhbyyN5bpHqF29mY8HF6f/ycB4qjLqNmJUyp
HDO5O/7aROW9uPknRBHyIdyA1EQ4jFkVle8bNYO7lV4cgIsOWSRdKwy7aw+uhjjZ
FtRgfVZXJwri9H9EOdeMamDSfvAO93zg3e4yyPjjgCv6nd30gw1ifT7ujN+TQRc4
nSkQi7LCONNfs5Ztk47S0LZp5iFmRlBhVmUOG5Ul7ejGRm4VEkU=
=O3dU
-----END PGP SIGNATURE-----

--NZ00oluAJr3A0NMv--
