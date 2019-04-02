Received: from eggs.gnu.org ([209.51.188.92]:50026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hB9P7-00039y-4n
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 22:44:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hB9BG-0002IF-JT
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 22:29:46 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hB9B0-00021c-5U
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 22:29:39 -0400
Received: by mail-oi1-x241.google.com with SMTP id l203so8515708oia.3
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 19:29:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20190401063639.18341-1-ayan@wavecomp.com>
References: <20190401063639.18341-1-ayan@wavecomp.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 2 Apr 2019 04:29:23 +0200
Message-ID: <CAL1e-=ih9b-9ByvkmfnG7dXQGrpDbzYje1cYgiqCHD+9Vm4Wvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Support load kernel(vmlinux)/dtb/initrd
 separately for Boston in QEMU.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Archer Yan <ayan@wavecomp.com>, pburton@wavecomp.com
Cc: qemu-devel@nongnu.org

On Apr 1, 2019 11:26 AM, "Archer Yan" <ayan@wavecomp.com> wrote:
>
> Currently boston in QEMU only supports boot with FIT format. Since ELF
file
> can provide symbol infomation in debug, this patch enables Boston boot
from
> vmlinux&dtb.
>
> Signed-off-by: Archer Yan <ayan@wavecomp.com>
> ---
>  hw/mips/boston.c | 224 ++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 201 insertions(+), 23 deletions(-)
>
> diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> index e5bab3cadc..5910ffdc8a 100644
> --- a/hw/mips/boston.c
> +++ b/hw/mips/boston.c
> @@ -39,6 +39,10 @@
>  #include "sysemu/device_tree.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/qtest.h"
> +#include "elf.h"
> +#include "sysemu/kvm.h"
> +#include "hw/mips/mips.h"
> +#include "qemu/option.h"
>
>  #include <libfdt.h>
>
> @@ -58,6 +62,11 @@ typedef struct {
>
>      hwaddr kernel_entry;
>      hwaddr fdt_base;
> +    long kernel_size;
> +
> +    uint64_t initrd_size;
> +    uint64_t initrd_start;
> +    uint64_t initrd_offset;
>  } BostonState;
>
>  enum boston_plat_reg {
> @@ -328,31 +337,59 @@ static void gen_firmware(uint32_t *p, hwaddr
kernel_entry, hwaddr fdt_addr,
>      stl_p(p++, 0x03200009);                     /* jr   $25 */
>  }
>
> -static const void *boston_fdt_filter(void *opaque, const void *fdt_orig,
> -                                     const void *match_data, hwaddr
*load_addr)
> +typedef uint64_t (*xlate_to_kseg0)(void *, uint64_t);
> +static xlate_to_kseg0 get_xlate_to_kseg0_fn(BostonState *s)
> +{
> +    /* Check where the kernel has been linked */
> +    if (s->kernel_entry & 0x80000000ll) {
> +        if (kvm_enabled()) {
> +            error_report("KVM guest kernels must be linked in useg. "
> +                         "Did you forget to enable CONFIG_KVM_GUEST?");
> +            return NULL;
> +        }
> +        return cpu_mips_phys_to_kseg0;
> +    } else {
> +        /* if kernel entry is in useg it is probably a KVM T&E kernel */
> +        mips_um_ksegs_enable();
> +        return cpu_mips_kvm_um_phys_to_kseg0;
> +    }
> +}
> +
> +/*Adapt fdt to insert initrd parameters*/
> +static int boston_initrd_fdt(BostonState *s, void *fdt)
>  {
> -    BostonState *s = BOSTON(opaque);
> -    MachineState *machine = s->mach;
>      const char *cmdline;
> +    char *args_str = NULL;
> +    MachineState *machine = s->mach;
> +    int initrd_args_len = 64;
>      int err;
> -    void *fdt;
> -    size_t fdt_sz, ram_low_sz, ram_high_sz;
> +    size_t ram_low_sz, ram_high_sz;
> +    uint64_t (*xlate_to_kseg0_fn) (void *opaque, uint64_t addr);
>
> -    fdt_sz = fdt_totalsize(fdt_orig) * 2;
> -    fdt = g_malloc0(fdt_sz);
> +    cmdline = (machine->kernel_cmdline && machine->kernel_cmdline[0])
> +            ? machine->kernel_cmdline : " ";
> +    xlate_to_kseg0_fn = get_xlate_to_kseg0_fn(s);
> +    if (NULL == xlate_to_kseg0_fn) {
> +        fprintf(stderr, "couldn't get xlate_to_kseg0\n");
> +        return -1;
> +    }
>
> -    err = fdt_open_into(fdt_orig, fdt, fdt_sz);
> -    if (err) {
> -        fprintf(stderr, "unable to open FDT\n");
> -        return NULL;
> +    s->initrd_start = xlate_to_kseg0_fn(NULL, s->initrd_offset);
> +
> +    if (s->initrd_size) {
> +        args_str = g_malloc(strlen(cmdline) + initrd_args_len);
> +        if (args_str != NULL) {
> +            sprintf((char *)args_str, "rd_start=0x%lx rd_size=0x%lx %s",
> +                    s->initrd_start, s->initrd_size, cmdline);
> +            cmdline = args_str;
> +        }
>      }
>
> -    cmdline = (machine->kernel_cmdline && machine->kernel_cmdline[0])
> -            ? machine->kernel_cmdline : " ";
>      err = qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
>      if (err < 0) {
>          fprintf(stderr, "couldn't set /chosen/bootargs\n");
> -        return NULL;
> +        g_free(args_str);
> +        return -1;
>      }
>
>      ram_low_sz = MIN(256 * MiB, machine->ram_size);
> @@ -360,10 +397,41 @@ static const void *boston_fdt_filter(void *opaque,
const void *fdt_orig,
>      qemu_fdt_setprop_sized_cells(fdt, "/memory@0", "reg",
>                                   1, 0x00000000, 1, ram_low_sz,
>                                   1, 0x90000000, 1, ram_high_sz);
> +    g_free(args_str);
> +    return 0;
> +}
>
> -    fdt = g_realloc(fdt, fdt_totalsize(fdt));
> -    qemu_fdt_dumpdtb(fdt, fdt_sz);
> +static const void *boston_fdt_filter(void *opaque, const void *fdt_orig,
> +                                     const void *match_data, hwaddr
*load_addr)
> +{
> +    BostonState *s = BOSTON(opaque);
> +    MachineState *machine = s->mach;
> +    int err;
> +    void *fdt;
> +    int fdt_sz;
> +    if (machine->dtb) {
> +        /*Use QEMU cmd specified dtb*/
> +        fdt = load_device_tree(machine->dtb, &fdt_sz);
> +    } else {
> +        /*Use default dtb contained in FIT image*/
> +        fdt_sz = fdt_totalsize(fdt_orig) * 2;
> +        fdt = g_malloc0(fdt_sz);
> +
> +        err = fdt_open_into(fdt_orig, fdt, fdt_sz);
> +        if (err) {
> +            fprintf(stderr, "unable to open FDT\n");
> +            return NULL;
> +        }
> +
> +        fdt = g_realloc(fdt, fdt_totalsize(fdt));
> +    }
>
> +    err = boston_initrd_fdt(s, fdt);
> +    if (err) {
> +        return NULL;
> +    }
> +
> +    qemu_fdt_dumpdtb(fdt, fdt_sz);
>      s->fdt_base = *load_addr;
>
>      return fdt;
> @@ -391,6 +459,99 @@ static const struct fit_loader boston_fit_loader = {
>      .kernel_filter = boston_kernel_filter,
>  };
>
> +static int boston_load_dtb(BostonState *s)
> +{
> +    void *fdt = NULL;
> +    int size = 0;
> +    int err;
> +    MachineState *machine = s->mach;
> +    hwaddr load_addr;
> +    hwaddr kernel_end = 0xffffffff80100000 + s->kernel_size;
> +
> +    fdt = load_device_tree(machine->dtb, &size);
> +    if (!fdt) {
> +        fprintf(stderr, "Couldn't open dtb file %s\n", machine->dtb);
> +        return -1;
> +    }
> +    load_addr = ROUND_UP(kernel_end, 64 * KiB) + (10 * MiB);
> +    err = boston_initrd_fdt(s, fdt);
> +    if (err) {
> +        return -1;
> +    }
> +
> +    qemu_fdt_dumpdtb(fdt, size);
> +
> +    s->fdt_base = load_addr;
> +    load_addr = cpu_mips_kseg0_to_phys(s, load_addr);
> +    rom_add_blob_fixed("fdt@boston", fdt, size, load_addr);
> +
> +    return 0;
> +
> +}
> +
> +static int boston_load_initrd(BostonState *s)
> +{
> +    int64_t initrd_size = 0;
> +    ram_addr_t initrd_offset = 0;
> +    int ram_low_size;
> +    MachineState *machine = s->mach;
> +    ram_low_size = MIN(machine->ram_size, 256 * MiB);
> +    if (machine->initrd_filename) {
> +        initrd_size = get_image_size(machine->initrd_filename);
> +        if (initrd_size > 0) {
> +            /*
> +             * The kernel allocates the bootmap memory in the low memory
after
> +             *  the initrd.  It takes at most 128kiB for 2GB RAM and 4kiB
> +             *  pages.
> +             */
> +            initrd_offset = (ram_low_size - initrd_size
> +                             - (128 * KiB)
> +                             - ~INITRD_PAGE_MASK) & INITRD_PAGE_MASK;
> +
> +            initrd_size = load_image_targphys(machine->initrd_filename,
> +                                              initrd_offset,
> +                                              ram_size - initrd_offset);
> +        }
> +        if (initrd_size == (target_ulong) -1) {
> +            error_report("could not load initial ram disk '%s'",
> +                         machine->initrd_filename);
> +            return -1;
> +        }
> +    }
> +    s->initrd_offset = initrd_offset;
> +    s->initrd_size = initrd_size;
> +    return 0;
> +}
> +
> +static int boston_load_kernel(BostonState *s)
> +{
> +    int64_t kernel_entry, kernel_high;
> +    long kernel_size;
> +    int big_endian;
> +    MachineState *machine = s->mach;
> +
> +#ifdef TARGET_WORDS_BIGENDIAN
> +    big_endian = 1;
> +#else
> +    big_endian = 0;
> +#endif
> +
> +    kernel_size = load_elf(machine->kernel_filename, NULL,
> +                           cpu_mips_kseg0_to_phys,  NULL,
> +                           (uint64_t *)&kernel_entry, NULL,
> +                           (uint64_t *)&kernel_high, big_endian,
EM_MIPS, 1, 0);
> +    if (kernel_size < 0) {
> +        error_report("could not load kernel '%s': %s",
> +                     machine->kernel_filename,
> +                     load_elf_strerror(kernel_size));
> +        return -1;
> +    }
> +
> +    s->kernel_entry = kernel_entry;
> +    s->kernel_size = kernel_size;
> +    return 0;
> +}
> +
>  static inline XilinxPCIEHost *
>  xilinx_pcie_init(MemoryRegion *sys_mem, uint32_t bus_nr,
>                   hwaddr cfg_base, uint64_t cfg_size,
> @@ -433,7 +594,7 @@ static void boston_mach_init(MachineState *machine)
>      PCIDevice *ahci;
>      DriveInfo *hd[6];
>      Chardev *chr;
> -    int fw_size, fit_err;
> +    int fw_size, load_err;
>      bool is_64b;
>
>      if ((machine->ram_size % GiB) ||
> @@ -533,12 +694,29 @@ static void boston_mach_init(MachineState *machine)
>              exit(1);
>          }
>      } else if (machine->kernel_filename) {
> -        fit_err = load_fit(&boston_fit_loader, machine->kernel_filename,
s);
> -        if (fit_err) {
> -            error_printf("unable to load FIT image\n");
> -            exit(1);
> +        if (machine->initrd_filename) {
> +            load_err = boston_load_initrd(s);
> +            if (load_err) {
> +                error_printf("unable to separately load initrd image\n");
> +                exit(1);
> +            }
> +        }
> +        load_err = load_fit(&boston_fit_loader,
machine->kernel_filename, s);
> +        if (load_err) {
> +            error_printf("unable to load FIT image, try load as ELF\n");
> +            load_err = boston_load_kernel(s);
> +            if (load_err) {
> +                error_printf("unable to separately load kernel image\n");
> +                exit(1);
> +            }
> +            if (machine->dtb) {
> +                load_err = boston_load_dtb(s);
> +                if (load_err) {
> +                    error_printf("unable to separately load dtb
image\n");
> +                    exit(1);
> +                }
> +            }
>          }
> -
>          gen_firmware(memory_region_get_ram_ptr(flash) + 0x7c00000,
>                       s->kernel_entry, s->fdt_base, is_64b);
>      } else if (!qtest_enabled()) {
> --
> 2.17.1
>
>

Adding Paul.

Aleksandar
