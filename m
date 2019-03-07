Received: from eggs.gnu.org ([209.51.188.92]:38011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1nkd-00074j-BG
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:47:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1nkc-00029q-7l
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:47:35 -0500
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:36332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h1nkb-00023a-Vs
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:47:34 -0500
Received: from player691.ha.ovh.net (unknown [10.109.160.54])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id E2DEE18A5A9
	for <qemu-devel@nongnu.org>; Thu,  7 Mar 2019 08:47:22 +0100 (CET)
References: <20190306085032.15744-1-clg@kaod.org>
	<20190306085032.15744-22-clg@kaod.org>
	<20190307042752.GN7722@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d6032e0f-9dd6-83a2-3ae4-f69f97987572@kaod.org>
Date: Thu, 7 Mar 2019 08:47:19 +0100
MIME-Version: 1.0
In-Reply-To: <20190307042752.GN7722@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 21/27] ppc/pnv: add a OCC model for POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 3/7/19 5:27 AM, David Gibson wrote:
> On Wed, Mar 06, 2019 at 09:50:26AM +0100, C=E9dric Le Goater wrote:
>> The OCC on POWER9 is very similar to the one found on POWER8. Provide
>> the same routines with P9 values for the registers and IRQ number.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/pnv.h       |  1 +
>>  include/hw/ppc/pnv_occ.h   |  4 ++++
>>  include/hw/ppc/pnv_xscom.h |  3 +++
>>  hw/ppc/pnv.c               | 13 +++++++++++++
>>  hw/ppc/pnv_occ.c           | 40 +++++++++++++++++++++++++++++++++++++=
+
>>  5 files changed, 61 insertions(+)
>>
>> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
>> index 2d68aabc212f..ad3bf0690ecf 100644
>> --- a/include/hw/ppc/pnv.h
>> +++ b/include/hw/ppc/pnv.h
>> @@ -86,6 +86,7 @@ typedef struct Pnv9Chip {
>>      PnvXive      xive;
>>      PnvPsi       psi;
>>      PnvLpcController lpc;
>> +    PnvOCC       occ;
>>  } Pnv9Chip;
>> =20
>>  typedef struct PnvChipClass {
>> diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
>> index ce2631e21f5e..8951eb7ea316 100644
>> --- a/include/hw/ppc/pnv_occ.h
>> +++ b/include/hw/ppc/pnv_occ.h
>> @@ -27,6 +27,10 @@
>>  #define PNV8_OCC(obj) \
>>      OBJECT_CHECK(PnvOCC, (obj), TYPE_PNV8_OCC)
>> =20
>> +#define TYPE_PNV9_OCC TYPE_PNV_OCC "-POWER9"
>> +#define PNV9_OCC(obj) \
>> +    OBJECT_CHECK(PnvOCC, (obj), TYPE_PNV9_OCC)
>> +
>>  typedef struct PnvOCC {
>>      DeviceState xd;
>> =20
>> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
>> index 403a365ed274..3292459fbb78 100644
>> --- a/include/hw/ppc/pnv_xscom.h
>> +++ b/include/hw/ppc/pnv_xscom.h
>> @@ -73,6 +73,9 @@ typedef struct PnvXScomInterfaceClass {
>>  #define PNV_XSCOM_OCC_BASE        0x0066000
>>  #define PNV_XSCOM_OCC_SIZE        0x6000
>> =20
>> +#define PNV9_XSCOM_OCC_BASE       PNV_XSCOM_OCC_BASE
>> +#define PNV9_XSCOM_OCC_SIZE       0x8000
>> +
>>  #define PNV9_XSCOM_PSIHB_BASE     0x5012900
>>  #define PNV9_XSCOM_PSIHB_SIZE     0x100
>> =20
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 81ab53899dbc..a056064c8c11 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -968,6 +968,11 @@ static void pnv_chip_power9_instance_init(Object =
*obj)
>>                              TYPE_PNV9_LPC, &error_abort, NULL);
>>      object_property_add_const_link(OBJECT(&chip9->lpc), "psi",
>>                                     OBJECT(&chip9->psi), &error_abort)=
;
>> +
>> +    object_initialize_child(obj, "occ",  &chip9->occ, sizeof(chip9->o=
cc),
>> +                            TYPE_PNV9_OCC, &error_abort, NULL);
>> +    object_property_add_const_link(OBJECT(&chip9->occ), "psi",
>> +                                   OBJECT(&chip9->psi), &error_abort)=
;
>>  }
>> =20
>>  static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
>> @@ -1020,6 +1025,14 @@ static void pnv_chip_power9_realize(DeviceState=
 *dev, Error **errp)
>>      }
>>      memory_region_add_subregion(get_system_memory(), PNV9_LPCM_BASE(c=
hip),
>>                                  &chip9->lpc.xscom_regs);
>> +
>> +    /* Create the simplified OCC model */
>> +    object_property_set_bool(OBJECT(&chip9->occ), true, "realized", &=
local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
>> +    pnv_xscom_add_subregion(chip, PNV9_XSCOM_OCC_BASE, &chip9->occ.xs=
com_regs);
>>  }
>> =20
>>  static void pnv_chip_power9_class_init(ObjectClass *klass, void *data=
)
>> diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
>> index a210f44926aa..59b0702bc716 100644
>> --- a/hw/ppc/pnv_occ.c
>> +++ b/hw/ppc/pnv_occ.c
>> @@ -31,6 +31,10 @@
>>  #define OCB_OCI_OCCMISC_AND     0x4021
>>  #define OCB_OCI_OCCMISC_OR      0x4022
>> =20
>> +#define P9_OCB_OCI_OCCMISC              0x6080
>> +#define P9_OCB_OCI_OCCMISC_CLEAR        0x6081
>> +#define P9_OCB_OCI_OCCMISC_OR           0x6082
>> +
>>  static void pnv_occ_set_misc(PnvOCC *occ, uint64_t val)
>>  {
>>      bool irq_state;
>> @@ -42,6 +46,17 @@ static void pnv_occ_set_misc(PnvOCC *occ, uint64_t =
val)
>>      pnv_psi_irq_set(occ->psi, PSIHB_IRQ_OCC, irq_state);
>>  }
>> =20
>> +static void pnv_occ_p9_set_misc(PnvOCC *occ, uint64_t val)
>> +{
>> +    bool irq_state;
>> +
>> +    val &=3D 0xffff000000000000ull;
>> +
>> +    occ->occmisc =3D val;
>> +    irq_state =3D !!(val >> 63);
>> +    pnv_psi_irq_set(occ->psi, PSIHB9_IRQ_OCC, irq_state);
>> +}
>> +
>>  static uint64_t pnv_occ_xscom_read(void *opaque, hwaddr addr, unsigne=
d size)
>>  {
>>      PnvOCC *occ =3D PNV_OCC(opaque);
>> @@ -50,6 +65,7 @@ static uint64_t pnv_occ_xscom_read(void *opaque, hwa=
ddr addr, unsigned size)
>> =20
>>      switch (offset) {
>>      case OCB_OCI_OCCMISC:
>> +    case P9_OCB_OCI_OCCMISC:
>>          val =3D occ->occmisc;
>>          break;
>>      default:
>> @@ -75,6 +91,15 @@ static void pnv_occ_xscom_write(void *opaque, hwadd=
r addr,
>>      case OCB_OCI_OCCMISC:
>>          pnv_occ_set_misc(occ, val);
>>          break;
>> +    case P9_OCB_OCI_OCCMISC_CLEAR:
>> +        pnv_occ_p9_set_misc(occ, 0);
>> +        break;
>> +    case P9_OCB_OCI_OCCMISC_OR:
>> +        pnv_occ_p9_set_misc(occ, occ->occmisc | val);
>> +        break;
>> +    case P9_OCB_OCI_OCCMISC:
>> +        pnv_occ_p9_set_misc(occ, val);
>> +       break;
>=20
> Are the P9 OCC registers a strict superset of the P8 registers?

I haven't checked all OCC registers but from what skiboot uses, the answe=
r=20
is yes. But we can introduce a new ops for POWER9, it would be cleaner.=20

Thanks,

C.=20

>=20
>>      default:
>>          qemu_log_mask(LOG_UNIMP, "OCC Unimplemented register: Ox%"
>>                        HWADDR_PRIx "\n", addr >> 3);
>> @@ -115,6 +140,20 @@ static void pnv_occ_realize(DeviceState *dev, Err=
or **errp)
>>                    occ, "xscom-occ", poc->xscom_size);
>>  }
>> =20
>> +static void pnv_occ_power9_class_init(ObjectClass *klass, void *data)
>> +{
>> +    PnvOCCClass *poc =3D PNV_OCC_CLASS(klass);
>> +
>> +    poc->xscom_size =3D PNV9_XSCOM_OCC_SIZE;
>> +}
>> +
>> +static const TypeInfo pnv_occ_power9_type_info =3D {
>> +    .name          =3D TYPE_PNV9_OCC,
>> +    .parent        =3D TYPE_PNV_OCC,
>> +    .instance_size =3D sizeof(PnvOCC),
>> +    .class_init    =3D pnv_occ_power9_class_init,
>> +};
>> +
>>  static void pnv_occ_power8_class_init(ObjectClass *klass, void *data)
>>  {
>>      PnvOCCClass *poc =3D PNV_OCC_CLASS(klass);
>> @@ -148,6 +187,7 @@ static void pnv_occ_register_types(void)
>>  {
>>      type_register_static(&pnv_occ_type_info);
>>      type_register_static(&pnv_occ_power8_type_info);
>> +    type_register_static(&pnv_occ_power9_type_info);
>>  }
>> =20
>>  type_init(pnv_occ_register_types)
>=20
