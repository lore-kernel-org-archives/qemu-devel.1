Received: from eggs.gnu.org ([2001:4830:134:3::10]:35691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQS6N-0002G3-1z
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 02:39:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQS6J-0003EQ-Ps
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 02:39:23 -0400
Date: Wed, 6 Jun 2018 16:39:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180606063910.GK17757@umbus.fritz.box>
References: <20180530100754.15833-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VSVNCtZB1QZ8vhj+"
Content-Disposition: inline
In-Reply-To: <20180530100754.15833-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2] pnv: add a physical mapping array
 describing MMIO ranges in each chip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>


--VSVNCtZB1QZ8vhj+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 30, 2018 at 12:07:54PM +0200, C=E9dric Le Goater wrote:
> Based on previous work done in skiboot, the physical mapping array
> helps in calculating the MMIO ranges of each controller depending on
> the chip id and the chip type. This is will be particularly useful for
> the P9 models which use less the XSCOM bus and rely more on MMIOs.
>=20
> A link on the chip is now necessary to calculate MMIO BARs and
> sizes. This is why such a link is introduced in the PSIHB model.

I think this message needs some work.  This says what it's for, but
what actually *is* this array, and how does it work?

The outside-core differences between POWER8 and POWER9 are substantial
enough that I'm wondering if pnvP8 and pnvP9 would be better off as
different machine types (sharing some routines, of course).

> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>=20
>  Changes since v1:
>=20
>  - removed PNV_MAP_MAX which has unused
>  - introduced a chip class handler to calculate the base address of a
>    controller as suggested by Greg.
>  - fix error reporting in pnv_psi_realize()
>=20
>  include/hw/ppc/pnv.h | 51 ++++++++++++++++++++++++++++++++++------------=
----
>  hw/ppc/pnv.c         | 53 ++++++++++++++++++++++++++++++++++++++++++++--=
------
>  hw/ppc/pnv_psi.c     | 15 ++++++++++++---
>  hw/ppc/pnv_xscom.c   |  8 ++++----
>  4 files changed, 96 insertions(+), 31 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 90759240a7b1..ffa4a0899705 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -53,7 +53,6 @@ typedef struct PnvChip {
>      uint64_t     cores_mask;
>      void         *cores;
> =20
> -    hwaddr       xscom_base;
>      MemoryRegion xscom_mmio;
>      MemoryRegion xscom;
>      AddressSpace xscom_as;
> @@ -64,6 +63,18 @@ typedef struct PnvChip {
>      PnvOCC       occ;
>  } PnvChip;
> =20
> +typedef enum PnvPhysMapType {
> +    PNV_MAP_XSCOM,
> +    PNV_MAP_ICP,
> +    PNV_MAP_PSIHB,
> +    PNV_MAP_PSIHB_FSP,
> +} PnvPhysMapType;
> +
> +typedef struct PnvPhysMapEntry {
> +    uint64_t        base;
> +    uint64_t        size;
> +} PnvPhysMapEntry;
> +
>  typedef struct PnvChipClass {
>      /*< private >*/
>      SysBusDeviceClass parent_class;
> @@ -73,9 +84,10 @@ typedef struct PnvChipClass {
>      uint64_t     chip_cfam_id;
>      uint64_t     cores_mask;
> =20
> -    hwaddr       xscom_base;
> +    const PnvPhysMapEntry *phys_map;
> =20
>      uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);
> +    uint64_t (*map_base)(const PnvChip *chip, PnvPhysMapType type);
>  } PnvChipClass;
> =20
>  #define PNV_CHIP_TYPE_SUFFIX "-" TYPE_PNV_CHIP
> @@ -159,9 +171,21 @@ void pnv_bmc_powerdown(IPMIBmc *bmc);
>  /*
>   * POWER8 MMIO base addresses
>   */
> -#define PNV_XSCOM_SIZE        0x800000000ull
> -#define PNV_XSCOM_BASE(chip)                                            \
> -    (chip->xscom_base + ((uint64_t)(chip)->chip_id) * PNV_XSCOM_SIZE)
> +static inline uint64_t pnv_map_size(const PnvChip *chip, PnvPhysMapType =
type)
> +{
> +    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
> +    const PnvPhysMapEntry *map =3D &pcc->phys_map[type];
> +
> +    return map->size;
> +}
> +
> +static inline uint64_t pnv_map_base(const PnvChip *chip, PnvPhysMapType =
type)
> +{
> +    return PNV_CHIP_GET_CLASS(chip)->map_base(chip, type);
> +}
> +
> +#define PNV_XSCOM_SIZE(chip)         pnv_map_size(chip, PNV_MAP_XSCOM)
> +#define PNV_XSCOM_BASE(chip)         pnv_map_base(chip, PNV_MAP_XSCOM)
> =20
>  /*
>   * XSCOM 0x20109CA defines the ICP BAR:
> @@ -177,18 +201,13 @@ void pnv_bmc_powerdown(IPMIBmc *bmc);
>   *      0xffffe02200000000 -> 0x0003ffff80800000
>   *      0xffffe02600000000 -> 0x0003ffff80900000
>   */
> -#define PNV_ICP_SIZE         0x0000000000100000ull
> -#define PNV_ICP_BASE(chip)                                              \
> -    (0x0003ffff80000000ull + (uint64_t) PNV_CHIP_INDEX(chip) * PNV_ICP_S=
IZE)
> -
> +#define PNV_ICP_SIZE(chip)           pnv_map_size(chip, PNV_MAP_ICP)
> +#define PNV_ICP_BASE(chip)           pnv_map_base(chip, PNV_MAP_ICP)
> =20
> -#define PNV_PSIHB_SIZE       0x0000000000100000ull
> -#define PNV_PSIHB_BASE(chip) \
> -    (0x0003fffe80000000ull + (uint64_t)PNV_CHIP_INDEX(chip) * PNV_PSIHB_=
SIZE)
> +#define PNV_PSIHB_SIZE(chip)         pnv_map_size(chip, PNV_MAP_PSIHB)
> +#define PNV_PSIHB_BASE(chip)         pnv_map_base(chip, PNV_MAP_PSIHB)
> =20
> -#define PNV_PSIHB_FSP_SIZE   0x0000000100000000ull
> -#define PNV_PSIHB_FSP_BASE(chip) \
> -    (0x0003ffe000000000ull + (uint64_t)PNV_CHIP_INDEX(chip) * \
> -     PNV_PSIHB_FSP_SIZE)
> +#define PNV_PSIHB_FSP_SIZE(chip)     pnv_map_size(chip, PNV_MAP_PSIHB_FS=
P)
> +#define PNV_PSIHB_FSP_BASE(chip)     pnv_map_base(chip, PNV_MAP_PSIHB_FS=
P)
> =20
>  #endif /* _PPC_PNV_H */
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 031488131629..77caaea64b2f 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -712,6 +712,24 @@ static uint32_t pnv_chip_core_pir_p9(PnvChip *chip, =
uint32_t core_id)
>   */
>  #define POWER9_CORE_MASK   (0xffffffffffffffull)
> =20
> +/*
> + * POWER8 MMIOs
> + */
> +static const PnvPhysMapEntry pnv_chip_power8_phys_map[] =3D {
> +    [PNV_MAP_XSCOM]     =3D { 0x0003fc0000000000ull, 0x0000000800000000u=
ll },
> +    [PNV_MAP_ICP]       =3D { 0x0003ffff80000000ull, 0x0000000000100000u=
ll },
> +    [PNV_MAP_PSIHB]     =3D { 0x0003fffe80000000ull, 0x0000000000100000u=
ll },
> +    [PNV_MAP_PSIHB_FSP] =3D { 0x0003ffe000000000ull, 0x0000000100000000u=
ll },
> +};
> +
> +static uint64_t pnv_chip_map_base_p8(const PnvChip *chip, PnvPhysMapType=
 type)
