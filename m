Received: from eggs.gnu.org ([209.51.188.92]:35793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AK-0001nk-If
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AC-0000RQ-HG
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:40 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr4A8-0000JU-DR
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:34 -0500
Received: by mail-wr1-x444.google.com with SMTP id t27so4455709wra.6
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 09:05:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id w13sm5583164wmf.5.2019.02.05.09.05.14
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Feb 2019 09:05:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Feb 2019 17:04:50 +0000
Message-Id: <20190205170510.21984-3-peter.maydell@linaro.org>
In-Reply-To: <20190205170510.21984-1-peter.maydell@linaro.org>
References: <20190205170510.21984-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/22] target/arm: Add PSTATE.BTYPE
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

Place this in its own field within ENV, as that will
make it easier to reset from within TCG generated code.

With the change to pstate_read/write, exception entry
and return are automatically handled.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190128223118.5255-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h           | 8 ++++++--
 target/arm/translate-a64.c | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0c7ea39f1ae..58f99985c24 100644
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
@@ -1206,6 +1208,7 @@ void pmu_init(ARMCPU *cpu);
 #define PSTATE_I (1U << 7)
 #define PSTATE_A (1U << 8)
 #define PSTATE_D (1U << 9)
+#define PSTATE_BTYPE (3U << 10)
 #define PSTATE_IL (1U << 20)
 #define PSTATE_SS (1U << 21)
 #define PSTATE_V (1U << 28)
@@ -1214,7 +1217,7 @@ void pmu_init(ARMCPU *cpu);
 #define PSTATE_N (1U << 31)
 #define PSTATE_NZCV (PSTATE_N | PSTATE_Z | PSTATE_C | PSTATE_V)
 #define PSTATE_DAIF (PSTATE_D | PSTATE_A | PSTATE_I | PSTATE_F)
-#define CACHED_PSTATE_BITS (PSTATE_NZCV | PSTATE_DAIF)
+#define CACHED_PSTATE_BITS (PSTATE_NZCV | PSTATE_DAIF | PSTATE_BTYPE)
 /* Mode values for AArch64 */
 #define PSTATE_MODE_EL3h 13
 #define PSTATE_MODE_EL3t 12
@@ -1246,7 +1249,7 @@ static inline uint32_t pstate_read(CPUARMState *env)
     ZF = (env->ZF == 0);
     return (env->NF & 0x80000000) | (ZF << 30)
         | (env->CF << 29) | ((env->VF & 0x80000000) >> 3)
-        | env->pstate | env->daif;
+        | env->pstate | env->daif | (env->btype << 10);
 }
 
 static inline void pstate_write(CPUARMState *env, uint32_t val)
@@ -1256,6 +1259,7 @@ static inline void pstate_write(CPUARMState *env, uint32_t val)
     env->CF = (val >> 29) & 1;
     env->VF = (val << 3) & 0x80000000;
     env->daif = val & PSTATE_DAIF;
+    env->btype = (val >> 10) & 3;
     env->pstate = val & ~CACHED_PSTATE_BITS;
 }
 
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index a1997e3ae28..0b94d9455b7 100644
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
2.20.1
