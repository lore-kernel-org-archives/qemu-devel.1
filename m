Received: from eggs.gnu.org ([2001:4830:134:3::10]:35122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcW-000159-7j
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcV-00069I-8t
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:48 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dGTcV-00067A-1N
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:47 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcU-0007R9-AP
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:10:46 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Jun 2017 18:10:23 +0100
Message-Id: <1496337035-30213-16-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
References: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 15/27] armv7m: Implement M profile default
 memory map
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Michael Davidsaver <mdavidsaver@gmail.com>

Add support for the M profile default memory map which is used
if the MPU is not present or disabled.

The main differences in behaviour from implementing this
correctly are that we set the PAGE_EXEC attribute on
the right regions of memory, such that device regions
are not executable.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
Message-id: 1493122030-32191-10-git-send-email-peter.maydell@linaro.org
[PMM: rephrased comment and commit message; don't mark
 the flash memory region as not-writable; list all
 the cases in the default map explicitly rather than
 using a 'default' case for the non-executable regions]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9e1ed1c..180b490 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8129,18 +8129,41 @@ static inline void get_phys_addr_pmsav7_default(CPUARMState *env,
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
+        case 0x40000000 ... 0x5fffffff: /* Peripheral */
+        case 0xa0000000 ... 0xbfffffff: /* Device */
+        case 0xc0000000 ... 0xdfffffff: /* Device */
+        case 0xe0000000 ... 0xffffffff: /* System */
+            *prot = PAGE_READ | PAGE_WRITE;
+            break;
+        default:
+            g_assert_not_reached();
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
