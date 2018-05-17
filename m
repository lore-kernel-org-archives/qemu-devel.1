Received: from eggs.gnu.org ([2001:4830:134:3::10]:52085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJJLh-0008Ai-Qf
	for qemu-devel@nongnu.org; Thu, 17 May 2018 09:53:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJJLc-0001v4-2y
	for qemu-devel@nongnu.org; Thu, 17 May 2018 09:53:41 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180517131814.26679-1-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <80c1c67d-5597-3b73-8bbc-64450abfa115@amsat.org>
Date: Thu, 17 May 2018 10:53:29 -0300
MIME-Version: 1.0
In-Reply-To: <20180517131814.26679-1-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Hi Cédric,

On 05/17/2018 10:18 AM, Cédric Le Goater wrote:
> Based on previous work done in skiboot, the physical mapping array
> helps in calculating the MMIO ranges of each controller depending on
> the chip id and the chip type. This is will be particularly useful for
> the P9 models which use less the XSCOM bus and rely more on MMIOs.
> 
> A link on the chip is now necessary to calculate MMIO BARs and
> sizes. This is why such a link is introduced in the PSIHB model.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/pnv.c         | 32 +++++++++++++++++++++--------
>  hw/ppc/pnv_psi.c     | 11 +++++++++-
>  hw/ppc/pnv_xscom.c   |  8 ++++----
>  include/hw/ppc/pnv.h | 58 +++++++++++++++++++++++++++++++++++++---------------

I recommend you to use the scripts/git.orderfile to make this review easier.

>  4 files changed, 80 insertions(+), 29 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 031488131629..330bf6f74810 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -712,6 +712,16 @@ static uint32_t pnv_chip_core_pir_p9(PnvChip *chip, uint32_t core_id)
>   */
>  #define POWER9_CORE_MASK   (0xffffffffffffffull)
>  
> +/*
> + * POWER8 MMIOs
> + */
> +static const PnvPhysMapEntry pnv_chip_power8_phys_map[] = {
> +    [PNV_MAP_XSCOM]     = { 0x0003fc0000000000ull, 0x0000000800000000ull },
> +    [PNV_MAP_ICP]       = { 0x0003ffff80000000ull, 0x0000000000100000ull },
> +    [PNV_MAP_PSIHB]     = { 0x0003fffe80000000ull, 0x0000000000100000ull },
> +    [PNV_MAP_PSIHB_FSP] = { 0x0003ffe000000000ull, 0x0000000100000000ull },
> +};
> +
>  static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -721,7 +731,7 @@ static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
>      k->chip_cfam_id = 0x221ef04980000000ull;  /* P8 Murano DD2.1 */
>      k->cores_mask = POWER8E_CORE_MASK;
>      k->core_pir = pnv_chip_core_pir_p8;
> -    k->xscom_base = 0x003fc0000000000ull;
> +    k->phys_map = pnv_chip_power8_phys_map;
>      dc->desc = "PowerNV Chip POWER8E";
>  }
>  
> @@ -734,7 +744,7 @@ static void pnv_chip_power8_class_init(ObjectClass *klass, void *data)
>      k->chip_cfam_id = 0x220ea04980000000ull; /* P8 Venice DD2.0 */
>      k->cores_mask = POWER8_CORE_MASK;
>      k->core_pir = pnv_chip_core_pir_p8;
> -    k->xscom_base = 0x003fc0000000000ull;
> +    k->phys_map = pnv_chip_power8_phys_map;
>      dc->desc = "PowerNV Chip POWER8";
>  }
>  
> @@ -747,10 +757,17 @@ static void pnv_chip_power8nvl_class_init(ObjectClass *klass, void *data)
>      k->chip_cfam_id = 0x120d304980000000ull;  /* P8 Naples DD1.0 */
>      k->cores_mask = POWER8_CORE_MASK;
>      k->core_pir = pnv_chip_core_pir_p8;
> -    k->xscom_base = 0x003fc0000000000ull;
> +    k->phys_map = pnv_chip_power8_phys_map;
>      dc->desc = "PowerNV Chip POWER8NVL";
>  }
>  
> +/*
> + * POWER9 MMIOs
> + */
> +static const PnvPhysMapEntry pnv_chip_power9_phys_map[] = {
> +    [PNV_MAP_XSCOM]     = { 0x000603fc00000000ull, 0x0000040000000000ull },
> +};
> +
>  static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -760,7 +777,7 @@ static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
>      k->chip_cfam_id = 0x220d104900008000ull; /* P9 Nimbus DD2.0 */
>      k->cores_mask = POWER9_CORE_MASK;
>      k->core_pir = pnv_chip_core_pir_p9;
> -    k->xscom_base = 0x00603fc00000000ull;
> +    k->phys_map = pnv_chip_power9_phys_map;
>      dc->desc = "PowerNV Chip POWER9";
>  }
>  
> @@ -797,15 +814,14 @@ static void pnv_chip_core_sanitize(PnvChip *chip, Error **errp)
>  static void pnv_chip_init(Object *obj)
>  {
>      PnvChip *chip = PNV_CHIP(obj);
> -    PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
> -
> -    chip->xscom_base = pcc->xscom_base;
>  
>      object_initialize(&chip->lpc, sizeof(chip->lpc), TYPE_PNV_LPC);
>      object_property_add_child(obj, "lpc", OBJECT(&chip->lpc), NULL);
>  
>      object_initialize(&chip->psi, sizeof(chip->psi), TYPE_PNV_PSI);
>      object_property_add_child(obj, "psi", OBJECT(&chip->psi), NULL);
> +    object_property_add_const_link(OBJECT(&chip->psi), "chip", obj,
> +                                   &error_abort);
>      object_property_add_const_link(OBJECT(&chip->psi), "xics",
>                                     OBJECT(qdev_get_machine()), &error_abort);
>  
> @@ -829,7 +845,7 @@ static void pnv_chip_icp_realize(PnvChip *chip, Error **errp)
>      XICSFabric *xi = XICS_FABRIC(qdev_get_machine());
>  
>      name = g_strdup_printf("icp-%x", chip->chip_id);
> -    memory_region_init(&chip->icp_mmio, OBJECT(chip), name, PNV_ICP_SIZE);
> +    memory_region_init(&chip->icp_mmio, OBJECT(chip), name, PNV_ICP_SIZE(chip));
>      sysbus_init_mmio(SYS_BUS_DEVICE(chip), &chip->icp_mmio);
>      g_free(name);
>  
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index 5b969127c303..dd7707b971c9 100644
> --- a/hw/ppc/pnv_psi.c
> +++ b/hw/ppc/pnv_psi.c
> @@ -465,6 +465,15 @@ static void pnv_psi_realize(DeviceState *dev, Error **errp)
>      Object *obj;
>      Error *err = NULL;
>      unsigned int i;
> +    PnvChip *chip;
> +
> +    obj = object_property_get_link(OBJECT(dev), "chip", &err);
> +    if (!obj) {
> +        error_setg(errp, "%s: required link 'chip' not found: %s",
> +                   __func__, error_get_pretty(err));
> +        return;
> +    }
> +    chip = PNV_CHIP(obj);
>  
>      obj = object_property_get_link(OBJECT(dev), "xics", &err);
>      if (!obj) {
> @@ -497,7 +506,7 @@ static void pnv_psi_realize(DeviceState *dev, Error **errp)
>  
>      /* Initialize MMIO region */
>      memory_region_init_io(&psi->regs_mr, OBJECT(dev), &psi_mmio_ops, psi,
> -                          "psihb", PNV_PSIHB_SIZE);
> +                          "psihb", PNV_PSIHB_SIZE(chip));
>  
>      /* Default BAR for MMIO region */
>      pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
> diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> index 46fae41f32b0..20ffc233174c 100644
> --- a/hw/ppc/pnv_xscom.c
> +++ b/hw/ppc/pnv_xscom.c
> @@ -50,7 +50,7 @@ static void xscom_complete(CPUState *cs, uint64_t hmer_bits)
>  
>  static uint32_t pnv_xscom_pcba(PnvChip *chip, uint64_t addr)
>  {
> -    addr &= (PNV_XSCOM_SIZE - 1);
> +    addr &= (PNV_XSCOM_SIZE(chip) - 1);
>  
>      if (pnv_chip_is_power9(chip)) {
>          return addr >> 3;
> @@ -179,10 +179,10 @@ void pnv_xscom_realize(PnvChip *chip, Error **errp)
>  
>      name = g_strdup_printf("xscom-%x", chip->chip_id);
>      memory_region_init_io(&chip->xscom_mmio, OBJECT(chip), &pnv_xscom_ops,
> -                          chip, name, PNV_XSCOM_SIZE);
> +                          chip, name, PNV_XSCOM_SIZE(chip));
>      sysbus_init_mmio(sbd, &chip->xscom_mmio);
>  
> -    memory_region_init(&chip->xscom, OBJECT(chip), name, PNV_XSCOM_SIZE);
> +    memory_region_init(&chip->xscom, OBJECT(chip), name, PNV_XSCOM_SIZE(chip));
>      address_space_init(&chip->xscom_as, &chip->xscom, name);
>      g_free(name);
>  }
> @@ -225,7 +225,7 @@ static const char compat_p9[] = "ibm,power9-xscom\0ibm,xscom";
>  int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset)
>  {
>      uint64_t reg[] = { cpu_to_be64(PNV_XSCOM_BASE(chip)),
> -                       cpu_to_be64(PNV_XSCOM_SIZE) };
> +                       cpu_to_be64(PNV_XSCOM_SIZE(chip)) };
>      int xscom_offset;
>      ForeachPopulateArgs args;
>      char *name;
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 90759240a7b1..b810e7b84ec0 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -53,7 +53,6 @@ typedef struct PnvChip {
>      uint64_t     cores_mask;
>      void         *cores;
>  
> -    hwaddr       xscom_base;
>      MemoryRegion xscom_mmio;
>      MemoryRegion xscom;
>      AddressSpace xscom_as;
> @@ -64,6 +63,19 @@ typedef struct PnvChip {
>      PnvOCC       occ;
>  } PnvChip;
>  
> +typedef enum PnvPhysMapType {
> +    PNV_MAP_XSCOM,
> +    PNV_MAP_ICP,
> +    PNV_MAP_PSIHB,
> +    PNV_MAP_PSIHB_FSP,
> +    PNV_MAP_MAX,

If you define PNV_MAP_MAX you need to add a check for 'type <
PNV_MAP_MAX' in pnv_map_size() and pnv_map_base().
Since you don't use it, it is simpler to just remove it.

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
> @@ -73,7 +85,7 @@ typedef struct PnvChipClass {
>      uint64_t     chip_cfam_id;
>      uint64_t     cores_mask;
>  
> -    hwaddr       xscom_base;
> +    const PnvPhysMapEntry *phys_map;
>  
>      uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);
>  } PnvChipClass;
> @@ -159,9 +171,28 @@ void pnv_bmc_powerdown(IPMIBmc *bmc);
>  /*
>   * POWER8 MMIO base addresses
>   */
> -#define PNV_XSCOM_SIZE        0x800000000ull
> -#define PNV_XSCOM_BASE(chip)                                            \
> -    (chip->xscom_base + ((uint64_t)(chip)->chip_id) * PNV_XSCOM_SIZE)
> +static inline uint64_t pnv_map_size(const PnvChip *chip, PnvPhysMapType type)
> +{
> +    PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
> +    const PnvPhysMapEntry *map = &pcc->phys_map[type];
> +
> +    return map->size;
> +}
> +
> +static inline uint64_t pnv_map_base(const PnvChip *chip, PnvPhysMapType type)
> +{
> +    PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
> +    const PnvPhysMapEntry *map = &pcc->phys_map[type];
> +
> +    if (pnv_chip_is_power9(chip)) {
> +        return map->base + ((uint64_t) chip->chip_id << 42);
> +    } else  {
> +        return map->base + chip->chip_id * map->size;
> +    }
> +}
> +
> +#define PNV_XSCOM_SIZE(chip)         pnv_map_size(chip, PNV_MAP_XSCOM)
> +#define PNV_XSCOM_BASE(chip)         pnv_map_base(chip, PNV_MAP_XSCOM)
>  
>  /*
>   * XSCOM 0x20109CA defines the ICP BAR:
> @@ -177,18 +208,13 @@ void pnv_bmc_powerdown(IPMIBmc *bmc);
>   *      0xffffe02200000000 -> 0x0003ffff80800000
>   *      0xffffe02600000000 -> 0x0003ffff80900000
>   */
> -#define PNV_ICP_SIZE         0x0000000000100000ull
> -#define PNV_ICP_BASE(chip)                                              \
> -    (0x0003ffff80000000ull + (uint64_t) PNV_CHIP_INDEX(chip) * PNV_ICP_SIZE)
> -
> +#define PNV_ICP_SIZE(chip)           pnv_map_size(chip, PNV_MAP_ICP)
> +#define PNV_ICP_BASE(chip)           pnv_map_base(chip, PNV_MAP_ICP)
>  
> -#define PNV_PSIHB_SIZE       0x0000000000100000ull
> -#define PNV_PSIHB_BASE(chip) \
> -    (0x0003fffe80000000ull + (uint64_t)PNV_CHIP_INDEX(chip) * PNV_PSIHB_SIZE)
> +#define PNV_PSIHB_SIZE(chip)         pnv_map_size(chip, PNV_MAP_PSIHB)
> +#define PNV_PSIHB_BASE(chip)         pnv_map_base(chip, PNV_MAP_PSIHB)
>  
> -#define PNV_PSIHB_FSP_SIZE   0x0000000100000000ull
> -#define PNV_PSIHB_FSP_BASE(chip) \
> -    (0x0003ffe000000000ull + (uint64_t)PNV_CHIP_INDEX(chip) * \
> -     PNV_PSIHB_FSP_SIZE)
> +#define PNV_PSIHB_FSP_SIZE(chip)     pnv_map_size(chip, PNV_MAP_PSIHB_FSP)
> +#define PNV_PSIHB_FSP_BASE(chip)     pnv_map_base(chip, PNV_MAP_PSIHB_FSP)

Those macros are now not very helpful, maybe a following cleanup can
remove them and use directly pnv_map_base/size() in place.

>  
>  #endif /* _PPC_PNV_H */
> 

Removing PNV_MAP_MAX:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Regards,

Phil.
