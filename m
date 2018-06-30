Received: from eggs.gnu.org ([2001:4830:134:3::10]:37990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ96F-0004JD-0R
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ96B-0002AZ-QK
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:10 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:40592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fZ96B-00029a-I8
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:07 -0400
Received: by mail-wm0-x234.google.com with SMTP id z13-v6so3944778wma.5
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 23:11:07 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Jun 2018 08:10:16 +0200
Message-Id: <20180630061040.6018-24-pbonzini@redhat.com>
In-Reply-To: <20180630061040.6018-1-pbonzini@redhat.com>
References: <20180630061040.6018-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 23/47] hw/xtensa: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/
  $ git grep -n '[<>][<>]= ?[1-5]0'

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Message-Id: <20180625124238.25339-22-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/xtensa/xtfpga.c     | 9 +++++----
 target/xtensa/helper.c | 5 +++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 5dc1303..b3161de 100644
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
index 34844ee..c9a6132 100644
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
1.8.3.1
