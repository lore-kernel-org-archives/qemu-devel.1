Received: from eggs.gnu.org ([2001:4830:134:3::10]:49175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1egXQw-0000QF-R8
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:02:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1egXQn-0005d1-Ax
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:02:50 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jan 2018 15:02:21 +0000
Message-Id: <1517324542-6607-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1517324542-6607-1-git-send-email-peter.maydell@linaro.org>
References: <1517324542-6607-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 6/7] target/arm: Make exception vector loads
 honour the SAU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

Make the load of the exception vector from the vector table honour
the SAU and any bus error on the load (possibly provoking a derived
exception), rather than simply aborting if the load fails.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 71 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 55 insertions(+), 16 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index de0031b..6931a9d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6449,28 +6449,63 @@ static uint32_t *get_v7m_sp_ptr(CPUARMState *env, bool secure, bool threadmode,
     }
 }
 
-static uint32_t arm_v7m_load_vector(ARMCPU *cpu, int exc, bool targets_secure)
+static bool arm_v7m_load_vector(ARMCPU *cpu, int exc, bool targets_secure,
+                                uint32_t *pvec)
 {
     CPUState *cs = CPU(cpu);
     CPUARMState *env = &cpu->env;
     MemTxResult result;
-    hwaddr vec = env->v7m.vecbase[targets_secure] + exc * 4;
-    uint32_t addr;
+    uint32_t addr = env->v7m.vecbase[targets_secure] + exc * 4;
+    uint32_t vector_entry;
+    MemTxAttrs attrs = {};
+    ARMMMUIdx mmu_idx;
+    bool exc_secure;
+
+    mmu_idx = arm_v7m_mmu_idx_for_secstate_and_priv(env, targets_secure, true);
 
-    addr = address_space_ldl(cs->as, vec,
-                             MEMTXATTRS_UNSPECIFIED, &result);
+    /* We don't do a get_phys_addr() here because the rules for vector
+     * loads are special: they always use the default memory map, and
+     * the default memory map permits reads from all addresses.
+     * Since there's no easy way to pass through to pmsav8_mpu_lookup()
+     * that we want this special case which would always say "yes",
+     * we just do the SAU lookup here followed by a direct physical load.
+     */
+    attrs.secure = targets_secure;
+    attrs.user = false;
+
+    if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
+        V8M_SAttributes sattrs = {};
+
+        v8m_security_lookup(env, addr, MMU_DATA_LOAD, mmu_idx, &sattrs);
+        if (sattrs.ns) {
+            attrs.secure = false;
+        } else if (!targets_secure) {
+            /* NS access to S memory */
+            goto load_fail;
+        }
+    }
+
+    vector_entry = address_space_ldl(arm_addressspace(cs, attrs), addr,
+                                     attrs, &result);
     if (result != MEMTX_OK) {
-        /* Architecturally this should cause a HardFault setting HSFR.VECTTBL,
-         * which would then be immediately followed by our failing to load
-         * the entry vector for that HardFault, which is a Lockup case.
-         * Since we don't model Lockup, we just report this guest error
-         * via cpu_abort().
-         */
-        cpu_abort(cs, "Failed to read from %s exception vector table "
-                  "entry %08x\n", targets_secure ? "secure" : "nonsecure",
-                  (unsigned)vec);
+        goto load_fail;
     }
-    return addr;
+    *pvec = vector_entry;
+    return true;
+
+load_fail:
+    /* All vector table fetch fails are reported as HardFault, with
+     * HFSR.VECTTBL and .FORCED set. (FORCED is set because
+     * technically the underlying exception is a MemManage or BusFault
+     * that is escalated to HardFault.) This is a terminal exception,
+     * so we will either take the HardFault immediately or else enter
+     * lockup (the latter case is handled in armv7m_nvic_set_pending_derived()).
+     */
+    exc_secure = targets_secure ||
+        !(cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK);
+    env->v7m.hfsr |= R_V7M_HFSR_VECTTBL_MASK | R_V7M_HFSR_FORCED_MASK;
+    armv7m_nvic_set_pending_derived(env->nvic, ARMV7M_EXCP_HARD, exc_secure);
+    return false;
 }
 
 static bool v7m_push_callee_stack(ARMCPU *cpu, uint32_t lr, bool dotailchain,
@@ -6623,7 +6658,11 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain,
         return;
     }
 
-    addr = arm_v7m_load_vector(cpu, exc, targets_secure);
+    if (!arm_v7m_load_vector(cpu, exc, targets_secure, &addr)) {
+        /* Vector load failed: derived exception */
+        v7m_exception_taken(cpu, lr, true, true);
+        return;
+    }
 
     /* Now we've done everything that might cause a derived exception
      * we can go ahead and activate whichever exception we're going to
-- 
2.7.4
