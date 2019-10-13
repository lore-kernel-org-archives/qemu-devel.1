Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FE7C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:47:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8B66206A3
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BS9LjwFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B66206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJmdJ-00048S-Bf
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 18:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJT-0006vF-22
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJR-0000yN-Dj
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:06 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:36555)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iJmJR-0000x7-6E
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:05 -0400
Received: by mail-pf1-x42d.google.com with SMTP id y22so9268872pfr.3
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 15:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/W5+06zWjEsCCO8DDCnAnC5YfhRA72tGQm0aAGdzZVE=;
 b=BS9LjwFYgXGpWLGoIh1Zw6GlJx0Xj5kUHrpiH4HWdF4qJg86DM39D+g5AD5spO6AQO
 MB7NOP95T45Nt8DylAohCC4DLAMMbfL32M69SKlC3x4ESNGleZOHfgQJCGsx+o924ePG
 O6uUaBXlCOVBk+OMx7R3TnOfzg0tIF063+anlTrJy2JJsNl2hx/g6lBJevL4HGreEgVN
 fwtZQgK2ilOYdtkQRh6ee8raLdT82pirOY+mrcZuE8aKut1ZoTqyYGXZ2pnEKzc7N6/z
 eufhpQk5VW8xEoE/J0jqohIwkeAZHTEHxq6mOov2nfh2uiX3bTuXhuRmystAfOhDw4tg
 cu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/W5+06zWjEsCCO8DDCnAnC5YfhRA72tGQm0aAGdzZVE=;
 b=hifZ2Lr2qKCo/zXGgvkweo8vuFfNbR+vW0LVhh2XYCzETXeuPGODqQcKmm+dn/9EjF
 0QzdpogBGA1wWIUAV1K0IlfrrWyDiTqAOCWQ+kSpqXEDHssdnUenCQcV2MhiO6r1gUCU
 o/ynAhiMQDdJIxSTkyAXzcSCYqjF/qkn5l1I4PUAdDX7uH+2u1rR0yYyW7b6t36fdB+B
 5mJ0ymCrMbjwKSeP2gt8spokHJy1cfK1uKtdeOXMSZO9XQzrVzFt2x7Vlm0D6vMVuM0a
 Z1K7l/tMYkwjjfQJPKT/rF24kN1AMMLVPn0M0FjnDw4hfVDx1Vt5Q6kQaOfWLIvi9Po7
 2JNA==
X-Gm-Message-State: APjAAAUcxGC9m213hf1pyUPANizUnPeHveZRzCV5Dst3ss4nhxqu+JiX
 MZVb1Egn5gBeOeTQnAQMR8VNY9V4d6I=
X-Google-Smtp-Source: APXvYqzGCBUo+0JdFv82aq/Gz5sd6wbspKlxrJl8iasKmTQ5INq6hT6yn40lWzIHinPEI+5sIIimwQ==
X-Received: by 2002:a17:90a:d991:: with SMTP id
 d17mr17690670pjv.73.1571005563790; 
 Sun, 13 Oct 2019 15:26:03 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d76sm15940571pfd.185.2019.10.13.15.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2019 15:26:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/23] tcg/ppc: Support vector multiply
