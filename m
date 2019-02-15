Received: from eggs.gnu.org ([209.51.188.92]:53607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1guaJs-0006n8-8n
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:02:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1guaJm-0000PE-AW
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:02:08 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 15 Feb 2019 10:00:50 +0000
Message-Id: <20190215100058.20015-10-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190215100058.20015-1-mark.cave-ayland@ilande.co.uk>
References: <20190215100058.20015-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 09/17] target/ppc: Pass integer to helper_mtvscr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, richard.henderson@linaro.org

From: Richard Henderson <richard.henderson@linaro.org>

We can re-use this helper elsewhere if we're not passing
in an entire vector register.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/helper.h                 |  2 +-
 target/ppc/int_helper.c             |  6 +++---
 target/ppc/translate/vmx-impl.inc.c | 17 +++++++++++++----
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 069daa9883..b3ffe28103 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -294,7 +294,7 @@ DEF_HELPER_5(vmsumuhs, void, env, avr, avr, avr, avr)
 DEF_HELPER_5(vmsumshm, void, env, avr, avr, avr, avr)
 DEF_HELPER_5(vmsumshs, void, env, avr, avr, avr, avr)
 DEF_HELPER_4(vmladduhm, void, avr, avr, avr, avr)
-DEF_HELPER_2(mtvscr, void, env, avr)
+DEF_HELPER_FLAGS_2(mtvscr, TCG_CALL_NO_RWG, void, env, i32)
 DEF_HELPER_3(lvebx, void, env, avr, tl)
 DEF_HELPER_3(lvehx, void, env, avr, tl)
 DEF_HELPER_3(lvewx, void, env, avr, tl)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 5c9623e952..aa6ad2ce7e 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -457,10 +457,10 @@ void helper_lvsr(ppc_avr_t *r, target_ulong sh)
     }
 }
 
-void helper_mtvscr(CPUPPCState *env, ppc_avr_t *r)
+void helper_mtvscr(CPUPPCState *env, uint32_t vscr)
 {
-    env->vscr = r->VsrW(3);
-    set_flush_to_zero(vscr_nj, &env->vec_status);
+    env->vscr = vscr;
+    set_flush_to_zero((vscr >> VSCR_NJ) & 1, &env->vec_status);
 }
 
 void helper_vaddcuw(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 41ddbd879f..182d3fc563 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -196,14 +196,23 @@ static void gen_mfvscr(DisasContext *ctx)
 
 static void gen_mtvscr(DisasContext *ctx)
 {
-    TCGv_ptr p;
+    TCGv_i32 val;
+    int bofs;
+
     if (unlikely(!ctx->altivec_enabled)) {
         gen_exception(ctx, POWERPC_EXCP_VPU);
         return;
     }
-    p = gen_avr_ptr(rB(ctx->opcode));
-    gen_helper_mtvscr(cpu_env, p);
-    tcg_temp_free_ptr(p);
+
+    val = tcg_temp_new_i32();
+    bofs = avr64_offset(rB(ctx->opcode), true);
+#ifdef HOST_WORDS_BIGENDIAN
+    bofs += 3 * 4;
+#endif
+
+    tcg_gen_ld_i32(val, cpu_env, bofs);
+    gen_helper_mtvscr(cpu_env, val);
+    tcg_temp_free_i32(val);
 }
 
 #define GEN_VX_VMUL10(name, add_cin, ret_carry)                         \
-- 
2.11.0
