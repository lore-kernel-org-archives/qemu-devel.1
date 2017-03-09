Received: from eggs.gnu.org ([2001:4830:134:3::10]:46512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1cm1Za-0004sx-CO
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:09:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1cm1ZW-0002gG-BU
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:09:54 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:37775)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1cm1ZW-0002fd-4R
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:09:50 -0500
Received: by mail-wm0-x22f.google.com with SMTP id n11so61268774wma.0
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 09:09:48 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu,  9 Mar 2017 18:09:43 +0100
Message-Id: <1489079383-11162-1-git-send-email-ard.biesheuvel@linaro.org>
Subject: [Qemu-devel] [PATCH] hw/arm/boot: take Linux/arm64 TEXT_OFFSET
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>

The arm64 boot protocol stipulates that the kernel must be loaded
TEXT_OFFSET bytes beyond a 2 MB aligned base address, where TEXT_OFFSET
could be any 4 KB multiple between 0 and 2 MB, and whose value can be
found in the header of the Image file.

So after attempts to load the kernel image as an ELF file or as a
U-Boot image (both of which have their own way of specifying the load
offset) have failed, try to determine the TEXT_OFFSET from the image
before proceeding with loading it as a gzipped or raw image.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 hw/arm/boot.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index ff621e4b6a4b..0824f74c697f 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -31,6 +31,11 @@
 #define KERNEL_LOAD_ADDR 0x00010000
 #define KERNEL64_LOAD_ADDR 0x00080000
 
+#define ARM64_IMAGE_HEADER_SIZE     64
+#define ARM64_TEXT_OFFSET_OFFSET    8
+#define ARM64_IMAGE_SIZE_OFFSET     16
+#define ARM64_MAGIC_OFFSET          56
+
 typedef enum {
     FIXUP_NONE = 0,     /* do nothing */
     FIXUP_TERMINATOR,   /* end of insns */
@@ -768,6 +773,51 @@ static uint64_t arm_load_elf(struct arm_boot_info *info, uint64_t *pentry,
     return ret;
 }
 
+static void aarch64_get_text_offset(struct arm_boot_info *info,
+                                    hwaddr *text_offset)
+{
+    uint8_t *buffer;
+    uint64_t headerval;
+    int size;
+
+    size = load_image_gzipped_buffer(info->kernel_filename,
+                                     LOAD_IMAGE_MAX_GUNZIP_BYTES,
+                                     &buffer);
+
+    if (size < 0) {
+        int fd, bytes;
+
+        fd = open(info->kernel_filename, O_RDONLY | O_BINARY);
+        if (fd < 0)
+            return;
+
+        buffer = g_malloc(ARM64_IMAGE_HEADER_SIZE);
+        bytes = read(fd, buffer, ARM64_IMAGE_HEADER_SIZE);
+        close(fd);
+
+        if (bytes < ARM64_IMAGE_HEADER_SIZE)
+            goto free_buffer;
+    }
+
+    /* check the arm64 magic header value */
+    if (memcmp(buffer + ARM64_MAGIC_OFFSET, "ARM\x64", 4) != 0)
+        goto free_buffer;
+
+    /* The arm64 Image header has text_offset and image_size fields at 8 and
+     * 16 bytes into the Image header, respectively. The text_offset field is
+     * only valid if the image_size is non-zero.
+     */
+    memcpy(&headerval, buffer + ARM64_IMAGE_SIZE_OFFSET, sizeof(headerval));
+    if (headerval == 0)
+        goto free_buffer;
+
+    memcpy(&headerval, buffer + ARM64_TEXT_OFFSET_OFFSET, sizeof(headerval));
+    *text_offset = le64_to_cpu(headerval);
+
+free_buffer:
+    g_free(buffer);
+}
+
 static void arm_load_kernel_notify(Notifier *notifier, void *data)
 {
     CPUState *cs;
@@ -900,6 +950,12 @@ static void arm_load_kernel_notify(Notifier *notifier, void *data)
         kernel_size = load_uimage(info->kernel_filename, &entry, NULL,
                                   &is_linux, NULL, NULL);
     }
+
+    /* A bare Linux/arm64 kernel carries the load offset in the Image header */
+    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) && kernel_size < 0) {
+        aarch64_get_text_offset(info, &kernel_load_offset);
+    }
+
     /* On aarch64, it's the bootloader's job to uncompress the kernel. */
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) && kernel_size < 0) {
         entry = info->loader_start + kernel_load_offset;
-- 
2.7.4