> +{
> +    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
> +    const PnvPhysMapEntry *map =3D &pcc->phys_map[type];
> +
> +    return map->base + chip->chip_id * map->size;
> +}
> +
>  static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -721,7 +739,8 @@ static void pnv_chip_power8e_class_init(ObjectClass *=
klass, void *data)
>      k->chip_cfam_id =3D 0x221ef04980000000ull;  /* P8 Murano DD2.1 */
>      k->cores_mask =3D POWER8E_CORE_MASK;
>      k->core_pir =3D pnv_chip_core_pir_p8;
> -    k->xscom_base =3D 0x003fc0000000000ull;
> +    k->map_base =3D pnv_chip_map_base_p8;
> +    k->phys_map =3D pnv_chip_power8_phys_map;
>      dc->desc =3D "PowerNV Chip POWER8E";
>  }
> =20
> @@ -734,7 +753,8 @@ static void pnv_chip_power8_class_init(ObjectClass *k=
lass, void *data)
>      k->chip_cfam_id =3D 0x220ea04980000000ull; /* P8 Venice DD2.0 */
>      k->cores_mask =3D POWER8_CORE_MASK;
>      k->core_pir =3D pnv_chip_core_pir_p8;
> -    k->xscom_base =3D 0x003fc0000000000ull;
> +    k->map_base =3D pnv_chip_map_base_p8;
> +    k->phys_map =3D pnv_chip_power8_phys_map;
>      dc->desc =3D "PowerNV Chip POWER8";
>  }
> =20
> @@ -747,10 +767,27 @@ static void pnv_chip_power8nvl_class_init(ObjectCla=
ss *klass, void *data)
>      k->chip_cfam_id =3D 0x120d304980000000ull;  /* P8 Naples DD1.0 */
>      k->cores_mask =3D POWER8_CORE_MASK;
>      k->core_pir =3D pnv_chip_core_pir_p8;
> -    k->xscom_base =3D 0x003fc0000000000ull;
> +    k->map_base =3D pnv_chip_map_base_p8;
> +    k->phys_map =3D pnv_chip_power8_phys_map;
>      dc->desc =3D "PowerNV Chip POWER8NVL";
>  }
> =20
> +/*
> + * POWER9 MMIOs
> + */
> +static const PnvPhysMapEntry pnv_chip_power9_phys_map[] =3D {
> +    [PNV_MAP_XSCOM]     =3D { 0x000603fc00000000ull, 0x0000000400000000u=
ll },
> +};
> +
> +/* Each chip has a 4TB range for its MMIOs */
> +static uint64_t pnv_chip_map_base_p9(const PnvChip *chip, PnvPhysMapType=
 type)
