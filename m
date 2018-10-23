Received: from eggs.gnu.org ([2001:4830:134:3::10]:47495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEwUB-0000Rm-Gg
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:12:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEwU7-0002w8-ET
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:12:39 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:57934 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gEwU3-0002qY-Ha
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:12:33 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 23 Oct 2018 15:12:14 +0200
Message-Id: <1540300334-9520-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] target/mips: Add initrd support for Boston
 board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, arikalo@wavecomp.com, amarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Rikalo <arikalo@wavecomp.com>

Add support for initial ramdisk loading for the Mips Boston board.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
v2->v3:
  - a comment was reformatted
  - rebased to the latest QEMU code
v1->v2:
  - 'long inird_size' is changed to 'target_ulong initrd_size',
    as it should be
  - error_report() is used instead of fprintf()
---
 hw/mips/boston.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++----=
-----
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 6c9c20a..788bf69 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -31,6 +31,7 @@
 #include "hw/loader-fit.h"
 #include "hw/mips/cps.h"
 #include "hw/mips/cpudevs.h"
+#include "hw/mips/mips.h"
 #include "hw/pci-host/xilinx-pcie.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
@@ -333,10 +334,12 @@ static const void *boston_fdt_filter(void *opaque, =
const void *fdt_orig,
 {
     BostonState *s =3D BOSTON(opaque);
     MachineState *machine =3D s->mach;
-    const char *cmdline;
+    GString *cmdline;
     int err;
     void *fdt;
     size_t fdt_sz, ram_low_sz, ram_high_sz;
+    target_ulong initrd_size;
+    ram_addr_t initrd_offset;
=20
     fdt_sz =3D fdt_totalsize(fdt_orig) * 2;
     fdt =3D g_malloc0(fdt_sz);
@@ -347,20 +350,54 @@ static const void *boston_fdt_filter(void *opaque, =
const void *fdt_orig,
         return NULL;
     }
=20
-    cmdline =3D (machine->kernel_cmdline && machine->kernel_cmdline[0])
-            ? machine->kernel_cmdline : " ";
-    err =3D qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline)=
;
-    if (err < 0) {
-        fprintf(stderr, "couldn't set /chosen/bootargs\n");
-        return NULL;
-    }
-
     ram_low_sz =3D MIN(256 * MiB, machine->ram_size);
     ram_high_sz =3D machine->ram_size - ram_low_sz;
     qemu_fdt_setprop_sized_cells(fdt, "/memory@0", "reg",
                                  1, 0x00000000, 1, ram_low_sz,
                                  1, 0x90000000, 1, ram_high_sz);
=20
+    cmdline =3D g_string_new(machine->kernel_cmdline);
+
+    /* load initrd */
+    initrd_offset =3D 0;
+    if (machine->initrd_filename) {
+        initrd_size =3D get_image_size(machine->initrd_filename);
+        if (initrd_size !=3D (target_ulong) -1) {
+            /*
+             * The kernel allocates the bootmap memory in the low memory=
 after
+             * the initrd. It takes at most 128kiB for 2GB RAM and 4kiB =
pages.
+             */
+            initrd_offset =3D (ram_low_sz - initrd_size - 131072
+                             - ~INITRD_PAGE_MASK) & INITRD_PAGE_MASK;
+
+            if ((int64_t)cpu_mips_kseg0_to_phys(NULL, *load_addr + fdt_s=
z)
+                >=3D (int64_t)initrd_offset) {
+                error_report("memory too small for initial ram disk '%s'=
",
+                             machine->initrd_filename);
+                exit(1);
+            }
+
+            initrd_size =3D load_image_targphys(machine->initrd_filename=
,
+                                              initrd_offset,
+                                              initrd_size);
+        }
+        if (initrd_size =3D=3D (target_ulong) -1) {
+            error_report("could not load initial ram disk '%s'",
+                         machine->initrd_filename);
+            exit(1);
+        }
+        g_string_append_printf(cmdline, " rd_start=3D0x%" PRIx64 " rd_si=
ze=3D%li",
+                               cpu_mips_phys_to_kseg0(NULL, initrd_offse=
t),
+                               initrd_size);
+    }
+
+    err =3D qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline-=
>str);
+    g_string_free(cmdline, true);
+    if (err < 0) {
+        error_report("couldn't set /chosen/bootargs");
+        exit(1);
+    }
+
     fdt =3D g_realloc(fdt, fdt_totalsize(fdt));
     qemu_fdt_dumpdtb(fdt, fdt_sz);
=20
--=20
2.7.4
