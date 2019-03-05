Received: from eggs.gnu.org ([209.51.188.92]:41875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1AY6-0000rj-Ra
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 08:56:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1AY4-0000Fs-Od
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 08:56:02 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1AY4-0000Cn-Du
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 08:56:00 -0500
Received: by mail-wr1-f68.google.com with SMTP id i16so9534653wrs.13
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 05:56:00 -0800 (PST)
References: <20190226193408.23862-1-armbru@redhat.com>
	<20190226193408.23862-12-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a20fe845-4f14-4f23-7feb-bb7ca899c2d5@redhat.com>
Date: Tue, 5 Mar 2019 14:55:57 +0100
MIME-Version: 1.0
In-Reply-To: <20190226193408.23862-12-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 11/11] pflash: Clean up after commit
 368a354f02b part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, alex.bennee@linaro.org, lersek@redhat.com
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, qemu-ppc@nongnu.org

Hi Markus,

On 2/26/19 8:34 PM, Markus Armbruster wrote:
> QOMification left parameter @size unused in pflash_cfi01_register()
> and pflash_cfi02_register().  Obviously, @size should match
> @sector_len and @nb_blocs, i.e. size == sector_len * nb_blocs.  All
> callers satisfy this.
> 
> Remove @nb_blocs and compute it from @size and @sector_len.

The pflash devices are simplistically modelled has having a single
sector size. This is not true for real hw (pflash have different sector
sizes). It is however true for the unofficial VirtPFlash device, which
doesn't have any spec.

The only valid parameter is @size. The @sector_len and @nb_blocs don't
match the hardwares. QEMU @sector_len is currently "The biggest
sector_size the device has" and QEMU @nb_blocs is really "@size /
@sector_len", although it doesn't match the nb_blocs the hardware has.

I don't disagree with the patch content, but the description is not
accurate. We can indeed drop the @nb_blocs argument because we model an
unique sector size, thus we can calculate "@nb_blocs = @size /
@sector_len" in the model.

With the patch description fixed:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Thanks,

