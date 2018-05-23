Received: from eggs.gnu.org ([2001:4830:134:3::10]:46749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLTCi-0005Y2-JO
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:49:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLTCe-0007Ax-LN
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:49:20 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:42675)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLTCe-0007Af-F2
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:49:16 -0400
Received: by mail-qt0-x243.google.com with SMTP id c2-v6so27825702qtn.9
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 05:49:16 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
	<1527034517-7851-31-git-send-email-mjc@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <65f3d9c9-4522-41d4-4ae9-fd54745412d8@amsat.org>
Date: Wed, 23 May 2018 09:49:12 -0300
MIME-Version: 1.0
In-Reply-To: <1527034517-7851-31-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 30/30] RISC-V: Support separate firmware
 and kernel payload
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Alistair Francis <Alistair.Francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>

On 05/22/2018 09:15 PM, Michael Clark wrote:
> Support for separate firmware and kernel payload is added
> by updating BBL to read optional preloaded kernel address
> attributes from device-tree using a similar mechanism to
> that used to pass init ramdisk addresses to linux kernel.
> 
>     chosen {
>         riscv,kernel-start = <0x00000000 0x80200000>;
>         riscv,kernel-end = <0x00000000 0x80590634>;
>     };
> 
> These attributes are added by QEMU and read by BBL when combining
> -bios <firmware-image> and -kernel <kernel-image> options. e.g.
> 
> $ qemu-system-riscv64 -machine virt -bios bbl -kernel vmlinux
> 
> With this change, bbl can be compiled without --with-payload
> and the dummy payload alignment is altered to make the memory
> footprint of the firmware-only bbl smaller. The dummy payload
> message is updated to indicate the alternative load method.
> 
> This load method could also be supported by a first stage boot
> loader that reads seperate firmware and kernel from SPI flash.
> The main advantage of this new mechanism is that it eases kernel
> development by avoiding the riscv-pk packaging step after kernel
> builds, makes building per repository artefacts for CI simpler,
> and mimics bootloaders on other platforms that can load a kernel
> image file directly. Ultimately BBL should use an SPI driver to
> load the kernel image however this mechanism supports use cases
> such such as QEMU's -bios, -kernel and -initrd options following
> examples from other platforms that pass kernel entry to firmware
> via device-tree.
> 
> The board is also changed to use the firmware address from the
> loaded firmware or combined firmware+kernel. This is normally
> equal to the DRAM base address of 0x8000_0000, however now it
> is possible to boot firmware at different load addresses because
> the reset code jumps to the actual firmware entry address.
> 
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  hw/riscv/Makefile.objs  |   1 +
>  hw/riscv/boot.c         | 172 ++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/riscv/virt.c         |  67 +++----------------

This patch would be easier to review split in 2, one dumb moving out to
separate and another with the interesting changes.

