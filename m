Received: from eggs.gnu.org ([2001:4830:134:3::10]:44745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gCl2v-0001yu-VI
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gCl2t-0006uT-1K
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:29 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:39448 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gCl2s-0006es-Ar
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:26 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 17 Oct 2018 14:33:44 +0200
Message-Id: <1539779635-15445-17-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539779635-15445-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539779635-15445-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 16/27] target/mips: Add availability control for
 DSP R3 ASE
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

From: Stefan Markovic <smarkovic@wavecomp.com>

Add infrastructure for availability control for DSP R3 ASE MIPS
instructions. Only BPOSGE32C currently belongs to DSP R3 ASE, but
this is likely to be changed in near future.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/internal.h           | 11 ++++++++---
 target/mips/translate.c          | 13 ++++++++++++-
 target/mips/translate_init.inc.c |  3 ++-
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index bfe83ee..4490bd1 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -307,8 +307,8 @@ static inline void compute_hflags(CPUMIPSState *env)
     env->hflags &= ~(MIPS_HFLAG_COP1X | MIPS_HFLAG_64 | MIPS_HFLAG_CP0 |
                      MIPS_HFLAG_F64 | MIPS_HFLAG_FPU | MIPS_HFLAG_KSU |
                      MIPS_HFLAG_AWRAP | MIPS_HFLAG_DSP | MIPS_HFLAG_DSPR2 |
-                     MIPS_HFLAG_SBRI | MIPS_HFLAG_MSA | MIPS_HFLAG_FRE |
-                     MIPS_HFLAG_ELPA | MIPS_HFLAG_ERL);
+                     MIPS_HFLAG_DSPR3 | MIPS_HFLAG_SBRI | MIPS_HFLAG_MSA |
+                     MIPS_HFLAG_FRE | MIPS_HFLAG_ELPA | MIPS_HFLAG_ERL);
     if (env->CP0_Status & (1 << CP0St_ERL)) {
         env->hflags |= MIPS_HFLAG_ERL;
     }
@@ -355,7 +355,12 @@ static inline void compute_hflags(CPUMIPSState *env)
         (env->CP0_Config5 & (1 << CP0C5_SBRI))) {
         env->hflags |= MIPS_HFLAG_SBRI;
     }
-    if (env->insn_flags & ASE_DSPR2) {
+    if (env->insn_flags & ASE_DSPR3) {
+        if (env->CP0_Status & (1 << CP0St_MX)) {
+            env->hflags |= MIPS_HFLAG_DSP | MIPS_HFLAG_DSPR2 |
+                           MIPS_HFLAG_DSPR3;
+        }
+    } else if (env->insn_flags & ASE_DSPR2) {
         /* Enables access MIPS DSP resources, now our cpu is DSP ASER2,
            so enable to access DSPR2 resources. */
         if (env->CP0_Status & (1 << CP0St_MX)) {
diff --git a/target/mips/translate.c b/target/mips/translate.c
index ce4a1bd..f7e861b 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -2408,6 +2408,17 @@ static inline void check_dspr2(DisasContext *ctx)
     }
 }
 
+static inline void check_dspr3(DisasContext *ctx)
+{
+    if (unlikely(!(ctx->hflags & MIPS_HFLAG_DSPR3))) {
+        if (ctx->insn_flags & ASE_DSP) {
+            generate_exception_end(ctx, EXCP_DSPDIS);
+        } else {
+            generate_exception_end(ctx, EXCP_RI);
+        }
+    }
+}
+
 /* This code generates a "reserved instruction" exception if the
    CPU does not support the instruction set corresponding to flags. */
 static inline void check_insn(DisasContext *ctx, uint64_t flags)
@@ -20638,7 +20649,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                     gen_compute_branch_cp1_nm(ctx, OPC_BC1NEZ, rt, s);
                     break;
                 case NM_BPOSGE32C:
-                    check_dspr2(ctx);
+                    check_dspr3(ctx);
                     {
                         int32_t imm = extract32(ctx->opcode, 1, 13) |
                                       extract32(ctx->opcode, 0, 1) << 13;
diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_init.inc.c
index b3320b9..d7cd4ee 100644
--- a/target/mips/translate_init.inc.c
+++ b/target/mips/translate_init.inc.c
@@ -485,7 +485,8 @@ const mips_def_t mips_defs[] =
         .CP1_fcr31 = (1 << FCR31_ABS2008) | (1 << FCR31_NAN2008),
         .SEGBITS = 32,
         .PABITS = 32,
-        .insn_flags = CPU_NANOMIPS32 | ASE_DSP | ASE_DSPR2 | ASE_MT,
+        .insn_flags = CPU_NANOMIPS32 | ASE_DSP | ASE_DSPR2 | ASE_DSPR3 |
+                      ASE_MT,
         .mmu_type = MMU_TYPE_R4000,
     },
 #if defined(TARGET_MIPS64)
-- 
2.7.4
