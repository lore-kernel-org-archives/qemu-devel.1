Received: from eggs.gnu.org ([2001:4830:134:3::10]:50376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOT-0008Hm-Hg
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOR-0006ux-TO
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:17 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 17 Oct 2017 15:21:25 +1100
Message-Id: <20171017042152.29443-8-david@gibson.dropbear.id.au>
In-Reply-To: <20171017042152.29443-1-david@gibson.dropbear.id.au>
References: <20171017042152.29443-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 07/34] target/ppc: Fix carry flag setting for
 shift algebraic instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: ehabkost@redhat.com, agraf@suse.de, imammedo@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Sandipan Das <sandipan@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Sandipan Das <sandipan@linux.vnet.ibm.com>

For POWER ISA v3.0, the XER bit CA32 needs to be set by the shift
right algebraic instructions whenever the CA bit is to be set. This
change affects the following instructions:
  * Shift Right Algebraic Word (sraw[.])
  * Shift Right Algebraic Word Immediate (srawi[.])
  * Shift Right Algebraic Doubleword (srad[.])
  * Shift Right Algebraic Doubleword Immediate (sradi[.])

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/int_helper.c | 16 ++++++++--------
 target/ppc/translate.c  | 12 ++++++++++++
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index da4e1a62c9..1c013a0ee3 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -219,17 +219,17 @@ target_ulong helper_sraw(CPUPPCState *env, target_ulong value,
             shift &= 0x1f;
             ret = (int32_t)value >> shift;
             if (likely(ret >= 0 || (value & ((1 << shift) - 1)) == 0)) {
-                env->ca = 0;
+                env->ca32 = env->ca = 0;
             } else {
-                env->ca = 1;
+                env->ca32 = env->ca = 1;
             }
         } else {
             ret = (int32_t)value;
-            env->ca = 0;
+            env->ca32 = env->ca = 0;
         }
     } else {
         ret = (int32_t)value >> 31;
-        env->ca = (ret != 0);
+        env->ca32 = env->ca = (ret != 0);
     }
     return (target_long)ret;
 }
@@ -245,17 +245,17 @@ target_ulong helper_srad(CPUPPCState *env, target_ulong value,
             shift &= 0x3f;
             ret = (int64_t)value >> shift;
             if (likely(ret >= 0 || (value & ((1ULL << shift) - 1)) == 0)) {
-                env->ca = 0;
+                env->ca32 = env->ca = 0;
             } else {
-                env->ca = 1;
+                env->ca32 = env->ca = 1;
             }
         } else {
             ret = (int64_t)value;
-            env->ca = 0;
+            env->ca32 = env->ca = 0;
         }
     } else {
         ret = (int64_t)value >> 63;
-        env->ca = (ret != 0);
+        env->ca32 = env->ca = (ret != 0);
     }
     return ret;
 }
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 606b605ba0..a81ff69d75 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2181,6 +2181,9 @@ static void gen_srawi(DisasContext *ctx)
     if (sh == 0) {
         tcg_gen_ext32s_tl(dst, src);
         tcg_gen_movi_tl(cpu_ca, 0);
+        if (is_isa300(ctx)) {
+            tcg_gen_movi_tl(cpu_ca32, 0);
+        }
     } else {
         TCGv t0;
         tcg_gen_ext32s_tl(dst, src);
@@ -2190,6 +2193,9 @@ static void gen_srawi(DisasContext *ctx)
         tcg_gen_and_tl(cpu_ca, cpu_ca, t0);
         tcg_temp_free(t0);
         tcg_gen_setcondi_tl(TCG_COND_NE, cpu_ca, cpu_ca, 0);
+        if (is_isa300(ctx)) {
+            tcg_gen_mov_tl(cpu_ca32, cpu_ca);
+        }
         tcg_gen_sari_tl(dst, dst, sh);
     }
     if (unlikely(Rc(ctx->opcode) != 0)) {
@@ -2259,6 +2265,9 @@ static inline void gen_sradi(DisasContext *ctx, int n)
     if (sh == 0) {
         tcg_gen_mov_tl(dst, src);
         tcg_gen_movi_tl(cpu_ca, 0);
+        if (is_isa300(ctx)) {
+            tcg_gen_movi_tl(cpu_ca32, 0);
+        }
     } else {
         TCGv t0;
         tcg_gen_andi_tl(cpu_ca, src, (1ULL << sh) - 1);
@@ -2267,6 +2276,9 @@ static inline void gen_sradi(DisasContext *ctx, int n)
         tcg_gen_and_tl(cpu_ca, cpu_ca, t0);
         tcg_temp_free(t0);
         tcg_gen_setcondi_tl(TCG_COND_NE, cpu_ca, cpu_ca, 0);
+        if (is_isa300(ctx)) {
+            tcg_gen_mov_tl(cpu_ca32, cpu_ca);
+        }
         tcg_gen_sari_tl(dst, src, sh);
     }
     if (unlikely(Rc(ctx->opcode) != 0)) {
-- 
2.13.6
