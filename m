Received: from eggs.gnu.org ([209.51.188.92]:43113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbY-0002oS-Bz
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbS-0007NL-T6
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:44 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbS-0007JK-0c
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:38 -0500
Received: by mail-wm1-x343.google.com with SMTP id g67so4773373wmd.2
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:35 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.32 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:39 +0000
Message-Id: <20190118145805.6852-24-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 23/49] target/arm: Merge TBFLAG_AA_TB{0,
 1} to TBII
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

We will shortly want to talk about TBI as it relates to data.
Passing around a pair of variables is less convenient than a
single variable.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20190108223129.5570-20-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h           |  3 +--
 target/arm/translate.h     |  3 +--
 target/arm/helper.c        |  5 ++---
 target/arm/translate-a64.c | 13 +++++++------
 4 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c1d511f274c..ea9b8ec4a1e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2979,8 +2979,7 @@ FIELD(TBFLAG_A32, HANDLER, 21, 1)
 FIELD(TBFLAG_A32, STACKCHECK, 22, 1)
 
 /* Bit usage when in AArch64 state */
-FIELD(TBFLAG_A64, TBI0, 0, 1)
-FIELD(TBFLAG_A64, TBI1, 1, 1)
+FIELD(TBFLAG_A64, TBII, 0, 2)
 FIELD(TBFLAG_A64, SVEEXC_EL, 2, 2)
 FIELD(TBFLAG_A64, ZCR_LEN, 4, 4)
 FIELD(TBFLAG_A64, PAUTH_ACTIVE, 8, 1)
diff --git a/target/arm/translate.h b/target/arm/translate.h
index d8a8bb4e9c0..bb37d35741c 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -26,8 +26,7 @@ typedef struct DisasContext {
     int user;
 #endif
     ARMMMUIdx mmu_idx; /* MMU index to use for normal loads/stores */
-    bool tbi0;         /* TBI0 for EL0/1 or TBI for EL2/3 */
-    bool tbi1;         /* TBI1 for EL0/1, not used for EL2/3 */
+    uint8_t tbii;      /* TBI1|TBI0 for EL0/1 or TBI for EL2/3 */
     bool ns;        /* Use non-secure CPREG bank on access */
     int fp_excp_el; /* FP exception EL or 0 if enabled */
     int sve_excp_el; /* SVE exception EL or 0 if enabled */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f09404e931f..97a24ed5908 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -13041,10 +13041,9 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         *pc = env->pc;
         flags = FIELD_DP32(flags, TBFLAG_ANY, AARCH64_STATE, 1);
         /* Get control bits for tagged addresses */
-        flags = FIELD_DP32(flags, TBFLAG_A64, TBI0,
+        flags = FIELD_DP32(flags, TBFLAG_A64, TBII,
+                           (arm_regime_tbi1(env, mmu_idx) << 1) |
                            arm_regime_tbi0(env, mmu_idx));
-        flags = FIELD_DP32(flags, TBFLAG_A64, TBI1,
-                           arm_regime_tbi1(env, mmu_idx));
 
         if (cpu_isar_feature(aa64_sve, cpu)) {
             int sve_el = sve_exception_el(env, current_el);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 8d8f0a60b38..f49fe1de3a8 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -276,13 +276,15 @@ void gen_a64_set_pc_im(uint64_t val)
  */
 static void gen_a64_set_pc(DisasContext *s, TCGv_i64 src)
 {
+    /* Note that TBII is TBI1:TBI0.  */
+    int tbi = s->tbii;
 
     if (s->current_el <= 1) {
         /* Test if NEITHER or BOTH TBI values are set.  If so, no need to
          * examine bit 55 of address, can just generate code.
          * If mixed, then test via generated code
          */
-        if (s->tbi0 && s->tbi1) {
+        if (tbi == 3) {
             TCGv_i64 tmp_reg = tcg_temp_new_i64();
             /* Both bits set, sign extension from bit 55 into [63:56] will
              * cover both cases
@@ -290,7 +292,7 @@ static void gen_a64_set_pc(DisasContext *s, TCGv_i64 src)
             tcg_gen_shli_i64(tmp_reg, src, 8);
             tcg_gen_sari_i64(cpu_pc, tmp_reg, 8);
             tcg_temp_free_i64(tmp_reg);
-        } else if (!s->tbi0 && !s->tbi1) {
+        } else if (tbi == 0) {
             /* Neither bit set, just load it as-is */
             tcg_gen_mov_i64(cpu_pc, src);
         } else {
@@ -300,7 +302,7 @@ static void gen_a64_set_pc(DisasContext *s, TCGv_i64 src)
 
             tcg_gen_andi_i64(tcg_bit55, src, (1ull << 55));
 
-            if (s->tbi0) {
+            if (tbi == 1) {
                 /* tbi0==1, tbi1==0, so 0-fill upper byte if bit 55 = 0 */
                 tcg_gen_andi_i64(tcg_tmpval, src,
                                  0x00FFFFFFFFFFFFFFull);
@@ -318,7 +320,7 @@ static void gen_a64_set_pc(DisasContext *s, TCGv_i64 src)
             tcg_temp_free_i64(tcg_tmpval);
         }
     } else {  /* EL > 1 */
-        if (s->tbi0) {
+        if (tbi != 0) {
             /* Force tag byte to all zero */
             tcg_gen_andi_i64(cpu_pc, src, 0x00FFFFFFFFFFFFFFull);
         } else {
@@ -13807,8 +13809,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->condexec_cond = 0;
     core_mmu_idx = FIELD_EX32(tb_flags, TBFLAG_ANY, MMUIDX);
     dc->mmu_idx = core_to_arm_mmu_idx(env, core_mmu_idx);
-    dc->tbi0 = FIELD_EX32(tb_flags, TBFLAG_A64, TBI0);
-    dc->tbi1 = FIELD_EX32(tb_flags, TBFLAG_A64, TBI1);
+    dc->tbii = FIELD_EX32(tb_flags, TBFLAG_A64, TBII);
     dc->current_el = arm_mmu_idx_to_el(dc->mmu_idx);
 #if !defined(CONFIG_USER_ONLY)
     dc->user = (dc->current_el == 0);
-- 
2.20.1
