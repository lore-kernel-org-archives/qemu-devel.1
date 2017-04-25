Received: from eggs.gnu.org ([2001:4830:134:3::10]:55126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d2zhj-0007pQ-2Y
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 08:36:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d2zhi-00051n-41
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 08:36:27 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Apr 2017 13:07:06 +0100
Message-Id: <1493122030-32191-10-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1493122030-32191-1-git-send-email-peter.maydell@linaro.org>
References: <1493122030-32191-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 09/13] armv7m: Implement M profile default
 memory map
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>

From: Michael Davidsaver <mdavidsaver@gmail.com>

Add support for the M profile default memory map which is used
if the MPU is not present or disabled.

The main differences in behaviour from implementing this
correctly are that we set the PAGE_EXEC attribute on
the right regions of memory, such that device regions
are not executable.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
[PMM: rephrased comment and commit message; don't mark
 the flash memory region as not-writable]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9e1ed1c..51662ad 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8129,18 +8129,35 @@ static inline void get_phys_addr_pmsav7_default(CPUARMState *env,
                                                 ARMMMUIdx mmu_idx,
                                                 int32_t address, int *prot)
 {
-    *prot = PAGE_READ | PAGE_WRITE;
-    switch (address) {
-    case 0xF0000000 ... 0xFFFFFFFF:
-        if (regime_sctlr(env, mmu_idx) & SCTLR_V) { /* hivecs execing is ok */
+    if (!arm_feature(env, ARM_FEATURE_M)) {
+        *prot = PAGE_READ | PAGE_WRITE;
+        switch (address) {
+        case 0xF0000000 ... 0xFFFFFFFF:
+            if (regime_sctlr(env, mmu_idx) & SCTLR_V) {
+                /* hivecs execing is ok */
+                *prot |= PAGE_EXEC;
+            }
+            break;
+        case 0x00000000 ... 0x7FFFFFFF:
             *prot |= PAGE_EXEC;
+            break;
+        }
+    } else {
+        /* Default system address map for M profile cores.
+         * The architecture specifies which regions are execute-never;
+         * at the MPU level no other checks are defined.
+         */
+        switch (address) {
+        case 0x00000000 ... 0x1fffffff: /* ROM */
+        case 0x20000000 ... 0x3fffffff: /* SRAM */
+        case 0x60000000 ... 0x7fffffff: /* RAM */
+        case 0x80000000 ... 0x9fffffff: /* RAM */
+            *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+            break;
+        default: /* Peripheral, 2x Device, and System */
+            *prot = PAGE_READ | PAGE_WRITE;
         }
-        break;
-    case 0x00000000 ... 0x7FFFFFFF:
-        *prot |= PAGE_EXEC;
-        break;
     }
-
 }
 
 static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
-- 
2.7.4