Date: Sun, 13 Oct 2019 15:25:34 -0700
Message-Id: <20191013222544.3679-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191013222544.3679-1-richard.henderson@linaro.org>
References: <20191013222544.3679-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42d
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For Altivec, this is always an expansion.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tcg/ppc/tcg-target.h     |   2 +-
 tcg/ppc/tcg-target.opc.h |   8 +++
 tcg/ppc/tcg-target.inc.c | 113 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 121 insertions(+), 2 deletions(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index ffb226946b..f50b7f4bac 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -162,7 +162,7 @@ extern bool have_altivec;
 #define TCG_TARGET_HAS_shs_vec          0
 #define TCG_TARGET_HAS_shv_vec          1
 #define TCG_TARGET_HAS_cmp_vec          1
-#define TCG_TARGET_HAS_mul_vec          0
+#define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       0
diff --git a/tcg/ppc/tcg-target.opc.h b/tcg/ppc/tcg-target.opc.h
index fa680dd6a0..db24a11987 100644
--- a/tcg/ppc/tcg-target.opc.h
+++ b/tcg/ppc/tcg-target.opc.h
@@ -3,3 +3,11 @@
  * emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
  * consider these to be UNSPEC with names.
  */
+
+DEF(ppc_mrgh_vec, 1, 2, 0, IMPLVEC)
+DEF(ppc_mrgl_vec, 1, 2, 0, IMPLVEC)
+DEF(ppc_msum_vec, 1, 3, 0, IMPLVEC)
+DEF(ppc_muleu_vec, 1, 2, 0, IMPLVEC)
+DEF(ppc_mulou_vec, 1, 2, 0, IMPLVEC)
+DEF(ppc_pkum_vec, 1, 2, 0, IMPLVEC)
+DEF(ppc_rotl_vec, 1, 2, 0, IMPLVEC)
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index a9264eccbe..d4b3354626 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -523,6 +523,25 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define VSRAB      VX4(772)
 #define VSRAH      VX4(836)
 #define VSRAW      VX4(900)
+#define VRLB       VX4(4)
+#define VRLH       VX4(68)
+#define VRLW       VX4(132)
+
+#define VMULEUB    VX4(520)
+#define VMULEUH    VX4(584)
+#define VMULOUB    VX4(8)
+#define VMULOUH    VX4(72)
+#define VMSUMUHM   VX4(38)
+
+#define VMRGHB     VX4(12)
+#define VMRGHH     VX4(76)
+#define VMRGHW     VX4(140)
+#define VMRGLB     VX4(268)
+#define VMRGLH     VX4(332)
+#define VMRGLW     VX4(396)
+
+#define VPKUHUM    VX4(14)
+#define VPKUWUM    VX4(78)
 
 #define VAND       VX4(1028)
 #define VANDC      VX4(1092)
@@ -2875,6 +2894,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_sarv_vec:
         return vece <= MO_32;
     case INDEX_op_cmp_vec:
+    case INDEX_op_mul_vec:
     case INDEX_op_shli_vec:
     case INDEX_op_shri_vec:
     case INDEX_op_sari_vec:
@@ -2987,7 +3007,13 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         smax_op[4] = { VMAXSB, VMAXSH, VMAXSW, 0 },
         shlv_op[4] = { VSLB, VSLH, VSLW, 0 },
         shrv_op[4] = { VSRB, VSRH, VSRW, 0 },
-        sarv_op[4] = { VSRAB, VSRAH, VSRAW, 0 };
+        sarv_op[4] = { VSRAB, VSRAH, VSRAW, 0 },
+        mrgh_op[4] = { VMRGHB, VMRGHH, VMRGHW, 0 },
+        mrgl_op[4] = { VMRGLB, VMRGLH, VMRGLW, 0 },
+        muleu_op[4] = { VMULEUB, VMULEUH, 0, 0 },
+        mulou_op[4] = { VMULOUB, VMULOUH, 0, 0 },
+        pkum_op[4] = { VPKUHUM, VPKUWUM, 0, 0 },
+        rotl_op[4] = { VRLB, VRLH, VRLW, 0 };
 
     TCGType type = vecl + TCG_TYPE_V64;
     TCGArg a0 = args[0], a1 = args[1], a2 = args[2];
@@ -3076,6 +3102,29 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
+    case INDEX_op_ppc_mrgh_vec:
+        insn = mrgh_op[vece];
+        break;
+    case INDEX_op_ppc_mrgl_vec:
+        insn = mrgl_op[vece];
+        break;
+    case INDEX_op_ppc_muleu_vec:
+        insn = muleu_op[vece];
+        break;
+    case INDEX_op_ppc_mulou_vec:
+        insn = mulou_op[vece];
+        break;
+    case INDEX_op_ppc_pkum_vec:
+        insn = pkum_op[vece];
+        break;
+    case INDEX_op_ppc_rotl_vec:
+        insn = rotl_op[vece];
+        break;
+    case INDEX_op_ppc_msum_vec:
+        tcg_debug_assert(vece == MO_16);
+        tcg_out32(s, VMSUMUHM | VRT(a0) | VRA(a1) | VRB(a2) | VRC(args[3]));
+        return;
+
     case INDEX_op_mov_vec:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_dupi_vec: /* Always emitted via tcg_out_movi.  */
     case INDEX_op_dup_vec:  /* Always emitted via tcg_out_dup_vec.  */
@@ -3145,6 +3194,53 @@ static void expand_vec_cmp(TCGType type, unsigned vece, TCGv_vec v0,
     }
 }
 
