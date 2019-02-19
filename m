Received: from eggs.gnu.org ([209.51.188.92]:51184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gw4pr-0004wk-Tx
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:49:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gw4pp-0007Om-7C
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:49:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44623)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gw4po-0007Nr-OW
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:49:17 -0500
Received: by mail-wr1-f65.google.com with SMTP id w2so7216501wrt.11
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 04:49:16 -0800 (PST)
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-2-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <095c8b8c-d33a-e972-d38f-b22b39d5c4b0@redhat.com>
Date: Tue, 19 Feb 2019 13:49:13 +0100
MIME-Version: 1.0
In-Reply-To: <20190218125615.18970-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/10] pflash: Rename pflash_t to
 PFlashCFI01, PFlashCFI02
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, alex.bennee@linaro.org, mreitz@redhat.com, qemu-ppc@nongnu.org, lersek@redhat.com

On 2/18/19 1:56 PM, Markus Armbruster wrote:
> flash.h's incomplete struct pflash_t is completed both in
> pflash_cfi01.c and in pflash_cfi02.c.  The complete types are
> incompatible.  This can hide type errors, such as passing a pflash_t
> created with pflash_cfi02_register() to pflash_cfi01_get_memory().
> 
> Furthermore, POSIX reserves typedef names ending with _t.
> 
> Rename the two structs to PFlashCFI01 and PFlashCFI02.

Why not ParallelFlashCFIxx?

