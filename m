Received: from eggs.gnu.org ([2001:4830:134:3::10]:40540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fLUNa-0005wI-BK
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fLUNV-0002G2-De
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:04:38 -0400
Received: from 18.mo5.mail-out.ovh.net ([178.33.45.10]:60520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fLUNV-0002A0-55
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:04:33 -0400
Received: from player793.ha.ovh.net (unknown [10.109.108.119])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 2CDD81B2A51
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 16:04:23 +0200 (CEST)
Date: Wed, 23 May 2018 16:04:16 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180523160416.4ca6fff1@bahia.lan>
In-Reply-To: <f03083c9-d17b-1d32-ef3a-2d4df1dddfb4@kaod.org>
References: <20180517131814.26679-1-clg@kaod.org>
	<20180518110041.71464bf3@bahia.lan>
	<f03083c9-d17b-1d32-ef3a-2d4df1dddfb4@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] pnv: add a physical mapping array
 describing MMIO ranges in each chip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>

On Wed, 23 May 2018 14:37:30 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 05/18/2018 11:00 AM, Greg Kurz wrote:
> > On Thu, 17 May 2018 15:18:14 +0200
> > C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >  =20
> >> Based on previous work done in skiboot, the physical mapping array
> >> helps in calculating the MMIO ranges of each controller depending on
> >> the chip id and the chip type. This is will be particularly useful for
> >> the P9 models which use less the XSCOM bus and rely more on MMIOs.
> >>
> >> A link on the chip is now necessary to calculate MMIO BARs and
> >> sizes. This is why such a link is introduced in the PSIHB model.
> >>
> >> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >> ---
> >>  hw/ppc/pnv.c         | 32 +++++++++++++++++++++--------
> >>  hw/ppc/pnv_psi.c     | 11 +++++++++-
> >>  hw/ppc/pnv_xscom.c   |  8 ++++----
> >>  include/hw/ppc/pnv.h | 58 +++++++++++++++++++++++++++++++++++++------=
---------
> >>  4 files changed, 80 insertions(+), 29 deletions(-)
> >>
> >> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> >> index 031488131629..330bf6f74810 100644
> >> --- a/hw/ppc/pnv.c
> >> +++ b/hw/ppc/pnv.c
> >> @@ -712,6 +712,16 @@ static uint32_t pnv_chip_core_pir_p9(PnvChip *chi=
p, uint32_t core_id)
> >>   */
> >>  #define POWER9_CORE_MASK   (0xffffffffffffffull)
> >> =20
> >> +/*
> >> + * POWER8 MMIOs
> >> + */
> >> +static const PnvPhysMapEntry pnv_chip_power8_phys_map[] =3D {
> >> +    [PNV_MAP_XSCOM]     =3D { 0x0003fc0000000000ull, 0x00000008000000=
00ull },
> >> +    [PNV_MAP_ICP]       =3D { 0x0003ffff80000000ull, 0x00000000001000=
00ull },
> >> +    [PNV_MAP_PSIHB]     =3D { 0x0003fffe80000000ull, 0x00000000001000=
00ull },
> >> +    [PNV_MAP_PSIHB_FSP] =3D { 0x0003ffe000000000ull, 0x00000001000000=
00ull },
> >> +};
> >> +
> >>  static void pnv_chip_power8e_class_init(ObjectClass *klass, void *dat=
a)
> >>  {
> >>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> >> @@ -721,7 +731,7 @@ static void pnv_chip_power8e_class_init(ObjectClas=
s *klass, void *data)
> >>      k->chip_cfam_id =3D 0x221ef04980000000ull;  /* P8 Murano DD2.1 */
> >>      k->cores_mask =3D POWER8E_CORE_MASK;
> >>      k->core_pir =3D pnv_chip_core_pir_p8;
> >> -    k->xscom_base =3D 0x003fc0000000000ull;
> >> +    k->phys_map =3D pnv_chip_power8_phys_map;
> >>      dc->desc =3D "PowerNV Chip POWER8E";
> >>  }
> >> =20
> >> @@ -734,7 +744,7 @@ static void pnv_chip_power8_class_init(ObjectClass=
 *klass, void *data)
> >>      k->chip_cfam_id =3D 0x220ea04980000000ull; /* P8 Venice DD2.0 */
> >>      k->cores_mask =3D POWER8_CORE_MASK;
> >>      k->core_pir =3D pnv_chip_core_pir_p8;
> >> -    k->xscom_base =3D 0x003fc0000000000ull;
> >> +    k->phys_map =3D pnv_chip_power8_phys_map;
> >>      dc->desc =3D "PowerNV Chip POWER8";
> >>  }
> >> =20
> >> @@ -747,10 +757,17 @@ static void pnv_chip_power8nvl_class_init(Object=
Class *klass, void *data)
> >>      k->chip_cfam_id =3D 0x120d304980000000ull;  /* P8 Naples DD1.0 */
> >>      k->cores_mask =3D POWER8_CORE_MASK;
> >>      k->core_pir =3D pnv_chip_core_pir_p8;
> >> -    k->xscom_base =3D 0x003fc0000000000ull;
> >> +    k->phys_map =3D pnv_chip_power8_phys_map;
> >>      dc->desc =3D "PowerNV Chip POWER8NVL";
> >>  }
> >> =20
> >> +/*
> >> + * POWER9 MMIOs
> >> + */
> >> +static const PnvPhysMapEntry pnv_chip_power9_phys_map[] =3D {
> >> +    [PNV_MAP_XSCOM]     =3D { 0x000603fc00000000ull, 0x00000400000000=
00ull },
> >> +};
> >> +
> >>  static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
> >>  {
> >>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> >> @@ -760,7 +777,7 @@ static void pnv_chip_power9_class_init(ObjectClass=
 *klass, void *data)
> >>      k->chip_cfam_id =3D 0x220d104900008000ull; /* P9 Nimbus DD2.0 */
> >>      k->cores_mask =3D POWER9_CORE_MASK;
> >>      k->core_pir =3D pnv_chip_core_pir_p9;
> >> -    k->xscom_base =3D 0x00603fc00000000ull;
> >> +    k->phys_map =3D pnv_chip_power9_phys_map;
> >>      dc->desc =3D "PowerNV Chip POWER9";
> >>  }
> >> =20
> >> @@ -797,15 +814,14 @@ static void pnv_chip_core_sanitize(PnvChip *chip=
, Error **errp)
> >>  static void pnv_chip_init(Object *obj)
> >>  {
> >>      PnvChip *chip =3D PNV_CHIP(obj);
> >> -    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
> >> -
> >> -    chip->xscom_base =3D pcc->xscom_base;
> >> =20
> >>      object_initialize(&chip->lpc, sizeof(chip->lpc), TYPE_PNV_LPC);
> >>      object_property_add_child(obj, "lpc", OBJECT(&chip->lpc), NULL);
> >> =20
> >>      object_initialize(&chip->psi, sizeof(chip->psi), TYPE_PNV_PSI);
> >>      object_property_add_child(obj, "psi", OBJECT(&chip->psi), NULL);
> >> +    object_property_add_const_link(OBJECT(&chip->psi), "chip", obj,
> >> +                                   &error_abort);
> >>      object_property_add_const_link(OBJECT(&chip->psi), "xics",
> >>                                     OBJECT(qdev_get_machine()), &error=
_abort);
> >> =20
> >> @@ -829,7 +845,7 @@ static void pnv_chip_icp_realize(PnvChip *chip, Er=
ror **errp)
> >>      XICSFabric *xi =3D XICS_FABRIC(qdev_get_machine());
> >> =20
> >>      name =3D g_strdup_printf("icp-%x", chip->chip_id);
> >> -    memory_region_init(&chip->icp_mmio, OBJECT(chip), name, PNV_ICP_S=
IZE);
> >> +    memory_region_init(&chip->icp_mmio, OBJECT(chip), name, PNV_ICP_S=
IZE(chip));
> >>      sysbus_init_mmio(SYS_BUS_DEVICE(chip), &chip->icp_mmio);
> >>      g_free(name);
> >> =20
> >> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> >> index 5b969127c303..dd7707b971c9 100644
> >> --- a/hw/ppc/pnv_psi.c
> >> +++ b/hw/ppc/pnv_psi.c
> >> @@ -465,6 +465,15 @@ static void pnv_psi_realize(DeviceState *dev, Err=
or **errp)
> >>      Object *obj;
> >>      Error *err =3D NULL;
> >>      unsigned int i;
> >> +    PnvChip *chip;
> >> +
> >> +    obj =3D object_property_get_link(OBJECT(dev), "chip", &err);
> >> +    if (!obj) {
> >> +        error_setg(errp, "%s: required link 'chip' not found: %s",
> >> +                   __func__, error_get_pretty(err));
> >> +        return; =20
> >=20
> > err was dynamically allocated and must be freed with error_free(). =20
>=20
> ok. There are quite a few places not doing it right then.=20
>=20

Yeah, error_get_pretty users are the usual suspects here.

> > This being said, the link is supposed to have been set in pnv_chip_init=
()
> > already, so if we can't get it here, it's likely a bug in QEMU. I'd rat=
her
> > pass &error_abort. =20
>=20
> The followed pattern in pnv is most of the time :
>=20
>     object_property_add_const_link(OBJECT(&chip->bar), "foo", obj,
>                                    &error_abort);
>=20
> and in the realize function :=20
>=20
>     Error *local_err =3D NULL;
>   =20
>     obj =3D object_property_get_link(OBJECT(dev), "foo", &local_err);
>     if (!obj) {
>         error_setg(errp, "%s: required link 'foo' not found: %s",
>                    __func__, error_get_pretty(local_err));
>         return;
>     }
>=20
> but you propose that we should rather simply do :
>  =20
>     obj =3D object_property_get_link(OBJECT(dev), "foo", &error_abort);
>=20
> Correct ?=20
> =20

Yes, but this is questionable :)

The realize function has an Error ** arg, ie, it is expected to propagate
errors and let the caller decide... so it is a matter of taste here.

Another option to using error_get_pretty() is to use error_propagate() and
error_prepend(), as suggested in include/qapi/error.h .

See commit a1a6bbde4f6a29368f8f605cea2e73630ec1bc7c for an example.

> >> +    }
> >> +    chip =3D PNV_CHIP(obj);
> >> =20
> >>      obj =3D object_property_get_link(OBJECT(dev), "xics", &err);
> >>      if (!obj) {
> >> @@ -497,7 +506,7 @@ static void pnv_psi_realize(DeviceState *dev, Erro=
r **errp)
> >> =20
> >>      /* Initialize MMIO region */
> >>      memory_region_init_io(&psi->regs_mr, OBJECT(dev), &psi_mmio_ops, =
psi,
> >> -                          "psihb", PNV_PSIHB_SIZE);
> >> +                          "psihb", PNV_PSIHB_SIZE(chip));
> >> =20
> >>      /* Default BAR for MMIO region */
> >>      pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
> >> diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> >> index 46fae41f32b0..20ffc233174c 100644
> >> --- a/hw/ppc/pnv_xscom.c
> >> +++ b/hw/ppc/pnv_xscom.c
> >> @@ -50,7 +50,7 @@ static void xscom_complete(CPUState *cs, uint64_t hm=
er_bits)
> >> =20
> >>  static uint32_t pnv_xscom_pcba(PnvChip *chip, uint64_t addr)
> >>  {
> >> -    addr &=3D (PNV_XSCOM_SIZE - 1);
> >> +    addr &=3D (PNV_XSCOM_SIZE(chip) - 1);
> >> =20
> >>      if (pnv_chip_is_power9(chip)) {
> >>          return addr >> 3;
> >> @@ -179,10 +179,10 @@ void pnv_xscom_realize(PnvChip *chip, Error **er=
rp)
> >> =20
> >>      name =3D g_strdup_printf("xscom-%x", chip->chip_id);
> >>      memory_region_init_io(&chip->xscom_mmio, OBJECT(chip), &pnv_xscom=
_ops,
> >> -                          chip, name, PNV_XSCOM_SIZE);
> >> +                          chip, name, PNV_XSCOM_SIZE(chip));
> >>      sysbus_init_mmio(sbd, &chip->xscom_mmio);
> >> =20
> >> -    memory_region_init(&chip->xscom, OBJECT(chip), name, PNV_XSCOM_SI=
ZE);
> >> +    memory_region_init(&chip->xscom, OBJECT(chip), name, PNV_XSCOM_SI=
ZE(chip));
> >>      address_space_init(&chip->xscom_as, &chip->xscom, name);
> >>      g_free(name);
> >>  }
> >> @@ -225,7 +225,7 @@ static const char compat_p9[] =3D "ibm,power9-xsco=
m\0ibm,xscom";
> >>  int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset)
> >>  {
> >>      uint64_t reg[] =3D { cpu_to_be64(PNV_XSCOM_BASE(chip)),
> >> -                       cpu_to_be64(PNV_XSCOM_SIZE) };
> >> +                       cpu_to_be64(PNV_XSCOM_SIZE(chip)) };
> >>      int xscom_offset;
> >>      ForeachPopulateArgs args;
> >>      char *name;
> >> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> >> index 90759240a7b1..b810e7b84ec0 100644
> >> --- a/include/hw/ppc/pnv.h
> >> +++ b/include/hw/ppc/pnv.h
> >> @@ -53,7 +53,6 @@ typedef struct PnvChip {
> >>      uint64_t     cores_mask;
> >>      void         *cores;
> >> =20
> >> -    hwaddr       xscom_base;
> >>      MemoryRegion xscom_mmio;
> >>      MemoryRegion xscom;
> >>      AddressSpace xscom_as;
> >> @@ -64,6 +63,19 @@ typedef struct PnvChip {
> >>      PnvOCC       occ;
> >>  } PnvChip;
> >> =20
> >> +typedef enum PnvPhysMapType {
> >> +    PNV_MAP_XSCOM,
> >> +    PNV_MAP_ICP,
> >> +    PNV_MAP_PSIHB,
> >> +    PNV_MAP_PSIHB_FSP,
> >> +    PNV_MAP_MAX,
> >> +} PnvPhysMapType;
> >> +
> >> +typedef struct PnvPhysMapEntry {
> >> +    uint64_t        base;
> >> +    uint64_t        size;
> >> +} PnvPhysMapEntry;
> >> +
> >>  typedef struct PnvChipClass {
> >>      /*< private >*/
> >>      SysBusDeviceClass parent_class;
> >> @@ -73,7 +85,7 @@ typedef struct PnvChipClass {
> >>      uint64_t     chip_cfam_id;
> >>      uint64_t     cores_mask;
> >> =20
> >> -    hwaddr       xscom_base;
> >> +    const PnvPhysMapEntry *phys_map;
> >> =20
> >>      uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);
> >>  } PnvChipClass;
> >> @@ -159,9 +171,28 @@ void pnv_bmc_powerdown(IPMIBmc *bmc);
> >>  /*
> >>   * POWER8 MMIO base addresses
> >>   */
> >> -#define PNV_XSCOM_SIZE        0x800000000ull
> >> -#define PNV_XSCOM_BASE(chip)                                         =
   \
> >> -    (chip->xscom_base + ((uint64_t)(chip)->chip_id) * PNV_XSCOM_SIZE)
> >> +static inline uint64_t pnv_map_size(const PnvChip *chip, PnvPhysMapTy=
pe type)
> >> +{
> >> +    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
> >> +    const PnvPhysMapEntry *map =3D &pcc->phys_map[type];
> >> +
> >> +    return map->size;
> >> +}
> >> +
> >> +static inline uint64_t pnv_map_base(const PnvChip *chip, PnvPhysMapTy=
pe type)
> >> +{
> >> +    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
> >> +    const PnvPhysMapEntry *map =3D &pcc->phys_map[type];
> >> +
> >> +    if (pnv_chip_is_power9(chip)) {
> >> +        return map->base + ((uint64_t) chip->chip_id << 42); =20
> >=20
> > So this patch also changes the way the base address is computed
> > with POWER9. Shouldn't this go to a separate patch or at least
> > mention the functional change in the changelog ? =20
>=20
> P9 is not really supported, multi P9 chips even less. But yes, I can
> mention that the P9 MMIO base address is being fixed.=20
> =20
> > Also, shouldn't this be a PnvChipClass level function rather than
> > doing a runtime check ? =20
>=20
> Hmm. pnv_map_base() needs the 'chip_id' to calculate the base
> address which is not a class level attribute. The P9 check only=20
> needs the chip class but it is more convenient to use a PnvChip.=20
> Only class_init routines use class variables.=20

Not sure to understand... My suggestion was just to add a new function
attribute to PnvChipClass:

    uint64_t (*map_base)(const PnvChip *chip, PnvPhysMapType type);

And have two separate implementations for P8 and P9:

static uint64_t pnv_chip_map_base_p8(const PnvChip *chip,
                                     const PnvPhysMapEntry *map)
{
    return map->base + chip->chip_id * map->size;
}

static uint64_t pnv_chip_map_base_p9(const PnvChip *chip,
                                     const PnvPhysMapEntry *map)
{
    return map->base + ((uint64_t) chip->chip_id << 42);
}

And pnv_map_base() would be:

static inline uint64_t pnv_map_base(const PnvChip *chip, PnvPhysMapType typ=
e)
{
    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);

    return pcc->map_base(chip, &pcc->phys_map[type]);
}

> > The rest of the patch looks good. =20
>=20
> Thanks,
>=20
> C.=20
> =20
> >> +    } else  {
> >> +        return map->base + chip->chip_id * map->size;
> >> +    }
> >> +}
> >> +
> >> +#define PNV_XSCOM_SIZE(chip)         pnv_map_size(chip, PNV_MAP_XSCOM)
> >> +#define PNV_XSCOM_BASE(chip)         pnv_map_base(chip, PNV_MAP_XSCOM)
> >> =20
> >>  /*
> >>   * XSCOM 0x20109CA defines the ICP BAR:
> >> @@ -177,18 +208,13 @@ void pnv_bmc_powerdown(IPMIBmc *bmc);
> >>   *      0xffffe02200000000 -> 0x0003ffff80800000
> >>   *      0xffffe02600000000 -> 0x0003ffff80900000
> >>   */
> >> -#define PNV_ICP_SIZE         0x0000000000100000ull
> >> -#define PNV_ICP_BASE(chip)                                           =
   \
