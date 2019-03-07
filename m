Received: from eggs.gnu.org ([209.51.188.92]:48458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h1xOm-0007FP-P3
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:05:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h1xOl-0006Ow-IK
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:05:40 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu,  7 Mar 2019 18:05:17 +0000
Message-Id: <20190307180520.13868-5-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190307180520.13868-1-mark.cave-ayland@ilande.co.uk>
References: <20190307180520.13868-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v2 4/7] target/ppc: introduce avr_full_offset()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, richard.henderson@linaro.org

All TCG vector operations require pointers to the base address of the vector
rather than separate access to the top and bottom 64-bits. Convert the VMX TCG
instructions to use a new avr_full_offset() function instead of avr64_offset()
which can then itself be written as a simple wrapper onto vsr_full_offset().

This same function can also reused in cpu_avr_ptr() to avoid having more than
one copy of the offset calculation logic.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/cpu.h                    | 12 +++++++++++-
 target/ppc/translate/vmx-impl.inc.c | 22 +++++++++++-----------
 target/ppc/translate/vsx-impl.inc.c |  5 -----
 3 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index d0580c6b6d..2a2792306f 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2598,14 +2598,24 @@ static inline int vsrl_offset(int i)
     return offsetof(CPUPPCState, vsr[i].u64[1]);
 }
 
+static inline int vsr_full_offset(int i)
+{
+    return offsetof(CPUPPCState, vsr[i].u64[0]);
+}
+
 static inline uint64_t *cpu_vsrl_ptr(CPUPPCState *env, int i)
 {
     return (uint64_t *)((uintptr_t)env + vsrl_offset(i));
 }
 
+static inline int avr_full_offset(int i)
+{
+    return vsr_full_offset(i + 32);
+}
+
 static inline ppc_avr_t *cpu_avr_ptr(CPUPPCState *env, int i)
 {
-    return &env->vsr[32 + i];
+    return (ppc_avr_t *)((uintptr_t)env + avr_full_offset(i));
 }
 
 void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUPPCState *env);
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index f1b15ae2cb..4e5d0bc0e0 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -10,7 +10,7 @@
 static inline TCGv_ptr gen_avr_ptr(int reg)
 {
     TCGv_ptr r = tcg_temp_new_ptr();
-    tcg_gen_addi_ptr(r, cpu_env, offsetof(CPUPPCState, vsr[32 + reg].u64[0]));
+    tcg_gen_addi_ptr(r, cpu_env, avr_full_offset(reg));
     return r;
 }
 
@@ -205,7 +205,7 @@ static void gen_mtvscr(DisasContext *ctx)
     }
 
     val = tcg_temp_new_i32();
-    bofs = avr64_offset(rB(ctx->opcode), true);
+    bofs = avr_full_offset(rB(ctx->opcode));
 #ifdef HOST_WORDS_BIGENDIAN
     bofs += 3 * 4;
 #endif
@@ -284,9 +284,9 @@ static void glue(gen_, name)(DisasContext *ctx)                         \
     }                                                                   \
                                                                         \
     tcg_op(vece,                                                        \
-           avr64_offset(rD(ctx->opcode), true),                         \
-           avr64_offset(rA(ctx->opcode), true),                         \
-           avr64_offset(rB(ctx->opcode), true),                         \
+           avr_full_offset(rD(ctx->opcode)),                            \
+           avr_full_offset(rA(ctx->opcode)),                            \
+           avr_full_offset(rB(ctx->opcode)),                            \
            16, 16);                                                     \
 }
 
@@ -578,10 +578,10 @@ static void glue(gen_, NAME)(DisasContext *ctx)                         \
         gen_exception(ctx, POWERPC_EXCP_VPU);                           \
         return;                                                         \
     }                                                                   \
-    tcg_gen_gvec_4(avr64_offset(rD(ctx->opcode), true),                 \
+    tcg_gen_gvec_4(avr_full_offset(rD(ctx->opcode)),                    \
                    offsetof(CPUPPCState, vscr_sat),                     \
-                   avr64_offset(rA(ctx->opcode), true),                 \
-                   avr64_offset(rB(ctx->opcode), true),                 \
+                   avr_full_offset(rA(ctx->opcode)),                    \
+                   avr_full_offset(rB(ctx->opcode)),                    \
                    16, 16, &g);                                         \
 }
 
@@ -755,7 +755,7 @@ static void glue(gen_, name)(DisasContext *ctx)                         \
             return;                                                     \
         }                                                               \
         simm = SIMM5(ctx->opcode);                                      \
-        tcg_op(avr64_offset(rD(ctx->opcode), true), 16, 16, simm);      \
+        tcg_op(avr_full_offset(rD(ctx->opcode)), 16, 16, simm);         \
     }
 
 GEN_VXFORM_DUPI(vspltisb, tcg_gen_gvec_dup8i, 6, 12);
@@ -850,8 +850,8 @@ static void gen_vsplt(DisasContext *ctx, int vece)
     }
 
     uimm = UIMM5(ctx->opcode);
-    bofs = avr64_offset(rB(ctx->opcode), true);
-    dofs = avr64_offset(rD(ctx->opcode), true);
+    bofs = avr_full_offset(rB(ctx->opcode));
+    dofs = avr_full_offset(rD(ctx->opcode));
 
     /* Experimental testing shows that hardware masks the immediate.  */
     bofs += (uimm << vece) & 15;
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 381ae0f2e9..7d02a235e7 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -10,11 +10,6 @@ static inline void set_vsrl(int n, TCGv_i64 src)
     tcg_gen_st_i64(src, cpu_env, vsrl_offset(n));
 }
 
-static inline int vsr_full_offset(int n)
-{
-    return offsetof(CPUPPCState, vsr[n].u64[0]);
-}
-
 static inline void get_cpu_vsrh(TCGv_i64 dst, int n)
 {
     if (n < 32) {
-- 
2.11.0