>  include/hw/riscv/boot.h |  30 +++++++++
>  4 files changed, 213 insertions(+), 57 deletions(-)
>  create mode 100644 hw/riscv/boot.c
>  create mode 100644 include/hw/riscv/boot.h
> 
> diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
> index 1dde01d39dcc..d36b004ab0f9 100644
> --- a/hw/riscv/Makefile.objs
> +++ b/hw/riscv/Makefile.objs
> @@ -1,3 +1,4 @@
> +obj-y += boot.o
>  obj-y += riscv_htif.o
>  obj-y += riscv_hart.o
>  obj-y += sifive_e.o
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> new file mode 100644
> index 000000000000..cf4e5d594638
> --- /dev/null
> +++ b/hw/riscv/boot.c
> @@ -0,0 +1,172 @@
> +/*
> + * QEMU RISCV firmware and kernel loader
> + *
> + * Copyright (c) 2017-2018 SiFive, Inc.
> + *
> + * Holds the state of a heterogenous array of RISC-V harts
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/error-report.h"
> +#include "hw/loader.h"
> +#include "hw/boards.h"
> +#include "sysemu/device_tree.h"
> +#include "elf.h"
> +#include "hw/riscv/boot.h"
> +
> +#define RISCV_BOOT_DEBUG 0
> +
> +#define boot_debug(fs, ...) \
> +    if (RISCV_BOOT_DEBUG) { \
> +        fprintf(stderr, "boot: %s: "fs, __func__, ##__VA_ARGS__); \
> +    }
> +
> +static uint64_t kernel_offset;
> +
> +static uint64_t kernel_translate(void *opaque, uint64_t addr)
> +{
> +    /* mask kernel virtual address and offset by load address */
> +    if (kernel_offset) {
> +        return (addr & 0x7fffffff) + kernel_offset;
> +    } else {
> +        return addr;
> +    }
> +}
> +
> +hwaddr riscv_load_firmware(const char *filename)
> +{
> +    uint64_t firmware_entry, firmware_start, firmware_end;
> +
> +    if (load_elf(filename, NULL, NULL,
> +                 &firmware_entry, &firmware_start, &firmware_end,
> +                 0, EM_RISCV, 1, 0) < 0) {
> +        error_report("riscv_boot: could not load firmware '%s'", filename);
> +        exit(1);
> +    }
> +
> +    /* align kernel load address to the megapage after the firmware */
> +#if defined(TARGET_RISCV32)
> +    kernel_offset = (firmware_end + 0x3fffff) & ~0x3fffff;
> +#else
> +    kernel_offset = (firmware_end + 0x1fffff) & ~0x1fffff;
> +#endif
> +
> +    boot_debug("entry=0x" TARGET_FMT_plx " start=0x" TARGET_FMT_plx " "
> +               "end=0x" TARGET_FMT_plx " kernel_offset=0x" TARGET_FMT_plx "\n",
> +               firmware_entry, firmware_start, firmware_end, kernel_offset);
> +
> +    return firmware_entry;
> +}
> +
> +hwaddr riscv_load_kernel(const char *filename, void *fdt)
> +{
> +    uint64_t kernel_entry, kernel_start, kernel_end;
> +
> +    if (load_elf(filename, kernel_translate, NULL,
> +                 &kernel_entry, &kernel_start, &kernel_end,
> +                 0, EM_RISCV, 1, 0) < 0) {
> +        error_report("riscv_boot: could not load kernel '%s'", filename);
> +        exit(1);
> +    }
> +
> +    boot_debug("entry=0x" TARGET_FMT_plx " start=0x" TARGET_FMT_plx " "
> +               "end=0x" TARGET_FMT_plx "\n", kernel_entry, kernel_start,
> +               kernel_end);
> +
> +    /*
> +     * pass kernel load address via device-tree to firmware
> +     *
> +     * BBL reads the kernel address from device-tree
> +     */
> +    if (fdt) {
> +        qemu_fdt_setprop_cells(fdt, "/chosen", "riscv,kernel-end",
> +                               kernel_end >> 32, kernel_end);
> +        qemu_fdt_setprop_cells(fdt, "/chosen", "riscv,kernel-start",
> +                               kernel_start >> 32, kernel_start);
> +    }
> +
> +    return kernel_entry;
> +}
> +
> +void riscv_load_initrd(const char *filename, uint64_t mem_size,
> +                       hwaddr firmware_entry, void *fdt)
> +{
> +    uint64_t start, size;
> +
> +    /* We want to put the initrd far enough into RAM that when the
> +     * kernel is uncompressed it will not clobber the initrd. However
> +     * on boards without much RAM we must ensure that we still leave
> +     * enough room for a decent sized initrd, and on boards with large
> +     * amounts of RAM we must avoid the initrd being so far up in RAM
> +     * that it is outside lowmem and inaccessible to the kernel.
> +     * So for boards with less  than 256MB of RAM we put the initrd
> +     * halfway into RAM, and for boards with 256MB of RAM or more we put
> +     * the initrd at 128MB.
> +     */
> +    start = firmware_entry + MIN(mem_size / 2, 128 * 1024 * 1024);
> +
> +    size = load_ramdisk(filename, start, mem_size - start);
> +    if (size == -1) {
> +        size = load_image_targphys(filename, start, mem_size - start);
> +        if (size == -1) {
> +            error_report("riscv_boot: could not load ramdisk '%s'", filename);
> +            exit(1);
> +        }
> +    }
> +
> +    boot_debug("start=0x" TARGET_FMT_plx " end=0x" TARGET_FMT_plx "\n",
> +               start, start + size);
> +
> +    /*
> +     * pass initrd load address via device-tree to kernel
> +     *
> +     * linux-kernel reads the initrd address from device-tree
> +     */
> +    if (fdt) {
> +        qemu_fdt_setprop_cells(fdt, "/chosen", "linux,initrd-end",
> +                               (start + size) >> 32, start + size);
> +        qemu_fdt_setprop_cells(fdt, "/chosen", "linux,initrd-start",
> +                               start >> 32, start);
> +    }
> +}
> +
> +hwaddr riscv_load_firmware_kernel_initrd(MachineState *machine, void *fdt)
> +{
> +    hwaddr firmware_entry = 0;
> +
> +    /* load firmware e.g. -bios bbl */
> +    if (machine->firmware) {
> +        firmware_entry = riscv_load_firmware(machine->firmware);
> +    }
> +
> +    /* load combined bbl+kernel or separate kernel */
> +    if (machine->kernel_filename) {
> +        if (machine->firmware) {
> +            /* load separate bios and kernel e.g. -bios bbl -kernel vmlinux */
> +            riscv_load_kernel(machine->kernel_filename, fdt);
> +        } else {
> +            /* load traditional combined bbl+kernel e.g. -kernel bbl_vmlimux */
> +            firmware_entry = riscv_load_kernel(machine->kernel_filename, NULL);
> +        }
> +        if (machine->initrd_filename) {
> +            /* load separate initrd */
> +            riscv_load_initrd(machine->initrd_filename, machine->ram_size,
> +                              firmware_entry, fdt);
> +        }
> +    }
> +
> +    return firmware_entry;
> +}
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index c889aa3cd269..984ddf0635fd 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -33,6 +33,7 @@
>  #include "hw/riscv/sifive_plic.h"
>  #include "hw/riscv/sifive_clint.h"
>  #include "hw/riscv/sifive_test.h"
> +#include "hw/riscv/boot.h"
>  #include "hw/riscv/virt.h"
>  #include "chardev/char.h"
>  #include "sysemu/arch_init.h"
> @@ -56,47 +57,6 @@ static const struct MemmapEntry {
>      [VIRT_DRAM] =     { 0x80000000,        0x0 },
>  };
>  
> -static uint64_t load_kernel(const char *kernel_filename)
> -{
> -    uint64_t kernel_entry, kernel_high;
> -
> -    if (load_elf(kernel_filename, NULL, NULL,
> -                 &kernel_entry, NULL, &kernel_high,
> -                 0, EM_RISCV, 1, 0) < 0) {
> -        error_report("qemu: could not load kernel '%s'", kernel_filename);
> -        exit(1);
> -    }
> -    return kernel_entry;
> -}
> -
> -static hwaddr load_initrd(const char *filename, uint64_t mem_size,
> -                          uint64_t kernel_entry, hwaddr *start)
> -{
> -    int size;
> -
> -    /* We want to put the initrd far enough into RAM that when the
> -     * kernel is uncompressed it will not clobber the initrd. However
> -     * on boards without much RAM we must ensure that we still leave
> -     * enough room for a decent sized initrd, and on boards with large
> -     * amounts of RAM we must avoid the initrd being so far up in RAM
> -     * that it is outside lowmem and inaccessible to the kernel.
> -     * So for boards with less  than 256MB of RAM we put the initrd
> -     * halfway into RAM, and for boards with 256MB of RAM or more we put
> -     * the initrd at 128MB.
> -     */
> -    *start = kernel_entry + MIN(mem_size / 2, 128 * 1024 * 1024);
> -
> -    size = load_ramdisk(filename, *start, mem_size - *start);
> -    if (size == -1) {
> -        size = load_image_targphys(filename, *start, mem_size - *start);
> -        if (size == -1) {
> -            error_report("qemu: could not load ramdisk '%s'", filename);
> -            exit(1);
> -        }
> -    }
> -    return *start + size;
> -}
> -
>  static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>      uint64_t mem_size, const char *cmdline)
>  {
> @@ -273,6 +233,7 @@ static void riscv_virt_board_init(MachineState *machine)
>      size_t plic_hart_config_len;
>      int i;
>      void *fdt;
> +    hwaddr firmware_entry;
>  
>      /* Initialize SOC */
>      object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_HART_ARRAY);
> @@ -300,20 +261,12 @@ static void riscv_virt_board_init(MachineState *machine)
>      memory_region_add_subregion(system_memory, memmap[VIRT_MROM].base,
>                                  mask_rom);
>  
> -    if (machine->kernel_filename) {
> -        uint64_t kernel_entry = load_kernel(machine->kernel_filename);
> -
> -        if (machine->initrd_filename) {
> -            hwaddr start;
> -            hwaddr end = load_initrd(machine->initrd_filename,
> -                                     machine->ram_size, kernel_entry,
> -                                     &start);
> -            qemu_fdt_setprop_cell(fdt, "/chosen",
> -                                  "linux,initrd-start", start);
> -            qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
> -                                  end);
> -        }
> -    }
> +    /*
> +     * combined firmware and kernel: -kernel bbl_vmlimux
> +     * separate firmware and kernel: -bios bbl -kernel vmlinux
> +     * firmware, kernel and ramdisk: -bios bbl -kernel vmlinux -initrd initramfs
> +     */
> +    firmware_entry = riscv_load_firmware_kernel_initrd(machine, fdt);
>  
>      /* reset vector */
>      uint32_t reset_vec[8] = {
> @@ -327,8 +280,8 @@ static void riscv_virt_board_init(MachineState *machine)
>  #endif
>          0x00028067,                  /*     jr     t0 */
>          0x00000000,
> -        memmap[VIRT_DRAM].base,      /* start: .dword memmap[VIRT_DRAM].base */
> -        0x00000000,
> +        firmware_entry,              /* .word firmware_entry */
> +        firmware_entry >> 32,
>                                       /* dtb: */
>      };
>  
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> new file mode 100644
> index 000000000000..aa30bf1c45b2
> --- /dev/null
> +++ b/include/hw/riscv/boot.h
> @@ -0,0 +1,30 @@
> +/*
> + * QEMU RISCV firmware and kernel loader interface
> + *
> + * Copyright (c) 2017-2018 SiFive, Inc.
> + *
> + * Holds the state of a heterogenous array of RISC-V harts
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_RISCV_BOOT_H
> +#define HW_RISCV_BOOT_H
> +
> +hwaddr riscv_load_firmware(const char *filename);
> +hwaddr riscv_load_kernel(const char *filename, void *fdt);
> +void riscv_load_initrd(const char *filename, uint64_t mem_size,
> +                       hwaddr firmware_entry, void *fdt);
> +hwaddr riscv_load_firmware_kernel_initrd(MachineState *machine, void *fdt);
> +
> +#endif
> 
