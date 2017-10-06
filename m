Received: from eggs.gnu.org ([2001:4830:134:3::10]:38451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e0M4I-00079q-TZ
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 02:25:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e0M4F-0006uR-O2
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 02:25:06 -0400
Received: from 5.mo5.mail-out.ovh.net ([87.98.173.103]:51723)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e0M4F-0006t5-H9
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 02:25:03 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 0C6D4135D45
	for <qemu-devel@nongnu.org>; Fri,  6 Oct 2017 08:25:02 +0200 (CEST)
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-22-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <254f7a9a-0b76-6c77-7107-b9bddfb5c281@kaod.org>
Date: Fri, 6 Oct 2017 08:24:56 +0200
MIME-Version: 1.0
In-Reply-To: <1507220690-265042-22-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 21/23] ppc: pnv: define core
 types statically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: "open list:ppce500" <qemu-ppc@nongnu.org>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>

On 10/05/2017 06:24 PM, Igor Mammedov wrote:
> pnv core type definition doesn't have any fields that
> require it to be defined at runtime. So replace code
> that fills in TypeInfo at runtime with static TypeInfo
> array that does the same at complie time.

This is much better.

> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/ppc/pnv_core.c | 48 ++++++++++++++++++++---------------------------=
-
>  1 file changed, 20 insertions(+), 28 deletions(-)
>=20
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index acdfa17..000c87e 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -225,38 +225,30 @@ static void pnv_core_class_init(ObjectClass *oc, =
void *data)
>      dc->props =3D pnv_core_properties;
>  }
> =20
> -static const TypeInfo pnv_core_info =3D {
> -    .name           =3D TYPE_PNV_CORE,
> -    .parent         =3D TYPE_CPU_CORE,
> -    .instance_size  =3D sizeof(PnvCore),
> -    .class_size     =3D sizeof(PnvCoreClass),
> -    .class_init =3D pnv_core_class_init,
> -    .abstract       =3D true,
> -};
> -
> -static const char *pnv_core_models[] =3D {
> -    "power8e_v2.1", "power8_v2.0", "power8nvl_v1.0", "power9_v1.0"
> -};
> -
> -static void pnv_core_register_types(void)
> -{
> -    int i ;
> -
> -    type_register_static(&pnv_core_info);
> -    for (i =3D 0; i < ARRAY_SIZE(pnv_core_models); ++i) {
> -        TypeInfo ti =3D {
> -            .parent =3D TYPE_PNV_CORE,
> -            .instance_size =3D sizeof(PnvCore),
> -        };
> -        ti.name =3D pnv_core_typename(pnv_core_models[i]);
> -        type_register(&ti);
> -        g_free((void *)ti.name);
> +#define DEFINE_PNV_CORE_TYPE(cpu_model)         \
> +    {                                           \
> +        .parent =3D TYPE_PNV_CORE,                \
> +        .name =3D PNV_CORE_TYPE_NAME(cpu_model),  \
>      }
> -}
> =20
> -type_init(pnv_core_register_types)
> +static const TypeInfo pnv_core_infos[] =3D {
> +    {
> +        .name           =3D TYPE_PNV_CORE,
> +        .parent         =3D TYPE_CPU_CORE,
> +        .instance_size  =3D sizeof(PnvCore),
> +        .class_size     =3D sizeof(PnvCoreClass),
> +        .class_init =3D pnv_core_class_init,
> +        .abstract       =3D true,
> +    },
> +    DEFINE_PNV_CORE_TYPE("power8e_v2.1"),
> +    DEFINE_PNV_CORE_TYPE("power8_v2.0"),
> +    DEFINE_PNV_CORE_TYPE("power8nvl_v1.0"),
> +    DEFINE_PNV_CORE_TYPE("power9_v1.0"),
> +};
> =20
>  char *pnv_core_typename(const char *model)
>  {
>      return g_strdup_printf(PNV_CORE_TYPE_NAME("%s"), model);
>  }
> +
> +DEFINE_TYPES(pnv_core_infos)
>=20
