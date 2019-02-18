Received: from eggs.gnu.org ([209.51.188.92]:47005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gvmTJ-00019E-Ql
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 12:12:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gvmTE-0007GV-6C
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 12:12:47 -0500
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-11-armbru@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <e993bad5-efc9-a196-afee-4375fc89a37a@redhat.com>
Date: Mon, 18 Feb 2019 18:12:27 +0100
MIME-Version: 1.0
In-Reply-To: <20190218125615.18970-11-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/10] hw/arm hw/xtensa: De-duplicate
 pflash creation code some
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org

On 02/18/19 13:56, Markus Armbruster wrote:
> pflash_cfi01_register() creates a TYPE_CFI_PFLASH01 device, sets
> properties, realizes, and wires up.
> 
> We have three modified copies of it, because their users need to set
> additional properties, or have the wiring done differently.
> 
> Factor out their common part into pflash_cfi01_create().
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/arm/vexpress.c        | 22 +++++-----------------
>  hw/arm/virt.c            | 26 +++++++++-----------------
>  hw/block/pflash_cfi01.c  | 39 +++++++++++++++++++++++++++------------
>  hw/xtensa/xtfpga.c       | 18 +++++++-----------
>  include/hw/block/flash.h |  8 ++++++++
>  5 files changed, 56 insertions(+), 57 deletions(-)
> 
> diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
> index 00913f2655..b23c63ed24 100644
> --- a/hw/arm/vexpress.c
> +++ b/hw/arm/vexpress.c
> @@ -515,26 +515,14 @@ static void vexpress_modify_dtb(const struct arm_boot_info *info, void *fdt)
>  static PFlashCFI01 *ve_pflash_cfi01_register(hwaddr base, const char *name,
>                                               DriveInfo *di)
>  {
> -    DeviceState *dev = qdev_create(NULL, TYPE_CFI_PFLASH01);
> +    DeviceState *dev;
>  
> -    if (di) {
> -        qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(di),
> -                            &error_abort);
> -    }
> -
> -    qdev_prop_set_uint32(dev, "num-blocks",
> -                         VEXPRESS_FLASH_SIZE / VEXPRESS_FLASH_SECT_SIZE);
> -    qdev_prop_set_uint64(dev, "sector-length", VEXPRESS_FLASH_SECT_SIZE);
> -    qdev_prop_set_uint8(dev, "width", 4);
> +    dev = DEVICE(pflash_cfi01_create(name, VEXPRESS_FLASH_SIZE,
> +                                     di ? blk_by_legacy_dinfo(di) : NULL,
> +                                     VEXPRESS_FLASH_SECT_SIZE,
> +                                     4, 0x89, 0x18, 0x00, 0x00, false));
>      qdev_prop_set_uint8(dev, "device-width", 2);
> -    qdev_prop_set_bit(dev, "big-endian", false);
> -    qdev_prop_set_uint16(dev, "id0", 0x89);
> -    qdev_prop_set_uint16(dev, "id1", 0x18);
> -    qdev_prop_set_uint16(dev, "id2", 0x00);
> -    qdev_prop_set_uint16(dev, "id3", 0x00);
> -    qdev_prop_set_string(dev, "name", name);
>      qdev_init_nofail(dev);
> -
>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
>      return CFI_PFLASH01(dev);
>  }
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index b7d53b2b87..7787918483 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -48,6 +48,7 @@
>  #include "exec/address-spaces.h"
>  #include "qemu/bitops.h"
>  #include "qemu/error-report.h"
> +#include "qemu/units.h"
>  #include "hw/pci-host/gpex.h"
>  #include "hw/arm/sysbus-fdt.h"
>  #include "hw/platform-bus.h"
> @@ -875,29 +876,20 @@ static void create_one_flash(const char *name, hwaddr flashbase,
>       * parameters as the flash devices on the Versatile Express board.
>       */
>      DriveInfo *dinfo = drive_get_next(IF_PFLASH);
> -    DeviceState *dev = qdev_create(NULL, TYPE_CFI_PFLASH01);
> -    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> -    const uint64_t sectorlength = 256 * 1024;
> +    DeviceState *dev;
> +    SysBusDevice *sbd;
>  
> -    if (dinfo) {
> -        qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo),
> -                            &error_abort);
> -    }
> +    dev = DEVICE(pflash_cfi01_create(name, flashsize,
> +                                     dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> +                                     256 * KiB,
> +                                     4, 0x89, 0x18, 0x00, 0x00, false));
>  
> -    qdev_prop_set_uint32(dev, "num-blocks", flashsize / sectorlength);
> -    qdev_prop_set_uint64(dev, "sector-length", sectorlength);
> -    qdev_prop_set_uint8(dev, "width", 4);
>      qdev_prop_set_uint8(dev, "device-width", 2);
> -    qdev_prop_set_bit(dev, "big-endian", false);
> -    qdev_prop_set_uint16(dev, "id0", 0x89);
> -    qdev_prop_set_uint16(dev, "id1", 0x18);
> -    qdev_prop_set_uint16(dev, "id2", 0x00);
> -    qdev_prop_set_uint16(dev, "id3", 0x00);
> -    qdev_prop_set_string(dev, "name", name);
>      qdev_init_nofail(dev);
>  
> +    sbd = SYS_BUS_DEVICE(dev);
>      memory_region_add_subregion(sysmem, flashbase,
> -                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
> +                                sysbus_mmio_get_region(sbd, 0));
>  
>      if (file) {
>          char *fn;
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 2e161f937f..00c2efd0d7 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -920,15 +920,14 @@ static void pflash_cfi01_register_types(void)
>  
>  type_init(pflash_cfi01_register_types)
>  
> -PFlashCFI01 *pflash_cfi01_register(hwaddr base,
> -                                   const char *name,
> -                                   hwaddr size,
> -                                   BlockBackend *blk,
> -                                   uint32_t sector_len,
> -                                   int bank_width,
> -                                   uint16_t id0, uint16_t id1,
> -                                   uint16_t id2, uint16_t id3,
> -                                   int be)
> +PFlashCFI01 *pflash_cfi01_create(const char *name,
> +                                 hwaddr size,
> +                                 BlockBackend *blk,
> +                                 uint32_t sector_len,
> +                                 int bank_width,
> +                                 uint16_t id0, uint16_t id1,
> +                                 uint16_t id2, uint16_t id3,
> +                                 int be)
>  {
>      DeviceState *dev = qdev_create(NULL, TYPE_CFI_PFLASH01);
>  
> @@ -945,12 +944,28 @@ PFlashCFI01 *pflash_cfi01_register(hwaddr base,
>      qdev_prop_set_uint16(dev, "id2", id2);
>      qdev_prop_set_uint16(dev, "id3", id3);
>      qdev_prop_set_string(dev, "name", name);
> -    qdev_init_nofail(dev);
> -
> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
>      return CFI_PFLASH01(dev);
>  }
>  
> +PFlashCFI01 *pflash_cfi01_register(hwaddr base,
> +                                   const char *name,
> +                                   hwaddr size,
> +                                   BlockBackend *blk,
> +                                   uint32_t sector_len,
> +                                   int bank_width,
> +                                   uint16_t id0, uint16_t id1,
> +                                   uint16_t id2, uint16_t id3,
> +                                   int be)
> +{
> +    PFlashCFI01 *dev = pflash_cfi01_create(name, size, blk,
> +                                           sector_len, bank_width,
> +                                           id0, id1, id2, id3, be);
> +
> +    qdev_init_nofail(DEVICE(dev));
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
> +    return dev;
> +}
> +
>  MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *fl)
>  {
>      return &fl->mem;
> diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
> index a726d5632a..0e96e73ee2 100644
> --- a/hw/xtensa/xtfpga.c
> +++ b/hw/xtensa/xtfpga.c
> @@ -167,21 +167,17 @@ static PFlashCFI01 *xtfpga_flash_init(MemoryRegion *address_space,
>                                        DriveInfo *dinfo, int be)
>  {
>      SysBusDevice *s;
> -    DeviceState *dev = qdev_create(NULL, TYPE_CFI_PFLASH01);
> +    PFlashCFI01 *dev = pflash_cfi01_create("xtfpga.io.flash",
> +                                           board->flash->size,
> +                                           blk_by_legacy_dinfo(dinfo),
> +                                           board->flash->sector_size,
> +                                           2, 0, 0, 0, 0, be);
>  
> -    qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo),
> -                        &error_abort);
> -    qdev_prop_set_uint32(dev, "num-blocks",
> -                         board->flash->size / board->flash->sector_size);
> -    qdev_prop_set_uint64(dev, "sector-length", board->flash->sector_size);
> -    qdev_prop_set_uint8(dev, "width", 2);
> -    qdev_prop_set_bit(dev, "big-endian", be);
> -    qdev_prop_set_string(dev, "name", "xtfpga.io.flash");
> -    qdev_init_nofail(dev);
> +    qdev_init_nofail(DEVICE(dev));
>      s = SYS_BUS_DEVICE(dev);
>      memory_region_add_subregion(address_space, board->flash->base,
>                                  sysbus_mmio_get_region(s, 0));
> -    return CFI_PFLASH01(dev);
> +    return dev;
>  }
>  
>  static uint64_t translate_phys_addr(void *opaque, uint64_t addr)
> diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
> index 24b13eb525..dbb25ba382 100644
> --- a/include/hw/block/flash.h
> +++ b/include/hw/block/flash.h
> @@ -13,6 +13,14 @@
>  
>  typedef struct PFlashCFI01 PFlashCFI01;
>  
> +PFlashCFI01 *pflash_cfi01_create(const char *name,
> +                                 hwaddr size,
> +                                 BlockBackend *blk,
> +                                 uint32_t sector_len,
> +                                 int width,
> +                                 uint16_t id0, uint16_t id1,
> +                                 uint16_t id2, uint16_t id3,
> +                                 int be);
>  PFlashCFI01 *pflash_cfi01_register(hwaddr base,
>                                     const char *name,
>                                     hwaddr size,
> 

Writing this patch must have been "fun"; my eyes are bleeding from
cross-referencing the new parameters with the removed properties. :/

I think the patch is correct.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo
