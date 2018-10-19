Received: from eggs.gnu.org ([2001:4830:134:3::10]:47583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY65-0001br-H6
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY64-0002Jl-FU
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:58:01 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gDY64-00020Y-6e
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:58:00 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY63-0006kB-6R
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 17:57:59 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 17:57:11 +0100
Message-Id: <20181019165735.22511-22-peter.maydell@linaro.org>
In-Reply-To: <20181019165735.22511-1-peter.maydell@linaro.org>
References: <20181019165735.22511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 21/45] hw/arm/boot: Increase compliance with
 kernel arm64 boot protocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Stewart Hildebrand <Stewart.Hildebrand@dornerworks.com>

"The Image must be placed text_offset bytes from a 2MB aligned base
address anywhere in usable system RAM and called there."

For the virt board, we write our startup bootloader at the very
bottom of RAM, so that bit can't be used for the image. To avoid
overlap in case the image requests to be loaded at an offset
smaller than our bootloader, we increment the load offset to the
next 2MB.

This fixes a boot failure for Xen AArch64.

Signed-off-by: Stewart Hildebrand <stewart.hildebrand@dornerworks.com>
Tested-by: Andre Przywara <andre.przywara@arm.com>
Message-id: b8a89518794b4436af0c151ed10de4fa@dornerworks.com
[PMM: Rephrased a comment a bit]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 20c71d7d961..586baa9b647 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -24,6 +24,7 @@
 #include "qemu/config-file.h"
 #include "qemu/option.h"
 #include "exec/address-spaces.h"
+#include "qemu/units.h"
 
 /* Kernel boot protocol is specified in the kernel docs
  * Documentation/arm/Booting and Documentation/arm64/booting.txt
@@ -36,6 +37,8 @@
 #define ARM64_TEXT_OFFSET_OFFSET    8
 #define ARM64_MAGIC_OFFSET          56
 
+#define BOOTLOADER_MAX_SIZE         (4 * KiB)
+
 AddressSpace *arm_boot_address_space(ARMCPU *cpu,
                                      const struct arm_boot_info *info)
 {
@@ -184,6 +187,8 @@ static void write_bootloader(const char *name, hwaddr addr,
         code[i] = tswap32(insn);
     }
 
+    assert((len * sizeof(uint32_t)) < BOOTLOADER_MAX_SIZE);
+
     rom_add_blob_fixed_as(name, code, len * sizeof(uint32_t), addr, as);
 
     g_free(code);
@@ -919,6 +924,19 @@ static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
         memcpy(&hdrvals, buffer + ARM64_TEXT_OFFSET_OFFSET, sizeof(hdrvals));
         if (hdrvals[1] != 0) {
             kernel_load_offset = le64_to_cpu(hdrvals[0]);
+
+            /*
+             * We write our startup "bootloader" at the very bottom of RAM,
+             * so that bit can't be used for the image. Luckily the Image
+             * format specification is that the image requests only an offset
+             * from a 2MB boundary, not an absolute load address. So if the
+             * image requests an offset that might mean it overlaps with the
+             * bootloader, we can just load it starting at 2MB+offset rather
+             * than 0MB + offset.
+             */
+            if (kernel_load_offset < BOOTLOADER_MAX_SIZE) {
+                kernel_load_offset += 2 * MiB;
+            }
         }
     }
 
-- 
2.19.1
