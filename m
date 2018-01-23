Received: from eggs.gnu.org ([2001:4830:134:3::10]:43197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edpen-0001sg-QY
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:53:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edpel-00044r-Vq
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:53:57 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:34644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1edpel-00043u-Mj
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:53:55 -0500
Received: by mail-pg0-x242.google.com with SMTP id r19so8779200pgn.1
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 19:53:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 22 Jan 2018 19:53:45 -0800
Message-Id: <20180123035349.24538-2-richard.henderson@linaro.org>
In-Reply-To: <20180123035349.24538-1-richard.henderson@linaro.org>
References: <20180123035349.24538-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 1/5] target/arm: Expand vector registers for
 SVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

Change vfp.regs as a uint64_t to vfp.zregs as an ARMVectorReg.
The previous patches have made the change in representation
relatively painless.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           | 59 +++++++++++++++++++++++++++++++---------------
 target/arm/machine.c       | 35 ++++++++++++++++++++++++++-
 target/arm/translate-a64.c |  8 +++----
 target/arm/translate.c     |  7 +++---
 4 files changed, 81 insertions(+), 28 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d2bb59eded..1854fe51a8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -153,6 +153,42 @@ typedef struct {
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
+ *
+ * Align the data for use with TCG host vector operations.
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
+
 typedef struct CPUARMState {
     /* Regs for current mode.  */
     uint32_t regs[16];
@@ -477,22 +513,7 @@ typedef struct CPUARMState {
 
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
-         * This corresponds to the architecturally defined mapping between
-         * the two execution states, and means we do not need to explicitly
-         * map these registers when changing states.
-         */
-        uint64_t regs[64];
+        ARMVectorReg zregs[32];
 
         uint32_t xregs[16];
         /* We store these fpcsr fields separately for convenience.  */
@@ -2769,7 +2790,7 @@ static inline void *arm_get_el_change_hook_opaque(ARMCPU *cpu)
  */
 static inline uint64_t *aa32_vfp_dreg(CPUARMState *env, unsigned regno)
 {
-    return &env->vfp.regs[regno];
+    return &env->vfp.zregs[regno >> 1].d[regno & 1];
 }
 
 /**
@@ -2778,7 +2799,7 @@ static inline uint64_t *aa32_vfp_dreg(CPUARMState *env, unsigned regno)
  */
 static inline uint64_t *aa32_vfp_qreg(CPUARMState *env, unsigned regno)
 {
-    return &env->vfp.regs[2 * regno];
+    return &env->vfp.zregs[regno].d[0];
 }
 
 /**
@@ -2787,7 +2808,7 @@ static inline uint64_t *aa32_vfp_qreg(CPUARMState *env, unsigned regno)
  */
 static inline uint64_t *aa64_vfp_qreg(CPUARMState *env, unsigned regno)
 {
-    return &env->vfp.regs[2 * regno];
+    return &env->vfp.zregs[regno].d[0];
 }
 
 #endif
diff --git a/target/arm/machine.c b/target/arm/machine.c
index a85c2430d3..cb0e1c92bb 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -50,7 +50,40 @@ static const VMStateDescription vmstate_vfp = {
     .minimum_version_id = 3,
     .needed = vfp_needed,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT64_ARRAY(env.vfp.regs, ARMCPU, 64),
+        /* For compatibility, store Qn out of Zn here.  */
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
index eed64c73e5..10eef870fe 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -517,8 +517,8 @@ static inline int vec_reg_offset(DisasContext *s, int regno,
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
@@ -528,7 +528,7 @@ static inline int vec_reg_offset(DisasContext *s, int regno,
 #else
     offs += element * (1 << size);
 #endif
-    offs += offsetof(CPUARMState, vfp.regs[regno * 2]);
+    offs += offsetof(CPUARMState, vfp.zregs[regno]);
     assert_fp_access_checked(s);
     return offs;
 }
@@ -537,7 +537,7 @@ static inline int vec_reg_offset(DisasContext *s, int regno,
 static inline int vec_full_reg_offset(DisasContext *s, int regno)
 {
     assert_fp_access_checked(s);
-    return offsetof(CPUARMState, vfp.regs[regno * 2]);
+    return offsetof(CPUARMState, vfp.zregs[regno]);
 }
 
 /* Return a newly allocated pointer to the vector register.  */
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 55826b7e5a..a8c13d3758 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1512,13 +1512,12 @@ static inline void gen_vfp_st(DisasContext *s, int dp, TCGv_i32 addr)
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
+        long ofs = offsetof(CPUARMState, vfp.zregs[reg >> 2].d[(reg >> 1) & 1]);
         if (reg & 1) {
             ofs += offsetof(CPU_DoubleU, l.upper);
         } else {
-- 
2.14.3
