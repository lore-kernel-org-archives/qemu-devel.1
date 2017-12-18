Received: from eggs.gnu.org ([2001:4830:134:3::10]:44433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzFP-0002ga-Ki
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzFN-0004kh-5A
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:39 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:46598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQzFM-0004kB-Rz
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:37 -0500
Received: by mail-pl0-x242.google.com with SMTP id i6so5222753plt.13
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:30:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:30:20 -0800
Message-Id: <20171218173022.18418-8-richard.henderson@linaro.org>
In-Reply-To: <20171218173022.18418-1-richard.henderson@linaro.org>
References: <20171218173022.18418-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 7/9] target/arm: Expand vector registers for SVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Change vfp.regs as a uint64_t to vfp.zregs as an ARMVectorReg.
The previous patches have made the change in representation
relatively painless.

Add vfp.pregs as an ARMPredicateReg.  Let FFR be P16 to make
it easier to treat it as for any other predicate.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           | 64 ++++++++++++++++++++++++++++++++--------------
 target/arm/machine.c       | 37 ++++++++++++++++++++++++++-
 target/arm/translate-a64.c |  8 +++---
 target/arm/translate.c     | 12 ++++-----
 4 files changed, 90 insertions(+), 31 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e1a8e2880d..150b0d9d84 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -153,6 +153,47 @@ typedef struct {
     uint32_t base_mask;
 } TCR;
 
