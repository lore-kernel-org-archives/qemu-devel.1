Received: from eggs.gnu.org ([2001:4830:134:3::10]:51659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWi-0004sG-S5
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWe-0007yk-CC
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:04 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:39136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ePBWe-0007um-2s
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:00 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWc-0007ir-Sh
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:12:58 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 18:12:21 +0000
Message-Id: <1513188761-20784-24-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
References: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 23/43] target/arm: Factor MPU lookup code out of
 get_phys_addr_pmsav8()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

For the TT instruction we're going to need to do an MPU lookup that
also tells us which MPU region the access hit. This requires us
to do the MPU lookup without first doing the SAU security access
check, so pull the MPU lookup parts of get_phys_addr_pmsav8()
out into their own function.

The TT instruction also needs to know the MPU region number which
the lookup hit, so provide this information to the caller of the
MPU lookup code, even though get_phys_addr_pmsav8() doesn't
need to know it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1512153879-5291-7-git-send-email-peter.maydell@linaro.org
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/arm/helper.c | 130 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 79 insertions(+), 51 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 70cf313..9e7eaa1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9348,67 +9348,28 @@ static void v8m_security_lookup(CPUARMState *env, uint32_t address,
     }
 }
 
-static bool get_phys_addr_pmsav8(CPUARMState *env, uint32_t address,
-                                 MMUAccessType access_type, ARMMMUIdx mmu_idx,
-                                 hwaddr *phys_ptr, MemTxAttrs *txattrs,
-                                 int *prot, uint32_t *fsr)
+static bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
+                              MMUAccessType access_type, ARMMMUIdx mmu_idx,
+                              hwaddr *phys_ptr, MemTxAttrs *txattrs,
+                              int *prot, uint32_t *fsr, uint32_t *mregion)
 {
+    /* Perform a PMSAv8 MPU lookup (without also doing the SAU check
+     * that a full phys-to-virt translation does).
+     * mregion is (if not NULL) set to the region number which matched,
+     * or -1 if no region number is returned (MPU off, address did not
+     * hit a region, address hit in multiple regions).
+     */
     ARMCPU *cpu = arm_env_get_cpu(env);
     bool is_user = regime_is_user(env, mmu_idx);
     uint32_t secure = regime_is_secure(env, mmu_idx);
     int n;
     int matchregion = -1;
     bool hit = false;
-    V8M_SAttributes sattrs = {};
 
     *phys_ptr = address;
     *prot = 0;
-
-    if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
-        v8m_security_lookup(env, address, access_type, mmu_idx, &sattrs);
-        if (access_type == MMU_INST_FETCH) {
-            /* Instruction fetches always use the MMU bank and the
-             * transaction attribute determined by the fetch address,
-             * regardless of CPU state. This is painful for QEMU
-             * to handle, because it would mean we need to encode
-             * into the mmu_idx not just the (user, negpri) information
-             * for the current security state but also that for the
-             * other security state, which would balloon the number
-             * of mmu_idx values needed alarmingly.
-             * Fortunately we can avoid this because it's not actually
-             * possible to arbitrarily execute code from memory with
-             * the wrong security attribute: it will always generate
-             * an exception of some kind or another, apart from the
-             * special case of an NS CPU executing an SG instruction
-             * in S&NSC memory. So we always just fail the translation
-             * here and sort things out in the exception handler
-             * (including possibly emulating an SG instruction).
-             */
-            if (sattrs.ns != !secure) {
-                *fsr = sattrs.nsc ? M_FAKE_FSR_NSC_EXEC : M_FAKE_FSR_SFAULT;
-                return true;
-            }
-        } else {
-            /* For data accesses we always use the MMU bank indicated
-             * by the current CPU state, but the security attributes
-             * might downgrade a secure access to nonsecure.
-             */
-            if (sattrs.ns) {
-                txattrs->secure = false;
-            } else if (!secure) {
-                /* NS access to S memory must fault.
-                 * Architecturally we should first check whether the
-                 * MPU information for this address indicates that we
-                 * are doing an unaligned access to Device memory, which
-                 * should generate a UsageFault instead. QEMU does not
-                 * currently check for that kind of unaligned access though.
-                 * If we added it we would need to do so as a special case
-                 * for M_FAKE_FSR_SFAULT in arm_v7m_cpu_do_interrupt().
-                 */
-                *fsr = M_FAKE_FSR_SFAULT;
-                return true;
-            }
-        }
+    if (mregion) {
+        *mregion = -1;
     }
 
     /* Unlike the ARM ARM pseudocode, we don't need to check whether this
@@ -9497,12 +9458,79 @@ static bool get_phys_addr_pmsav8(CPUARMState *env, uint32_t address,
         /* We don't need to look the attribute up in the MAIR0/MAIR1
          * registers because that only tells us about cacheability.
          */
+        if (mregion) {
+            *mregion = matchregion;
+        }
     }
 
     *fsr = 0x00d; /* Permission fault */
     return !(*prot & (1 << access_type));
 }
 