Phil.

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  hw/arm/collie.c                          | 5 +++--
>  hw/arm/digic_boards.c                    | 1 -
>  hw/arm/gumstix.c                         | 4 ++--
>  hw/arm/mainstone.c                       | 2 +-
>  hw/arm/musicpal.c                        | 4 ++--
>  hw/arm/omap_sx1.c                        | 4 ++--
>  hw/arm/versatilepb.c                     | 1 -
>  hw/arm/xilinx_zynq.c                     | 3 +--
>  hw/arm/z2.c                              | 2 +-
>  hw/block/pflash_cfi01.c                  | 5 +++--
>  hw/block/pflash_cfi02.c                  | 5 +++--
>  hw/i386/pc_sysfw.c                       | 6 +-----
>  hw/lm32/lm32_boards.c                    | 4 ++--
>  hw/lm32/milkymist.c                      | 2 +-
>  hw/microblaze/petalogix_ml605_mmu.c      | 2 +-
>  hw/microblaze/petalogix_s3adsp1800_mmu.c | 2 +-
>  hw/mips/mips_malta.c                     | 7 +++----
>  hw/mips/mips_r4k.c                       | 2 +-
>  hw/ppc/ppc405_boards.c                   | 6 +++---
>  hw/ppc/sam460ex.c                        | 2 +-
>  hw/ppc/virtex_ml507.c                    | 2 +-
>  hw/sh4/r2d.c                             | 2 +-
>  include/hw/block/flash.h                 | 4 ++--
>  23 files changed, 36 insertions(+), 41 deletions(-)
> 
> diff --git a/hw/arm/collie.c b/hw/arm/collie.c
> index cbc4400f8e..7c9c0615f0 100644
> --- a/hw/arm/collie.c
> +++ b/hw/arm/collie.c
> @@ -9,6 +9,7 @@
>   * GNU GPL, version 2 or (at your option) any later version.
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "hw/hw.h"
>  #include "hw/sysbus.h"
>  #include "hw/boards.h"
> @@ -38,12 +39,12 @@ static void collie_init(MachineState *machine)
>      dinfo = drive_get(IF_PFLASH, 0, 0);
>      pflash_cfi01_register(SA_CS0, "collie.fl1", 0x02000000,
>                      dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> -                    (64 * 1024), 512, 4, 0x00, 0x00, 0x00, 0x00, 0);
> +                    64 * KiB, 4, 0x00, 0x00, 0x00, 0x00, 0);
>  
>      dinfo = drive_get(IF_PFLASH, 0, 1);
>      pflash_cfi01_register(SA_CS1, "collie.fl2", 0x02000000,
>                      dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> -                    (64 * 1024), 512, 4, 0x00, 0x00, 0x00, 0x00, 0);
> +                    64 * KiB, 4, 0x00, 0x00, 0x00, 0x00, 0);
>  
>      sysbus_create_simple("scoop", 0x40800000, NULL);
>  
> diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
> index 15a00a1be3..304e4d1a29 100644
> --- a/hw/arm/digic_boards.c
> +++ b/hw/arm/digic_boards.c
> @@ -131,7 +131,6 @@ static void digic4_add_k8p3215uqb_rom(DigicBoardState *s, hwaddr addr,
>  
>      pflash_cfi02_register(addr, "pflash", FLASH_K8P3215UQB_SIZE,
>                            NULL, FLASH_K8P3215UQB_SECTOR_SIZE,
> -                          FLASH_K8P3215UQB_SIZE / FLASH_K8P3215UQB_SECTOR_SIZE,
>                            DIGIC4_ROM_MAX_SIZE / FLASH_K8P3215UQB_SIZE,
>                            4,
>                            0x00EC, 0x007E, 0x0003, 0x0001,
> diff --git a/hw/arm/gumstix.c b/hw/arm/gumstix.c
> index 304dbeab2f..2e526218f4 100644
> --- a/hw/arm/gumstix.c
> +++ b/hw/arm/gumstix.c
> @@ -74,7 +74,7 @@ static void connex_init(MachineState *machine)
>  #endif
>      if (!pflash_cfi01_register(0x00000000, "connext.rom", connex_rom,
>                                 dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> -                               sector_len, connex_rom / sector_len,
> +                               sector_len,
>                                 2, 0, 0, 0, 0, be)) {
>          error_report("Error registering flash memory");
>          exit(1);
> @@ -111,7 +111,7 @@ static void verdex_init(MachineState *machine)
>  #endif
>      if (!pflash_cfi01_register(0x00000000, "verdex.rom", verdex_rom,
>                                 dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> -                               sector_len, verdex_rom / sector_len,
> +                               sector_len,
>                                 2, 0, 0, 0, 0, be)) {
>          error_report("Error registering flash memory");
>          exit(1);
> diff --git a/hw/arm/mainstone.c b/hw/arm/mainstone.c
> index 2a1c1072db..6e15ba9663 100644
> --- a/hw/arm/mainstone.c
> +++ b/hw/arm/mainstone.c
> @@ -152,7 +152,7 @@ static void mainstone_common_init(MemoryRegion *address_space_mem,
>                                     i ? "mainstone.flash1" : "mainstone.flash0",
>                                     MAINSTONE_FLASH,
>                                     blk_by_legacy_dinfo(dinfo),
> -                                   sector_len, MAINSTONE_FLASH / sector_len,
> +                                   sector_len,
>                                     4, 0, 0, 0, 0, be)) {
>              error_report("Error registering flash memory");
>              exit(1);
> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
> index cc780dfb37..0f4f02df8e 100644
> --- a/hw/arm/musicpal.c
> +++ b/hw/arm/musicpal.c
> @@ -1638,14 +1638,14 @@ static void musicpal_init(MachineState *machine)
>  #ifdef TARGET_WORDS_BIGENDIAN
>          pflash_cfi02_register(0x100000000ULL - MP_FLASH_SIZE_MAX,
>                                "musicpal.flash", flash_size,
> -                              blk, 0x10000, (flash_size + 0xffff) >> 16,
> +                              blk, 0x10000,
>                                MP_FLASH_SIZE_MAX / flash_size,
>                                2, 0x00BF, 0x236D, 0x0000, 0x0000,
>                                0x5555, 0x2AAA, 1);
>  #else
>          pflash_cfi02_register(0x100000000ULL - MP_FLASH_SIZE_MAX,
>                                "musicpal.flash", flash_size,
> -                              blk, 0x10000, (flash_size + 0xffff) >> 16,
> +                              blk, 0x10000,
>                                MP_FLASH_SIZE_MAX / flash_size,
>                                2, 0x00BF, 0x236D, 0x0000, 0x0000,
>                                0x5555, 0x2AAA, 0);
> diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
> index b1128777cf..b269a5e1c2 100644
> --- a/hw/arm/omap_sx1.c
> +++ b/hw/arm/omap_sx1.c
> @@ -155,7 +155,7 @@ static void sx1_init(MachineState *machine, const int version)
>          if (!pflash_cfi01_register(OMAP_CS0_BASE,
>                                     "omap_sx1.flash0-1", flash_size,
>                                     blk_by_legacy_dinfo(dinfo),
> -                                   sector_size, flash_size / sector_size,
> +                                   sector_size,
>                                     4, 0, 0, 0, 0, be)) {
>              fprintf(stderr, "qemu: Error registering flash memory %d.\n",
>                             fl_idx);
> @@ -179,7 +179,7 @@ static void sx1_init(MachineState *machine, const int version)
>          if (!pflash_cfi01_register(OMAP_CS1_BASE,
>                                     "omap_sx1.flash1-1", flash1_size,
>                                     blk_by_legacy_dinfo(dinfo),
> -                                   sector_size, flash1_size / sector_size,
> +                                   sector_size,
>                                     4, 0, 0, 0, 0, be)) {
>              fprintf(stderr, "qemu: Error registering flash memory %d.\n",
>                             fl_idx);
> diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
> index 82c5277462..d67181810a 100644
> --- a/hw/arm/versatilepb.c
> +++ b/hw/arm/versatilepb.c
> @@ -369,7 +369,6 @@ static void versatile_init(MachineState *machine, int board_id)
>                            VERSATILE_FLASH_SIZE,
>                            dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
>                            VERSATILE_FLASH_SECT_SIZE,
> -                          VERSATILE_FLASH_SIZE / VERSATILE_FLASH_SECT_SIZE,
>                            4, 0x0089, 0x0018, 0x0000, 0x0, 0)) {
>          fprintf(stderr, "qemu: Error registering flash memory.\n");
>      }
> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> index 1fa4a77728..f36cfcfd4a 100644
> --- a/hw/arm/xilinx_zynq.c
> +++ b/hw/arm/xilinx_zynq.c
> @@ -207,8 +207,7 @@ static void zynq_init(MachineState *machine)
>      /* AMD */
>      pflash_cfi02_register(0xe2000000, "zynq.pflash", FLASH_SIZE,
>                            dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> -                          FLASH_SECTOR_SIZE,
> -                          FLASH_SIZE/FLASH_SECTOR_SIZE, 1,
> +                          FLASH_SECTOR_SIZE, 1,
>                            1, 0x0066, 0x0022, 0x0000, 0x0000, 0x0555, 0x2aa,
>                                0);
>  
> diff --git a/hw/arm/z2.c b/hw/arm/z2.c
> index 54e6caee9f..fb073ec2f5 100644
> --- a/hw/arm/z2.c
> +++ b/hw/arm/z2.c
> @@ -326,7 +326,7 @@ static void z2_init(MachineState *machine)
>  
>      if (!pflash_cfi01_register(Z2_FLASH_BASE, "z2.flash0", Z2_FLASH_SIZE,
>                                 dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> -                               sector_len, Z2_FLASH_SIZE / sector_len,
> +                               sector_len,
>                                 4, 0, 0, 0, 0, be)) {
>          error_report("Error registering flash memory");
>          exit(1);
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index bd42487c0a..9d1c356eb6 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -940,7 +940,7 @@ PFlashCFI01 *pflash_cfi01_register(hwaddr base,
>                                     const char *name,
>                                     hwaddr size,
>                                     BlockBackend *blk,
> -                                   uint32_t sector_len, int nb_blocs,
> +                                   uint32_t sector_len,
>                                     int bank_width,
>                                     uint16_t id0, uint16_t id1,
>                                     uint16_t id2, uint16_t id3,
> @@ -951,7 +951,8 @@ PFlashCFI01 *pflash_cfi01_register(hwaddr base,
>      if (blk) {
>          qdev_prop_set_drive(dev, "drive", blk, &error_abort);
>      }
> -    qdev_prop_set_uint32(dev, "num-blocks", nb_blocs);
> +    assert(size % sector_len == 0);
> +    qdev_prop_set_uint32(dev, "num-blocks", size / sector_len);
>      qdev_prop_set_uint64(dev, "sector-length", sector_len);
>      qdev_prop_set_uint8(dev, "width", bank_width);
>      qdev_prop_set_bit(dev, "big-endian", !!be);
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index c261ebff72..33779ce807 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -720,7 +720,7 @@ PFlashCFI02 *pflash_cfi02_register(hwaddr base,
>                                     const char *name,
>                                     hwaddr size,
>                                     BlockBackend *blk,
> -                                   uint32_t sector_len, int nb_blocs,
> +                                   uint32_t sector_len,
>                                     int nb_mappings, int width,
>                                     uint16_t id0, uint16_t id1,
>                                     uint16_t id2, uint16_t id3,
> @@ -733,7 +733,8 @@ PFlashCFI02 *pflash_cfi02_register(hwaddr base,
>      if (blk) {
>          qdev_prop_set_drive(dev, "drive", blk, &error_abort);
>      }
> -    qdev_prop_set_uint32(dev, "num-blocks", nb_blocs);
> +    assert(size % sector_len == 0);
> +    qdev_prop_set_uint32(dev, "num-blocks", size / sector_len);
>      qdev_prop_set_uint32(dev, "sector-length", sector_len);
>      qdev_prop_set_uint8(dev, "width", width);
>      qdev_prop_set_uint8(dev, "mappings", nb_mappings);
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index 9a5be54a85..34727c5b1f 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -110,16 +110,13 @@ static void pc_system_flash_init(MemoryRegion *rom_memory)
>      int64_t size;
>      char *fatal_errmsg = NULL;
>      hwaddr phys_addr = 0x100000000ULL;
> -    int sector_bits, sector_size;
> +    uint32_t sector_size = 4096;
>      PFlashCFI01 *system_flash;
>      MemoryRegion *flash_mem;
>      char name[64];
>      void *flash_ptr;
>      int ret, flash_size;
>  
> -    sector_bits = 12;
> -    sector_size = 1 << sector_bits;
> -
>      for (unit = 0;
>           (unit < FLASH_MAP_UNIT_MAX &&
>            (pflash_drv = drive_get(IF_PFLASH, 0, unit)) != NULL);
> @@ -162,7 +159,6 @@ static void pc_system_flash_init(MemoryRegion *rom_memory)
>          snprintf(name, sizeof name, "system.flash%d", unit);
>          system_flash = pflash_cfi01_register(phys_addr, name,
>                                               size, blk, sector_size,
> -                                             size >> sector_bits,
>                                               1      /* width */,
>                                               0x0000 /* id0 */,
>                                               0x0000 /* id1 */,
> diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
> index f726355309..09f411ed07 100644
> --- a/hw/lm32/lm32_boards.c
> +++ b/hw/lm32/lm32_boards.c
> @@ -116,7 +116,7 @@ static void lm32_evr_init(MachineState *machine)
>      /* Spansion S29NS128P */
>      pflash_cfi02_register(flash_base, "lm32_evr.flash", flash_size,
>                            dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> -                          flash_sector_size, flash_size / flash_sector_size,
> +                          flash_sector_size,
>                            1, 2, 0x01, 0x7e, 0x43, 0x00, 0x555, 0x2aa, 1);
>  
>      /* create irq lines */
> @@ -209,7 +209,7 @@ static void lm32_uclinux_init(MachineState *machine)
>      /* Spansion S29NS128P */
>      pflash_cfi02_register(flash_base, "lm32_uclinux.flash", flash_size,
>                            dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> -                          flash_sector_size, flash_size / flash_sector_size,
> +                          flash_sector_size,
>                            1, 2, 0x01, 0x7e, 0x43, 0x00, 0x555, 0x2aa, 1);
>  
>      /* create irq lines */
> diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
> index ece7e3b699..46b0f51fdf 100644
> --- a/hw/lm32/milkymist.c
> +++ b/hw/lm32/milkymist.c
> @@ -123,7 +123,7 @@ milkymist_init(MachineState *machine)
>      /* Numonyx JS28F256J3F105 */
>      pflash_cfi01_register(flash_base, "milkymist.flash", flash_size,
>                            dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> -                          flash_sector_size, flash_size / flash_sector_size,
> +                          flash_sector_size,
>                            2, 0x00, 0x89, 0x00, 0x1d, 1);
>  
>      /* create irq lines */
> diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
> index 74bcc14cda..46904d2012 100644
> --- a/hw/microblaze/petalogix_ml605_mmu.c
> +++ b/hw/microblaze/petalogix_ml605_mmu.c
> @@ -109,7 +109,7 @@ petalogix_ml605_init(MachineState *machine)
>       * 10th paremeter 0 means little-endian */
>      pflash_cfi01_register(FLASH_BASEADDR, "petalogix_ml605.flash", FLASH_SIZE,
>                            dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> -                          64 * KiB, FLASH_SIZE >> 16,
> +                          64 * KiB,
>                            2, 0x89, 0x18, 0x0000, 0x0, 0);
>  
>  
> diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> index a07b7f8edf..027c31fdcc 100644
> --- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
> +++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> @@ -90,7 +90,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
>      pflash_cfi01_register(FLASH_BASEADDR,
>                            "petalogix_s3adsp1800.flash", FLASH_SIZE,
>                            dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> -                          64 * KiB, FLASH_SIZE >> 16,
> +                          64 * KiB,
>                            1, 0x89, 0x18, 0x0000, 0x0, 1);
>  
>      dev = qdev_create(NULL, "xlnx.xps-intc");
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index fdf1434b28..647d4a2dac 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1208,7 +1208,6 @@ void mips_malta_init(MachineState *machine)
>      DriveInfo *dinfo;
>      DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>      int fl_idx = 0;
> -    int fl_sectors = bios_size >> 16;
>      int be;
>  
>      DeviceState *dev = qdev_create(NULL, TYPE_MIPS_MALTA);
> @@ -1268,15 +1267,15 @@ void mips_malta_init(MachineState *machine)
>  #ifdef DEBUG_BOARD_INIT
>      if (dinfo) {
>          printf("Register parallel flash %d size " TARGET_FMT_lx " at "
> -               "addr %08llx '%s' %x\n",
> +               "addr %08llx '%s'\n",
>                 fl_idx, FLASH_SIZE, FLASH_ADDRESS,
> -               blk_name(dinfo->bdrv), fl_sectors);
> +               blk_name(dinfo->bdrv));
>      }
>  #endif
>      fl = pflash_cfi01_register(FLASH_ADDRESS, "mips_malta.bios",
>                                 FLASH_SIZE,
>                                 dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> -                               65536, fl_sectors,
> +                               65536,
>                                 4, 0x0000, 0x0000, 0x0000, 0x0000, be);
>      bios = pflash_cfi01_get_memory(fl);
>      fl_idx++;
> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
> index 0b9df466e7..acfd59c17a 100644
> --- a/hw/mips/mips_r4k.c
> +++ b/hw/mips/mips_r4k.c
> @@ -237,7 +237,7 @@ void mips_r4k_init(MachineState *machine)
>          uint32_t mips_rom = 0x00400000;
>          if (!pflash_cfi01_register(0x1fc00000, "mips_r4k.bios", mips_rom,
>                                     blk_by_legacy_dinfo(dinfo),
> -                                   sector_len, mips_rom / sector_len,
> +                                   sector_len,
>                                     4, 0, 0, 0, 0, be)) {
>              fprintf(stderr, "qemu: Error registering flash memory.\n");
>          }
> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
> index dfaea45898..1dd5c8b797 100644
> --- a/hw/ppc/ppc405_boards.c
> +++ b/hw/ppc/ppc405_boards.c
> @@ -195,7 +195,7 @@ static void ref405ep_init(MachineState *machine)
>          pflash_cfi02_register((uint32_t)(-bios_size),
>                                "ef405ep.bios", bios_size,
>                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> -                              64 * KiB, bios_size / (64 * KiB), 1,
> +                              64 * KiB, 1,
>                                2, 0x0001, 0x22DA, 0x0000, 0x0000, 0x555, 0x2AA,
>                                1);
>      } else
> @@ -486,7 +486,7 @@ static void taihu_405ep_init(MachineState *machine)
>          pflash_cfi02_register(0xFFE00000,
>                                "taihu_405ep.bios", bios_size,
>                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> -                              64 * KiB, bios_size / (64 * KiB), 1,
> +                              64 * KiB, 1,
>                                4, 0x0001, 0x22DA, 0x0000, 0x0000, 0x555, 0x2AA,
>                                1);
>          fl_idx++;
> @@ -528,7 +528,7 @@ static void taihu_405ep_init(MachineState *machine)
>  #endif
>          pflash_cfi02_register(0xfc000000, "taihu_405ep.flash", bios_size,
>                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> -                              64 * KiB, bios_size / (64 * KiB), 1,
> +                              64 * KiB, 1,
>                                4, 0x0001, 0x22DA, 0x0000, 0x0000, 0x555, 0x2AA,
>                                1);
>          fl_idx++;
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index ad36cb12c8..1de0a1b47c 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -115,7 +115,7 @@ static int sam460ex_load_uboot(void)
>      if (!pflash_cfi01_register(FLASH_BASE | ((hwaddr)FLASH_BASE_H << 32),
>                                 "sam460ex.flash", FLASH_SIZE,
>                                 dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> -                               64 * KiB, FLASH_SIZE / (64 * KiB),
> +                               64 * KiB,
>                                 1, 0x89, 0x18, 0x0000, 0x0, 1)) {
>          error_report("Error registering flash memory");
>          /* XXX: return an error instead? */
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index d2085a839c..4f86c22968 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -229,7 +229,7 @@ static void virtex_init(MachineState *machine)
>      dinfo = drive_get(IF_PFLASH, 0, 0);
>      pflash_cfi01_register(PFLASH_BASEADDR, "virtex.flash", FLASH_SIZE,
>                            dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> -                          64 * KiB, FLASH_SIZE >> 16,
> +                          64 * KiB,
>                            1, 0x89, 0x18, 0x0000, 0x0, 1);
>  
>      cpu_irq = (qemu_irq *) &env->irq_inputs[PPC40x_INPUT_INT];
> diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
> index abd3b67c28..5e6953537c 100644
> --- a/hw/sh4/r2d.c
> +++ b/hw/sh4/r2d.c
> @@ -299,7 +299,7 @@ static void r2d_init(MachineState *machine)
>       */
>      pflash_cfi02_register(0x0, "r2d.flash", FLASH_SIZE / 4,
>                            dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> -                          16 * KiB, FLASH_SIZE >> 16,
> +                          16 * KiB,
>                            1, 4, 0x0000, 0x0000, 0x0000, 0x0000,
>                            0x555, 0x2aa, 0);
>  
> diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
> index 3e48901c84..914932eaec 100644
> --- a/include/hw/block/flash.h
> +++ b/include/hw/block/flash.h
> @@ -17,7 +17,7 @@ PFlashCFI01 *pflash_cfi01_register(hwaddr base,
>                                     const char *name,
>                                     hwaddr size,
>                                     BlockBackend *blk,
> -                                   uint32_t sector_len, int nb_blocs,
> +                                   uint32_t sector_len,
>                                     int width,
>                                     uint16_t id0, uint16_t id1,
>                                     uint16_t id2, uint16_t id3,
> @@ -36,7 +36,7 @@ PFlashCFI02 *pflash_cfi02_register(hwaddr base,
>                                     const char *name,
>                                     hwaddr size,
>                                     BlockBackend *blk,
> -                                   uint32_t sector_len, int nb_blocs,
> +                                   uint32_t sector_len,
>                                     int nb_mappings,
>                                     int width,
>                                     uint16_t id0, uint16_t id1,
> 