+/* Define a maximum sized vector register.
+ * For 32-bit, this is a 128-bit NEON/AdvSIMD register.
+ * For 64-bit, this is a 2048-bit SVE register.
+ *
+ * Note that the mapping between S, D, and Q views of the register bank
+ * differs between AArch64 and AArch32.
+ * In AArch32:
+ *  Qn = regs[n].d[1]:regs[n].d[0]
+ *  Dn = regs[n / 2].d[n & 1]
+ *  Sn = regs[n / 4].d[n % 4 / 2],
+ *       bits 31..0 for even n, and bits 63..32 for odd n
+ *       (and regs[16] to regs[31] are inaccessible)
+ * In AArch64:
+ *  Zn = regs[n].d[*]
+ *  Qn = regs[n].d[1]:regs[n].d[0]
+ *  Dn = regs[n].d[0]
+ *  Sn = regs[n].d[0] bits 31..0
+ *
+ * This corresponds to the architecturally defined mapping between
+ * the two execution states, and means we do not need to explicitly
+ * map these registers when changing states.
+ */
+
+#ifdef TARGET_AARCH64
+# define ARM_MAX_VQ    16
+#else
+# define ARM_MAX_VQ    1
+#endif
+
+typedef struct ARMVectorReg {
+    uint64_t d[2 * ARM_MAX_VQ] QEMU_ALIGNED(16);
+} ARMVectorReg;
+
+typedef struct ARMPredicateReg {
+#ifdef TARGET_AARCH64
+    uint64_t p[2 * ARM_MAX_VQ / 8] QEMU_ALIGNED(16);
+#else
+    uint64_t p[0];
+#endif
+} ARMPredicateReg;
+
 typedef struct CPUARMState {
     /* Regs for current mode.  */
     uint32_t regs[16];
@@ -477,23 +518,8 @@ typedef struct CPUARMState {
 
     /* VFP coprocessor state.  */
     struct {
-        /* VFP/Neon register state. Note that the mapping between S, D and Q
-         * views of the register bank differs between AArch64 and AArch32:
-         * In AArch32:
-         *  Qn = regs[2n+1]:regs[2n]
-         *  Dn = regs[n]
-         *  Sn = regs[n/2] bits 31..0 for even n, and bits 63..32 for odd n
-         * (and regs[32] to regs[63] are inaccessible)
-         * In AArch64:
-         *  Qn = regs[2n+1]:regs[2n]
-         *  Dn = regs[2n]
-         *  Sn = regs[2n] bits 31..0
-         *  Hn = regs[2n] bits 15..0 for even n, and bits 31..16 for odd n
-         * This corresponds to the architecturally defined mapping between
-         * the two execution states, and means we do not need to explicitly
-         * map these registers when changing states.
-         */
-        uint64_t regs[64] QEMU_ALIGNED(16);
+        ARMVectorReg zregs[32];
+        ARMPredicateReg pregs[17];  /* ffr is pregs[16] */
 
         uint32_t xregs[16];
         /* We store these fpcsr fields separately for convenience.  */
@@ -2905,7 +2931,7 @@ static inline void *arm_get_el_change_hook_opaque(ARMCPU *cpu)
  */
 static inline uint64_t *aa32_vfp_dreg(CPUARMState *env, unsigned regno)
 {
-    return &env->vfp.regs[regno];
+    return &env->vfp.zregs[regno >> 1].d[regno & 1];
 }
 
 /**
@@ -2914,7 +2940,7 @@ static inline uint64_t *aa32_vfp_dreg(CPUARMState *env, unsigned regno)
  */
 static inline uint64_t *aa64_vfp_qreg(CPUARMState *env, unsigned regno)
 {
-    return &env->vfp.regs[2 * regno];
+    return &env->vfp.zregs[regno].d[0];
 }
 
 #endif
diff --git a/target/arm/machine.c b/target/arm/machine.c
index a85c2430d3..39f3123b10 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -50,7 +50,42 @@ static const VMStateDescription vmstate_vfp = {
     .minimum_version_id = 3,
     .needed = vfp_needed,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT64_ARRAY(env.vfp.regs, ARMCPU, 64),
+        /* For compatibility, store Qn out of Zn here.  */
+        /* TODO: store the other quadwords in another subsection,
+           along with predicate registers and ZCR_EL[1-3].  */
+        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[0].d, ARMCPU, 0, 2),
+        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[1].d, ARMCPU, 0, 2),
+        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[2].d, ARMCPU, 0, 2),
+        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[3].d, ARMCPU, 0, 2),
+        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[4].d, ARMCPU, 0, 2),
+        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[5].d, ARMCPU, 0, 2),
+        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[6].d, ARMCPU, 0, 2),
+        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[7].d, ARMCPU, 0, 2),
+        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[8].d, ARMCPU, 0, 2),
+        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[9].d, ARMCPU, 0, 2),
+        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[10].d, ARMCPU, 0, 2),
+        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[11].d, ARMCPU, 0, 2),
+        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[12].d, ARMCPU, 0, 2),
+        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[13].d, ARMCPU, 0, 2),
+        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[14].d, ARMCPU, 0, 2),
+        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[15].d, ARMCPU, 0, 2),
+        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[16].d, ARMCPU, 0, 2),
+        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[17].d, ARMCPU, 0, 2),
+        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[18].d, ARMCPU, 0, 2),
+        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[19].d, ARMCPU, 0, 2),
+        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[20].d, ARMCPU, 0, 2),
+        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[21].d, ARMCPU, 0, 2),
+        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[22].d, ARMCPU, 0, 2),
+        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[23].d, ARMCPU, 0, 2),
+        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[24].d, ARMCPU, 0, 2),
+        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[25].d, ARMCPU, 0, 2),
+        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[26].d, ARMCPU, 0, 2),
+        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[27].d, ARMCPU, 0, 2),
+        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[28].d, ARMCPU, 0, 2),
+        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[29].d, ARMCPU, 0, 2),
+        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[30].d, ARMCPU, 0, 2),
+        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[31].d, ARMCPU, 0, 2),
+
         /* The xregs array is a little awkward because element 1 (FPSCR)
          * requires a specific accessor, so we have to split it up in
          * the vmstate:
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e17c7269d4..487408a7a7 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -523,8 +523,8 @@ static inline int vec_reg_offset(DisasContext *s, int regno,
 {
     int offs = 0;
 #ifdef HOST_WORDS_BIGENDIAN
-    /* This is complicated slightly because vfp.regs[2n] is
-     * still the low half and  vfp.regs[2n+1] the high half
+    /* This is complicated slightly because vfp.zregs[n].d[0] is
+     * still the low half and vfp.zregs[n].d[1] the high half
      * of the 128 bit vector, even on big endian systems.
      * Calculate the offset assuming a fully bigendian 128 bits,
      * then XOR to account for the order of the two 64 bit halves.
@@ -534,7 +534,7 @@ static inline int vec_reg_offset(DisasContext *s, int regno,
 #else
     offs += element * (1 << size);
 #endif
-    offs += offsetof(CPUARMState, vfp.regs[regno * 2]);
+    offs += offsetof(CPUARMState, vfp.zregs[regno]);
     assert_fp_access_checked(s);
     return offs;
 }
@@ -543,7 +543,7 @@ static inline int vec_reg_offset(DisasContext *s, int regno,
 static inline int vec_full_reg_offset(DisasContext *s, int regno)
 {
     assert_fp_access_checked(s);
-    return offsetof(CPUARMState, vfp.regs[regno * 2]);
+    return offsetof(CPUARMState, vfp.zregs[regno]);
 }
 
 /* Return the byte size of the "whole" vector register, VL / 8.  */
diff --git a/target/arm/translate.c b/target/arm/translate.c
index a93e26498e..7a5e493333 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1513,19 +1513,17 @@ static inline void gen_vfp_st(DisasContext *s, int dp, TCGv_i32 addr)
     }
 }
 
-static inline long
-vfp_reg_offset (int dp, int reg)
+static inline long vfp_reg_offset(bool dp, unsigned reg)
 {
     if (dp) {
-        return offsetof(CPUARMState, vfp.regs[reg]);
+        return offsetof(CPUARMState, vfp.zregs[reg >> 1].d[reg & 1]);
     } else {
-        long ofs = offsetof(CPUARMState, vfp.regs[reg >> 1]);
+        long r = offsetof(CPUARMState, vfp.zregs[reg >> 2].d[(reg >> 1) & 1]);
         if (reg & 1) {
-            ofs += offsetof(CPU_DoubleU, l.upper);
+            return r + offsetof(CPU_DoubleU, l.upper);
         } else {
-            ofs += offsetof(CPU_DoubleU, l.lower);
+            return r + offsetof(CPU_DoubleU, l.lower);
         }
-        return ofs;
     }
 }
 
-- 
2.14.3