> >> -    (0x0003ffff80000000ull + (uint64_t) PNV_CHIP_INDEX(chip) * PNV_IC=
P_SIZE)
> >> -
> >> +#define PNV_ICP_SIZE(chip)           pnv_map_size(chip, PNV_MAP_ICP)
> >> +#define PNV_ICP_BASE(chip)           pnv_map_base(chip, PNV_MAP_ICP)
> >> =20
> >> -#define PNV_PSIHB_SIZE       0x0000000000100000ull
> >> -#define PNV_PSIHB_BASE(chip) \
> >> -    (0x0003fffe80000000ull + (uint64_t)PNV_CHIP_INDEX(chip) * PNV_PSI=
HB_SIZE)
> >> +#define PNV_PSIHB_SIZE(chip)         pnv_map_size(chip, PNV_MAP_PSIHB)
> >> +#define PNV_PSIHB_BASE(chip)         pnv_map_base(chip, PNV_MAP_PSIHB)
> >> =20
> >> -#define PNV_PSIHB_FSP_SIZE   0x0000000100000000ull
> >> -#define PNV_PSIHB_FSP_BASE(chip) \
> >> -    (0x0003ffe000000000ull + (uint64_t)PNV_CHIP_INDEX(chip) * \
> >> -     PNV_PSIHB_FSP_SIZE)
> >> +#define PNV_PSIHB_FSP_SIZE(chip)     pnv_map_size(chip, PNV_MAP_PSIHB=
_FSP)
> >> +#define PNV_PSIHB_FSP_BASE(chip)     pnv_map_base(chip, PNV_MAP_PSIHB=
_FSP)
> >> =20
> >>  #endif /* _PPC_PNV_H */ =20
> >  =20
>=20
