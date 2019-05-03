Received: from eggs.gnu.org ([209.51.188.92]:34148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMbkx-0006cs-Bm
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMbkv-00015A-R9
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:13:55 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMbkv-00014Z-K6
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:13:53 -0400
Received: by mail-wm1-x343.google.com with SMTP id y2so7629180wmi.5
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 10:13:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  3 May 2019 18:13:47 +0100
Message-Id: <20190503171347.13747-3-peter.maydell@linaro.org>
In-Reply-To: <20190503171347.13747-1-peter.maydell@linaro.org>
References: <20190503171347.13747-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/2] hw/arm/boot: Honour image size field in
 AArch64 Image format kernels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Mark Rutland <mark.rutland@arm.com>

Since Linux v3.17, the kernel's Image header includes a field image_size,
which gives the total size of the kernel including unpopulated data
sections such as the BSS). If this is present, then return it from
load_aarch64_image() as the true size of the kernel rather than
just using the size of the Image file itself. This allows the code
which calculates where to put the initrd to avoid putting it in
the kernel's BSS area.

This means that we should be able to reliably load kernel images
which are larger than 128MB without accidentally putting the
initrd or dtb in locations that clash with the kernel itself.

Fixes: https://bugs.launchpad.net/qemu/+bug/1823998
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 7c978fedde4..34bdd151df8 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -910,6 +910,7 @@ static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
                                    hwaddr *entry, AddressSpace *as)
 {
     hwaddr kernel_load_offset = KERNEL64_LOAD_ADDR;
+    uint64_t kernel_size = 0;
     uint8_t *buffer;
     int size;
 
@@ -937,7 +938,10 @@ static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
          * is only valid if the image_size is non-zero.
          */
         memcpy(&hdrvals, buffer + ARM64_TEXT_OFFSET_OFFSET, sizeof(hdrvals));
-        if (hdrvals[1] != 0) {
+
+        kernel_size = le64_to_cpu(hdrvals[1]);
+
+        if (kernel_size != 0) {
             kernel_load_offset = le64_to_cpu(hdrvals[0]);
 
             /*
@@ -955,12 +959,21 @@ static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
         }
     }
 
+    /*
+     * Kernels before v3.17 don't populate the image_size field, and
+     * raw images have no header. For those our best guess at the size
+     * is the size of the Image file itself.
+     */
+    if (kernel_size == 0) {
+        kernel_size = size;
+    }
+
     *entry = mem_base + kernel_load_offset;
     rom_add_blob_fixed_as(filename, buffer, size, *entry, as);
 
     g_free(buffer);
 
-    return size;
+    return kernel_size;
 }
 
 static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
-- 
2.20.1
