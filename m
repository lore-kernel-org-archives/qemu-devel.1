Received: from eggs.gnu.org ([2001:4830:134:3::10]:51577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeUSB-0005KS-UO
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeUS8-0002Oa-QS
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:39 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:39198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eeUS8-0002ON-Kr
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:36 -0500
Received: by mail-pg0-x244.google.com with SMTP id w17so3811916pgv.6
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 15:27:36 -0800 (PST)
Received: from cloudburst.twiddle.net (174-21-6-47.tukw.qwest.net.
	[174.21.6.47]) by smtp.gmail.com with ESMTPSA id
	z19sm9760028pfh.185.2018.01.24.15.27.34 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Jan 2018 15:27:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 24 Jan 2018 15:26:25 -0800
Message-Id: <20180124232625.30105-46-richard.henderson@linaro.org>
In-Reply-To: <20180124232625.30105-1-richard.henderson@linaro.org>
References: <20180124232625.30105-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 45/45] target/hppa: Implement PROBE for
 system mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/helper.h    |  3 +--
 target/hppa/op_helper.c | 36 +++++++++++++++++++++++++-----------
 target/hppa/translate.c | 20 ++++++++++++++++----
 3 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 31320740da..51dc3f8b09 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -17,8 +17,7 @@ DEF_HELPER_FLAGS_3(stby_b_parallel, TCG_CALL_NO_WG, void, env, tl, tr)
 DEF_HELPER_FLAGS_3(stby_e, TCG_CALL_NO_WG, void, env, tl, tr)
 DEF_HELPER_FLAGS_3(stby_e_parallel, TCG_CALL_NO_WG, void, env, tl, tr)
 
-DEF_HELPER_FLAGS_1(probe_r, TCG_CALL_NO_RWG_SE, tr, tl)
-DEF_HELPER_FLAGS_1(probe_w, TCG_CALL_NO_RWG_SE, tr, tl)
+DEF_HELPER_FLAGS_4(probe, TCG_CALL_NO_WG, tr, env, tl, i32, i32)
 
 DEF_HELPER_FLAGS_1(loaded_fr0, TCG_CALL_NO_RWG, void, env)
 
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index c2eeced0e9..b386394bdf 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -160,21 +160,35 @@ void HELPER(stby_e_parallel)(CPUHPPAState *env, target_ulong addr,
     do_stby_e(env, addr, val, true);
 }
 
-target_ureg HELPER(probe_r)(target_ulong addr)
+target_ureg HELPER(probe)(CPUHPPAState *env, target_ulong addr,
+                          uint32_t level, uint32_t want)
 {
 #ifdef CONFIG_USER_ONLY
-    return page_check_range(addr, 1, PAGE_READ);
+    return page_check_range(addr, 1, want);
 #else
-    return 1; /* FIXME */
-#endif
-}
+    int prot, excp;
+    hwaddr phys;
 
-target_ureg HELPER(probe_w)(target_ulong addr)
-{
-#ifdef CONFIG_USER_ONLY
-    return page_check_range(addr, 1, PAGE_WRITE);
-#else
-    return 1; /* FIXME */
+    /* Fail if the requested privilege level is higher than current.  */
+    if (level < (env->iaoq_f & 3)) {
+        return 0;
+    }
+
+    /* Use MMU_DEBUG_LOAD to bypass TLB D/B/T bit checks.  */
+    excp = hppa_get_physical_address(env, addr, level, MMU_DEBUG_LOAD,
+                                     &phys, &prot);
+    if (excp >= 0) {
+        if (env->psw & PSW_Q) {
+            /* ??? Needs tweaking for hppa64.  */
+            env->cr[CR_IOR] = addr;
+            env->cr[CR_ISR] = addr >> 32;
+        }
+        if (excp == EXCP_DTLB_MISS) {
+            excp = EXCP_NA_DTLB_MISS;
+        }
+        hppa_dynamic_excp(env, excp, GETPC());
+    }
+    return (want & prot) != 0;
 #endif
 }
 
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index c62ee72615..7c45b1706c 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2380,21 +2380,33 @@ static DisasJumpType trans_probe(DisasContext *ctx, uint32_t insn,
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned sp = extract32(insn, 14, 2);
+    unsigned rr = extract32(insn, 16, 5);
     unsigned rb = extract32(insn, 21, 5);
     unsigned is_write = extract32(insn, 6, 1);
+    unsigned is_imm = extract32(insn, 13, 1);
     TCGv_reg dest, ofs;
+    TCGv_i32 level, want;
     TCGv_tl addr;
 
     nullify_over(ctx);
 
-    /* ??? Do something with priv level operand.  */
     dest = dest_gpr(ctx, rt);
     form_gva(ctx, &addr, &ofs, rb, 0, 0, 0, sp, 0, false);
-    if (is_write) {
-        gen_helper_probe_w(dest, addr);
+
+    if (is_imm) {
+        level = tcg_const_i32(extract32(insn, 16, 2));
     } else {
-        gen_helper_probe_r(dest, addr);
+        level = tcg_temp_new_i32();
+        tcg_gen_trunc_reg_i32(level, load_gpr(ctx, rr));
+        tcg_gen_andi_i32(level, level, 3);
     }
+    want = tcg_const_i32(is_write ? PROT_WRITE : PROT_READ);
+
+    gen_helper_probe(dest, cpu_env, addr, level, want);
+
+    tcg_temp_free_i32(want);
+    tcg_temp_free_i32(level);
+
     save_gpr(ctx, rt, dest);
     return nullify_end(ctx, DISAS_NEXT);
 }
-- 
2.14.3
