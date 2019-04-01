Received: from eggs.gnu.org ([209.51.188.92]:39788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ayan@wavecomp.com>) id 1hAqYy-0002h6-JZ
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 02:36:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ayan@wavecomp.com>) id 1hAqYx-0003fk-0x
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 02:36:56 -0400
Received: from mail-cys01nam02on0709.outbound.protection.outlook.com
	([2a01:111:f400:fe45::709]:39830
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ayan@wavecomp.com>) id 1hAqYw-0003el-JQ
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 02:36:54 -0400
From: Archer Yan <ayan@wavecomp.com>
Date: Mon, 1 Apr 2019 06:36:51 +0000
Message-ID: <20190401063639.18341-1-ayan@wavecomp.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH] Support load kernel(vmlinux)/dtb/initrd
 separately for Boston in QEMU.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Archer Yan <ayan@wavecomp.com>

Currently boston in QEMU only supports boot with FIT format. Since ELF file
can provide symbol infomation in debug, this patch enables Boston boot from
vmlinux&dtb.

Signed-off-by: Archer Yan <ayan@wavecomp.com>
---
 hw/mips/boston.c | 224 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 201 insertions(+), 23 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index e5bab3cadc..5910ffdc8a 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -39,6 +39,10 @@
 #include "sysemu/device_tree.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/qtest.h"
+#include "elf.h"
+#include "sysemu/kvm.h"
+#include "hw/mips/mips.h"
+#include "qemu/option.h"
=20
 #include <libfdt.h>
=20
@@ -58,6 +62,11 @@ typedef struct {
=20
     hwaddr kernel_entry;
     hwaddr fdt_base;
+    long kernel_size;
+
+    uint64_t initrd_size;
+    uint64_t initrd_start;
+    uint64_t initrd_offset;
 } BostonState;
