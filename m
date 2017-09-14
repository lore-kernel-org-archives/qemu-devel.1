Received: from eggs.gnu.org ([2001:4830:134:3::10]:37757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsZNl-0003cE-JI
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsZNi-0006IF-4K
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:01:01 -0400
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d]:49085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dsZNh-0006Hb-Ta
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:00:58 -0400
Received: by mail-pf0-x22d.google.com with SMTP id n24so152739pfk.5
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 12:00:57 -0700 (PDT)
Received: from bigtime.twiddle.net (97-126-103-167.tukw.qwest.net.
	[97.126.103.167]) by smtp.gmail.com with ESMTPSA id
	m24sm32941520pfj.28.2017.09.14.12.00.55 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 14 Sep 2017 12:00:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 14 Sep 2017 12:00:50 -0700
Message-Id: <20170914190053.27625-2-richard.henderson@linaro.org>
In-Reply-To: <20170914190053.27625-1-richard.henderson@linaro.org>
References: <20170914190053.27625-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/4] tcg/arm: Fully convert tcg_target_op_def
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
 tcg/arm/tcg-target.inc.c | 186 +++++++++++++++++++++++++++--------------------
 1 file changed, 107 insertions(+), 79 deletions(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 14599a8685..98a12535a5 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -2060,91 +2060,119 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
     }
 }
 