> +{
> +    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
> +    const PnvPhysMapEntry *map =3D &pcc->phys_map[type];
> +
> +    return map->base + ((uint64_t) chip->chip_id << 42);
> +}
> +
>  static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -760,7 +797,8 @@ static void pnv_chip_power9_class_init(ObjectClass *k=
lass, void *data)
>      k->chip_cfam_id =3D 0x220d104900008000ull; /* P9 Nimbus DD2.0 */
>      k->cores_mask =3D POWER9_CORE_MASK;
>      k->core_pir =3D pnv_chip_core_pir_p9;
> -    k->xscom_base =3D 0x00603fc00000000ull;
> +    k->map_base =3D pnv_chip_map_base_p9;
> +    k->phys_map =3D pnv_chip_power9_phys_map;
>      dc->desc =3D "PowerNV Chip POWER9";
>  }
> =20
> @@ -797,15 +835,14 @@ static void pnv_chip_core_sanitize(PnvChip *chip, E=
rror **errp)
>  static void pnv_chip_init(Object *obj)
>  {
>      PnvChip *chip =3D PNV_CHIP(obj);
> -    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
> -
> -    chip->xscom_base =3D pcc->xscom_base;
> =20
>      object_initialize(&chip->lpc, sizeof(chip->lpc), TYPE_PNV_LPC);
>      object_property_add_child(obj, "lpc", OBJECT(&chip->lpc), NULL);
> =20
>      object_initialize(&chip->psi, sizeof(chip->psi), TYPE_PNV_PSI);
>      object_property_add_child(obj, "psi", OBJECT(&chip->psi), NULL);
> +    object_property_add_const_link(OBJECT(&chip->psi), "chip", obj,
> +                                   &error_abort);
>      object_property_add_const_link(OBJECT(&chip->psi), "xics",
>                                     OBJECT(qdev_get_machine()), &error_ab=
ort);
> =20
> @@ -829,7 +866,7 @@ static void pnv_chip_icp_realize(PnvChip *chip, Error=
 **errp)
>      XICSFabric *xi =3D XICS_FABRIC(qdev_get_machine());
> =20
>      name =3D g_strdup_printf("icp-%x", chip->chip_id);
> -    memory_region_init(&chip->icp_mmio, OBJECT(chip), name, PNV_ICP_SIZE=
);
> +    memory_region_init(&chip->icp_mmio, OBJECT(chip), name, PNV_ICP_SIZE=
(chip));
>      sysbus_init_mmio(SYS_BUS_DEVICE(chip), &chip->icp_mmio);
>      g_free(name);
> =20
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index 5b969127c303..882b5d4b9f99 100644
> --- a/hw/ppc/pnv_psi.c
> +++ b/hw/ppc/pnv_psi.c
> @@ -465,11 +465,20 @@ static void pnv_psi_realize(DeviceState *dev, Error=
 **errp)
>      Object *obj;
>      Error *err =3D NULL;
>      unsigned int i;
> +    PnvChip *chip;
> +
> +    obj =3D object_property_get_link(OBJECT(dev), "chip", &err);
> +    if (!obj) {
> +        error_propagate(errp, err);
> +        error_prepend(errp, "required link 'chip' not found: ");
> +        return;
> +    }
> +    chip =3D PNV_CHIP(obj);
> =20
>      obj =3D object_property_get_link(OBJECT(dev), "xics", &err);
>      if (!obj) {
> -        error_setg(errp, "%s: required link 'xics' not found: %s",
> -                   __func__, error_get_pretty(err));
> +        error_propagate(errp, err);
> +        error_prepend(errp, "required link 'xics' not found: ");
>          return;
>      }
> =20
> @@ -497,7 +506,7 @@ static void pnv_psi_realize(DeviceState *dev, Error *=
*errp)
> =20
>      /* Initialize MMIO region */
>      memory_region_init_io(&psi->regs_mr, OBJECT(dev), &psi_mmio_ops, psi,
> -                          "psihb", PNV_PSIHB_SIZE);
> +                          "psihb", PNV_PSIHB_SIZE(chip));
> =20
>      /* Default BAR for MMIO region */
>      pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
> diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> index 46fae41f32b0..20ffc233174c 100644
> --- a/hw/ppc/pnv_xscom.c
> +++ b/hw/ppc/pnv_xscom.c
> @@ -50,7 +50,7 @@ static void xscom_complete(CPUState *cs, uint64_t hmer_=
bits)
> =20
>  static uint32_t pnv_xscom_pcba(PnvChip *chip, uint64_t addr)
>  {
> -    addr &=3D (PNV_XSCOM_SIZE - 1);
> +    addr &=3D (PNV_XSCOM_SIZE(chip) - 1);
> =20
>      if (pnv_chip_is_power9(chip)) {
>          return addr >> 3;
> @@ -179,10 +179,10 @@ void pnv_xscom_realize(PnvChip *chip, Error **errp)
> =20
>      name =3D g_strdup_printf("xscom-%x", chip->chip_id);
>      memory_region_init_io(&chip->xscom_mmio, OBJECT(chip), &pnv_xscom_op=
s,
> -                          chip, name, PNV_XSCOM_SIZE);
> +                          chip, name, PNV_XSCOM_SIZE(chip));
>      sysbus_init_mmio(sbd, &chip->xscom_mmio);
> =20
> -    memory_region_init(&chip->xscom, OBJECT(chip), name, PNV_XSCOM_SIZE);
> +    memory_region_init(&chip->xscom, OBJECT(chip), name, PNV_XSCOM_SIZE(=
chip));
>      address_space_init(&chip->xscom_as, &chip->xscom, name);
>      g_free(name);
>  }
> @@ -225,7 +225,7 @@ static const char compat_p9[] =3D "ibm,power9-xscom\0=
ibm,xscom";
>  int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset)
>  {
>      uint64_t reg[] =3D { cpu_to_be64(PNV_XSCOM_BASE(chip)),
> -                       cpu_to_be64(PNV_XSCOM_SIZE) };
> +                       cpu_to_be64(PNV_XSCOM_SIZE(chip)) };
>      int xscom_offset;
>      ForeachPopulateArgs args;
>      char *name;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VSVNCtZB1QZ8vhj+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsXgY4ACgkQbDjKyiDZ
s5Km+A/9Hmph7n2ghSnFVkr2s1WcBrzWgVS1yeDsAI6/xXzYvuTTOZHaM9qWYN4w
cnRVLSZS01HVFXwNhHeKV1wz4nNK3yDryLSs1Wlg4DXDWs5pPKs6uzrIICmu0Hg8
xiWX+iIRIG16oabVD+YwAbZ9RWTv6BoNU2sQYy6yd1potdsRvpBWGUJ4In7LepTS
viEkU4ADGpfskUdcpqsd/Oaf9ehhMsdY8Fo9VCKJH55PZ8xFqet0xBNvDXo2vjgV
jSS9JW6j+m/oUfcdcF4q/ed85Cj7xHcwJqY3glUUX5lv7dbiDetyTkHJQruVs2S3
Oe+pdFOo1+4IcFNxsQ1BJpCQ2B9BVm09yubdUZCxObg1s8OoZvsxSl4g5Hhqre0W
g4BLjCVs6pX3of7fS5q53+iiI1gVbaUzKHd/t0WqKOS5qOo8refIwK13t5UIa+K5
cy673qLfchRBlur4yMUzb0CW6XnMdapp67upL1IwmnG50NEe4tSh6vDcUzrdv9WF
7FfJ5kgQNXXs8w3P5ImJb4h9xKYFfeYpMOq9S9R4DwgOXgrtISaS1IMmOUG3yrKp
oVchhpTUuy2oB0a8cCr8A+1JdfjruDZASsr8XG0dU7FexrC5ilMx4Vq2it9O3Usu
oyyaeM5EBpRn13XTZRzK+TFqLmlbgcJ128s3Bm4R8iHaC79J4NI=
=fAQ7
-----END PGP SIGNATURE-----

--VSVNCtZB1QZ8vhj+--
