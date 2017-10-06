Received: from eggs.gnu.org ([2001:4830:134:3::10]:39082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e0M6y-0008Nw-HX
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 02:27:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e0M6v-0000gq-By
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 02:27:52 -0400
Received: from 10.mo5.mail-out.ovh.net ([46.105.52.148]:39453)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e0M6v-0000es-2m
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 02:27:49 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 149621381A8
	for <qemu-devel@nongnu.org>; Fri,  6 Oct 2017 08:27:48 +0200 (CEST)
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-23-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5226a65f-468a-7043-2e48-a5e3ac682f75@kaod.org>
Date: Fri, 6 Oct 2017 08:27:43 +0200
MIME-Version: 1.0
In-Reply-To: <1507220690-265042-23-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 22/23] ppc: pnv: drop
 PnvChipClass::cpu_model field
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
> deduce core type directly from chip type instead of
> maintaining type mapping in PnvChipClass::cpu_model.

nice one again.
=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>  include/hw/ppc/pnv.h      |  1 -
>  include/hw/ppc/pnv_core.h |  1 -
>  hw/ppc/pnv.c              | 25 +++++++++++++------------
>  hw/ppc/pnv_core.c         |  5 -----
>  4 files changed, 13 insertions(+), 19 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index d82eee1..20244da 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -69,7 +69,6 @@ typedef struct PnvChipClass {
>      SysBusDeviceClass parent_class;
> =20
>      /*< public >*/
> -    const char *cpu_model;
>      PnvChipType  chip_type;
>      uint64_t     chip_cfam_id;
>      uint64_t     cores_mask;
> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> index a336a1f..e337af7 100644
> --- a/include/hw/ppc/pnv_core.h
> +++ b/include/hw/ppc/pnv_core.h
> @@ -46,6 +46,5 @@ typedef struct PnvCoreClass {
> =20
>  #define PNV_CORE_TYPE_SUFFIX "-" TYPE_PNV_CORE
>  #define PNV_CORE_TYPE_NAME(cpu_model) cpu_model PNV_CORE_TYPE_SUFFIX
> -extern char *pnv_core_typename(const char *model);
> =20
>  #endif /* _PPC_PNV_CORE_H */
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 9c5eb7c..ab7083b 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -55,6 +55,16 @@
>  #define KERNEL_LOAD_ADDR        0x20000000
>  #define INITRD_LOAD_ADDR        0x40000000
> =20
> +static const char *pvn_chip_core_typename(const PnvChip *o)
> +{
> +    const char *chip_type =3D object_class_get_name(object_get_class(O=
BJECT(o)));
> +    int len =3D strlen(chip_type) - strlen(PNV_CHIP_TYPE_SUFFIX);
> +    char *s =3D g_strdup_printf(PNV_CORE_TYPE_NAME("%.*s"), len, chip_=
type);
> +    const char *core_type =3D object_class_get_name(object_class_by_na=
me(s));
> +    g_free(s);
> +    return core_type;
> +}
> +
>  /*
>   * On Power Systems E880 (POWER8), the max cpus (threads) should be :
>   *     4 * 4 sockets * 12 cores * 8 threads =3D 1536
> @@ -270,8 +280,7 @@ static int pnv_chip_lpc_offset(PnvChip *chip, void =
*fdt)
> =20
>  static void powernv_populate_chip(PnvChip *chip, void *fdt)
>  {
> -    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
> -    char *typename =3D pnv_core_typename(pcc->cpu_model);
> +    const char *typename =3D pvn_chip_core_typename(chip);
>      size_t typesize =3D object_type_get_instance_size(typename);
>      int i;
> =20
> @@ -301,7 +310,6 @@ static void powernv_populate_chip(PnvChip *chip, vo=
id *fdt)
>          powernv_populate_memory_node(fdt, chip->chip_id, chip->ram_sta=
rt,
>                                       chip->ram_size);
>      }
> -    g_free(typename);
>  }
> =20
>  static void powernv_populate_rtc(ISADevice *d, void *fdt, int lpc_off)
> @@ -713,7 +721,6 @@ static void pnv_chip_power8e_class_init(ObjectClass=
 *klass, void *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      PnvChipClass *k =3D PNV_CHIP_CLASS(klass);
> =20
> -    k->cpu_model =3D "power8e_v2.1";
>      k->chip_type =3D PNV_CHIP_POWER8E;
>      k->chip_cfam_id =3D 0x221ef04980000000ull;  /* P8 Murano DD2.1 */
>      k->cores_mask =3D POWER8E_CORE_MASK;
> @@ -735,7 +742,6 @@ static void pnv_chip_power8_class_init(ObjectClass =
*klass, void *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      PnvChipClass *k =3D PNV_CHIP_CLASS(klass);
> =20
> -    k->cpu_model =3D "power8_v2.0";
>      k->chip_type =3D PNV_CHIP_POWER8;
>      k->chip_cfam_id =3D 0x220ea04980000000ull; /* P8 Venice DD2.0 */
>      k->cores_mask =3D POWER8_CORE_MASK;
> @@ -757,7 +763,6 @@ static void pnv_chip_power8nvl_class_init(ObjectCla=
ss *klass, void *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      PnvChipClass *k =3D PNV_CHIP_CLASS(klass);
> =20
> -    k->cpu_model =3D "power8nvl_v1.0";
>      k->chip_type =3D PNV_CHIP_POWER8NVL;
>      k->chip_cfam_id =3D 0x120d304980000000ull;  /* P8 Naples DD1.0 */
>      k->cores_mask =3D POWER8_CORE_MASK;
> @@ -779,7 +784,6 @@ static void pnv_chip_power9_class_init(ObjectClass =
*klass, void *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      PnvChipClass *k =3D PNV_CHIP_CLASS(klass);
> =20
> -    k->cpu_model =3D "power9_v1.0";
>      k->chip_type =3D PNV_CHIP_POWER9;
>      k->chip_cfam_id =3D 0x100d104980000000ull; /* P9 Nimbus DD1.0 */
>      k->cores_mask =3D POWER9_CORE_MASK;
> @@ -854,7 +858,7 @@ static void pnv_chip_init(Object *obj)
>  static void pnv_chip_icp_realize(PnvChip *chip, Error **errp)
>  {
>      PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
> -    char *typename =3D pnv_core_typename(pcc->cpu_model);
> +    const char *typename =3D pvn_chip_core_typename(chip);
>      size_t typesize =3D object_type_get_instance_size(typename);
>      int i, j;
>      char *name;
> @@ -879,8 +883,6 @@ static void pnv_chip_icp_realize(PnvChip *chip, Err=
or **errp)
>              memory_region_add_subregion(&chip->icp_mmio, pir << 12, &i=
cp->mmio);
>          }
>      }
> -
> -    g_free(typename);
>  }
> =20
>  static void pnv_chip_realize(DeviceState *dev, Error **errp)
> @@ -888,7 +890,7 @@ static void pnv_chip_realize(DeviceState *dev, Erro=
r **errp)
>      PnvChip *chip =3D PNV_CHIP(dev);
>      Error *error =3D NULL;
>      PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
> -    char *typename =3D pnv_core_typename(pcc->cpu_model);
> +    const char *typename =3D pvn_chip_core_typename(chip);
>      size_t typesize =3D object_type_get_instance_size(typename);
>      int i, core_hwid;
> =20
> @@ -947,7 +949,6 @@ static void pnv_chip_realize(DeviceState *dev, Erro=
r **errp)
>                                  &PNV_CORE(pnv_core)->xscom_regs);
>          i++;
>      }
> -    g_free(typename);
> =20
>      /* Create LPC controller */
>      object_property_set_bool(OBJECT(&chip->lpc), true, "realized",
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 000c87e..621b69e 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -246,9 +246,4 @@ static const TypeInfo pnv_core_infos[] =3D {
>      DEFINE_PNV_CORE_TYPE("power9_v1.0"),
>  };
> =20
> -char *pnv_core_typename(const char *model)
> -{
> -    return g_strdup_printf(PNV_CORE_TYPE_NAME("%s"), model);
> -}
> -
>  DEFINE_TYPES(pnv_core_infos)
>=20
