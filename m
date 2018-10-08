Received: from eggs.gnu.org ([2001:4830:134:3::10]:58531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9d4S-0005Fr-1M
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9cyq-0008AK-Vy
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:22:24 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:36558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g9cyq-00088s-MD
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:22:20 -0400
Received: by mail-pl1-x62d.google.com with SMTP id y11-v6so7463538plt.3
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 14:22:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  8 Oct 2018 14:22:01 -0700
Message-Id: <20181008212205.17752-7-richard.henderson@linaro.org>
In-Reply-To: <20181008212205.17752-1-richard.henderson@linaro.org>
References: <20181008212205.17752-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 06/10] target/arm: Convert division from
 feature bits to isar0 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Both arm and thumb2 division are controlled by the same ISAR field,
which takes care of the arm implies thumb case.  Having M imply
thumb2 division was wrong for cortex-m0, which is v6m and does not
have thumb2 at all, much less thumb2 division.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h       | 12 ++++++++++--
 target/arm/translate.h |  2 ++
 linux-user/elfload.c   |  4 ++--
 target/arm/cpu.c       | 10 +---------
 target/arm/translate.c |  4 ++--
 5 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 66eaa40ed9..2af971e823 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1550,7 +1550,6 @@ enum arm_features {
     ARM_FEATURE_VFP3,
     ARM_FEATURE_VFP_FP16,
     ARM_FEATURE_NEON,
-    ARM_FEATURE_THUMB_DIV, /* divide supported in Thumb encoding */
     ARM_FEATURE_M, /* Microcontroller profile.  */
     ARM_FEATURE_OMAPCP, /* OMAP specific CP15 ops handling.  */
     ARM_FEATURE_THUMB2EE,
@@ -1560,7 +1559,6 @@ enum arm_features {
     ARM_FEATURE_V5,
     ARM_FEATURE_STRONGARM,
     ARM_FEATURE_VAPA, /* cp15 VA to PA lookups */
-    ARM_FEATURE_ARM_DIV, /* divide supported in ARM encoding */
     ARM_FEATURE_VFP4, /* VFPv4 (implies that NEON is v2) */
     ARM_FEATURE_GENERIC_TIMER,
     ARM_FEATURE_MVFR, /* Media and VFP Feature Registers 0 and 1 */
@@ -3139,6 +3137,16 @@ extern const uint64_t pred_esz_masks[4];
 /*
  * 32-bit feature tests via id registers.
  */
+static inline bool aa32_feature_thumb_div(ARMCPU *cpu)
+{
+    return FIELD_EX32(cpu->id_isar0, ID_ISAR0, DIVIDE) != 0;
+}
+
+static inline bool aa32_feature_arm_div(ARMCPU *cpu)
+{
+    return FIELD_EX32(cpu->id_isar0, ID_ISAR0, DIVIDE) > 1;
+}
+
 static inline bool aa32_feature_aes(ARMCPU *cpu)
 {
     return FIELD_EX32(cpu->id_isar5, ID_ISAR5, AES) != 0;
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 1d60569583..8279465d1d 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -195,6 +195,8 @@ static inline TCGv_i32 get_ahp_flag(void)
     static inline bool aa32_dc_feature_##NAME(DisasContext *dc) \
     { return aa32_feature_##NAME(dc->cpu); }
 
+FORWARD_FEATURE(thumb_div)
+FORWARD_FEATURE(arm_div)
 FORWARD_FEATURE(aes)
 FORWARD_FEATURE(pmull)
 FORWARD_FEATURE(sha1)
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 571beca8fd..9b00e977d8 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -471,8 +471,8 @@ static uint32_t get_elf_hwcap(void)
     GET_FEATURE(ARM_FEATURE_VFP3, ARM_HWCAP_ARM_VFPv3);
     GET_FEATURE(ARM_FEATURE_V6K, ARM_HWCAP_ARM_TLS);
     GET_FEATURE(ARM_FEATURE_VFP4, ARM_HWCAP_ARM_VFPv4);
-    GET_FEATURE(ARM_FEATURE_ARM_DIV, ARM_HWCAP_ARM_IDIVA);
-    GET_FEATURE(ARM_FEATURE_THUMB_DIV, ARM_HWCAP_ARM_IDIVT);
+    GET_FEATURE_ID(arm_div, ARM_HWCAP_ARM_IDIVA);
+    GET_FEATURE_ID(thumb_div, ARM_HWCAP_ARM_IDIVT);
     /* All QEMU's VFPv3 CPUs have 32 registers, see VFP_DREG in translate.c.
      * Note that the ARM_HWCAP_ARM_VFPv3D16 bit is always the inverse of
      * ARM_HWCAP_ARM_VFPD32 (and so always clear for QEMU); it is unrelated
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 83a6cb535f..f068b4c476 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -825,7 +825,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
          * Presence of EL2 itself is ARM_FEATURE_EL2, and of the
          * Security Extensions is ARM_FEATURE_EL3.
          */
-        set_feature(env, ARM_FEATURE_ARM_DIV);
+        assert(aa32_feature_arm_div(cpu));
         set_feature(env, ARM_FEATURE_LPAE);
         set_feature(env, ARM_FEATURE_V7);
     }
@@ -858,12 +858,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     if (arm_feature(env, ARM_FEATURE_V5)) {
         set_feature(env, ARM_FEATURE_V4T);
     }
-    if (arm_feature(env, ARM_FEATURE_M)) {
-        set_feature(env, ARM_FEATURE_THUMB_DIV);
-    }
-    if (arm_feature(env, ARM_FEATURE_ARM_DIV)) {
-        set_feature(env, ARM_FEATURE_THUMB_DIV);
-    }
     if (arm_feature(env, ARM_FEATURE_VFP4)) {
         set_feature(env, ARM_FEATURE_VFP3);
         set_feature(env, ARM_FEATURE_VFP_FP16);
@@ -1384,8 +1378,6 @@ static void cortex_r5_initfn(Object *obj)
     ARMCPU *cpu = ARM_CPU(obj);
 
     set_feature(&cpu->env, ARM_FEATURE_V7);
-    set_feature(&cpu->env, ARM_FEATURE_THUMB_DIV);
-    set_feature(&cpu->env, ARM_FEATURE_ARM_DIV);
     set_feature(&cpu->env, ARM_FEATURE_V7MP);
     set_feature(&cpu->env, ARM_FEATURE_PMSA);
     cpu->midr = 0x411fc153; /* r1p3 */
diff --git a/target/arm/translate.c b/target/arm/translate.c
index ea8545c43b..b1ee6533cc 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9755,7 +9755,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                     case 1:
                     case 3:
                         /* SDIV, UDIV */
-                        if (!arm_dc_feature(s, ARM_FEATURE_ARM_DIV)) {
+                        if (!aa32_dc_feature_arm_div(s)) {
                             goto illegal_op;
                         }
                         if (((insn >> 5) & 7) || (rd != 15)) {
@@ -10963,7 +10963,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             tmp2 = load_reg(s, rm);
             if ((op & 0x50) == 0x10) {
                 /* sdiv, udiv */
-                if (!arm_dc_feature(s, ARM_FEATURE_THUMB_DIV)) {
+                if (!aa32_dc_feature_thumb_div(s)) {
                     goto illegal_op;
                 }
                 if (op & 0x20)
-- 
2.17.1
