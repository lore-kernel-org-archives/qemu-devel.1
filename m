Received: from eggs.gnu.org ([2001:4830:134:3::10]:37109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cX7AV-0007NR-Ko
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:06:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cX7AQ-0003OP-Je
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:06:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cX7AQ-0003OJ-B3
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:06:18 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1484165352.git.atar4qemu@gmail.com>
	<662c7a5b81926a9daba26c943b0c11e99068c867.1484165352.git.atar4qemu@gmail.com>
	<87bmuumfxp.fsf@dusky.pond.sub.org>
	<CACXAS8CFZzU1-PQenvAX2iSnDoWOo62Zb7mNPJSeJJnzNmyXVQ@mail.gmail.com>
Date: Fri, 27 Jan 2017 15:06:15 +0100
In-Reply-To: <CACXAS8CFZzU1-PQenvAX2iSnDoWOo62Zb7mNPJSeJJnzNmyXVQ@mail.gmail.com>
	(Artyom Tarasenko's message of "Thu, 26 Jan 2017 10:33:18 +0100")
Message-ID: <8737g4k36w.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 30/30] target-sparc: fix up niagara
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Artyom Tarasenko <atar4qemu@gmail.com> writes:

> On Thu, Jan 26, 2017 at 8:35 AM, Markus Armbruster <armbru@redhat.com> wrote:
>> niagara_init() does something naughty, which conflicts with Max's
>> "[PATCH v6 0/9] block: Drop BDS.filename".  Details inline.
>>
>> Artyom Tarasenko <atar4qemu@gmail.com> writes:
>>
>>> Remove the Niagara stub implementation from sun4u.c and add a machine,
>>> compatible with Legion simulator from the OpenSPARC T1 project.
>>>
>>> The machine uses the firmware supplied with the OpenSPARC T1 project,
>>> http://download.oracle.com/technetwork/systems/opensparc/OpenSPARCT1_Arch.1.5.tar.bz2
>>> in the directory S10image/, and is able to boot the supplied Solaris 10 image.
>>>
>>> Note that for compatibility with the naming conventions for SPARC machines
>>> the new machine name is lowercase niagara.
>>>
>>> Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
>>> Reviewed-by: Richard Henderson <rth@twiddle.net>
>>> ---
>>>  MAINTAINERS                         |  13 +--
>>>  default-configs/sparc64-softmmu.mak |   2 +
>>>  hw/sparc64/Makefile.objs            |   1 +
>>>  hw/sparc64/niagara.c                | 177 ++++++++++++++++++++++++++++++++++++
>>>  hw/sparc64/sun4u.c                  |  31 -------
>>>  qemu-doc.texi                       |  14 ++-
>>>  6 files changed, 199 insertions(+), 39 deletions(-)
>>>  create mode 100644 hw/sparc64/niagara.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 54588e5..b5ebfab 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -725,6 +725,13 @@ S: Maintained
>>>  F: hw/sparc64/sun4u.c
>>>  F: pc-bios/openbios-sparc64
>>>
>>> +Sun4v
>>> +M: Artyom Tarasenko <atar4qemu@gmail.com>
>>> +S: Maintained
>>> +F: hw/sparc64/sun4v.c
>>> +F: hw/timer/sun4v-rtc.c
>>> +F: include/hw/timer/sun4v-rtc.h
>>> +
>>>  Leon3
>>>  M: Fabien Chouteau <chouteau@adacore.com>
>>>  S: Maintained
>>> @@ -1098,12 +1105,6 @@ F: hw/nvram/chrp_nvram.c
>>>  F: include/hw/nvram/chrp_nvram.h
>>>  F: tests/prom-env-test.c
>>>
>>> -sun4v RTC
>>> -M: Artyom Tarasenko <atar4qemu@gmail.com>
>>> -S: Maintained
>>> -F: hw/timer/sun4v-rtc.c
>>> -F: include/hw/timer/sun4v-rtc.h
>>> -
>>>  Subsystems
>>>  ----------
>>>  Audio
>>> diff --git a/default-configs/sparc64-softmmu.mak b/default-configs/sparc64-softmmu.mak
>>> index c0cdd64..c581e61 100644
>>> --- a/default-configs/sparc64-softmmu.mak
>>> +++ b/default-configs/sparc64-softmmu.mak
>>> @@ -13,3 +13,5 @@ CONFIG_IDE_CMD646=y
>>>  CONFIG_PCI_APB=y
>>>  CONFIG_MC146818RTC=y
>>>  CONFIG_ISA_TESTDEV=y
>>> +CONFIG_EMPTY_SLOT=y
>>> +CONFIG_SUN4V_RTC=y
>>> diff --git a/hw/sparc64/Makefile.objs b/hw/sparc64/Makefile.objs
>>> index a96b1f8..cf9de21 100644
>>> --- a/hw/sparc64/Makefile.objs
>>> +++ b/hw/sparc64/Makefile.objs
>>> @@ -1,2 +1,3 @@
>>>  obj-y += sparc64.o
>>>  obj-y += sun4u.o
>>> +obj-y += niagara.o
>>> \ No newline at end of file
>>> diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
>>> new file mode 100644
>>> index 0000000..b55d4bb
>>> --- /dev/null
>>> +++ b/hw/sparc64/niagara.c
>>> @@ -0,0 +1,177 @@
>>> +/*
>>> + * QEMU Sun4v/Niagara System Emulator
>>> + *
>>> + * Copyright (c) 2016 Artyom Tarasenko
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person obtaining a copy
>>> + * of this software and associated documentation files (the "Software"), to deal
>>> + * in the Software without restriction, including without limitation the rights
>>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>>> + * copies of the Software, and to permit persons to whom the Software is
>>> + * furnished to do so, subject to the following conditions:
>>> + *
>>> + * The above copyright notice and this permission notice shall be included in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
>>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>>> + * THE SOFTWARE.
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "qapi/error.h"
>>> +#include "qemu-common.h"
>>> +#include "cpu.h"
>>> +#include "hw/hw.h"
>>> +#include "hw/boards.h"
>>> +#include "hw/char/serial.h"
>>> +#include "hw/empty_slot.h"
>>> +#include "hw/loader.h"
>>> +#include "hw/sparc/sparc64.h"
>>> +#include "hw/timer/sun4v-rtc.h"
>>> +#include "exec/address-spaces.h"
>>> +#include "sysemu/block-backend.h"
>>> +
>>> +
>>> +typedef struct NiagaraBoardState {
>>> +    MemoryRegion hv_ram;
>>> +    MemoryRegion partition_ram;
>>> +    MemoryRegion nvram;
>>> +    MemoryRegion md_rom;
>>> +    MemoryRegion hv_rom;
>>> +    MemoryRegion vdisk_ram;
>>> +    MemoryRegion prom;
>>> +} NiagaraBoardState;
>>> +
>>> +#define NIAGARA_HV_RAM_BASE 0x100000ULL
>>> +#define NIAGARA_HV_RAM_SIZE 0x3f00000ULL /* 63 MiB */
>>> +
>>> +#define NIAGARA_PARTITION_RAM_BASE 0x80000000ULL
>>> +
>>> +#define NIAGARA_UART_BASE   0x1f10000000ULL
>>> +
>>> +#define NIAGARA_NVRAM_BASE  0x1f11000000ULL
>>> +#define NIAGARA_NVRAM_SIZE  0x2000
>>> +
>>> +#define NIAGARA_MD_ROM_BASE 0x1f12000000ULL
>>> +#define NIAGARA_MD_ROM_SIZE 0x2000
>>> +
>>> +#define NIAGARA_HV_ROM_BASE 0x1f12080000ULL
>>> +#define NIAGARA_HV_ROM_SIZE 0x2000
>>> +
>>> +#define NIAGARA_IOBBASE     0x9800000000ULL
>>> +#define NIAGARA_IOBSIZE     0x0100000000ULL
>>> +
>>> +#define NIAGARA_VDISK_BASE  0x1f40000000ULL
>>> +#define NIAGARA_RTC_BASE    0xfff0c1fff8ULL
>>> +#define NIAGARA_UART_BASE   0x1f10000000ULL
>>> +
>>> +/* Firmware layout
>>> + *
>>> + * |------------------|
>>> + * |   openboot.bin   |
>>> + * |------------------| PROM_ADDR + OBP_OFFSET
>>> + * |      q.bin       |
>>> + * |------------------| PROM_ADDR + Q_OFFSET
>>> + * |     reset.bin    |
>>> + * |------------------| PROM_ADDR
>>> + */
>>> +#define NIAGARA_PROM_BASE   0xfff0000000ULL
>>> +#define NIAGARA_Q_OFFSET    0x10000ULL
>>> +#define NIAGARA_OBP_OFFSET  0x80000ULL
>>> +#define PROM_SIZE_MAX       (4 * 1024 * 1024)
>>> +
>>> +/* Niagara hardware initialisation */
>>> +static void niagara_init(MachineState *machine)
>>> +{
>>> +    NiagaraBoardState *s = g_new(NiagaraBoardState, 1);
>>> +    DriveInfo *dinfo = drive_get_next(IF_PFLASH);
>>
>> @dinfo is the first -drive if=pflash (or its sugared form -pflash).
>>
>>> +    MemoryRegion *sysmem = get_system_memory();
>>> +
>>> +    /* init CPUs */
>>> +    sparc64_cpu_devinit(machine->cpu_model, "Sun UltraSparc T1",
>>> +                        NIAGARA_PROM_BASE);
>>> +    /* set up devices */
>>> +    memory_region_allocate_system_memory(&s->hv_ram, NULL, "sun4v-hv.ram",
>>> +                                         NIAGARA_HV_RAM_SIZE);
>>> +    memory_region_add_subregion(sysmem, NIAGARA_HV_RAM_BASE, &s->hv_ram);
>>> +
>>> +    memory_region_allocate_system_memory(&s->partition_ram, NULL,
>>> +                                         "sun4v-partition.ram",
>>> +                                         machine->ram_size);
>>> +    memory_region_add_subregion(sysmem, NIAGARA_PARTITION_RAM_BASE,
>>> +                                &s->partition_ram);
>>> +
>>> +    memory_region_allocate_system_memory(&s->nvram, NULL,
>>> +                                         "sun4v.nvram", NIAGARA_NVRAM_SIZE);
>>> +    memory_region_add_subregion(sysmem, NIAGARA_NVRAM_BASE, &s->nvram);
>>> +    memory_region_allocate_system_memory(&s->md_rom, NULL,
>>> +                                         "sun4v-md.rom", NIAGARA_MD_ROM_SIZE);
>>> +    memory_region_add_subregion(sysmem, NIAGARA_MD_ROM_BASE, &s->md_rom);
>>> +    memory_region_allocate_system_memory(&s->hv_rom, NULL,
>>> +                                         "sun4v-hv.rom", NIAGARA_HV_ROM_SIZE);
>>> +    memory_region_add_subregion(sysmem, NIAGARA_HV_ROM_BASE, &s->hv_rom);
>>> +    memory_region_allocate_system_memory(&s->prom, NULL,
>>> +                                         "sun4v.prom", PROM_SIZE_MAX);
>>> +    memory_region_add_subregion(sysmem, NIAGARA_PROM_BASE, &s->prom);
>>> +
>>> +    rom_add_file_fixed("nvram1", NIAGARA_NVRAM_BASE, -1);
>>> +    rom_add_file_fixed("1up-md.bin", NIAGARA_MD_ROM_BASE, -1);
>>> +    rom_add_file_fixed("1up-hv.bin", NIAGARA_HV_ROM_BASE, -1);
>>> +
>>> +    rom_add_file_fixed("reset.bin", NIAGARA_PROM_BASE, -1);
>>> +    rom_add_file_fixed("q.bin", NIAGARA_PROM_BASE + NIAGARA_Q_OFFSET, -1);
>>> +    rom_add_file_fixed("openboot.bin", NIAGARA_PROM_BASE + NIAGARA_OBP_OFFSET,
>>> +                       -1);
>>> +
>>> +    /* the virtual ramdisk is kind of initrd, but it resides
>>> +       outside of the partition RAM */
>>> +    if (dinfo) {
>>> +        BlockBackend *blk = blk_by_legacy_dinfo(dinfo);
>>
>> This is the block backend created by the first -drive if=pflash.
>>
>>> +        int size = blk_getlength(blk);
>>> +        if (size > 0) {
>>> +            memory_region_allocate_system_memory(&s->vdisk_ram, NULL,
>>> +                                                 "sun4v_vdisk.ram", size);
>>> +            memory_region_add_subregion(get_system_memory(),
>>> +                                        NIAGARA_VDISK_BASE, &s->vdisk_ram);
>>> +            dinfo->is_default = 1;
>>> +            rom_add_file_fixed(blk_bs(blk)->filename, NIAGARA_VDISK_BASE, -1);
>>
>> The block backend isn't actually used.  It's merely a carrier for a
>> filename.  Naughty.  Also conflicts with Max's work to kill ->filename.
>>
>> What you create for it isn't actually a pflash device.  Naughty.
>>
>> Despite rom_add_file_fixed(), it's RAM, not ROM:
>>
>>     (qemu) info mtree
>>     address-space: memory
>>       0000000000000000-ffffffffffffffff (prio 0, RW): system
>>         0000000000100000-0000000003ffffff (prio 0, RW): sun4v-hv.ram
>>         0000000080000000-0000000087ffffff (prio 0, RW): sun4v-partition.ram
>>         0000001f10000000-0000001f10000007 (prio 0, RW): serial
>>         0000001f11000000-0000001f11001fff (prio 0, RW): sun4v.nvram
>>         0000001f12000000-0000001f12001fff (prio 0, RW): sun4v-md.rom
>>         0000001f12080000-0000001f12081fff (prio 0, RW): sun4v-hv.rom
>>         0000001f40000000-0000001f413fffff (prio 0, RW): sun4v_vdisk.ram
>>         0000009800000000-00000098ffffffff (prio 0, RW): empty-slot
>>         000000fff0000000-000000fff03fffff (prio 0, RW): sun4v.prom
>>         000000fff0c1fff8-000000fff0c1ffff (prio 0, RW): sun4v-rtc
>>
>>     address-space: I/O
>>       0000000000000000-000000000000ffff (prio 0, RW): io
>>
>>     address-space: cpu-memory
>>       0000000000000000-ffffffffffffffff (prio 0, RW): system
>>         0000000000100000-0000000003ffffff (prio 0, RW): sun4v-hv.ram
>>         0000000080000000-0000000087ffffff (prio 0, RW): sun4v-partition.ram
>>         0000001f10000000-0000001f10000007 (prio 0, RW): serial
>>         0000001f11000000-0000001f11001fff (prio 0, RW): sun4v.nvram
>>         0000001f12000000-0000001f12001fff (prio 0, RW): sun4v-md.rom
>>         0000001f12080000-0000001f12081fff (prio 0, RW): sun4v-hv.rom
>> --->    0000001f40000000-0000001f413fffff (prio 0, RW): sun4v_vdisk.ram
>>         0000009800000000-00000098ffffffff (prio 0, RW): empty-slot
>>         000000fff0000000-000000fff03fffff (prio 0, RW): sun4v.prom
>>
>> Note that sun4v-md.rom and sun4v-hv.rom aren't ROM, either.
>
> Is rom_add_file_fixed supposed to mark the memory region read-only? Or
> should it be created read-only before calling rom_add_file_fixed?

I'm not familiar with the memory API, but the fact that you're getting
RW suggests that you need to mark read-only yourself.  Suggest to
examine similar code elsewhere for additional clues.

>> The monkey-patching of dinfo->is_default is to silence the "Orphaned
>> drive without device" warning.  Naughty.
>>
>> This use of -drive if=pflash is highly unorthodox.  To suggest better
>> ways, we need to understand the role of "the virtual ramdisk".  Can you
>> explain?  How does it work on a physical system?
>
> AFAIK except for simulators it's only used on FPGA boards. It's what
> the comment says: a kind of initrd, but it resides outside of the
> partition RAM. So, it is a RAM region pre-filled with data in the way
> not visible to the guest.
>
> I would have used an -initrd option instead of -pflash, but it
> required a -kernel option, and there is no sensible way to use the
> -kernel with Solaris.
> If QEMU had something like a nvram-disk - it would have worked here the best.

Have you considered pressing -bios into service?  -option-rom?  -object
memory-backend-file?  Paolo, any recommendations?
