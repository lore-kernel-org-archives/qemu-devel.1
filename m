Received: from eggs.gnu.org ([2001:4830:134:3::10]:43308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWW-0002mG-7I
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWV-0004nN-6u
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:48 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eriWV-0004lz-0R
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:47 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWU-0001K3-1q
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:06:46 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Mar 2018 11:06:08 +0000
Message-Id: <20180302110640.28004-8-peter.maydell@linaro.org>
In-Reply-To: <20180302110640.28004-1-peter.maydell@linaro.org>
References: <20180302110640.28004-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/39] hw/arm/armv7m: Honour CPU's address space
 for image loads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Instead of loading guest images to the system address space, use the
CPU's address space.  This is important if we're trying to load the
file to memory or via an alias memory region that is provided by an
SoC object and thus not mapped into the system address space.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180220180325.29818-4-peter.maydell@linaro.org
---
 hw/arm/armv7m.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 56770a7048..facc536b07 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -270,6 +270,9 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size)
     uint64_t entry;
     uint64_t lowaddr;
     int big_endian;
+    AddressSpace *as;
+    int asidx;
+    CPUState *cs = CPU(cpu);
 
 #ifdef TARGET_WORDS_BIGENDIAN
     big_endian = 1;
@@ -282,11 +285,19 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size)
         exit(1);
     }
 
+    if (arm_feature(&cpu->env, ARM_FEATURE_EL3)) {
+        asidx = ARMASIdx_S;
+    } else {
+        asidx = ARMASIdx_NS;
+    }
+    as = cpu_get_address_space(cs, asidx);
+
     if (kernel_filename) {
-        image_size = load_elf(kernel_filename, NULL, NULL, &entry, &lowaddr,
-                              NULL, big_endian, EM_ARM, 1, 0);
+        image_size = load_elf_as(kernel_filename, NULL, NULL, &entry, &lowaddr,
+                                 NULL, big_endian, EM_ARM, 1, 0, as);
         if (image_size < 0) {
-            image_size = load_image_targphys(kernel_filename, 0, mem_size);
+            image_size = load_image_targphys_as(kernel_filename, 0,
+                                                mem_size, as);
             lowaddr = 0;
         }
         if (image_size < 0) {
-- 
2.16.2
