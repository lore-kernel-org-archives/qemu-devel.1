Received: from eggs.gnu.org ([209.51.188.92]:46992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goFcD-0006iZ-2v
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:42:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goFRD-0006Bb-1k
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:31:32 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1goFRB-0006A1-5S
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:31:30 -0500
Received: by mail-ot1-x344.google.com with SMTP id n8so16173280otl.6
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 14:31:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 28 Jan 2019 14:31:08 -0800
Message-Id: <20190128223118.5255-3-richard.henderson@linaro.org>
In-Reply-To: <20190128223118.5255-1-richard.henderson@linaro.org>
References: <20190128223118.5255-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 02/12] target/arm: Add PSTATE.BTYPE
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

Place this in its own field within ENV, as that will
make it easier to reset from within TCG generated code.

With the change to pstate_read/write, exception entry
and return are automatically handled.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           | 8 ++++++--
 target/arm/translate-a64.c | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d7190f0712..76e2f8fd42 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -234,6 +234,7 @@ typedef struct CPUARMState {
      *    semantics as for AArch32, as described in the comments on each field)
      *  nRW (also known as M[4]) is kept, inverted, in env->aarch64
      *  DAIF (exception masks) are kept in env->daif
+     *  BTYPE is kept in env->btype
      *  all other bits are stored in their correct places in env->pstate
      */
     uint32_t pstate;
@@ -263,6 +264,7 @@ typedef struct CPUARMState {
     uint32_t GE; /* cpsr[19:16] */
     uint32_t thumb; /* cpsr[5]. 0 = arm mode, 1 = thumb mode. */
     uint32_t condexec_bits; /* IT bits.  cpsr[15:10,26:25].  */
+    uint32_t btype;  /* BTI branch type.  spsr[11:10].  */
     uint64_t daif; /* exception masks, in the bits they are in PSTATE */
 
     uint64_t elr_el[4]; /* AArch64 exception link regs  */
@@ -1197,6 +1199,7 @@ uint64_t get_pmceid(CPUARMState *env, unsigned which);
 #define PSTATE_I (1U << 7)
 #define PSTATE_A (1U << 8)
 #define PSTATE_D (1U << 9)
+#define PSTATE_BTYPE (3U << 10)
 #define PSTATE_IL (1U << 20)
 #define PSTATE_SS (1U << 21)
 #define PSTATE_V (1U << 28)
@@ -1205,7 +1208,7 @@ uint64_t get_pmceid(CPUARMState *env, unsigned which);
 #define PSTATE_N (1U << 31)
 #define PSTATE_NZCV (PSTATE_N | PSTATE_Z | PSTATE_C | PSTATE_V)
 #define PSTATE_DAIF (PSTATE_D | PSTATE_A | PSTATE_I | PSTATE_F)
-#define CACHED_PSTATE_BITS (PSTATE_NZCV | PSTATE_DAIF)
+#define CACHED_PSTATE_BITS (PSTATE_NZCV | PSTATE_DAIF | PSTATE_BTYPE)
 /* Mode values for AArch64 */
 #define PSTATE_MODE_EL3h 13
 #define PSTATE_MODE_EL3t 12
@@ -1237,7 +1240,7 @@ static inline uint32_t pstate_read(CPUARMState *env)
     ZF = (env->ZF == 0);
     return (env->NF & 0x80000000) | (ZF << 30)
         | (env->CF << 29) | ((env->VF & 0x80000000) >> 3)
-        | env->pstate | env->daif;
+        | env->pstate | env->daif | (env->btype << 10);
 }
 
 static inline void pstate_write(CPUARMState *env, uint32_t val)
@@ -1247,6 +1250,7 @@ static inline void pstate_write(CPUARMState *env, uint32_t val)
     env->CF = (val >> 29) & 1;
     env->VF = (val << 3) & 0x80000000;
     env->daif = val & PSTATE_DAIF;
+    env->btype = (val >> 10) & 3;
     env->pstate = val & ~CACHED_PSTATE_BITS;
 }
 
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 4d28a27c3b..611279e98e 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -163,6 +163,9 @@ void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
                 el,
                 psr & PSTATE_SP ? 'h' : 't');
 
+    if (cpu_isar_feature(aa64_bti, cpu)) {
+        cpu_fprintf(f, "  BTYPE=%d", (psr & PSTATE_BTYPE) >> 10);
+    }
     if (!(flags & CPU_DUMP_FPU)) {
         cpu_fprintf(f, "\n");
         return;
-- 
2.17.2
