Received: from eggs.gnu.org ([209.51.188.92]:45505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h0UqC-0004vq-25
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 12:23:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h0UqA-0001qy-Io
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 12:23:56 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun,  3 Mar 2019 17:23:40 +0000
Message-Id: <20190303172343.13406-6-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190303172343.13406-1-mark.cave-ayland@ilande.co.uk>
References: <20190303172343.13406-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 5/8] target/ppc: introduce avr_offset() function
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
rather than separate access to the top and bottom 64-bits. Convert
the VMX TCG instructions to use a new avr_offset() function instead of
avr64_offset(), which can itself be written as a simple wrapper onto
vsr_full_offset().

After the conversion is complete then avr64_offset() can be removed since its
functionality is now completely within get_avr64()/set_avr64().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/cpu.h                    | 12 +++++++++++-
 target/ppc/translate/vmx-impl.inc.c | 27 +++++++++++----------------
 target/ppc/translate/vsx-impl.inc.c |  5 -----
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 326593e0e7..89651988ab 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2598,6 +2598,11 @@ static inline int vsrl_offset(int i)
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
@@ -2613,9 +2618,14 @@ static inline int avrl_offset(int i)
     return offsetof(CPUPPCState, vsr[32 + i].VsrD(1));
 }
 
+static inline int avr_offset(int i)
+{
+    return vsr_full_offset(i + 32);
+}
+
 static inline ppc_avr_t *cpu_avr_ptr(CPUPPCState *env, int i)
 {
-    return &env->vsr[32 + i];
+    return (ppc_avr_t *)((uintptr_t)env + avr_offset(i));
 }
 
 void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUPPCState *env);
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index f1b15ae2cb..5f0c96a5e9 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -10,15 +10,10 @@
 static inline TCGv_ptr gen_avr_ptr(int reg)
 {
     TCGv_ptr r = tcg_temp_new_ptr();
-    tcg_gen_addi_ptr(r, cpu_env, offsetof(CPUPPCState, vsr[32 + reg].u64[0]));
+    tcg_gen_addi_ptr(r, cpu_env, avr_offset(reg));
     return r;
 }
 
-static inline long avr64_offset(int reg, bool high)
-{
-    return offsetof(CPUPPCState, vsr[32 + reg].u64[(high ? 0 : 1)]);
-}
-
 #define GEN_VR_LDX(name, opc2, opc3)                                          \
 static void glue(gen_, name)(DisasContext *ctx)                                       \
 {                                                                             \
@@ -205,7 +200,7 @@ static void gen_mtvscr(DisasContext *ctx)
     }
 
     val = tcg_temp_new_i32();
-    bofs = avr64_offset(rB(ctx->opcode), true);
+    bofs = avr_offset(rB(ctx->opcode));
 #ifdef HOST_WORDS_BIGENDIAN
     bofs += 3 * 4;
 #endif
@@ -284,9 +279,9 @@ static void glue(gen_, name)(DisasContext *ctx)                         \
     }                                                                   \
                                                                         \
     tcg_op(vece,                                                        \
-           avr64_offset(rD(ctx->opcode), true),                         \
-           avr64_offset(rA(ctx->opcode), true),                         \
-           avr64_offset(rB(ctx->opcode), true),                         \
+           avr_offset(rD(ctx->opcode)),                                 \
+           avr_offset(rA(ctx->opcode)),                                 \
+           avr_offset(rB(ctx->opcode)),                                 \
            16, 16);                                                     \
 }
 
@@ -578,10 +573,10 @@ static void glue(gen_, NAME)(DisasContext *ctx)                         \
         gen_exception(ctx, POWERPC_EXCP_VPU);                           \
         return;                                                         \
     }                                                                   \
-    tcg_gen_gvec_4(avr64_offset(rD(ctx->opcode), true),                 \
+    tcg_gen_gvec_4(avr_offset(rD(ctx->opcode)),                         \
                    offsetof(CPUPPCState, vscr_sat),                     \
-                   avr64_offset(rA(ctx->opcode), true),                 \
-                   avr64_offset(rB(ctx->opcode), true),                 \
+                   avr_offset(rA(ctx->opcode)),                         \
+                   avr_offset(rB(ctx->opcode)),                         \
                    16, 16, &g);                                         \
 }
 
@@ -755,7 +750,7 @@ static void glue(gen_, name)(DisasContext *ctx)                         \
             return;                                                     \
         }                                                               \
         simm = SIMM5(ctx->opcode);                                      \
-        tcg_op(avr64_offset(rD(ctx->opcode), true), 16, 16, simm);      \
+        tcg_op(avr_offset(rD(ctx->opcode)), 16, 16, simm);              \
     }
 
 GEN_VXFORM_DUPI(vspltisb, tcg_gen_gvec_dup8i, 6, 12);
@@ -850,8 +845,8 @@ static void gen_vsplt(DisasContext *ctx, int vece)
     }
 
     uimm = UIMM5(ctx->opcode);
-    bofs = avr64_offset(rB(ctx->opcode), true);
-    dofs = avr64_offset(rD(ctx->opcode), true);
+    bofs = avr_offset(rB(ctx->opcode));
+    dofs = avr_offset(rD(ctx->opcode));
 
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
