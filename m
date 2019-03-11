Received: from eggs.gnu.org ([209.51.188.92]:58403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3Lww-0000Uc-IU
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3Lwu-0003tb-QJ
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:30:42 -0400
References: <20190308131445.17502-1-armbru@redhat.com>
	<20190308131445.17502-12-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fde51cea-909c-6c63-7553-2b48d7d4ac45@redhat.com>
Date: Mon, 11 Mar 2019 15:30:19 +0100
MIME-Version: 1.0
In-Reply-To: <20190308131445.17502-12-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 11/12] pc: Support firmware
 configuration with -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, pkrempa@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, marcandre.lureau@redhat.com, philmd@redhat.com

On 08/03/19 14:14, Markus Armbruster wrote:
> The PC machines put firmware in ROM by default.  To get it put into
> flash memory (required by OVMF), you have to use -drive
> if=3Dpflash,unit=3D0,... and optionally -drive if=3Dpflash,unit=3D1,...
>=20
> Why two -drive?  This permits setting up one part of the flash memory
> read-only, and the other part read/write.  Below the hood, it creates
> two separate flash devices, because we were too lazy to improve our
> flash device models to support sector protection.

Not just that, it avoids the need to "upgrade the firmware" of old
virtual machines.  Instead, you just need to upgrade the files on the
host and restart QEMU, just like with non-UEFI firmware.

> This is actually an instance of a wider problem: our general device
> configuration interface doesn't cover onboard devices.  Instead, we
> have a zoo of ad hoc interfaces that are much more limited.  Some of
> them we'd rather deprecate (-drive, -net), but can't until we have
> suitable replacements.

-net already has a better replacement, -nic, which is basically "like
-netdev but also tell board creation code about it".  I suppose you'd
prefer that it were also accessible as "-netdev ...,id=3Dfoo -machine
net0=3Dfoo"?

