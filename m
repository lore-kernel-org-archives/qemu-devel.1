Received: from eggs.gnu.org ([2001:4830:134:3::10]:40298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0OPG-0004Vt-8T
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 04:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0OPE-0008E6-VI
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 04:54:54 -0400
Date: Fri, 6 Oct 2017 19:41:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171006084112.GY3260@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-21-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="csti59zOqP8qx56L"
Content-Disposition: inline
In-Reply-To: <1507220690-265042-21-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 20/23] ppc: pnv: drop PnvCoreClass::cpu_oc
 field
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


--csti59zOqP8qx56L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2017 at 06:24:47PM +0200, Igor Mammedov wrote:
> deduce cpu type directly from core type instead of
> maintaining type mapping in PnvCoreClass::cpu_oc and doing
> extra cpu_model parsing in pnv_core_class_init()
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/hw/ppc/pnv_core.h |  1 -
>  hw/ppc/pnv_core.c         | 18 ++++++++++++------
>  2 files changed, 12 insertions(+), 7 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> index 3360c4b..a336a1f 100644
> --- a/include/hw/ppc/pnv_core.h
> +++ b/include/hw/ppc/pnv_core.h
> @@ -42,7 +42,6 @@ typedef struct PnvCore {
> =20
>  typedef struct PnvCoreClass {
>      DeviceClass parent_class;
> -    ObjectClass *cpu_oc;
>  } PnvCoreClass;
> =20
>  #define PNV_CORE_TYPE_SUFFIX "-" TYPE_PNV_CORE
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index b3e3f23..acdfa17 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -27,6 +27,16 @@
>  #include "hw/ppc/pnv_xscom.h"
>  #include "hw/ppc/xics.h"
> =20
> +static const char *pvn_core_cpu_typename(PnvCore *pc)

Uh.. s/pvn/pnv/ ..

> +{
> +    const char *core_type =3D object_class_get_name(object_get_class(OBJ=
ECT(pc)));
> +    int len =3D strlen(core_type) - strlen(PNV_CORE_TYPE_SUFFIX);
> +    char *s =3D g_strdup_printf(POWERPC_CPU_TYPE_NAME("%.*s"), len, core=
_type);
> +    const char *cpu_type =3D object_class_get_name(object_class_by_name(=
s));
> +    g_free(s);
> +    return cpu_type;
> +}
> +
>  static void powernv_cpu_reset(void *opaque)
>  {
>      PowerPCCPU *cpu =3D opaque;
> @@ -148,8 +158,7 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
>  {
>      PnvCore *pc =3D PNV_CORE(OBJECT(dev));
>      CPUCore *cc =3D CPU_CORE(OBJECT(dev));
> -    PnvCoreClass *pcc =3D PNV_CORE_GET_CLASS(OBJECT(dev));
> -    const char *typename =3D object_class_get_name(pcc->cpu_oc);
> +    const char *typename =3D pvn_core_cpu_typename(pc);
>      size_t size =3D object_type_get_instance_size(typename);
>      Error *local_err =3D NULL;
>      void *obj;
> @@ -211,11 +220,9 @@ static Property pnv_core_properties[] =3D {
>  static void pnv_core_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(oc);
> -    PnvCoreClass *pcc =3D PNV_CORE_CLASS(oc);
> =20
>      dc->realize =3D pnv_core_realize;
>      dc->props =3D pnv_core_properties;
> -    pcc->cpu_oc =3D cpu_class_by_name(TYPE_POWERPC_CPU, data);
>  }
> =20
>  static const TypeInfo pnv_core_info =3D {
> @@ -223,6 +230,7 @@ static const TypeInfo pnv_core_info =3D {
>      .parent         =3D TYPE_CPU_CORE,
>      .instance_size  =3D sizeof(PnvCore),
>      .class_size     =3D sizeof(PnvCoreClass),
> +    .class_init =3D pnv_core_class_init,
>      .abstract       =3D true,
>  };
> =20
> @@ -239,8 +247,6 @@ static void pnv_core_register_types(void)
>          TypeInfo ti =3D {
>              .parent =3D TYPE_PNV_CORE,
>              .instance_size =3D sizeof(PnvCore),
> -            .class_init =3D pnv_core_class_init,
> -            .class_data =3D (void *) pnv_core_models[i],
>          };
>          ti.name =3D pnv_core_typename(pnv_core_models[i]);
>          type_register(&ti);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--csti59zOqP8qx56L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnXQagACgkQbDjKyiDZ
s5JVcg//an2KVtO8uMgRtyx6JMv4moXDAkC3Css1grf1A5MSCcEK5ohmyL+Dv9XV
776hvLuJKe/pfr+WzYtNKAZBPBFZjBVt63IhD6efbH2UBqpiNw5Az6ANFVOS0A9W
GZoyBFO1klmjqMQSJzaPh0TAM5CnfeH/BL5qOS217IL1sLDLCtJCM3N1ZsI+u/32
cAEW2Gx3NZgM/zJHHL4A3R7Y/z8MDMKUnzAdMJpid4ozQCWgjD7nqEnB9Yjd3PN3
J2Kfyi6a1s8TMszUxxQHqMb4vKDxDZTprdpPQ0d8Iv6yQ7l2C05Nq3W5JMN/OPcL
0RvooVKdGbeF/bt/7gxEpCoV5ECjo3mXvcGyDkfu5wo7NY2PpgKIJNMG8+xw/XRw
mmvLv+/fXDV8Bp2uMzKI/YIX9i9D4pBCrNoNf5LIFGng00m7hMN+SxPIsPc8vysq
WXp6b64riy70GLjE47FBWB5XMBhXL8x87UpuSmVcvsP5XvRLt88KUtFKsKjb28Ms
TYrD57majgRl/DC9NApd4VfYnzCKbtjtYiJI+xBz7qpKrGJHWVl9AcD1WlZkwM9N
SW5tuUAT4kJiPLse0xD9w70n47nEHfgnJFtAAQlQhcug7+75znWVkTh9Blqgzub0
x63qbQSTDgJGRRVm+ZRGVIqvDQbSQ3mQc7FgegEF983MPV2JifU=
=jotU
-----END PGP SIGNATURE-----

--csti59zOqP8qx56L--
