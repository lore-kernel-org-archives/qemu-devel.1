Received: from eggs.gnu.org ([209.51.188.92]:46717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXpO-0005gW-4K
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:32:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXpK-00038p-3B
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:32:35 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36299)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggXpG-0002a2-5w
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:32:32 -0500
Received: by mail-wr1-x443.google.com with SMTP id u4so1091630wrp.3
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 08:32:08 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	j14sm46039759wrv.96.2019.01.07.08.32.04 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 07 Jan 2019 08:32:05 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  7 Jan 2019 16:31:17 +0000
Message-Id: <20190107163117.16269-38-peter.maydell@linaro.org>
In-Reply-To: <20190107163117.16269-1-peter.maydell@linaro.org>
References: <20190107163117.16269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 37/37] Support u-boot noload images for arm as
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

From: Nick Hudson <nick.hudson@gmx.co.uk>

noload kernels are loaded with the u-boot image header and as a result
the header size needs adding to the entry point.  Fake up a hdr so the
kernel image is loaded at the right address and the entry point is
adjusted appropriately.

The default location for the uboot file is 32MiB above bottom of DRAM.
This matches the recommendation in Documentation/arm/Booting.

Clarify the load_uimage API to state the passing of a load address when an
image doesn't specify one, or when loading a ramdisk is expected.

Adjust callers of load_uimage, etc.

Signed-off-by: Nick Hudson <skrll@netbsd.org>
Message-id: 11488a08-1fe0-a278-2210-deb64731107f@gmx.co.uk
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/core/uboot_image.h  |  1 +
 include/hw/loader.h    |  7 ++++++-
 hw/arm/boot.c          |  8 +++++---
 hw/core/loader.c       | 19 ++++++++++++++++---
 hw/microblaze/boot.c   |  2 +-
 hw/nios2/boot.c        |  2 +-
 hw/ppc/e500.c          |  1 +
 hw/ppc/ppc440_bamboo.c |  2 +-
 hw/ppc/sam460ex.c      |  2 +-
 9 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/hw/core/uboot_image.h b/hw/core/uboot_image.h
index 34c11a70a67..608022de6ec 100644
--- a/hw/core/uboot_image.h
+++ b/hw/core/uboot_image.h
@@ -124,6 +124,7 @@
 #define IH_TYPE_SCRIPT		6	/* Script file			*/
 #define IH_TYPE_FILESYSTEM	7	/* Filesystem Image (any type)	*/
 #define IH_TYPE_FLATDT		8	/* Binary Flat Device Tree Blob	*/
+#define IH_TYPE_KERNEL_NOLOAD  14	/* OS Kernel Image (noload)	*/
 
 /*
  * Compression Types
diff --git a/include/hw/loader.h b/include/hw/loader.h
index 0a0ad808ea3..de8a29603b0 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -175,10 +175,15 @@ void load_elf_hdr(const char *filename, void *hdr, bool *is64, Error **errp);
 int load_aout(const char *filename, hwaddr addr, int max_sz,
               int bswap_needed, hwaddr target_page_size);
 
+#define LOAD_UIMAGE_LOADADDR_INVALID (-1)
+
 /** load_uimage_as:
  * @filename: Path of uimage file
  * @ep: Populated with program entry point. Ignored if NULL.
- * @loadaddr: Populated with the load address. Ignored if NULL.
+ * @loadaddr: load address if none specified in the image or when loading a
+ *            ramdisk. Populated with the load address. Ignored if NULL or
+ *            LOAD_UIMAGE_LOADADDR_INVALID (images which do not specify a load
+ *            address will not be loadable).
  * @is_linux: Is set to true if the image loaded is Linux. Ignored if NULL.
  * @translate_fn: optional function to translate load addresses
  * @translate_opaque: opaque data passed to @translate_fn
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 94fce128028..c7a67af7a97 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -30,8 +30,9 @@
  * Documentation/arm/Booting and Documentation/arm64/booting.txt
  * They have different preferred image load offsets from system RAM base.
  */
-#define KERNEL_ARGS_ADDR 0x100
-#define KERNEL_LOAD_ADDR 0x00010000
+#define KERNEL_ARGS_ADDR   0x100
+#define KERNEL_NOLOAD_ADDR 0x02000000
+#define KERNEL_LOAD_ADDR   0x00010000
 #define KERNEL64_LOAD_ADDR 0x00080000
 
 #define ARM64_TEXT_OFFSET_OFFSET    8
