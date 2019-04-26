Received: from eggs.gnu.org ([209.51.188.92]:59443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK5UG-00063p-NG
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 14:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK5UF-0006Nr-Fi
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 14:22:16 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:47053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hK5UF-0006Mb-8m
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 14:22:15 -0400
Received: by mail-pf1-x431.google.com with SMTP id j11so2091608pff.13
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 11:22:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 26 Apr 2019 11:22:09 -0700
Message-Id: <20190426182210.10442-2-richard.henderson@linaro.org>
In-Reply-To: <20190426182210.10442-1-richard.henderson@linaro.org>
References: <20190426182210.10442-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 1/2] target/hppa: Implement Fast TLB Insert
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Nick Hudson <skrll@netbsd.org>

From: Nick Hudson <skrll@netbsd.org>

These instructions are present on pcxl and pcxl2 machines,
and are used by NetBSD and OpenBSD.  See

     https://parisc.wiki.kernel.org/images-parisc/a/a9/Pcxl2_ers.pdf
     page 13-9 (195/206)

Signed-off-by: Nick Hudson <skrll@netbsd.org>
Message-Id: <20190423063621.8203-2-nick.hudson@gmx.co.uk>
[rth: Use extending loads, locally managed temporaries.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c  | 54 ++++++++++++++++++++++++++++++++++++++++
 target/hppa/insns.decode |  3 +++
 2 files changed, 57 insertions(+)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 43b74367ea..aa140c6c72 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2518,6 +2518,60 @@ static bool trans_pxtlbx(DisasContext *ctx, arg_pxtlbx *a)
 #endif
 }
 
+/*
+ * Implement the pcxl and pcxl2 Fast TLB Insert instructions.
+ * See
+ *     https://parisc.wiki.kernel.org/images-parisc/a/a9/Pcxl2_ers.pdf
+ *     page 13-9 (195/206)
+ */
+static bool trans_ixtlbxf(DisasContext *ctx, arg_ixtlbxf *a)
+{
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+#ifndef CONFIG_USER_ONLY
+    TCGv_tl addr, atl, stl;
+    TCGv_reg reg;
+
+    nullify_over(ctx);
+
+    /*
+     * FIXME:
+     *  if (not (pcxl or pcxl2))
+     *    return gen_illegal(ctx);
+     *
+     * Note for future: these are 32-bit systems; no hppa64.
+     */
+
+    atl = tcg_temp_new_tl(ctx);
+    stl = tcg_temp_new_tl(ctx);
+    addr = tcg_temp_new_tl(ctx);
+
+    tcg_gen_ld32u_i64(stl, cpu_env,
+                      a->data ? offsetof(CPUHPPAState, cr[CR_ISR])
+                      : offsetof(CPUHPPAState, cr[CR_IIASQ]));
+    tcg_gen_ld32u_i64(atl, cpu_env,
+                      a->data ? offsetof(CPUHPPAState, cr[CR_IOR])
+                      : offsetof(CPUHPPAState, cr[CR_IIAOQ]));
+    tcg_gen_shli_i64(stl, stl, 32);
+    tcg_gen_or_tl(addr, atl, stl);
+    tcg_temp_free_tl(atl);
+    tcg_temp_free_tl(stl);
+
+    reg = load_gpr(ctx, a->r);
+    if (a->addr) {
+        gen_helper_itlba(cpu_env, addr, reg);
+    } else {
+        gen_helper_itlbp(cpu_env, addr, reg);
+    }
+    tcg_temp_free_tl(addr);
+
+    /* Exit TB for TLB change if mmu is enabled.  */
+    if (ctx->tb_flags & PSW_C) {
+        ctx->base.is_jmp = DISAS_IAQ_N_STALE;
+    }
+    return nullify_end(ctx);
+#endif
+}
+
 static bool trans_lpa(DisasContext *ctx, arg_ldst *a)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 098370c2f0..f0dd71dd08 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -133,6 +133,9 @@ ixtlbx          000001 b:5 r:5 sp:2 0100000 addr:1 0 00000      data=1
 ixtlbx          000001 b:5 r:5 ... 000000 addr:1 0 00000        \
                 sp=%assemble_sr3x data=0
 
+# pcxl and pcxl2 Fast TLB Insert instructions
+ixtlbxf         000001 00000 r:5 00 0 data:1 01000 addr:1 0 00000
+
 pxtlbx          000001 b:5 x:5 sp:2 0100100 local:1 m:1 -----   data=1
 pxtlbx          000001 b:5 x:5 ... 000100 local:1 m:1 -----     \
                 sp=%assemble_sr3x data=0
-- 
2.17.1