-static const TCGTargetOpDef arm_op_defs[] = {
-    { INDEX_op_exit_tb, { } },
-    { INDEX_op_goto_tb, { } },
-    { INDEX_op_br, { } },
-    { INDEX_op_goto_ptr, { "r" } },
-
-    { INDEX_op_ld8u_i32, { "r", "r" } },
-    { INDEX_op_ld8s_i32, { "r", "r" } },
-    { INDEX_op_ld16u_i32, { "r", "r" } },
-    { INDEX_op_ld16s_i32, { "r", "r" } },
-    { INDEX_op_ld_i32, { "r", "r" } },
-    { INDEX_op_st8_i32, { "r", "r" } },
-    { INDEX_op_st16_i32, { "r", "r" } },
-    { INDEX_op_st_i32, { "r", "r" } },
-
-    /* TODO: "r", "r", "ri" */
-    { INDEX_op_add_i32, { "r", "r", "rIN" } },
-    { INDEX_op_sub_i32, { "r", "rI", "rIN" } },
-    { INDEX_op_mul_i32, { "r", "r", "r" } },
-    { INDEX_op_mulu2_i32, { "r", "r", "r", "r" } },
-    { INDEX_op_muls2_i32, { "r", "r", "r", "r" } },
-    { INDEX_op_and_i32, { "r", "r", "rIK" } },
-    { INDEX_op_andc_i32, { "r", "r", "rIK" } },
-    { INDEX_op_or_i32, { "r", "r", "rI" } },
-    { INDEX_op_xor_i32, { "r", "r", "rI" } },
-    { INDEX_op_neg_i32, { "r", "r" } },
-    { INDEX_op_not_i32, { "r", "r" } },
-
-    { INDEX_op_shl_i32, { "r", "r", "ri" } },
-    { INDEX_op_shr_i32, { "r", "r", "ri" } },
-    { INDEX_op_sar_i32, { "r", "r", "ri" } },
-    { INDEX_op_rotl_i32, { "r", "r", "ri" } },
-    { INDEX_op_rotr_i32, { "r", "r", "ri" } },
-    { INDEX_op_clz_i32, { "r", "r", "rIK" } },
-    { INDEX_op_ctz_i32, { "r", "r", "rIK" } },
-
-    { INDEX_op_brcond_i32, { "r", "rIN" } },
-    { INDEX_op_setcond_i32, { "r", "r", "rIN" } },
-    { INDEX_op_movcond_i32, { "r", "r", "rIN", "rIK", "0" } },
-
-    { INDEX_op_add2_i32, { "r", "r", "r", "r", "rIN", "rIK" } },
-    { INDEX_op_sub2_i32, { "r", "r", "rI", "rI", "rIN", "rIK" } },
-    { INDEX_op_brcond2_i32, { "r", "r", "rIN", "rIN" } },
-    { INDEX_op_setcond2_i32, { "r", "r", "r", "rIN", "rIN" } },
-
-#if TARGET_LONG_BITS == 32
-    { INDEX_op_qemu_ld_i32, { "r", "l" } },
-    { INDEX_op_qemu_ld_i64, { "r", "r", "l" } },
-    { INDEX_op_qemu_st_i32, { "s", "s" } },
-    { INDEX_op_qemu_st_i64, { "s", "s", "s" } },
-#else
-    { INDEX_op_qemu_ld_i32, { "r", "l", "l" } },
-    { INDEX_op_qemu_ld_i64, { "r", "r", "l", "l" } },
-    { INDEX_op_qemu_st_i32, { "s", "s", "s" } },
-    { INDEX_op_qemu_st_i64, { "s", "s", "s", "s" } },
-#endif
-
-    { INDEX_op_bswap16_i32, { "r", "r" } },
-    { INDEX_op_bswap32_i32, { "r", "r" } },
-
-    { INDEX_op_ext8s_i32, { "r", "r" } },
-    { INDEX_op_ext16s_i32, { "r", "r" } },
-    { INDEX_op_ext16u_i32, { "r", "r" } },
+static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
+{
+    static const TCGTargetOpDef r = { .args_ct_str = { "r" } };
+    static const TCGTargetOpDef r_r = { .args_ct_str = { "r", "r" } };
+    static const TCGTargetOpDef s_s = { .args_ct_str = { "s", "s" } };
+    static const TCGTargetOpDef r_l = { .args_ct_str = { "r", "l" } };
+    static const TCGTargetOpDef r_r_r = { .args_ct_str = { "r", "r", "r" } };
+    static const TCGTargetOpDef r_r_l = { .args_ct_str = { "r", "r", "l" } };
+    static const TCGTargetOpDef r_l_l = { .args_ct_str = { "r", "l", "l" } };
+    static const TCGTargetOpDef s_s_s = { .args_ct_str = { "s", "s", "s" } };
+    static const TCGTargetOpDef r_r_ri = { .args_ct_str = { "r", "r", "ri" } };
+    static const TCGTargetOpDef r_r_rI = { .args_ct_str = { "r", "r", "rI" } };
+    static const TCGTargetOpDef r_r_rIN
+        = { .args_ct_str = { "r", "r", "rIN" } };
+    static const TCGTargetOpDef r_r_rIK
+        = { .args_ct_str = { "r", "r", "rIK" } };
+    static const TCGTargetOpDef r_r_r_r
+        = { .args_ct_str = { "r", "r", "r", "r" } };
+    static const TCGTargetOpDef r_r_l_l
+        = { .args_ct_str = { "r", "r", "l", "l" } };
+    static const TCGTargetOpDef s_s_s_s
+        = { .args_ct_str = { "s", "s", "s", "s" } };
+    static const TCGTargetOpDef br
+        = { .args_ct_str = { "r", "rIN" } };
+    static const TCGTargetOpDef dep
+        = { .args_ct_str = { "r", "0", "rZ" } };
+    static const TCGTargetOpDef movc
+        = { .args_ct_str = { "r", "r", "rIN", "rIK", "0" } };
+    static const TCGTargetOpDef add2
+        = { .args_ct_str = { "r", "r", "r", "r", "rIN", "rIK" } };
+    static const TCGTargetOpDef sub2
+        = { .args_ct_str = { "r", "r", "rI", "rI", "rIN", "rIK" } };
+    static const TCGTargetOpDef br2
+        = { .args_ct_str = { "r", "r", "rIN", "rIN" } };
+    static const TCGTargetOpDef setc2
+        = { .args_ct_str = { "r", "r", "r", "rIN", "rIN" } };
+
+    switch (op) {
+    case INDEX_op_goto_ptr:
+        return &r;
 
-    { INDEX_op_deposit_i32, { "r", "0", "rZ" } },
-    { INDEX_op_extract_i32, { "r", "r" } },
-    { INDEX_op_sextract_i32, { "r", "r" } },
+    case INDEX_op_ld8u_i32:
+    case INDEX_op_ld8s_i32:
+    case INDEX_op_ld16u_i32:
+    case INDEX_op_ld16s_i32:
+    case INDEX_op_ld_i32:
+    case INDEX_op_st8_i32:
+    case INDEX_op_st16_i32:
+    case INDEX_op_st_i32:
+    case INDEX_op_neg_i32:
+    case INDEX_op_not_i32:
+    case INDEX_op_bswap16_i32:
+    case INDEX_op_bswap32_i32:
+    case INDEX_op_ext8s_i32:
+    case INDEX_op_ext16s_i32:
+    case INDEX_op_ext16u_i32:
+    case INDEX_op_extract_i32:
+    case INDEX_op_sextract_i32:
+        return &r_r;
 
-    { INDEX_op_div_i32, { "r", "r", "r" } },
-    { INDEX_op_divu_i32, { "r", "r", "r" } },
+    case INDEX_op_add_i32:
+    case INDEX_op_sub_i32:
+    case INDEX_op_setcond_i32:
+        return &r_r_rIN;
+    case INDEX_op_and_i32:
+    case INDEX_op_andc_i32:
+    case INDEX_op_clz_i32:
+    case INDEX_op_ctz_i32:
+        return &r_r_rIK;
+    case INDEX_op_mul_i32:
+    case INDEX_op_div_i32:
+    case INDEX_op_divu_i32:
+        return &r_r_r;
+    case INDEX_op_mulu2_i32:
+    case INDEX_op_muls2_i32:
+        return &r_r_r_r;
+    case INDEX_op_or_i32:
+    case INDEX_op_xor_i32:
+        return &r_r_rI;
+    case INDEX_op_shl_i32:
+    case INDEX_op_shr_i32:
+    case INDEX_op_sar_i32:
+    case INDEX_op_rotl_i32:
+    case INDEX_op_rotr_i32:
+        return &r_r_ri;
 
-    { INDEX_op_mb, { } },
-    { -1 },
-};
+    case INDEX_op_brcond_i32:
+        return &br;
+    case INDEX_op_deposit_i32:
+        return &dep;
+    case INDEX_op_movcond_i32:
+        return &movc;
+    case INDEX_op_add2_i32:
+        return &add2;
+    case INDEX_op_sub2_i32:
+        return &sub2;
+    case INDEX_op_brcond2_i32:
+        return &br2;
+    case INDEX_op_setcond2_i32:
+        return &setc2;
 
-static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
-{
-    int i, n = ARRAY_SIZE(arm_op_defs);
+    case INDEX_op_qemu_ld_i32:
+        return TARGET_LONG_BITS == 32 ? &r_l : &r_l_l;
+    case INDEX_op_qemu_ld_i64:
+        return TARGET_LONG_BITS == 32 ? &r_r_l : &r_r_l_l;
+    case INDEX_op_qemu_st_i32:
+        return TARGET_LONG_BITS == 32 ? &s_s : &s_s_s;
+    case INDEX_op_qemu_st_i64:
+        return TARGET_LONG_BITS == 32 ? &s_s_s : &s_s_s_s;
 
-    for (i = 0; i < n; ++i) {
-        if (arm_op_defs[i].op == op) {
-            return &arm_op_defs[i];
-        }
+    default:
+        return NULL;
     }
-    return NULL;
 }
 
 static void tcg_target_init(TCGContext *s)
-- 
2.13.5
