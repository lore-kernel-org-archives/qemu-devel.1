Received: from eggs.gnu.org ([2001:4830:134:3::10]:56204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1eS4jc-0003CT-Rw
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 12:34:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1eS4jZ-0007VG-JE
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 12:34:20 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:56926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jack.schwartz@oracle.com>)
	id 1eS4jZ-0007Uo-9z
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 12:34:17 -0500
From: Jack Schwartz <jack.schwartz@oracle.com>
Date: Thu, 21 Dec 2017 09:25:18 -0800
Message-Id: <1513877118-3149-5-git-send-email-jack.schwartz@oracle.com>
In-Reply-To: <1513877118-3149-1-git-send-email-jack.schwartz@oracle.com>
References: <1513877118-3149-1-git-send-email-jack.schwartz@oracle.com>
Subject: [Qemu-devel] [PATCH QEMU v1 4/4] multiboot: fprintf(stderr...) ->
 error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, daniel.kiper@oracle.com, konrad.wilk@oracle.com

Change all fprintf(stderr...) calls in hw/i386/multiboot.c to call
error_report() instead, including the mb_debug macro.  Remove the "\n"
from strings passed to all modified calls, since error_report() appends
one.

Signed-off-by: Jack Schwartz <jack.schwartz@oracle.com>
Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 hw/i386/multiboot.c | 55 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 818728b..d9a0a95 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -31,12 +31,13 @@
 #include "hw/loader.h"
 #include "elf.h"
 #include "sysemu/sysemu.h"
+#include "qemu/error-report.h"
 
 /* Show multiboot debug output */
 //#define DEBUG_MULTIBOOT
 
 #ifdef DEBUG_MULTIBOOT
-#define mb_debug(a...) fprintf(stderr, ## a)
+#define mb_debug(a...) error_report(a)
 #else
 #define mb_debug(a...)
 #endif