Ideally ParallelFlashCFI would be an InterfaceInfo...

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/arm/vexpress.c        |  8 ++--
>  hw/block/pflash_cfi01.c  | 87 +++++++++++++++++++++-------------------
>  hw/block/pflash_cfi02.c  | 67 ++++++++++++++++---------------
>  hw/i386/pc_sysfw.c       |  2 +-
>  hw/mips/mips_malta.c     |  2 +-
>  hw/xtensa/xtfpga.c       | 10 ++---
>  include/hw/block/flash.h | 53 ++++++++++++++----------
>  7 files changed, 122 insertions(+), 107 deletions(-)
> 
> diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
> index c02d18ee61..ed46d2e730 100644
> --- a/hw/arm/vexpress.c
> +++ b/hw/arm/vexpress.c
> @@ -512,8 +512,8 @@ static void vexpress_modify_dtb(const struct arm_boot_info *info, void *fdt)
>  /* Open code a private version of pflash registration since we
>   * need to set non-default device width for VExpress platform.
>   */
> -static pflash_t *ve_pflash_cfi01_register(hwaddr base, const char *name,
> -                                          DriveInfo *di)
> +static PFlashCFI01 *ve_pflash_cfi01_register(hwaddr base, const char *name,
> +                                             DriveInfo *di)
>  {
>      DeviceState *dev = qdev_create(NULL, "cfi.pflash01");
>  
> @@ -536,7 +536,7 @@ static pflash_t *ve_pflash_cfi01_register(hwaddr base, const char *name,
>      qdev_init_nofail(dev);
>  
>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
> -    return OBJECT_CHECK(pflash_t, (dev), "cfi.pflash01");
> +    return OBJECT_CHECK(PFlashCFI01, (dev), "cfi.pflash01");
>  }
>  
>  static void vexpress_common_init(MachineState *machine)
> @@ -548,7 +548,7 @@ static void vexpress_common_init(MachineState *machine)
>      qemu_irq pic[64];
>      uint32_t sys_id;
>      DriveInfo *dinfo;
> -    pflash_t *pflash0;
> +    PFlashCFI01 *pflash0;
>      I2CBus *i2c;
>      ram_addr_t vram_size, sram_size;
>      MemoryRegion *sysmem = get_system_memory();
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index bffb4c40e7..9efa7aa9af 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -65,12 +65,13 @@ do {                                                        \
>  #define DPRINTF(fmt, ...) do { } while (0)
>  #endif
>  
> -#define CFI_PFLASH01(obj) OBJECT_CHECK(pflash_t, (obj), TYPE_CFI_PFLASH01)
> +#define CFI_PFLASH01(obj) \
> +    OBJECT_CHECK(PFlashCFI01, (obj), TYPE_CFI_PFLASH01)
>  
>  #define PFLASH_BE          0
>  #define PFLASH_SECURE      1
>  
> -struct pflash_t {
> +struct PFlashCFI01 {
>      /*< private >*/
>      SysBusDevice parent_obj;
>      /*< public >*/
> @@ -109,17 +110,17 @@ static const VMStateDescription vmstate_pflash = {
>      .minimum_version_id = 1,
>      .post_load = pflash_post_load,
>      .fields = (VMStateField[]) {
> -        VMSTATE_UINT8(wcycle, pflash_t),
> -        VMSTATE_UINT8(cmd, pflash_t),
> -        VMSTATE_UINT8(status, pflash_t),
> -        VMSTATE_UINT64(counter, pflash_t),
> +        VMSTATE_UINT8(wcycle, PFlashCFI01),
> +        VMSTATE_UINT8(cmd, PFlashCFI01),
> +        VMSTATE_UINT8(status, PFlashCFI01),
> +        VMSTATE_UINT64(counter, PFlashCFI01),
>          VMSTATE_END_OF_LIST()
>      }
>  };
>  
>  static void pflash_timer (void *opaque)
>  {
> -    pflash_t *pfl = opaque;
> +    PFlashCFI01 *pfl = opaque;
>  
>      trace_pflash_timer_expired(pfl->cmd);
>      /* Reset flash */
> @@ -133,7 +134,7 @@ static void pflash_timer (void *opaque)
>   * If this code is called we know we have a device_width set for
>   * this flash.
>   */
> -static uint32_t pflash_cfi_query(pflash_t *pfl, hwaddr offset)
> +static uint32_t pflash_cfi_query(PFlashCFI01 *pfl, hwaddr offset)
>  {
>      int i;
>      uint32_t resp = 0;
> @@ -193,7 +194,7 @@ static uint32_t pflash_cfi_query(pflash_t *pfl, hwaddr offset)
>  
>  
>  /* Perform a device id query based on the bank width of the flash. */
> -static uint32_t pflash_devid_query(pflash_t *pfl, hwaddr offset)
> +static uint32_t pflash_devid_query(PFlashCFI01 *pfl, hwaddr offset)
>  {
>      int i;
>      uint32_t resp;
> @@ -241,7 +242,7 @@ static uint32_t pflash_devid_query(pflash_t *pfl, hwaddr offset)
>      return resp;
>  }
>  
> -static uint32_t pflash_data_read(pflash_t *pfl, hwaddr offset,
> +static uint32_t pflash_data_read(PFlashCFI01 *pfl, hwaddr offset,
>                                   int width, int be)
>  {
>      uint8_t *p;
> @@ -284,7 +285,7 @@ static uint32_t pflash_data_read(pflash_t *pfl, hwaddr offset,
>      return ret;
>  }
>  
> -static uint32_t pflash_read (pflash_t *pfl, hwaddr offset,
> +static uint32_t pflash_read (PFlashCFI01 *pfl, hwaddr offset,
>                               int width, int be)
>  {
>      hwaddr boff;
> @@ -398,7 +399,7 @@ static uint32_t pflash_read (pflash_t *pfl, hwaddr offset,
>  }
>  
>  /* update flash content on disk */
> -static void pflash_update(pflash_t *pfl, int offset,
> +static void pflash_update(PFlashCFI01 *pfl, int offset,
>                            int size)
>  {
>      int offset_end;
> @@ -412,7 +413,7 @@ static void pflash_update(pflash_t *pfl, int offset,
>      }
>  }
>  
> -static inline void pflash_data_write(pflash_t *pfl, hwaddr offset,
> +static inline void pflash_data_write(PFlashCFI01 *pfl, hwaddr offset,
>                                       uint32_t value, int width, int be)
>  {
>      uint8_t *p = pfl->storage;
> @@ -448,7 +449,7 @@ static inline void pflash_data_write(pflash_t *pfl, hwaddr offset,
>  
>  }
>  
> -static void pflash_write(pflash_t *pfl, hwaddr offset,
> +static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
>                           uint32_t value, int width, int be)
>  {
>      uint8_t *p;
> @@ -654,7 +655,7 @@ static void pflash_write(pflash_t *pfl, hwaddr offset,
>  static MemTxResult pflash_mem_read_with_attrs(void *opaque, hwaddr addr, uint64_t *value,
>                                                unsigned len, MemTxAttrs attrs)
>  {
> -    pflash_t *pfl = opaque;
> +    PFlashCFI01 *pfl = opaque;
>      bool be = !!(pfl->features & (1 << PFLASH_BE));
>  
>      if ((pfl->features & (1 << PFLASH_SECURE)) && !attrs.secure) {
> @@ -668,7 +669,7 @@ static MemTxResult pflash_mem_read_with_attrs(void *opaque, hwaddr addr, uint64_
>  static MemTxResult pflash_mem_write_with_attrs(void *opaque, hwaddr addr, uint64_t value,
>                                                 unsigned len, MemTxAttrs attrs)
>  {
> -    pflash_t *pfl = opaque;
> +    PFlashCFI01 *pfl = opaque;
>      bool be = !!(pfl->features & (1 << PFLASH_BE));
>  
>      if ((pfl->features & (1 << PFLASH_SECURE)) && !attrs.secure) {
> @@ -687,7 +688,7 @@ static const MemoryRegionOps pflash_cfi01_ops = {
>  
>  static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
>  {
> -    pflash_t *pfl = CFI_PFLASH01(dev);
> +    PFlashCFI01 *pfl = CFI_PFLASH01(dev);
>      uint64_t total_len;
>      int ret;
>      uint64_t blocks_per_device, sector_len_per_device, device_len;
> @@ -864,14 +865,14 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
>  }
>  
>  static Property pflash_cfi01_properties[] = {
> -    DEFINE_PROP_DRIVE("drive", struct pflash_t, blk),
> +    DEFINE_PROP_DRIVE("drive", PFlashCFI01, blk),
>      /* num-blocks is the number of blocks actually visible to the guest,
>       * ie the total size of the device divided by the sector length.
>       * If we're emulating flash devices wired in parallel the actual
>       * number of blocks per indvidual device will differ.
>       */
> -    DEFINE_PROP_UINT32("num-blocks", struct pflash_t, nb_blocs, 0),
> -    DEFINE_PROP_UINT64("sector-length", struct pflash_t, sector_len, 0),
> +    DEFINE_PROP_UINT32("num-blocks", PFlashCFI01, nb_blocs, 0),
> +    DEFINE_PROP_UINT64("sector-length", PFlashCFI01, sector_len, 0),
>      /* width here is the overall width of this QEMU device in bytes.
>       * The QEMU device may be emulating a number of flash devices
>       * wired up in parallel; the width of each individual flash
> @@ -888,17 +889,17 @@ static Property pflash_cfi01_properties[] = {
>       * 16 bit devices making up a 32 bit wide QEMU device. This
>       * is deprecated for new uses of this device.
>       */
> -    DEFINE_PROP_UINT8("width", struct pflash_t, bank_width, 0),
> -    DEFINE_PROP_UINT8("device-width", struct pflash_t, device_width, 0),
> -    DEFINE_PROP_UINT8("max-device-width", struct pflash_t, max_device_width, 0),
> -    DEFINE_PROP_BIT("big-endian", struct pflash_t, features, PFLASH_BE, 0),
> -    DEFINE_PROP_BIT("secure", struct pflash_t, features, PFLASH_SECURE, 0),
> -    DEFINE_PROP_UINT16("id0", struct pflash_t, ident0, 0),
> -    DEFINE_PROP_UINT16("id1", struct pflash_t, ident1, 0),
> -    DEFINE_PROP_UINT16("id2", struct pflash_t, ident2, 0),
> -    DEFINE_PROP_UINT16("id3", struct pflash_t, ident3, 0),
> -    DEFINE_PROP_STRING("name", struct pflash_t, name),
> -    DEFINE_PROP_BOOL("old-multiple-chip-handling", struct pflash_t,
> +    DEFINE_PROP_UINT8("width", PFlashCFI01, bank_width, 0),
> +    DEFINE_PROP_UINT8("device-width", PFlashCFI01, device_width, 0),
> +    DEFINE_PROP_UINT8("max-device-width", PFlashCFI01, max_device_width, 0),
> +    DEFINE_PROP_BIT("big-endian", PFlashCFI01, features, PFLASH_BE, 0),
> +    DEFINE_PROP_BIT("secure", PFlashCFI01, features, PFLASH_SECURE, 0),
> +    DEFINE_PROP_UINT16("id0", PFlashCFI01, ident0, 0),
> +    DEFINE_PROP_UINT16("id1", PFlashCFI01, ident1, 0),
> +    DEFINE_PROP_UINT16("id2", PFlashCFI01, ident2, 0),
> +    DEFINE_PROP_UINT16("id3", PFlashCFI01, ident3, 0),
> +    DEFINE_PROP_STRING("name", PFlashCFI01, name),
> +    DEFINE_PROP_BOOL("old-multiple-chip-handling", PFlashCFI01,
>                       old_multiple_chip_handling, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> @@ -917,7 +918,7 @@ static void pflash_cfi01_class_init(ObjectClass *klass, void *data)
>  static const TypeInfo pflash_cfi01_info = {
>      .name           = TYPE_CFI_PFLASH01,
>      .parent         = TYPE_SYS_BUS_DEVICE,
> -    .instance_size  = sizeof(struct pflash_t),
> +    .instance_size  = sizeof(PFlashCFI01),
>      .class_init     = pflash_cfi01_class_init,
>  };
>  
> @@ -928,13 +929,15 @@ static void pflash_cfi01_register_types(void)
>  
>  type_init(pflash_cfi01_register_types)
>  
> -pflash_t *pflash_cfi01_register(hwaddr base,
> -                                DeviceState *qdev, const char *name,
> -                                hwaddr size,
> -                                BlockBackend *blk,
> -                                uint32_t sector_len, int nb_blocs,
> -                                int bank_width, uint16_t id0, uint16_t id1,
> -                                uint16_t id2, uint16_t id3, int be)
> +PFlashCFI01 *pflash_cfi01_register(hwaddr base,
> +                                   DeviceState *qdev, const char *name,
> +                                   hwaddr size,
> +                                   BlockBackend *blk,
> +                                   uint32_t sector_len, int nb_blocs,
> +                                   int bank_width,
> +                                   uint16_t id0, uint16_t id1,
> +                                   uint16_t id2, uint16_t id3,
> +                                   int be)
>  {
>      DeviceState *dev = qdev_create(NULL, TYPE_CFI_PFLASH01);
>  
> @@ -956,14 +959,14 @@ pflash_t *pflash_cfi01_register(hwaddr base,
>      return CFI_PFLASH01(dev);
>  }
>  
> -MemoryRegion *pflash_cfi01_get_memory(pflash_t *fl)
> +MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *fl)
>  {
>      return &fl->mem;
>  }
>  
>  static void postload_update_cb(void *opaque, int running, RunState state)
>  {
> -    pflash_t *pfl = opaque;
> +    PFlashCFI01 *pfl = opaque;
>  
>      /* This is called after bdrv_invalidate_cache_all.  */
>      qemu_del_vm_change_state_handler(pfl->vmstate);
> @@ -975,7 +978,7 @@ static void postload_update_cb(void *opaque, int running, RunState state)
>  
>  static int pflash_post_load(void *opaque, int version_id)
>  {
> -    pflash_t *pfl = opaque;
> +    PFlashCFI01 *pfl = opaque;
>  
>      if (!pfl->ro) {
>          pfl->vmstate = qemu_add_vm_change_state_handler(postload_update_cb,
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index 0f8b7b8c7b..424cc106d6 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -57,9 +57,10 @@ do {                                                       \
>  
>  #define PFLASH_LAZY_ROMD_THRESHOLD 42
>  
> -#define CFI_PFLASH02(obj) OBJECT_CHECK(pflash_t, (obj), TYPE_CFI_PFLASH02)
> +#define CFI_PFLASH02(obj) \
> +    OBJECT_CHECK(PFlashCFI02, (obj), TYPE_CFI_PFLASH02)
>  
> -struct pflash_t {
> +struct PFlashCFI02 {
>      /*< private >*/
>      SysBusDevice parent_obj;
>      /*< public >*/
> @@ -101,7 +102,7 @@ struct pflash_t {
>  /*
>   * Set up replicated mappings of the same region.
>   */
> -static void pflash_setup_mappings(pflash_t *pfl)
> +static void pflash_setup_mappings(PFlashCFI02 *pfl)
>  {
>      unsigned i;
>      hwaddr size = memory_region_size(&pfl->orig_mem);
> @@ -115,7 +116,7 @@ static void pflash_setup_mappings(pflash_t *pfl)
>      }
>  }
>  
> -static void pflash_register_memory(pflash_t *pfl, int rom_mode)
> +static void pflash_register_memory(PFlashCFI02 *pfl, int rom_mode)
>  {
>      memory_region_rom_device_set_romd(&pfl->orig_mem, rom_mode);
>      pfl->rom_mode = rom_mode;
> @@ -123,7 +124,7 @@ static void pflash_register_memory(pflash_t *pfl, int rom_mode)
>  
>  static void pflash_timer (void *opaque)
>  {
> -    pflash_t *pfl = opaque;
> +    PFlashCFI02 *pfl = opaque;
>  
>      trace_pflash_timer_expired(pfl->cmd);
>      /* Reset flash */
> @@ -137,7 +138,7 @@ static void pflash_timer (void *opaque)
>      pfl->cmd = 0;
>  }
>  
> -static uint32_t pflash_read (pflash_t *pfl, hwaddr offset,
> +static uint32_t pflash_read (PFlashCFI02 *pfl, hwaddr offset,
>                               int width, int be)
>  {
>      hwaddr boff;
> @@ -246,7 +247,7 @@ static uint32_t pflash_read (pflash_t *pfl, hwaddr offset,
>  }
>  
>  /* update flash content on disk */
> -static void pflash_update(pflash_t *pfl, int offset,
> +static void pflash_update(PFlashCFI02 *pfl, int offset,
>                            int size)
>  {
>      int offset_end;
> @@ -260,7 +261,7 @@ static void pflash_update(pflash_t *pfl, int offset,
>      }
>  }
>  
> -static void pflash_write (pflash_t *pfl, hwaddr offset,
> +static void pflash_write (PFlashCFI02 *pfl, hwaddr offset,
>                            uint32_t value, int width, int be)
>  {
>      hwaddr boff;
> @@ -533,7 +534,7 @@ static const MemoryRegionOps pflash_cfi02_ops_le = {
>  
>  static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
>  {
> -    pflash_t *pfl = CFI_PFLASH02(dev);
> +    PFlashCFI02 *pfl = CFI_PFLASH02(dev);
>      uint32_t chip_len;
>      int ret;
>      Error *local_err = NULL;
> @@ -679,19 +680,19 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
>  }
>  
>  static Property pflash_cfi02_properties[] = {
> -    DEFINE_PROP_DRIVE("drive", struct pflash_t, blk),
> -    DEFINE_PROP_UINT32("num-blocks", struct pflash_t, nb_blocs, 0),
> -    DEFINE_PROP_UINT32("sector-length", struct pflash_t, sector_len, 0),
> -    DEFINE_PROP_UINT8("width", struct pflash_t, width, 0),
> -    DEFINE_PROP_UINT8("mappings", struct pflash_t, mappings, 0),
> -    DEFINE_PROP_UINT8("big-endian", struct pflash_t, be, 0),
> -    DEFINE_PROP_UINT16("id0", struct pflash_t, ident0, 0),
> -    DEFINE_PROP_UINT16("id1", struct pflash_t, ident1, 0),
> -    DEFINE_PROP_UINT16("id2", struct pflash_t, ident2, 0),
> -    DEFINE_PROP_UINT16("id3", struct pflash_t, ident3, 0),
> -    DEFINE_PROP_UINT16("unlock-addr0", struct pflash_t, unlock_addr0, 0),
> -    DEFINE_PROP_UINT16("unlock-addr1", struct pflash_t, unlock_addr1, 0),
> -    DEFINE_PROP_STRING("name", struct pflash_t, name),
> +    DEFINE_PROP_DRIVE("drive", PFlashCFI02, blk),
> +    DEFINE_PROP_UINT32("num-blocks", PFlashCFI02, nb_blocs, 0),
> +    DEFINE_PROP_UINT32("sector-length", PFlashCFI02, sector_len, 0),
> +    DEFINE_PROP_UINT8("width", PFlashCFI02, width, 0),
> +    DEFINE_PROP_UINT8("mappings", PFlashCFI02, mappings, 0),
> +    DEFINE_PROP_UINT8("big-endian", PFlashCFI02, be, 0),
> +    DEFINE_PROP_UINT16("id0", PFlashCFI02, ident0, 0),
> +    DEFINE_PROP_UINT16("id1", PFlashCFI02, ident1, 0),
> +    DEFINE_PROP_UINT16("id2", PFlashCFI02, ident2, 0),
> +    DEFINE_PROP_UINT16("id3", PFlashCFI02, ident3, 0),
> +    DEFINE_PROP_UINT16("unlock-addr0", PFlashCFI02, unlock_addr0, 0),
> +    DEFINE_PROP_UINT16("unlock-addr1", PFlashCFI02, unlock_addr1, 0),
> +    DEFINE_PROP_STRING("name", PFlashCFI02, name),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> @@ -707,7 +708,7 @@ static void pflash_cfi02_class_init(ObjectClass *klass, void *data)
>  static const TypeInfo pflash_cfi02_info = {
>      .name           = TYPE_CFI_PFLASH02,
>      .parent         = TYPE_SYS_BUS_DEVICE,
> -    .instance_size  = sizeof(struct pflash_t),
> +    .instance_size  = sizeof(PFlashCFI02),
>      .class_init     = pflash_cfi02_class_init,
>  };
>  
> @@ -718,15 +719,17 @@ static void pflash_cfi02_register_types(void)
>  
>  type_init(pflash_cfi02_register_types)
>  
> -pflash_t *pflash_cfi02_register(hwaddr base,
> -                                DeviceState *qdev, const char *name,
> -                                hwaddr size,
> -                                BlockBackend *blk, uint32_t sector_len,
> -                                int nb_blocs, int nb_mappings, int width,
> -                                uint16_t id0, uint16_t id1,
> -                                uint16_t id2, uint16_t id3,
> -                                uint16_t unlock_addr0, uint16_t unlock_addr1,
> -                                int be)
> +PFlashCFI02 *pflash_cfi02_register(hwaddr base,
> +                                   DeviceState *qdev, const char *name,
> +                                   hwaddr size,
> +                                   BlockBackend *blk,
> +                                   uint32_t sector_len, int nb_blocs,
> +                                   int nb_mappings, int width,
> +                                   uint16_t id0, uint16_t id1,
> +                                   uint16_t id2, uint16_t id3,
> +                                   uint16_t unlock_addr0,
> +                                   uint16_t unlock_addr1,
> +                                   int be)
>  {
>      DeviceState *dev = qdev_create(NULL, TYPE_CFI_PFLASH02);
>  
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index 091e22dd60..67e55342f6 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -111,7 +111,7 @@ static void pc_system_flash_init(MemoryRegion *rom_memory)
>      char *fatal_errmsg = NULL;
>      hwaddr phys_addr = 0x100000000ULL;
>      int sector_bits, sector_size;
> -    pflash_t *system_flash;
> +    PFlashCFI01 *system_flash;
>      MemoryRegion *flash_mem;
>      char name[64];
>      void *flash_ptr;
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 74667766c2..fff5ed19bd 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1189,7 +1189,7 @@ void mips_malta_init(MachineState *machine)
>      const char *kernel_cmdline = machine->kernel_cmdline;
>      const char *initrd_filename = machine->initrd_filename;
>      char *filename;
> -    pflash_t *fl;
> +    PFlashCFI01 *fl;
>      MemoryRegion *system_memory = get_system_memory();
>      MemoryRegion *ram_high = g_new(MemoryRegion, 1);
>      MemoryRegion *ram_low_preio = g_new(MemoryRegion, 1);
> diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
> index ab3e52b415..3d59a7a356 100644
> --- a/hw/xtensa/xtfpga.c
> +++ b/hw/xtensa/xtfpga.c
> @@ -162,9 +162,9 @@ static void xtfpga_net_init(MemoryRegion *address_space,
>      memory_region_add_subregion(address_space, buffers, ram);
>  }
>  
> -static pflash_t *xtfpga_flash_init(MemoryRegion *address_space,
> -                                   const XtfpgaBoardDesc *board,
> -                                   DriveInfo *dinfo, int be)
> +static PFlashCFI01 *xtfpga_flash_init(MemoryRegion *address_space,
> +                                      const XtfpgaBoardDesc *board,
> +                                      DriveInfo *dinfo, int be)
>  {
>      SysBusDevice *s;
>      DeviceState *dev = qdev_create(NULL, "cfi.pflash01");
> @@ -181,7 +181,7 @@ static pflash_t *xtfpga_flash_init(MemoryRegion *address_space,
>      s = SYS_BUS_DEVICE(dev);
>      memory_region_add_subregion(address_space, board->flash->base,
>                                  sysbus_mmio_get_region(s, 0));
> -    return OBJECT_CHECK(pflash_t, (dev), "cfi.pflash01");
> +    return OBJECT_CHECK(PFlashCFI01, (dev), "cfi.pflash01");
>  }
>  
>  static uint64_t translate_phys_addr(void *opaque, uint64_t addr)
> @@ -229,7 +229,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
>      XtensaMxPic *mx_pic = NULL;
>      qemu_irq *extints;
>      DriveInfo *dinfo;
> -    pflash_t *flash = NULL;
> +    PFlashCFI01 *flash = NULL;
>      QemuOpts *machine_opts = qemu_get_machine_opts();
>      const char *kernel_filename = qemu_opt_get(machine_opts, "kernel");
>      const char *kernel_cmdline = qemu_opt_get(machine_opts, "append");
> diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
> index 67c3aa329e..51d8f60c65 100644
> --- a/include/hw/block/flash.h
> +++ b/include/hw/block/flash.h
> @@ -5,32 +5,41 @@
>  
>  #include "exec/memory.h"
>  
> -#define TYPE_CFI_PFLASH01 "cfi.pflash01"
> -#define TYPE_CFI_PFLASH02 "cfi.pflash02"
> -
> -typedef struct pflash_t pflash_t;
> -
>  /* pflash_cfi01.c */
> -pflash_t *pflash_cfi01_register(hwaddr base,
> -                                DeviceState *qdev, const char *name,
> -                                hwaddr size,
> -                                BlockBackend *blk,
> -                                uint32_t sector_len, int nb_blocs, int width,
> -                                uint16_t id0, uint16_t id1,
> -                                uint16_t id2, uint16_t id3, int be);
> +
> +#define TYPE_CFI_PFLASH01 "cfi.pflash01"
> +
> +typedef struct PFlashCFI01 PFlashCFI01;
> +
> +PFlashCFI01 *pflash_cfi01_register(hwaddr base,
> +                                   DeviceState *qdev, const char *name,
> +                                   hwaddr size,
> +                                   BlockBackend *blk,
> +                                   uint32_t sector_len, int nb_blocs,
> +                                   int width,
> +                                   uint16_t id0, uint16_t id1,
> +                                   uint16_t id2, uint16_t id3,
> +                                   int be);
> +MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *fl);
>  
>  /* pflash_cfi02.c */
> -pflash_t *pflash_cfi02_register(hwaddr base,
> -                                DeviceState *qdev, const char *name,
> -                                hwaddr size,
> -                                BlockBackend *blk, uint32_t sector_len,
> -                                int nb_blocs, int nb_mappings, int width,
> -                                uint16_t id0, uint16_t id1,
> -                                uint16_t id2, uint16_t id3,
> -                                uint16_t unlock_addr0, uint16_t unlock_addr1,
> -                                int be);
>  
> -MemoryRegion *pflash_cfi01_get_memory(pflash_t *fl);
> +#define TYPE_CFI_PFLASH02 "cfi.pflash02"
> +
> +typedef struct PFlashCFI02 PFlashCFI02;
> +
> +PFlashCFI02 *pflash_cfi02_register(hwaddr base,
> +                                   DeviceState *qdev, const char *name,
> +                                   hwaddr size,
> +                                   BlockBackend *blk,
> +                                   uint32_t sector_len, int nb_blocs,
> +                                   int nb_mappings,
> +                                   int width,
> +                                   uint16_t id0, uint16_t id1,
> +                                   uint16_t id2, uint16_t id3,
> +                                   uint16_t unlock_addr0,
> +                                   uint16_t unlock_addr1,
> +                                   int be);
>  
>  /* nand.c */
>  DeviceState *nand_init(BlockBackend *blk, int manf_id, int chip_id);
> 