+
+static bool get_phys_addr_pmsav8(CPUARMState *env, uint32_t address,
+                                 MMUAccessType access_type, ARMMMUIdx mmu_idx,
+                                 hwaddr *phys_ptr, MemTxAttrs *txattrs,
+                                 int *prot, uint32_t *fsr)
+{
+    uint32_t secure = regime_is_secure(env, mmu_idx);
+    V8M_SAttributes sattrs = {};
+
+    if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
+        v8m_security_lookup(env, address, access_type, mmu_idx, &sattrs);
+        if (access_type == MMU_INST_FETCH) {
+            /* Instruction fetches always use the MMU bank and the
+             * transaction attribute determined by the fetch address,
+             * regardless of CPU state. This is painful for QEMU
+             * to handle, because it would mean we need to encode
+             * into the mmu_idx not just the (user, negpri) information
+             * for the current security state but also that for the
+             * other security state, which would balloon the number
+             * of mmu_idx values needed alarmingly.
+             * Fortunately we can avoid this because it's not actually
+             * possible to arbitrarily execute code from memory with
+             * the wrong security attribute: it will always generate
+             * an exception of some kind or another, apart from the
+             * special case of an NS CPU executing an SG instruction
+             * in S&NSC memory. So we always just fail the translation
+             * here and sort things out in the exception handler
+             * (including possibly emulating an SG instruction).
+             */
+            if (sattrs.ns != !secure) {
+                *fsr = sattrs.nsc ? M_FAKE_FSR_NSC_EXEC : M_FAKE_FSR_SFAULT;
+                *phys_ptr = address;
+                *prot = 0;
+                return true;
+            }
+        } else {
+            /* For data accesses we always use the MMU bank indicated
+             * by the current CPU state, but the security attributes
+             * might downgrade a secure access to nonsecure.
+             */
+            if (sattrs.ns) {
+                txattrs->secure = false;
+            } else if (!secure) {
+                /* NS access to S memory must fault.
+                 * Architecturally we should first check whether the
+                 * MPU information for this address indicates that we
+                 * are doing an unaligned access to Device memory, which
+                 * should generate a UsageFault instead. QEMU does not
+                 * currently check for that kind of unaligned access though.
+                 * If we added it we would need to do so as a special case
+                 * for M_FAKE_FSR_SFAULT in arm_v7m_cpu_do_interrupt().
+                 */
+                *fsr = M_FAKE_FSR_SFAULT;
+                *phys_ptr = address;
+                *prot = 0;
+                return true;
+            }
+        }
+    }
+
+    return pmsav8_mpu_lookup(env, address, access_type, mmu_idx, phys_ptr,
+                             txattrs, prot, fsr, NULL);
+}
+
 static bool get_phys_addr_pmsav5(CPUARMState *env, uint32_t address,
                                  MMUAccessType access_type, ARMMMUIdx mmu_idx,
                                  hwaddr *phys_ptr, int *prot, uint32_t *fsr)
-- 
2.7.4