@@ -137,7 +138,7 @@ static void mb_add_mod(MultibootState *s,
     stl_p(p + MB_MOD_END,     end);
     stl_p(p + MB_MOD_CMDLINE, cmdline_phys);
 
-    mb_debug("mod%02d: "TARGET_FMT_plx" - "TARGET_FMT_plx"\n",
+    mb_debug("mod%02d: "TARGET_FMT_plx" - "TARGET_FMT_plx,
              s->mb_mods_count, start, end);
 
     s->mb_mods_count++;
@@ -179,12 +180,12 @@ int load_multiboot(FWCfgState *fw_cfg,
     if (!is_multiboot)
         return 0; /* no multiboot */
 
-    mb_debug("qemu: I believe we found a multiboot image!\n");
+    mb_debug("qemu: I believe we found a multiboot image!");
     memset(bootinfo, 0, sizeof(bootinfo));
     memset(&mbs, 0, sizeof(mbs));
 
     if (flags & 0x00000004) { /* MULTIBOOT_HEADER_HAS_VBE */
-        fprintf(stderr, "qemu: multiboot knows VBE. we don't.\n");
+        error_report("qemu: multiboot knows VBE. we don't.");
     }
     if (!(flags & 0x00010000)) { /* MULTIBOOT_HEADER_HAS_ADDR */
         uint64_t elf_entry;
@@ -193,7 +194,7 @@ int load_multiboot(FWCfgState *fw_cfg,
         fclose(f);
 
         if (((struct elf64_hdr*)header)->e_machine == EM_X86_64) {
-            fprintf(stderr, "Cannot load x86-64 image, give a 32bit one.\n");
+            error_report("Cannot load x86-64 image, give a 32bit one.");
             exit(1);
         }
 
@@ -201,7 +202,7 @@ int load_multiboot(FWCfgState *fw_cfg,
                                &elf_low, &elf_high, 0, I386_ELF_MACHINE,
                                0, 0);
         if (kernel_size < 0) {
-            fprintf(stderr, "Error while loading elf kernel\n");
+            error_report("Error while loading elf kernel");
             exit(1);
         }
         mh_load_addr = elf_low;
@@ -210,12 +211,13 @@ int load_multiboot(FWCfgState *fw_cfg,
 
         mbs.mb_buf = g_malloc(mb_kernel_size);
         if (rom_copy(mbs.mb_buf, mh_load_addr, mb_kernel_size) != mb_kernel_size) {
-            fprintf(stderr, "Error while fetching elf kernel from rom\n");
+            error_report("Error while fetching elf kernel from rom");
             exit(1);
         }
 
-        mb_debug("qemu: loading multiboot-elf kernel (%#x bytes) with entry %#zx\n",
-                  mb_kernel_size, (size_t)mh_entry_addr);
+        mb_debug("qemu: loading multiboot-elf kernel "
+                 "(%#x bytes) with entry %#zx",
+                 mb_kernel_size, (size_t)mh_entry_addr);
     } else {
         /* Valid if mh_flags sets MULTIBOOT_HEADER_HAS_ADDR. */
         uint32_t mh_header_addr = ldl_p(header+i+12);
@@ -224,7 +226,7 @@ int load_multiboot(FWCfgState *fw_cfg,
 
         mh_load_addr = ldl_p(header+i+16);
         if (mh_header_addr < mh_load_addr) {
-            fprintf(stderr, "invalid load_addr address\n");
+            error_report("invalid load_addr address");
             exit(1);
         }
 
@@ -234,20 +236,20 @@ int load_multiboot(FWCfgState *fw_cfg,
 
         if (mh_load_end_addr) {
             if (mh_load_end_addr < mh_load_addr) {
-                fprintf(stderr, "invalid load_end_addr address\n");
+                error_report("invalid load_end_addr address");
                 exit(1);
             }
             mb_load_size = mh_load_end_addr - mh_load_addr;
         } else {
             if (kernel_file_size < mb_kernel_text_offset) {
-                fprintf(stderr, "invalid kernel_file_size\n");
+                error_report("invalid kernel_file_size");
                 exit(1);
             }
             mb_load_size = kernel_file_size - mb_kernel_text_offset;
         }
         if (mh_bss_end_addr) {
             if (mh_bss_end_addr < (mh_load_addr + mb_load_size)) {
-                fprintf(stderr, "invalid bss_end_addr address\n");
+                error_report("invalid bss_end_addr address");
                 exit(1);
             }
             mb_kernel_size = mh_bss_end_addr - mh_load_addr;
@@ -255,17 +257,17 @@ int load_multiboot(FWCfgState *fw_cfg,
             mb_kernel_size = mb_load_size;
         }
 
-        mb_debug("multiboot: header_addr = %#x\n", mh_header_addr);
-        mb_debug("multiboot: load_addr = %#x\n", mh_load_addr);
-        mb_debug("multiboot: load_end_addr = %#x\n", mh_load_end_addr);
-        mb_debug("multiboot: bss_end_addr = %#x\n", mh_bss_end_addr);
-        mb_debug("qemu: loading multiboot kernel (%#x bytes) at %#x\n",
+        mb_debug("multiboot: header_addr = %#x", mh_header_addr);
+        mb_debug("multiboot: load_addr = %#x", mh_load_addr);
+        mb_debug("multiboot: load_end_addr = %#x", mh_load_end_addr);
+        mb_debug("multiboot: bss_end_addr = %#x", mh_bss_end_addr);
+        mb_debug("qemu: loading multiboot kernel (%#x bytes) at %#x",
                  mb_load_size, mh_load_addr);
 
         mbs.mb_buf = g_malloc(mb_kernel_size);
         fseek(f, mb_kernel_text_offset, SEEK_SET);
         if (fread(mbs.mb_buf, 1, mb_load_size, f) != mb_load_size) {
-            fprintf(stderr, "fread() failed\n");
+            error_report("fread() failed");
             exit(1);
         }
         memset(mbs.mb_buf + mb_load_size, 0, mb_kernel_size - mb_load_size);
@@ -319,10 +321,10 @@ int load_multiboot(FWCfgState *fw_cfg,
             hwaddr c = mb_add_cmdline(&mbs, tmpbuf);
             if ((next_space = strchr(tmpbuf, ' ')))
                 *next_space = '\0';
-            mb_debug("multiboot loading module: %s\n", tmpbuf);
+            mb_debug("multiboot loading module: %s", tmpbuf);
             mb_mod_length = get_image_size(tmpbuf);
             if (mb_mod_length < 0) {
-                fprintf(stderr, "Failed to open file '%s'\n", tmpbuf);
+                error_report("Failed to open file '%s'", tmpbuf);
                 exit(1);
             }
 
@@ -333,7 +335,7 @@ int load_multiboot(FWCfgState *fw_cfg,
             mb_add_mod(&mbs, mbs.mb_buf_phys + offs,
                        mbs.mb_buf_phys + offs + mb_mod_length, c);
 
-            mb_debug("mod_start: %p\nmod_end:   %p\n  cmdline: "TARGET_FMT_plx"\n",
+            mb_debug("mod_start: %p\nmod_end:   %p\n  cmdline: "TARGET_FMT_plx,
                      (char *)mbs.mb_buf + offs,
                      (char *)mbs.mb_buf + offs + mb_mod_length, c);
             initrd_filename = next_initrd+1;
@@ -361,10 +363,11 @@ int load_multiboot(FWCfgState *fw_cfg,
     stl_p(bootinfo + MBI_BOOT_DEVICE, 0x8000ffff); /* XXX: use the -boot switch? */
     stl_p(bootinfo + MBI_MMAP_ADDR,   ADDR_E820_MAP);
 
-    mb_debug("multiboot: entry_addr = %#x\n", mh_entry_addr);
-    mb_debug("           mb_buf_phys   = "TARGET_FMT_plx"\n", mbs.mb_buf_phys);
-    mb_debug("           mod_start     = "TARGET_FMT_plx"\n", mbs.mb_buf_phys + mbs.offset_mods);
-    mb_debug("           mb_mods_count = %d\n", mbs.mb_mods_count);
+    mb_debug("multiboot: entry_addr = %#x", mh_entry_addr);
+    mb_debug("           mb_buf_phys   = "TARGET_FMT_plx, mbs.mb_buf_phys);
+    mb_debug("           mod_start     = "TARGET_FMT_plx,
+             mbs.mb_buf_phys + mbs.offset_mods);
+    mb_debug("           mb_mods_count = %d", mbs.mb_mods_count);
 
     /* save bootinfo off the stack */
     mb_bootinfo_data = g_memdup(bootinfo, sizeof(bootinfo));
-- 
1.8.3.1
