Received: from eggs.gnu.org ([2001:4830:134:3::10]:39059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e0M6v-0008Lo-IX
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 02:27:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e0M6s-0000cm-EO
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 02:27:49 -0400
Received: from 12.mo5.mail-out.ovh.net ([46.105.39.65]:39675)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e0M6s-0000bg-8B
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 02:27:46 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id E16A3138197
	for <qemu-devel@nongnu.org>; Fri,  6 Oct 2017 08:27:44 +0200 (CEST)
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-21-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <1cf6e90b-f846-508b-f3d9-e3f738258e84@kaod.org>
Date: Fri, 6 Oct 2017 08:27:40 +0200
MIME-Version: 1.0
In-Reply-To: <1507220690-265042-21-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 20/23] ppc: pnv: drop
 PnvCoreClass::cpu_oc field
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
> deduce cpu type directly from core type instead of
> maintaining type mapping in PnvCoreClass::cpu_oc and doing
> extra cpu_model parsing in pnv_core_class_init()
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

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
> +{
> +    const char *core_type =3D object_class_get_name(object_get_class(O=
BJECT(pc)));
> +    int len =3D strlen(core_type) - strlen(PNV_CORE_TYPE_SUFFIX);
> +    char *s =3D g_strdup_printf(POWERPC_CPU_TYPE_NAME("%.*s"), len, co=
re_type);
> +    const char *cpu_type =3D object_class_get_name(object_class_by_nam=
e(s));
> +    g_free(s);
> +    return cpu_type;
> +}
> +
>  static void powernv_cpu_reset(void *opaque)
>  {
>      PowerPCCPU *cpu =3D opaque;
> @@ -148,8 +158,7 @@ static void pnv_core_realize(DeviceState *dev, Erro=
r **errp)
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
>=20
