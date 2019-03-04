Received: from eggs.gnu.org ([209.51.188.92]:44421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0tdK-00047s-0F
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 14:52:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0tdH-0003aR-N2
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 14:52:17 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h0tdF-0003W4-K9
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 14:52:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id j125so365128wmj.1
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 11:52:11 -0800 (PST)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20190225183757.27378-1-armbru@redhat.com>
	<20190225183757.27378-7-armbru@redhat.com>
	<ede4b101-7390-4cef-a730-97ca194a51a2@redhat.com>
Message-ID: <ae6a1804-0303-b107-b27d-2c8fddc6afc1@redhat.com>
Date: Mon, 4 Mar 2019 20:52:08 +0100
MIME-Version: 1.0
In-Reply-To: <ede4b101-7390-4cef-a730-97ca194a51a2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 6/6] pc: Support firmware configuration
 with -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org, mst@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, lersek@redhat.com

On 3/4/19 8:14 PM, Philippe Mathieu-Daudé wrote:
> On 2/25/19 7:37 PM, Markus Armbruster wrote:
>> The PC machines put firmware in ROM by default.  To get it put into
>> flash memory (required by OVMF), you have to use -drive
>> if=pflash,unit=0,... and optionally -drive if=pflash,unit=1,...
>>
>> Why two -drive?  This permits setting up one part of the flash memory
>> read-only, and the other part read/write.  Below the hood, it creates
>> two separate flash devices, because we were too lazy to improve our
>> flash device models to support sector protection.
>>
>> The problem at hand is to do the same with -blockdev somehow, as one
>> more step towards deprecating -drive.
>>
>> Mapping -drive if=none,... to -blockdev is a solved problem.  With
>> if=T other than if=none, -drive additionally configures a block device
>> frontend.  For non-onboard devices, that part maps to -device.  Also a
>> solved problem.  For onboard devices such as PC flash memory, we have
>> an unsolved problem.
>>
>> This is actually an instance of a wider problem: our general device
>> configuration interface doesn't cover onboard devices.  Instead, we
>> have a zoo of ad hoc interfaces that are much more limited.  Some of
>> them we'd rather deprecate (-drive, -net), but can't until we have
>> suitable replacements.
>>
>> Sadly, I can't attack the wider problem today.  So back to the narrow
>> problem.
>>
>> My first idea was to reduce it to its solved buddy by using pluggable
>> instead of onboard devices for the flash memory.  Workable, but it
>> requires some extra smarts in firmware descriptors and libvirt.  Paolo
>> had an idea that is simpler for libvirt: keep the devices onboard, and
>> add machine properties for their block backends.
>>
>> The implementation is less than straightforward, I'm afraid.
>>
>> First, block backend properties are *qdev* properties.  Machines can't
>> have those, as they're not devices.  I could duplicate these qdev
>> properties as QOM properties, but I hate that.
>>
>> More seriously, the properties do not belong to the machine, they
>> belong to the onboard flash devices.  Adding them to the machine would
>> then require bad magic to somehow transfer them to the flash devices.
>> Fortunately, QOM provides the means to handle exactly this case: add
>> alias properties to the machine that forward to the onboard devices'
>> properties.
>>
>> Properties need to be created in .instance_init() methods.  For PC
>> machines, that's pc_machine_initfn().  To make alias properties work,
>> we need to create the onboard flash devices there, too.  Requires
>> several bug fixes, in the previous commits.  We also have to realize
>> the devices.  More on that below.
>>
>> If the user sets pflash0, firmware resides in flash memory.
>> pc_system_firmware_init() maps and realizes the flash devices.
>>
>> Else, firmware resides in ROM.  The onboard flash devices aren't used
>> then.  pc_system_firmware_init() destroys them unrealized, along with
>> the alias properties.  Except I can't figure out how to destroy the
>> devices correctly.  Marked FIXME.
>>
>> The existing code to pick up drives defined with -drive if=pflash is
>> replaced by code to desugar into the machine properties.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/block/pflash_cfi01.c  |   5 +
>>  hw/i386/pc.c             |   4 +-
>>  hw/i386/pc_sysfw.c       | 230 ++++++++++++++++++++++++++-------------
>>  include/hw/block/flash.h |   1 +
>>  include/hw/i386/pc.h     |   6 +-
>>  5 files changed, 168 insertions(+), 78 deletions(-)
>>
>> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
>> index 6ad27f4472..7c428bbf50 100644
>> --- a/hw/block/pflash_cfi01.c
>> +++ b/hw/block/pflash_cfi01.c
>> @@ -959,6 +959,11 @@ MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *fl)
>>      return &fl->mem;
>>  }
>>  
>> +BlockBackend *pflash_cfi01_get_blk(PFlashCFI01 *fl)
>> +{
>> +    return fl->blk;
>> +}
>> +
>>  static void postload_update_cb(void *opaque, int running, RunState state)
>>  {
>>      PFlashCFI01 *pfl = opaque;
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 3889eccdc3..420a0c5c9e 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1830,7 +1830,7 @@ void pc_memory_init(PCMachineState *pcms,
>>      }
>>  
>>      /* Initialize PC system firmware */
>> -    pc_system_firmware_init(rom_memory, !pcmc->pci_enabled);
>> +    pc_system_firmware_init(pcms, rom_memory);
>>  
>>      option_rom_mr = g_malloc(sizeof(*option_rom_mr));
>>      memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
>> @@ -2671,6 +2671,8 @@ static void pc_machine_initfn(Object *obj)
>>      pcms->smbus_enabled = true;
>>      pcms->sata_enabled = true;
>>      pcms->pit_enabled = true;
>> +
>> +    pc_system_flash_create(pcms);
>>  }
>>  
>>  static void pc_machine_reset(void)
>> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
>> index 34727c5b1f..98998e1ba8 100644
>> --- a/hw/i386/pc_sysfw.c
>> +++ b/hw/i386/pc_sysfw.c
>> @@ -76,7 +76,58 @@ static void pc_isa_bios_init(MemoryRegion *rom_memory,
>>      memory_region_set_readonly(isa_bios, true);
>>  }
>>  
>> -#define FLASH_MAP_UNIT_MAX 2
>> +static PFlashCFI01 *pc_pflash_create(const char *name)
>> +{
>> +    DeviceState *dev = qdev_create(NULL, TYPE_CFI_PFLASH01);
>> +
>> +    qdev_prop_set_uint64(dev, "sector-length", 4096);
> 
> 4 * KiB
> 
>> +    qdev_prop_set_uint8(dev, "width", 1);
>> +    qdev_prop_set_string(dev, "name", name);
>> +    return CFI_PFLASH01(dev);
>> +}
>> +
>> +void pc_system_flash_create(PCMachineState *pcms)
>> +{
>> +    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>> +
>> +    if (pcmc->pci_enabled) {
>> +        pcms->flash[0] = pc_pflash_create("system.flash0");
>> +        pcms->flash[1] = pc_pflash_create("system.flash1");
>> +        object_property_add_alias(OBJECT(pcms), "pflash0",
>> +                                  OBJECT(pcms->flash[0]), "drive",
>> +                                  &error_abort);
>> +        object_property_add_alias(OBJECT(pcms), "pflash1",
>> +                                  OBJECT(pcms->flash[1]), "drive",
>> +                                  &error_abort);
>> +    }
>> +}
>> +
>> +static void pc_system_flash_cleanup_unused(PCMachineState *pcms)
>> +{
>> +    char *prop_name;
>> +    int i;
>> +    Object *dev_obj;
>> +
>> +    assert(PC_MACHINE_GET_CLASS(pcms)->pci_enabled);
> 
> Since this assert is called unconditionally, we can move it to
> pc_system_firmware_init().
> 
>> +
>> +    for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
>> +        dev_obj = OBJECT(pcms->flash[i]);
>> +        if (!object_property_get_bool(dev_obj, "realized", &error_abort)) {
>> +            prop_name = g_strdup_printf("pflash%d", i);
>> +            object_property_del(OBJECT(pcms), prop_name, &error_abort);
>> +            g_free(prop_name);
>> +            /*
>> +             * FIXME delete @dev_obj.  Straight object_unref() is
>> +             * wrong, since it leaves dangling references in the
>> +             * parent bus behind.  object_unparent() doesn't work,
>> +             * either: since @dev_obj hasn't been realized,
>> +             * dev_obj->parent is null, and object_unparent() does
>> +             * nothing.
>> +             */

I forgot, apart from this comment and the hack patch you posted after
which I don't understand, for the rest:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>> +            pcms->flash[i] = NULL;
>> +        }
>> +    }
>> +}
>>  
>>  /* We don't have a theoretically justifiable exact lower bound on the base
>>   * address of any flash mapping. In practice, the IO-APIC MMIO range is
>> @@ -84,88 +135,78 @@ static void pc_isa_bios_init(MemoryRegion *rom_memory,
>>   * only 18MB-4KB below 4G. For now, restrict the cumulative mapping to 8MB in
>>   * size.
>>   */
>> -#define FLASH_MAP_BASE_MIN ((hwaddr)(4 * GiB - 8 * MiB))
>> +#define FLASH_SIZE_LIMIT (8 * MiB)
>>  
>> -/* This function maps flash drives from 4G downward, in order of their unit
>> - * numbers. The mapping starts at unit#0, with unit number increments of 1, and
>> - * stops before the first missing flash drive, or before
>> - * unit#FLASH_MAP_UNIT_MAX, whichever is reached first.
>> +/*
>> + * Map the pcms->flash[] from 4GiB downward, and realize.
>> + * Map them in descending order, i.e. pcms->flash[0] at the top,
>> + * without gaps.
>> + * Stop at the first pcms->flash[0] lacking a block backend.
>> + * Set each flash's size from its block backend.  Fatal error if the
>> + * size isn't a non-zero multiples of 4KiB, or the total size exceeds
> 
> Not related to this patch:
> 
> Looking at git history the commit introducing this is bd183c79b51 but
> there are no details about why it is required for 'PC'.
> Is it a backend requirement?
> If not, here we shouldn't care about underlying layout. It is the
> responsability of the pflash device to figure this out.
> 
> Somehow related to this patch:
> 
> I understand I could use 1 single flash of 16KiB, or 2 of 4KiB and this
> would work, I'm not sure coz haven't tested, are these real-world use cases?
> Now we have a 8MiB limit. Neither a real-world use case.
> Per commit 637a5acb46b this is OVMF related, also OVMF strictly uses 2
> flashes.
> IMHO there are too many checks around, and we could simplify.
> 
>> + * FLASH_SIZE_LIMIT.
>>   *
>> - * Addressing within one flash drive is of course not reversed.
>> - *
>> - * An error message is printed and the process exits if:
>> - * - the size of the backing file for a flash drive is non-positive, or not a
>> - *   multiple of the required sector size, or
>> - * - the current mapping's base address would fall below FLASH_MAP_BASE_MIN.
>> - *
>> - * The drive with unit#0 (if available) is mapped at the highest address, and
>> - * it is passed to pc_isa_bios_init(). Merging several drives for isa-bios is
>> + * If pcms->flash[0] has a block backend, its memory is passed to
>> + * pc_isa_bios_init().  Merging several flash devices for isa-bios is
>>   * not supported.
>>   */
>> -static void pc_system_flash_init(MemoryRegion *rom_memory)
>> +static void pc_system_flash_map(PCMachineState *pcms,
>> +                                MemoryRegion *rom_memory)
>>  {
>> -    int unit;
>> -    DriveInfo *pflash_drv;
>> +    hwaddr total_size = 0;
>> +    int i;
>>      BlockBackend *blk;
>>      int64_t size;
>> -    char *fatal_errmsg = NULL;
>> -    hwaddr phys_addr = 0x100000000ULL;
>>      uint32_t sector_size = 4096;
>>      PFlashCFI01 *system_flash;
>>      MemoryRegion *flash_mem;
>> -    char name[64];
>>      void *flash_ptr;
>>      int ret, flash_size;
>>  
>> -    for (unit = 0;
>> -         (unit < FLASH_MAP_UNIT_MAX &&
>> -          (pflash_drv = drive_get(IF_PFLASH, 0, unit)) != NULL);
>> -         ++unit) {
>> -        blk = blk_by_legacy_dinfo(pflash_drv);
>> +    assert(PC_MACHINE_GET_CLASS(pcms)->pci_enabled);
>> +
>> +    for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
>> +        system_flash = pcms->flash[i];
>> +        blk = pflash_cfi01_get_blk(system_flash);
>> +        if (!blk) {
>> +            break;
>> +        }
>>          size = blk_getlength(blk);
>>          if (size < 0) {
>> -            fatal_errmsg = g_strdup_printf("failed to get backing file size");
>> -        } else if (size == 0) {
>> -            fatal_errmsg = g_strdup_printf("PC system firmware (pflash) "
>> -                               "cannot have zero size");
>> -        } else if ((size % sector_size) != 0) {
>> -            fatal_errmsg = g_strdup_printf("PC system firmware (pflash) "
>> -                               "must be a multiple of 0x%x", sector_size);
>> -        } else if (phys_addr < size || phys_addr - size < FLASH_MAP_BASE_MIN) {
>> -            fatal_errmsg = g_strdup_printf("oversized backing file, pflash "
>> -                               "segments cannot be mapped under "
>> -                               TARGET_FMT_plx, FLASH_MAP_BASE_MIN);
>> +            error_report("can't get size of block device %s: %s",
>> +                         blk_name(blk), strerror(-size));
>> +            exit(1);
>>          }
>> -        if (fatal_errmsg != NULL) {
>> -            Location loc;
>> -
>> -            /* push a new, "none" location on the location stack; overwrite its
>> -             * contents with the location saved in the option; print the error
>> -             * (includes location); pop the top
>> -             */
>> -            loc_push_none(&loc);
>> -            if (pflash_drv->opts != NULL) {
>> -                qemu_opts_loc_restore(pflash_drv->opts);
>> -            }
>> -            error_report("%s", fatal_errmsg);
>> -            loc_pop(&loc);
>> -            g_free(fatal_errmsg);
>> +        if (size == 0) {
>> +            error_report("system firmware block device %s is empty",
>> +                         blk_name(blk));
>> +            exit(1);
>> +        }
>> +        if (size == 0 || size % sector_size != 0) {
>> +            error_report("system firmware block device %s has invalid size "
>> +                         "%" PRId64,
>> +                         blk_name(blk), size);
>> +            info_report("its size must be a non-zero multiple of 0x%x",
>> +                        sector_size);
>> +            exit(1);
>> +        }
>> +        if ((hwaddr)size != size
>> +            || total_size > HWADDR_MAX - size
>> +            || total_size + size > FLASH_SIZE_LIMIT) {
>> +            error_report("combined size of system firmware exceeds "
>> +                         "%" PRIu64 " bytes",
>> +                         FLASH_SIZE_LIMIT);
>>              exit(1);
>>          }
>>  
>> -        phys_addr -= size;
>> +        total_size += size;
>> +        qdev_prop_set_uint32(DEVICE(system_flash), "num-blocks",
>> +                             size / sector_size);
>> +        qdev_init_nofail(DEVICE(system_flash));
>> +        sysbus_mmio_map(SYS_BUS_DEVICE(system_flash), 0,
>> +                        0x100000000ULL - total_size);
>>  
>> -        /* pflash_cfi01_register() creates a deep copy of the name */
>> -        snprintf(name, sizeof name, "system.flash%d", unit);
>> -        system_flash = pflash_cfi01_register(phys_addr, name,
>> -                                             size, blk, sector_size,
>> -                                             1      /* width */,
>> -                                             0x0000 /* id0 */,
>> -                                             0x0000 /* id1 */,
>> -                                             0x0000 /* id2 */,
>> -                                             0x0000 /* id3 */,
>> -                                             0      /* be */);
>> -        if (unit == 0) {
>> +        if (i == 0) {
>>              flash_mem = pflash_cfi01_get_memory(system_flash);
>>              pc_isa_bios_init(rom_memory, flash_mem, size);
>>  
>> @@ -236,24 +277,63 @@ static void old_pc_system_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw)
>>                                  bios);
>>  }
>>  
>> -void pc_system_firmware_init(MemoryRegion *rom_memory, bool isapc_ram_fw)
>> +void pc_system_firmware_init(PCMachineState *pcms,
>> +                             MemoryRegion *rom_memory)
>>  {
>> +    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>> +    int i;
>>      DriveInfo *pflash_drv;
>> +    BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
>> +    Location loc;
>>  
>> -    pflash_drv = drive_get(IF_PFLASH, 0, 0);
>> -
>> -    if (isapc_ram_fw || pflash_drv == NULL) {
>> -        /* When a pflash drive is not found, use rom-mode */
>> -        old_pc_system_rom_init(rom_memory, isapc_ram_fw);
>> +    if (!pcmc->pci_enabled) {
>> +        old_pc_system_rom_init(rom_memory, true);
>>          return;
>>      }
>>  
>> -    if (kvm_enabled() && !kvm_readonly_mem_enabled()) {
>> -        /* Older KVM cannot execute from device memory. So, flash memory
>> -         * cannot be used unless the readonly memory kvm capability is present. */
>> -        fprintf(stderr, "qemu: pflash with kvm requires KVM readonly memory support\n");
>> -        exit(1);
>> +    /* Map legacy -drive if=pflash to machine properties */
>> +    for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
>> +        pflash_blk[i] = pflash_cfi01_get_blk(pcms->flash[i]);
>> +        pflash_drv = drive_get(IF_PFLASH, 0, i);
>> +        if (!pflash_drv) {
>> +            continue;
>> +        }
>> +        loc_push_none(&loc);
>> +        qemu_opts_loc_restore(pflash_drv->opts);
>> +        if (pflash_blk[i]) {
>> +            error_report("clashes with -machine");
>> +            exit(1);
>> +        }
>> +        pflash_blk[i] = blk_by_legacy_dinfo(pflash_drv);
>> +        qdev_prop_set_drive(DEVICE(pcms->flash[i]),
>> +                            "drive", pflash_blk[i], &error_fatal);
>> +        loc_pop(&loc);
>>      }
>>  
>> -    pc_system_flash_init(rom_memory);
>> +    /* Reject gaps */
>> +    for (i = 1; i < ARRAY_SIZE(pcms->flash); i++) {
>> +        if (pflash_blk[i] && !pflash_blk[i - 1]) {
>> +            error_report("pflash%d requires pflash%d", i, i - 1);
>> +            exit(1);
>> +        }
>> +    }
> 
> Or simpler:
> 
>        if (pflash_blk[1] && !pflash_blk[0]) {
>            error_report("pflash1 requires pflash0");
>            exit(1);
>        }
> 
>> +
>> +    if (!pflash_blk[0]) {
>> +        /* Machine property pflash0 not set, use ROM mode */
>> +        old_pc_system_rom_init(rom_memory, false);
>> +    } else {
>> +        if (kvm_enabled() && !kvm_readonly_mem_enabled()) {
>> +            /*
>> +             * Older KVM cannot execute from device memory. So, flash
>> +             * memory cannot be used unless the readonly memory kvm
>> +             * capability is present.
>> +             */
>> +            error_report("pflash with kvm requires KVM readonly memory support");
>> +            exit(1);
>> +        }
>> +
>> +        pc_system_flash_map(pcms, rom_memory);
>> +    }
>> +
>> +    pc_system_flash_cleanup_unused(pcms);
>>  }
>> diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
>> index 24b13eb525..91e0f8dd6e 100644
>> --- a/include/hw/block/flash.h
>> +++ b/include/hw/block/flash.h
>> @@ -22,6 +22,7 @@ PFlashCFI01 *pflash_cfi01_register(hwaddr base,
>>                                     uint16_t id0, uint16_t id1,
>>                                     uint16_t id2, uint16_t id3,
>>                                     int be);
>> +BlockBackend *pflash_cfi01_get_blk(PFlashCFI01 *fl);
>>  MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *fl);
>>  
>>  /* pflash_cfi02.c */
>> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>> index 3ff127ebd0..266639ca8c 100644
>> --- a/include/hw/i386/pc.h
>> +++ b/include/hw/i386/pc.h
>> @@ -6,6 +6,7 @@
>>  #include "hw/boards.h"
>>  #include "hw/isa/isa.h"
>>  #include "hw/block/fdc.h"
>> +#include "hw/block/flash.h"
>>  #include "net/net.h"
>>  #include "hw/i386/ioapic.h"
>>  
>> @@ -39,6 +40,7 @@ struct PCMachineState {
>>      PCIBus *bus;
>>      FWCfgState *fw_cfg;
>>      qemu_irq *gsi;
>> +    PFlashCFI01 *flash[2];
>>  
>>      /* Configuration options: */
>>      uint64_t max_ram_below_4g;
>> @@ -278,8 +280,8 @@ extern PCIDevice *piix4_dev;
>>  int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn);
>>  
>>  /* pc_sysfw.c */
>> -void pc_system_firmware_init(MemoryRegion *rom_memory,
>> -                             bool isapc_ram_fw);
>> +void pc_system_flash_create(PCMachineState *pcms);
>> +void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);
>>  
>>  /* acpi-build.c */
>>  void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
>>