@@ -1082,7 +1083,8 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
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
index fa41842280a..c7182dfa64b 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -613,13 +613,26 @@ static int load_uboot_image(const char *filename, hwaddr *ep, hwaddr *loadaddr,
         goto out;
 
     if (hdr->ih_type != image_type) {
-        fprintf(stderr, "Wrong image type %d, expected %d\n", hdr->ih_type,
-                image_type);
-        goto out;
+        if (!(image_type == IH_TYPE_KERNEL &&
+            hdr->ih_type == IH_TYPE_KERNEL_NOLOAD)) {
+            fprintf(stderr, "Wrong image type %d, expected %d\n", hdr->ih_type,
+                    image_type);
+            goto out;
+        }
     }
 
     /* TODO: Implement other image types.  */
     switch (hdr->ih_type) {
+    case IH_TYPE_KERNEL_NOLOAD:
+        if (!loadaddr || *loadaddr == LOAD_UIMAGE_LOADADDR_INVALID) {
+            fprintf(stderr, "this image format (kernel_noload) cannot be "
+                    "loaded on this machine type");
+            goto out;
+        }
+
+        hdr->ih_load = *loadaddr + sizeof(*hdr);
+        hdr->ih_ep += hdr->ih_load;
+        /* fall through */
     case IH_TYPE_KERNEL:
         address = hdr->ih_load;
         if (translate_fn) {
diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
index 35bfeda7aa7..489ab839b7c 100644
--- a/hw/microblaze/boot.c
+++ b/hw/microblaze/boot.c
@@ -156,7 +156,7 @@ void microblaze_load_kernel(MicroBlazeCPU *cpu, hwaddr ddr_base,
 
         /* If it wasn't an ELF image, try an u-boot image.  */
         if (kernel_size < 0) {
-            hwaddr uentry, loadaddr;
+            hwaddr uentry, loadaddr = LOAD_UIMAGE_LOADADDR_INVALID;
 
             kernel_size = load_uimage(kernel_filename, &uentry, &loadaddr, 0,
                                       NULL, NULL);
diff --git a/hw/nios2/boot.c b/hw/nios2/boot.c
index 4bb5b601d3a..ed5cb28e942 100644
--- a/hw/nios2/boot.c
+++ b/hw/nios2/boot.c
@@ -161,7 +161,7 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base,
 
         /* If it wasn't an ELF image, try an u-boot image. */
         if (kernel_size < 0) {
-            hwaddr uentry, loadaddr;
+            hwaddr uentry, loadaddr = LOAD_UIMAGE_LOADADDR_INVALID;
 
             kernel_size = load_uimage(kernel_filename, &uentry, &loadaddr, 0,
                                       NULL, NULL);
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index b20fea0dfce..0581e9e3d4c 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -995,6 +995,7 @@ void ppce500_init(MachineState *machine)
          * Hrm. No ELF image? Try a uImage, maybe someone is giving us an
          * ePAPR compliant kernel
          */
+        loadaddr = LOAD_UIMAGE_LOADADDR_INVALID;
         payload_size = load_uimage(filename, &bios_entry, &loadaddr, NULL,
                                    NULL, NULL);
         if (payload_size < 0) {
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index b8aa55d5266..fc061915887 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -179,7 +179,7 @@ static void bamboo_init(MachineState *machine)
     CPUPPCState *env;
     uint64_t elf_entry;
     uint64_t elf_lowaddr;
-    hwaddr loadaddr = 0;
+    hwaddr loadaddr = LOAD_UIMAGE_LOADADDR_INVALID;
     target_long initrd_size = 0;
     DeviceState *dev;
     int success;
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 4b051c0950a..84ea592749c 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -402,7 +402,7 @@ static void sam460ex_init(MachineState *machine)
     CPUPPCState *env;
     PPC4xxI2CState *i2c[2];
     hwaddr entry = UBOOT_ENTRY;
-    hwaddr loadaddr = 0;
+    hwaddr loadaddr = LOAD_UIMAGE_LOADADDR_INVALID;
     target_long initrd_size = 0;
     DeviceState *dev;
     SysBusDevice *sbdev;
-- 
2.19.2
