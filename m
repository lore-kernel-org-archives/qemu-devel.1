Received: from eggs.gnu.org ([2001:4830:134:3::10]:54400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXQqp-0001nt-CT
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:44:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXQqo-0007wj-50
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:44:11 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 25 Jun 2018 09:42:13 -0300
Message-Id: <20180625124238.25339-22-f4bug@amsat.org>
In-Reply-To: <20180625124238.25339-1-f4bug@amsat.org>
References: <20180625124238.25339-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 21/46] hw/xtensa: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/
  $ git grep -n '[<>][<>]= ?[1-5]0'

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
---
 hw/xtensa/xtfpga.c     | 9 +++++----
 target/xtensa/helper.c | 5 +++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 5dc13034f9..b3161de320 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -26,6 +26,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "sysemu/sysemu.h"
@@ -152,7 +153,7 @@ static void xtfpga_net_init(MemoryRegion *address_space,
             sysbus_mmio_get_region(s, 1));
 
     ram = g_malloc(sizeof(*ram));
-    memory_region_init_ram_nomigrate(ram, OBJECT(s), "open_eth.ram", 16384,
+    memory_region_init_ram_nomigrate(ram, OBJECT(s), "open_eth.ram", 16 * KiB,
                            &error_fatal);
     vmstate_register_ram_global(ram);
     memory_region_add_subregion(address_space, buffers, ram);
@@ -229,7 +230,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
     const char *kernel_cmdline = qemu_opt_get(machine_opts, "append");
     const char *dtb_filename = qemu_opt_get(machine_opts, "dtb");
     const char *initrd_filename = qemu_opt_get(machine_opts, "initrd");
-    const unsigned system_io_size = 224 * 1024 * 1024;
+    const unsigned system_io_size = 224 * MiB;
     int n;
 
     for (n = 0; n < smp_cpus; n++) {
@@ -342,7 +343,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
             cpu_physical_memory_write(cur_lowmem, fdt, fdt_size);
             cur_tagptr = put_tag(cur_tagptr, BP_TAG_FDT,
                                  sizeof(dtb_addr), &dtb_addr);
-            cur_lowmem = QEMU_ALIGN_UP(cur_lowmem + fdt_size, 4096);
+            cur_lowmem = QEMU_ALIGN_UP(cur_lowmem + fdt_size, 4 * KiB);
         }
 #else
         if (dtb_filename) {
@@ -370,7 +371,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
             initrd_location.end = tswap32(cur_lowmem + initrd_size);
             cur_tagptr = put_tag(cur_tagptr, BP_TAG_INITRD,
                                  sizeof(initrd_location), &initrd_location);
-            cur_lowmem = QEMU_ALIGN_UP(cur_lowmem + initrd_size, 4096);
+            cur_lowmem = QEMU_ALIGN_UP(cur_lowmem + initrd_size, 4 * KiB);
         }
         cur_tagptr = put_tag(cur_tagptr, BP_TAG_LAST, 0, NULL);
         env->regs[2] = tagptr;
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 34844eead3..c9a6132700 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -26,6 +26,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/gdbstub.h"
@@ -726,10 +727,10 @@ static void dump_tlb(FILE *f, fprintf_function cpu_fprintf,
         bool print_header = true;
 
         if (sz >= 0x100000) {
-            sz >>= 20;
+            sz /= MiB;
             sz_text = "MB";
         } else {
-            sz >>= 10;
+            sz /= KiB;
             sz_text = "KB";
         }
 
-- 
2.18.0
