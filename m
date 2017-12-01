Received: from eggs.gnu.org ([2001:4830:134:3::10]:53272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eKqIy-0006OW-VB
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 13:44:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eKqIx-000359-QI
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 13:44:57 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Dec 2017 18:44:39 +0000
Message-Id: <1512153879-5291-8-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1512153879-5291-1-git-send-email-peter.maydell@linaro.org>
References: <1512153879-5291-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 7/7] target/arm: Implement TT instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Implement the TT instruction which queries the security
state and access permissions of a memory location.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h    |   2 +
 target/arm/helper.c    | 108 +++++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/translate.c |  29 ++++++++++++-
 3 files changed, 138 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 439d228..066729e 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -66,6 +66,8 @@ DEF_HELPER_2(v7m_mrs, i32, env, i32)
 DEF_HELPER_2(v7m_bxns, void, env, i32)
 DEF_HELPER_2(v7m_blxns, void, env, i32)
 
+DEF_HELPER_3(v7m_tt, i32, env, i32, i32)
+
 DEF_HELPER_4(access_check_cp_reg, void, env, ptr, i32, i32)
 DEF_HELPER_3(set_cp_reg, void, env, ptr, i32)
 DEF_HELPER_2(get_cp_reg, i32, env, ptr)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index be8d797..5368ad8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5947,6 +5947,28 @@ void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
     g_assert_not_reached();
 }
 
+uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
+{
+    /* The TT instructions can be used by unprivileged code, but in
+     * user-only emulation we don't have the MPU.
+     * Luckily since we know we are NonSecure unprivileged (and that in
+     * turn means that the A flag wasn't specified), all the bits in the
+     * register must be zero:
+     *  IREGION: 0 because IRVALID is 0
+     *  IRVALID: 0 because NS
+     *  S: 0 because NS
+     *  NSRW: 0 because NS
+     *  NSR: 0 because NS
+     *  RW: 0 because unpriv and A flag not set
+     *  R: 0 because unpriv and A flag not set
+     *  SRVALID: 0 because NS
+     *  MRVALID: 0 because unpriv and A flag not set
+     *  SREGION: 0 becaus SRVALID is 0
+     *  MREGION: 0 because MRVALID is 0
+     */
+    return 0;
+}
+
 void switch_mode(CPUARMState *env, int mode)
 {
     ARMCPU *cpu = arm_env_get_cpu(env);
@@ -10143,6 +10165,92 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
     }
 }
 
+uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
+{
+    /* Implement the TT instruction. op is bits [7:6] of the insn. */
+    bool forceunpriv = op & 1;
+    bool alt = op & 2;
+    V8M_SAttributes sattrs = {};
+    uint32_t tt_resp;
+    bool r, rw, nsr, nsrw, mrvalid;
+    int prot;
+    MemTxAttrs attrs = {};
+    hwaddr phys_addr;
+    uint32_t fsr;
+    ARMMMUIdx mmu_idx;
+    uint32_t mregion;
+    bool targetpriv;
+    bool targetsec = env->v7m.secure;
+
+    /* Work out what the security state and privilege level we're
+     * interested in is...
+     */
+    if (alt) {
+        targetsec = !targetsec;
+    }
+
+    if (forceunpriv) {
+        targetpriv = false;
+    } else {
+        targetpriv = arm_v7m_is_handler_mode(env) ||
+            !(env->v7m.control[targetsec] & R_V7M_CONTROL_NPRIV_MASK);
+    }
+
+    /* ...and then figure out which MMU index this is */
+    mmu_idx = arm_v7m_mmu_idx_for_secstate_and_priv(env, targetsec, targetpriv);
+
+    /* We know that the MPU and SAU don't care about the access type
+     * for our purposes beyond that we don't want to claim to be
+     * an insn fetch, so we arbitrarily call this a read.
+     */
+
+    /* MPU region info only available for privileged or if
+     * inspecting the other MPU state.
+     */
+    if (arm_current_el(env) != 0 || alt) {
+        /* We can ignore the return value as prot is always set */
+        pmsav8_mpu_lookup(env, addr, MMU_DATA_LOAD, mmu_idx,
+                          &phys_addr, &attrs, &prot, &fsr, &mregion);
+        if (mregion == -1) {
+            mrvalid = false;
+            mregion = 0;
+        } else {
+            mrvalid = true;
+        }
+        r = prot & PAGE_READ;
+        rw = prot & PAGE_WRITE;
+    } else {
+        r = false;
+        rw = false;
+        mrvalid = false;
+        mregion = 0;
+    }
+
+    if (env->v7m.secure) {
+        v8m_security_lookup(env, addr, MMU_DATA_LOAD, mmu_idx, &sattrs);
+        nsr = sattrs.ns && r;
+        nsrw = sattrs.ns && rw;
+    } else {
+        sattrs.ns = true;
+        nsr = false;
+        nsrw = false;
+    }
+
+    tt_resp = (sattrs.iregion << 24) |
+        (sattrs.irvalid << 23) |
+        ((!sattrs.ns) << 22) |
+        (nsrw << 21) |
+        (nsr << 20) |
+        (rw << 19) |
+        (r << 18) |
+        (sattrs.srvalid << 17) |
+        (mrvalid << 16) |
+        (sattrs.sregion << 8) |
+        mregion;
+
+    return tt_resp;
+}
+
 #endif
 
 void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 6df4d90..002055b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9810,7 +9810,7 @@ static int disas_thumb2_insn(DisasContext *s, uint32_t insn)
         if (insn & (1 << 22)) {
             /* 0b1110_100x_x1xx_xxxx_xxxx_xxxx_xxxx_xxxx
              * - load/store doubleword, load/store exclusive, ldacq/strel,
-             *   table branch.
+             *   table branch, TT.
              */
             if (insn == 0xe97fe97f && arm_dc_feature(s, ARM_FEATURE_M) &&
                 arm_dc_feature(s, ARM_FEATURE_V8)) {
@@ -9887,8 +9887,35 @@ static int disas_thumb2_insn(DisasContext *s, uint32_t insn)
             } else if ((insn & (1 << 23)) == 0) {
                 /* 0b1110_1000_010x_xxxx_xxxx_xxxx_xxxx_xxxx
                  * - load/store exclusive word
+                 * - TT (v8M only)
                  */
                 if (rs == 15) {
+                    if (!(insn & (1 << 20)) &&
+                        arm_dc_feature(s, ARM_FEATURE_M) &&
+                        arm_dc_feature(s, ARM_FEATURE_V8)) {
+                        /* 0b1110_1000_0100_xxxx_1111_xxxx_xxxx_xxxx
+                         *  - TT (v8M only)
+                         */
+                        bool alt = insn & (1 << 7);
+                        TCGv_i32 addr, op, ttresp;
+
+                        if ((insn & 0x3f) || rd == 13 || rd == 15 || rn == 15) {
+                            /* we UNDEF for these UNPREDICTABLE cases */
+                            goto illegal_op;
+                        }
+
+                        if (alt && !s->v8m_secure) {
+                            goto illegal_op;
+                        }
+
+                        addr = load_reg(s, rn);
+                        op = tcg_const_i32(extract32(insn, 6, 2));
+                        ttresp = tcg_temp_new_i32();
+                        gen_helper_v7m_tt(ttresp, cpu_env, addr, op);
+                        tcg_temp_free_i32(addr);
+                        tcg_temp_free_i32(op);
+                        store_reg(s, rd, ttresp);
+                    }
                     goto illegal_op;
                 }
                 addr = tcg_temp_local_new_i32();
-- 
2.7.4
