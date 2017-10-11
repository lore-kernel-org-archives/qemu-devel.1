Received: from eggs.gnu.org ([2001:4830:134:3::10]:44505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e2KjX-0007Ay-DK
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 13:23:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e2KjW-0003im-6n
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 13:23:51 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1507578671-158758-1-git-send-email-imammedo@redhat.com>
	<1507578671-158758-24-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cc201856-0592-ca57-a004-e591cd265d42@amsat.org>
Date: Wed, 11 Oct 2017 14:23:38 -0300
MIME-Version: 1.0
In-Reply-To: <1507578671-158758-24-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 23/24] ppc: pnv: drop
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
Cc: "open list:ppce500" <qemu-ppc@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

On 10/09/2017 04:51 PM, Igor Mammedov wrote:
> deduce core type directly from chip type instead of
> maintaining type mapping in PnvChipClass::cpu_model.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> v2:
>   - fix typo: s/pvn_chip_core_typename/pnv_chip_core_typename/
> ---
>  include/hw/ppc/pnv.h      |  1 -
>  include/hw/ppc/pnv_core.h |  1 -
>  hw/ppc/pnv.c              | 25 +++++++++++++------------
>  hw/ppc/pnv_core.c         |  5 -----
>  4 files changed, 13 insertions(+), 19 deletions(-)
> 
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index d82eee1..20244da 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -69,7 +69,6 @@ typedef struct PnvChipClass {
>      SysBusDeviceClass parent_class;
>  
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
>  
>  #define PNV_CORE_TYPE_SUFFIX "-" TYPE_PNV_CORE
>  #define PNV_CORE_TYPE_NAME(cpu_model) cpu_model PNV_CORE_TYPE_SUFFIX
> -extern char *pnv_core_typename(const char *model);
>  
>  #endif /* _PPC_PNV_CORE_H */
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 3eafa28..80c7f62 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -55,6 +55,16 @@
>  #define KERNEL_LOAD_ADDR        0x20000000
>  #define INITRD_LOAD_ADDR        0x40000000
>  
> +static const char *pnv_chip_core_typename(const PnvChip *o)
> +{
> +    const char *chip_type = object_class_get_name(object_get_class(OBJECT(o)));
> +    int len = strlen(chip_type) - strlen(PNV_CHIP_TYPE_SUFFIX);
> +    char *s = g_strdup_printf(PNV_CORE_TYPE_NAME("%.*s"), len, chip_type);
> +    const char *core_type = object_class_get_name(object_class_by_name(s));
> +    g_free(s);
> +    return core_type;
> +}
> +
>  /*
>   * On Power Systems E880 (POWER8), the max cpus (threads) should be :
>   *     4 * 4 sockets * 12 cores * 8 threads = 1536
> @@ -269,8 +279,7 @@ static int pnv_chip_lpc_offset(PnvChip *chip, void *fdt)
>  
>  static void powernv_populate_chip(PnvChip *chip, void *fdt)
>  {
> -    PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
> -    char *typename = pnv_core_typename(pcc->cpu_model);
> +    const char *typename = pnv_chip_core_typename(chip);
>      size_t typesize = object_type_get_instance_size(typename);
>      int i;
>  
> @@ -300,7 +309,6 @@ static void powernv_populate_chip(PnvChip *chip, void *fdt)
>          powernv_populate_memory_node(fdt, chip->chip_id, chip->ram_start,
>                                       chip->ram_size);
>      }
> -    g_free(typename);
>  }
>  
>  static void powernv_populate_rtc(ISADevice *d, void *fdt, int lpc_off)
> @@ -712,7 +720,6 @@ static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      PnvChipClass *k = PNV_CHIP_CLASS(klass);
>  
> -    k->cpu_model = "power8e_v2.1";
>      k->chip_type = PNV_CHIP_POWER8E;
>      k->chip_cfam_id = 0x221ef04980000000ull;  /* P8 Murano DD2.1 */
>      k->cores_mask = POWER8E_CORE_MASK;
> @@ -734,7 +741,6 @@ static void pnv_chip_power8_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      PnvChipClass *k = PNV_CHIP_CLASS(klass);
>  
> -    k->cpu_model = "power8_v2.0";
>      k->chip_type = PNV_CHIP_POWER8;
>      k->chip_cfam_id = 0x220ea04980000000ull; /* P8 Venice DD2.0 */
>      k->cores_mask = POWER8_CORE_MASK;
> @@ -756,7 +762,6 @@ static void pnv_chip_power8nvl_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      PnvChipClass *k = PNV_CHIP_CLASS(klass);
>  
> -    k->cpu_model = "power8nvl_v1.0";
>      k->chip_type = PNV_CHIP_POWER8NVL;
>      k->chip_cfam_id = 0x120d304980000000ull;  /* P8 Naples DD1.0 */
>      k->cores_mask = POWER8_CORE_MASK;
> @@ -778,7 +783,6 @@ static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      PnvChipClass *k = PNV_CHIP_CLASS(klass);
>  
> -    k->cpu_model = "power9_v1.0";
>      k->chip_type = PNV_CHIP_POWER9;
>      k->chip_cfam_id = 0x100d104980000000ull; /* P9 Nimbus DD1.0 */
>      k->cores_mask = POWER9_CORE_MASK;
> @@ -853,7 +857,7 @@ static void pnv_chip_init(Object *obj)
>  static void pnv_chip_icp_realize(PnvChip *chip, Error **errp)
>  {
>      PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
> -    char *typename = pnv_core_typename(pcc->cpu_model);
> +    const char *typename = pnv_chip_core_typename(chip);
>      size_t typesize = object_type_get_instance_size(typename);
>      int i, j;
>      char *name;
> @@ -878,8 +882,6 @@ static void pnv_chip_icp_realize(PnvChip *chip, Error **errp)
>              memory_region_add_subregion(&chip->icp_mmio, pir << 12, &icp->mmio);
>          }
>      }
> -
> -    g_free(typename);
>  }
>  
>  static void pnv_chip_realize(DeviceState *dev, Error **errp)
> @@ -887,7 +889,7 @@ static void pnv_chip_realize(DeviceState *dev, Error **errp)
>      PnvChip *chip = PNV_CHIP(dev);
>      Error *error = NULL;
>      PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
> -    char *typename = pnv_core_typename(pcc->cpu_model);
> +    const char *typename = pnv_chip_core_typename(chip);
>      size_t typesize = object_type_get_instance_size(typename);
>      int i, core_hwid;
>  
> @@ -946,7 +948,6 @@ static void pnv_chip_realize(DeviceState *dev, Error **errp)
>                                  &PNV_CORE(pnv_core)->xscom_regs);
>          i++;
>      }
> -    g_free(typename);
>  
>      /* Create LPC controller */
>      object_property_set_bool(OBJECT(&chip->lpc), true, "realized",
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 438dbd1..71eb90a 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -246,9 +246,4 @@ static const TypeInfo pnv_core_infos[] = {
>      DEFINE_PNV_CORE_TYPE("power9_v1.0"),
>  };
>  
> -char *pnv_core_typename(const char *model)
> -{
> -    return g_strdup_printf(PNV_CORE_TYPE_NAME("%s"), model);
> -}
> -
>  DEFINE_TYPES(pnv_core_infos)
> 
