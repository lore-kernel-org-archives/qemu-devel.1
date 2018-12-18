Received: from eggs.gnu.org ([2001:4830:134:3::10]:52904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92t-0001fH-RS
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92q-0002py-Pm
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:39:59 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:36692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZ92q-0002iw-Cp
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:39:56 -0500
Received: by mail-pf1-x434.google.com with SMTP id b85so7655504pfc.3
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 22:39:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 17 Dec 2018 22:39:03 -0800
Message-Id: <20181218063911.2112-27-richard.henderson@linaro.org>
In-Reply-To: <20181218063911.2112-1-richard.henderson@linaro.org>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 26/34] target/ppc: Pass integer to helper_mtvscr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

We can re-use this helper elsewhere if we're not passing
in an entire vector register.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/helper.h                 |  2 +-
 target/ppc/int_helper.c             | 10 +++-------
 target/ppc/translate/vmx-impl.inc.c | 17 +++++++++++++----
 3 files changed, 17 insertions(+), 12 deletions(-)

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
index 3bf0fdb6c5..0443f33cd2 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -469,14 +469,10 @@ void helper_lvsr(ppc_avr_t *r, target_ulong sh)
     }
 }
 
-void helper_mtvscr(CPUPPCState *env, ppc_avr_t *r)
+void helper_mtvscr(CPUPPCState *env, uint32_t vscr)
 {
-#if defined(HOST_WORDS_BIGENDIAN)
-    env->vscr = r->u32[3];
-#else
-    env->vscr = r->u32[0];
-#endif
-    set_flush_to_zero(vscr_nj, &env->vec_status);
+    env->vscr = vscr;
+    set_flush_to_zero((vscr >> VSCR_NJ) & 1, &env->vec_status);
 }
 
 void helper_vaddcuw(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 329131d30b..ab6da3aa55 100644
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
2.17.2
