Received: from eggs.gnu.org ([2001:4830:134:3::10]:43924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F97-0008Vs-EQ
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F94-0008Bp-7L
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:29 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:36887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1d1F93-00085i-U1
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:26 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F8p-0006sH-Re
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 17:41:11 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Apr 2017 17:40:47 +0100
Message-Id: <1492706470-10921-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
References: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 01/24] hw/arm/boot: take Linux/arm64 TEXT_OFFSET
 header field into account
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

The arm64 boot protocol stipulates that the kernel must be loaded
TEXT_OFFSET bytes beyond a 2 MB aligned base address, where TEXT_OFFSET
could be any 4 KB multiple between 0 and 2 MB, and whose value can be
found in the header of the Image file.

So after attempts to load the arm64 kernel image as an ELF file or as a
U-Boot image have failed (both of which have their own way of specifying
the load offset), try to determine the TEXT_OFFSET from the image after
loading it but before mapping it as a ROM mapping into the guest address
space.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1489414630-21609-1-git-send-email-ard.biesheuvel@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 11 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index ff621e4..c2720c8 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -31,6 +31,9 @@
 #define KERNEL_LOAD_ADDR 0x00010000
 #define KERNEL64_LOAD_ADDR 0x00080000
 
+#define ARM64_TEXT_OFFSET_OFFSET    8
+#define ARM64_MAGIC_OFFSET          56
+
 typedef enum {
     FIXUP_NONE = 0,     /* do nothing */
     FIXUP_TERMINATOR,   /* end of insns */
@@ -768,6 +771,49 @@ static uint64_t arm_load_elf(struct arm_boot_info *info, uint64_t *pentry,
     return ret;
 }
 
+static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
+                                   hwaddr *entry)
+{
+    hwaddr kernel_load_offset = KERNEL64_LOAD_ADDR;
+    uint8_t *buffer;
+    int size;
+
+    /* On aarch64, it's the bootloader's job to uncompress the kernel. */
+    size = load_image_gzipped_buffer(filename, LOAD_IMAGE_MAX_GUNZIP_BYTES,
+                                     &buffer);
+
+    if (size < 0) {
+        gsize len;
+
+        /* Load as raw file otherwise */
+        if (!g_file_get_contents(filename, (char **)&buffer, &len, NULL)) {
+            return -1;
+        }
+        size = len;
+    }
+
+    /* check the arm64 magic header value -- very old kernels may not have it */
+    if (memcmp(buffer + ARM64_MAGIC_OFFSET, "ARM\x64", 4) == 0) {
+        uint64_t hdrvals[2];
+
+        /* The arm64 Image header has text_offset and image_size fields at 8 and
+         * 16 bytes into the Image header, respectively. The text_offset field
+         * is only valid if the image_size is non-zero.
+         */
+        memcpy(&hdrvals, buffer + ARM64_TEXT_OFFSET_OFFSET, sizeof(hdrvals));
+        if (hdrvals[1] != 0) {
+            kernel_load_offset = le64_to_cpu(hdrvals[0]);
+        }
+    }
+
+    *entry = mem_base + kernel_load_offset;
+    rom_add_blob_fixed(filename, buffer, size, *entry);
+
+    g_free(buffer);
+
+    return size;
+}
+
 static void arm_load_kernel_notify(Notifier *notifier, void *data)
 {
     CPUState *cs;
@@ -776,7 +822,7 @@ static void arm_load_kernel_notify(Notifier *notifier, void *data)
     int is_linux = 0;
     uint64_t elf_entry, elf_low_addr, elf_high_addr;
     int elf_machine;
-    hwaddr entry, kernel_load_offset;
+    hwaddr entry;
     static const ARMInsnFixup *primary_loader;
     ArmLoadKernelNotifier *n = DO_UPCAST(ArmLoadKernelNotifier,
                                          notifier, notifier);
@@ -841,14 +887,12 @@ static void arm_load_kernel_notify(Notifier *notifier, void *data)
 
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         primary_loader = bootloader_aarch64;
-        kernel_load_offset = KERNEL64_LOAD_ADDR;
         elf_machine = EM_AARCH64;
     } else {
         primary_loader = bootloader;
         if (!info->write_board_setup) {
             primary_loader += BOOTLOADER_NO_BOARD_SETUP_OFFSET;
         }
-        kernel_load_offset = KERNEL_LOAD_ADDR;
         elf_machine = EM_ARM;
     }
 
@@ -900,17 +944,15 @@ static void arm_load_kernel_notify(Notifier *notifier, void *data)
         kernel_size = load_uimage(info->kernel_filename, &entry, NULL,
                                   &is_linux, NULL, NULL);
     }
-    /* On aarch64, it's the bootloader's job to uncompress the kernel. */
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) && kernel_size < 0) {
-        entry = info->loader_start + kernel_load_offset;
-        kernel_size = load_image_gzipped(info->kernel_filename, entry,
-                                         info->ram_size - kernel_load_offset);
+        kernel_size = load_aarch64_image(info->kernel_filename,
+                                         info->loader_start, &entry);
         is_linux = 1;
-    }
-    if (kernel_size < 0) {
-        entry = info->loader_start + kernel_load_offset;
+    } else if (kernel_size < 0) {
+        /* 32-bit ARM */
+        entry = info->loader_start + KERNEL_LOAD_ADDR;
         kernel_size = load_image_targphys(info->kernel_filename, entry,
-                                          info->ram_size - kernel_load_offset);
+                                          info->ram_size - KERNEL_LOAD_ADDR);
         is_linux = 1;
     }
     if (kernel_size < 0) {
-- 
2.7.4