=20
 enum boston_plat_reg {
@@ -328,31 +337,59 @@ static void gen_firmware(uint32_t *p, hwaddr kernel_e=
ntry, hwaddr fdt_addr,
     stl_p(p++, 0x03200009);                     /* jr   $25 */
 }
=20
-static const void *boston_fdt_filter(void *opaque, const void *fdt_orig,
-                                     const void *match_data, hwaddr *load_=
addr)
+typedef uint64_t (*xlate_to_kseg0)(void *, uint64_t);
+static xlate_to_kseg0 get_xlate_to_kseg0_fn(BostonState *s)
+{
+    /* Check where the kernel has been linked */
+    if (s->kernel_entry & 0x80000000ll) {
+        if (kvm_enabled()) {
+            error_report("KVM guest kernels must be linked in useg. "
+                         "Did you forget to enable CONFIG_KVM_GUEST?");
+            return NULL;
+        }
+        return cpu_mips_phys_to_kseg0;
+    } else {
+        /* if kernel entry is in useg it is probably a KVM T&E kernel */
+        mips_um_ksegs_enable();
+        return cpu_mips_kvm_um_phys_to_kseg0;
+    }
+}
+
+/*Adapt fdt to insert initrd parameters*/
+static int boston_initrd_fdt(BostonState *s, void *fdt)
 {
-    BostonState *s =3D BOSTON(opaque);
-    MachineState *machine =3D s->mach;
     const char *cmdline;
+    char *args_str =3D NULL;
+    MachineState *machine =3D s->mach;
+    int initrd_args_len =3D 64;
     int err;
-    void *fdt;
-    size_t fdt_sz, ram_low_sz, ram_high_sz;
+    size_t ram_low_sz, ram_high_sz;
+    uint64_t (*xlate_to_kseg0_fn) (void *opaque, uint64_t addr);
=20
-    fdt_sz =3D fdt_totalsize(fdt_orig) * 2;
-    fdt =3D g_malloc0(fdt_sz);
+    cmdline =3D (machine->kernel_cmdline && machine->kernel_cmdline[0])
+            ? machine->kernel_cmdline : " ";
+    xlate_to_kseg0_fn =3D get_xlate_to_kseg0_fn(s);
+    if (NULL =3D=3D xlate_to_kseg0_fn) {
+        fprintf(stderr, "couldn't get xlate_to_kseg0\n");
+        return -1;
+    }
=20
-    err =3D fdt_open_into(fdt_orig, fdt, fdt_sz);
-    if (err) {
-        fprintf(stderr, "unable to open FDT\n");
-        return NULL;
+    s->initrd_start =3D xlate_to_kseg0_fn(NULL, s->initrd_offset);
+
+    if (s->initrd_size) {
+        args_str =3D g_malloc(strlen(cmdline) + initrd_args_len);
+        if (args_str !=3D NULL) {
+            sprintf((char *)args_str, "rd_start=3D0x%lx rd_size=3D0x%lx %s=
",
+                    s->initrd_start, s->initrd_size, cmdline);
+            cmdline =3D args_str;
+        }
     }
=20
-    cmdline =3D (machine->kernel_cmdline && machine->kernel_cmdline[0])
-            ? machine->kernel_cmdline : " ";
     err =3D qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
     if (err < 0) {
         fprintf(stderr, "couldn't set /chosen/bootargs\n");
-        return NULL;
+        g_free(args_str);
+        return -1;
     }
=20
     ram_low_sz =3D MIN(256 * MiB, machine->ram_size);
@@ -360,10 +397,41 @@ static const void *boston_fdt_filter(void *opaque, co=
nst void *fdt_orig,
     qemu_fdt_setprop_sized_cells(fdt, "/memory@0", "reg",
                                  1, 0x00000000, 1, ram_low_sz,
                                  1, 0x90000000, 1, ram_high_sz);
+    g_free(args_str);
+    return 0;
+}
=20
-    fdt =3D g_realloc(fdt, fdt_totalsize(fdt));
-    qemu_fdt_dumpdtb(fdt, fdt_sz);
+static const void *boston_fdt_filter(void *opaque, const void *fdt_orig,
+                                     const void *match_data, hwaddr *load_=
addr)
+{
+    BostonState *s =3D BOSTON(opaque);
+    MachineState *machine =3D s->mach;
+    int err;
+    void *fdt;
+    int fdt_sz;
+    if (machine->dtb) {
+        /*Use QEMU cmd specified dtb*/
+        fdt =3D load_device_tree(machine->dtb, &fdt_sz);
+    } else {
+        /*Use default dtb contained in FIT image*/
+        fdt_sz =3D fdt_totalsize(fdt_orig) * 2;
+        fdt =3D g_malloc0(fdt_sz);
+
+        err =3D fdt_open_into(fdt_orig, fdt, fdt_sz);
+        if (err) {
+            fprintf(stderr, "unable to open FDT\n");
+            return NULL;
+        }
+
+        fdt =3D g_realloc(fdt, fdt_totalsize(fdt));
+    }
=20
+    err =3D boston_initrd_fdt(s, fdt);
+    if (err) {
+        return NULL;
+    }
+
+    qemu_fdt_dumpdtb(fdt, fdt_sz);
     s->fdt_base =3D *load_addr;
=20
     return fdt;
@@ -391,6 +459,99 @@ static const struct fit_loader boston_fit_loader =3D {
     .kernel_filter =3D boston_kernel_filter,
 };
=20
+static int boston_load_dtb(BostonState *s)
+{
+    void *fdt =3D NULL;
+    int size =3D 0;
+    int err;
+    MachineState *machine =3D s->mach;
+    hwaddr load_addr;
+    hwaddr kernel_end =3D 0xffffffff80100000 + s->kernel_size;
+
+    fdt =3D load_device_tree(machine->dtb, &size);
+    if (!fdt) {
+        fprintf(stderr, "Couldn't open dtb file %s\n", machine->dtb);
+        return -1;
+    }
+    load_addr =3D ROUND_UP(kernel_end, 64 * KiB) + (10 * MiB);
+    err =3D boston_initrd_fdt(s, fdt);
+    if (err) {
+        return -1;
+    }
+
+    qemu_fdt_dumpdtb(fdt, size);
+
+    s->fdt_base =3D load_addr;
+    load_addr =3D cpu_mips_kseg0_to_phys(s, load_addr);
+    rom_add_blob_fixed("fdt@boston", fdt, size, load_addr);
+
+    return 0;
+
+}
+
+static int boston_load_initrd(BostonState *s)
+{
+    int64_t initrd_size =3D 0;
+    ram_addr_t initrd_offset =3D 0;
+    int ram_low_size;
+    MachineState *machine =3D s->mach;
+    ram_low_size =3D MIN(machine->ram_size, 256 * MiB);
+    if (machine->initrd_filename) {
+        initrd_size =3D get_image_size(machine->initrd_filename);
+        if (initrd_size > 0) {
+            /*
+             * The kernel allocates the bootmap memory in the low memory a=
fter
+             *  the initrd.  It takes at most 128kiB for 2GB RAM and 4kiB
+             *  pages.
+             */
+            initrd_offset =3D (ram_low_size - initrd_size
+                             - (128 * KiB)
+                             - ~INITRD_PAGE_MASK) & INITRD_PAGE_MASK;
+
+            initrd_size =3D load_image_targphys(machine->initrd_filename,
+                                              initrd_offset,
+                                              ram_size - initrd_offset);
+        }
+        if (initrd_size =3D=3D (target_ulong) -1) {
+            error_report("could not load initial ram disk '%s'",
+                         machine->initrd_filename);
+            return -1;
+        }
+    }
+    s->initrd_offset =3D initrd_offset;
+    s->initrd_size =3D initrd_size;
+    return 0;
+}
+
+static int boston_load_kernel(BostonState *s)
+{
+    int64_t kernel_entry, kernel_high;
+    long kernel_size;
+    int big_endian;
+    MachineState *machine =3D s->mach;
+
+#ifdef TARGET_WORDS_BIGENDIAN
+    big_endian =3D 1;
+#else
+    big_endian =3D 0;
+#endif
+
+    kernel_size =3D load_elf(machine->kernel_filename, NULL,
+                           cpu_mips_kseg0_to_phys,  NULL,
+                           (uint64_t *)&kernel_entry, NULL,
+                           (uint64_t *)&kernel_high, big_endian, EM_MIPS, =
1, 0);
+    if (kernel_size < 0) {
+        error_report("could not load kernel '%s': %s",
+                     machine->kernel_filename,
+                     load_elf_strerror(kernel_size));
+        return -1;
+    }
+
+    s->kernel_entry =3D kernel_entry;
+    s->kernel_size =3D kernel_size;
+    return 0;
+}
+
 static inline XilinxPCIEHost *
 xilinx_pcie_init(MemoryRegion *sys_mem, uint32_t bus_nr,
                  hwaddr cfg_base, uint64_t cfg_size,
@@ -433,7 +594,7 @@ static void boston_mach_init(MachineState *machine)
     PCIDevice *ahci;
     DriveInfo *hd[6];
     Chardev *chr;
-    int fw_size, fit_err;
+    int fw_size, load_err;
     bool is_64b;
=20
     if ((machine->ram_size % GiB) ||
@@ -533,12 +694,29 @@ static void boston_mach_init(MachineState *machine)
             exit(1);
         }
     } else if (machine->kernel_filename) {
-        fit_err =3D load_fit(&boston_fit_loader, machine->kernel_filename,=
 s);
-        if (fit_err) {
-            error_printf("unable to load FIT image\n");
-            exit(1);
+        if (machine->initrd_filename) {
+            load_err =3D boston_load_initrd(s);
+            if (load_err) {
+                error_printf("unable to separately load initrd image\n");
+                exit(1);
+            }
+        }
+        load_err =3D load_fit(&boston_fit_loader, machine->kernel_filename=
, s);
+        if (load_err) {
+            error_printf("unable to load FIT image, try load as ELF\n");
+            load_err =3D boston_load_kernel(s);
+            if (load_err) {
+                error_printf("unable to separately load kernel image\n");
+                exit(1);
+            }
+            if (machine->dtb) {
+                load_err =3D boston_load_dtb(s);
+                if (load_err) {
+                    error_printf("unable to separately load dtb image\n");
+                    exit(1);
+                }
+            }
         }
-
         gen_firmware(memory_region_get_ram_ptr(flash) + 0x7c00000,
                      s->kernel_entry, s->fdt_base, is_64b);
     } else if (!qtest_enabled()) {
--=20
2.17.1