> +static void pc_system_flash_cleanup_unused(PCMachineState *pcms)
> +{
> +    char *prop_name;
> +    int i;
> +    Object *dev_obj;
> +
> +    assert(PC_MACHINE_GET_CLASS(pcms)->pci_enabled);
> +
> +    for (i =3D 0; i < ARRAY_SIZE(pcms->flash); i++) {
> +        dev_obj =3D OBJECT(pcms->flash[i]);
> +        if (!object_property_get_bool(dev_obj, "realized", &error_abor=
t)) {
> +            prop_name =3D g_strdup_printf("pflash%d", i);
> +            object_property_del(OBJECT(pcms), prop_name, &error_abort)=
;

Why didn't this already call object->class->unparent?

> +            g_free(prop_name);
> +            /*
> +             * Delete @dev_obj.  Straight object_unref() is wrong,
> +             * since it leaves dangling references in the parent bus
> +             * behind.  object_unparent() doesn't work, either: since
> +             * @dev_obj hasn't been realized, dev_obj->parent is null,
> +             * and object_unparent() does nothing.

Does it work if you add the device yourself as a child of /machine,
instead of relying on /machine/unattached?

>   DeviceClass method
> +             * device_unparent() works, but we have to take a
> +             * temporary reference, or else device_unparent() commits
> +             * a use-after-free error.
> +             */
> +            object_ref(dev_obj);
> +            object_get_class(dev_obj)->unparent(dev_obj);
> +            object_unref(dev_obj);
> +            pcms->flash[i] =3D NULL;
> +        }

Paolo

> +    }
> +}
> +
> +/*
> + * Map the pcms->flash[] from 4GiB downward, and realize.
> + * Map them in descending order, i.e. pcms->flash[0] at the top,
> + * without gaps.
> + * Stop at the first pcms->flash[0] lacking a block backend.
> + * Set each flash's size from its block backend.  Fatal error if the
> + * size isn't a non-zero multiple of 4KiB, or the total size exceeds
> + * FLASH_SIZE_LIMIT.
>   *
> - * The drive with unit#0 (if available) is mapped at the highest addre=
ss, and
> - * it is passed to pc_isa_bios_init(). Merging several drives for isa-=
bios is
> + * If pcms->flash[0] has a block backend, its memory is passed to
> + * pc_isa_bios_init().  Merging several flash devices for isa-bios is
>   * not supported.
>   */
> -static void pc_system_flash_init(MemoryRegion *rom_memory)
> +static void pc_system_flash_map(PCMachineState *pcms,
> +                                MemoryRegion *rom_memory)
>  {
> -    int unit;
> -    DriveInfo *pflash_drv;
> +    hwaddr total_size =3D 0;
> +    int i;
>      BlockBackend *blk;
>      int64_t size;
> -    char *fatal_errmsg =3D NULL;
> -    hwaddr phys_addr =3D 0x100000000ULL;
> -    uint32_t sector_size =3D 4096;
>      PFlashCFI01 *system_flash;
>      MemoryRegion *flash_mem;
> -    char name[64];
>      void *flash_ptr;
>      int ret, flash_size;
> =20
> -    for (unit =3D 0;
> -         (unit < FLASH_MAP_UNIT_MAX &&
> -          (pflash_drv =3D drive_get(IF_PFLASH, 0, unit)) !=3D NULL);
> -         ++unit) {
> -        blk =3D blk_by_legacy_dinfo(pflash_drv);
> +    assert(PC_MACHINE_GET_CLASS(pcms)->pci_enabled);
> +
> +    for (i =3D 0; i < ARRAY_SIZE(pcms->flash); i++) {
> +        system_flash =3D pcms->flash[i];
> +        blk =3D pflash_cfi01_get_blk(system_flash);
> +        if (!blk) {
> +            break;
> +        }
>          size =3D blk_getlength(blk);
>          if (size < 0) {
> -            fatal_errmsg =3D g_strdup_printf("failed to get backing fi=
le size");
> -        } else if (size =3D=3D 0) {
> -            fatal_errmsg =3D g_strdup_printf("PC system firmware (pfla=
sh) "
> -                               "cannot have zero size");
> -        } else if ((size % sector_size) !=3D 0) {
> -            fatal_errmsg =3D g_strdup_printf("PC system firmware (pfla=
sh) "
> -                               "must be a multiple of 0x%x", sector_si=
ze);
> -        } else if (phys_addr < size || phys_addr - size < FLASH_MAP_BA=
SE_MIN) {
> -            fatal_errmsg =3D g_strdup_printf("oversized backing file, =
pflash "
> -                               "segments cannot be mapped under "
> -                               TARGET_FMT_plx, FLASH_MAP_BASE_MIN);
> +            error_report("can't get size of block device %s: %s",
> +                         blk_name(blk), strerror(-size));
> +            exit(1);
>          }
> -        if (fatal_errmsg !=3D NULL) {
> -            Location loc;
> -
> -            /* push a new, "none" location on the location stack; over=
write its
> -             * contents with the location saved in the option; print t=
he error
> -             * (includes location); pop the top
> -             */
> -            loc_push_none(&loc);
> -            if (pflash_drv->opts !=3D NULL) {
> -                qemu_opts_loc_restore(pflash_drv->opts);
> -            }
> -            error_report("%s", fatal_errmsg);
> -            loc_pop(&loc);
> -            g_free(fatal_errmsg);
> +        if (size =3D=3D 0 || size % FLASH_SECTOR_SIZE !=3D 0) {
> +            error_report("system firmware block device %s has invalid =
size "
> +                         "%" PRId64,
> +                         blk_name(blk), size);
> +            info_report("its size must be a non-zero multiple of 0x%x"=
,
> +                        FLASH_SECTOR_SIZE);
> +            exit(1);
> +        }
> +        if ((hwaddr)size !=3D size
> +            || total_size > HWADDR_MAX - size
> +            || total_size + size > FLASH_SIZE_LIMIT) {
> +            error_report("combined size of system firmware exceeds "
> +                         "%" PRIu64 " bytes",
> +                         FLASH_SIZE_LIMIT);
>              exit(1);
>          }
> =20
> -        phys_addr -=3D size;
> +        total_size +=3D size;
> +        qdev_prop_set_uint32(DEVICE(system_flash), "num-blocks",
> +                             size / FLASH_SECTOR_SIZE);
> +        qdev_init_nofail(DEVICE(system_flash));
> +        sysbus_mmio_map(SYS_BUS_DEVICE(system_flash), 0,
> +                        0x100000000ULL - total_size);
> =20
> -        /* pflash_cfi01_register() creates a deep copy of the name */
> -        snprintf(name, sizeof name, "system.flash%d", unit);
> -        system_flash =3D pflash_cfi01_register(phys_addr, name,
> -                                             size, blk, sector_size,
> -                                             1      /* width */,
> -                                             0x0000 /* id0 */,
> -                                             0x0000 /* id1 */,
> -                                             0x0000 /* id2 */,
> -                                             0x0000 /* id3 */,
> -                                             0      /* be */);
> -        if (unit =3D=3D 0) {
> +        if (i =3D=3D 0) {
>              flash_mem =3D pflash_cfi01_get_memory(system_flash);
>              pc_isa_bios_init(rom_memory, flash_mem, size);
> =20
> @@ -235,23 +278,59 @@ void pc_system_firmware_init(PCMachineState *pcms=
,
>                               MemoryRegion *rom_memory)
>  {
>      PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
> -    bool isapc_ram_fw =3D !pcmc->pci_enabled;
> +    int i;
>      DriveInfo *pflash_drv;
> +    BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
> +    Location loc;
> =20
> -    pflash_drv =3D drive_get(IF_PFLASH, 0, 0);
> -
> -    if (isapc_ram_fw || pflash_drv =3D=3D NULL) {
> -        /* When a pflash drive is not found, use rom-mode */
> -        old_pc_system_rom_init(rom_memory, isapc_ram_fw);
> +    if (!pcmc->pci_enabled) {
> +        old_pc_system_rom_init(rom_memory, true);
>          return;
>      }
> =20
> -    if (kvm_enabled() && !kvm_readonly_mem_enabled()) {
> -        /* Older KVM cannot execute from device memory. So, flash memo=
ry
> -         * cannot be used unless the readonly memory kvm capability is=
 present. */
> -        fprintf(stderr, "qemu: pflash with kvm requires KVM readonly m=
emory support\n");
> -        exit(1);
> +    /* Map legacy -drive if=3Dpflash to machine properties */
> +    for (i =3D 0; i < ARRAY_SIZE(pcms->flash); i++) {
> +        pflash_blk[i] =3D pflash_cfi01_get_blk(pcms->flash[i]);
> +        pflash_drv =3D drive_get(IF_PFLASH, 0, i);
> +        if (!pflash_drv) {
> +            continue;
> +        }
> +        loc_push_none(&loc);
> +        qemu_opts_loc_restore(pflash_drv->opts);
> +        if (pflash_blk[i]) {
> +            error_report("clashes with -machine");
> +            exit(1);
> +        }
> +        pflash_blk[i] =3D blk_by_legacy_dinfo(pflash_drv);
> +        qdev_prop_set_drive(DEVICE(pcms->flash[i]),
> +                            "drive", pflash_blk[i], &error_fatal);
> +        loc_pop(&loc);
>      }
> =20
> -    pc_system_flash_init(rom_memory);
> +    /* Reject gaps */
> +    for (i =3D 1; i < ARRAY_SIZE(pcms->flash); i++) {
> +        if (pflash_blk[i] && !pflash_blk[i - 1]) {
> +            error_report("pflash%d requires pflash%d", i, i - 1);
> +            exit(1);
> +        }
> +    }
> +
> +    if (!pflash_blk[0]) {
> +        /* Machine property pflash0 not set, use ROM mode */
> +        old_pc_system_rom_init(rom_memory, false);
> +    } else {
> +        if (kvm_enabled() && !kvm_readonly_mem_enabled()) {
> +            /*
> +             * Older KVM cannot execute from device memory. So, flash
> +             * memory cannot be used unless the readonly memory kvm
> +             * capability is present.
> +             */
> +            error_report("pflash with kvm requires KVM readonly memory=
 support");
> +            exit(1);
> +        }
> +
> +        pc_system_flash_map(pcms, rom_memory);
> +    }
> +
> +    pc_system_flash_cleanup_unused(pcms);
>  }
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 4f5ed7cefc..276ff15d4d 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -6,6 +6,7 @@
>  #include "hw/boards.h"
>  #include "hw/isa/isa.h"
>  #include "hw/block/fdc.h"
> +#include "hw/block/flash.h"
>  #include "net/net.h"
>  #include "hw/i386/ioapic.h"
> =20
> @@ -39,6 +40,7 @@ struct PCMachineState {
>      PCIBus *bus;
>      FWCfgState *fw_cfg;
>      qemu_irq *gsi;
> +    PFlashCFI01 *flash[2];
> =20
>      /* Configuration options: */
>      uint64_t max_ram_below_4g;
> @@ -277,6 +279,7 @@ extern PCIDevice *piix4_dev;
>  int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn);
> =20
>  /* pc_sysfw.c */
> +void pc_system_flash_create(PCMachineState *pcms);
>  void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_m=
emory);
> =20
>  /* acpi-build.c */
>=20
