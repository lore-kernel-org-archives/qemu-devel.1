Received: from eggs.gnu.org ([2001:4830:134:3::10]:41931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nicholas.a.hudson@gmail.com>) id 1gSSpw-0000j5-1i
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 15:23:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nicholas.a.hudson@gmail.com>) id 1gSSpu-0006Du-7f
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 15:22:59 -0500
From: Nick Hudson <nicholas.a.hudson@gmail.com>
Message-ID: <fe1367d1-33f7-21fa-be84-20b9795a2157@gmail.com>
Date: Thu, 29 Nov 2018 20:22:47 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2] Support u-boot noload images for arm as
 used by, NetBSD/evbarm GENERIC kernel.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org

noload kernels are loaded with the u-boot image header and as a result
the header size needs adding to the entry point.  Fake up a hdr so the
kernel image is loaded at the right address and the entry point is
adjusted appropriately.

The bootloader fits in the space that the uboot header would have occupied.

Update the load_uimage API to allow passing of load address when an image
doesn't specify one.

Signed-off-by: Nick Hudson <skrll@netbsd.org>
---
 hw/arm/boot.c         |  8 +++++---
 hw/core/loader.c      | 15 ++++++++++++---
 hw/core/uboot_image.h |  1 +
 include/hw/loader.h   |  3 ++-
 4 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 586baa9b64..450267566a 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -30,8 +30,9 @@
  * Documentation/arm/Booting and Documentation/arm64/booting.txt
  * They have different preferred image load offsets from system RAM base.
  */
-#define KERNEL_ARGS_ADDR 0x100
-#define KERNEL_LOAD_ADDR 0x00010000
+#define KERNEL_ARGS_ADDR   0x100
+#define KERNEL_NOLOAD_ADDR 0x00000000
+#define KERNEL_LOAD_ADDR   0x00010000
 #define KERNEL64_LOAD_ADDR 0x00080000

 #define ARM64_TEXT_OFFSET_OFFSET    8
@@ -1078,7 +1079,8 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
     }
     entry = elf_entry;
     if (kernel_size < 0) {
-        kernel_size = load_uimage_as(info->kernel_filename, &entry, NULL,
+        uint64_t loadaddr = info->loader_start + KERNEL_NOLOAD_ADDR;
+        kernel_size = load_uimage_as(info->kernel_filename, &entry, &loadaddr,
                                      &is_linux, NULL, NULL, as);
     }
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) && kernel_size < 0) {
diff --git a/hw/core/loader.c b/hw/core/loader.c
index aa0b3fc867..5537e88817 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -638,13 +638,22 @@ static int load_uboot_image(const char *filename, hwaddr *ep, hwaddr *loadaddr,
         goto out;

     if (hdr->ih_type != image_type) {
-        fprintf(stderr, "Wrong image type %d, expected %d\n", hdr->ih_type,
-                image_type);
-        goto out;
+        if (image_type != IH_TYPE_KERNEL && hdr->ih_type != IH_TYPE_KERNEL_NOLOAD) {
+            fprintf(stderr, "Wrong image type %d, expected %d\n", hdr->ih_type,
+                    image_type);
+            goto out;
+        }
     }

     /* TODO: Implement other image types.  */
     switch (hdr->ih_type) {
+    case IH_TYPE_KERNEL_NOLOAD:
+       if (loadaddr == NULL)
+            goto out;
+
+        hdr->ih_load = *loadaddr + sizeof(*hdr);
+        hdr->ih_ep += hdr->ih_load;
+        /* fall through */
     case IH_TYPE_KERNEL:
         address = hdr->ih_load;
         if (translate_fn) {
diff --git a/hw/core/uboot_image.h b/hw/core/uboot_image.h
index 34c11a70a6..608022de6e 100644
--- a/hw/core/uboot_image.h
+++ b/hw/core/uboot_image.h
@@ -124,6 +124,7 @@
 #define IH_TYPE_SCRIPT         6       /* Script file                  */
 #define IH_TYPE_FILESYSTEM     7       /* Filesystem Image (any type)  */
 #define IH_TYPE_FLATDT         8       /* Binary Flat Device Tree Blob */
+#define IH_TYPE_KERNEL_NOLOAD  14      /* OS Kernel Image (noload)     */

 /*
  * Compression Types
diff --git a/include/hw/loader.h b/include/hw/loader.h
index 67a0af84ac..10ff0ff76d 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -163,7 +163,8 @@ int load_aout(const char *filename, hwaddr addr, int max_sz,
 /** load_uimage_as:
  * @filename: Path of uimage file
  * @ep: Populated with program entry point. Ignored if NULL.
- * @loadaddr: Populated with the load address. Ignored if NULL.
+ * @loadaddr: load address if none specified in the image. Populated with the
+ *            load address. Ignored if NULL.
  * @is_linux: Is set to true if the image loaded is Linux. Ignored if NULL.
  * @translate_fn: optional function to translate load addresses
  * @translate_opaque: opaque data passed to @translate_fn
--
2.17.1
