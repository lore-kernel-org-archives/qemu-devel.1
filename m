Received: from eggs.gnu.org ([2001:4830:134:3::10]:59114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nicholas.a.hudson@gmail.com>) id 1gWh8R-0005CW-BN
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 07:27:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nicholas.a.hudson@gmail.com>) id 1gWh8P-0005D6-Vb
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 07:27:35 -0500
From: Nick Hudson <nicholas.a.hudson@gmail.com>
Message-ID: <975b9131-9937-cfea-3b5d-ef36d0c2b761@gmail.com>
Date: Tue, 11 Dec 2018 12:27:25 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [Qemu-devel] [PATCH v3] Support u-boot noload images for arm as
 used by, NetBSD/evbarm GENERIC kernel.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>


noload kernels are loaded with the u-boot image header and as a result
the header size needs adding to the entry point.  Fake up a hdr so the
kernel image is loaded at the right address and the entry point is
adjusted appropriately.

The bootloader fits in the space that the uboot header would have occupied.

Clarify the load_uimage API to state the passing of a load address when an
image doesn't specify one, or when loading a ramdisk is expected.

Adjust callers of load_uimage, etc.

Signed-off-by: Nick Hudson<skrll@netbsd.org>

---
  hw/arm/boot.c          |  8 +++++---
  hw/core/loader.c       | 19 ++++++++++++++++---
  hw/core/uboot_image.h  |  1 +
  hw/microblaze/boot.c   |  2 +-
  hw/nios2/boot.c        |  2 +-
  hw/ppc/e500.c          |  1 +
  hw/ppc/ppc440_bamboo.c |  2 +-
  hw/ppc/sam460ex.c      |  2 +-
  include/hw/loader.h    |  7 ++++++-
  9 files changed, 33 insertions(+), 11 deletions(-)

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
+#define KERNEL_ARGS_ADDR   0x100
+#define KERNEL_NOLOAD_ADDR 0x00000000
+#define KERNEL_LOAD_ADDR   0x00010000
  #define KERNEL64_LOAD_ADDR 0x00080000

  #define ARM64_TEXT_OFFSET_OFFSET    8
