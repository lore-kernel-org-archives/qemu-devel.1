Received: from eggs.gnu.org ([2001:4830:134:3::10]:53640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1cnQmx-0007Hl-22
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:17:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1cnQmt-0003GB-Qt
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:17:30 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:33079)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1cnQmt-0003Ft-H1
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:17:27 -0400
Received: by mail-wr0-x231.google.com with SMTP id u48so104705506wrc.0
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 07:17:27 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 13 Mar 2017 14:17:10 +0000
Message-Id: <1489414630-21609-1-git-send-email-ard.biesheuvel@linaro.org>
Subject: [Qemu-devel] [PATCH v2] hw/arm/boot: take Linux/arm64 TEXT_OFFSET
 header field into account
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: mark.rutland@arm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>

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
---
v2: split off AArch64 specific loader logic regarding gzipped/raw and variable
    load offset into a separate helper function, which removes the need for
    loading the image twice

 hw/arm/boot.c | 64 ++++++++++++++++----
 1 file changed, 53 insertions(+), 11 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index ff621e4b6a4b..c2720c80460f 100644
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
