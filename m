Received: from eggs.gnu.org ([209.51.188.92]:55897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ghZHT-0004ST-Aa
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:17:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ghZHS-0007WY-Ez
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:17:51 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:34144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ghZHS-0007Vt-8K
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:17:50 -0500
Received: by mail-pg1-x542.google.com with SMTP id j10so4776332pga.1
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 04:17:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 Jan 2019 23:17:27 +1100
Message-Id: <20190110121736.23448-3-richard.henderson@linaro.org>
In-Reply-To: <20190110121736.23448-1-richard.henderson@linaro.org>
References: <20190110121736.23448-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 02/11] target/arm: Add PSTATE.BTYPE
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           | 8 ++++++--
 target/arm/translate-a64.c | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index fadb74d9a6..8179c07250 100644
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
@@ -1155,6 +1157,7 @@ void pmccntr_sync(CPUARMState *env);
 #define PSTATE_I (1U << 7)
 #define PSTATE_A (1U << 8)
 #define PSTATE_D (1U << 9)
+#define PSTATE_BTYPE (3U << 10)
 #define PSTATE_IL (1U << 20)
 #define PSTATE_SS (1U << 21)
 #define PSTATE_V (1U << 28)
@@ -1163,7 +1166,7 @@ void pmccntr_sync(CPUARMState *env);
 #define PSTATE_N (1U << 31)
 #define PSTATE_NZCV (PSTATE_N | PSTATE_Z | PSTATE_C | PSTATE_V)
 #define PSTATE_DAIF (PSTATE_D | PSTATE_A | PSTATE_I | PSTATE_F)
-#define CACHED_PSTATE_BITS (PSTATE_NZCV | PSTATE_DAIF)
+#define CACHED_PSTATE_BITS (PSTATE_NZCV | PSTATE_DAIF | PSTATE_BTYPE)
 /* Mode values for AArch64 */
 #define PSTATE_MODE_EL3h 13
 #define PSTATE_MODE_EL3t 12
@@ -1195,7 +1198,7 @@ static inline uint32_t pstate_read(CPUARMState *env)
     ZF = (env->ZF == 0);
     return (env->NF & 0x80000000) | (ZF << 30)
         | (env->CF << 29) | ((env->VF & 0x80000000) >> 3)
-        | env->pstate | env->daif;
+        | env->pstate | env->daif | (env->btype << 10);
 }
 
 static inline void pstate_write(CPUARMState *env, uint32_t val)
@@ -1205,6 +1208,7 @@ static inline void pstate_write(CPUARMState *env, uint32_t val)
     env->CF = (val >> 29) & 1;
     env->VF = (val << 3) & 0x80000000;
     env->daif = val & PSTATE_DAIF;
+    env->btype = (val >> 10) & 3;
     env->pstate = val & ~CACHED_PSTATE_BITS;
 }
 
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2c5ad1774a..e43f0982f9 100644
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