@@ -1078,7 +1079,8 @@ void arm_load_kernel(ARMCPU *cpu, struct 
arm_boot_info *info)
      }
      entry = elf_entry;
      if (kernel_size < 0) {
-        kernel_size = load_uimage_as(info->kernel_filename, &entry, NULL,
+        uint64_t loadaddr = info->loader_start + KERNEL_NOLOAD_ADDR;
+        kernel_size = load_uimage_as(info->kernel_filename, &entry, 
&loadaddr,
                                       &is_linux, NULL, NULL, as);
      }
      if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) && kernel_size < 0) {
diff --git a/hw/core/loader.c b/hw/core/loader.c
index aa0b3fc867..7362197162 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -638,13 +638,26 @@ static int load_uboot_image(const char *filename, 
hwaddr *ep, hwaddr *loadaddr,
          goto out;

      if (hdr->ih_type != image_type) {
-        fprintf(stderr, "Wrong image type %d, expected %d\n", hdr->ih_type,
-                image_type);
-        goto out;
+        if (image_type != IH_TYPE_KERNEL &&
+            hdr->ih_type != IH_TYPE_KERNEL_NOLOAD) {
+            fprintf(stderr, "Wrong image type %d, expected %d\n", 
hdr->ih_type,
+                    image_type);
+            goto out;
+        }
      }

      /* TODO: Implement other image types.  */
      switch (hdr->ih_type) {
+    case IH_TYPE_KERNEL_NOLOAD:
+        if (!loadaddr || *loadaddr == LOAD_UIMAGE_LOADADDR_INVALID) {
+            fprintf(stderr, "this image format (kernel_noload) cannot be "
+                    "loaded on this machine type");
+            goto out;
+        }
+
+        hdr->ih_load = *loadaddr + sizeof(*hdr);
+        hdr->ih_ep += hdr->ih_load;
+        /* fall through */
      case IH_TYPE_KERNEL:
          address = hdr->ih_load;
          if (translate_fn) {
diff --git a/hw/core/uboot_image.h b/hw/core/uboot_image.h
index 34c11a70a6..608022de6e 100644
--- a/hw/core/uboot_image.h
+++ b/hw/core/uboot_image.h
@@ -124,6 +124,7 @@
  #define IH_TYPE_SCRIPT        6    /* Script file     */
  #define IH_TYPE_FILESYSTEM    7    /* Filesystem Image (any type)    */
  #define IH_TYPE_FLATDT        8    /* Binary Flat Device Tree Blob    */
+#define IH_TYPE_KERNEL_NOLOAD  14    /* OS Kernel Image (noload)    */

  /*
   * Compression Types
diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
index 35bfeda7aa..489ab839b7 100644
--- a/hw/microblaze/boot.c
+++ b/hw/microblaze/boot.c
@@ -156,7 +156,7 @@ void microblaze_load_kernel(MicroBlazeCPU *cpu, 
hwaddr ddr_base,

          /* If it wasn't an ELF image, try an u-boot image.  */
          if (kernel_size < 0) {
-            hwaddr uentry, loadaddr;
+            hwaddr uentry, loadaddr = LOAD_UIMAGE_LOADADDR_INVALID;

              kernel_size = load_uimage(kernel_filename, &uentry, 
&loadaddr, 0,
                                        NULL, NULL);
diff --git a/hw/nios2/boot.c b/hw/nios2/boot.c
index 4bb5b601d3..ed5cb28e94 100644
--- a/hw/nios2/boot.c
+++ b/hw/nios2/boot.c
@@ -161,7 +161,7 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base,

          /* If it wasn't an ELF image, try an u-boot image. */
          if (kernel_size < 0) {
-            hwaddr uentry, loadaddr;
+            hwaddr uentry, loadaddr = LOAD_UIMAGE_LOADADDR_INVALID;

              kernel_size = load_uimage(kernel_filename, &uentry, 
&loadaddr, 0,
                                        NULL, NULL);
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index e6747fce28..e275178951 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -997,6 +997,7 @@ void ppce500_init(MachineState *machine)
           * Hrm. No ELF image? Try a uImage, maybe someone is giving us an
           * ePAPR compliant kernel
           */
+        loadaddr = LOAD_UIMAGE_LOADADDR_INVALID;
          payload_size = load_uimage(filename, &bios_entry, &loadaddr, NULL,
                                     NULL, NULL);
          if (payload_size < 0) {
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index f5720f979e..70428b1865 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -180,7 +180,7 @@ static void bamboo_init(MachineState *machine)
      CPUPPCState *env;
      uint64_t elf_entry;
      uint64_t elf_lowaddr;
-    hwaddr loadaddr = 0;
+    hwaddr loadaddr = LOAD_UIMAGE_LOADADDR_INVALID;
      target_long initrd_size = 0;
      DeviceState *dev;
      int success;
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 5aac58f36e..2d6d5c4402 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -402,7 +402,7 @@ static void sam460ex_init(MachineState *machine)
      CPUPPCState *env;
      PPC4xxI2CState *i2c[2];
      hwaddr entry = UBOOT_ENTRY;
-    hwaddr loadaddr = 0;
+    hwaddr loadaddr = LOAD_UIMAGE_LOADADDR_INVALID;
      target_long initrd_size = 0;
      DeviceState *dev;
      SysBusDevice *sbdev;
diff --git a/include/hw/loader.h b/include/hw/loader.h
index 67a0af84ac..a7254bc5c4 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -160,10 +160,15 @@ void load_elf_hdr(const char *filename, void *hdr, 
bool *is64, Error **errp);
  int load_aout(const char *filename, hwaddr addr, int max_sz,
                int bswap_needed, hwaddr target_page_size);

+#define LOAD_UIMAGE_LOADADDR_INVALID (-1)
+
  /** load_uimage_as:
   * @filename: Path of uimage file
   * @ep: Populated with program entry point. Ignored if NULL.
- * @loadaddr: Populated with the load address. Ignored if NULL.
+ * @loadaddr: load address if none specified in the image or when 
loading a ramdisk.
+ *            Populated with the the load address. Ignored if NULL or
+ *            LOAD_UIMAGE_LOADADDR_INVALID (images which do not specify 
a load address
+ *            will not be loadable).
   * @is_linux: Is set to true if the image loaded is Linux. Ignored if 
NULL.
   * @translate_fn: optional function to translate load addresses
   * @translate_opaque: opaque data passed to @translate_fn
-- 
2.17.1