+static void expand_vec_mul(TCGType type, unsigned vece, TCGv_vec v0,
+                           TCGv_vec v1, TCGv_vec v2)
+{
+    TCGv_vec t1 = tcg_temp_new_vec(type);
+    TCGv_vec t2 = tcg_temp_new_vec(type);
+    TCGv_vec t3, t4;
+
+    switch (vece) {
+    case MO_8:
+    case MO_16:
+        vec_gen_3(INDEX_op_ppc_muleu_vec, type, vece, tcgv_vec_arg(t1),
+                  tcgv_vec_arg(v1), tcgv_vec_arg(v2));
+        vec_gen_3(INDEX_op_ppc_mulou_vec, type, vece, tcgv_vec_arg(t2),
+                  tcgv_vec_arg(v1), tcgv_vec_arg(v2));
+        vec_gen_3(INDEX_op_ppc_mrgh_vec, type, vece + 1, tcgv_vec_arg(v0),
+                  tcgv_vec_arg(t1), tcgv_vec_arg(t2));
+        vec_gen_3(INDEX_op_ppc_mrgl_vec, type, vece + 1, tcgv_vec_arg(t1),
+                  tcgv_vec_arg(t1), tcgv_vec_arg(t2));
+        vec_gen_3(INDEX_op_ppc_pkum_vec, type, vece, tcgv_vec_arg(v0),
+                  tcgv_vec_arg(v0), tcgv_vec_arg(t1));
+	break;
+
+    case MO_32:
+        t3 = tcg_temp_new_vec(type);
+        t4 = tcg_temp_new_vec(type);
+        tcg_gen_dupi_vec(MO_8, t4, -16);
+        vec_gen_3(INDEX_op_ppc_rotl_vec, type, MO_32, tcgv_vec_arg(t1),
+                  tcgv_vec_arg(v2), tcgv_vec_arg(t4));
+        vec_gen_3(INDEX_op_ppc_mulou_vec, type, MO_16, tcgv_vec_arg(t2),
+                  tcgv_vec_arg(v1), tcgv_vec_arg(v2));
+        tcg_gen_dupi_vec(MO_8, t3, 0);
+        vec_gen_4(INDEX_op_ppc_msum_vec, type, MO_16, tcgv_vec_arg(t3),
+                  tcgv_vec_arg(v1), tcgv_vec_arg(t1), tcgv_vec_arg(t3));
+        vec_gen_3(INDEX_op_shlv_vec, type, MO_32, tcgv_vec_arg(t3),
+                  tcgv_vec_arg(t3), tcgv_vec_arg(t4));
+        tcg_gen_add_vec(MO_32, v0, t2, t3);
+        tcg_temp_free_vec(t3);
+        tcg_temp_free_vec(t4);
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+    tcg_temp_free_vec(t1);
+    tcg_temp_free_vec(t2);
+}
+
 void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
                        TCGArg a0, ...)
 {
@@ -3171,6 +3267,10 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
         v2 = temp_tcgv_vec(arg_temp(a2));
         expand_vec_cmp(type, vece, v0, v1, v2, va_arg(va, TCGArg));
         break;
+    case INDEX_op_mul_vec:
+        v2 = temp_tcgv_vec(arg_temp(a2));
+        expand_vec_mul(type, vece, v0, v1, v2);
+        break;
     default:
         g_assert_not_reached();
     }
@@ -3217,6 +3317,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     static const TCGTargetOpDef v_r = { .args_ct_str = { "v", "r" } };
     static const TCGTargetOpDef v_v = { .args_ct_str = { "v", "v" } };
     static const TCGTargetOpDef v_v_v = { .args_ct_str = { "v", "v", "v" } };
+    static const TCGTargetOpDef v_v_v_v
+        = { .args_ct_str = { "v", "v", "v", "v" } };
 
     switch (op) {
     case INDEX_op_goto_ptr:
@@ -3354,6 +3456,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_add_vec:
     case INDEX_op_sub_vec:
+    case INDEX_op_mul_vec:
     case INDEX_op_and_vec:
     case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
@@ -3371,6 +3474,12 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_shlv_vec:
     case INDEX_op_shrv_vec:
     case INDEX_op_sarv_vec:
+    case INDEX_op_ppc_mrgh_vec:
+    case INDEX_op_ppc_mrgl_vec:
+    case INDEX_op_ppc_muleu_vec:
+    case INDEX_op_ppc_mulou_vec:
+    case INDEX_op_ppc_pkum_vec:
+    case INDEX_op_ppc_rotl_vec:
         return &v_v_v;
     case INDEX_op_not_vec:
     case INDEX_op_dup_vec:
@@ -3379,6 +3488,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_st_vec:
     case INDEX_op_dupm_vec:
         return &v_r;
+    case INDEX_op_ppc_msum_vec:
+        return &v_v_v_v;
 
     default:
         return NULL;
-- 
2.17.1


