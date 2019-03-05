Received: from eggs.gnu.org ([209.51.188.92]:40165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h18JM-000683-0g
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 06:32:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h18JH-0005Eb-A2
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 06:32:38 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190225183757.27378-1-armbru@redhat.com>
	<20190225183757.27378-7-armbru@redhat.com>
	<ede4b101-7390-4cef-a730-97ca194a51a2@redhat.com>
Date: Tue, 05 Mar 2019 12:31:49 +0100
In-Reply-To: <ede4b101-7390-4cef-a730-97ca194a51a2@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 4 Mar 2019 20:14:41
	+0100")
Message-ID: <87y35tsgka.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org, mst@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, lersek@redhat.com

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 2/25/19 7:37 PM, Markus Armbruster wrote:
>> The PC machines put firmware in ROM by default.  To get it put into
>> flash memory (required by OVMF), you have to use -drive
>> if=3Dpflash,unit=3D0,... and optionally -drive if=3Dpflash,unit=3D1,...
>>=20
>> Why two -drive?  This permits setting up one part of the flash memory
>> read-only, and the other part read/write.  Below the hood, it creates
>> two separate flash devices, because we were too lazy to improve our
>> flash device models to support sector protection.
>>=20
>> The problem at hand is to do the same with -blockdev somehow, as one
>> more step towards deprecating -drive.
>>=20
>> Mapping -drive if=3Dnone,... to -blockdev is a solved problem.  With
>> if=3DT other than if=3Dnone, -drive additionally configures a block devi=
ce
>> frontend.  For non-onboard devices, that part maps to -device.  Also a
>> solved problem.  For onboard devices such as PC flash memory, we have
>> an unsolved problem.
>>=20
>> This is actually an instance of a wider problem: our general device
>> configuration interface doesn't cover onboard devices.  Instead, we
>> have a zoo of ad hoc interfaces that are much more limited.  Some of
>> them we'd rather deprecate (-drive, -net), but can't until we have
>> suitable replacements.
>>=20
>> Sadly, I can't attack the wider problem today.  So back to the narrow
>> problem.
>>=20
>> My first idea was to reduce it to its solved buddy by using pluggable
>> instead of onboard devices for the flash memory.  Workable, but it
>> requires some extra smarts in firmware descriptors and libvirt.  Paolo
>> had an idea that is simpler for libvirt: keep the devices onboard, and
>> add machine properties for their block backends.
>>=20
>> The implementation is less than straightforward, I'm afraid.
>>=20
>> First, block backend properties are *qdev* properties.  Machines can't
>> have those, as they're not devices.  I could duplicate these qdev
>> properties as QOM properties, but I hate that.
>>=20
>> More seriously, the properties do not belong to the machine, they
>> belong to the onboard flash devices.  Adding them to the machine would
>> then require bad magic to somehow transfer them to the flash devices.
>> Fortunately, QOM provides the means to handle exactly this case: add
>> alias properties to the machine that forward to the onboard devices'
>> properties.
>>=20
>> Properties need to be created in .instance_init() methods.  For PC
>> machines, that's pc_machine_initfn().  To make alias properties work,
>> we need to create the onboard flash devices there, too.  Requires
>> several bug fixes, in the previous commits.  We also have to realize
>> the devices.  More on that below.
>>=20
>> If the user sets pflash0, firmware resides in flash memory.
>> pc_system_firmware_init() maps and realizes the flash devices.
>>=20
>> Else, firmware resides in ROM.  The onboard flash devices aren't used
>> then.  pc_system_firmware_init() destroys them unrealized, along with
>> the alias properties.  Except I can't figure out how to destroy the
>> devices correctly.  Marked FIXME.
>>=20
>> The existing code to pick up drives defined with -drive if=3Dpflash is
>> replaced by code to desugar into the machine properties.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/block/pflash_cfi01.c  |   5 +
>>  hw/i386/pc.c             |   4 +-
>>  hw/i386/pc_sysfw.c       | 230 ++++++++++++++++++++++++++-------------
>>  include/hw/block/flash.h |   1 +
>>  include/hw/i386/pc.h     |   6 +-
>>  5 files changed, 168 insertions(+), 78 deletions(-)
>>=20
>> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
>> index 6ad27f4472..7c428bbf50 100644
>> --- a/hw/block/pflash_cfi01.c
>> +++ b/hw/block/pflash_cfi01.c
>> @@ -959,6 +959,11 @@ MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *=
fl)
>>      return &fl->mem;
>>  }
>>=20=20
>> +BlockBackend *pflash_cfi01_get_blk(PFlashCFI01 *fl)
>> +{
>> +    return fl->blk;
>> +}
>> +
>>  static void postload_update_cb(void *opaque, int running, RunState stat=
e)
>>  {
>>      PFlashCFI01 *pfl =3D opaque;
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 3889eccdc3..420a0c5c9e 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1830,7 +1830,7 @@ void pc_memory_init(PCMachineState *pcms,
>>      }
>>=20=20
>>      /* Initialize PC system firmware */
>> -    pc_system_firmware_init(rom_memory, !pcmc->pci_enabled);
>> +    pc_system_firmware_init(pcms, rom_memory);
>>=20=20
>>      option_rom_mr =3D g_malloc(sizeof(*option_rom_mr));
>>      memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
>> @@ -2671,6 +2671,8 @@ static void pc_machine_initfn(Object *obj)
>>      pcms->smbus_enabled =3D true;
>>      pcms->sata_enabled =3D true;
>>      pcms->pit_enabled =3D true;
>> +
>> +    pc_system_flash_create(pcms);
>>  }
>>=20=20
>>  static void pc_machine_reset(void)
>> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
>> index 34727c5b1f..98998e1ba8 100644
>> --- a/hw/i386/pc_sysfw.c
>> +++ b/hw/i386/pc_sysfw.c
>> @@ -76,7 +76,58 @@ static void pc_isa_bios_init(MemoryRegion *rom_memory,
>>      memory_region_set_readonly(isa_bios, true);
>>  }
>>=20=20
>> -#define FLASH_MAP_UNIT_MAX 2
>> +static PFlashCFI01 *pc_pflash_create(const char *name)
>> +{
>> +    DeviceState *dev =3D qdev_create(NULL, TYPE_CFI_PFLASH01);
>> +
>> +    qdev_prop_set_uint64(dev, "sector-length", 4096);
>
> 4 * KiB

Feels like a wash to me.  We use 4096 far more often than 4 * KiB.
Anyone else got a preference?

>> +    qdev_prop_set_uint8(dev, "width", 1);
>> +    qdev_prop_set_string(dev, "name", name);
>> +    return CFI_PFLASH01(dev);
>> +}
>> +
>> +void pc_system_flash_create(PCMachineState *pcms)
>> +{
>> +    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
>> +
>> +    if (pcmc->pci_enabled) {
>> +        pcms->flash[0] =3D pc_pflash_create("system.flash0");
>> +        pcms->flash[1] =3D pc_pflash_create("system.flash1");
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

pc_system_firmware_init() populates pcms->flash[] when ->pci_enabled.  I
systematically assert ->pci_enabled before using pcms->flash[].  The
assertion does double-duty as documentation.

>> +
>> +    for (i =3D 0; i < ARRAY_SIZE(pcms->flash); i++) {
>> +        dev_obj =3D OBJECT(pcms->flash[i]);
>> +        if (!object_property_get_bool(dev_obj, "realized", &error_abort=
)) {
>> +            prop_name =3D g_strdup_printf("pflash%d", i);
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
>> +            pcms->flash[i] =3D NULL;
>> +        }
>> +    }
>> +}
>>=20=20
>>  /* We don't have a theoretically justifiable exact lower bound on the b=
ase
>>   * address of any flash mapping. In practice, the IO-APIC MMIO range is
>> @@ -84,88 +135,78 @@ static void pc_isa_bios_init(MemoryRegion *rom_memo=
ry,
>>   * only 18MB-4KB below 4G. For now, restrict the cumulative mapping to =
8MB in
>>   * size.
>>   */
>> -#define FLASH_MAP_BASE_MIN ((hwaddr)(4 * GiB - 8 * MiB))
>> +#define FLASH_SIZE_LIMIT (8 * MiB)
>>=20=20
>> -/* This function maps flash drives from 4G downward, in order of their =
unit
>> - * numbers. The mapping starts at unit#0, with unit number increments o=
f 1, and
>> - * stops before the first missing flash drive, or before
>> - * unit#FLASH_MAP_UNIT_MAX, whichever is reached first.
>> +/*
>> + * Map the pcms->flash[] from 4GiB downward, and realize.
>> + * Map them in descending order, i.e. pcms->flash[0] at the top,
>> + * without gaps.
>> + * Stop at the first pcms->flash[0] lacking a block backend.
>> + * Set each flash's size from its block backend.  Fatal error if the
>> + * size isn't a non-zero multiples of 4KiB, or the total size exceeds

Note to self: non-zero multiple

> Not related to this patch:
>
> Looking at git history the commit introducing this is bd183c79b51 but
> there are no details about why it is required for 'PC'.

By "this" you mean "size must be a multiple of 4KiB"?

> Is it a backend requirement?
> If not, here we shouldn't care about underlying layout. It is the
> responsability of the pflash device to figure this out.
>
> Somehow related to this patch:
>
> I understand I could use 1 single flash of 16KiB, or 2 of 4KiB and this
> would work, I'm not sure coz haven't tested, are these real-world use cas=
es?
> Now we have a 8MiB limit. Neither a real-world use case.
> Per commit 637a5acb46b this is OVMF related, also OVMF strictly uses 2
> flashes.

Actual use cases:

* Configuring flash memory backed by a firmware image

  Initial OVMF support, looks like

    -drive if=3Dpflash,format=3Draw,file=3D/where/ever/OVMF.fd

* Configuring flash memory backed by two firmware images, one read-only,
  and one read/write

  Current OVMF support, looks like

    -drive if=3Dpflash,format=3Draw,readonly,file=3D/usr/share/OVMF/OVMF_CO=
DE.fd
    -drive if=3Dpflash,format=3Draw,file=3D/where/ever/OVMF_VARS.fd

  Below the hood, this creates two separate flash chips, because we
  couldn't be bothered to implement sector protection.  I hate that.

  I figure this use case requires "no gap between the two flash chips".

I'm not aware of any other use case with PC machines.

Limiting total flash size is a good idea, because without it, users
could configure flash that overlaps other stuff, which can only end in
tears.

Note that the code can handle any number of units up to a limit set at
compile time.  That limit is #define FLASH_MAP_UNIT_MAX 2.

> IMHO there are too many checks around, and we could simplify.

I agree this magic board code is more general than necessary.  I
actually argued for picking *one* size of flash and be done with it, or
maybe a few sizes, if firmware developers really, really wants that:

    The size of the flash chip is a property of the machine.  It is *fixed*.
    Using whatever size the image has is sloppy modelling.

    A machine may come in minor variations that aren't worth their own
    machine type.  One such variation could be a different flash chip size.
    Using the image size to select one from the set of fixed sizes is
    tolerable.

    Subject: Re: [PATCH v2] hw/block: report when pflash backing file isn't=
 aligned
    Message-ID: <87lg2hujld.fsf@dusky.pond.sub.org>
    Date: Fri, 15 Feb 2019 17:01:18 +0100
    https://lists.nongnu.org/archive/html/qemu-devel/2019-02/msg04268.html

But L=C3=A1szl=C3=B3 objected.

I still think offering powers of two between 64KiB and 8MiB (or whatever
upper limit we can agree upon) would satisfy all practical needs and
then some.

>> + * FLASH_SIZE_LIMIT.
>>   *
>> - * Addressing within one flash drive is of course not reversed.
>> - *
>> - * An error message is printed and the process exits if:
>> - * - the size of the backing file for a flash drive is non-positive, or=
 not a
>> - *   multiple of the required sector size, or
>> - * - the current mapping's base address would fall below FLASH_MAP_BASE=
_MIN.
>> - *
>> - * The drive with unit#0 (if available) is mapped at the highest addres=
s, and
>> - * it is passed to pc_isa_bios_init(). Merging several drives for isa-b=
ios is
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
>> +    hwaddr total_size =3D 0;
>> +    int i;
>>      BlockBackend *blk;
>>      int64_t size;
>> -    char *fatal_errmsg =3D NULL;
>> -    hwaddr phys_addr =3D 0x100000000ULL;
>>      uint32_t sector_size =3D 4096;
>>      PFlashCFI01 *system_flash;
>>      MemoryRegion *flash_mem;
>> -    char name[64];
>>      void *flash_ptr;
>>      int ret, flash_size;
>>=20=20
>> -    for (unit =3D 0;
>> -         (unit < FLASH_MAP_UNIT_MAX &&
>> -          (pflash_drv =3D drive_get(IF_PFLASH, 0, unit)) !=3D NULL);
>> -         ++unit) {
>> -        blk =3D blk_by_legacy_dinfo(pflash_drv);
>> +    assert(PC_MACHINE_GET_CLASS(pcms)->pci_enabled);
>> +
>> +    for (i =3D 0; i < ARRAY_SIZE(pcms->flash); i++) {
>> +        system_flash =3D pcms->flash[i];
>> +        blk =3D pflash_cfi01_get_blk(system_flash);
>> +        if (!blk) {
>> +            break;
>> +        }
>>          size =3D blk_getlength(blk);
>>          if (size < 0) {
>> -            fatal_errmsg =3D g_strdup_printf("failed to get backing fil=
e size");
>> -        } else if (size =3D=3D 0) {
>> -            fatal_errmsg =3D g_strdup_printf("PC system firmware (pflas=
h) "
>> -                               "cannot have zero size");
>> -        } else if ((size % sector_size) !=3D 0) {
>> -            fatal_errmsg =3D g_strdup_printf("PC system firmware (pflas=
h) "
>> -                               "must be a multiple of 0x%x", sector_siz=
e);
>> -        } else if (phys_addr < size || phys_addr - size < FLASH_MAP_BAS=
E_MIN) {
>> -            fatal_errmsg =3D g_strdup_printf("oversized backing file, p=
flash "
>> -                               "segments cannot be mapped under "
>> -                               TARGET_FMT_plx, FLASH_MAP_BASE_MIN);
>> +            error_report("can't get size of block device %s: %s",
>> +                         blk_name(blk), strerror(-size));
>> +            exit(1);
>>          }
>> -        if (fatal_errmsg !=3D NULL) {
>> -            Location loc;
>> -
>> -            /* push a new, "none" location on the location stack; overw=
rite its
>> -             * contents with the location saved in the option; print th=
e error
>> -             * (includes location); pop the top
>> -             */
>> -            loc_push_none(&loc);
>> -            if (pflash_drv->opts !=3D NULL) {
>> -                qemu_opts_loc_restore(pflash_drv->opts);
>> -            }
>> -            error_report("%s", fatal_errmsg);
>> -            loc_pop(&loc);
>> -            g_free(fatal_errmsg);
>> +        if (size =3D=3D 0) {
>> +            error_report("system firmware block device %s is empty",
>> +                         blk_name(blk));
>> +            exit(1);
>> +        }
>> +        if (size =3D=3D 0 || size % sector_size !=3D 0) {
>> +            error_report("system firmware block device %s has invalid s=
ize "
>> +                         "%" PRId64,
>> +                         blk_name(blk), size);
>> +            info_report("its size must be a non-zero multiple of 0x%x",
>> +                        sector_size);
>> +            exit(1);
>> +        }
>> +        if ((hwaddr)size !=3D size
>> +            || total_size > HWADDR_MAX - size
>> +            || total_size + size > FLASH_SIZE_LIMIT) {
>> +            error_report("combined size of system firmware exceeds "
>> +                         "%" PRIu64 " bytes",
>> +                         FLASH_SIZE_LIMIT);
>>              exit(1);
>>          }
>>=20=20
>> -        phys_addr -=3D size;
>> +        total_size +=3D size;
>> +        qdev_prop_set_uint32(DEVICE(system_flash), "num-blocks",
>> +                             size / sector_size);
>> +        qdev_init_nofail(DEVICE(system_flash));
>> +        sysbus_mmio_map(SYS_BUS_DEVICE(system_flash), 0,
>> +                        0x100000000ULL - total_size);
>>=20=20
>> -        /* pflash_cfi01_register() creates a deep copy of the name */
>> -        snprintf(name, sizeof name, "system.flash%d", unit);
>> -        system_flash =3D pflash_cfi01_register(phys_addr, name,
>> -                                             size, blk, sector_size,
>> -                                             1      /* width */,
>> -                                             0x0000 /* id0 */,
>> -                                             0x0000 /* id1 */,
>> -                                             0x0000 /* id2 */,
>> -                                             0x0000 /* id3 */,
>> -                                             0      /* be */);
>> -        if (unit =3D=3D 0) {
>> +        if (i =3D=3D 0) {
>>              flash_mem =3D pflash_cfi01_get_memory(system_flash);
>>              pc_isa_bios_init(rom_memory, flash_mem, size);
>>=20=20
>> @@ -236,24 +277,63 @@ static void old_pc_system_rom_init(MemoryRegion *r=
om_memory, bool isapc_ram_fw)
>>                                  bios);
>>  }
>>=20=20
>> -void pc_system_firmware_init(MemoryRegion *rom_memory, bool isapc_ram_f=
w)
>> +void pc_system_firmware_init(PCMachineState *pcms,
>> +                             MemoryRegion *rom_memory)
>>  {
>> +    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
>> +    int i;
>>      DriveInfo *pflash_drv;
>> +    BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
>> +    Location loc;
>>=20=20
>> -    pflash_drv =3D drive_get(IF_PFLASH, 0, 0);
>> -
>> -    if (isapc_ram_fw || pflash_drv =3D=3D NULL) {
>> -        /* When a pflash drive is not found, use rom-mode */
>> -        old_pc_system_rom_init(rom_memory, isapc_ram_fw);
>> +    if (!pcmc->pci_enabled) {
>> +        old_pc_system_rom_init(rom_memory, true);
>>          return;
>>      }
>>=20=20
>> -    if (kvm_enabled() && !kvm_readonly_mem_enabled()) {
>> -        /* Older KVM cannot execute from device memory. So, flash memory
>> -         * cannot be used unless the readonly memory kvm capability is =
present. */
>> -        fprintf(stderr, "qemu: pflash with kvm requires KVM readonly me=
mory support\n");
>> -        exit(1);
>> +    /* Map legacy -drive if=3Dpflash to machine properties */
>> +    for (i =3D 0; i < ARRAY_SIZE(pcms->flash); i++) {
>> +        pflash_blk[i] =3D pflash_cfi01_get_blk(pcms->flash[i]);
>> +        pflash_drv =3D drive_get(IF_PFLASH, 0, i);
>> +        if (!pflash_drv) {
>> +            continue;
>> +        }
>> +        loc_push_none(&loc);
>> +        qemu_opts_loc_restore(pflash_drv->opts);
>> +        if (pflash_blk[i]) {
>> +            error_report("clashes with -machine");
>> +            exit(1);
>> +        }
>> +        pflash_blk[i] =3D blk_by_legacy_dinfo(pflash_drv);
>> +        qdev_prop_set_drive(DEVICE(pcms->flash[i]),
>> +                            "drive", pflash_blk[i], &error_fatal);
>> +        loc_pop(&loc);
>>      }
>>=20=20
>> -    pc_system_flash_init(rom_memory);
>> +    /* Reject gaps */
>> +    for (i =3D 1; i < ARRAY_SIZE(pcms->flash); i++) {
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

This assumes ARRAY_SIZE(pcms->flash) =3D=3D 2.  Valid, but the code avoids
the assumption everywhere else.  Similar to how the old code should work
for any FLASH_MAP_UNIT_MAX, even though it's actually 2.

If we decide two images are going to be enough for everybody, we can
simplify some.  There's more unused flexibility to discard, if we want
to.

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
>> +            error_report("pflash with kvm requires KVM readonly memory =
support");
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
>>=20=20
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
>>=20=20
>> @@ -39,6 +40,7 @@ struct PCMachineState {
>>      PCIBus *bus;
>>      FWCfgState *fw_cfg;
>>      qemu_irq *gsi;
>> +    PFlashCFI01 *flash[2];
>>=20=20
>>      /* Configuration options: */
>>      uint64_t max_ram_below_4g;
>> @@ -278,8 +280,8 @@ extern PCIDevice *piix4_dev;
>>  int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn);
>>=20=20
>>  /* pc_sysfw.c */
>> -void pc_system_firmware_init(MemoryRegion *rom_memory,
>> -                             bool isapc_ram_fw);
>> +void pc_system_flash_create(PCMachineState *pcms);
>> +void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_me=
mory);
>>=20=20
>>  /* acpi-build.c */
>>  void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
>>=20
