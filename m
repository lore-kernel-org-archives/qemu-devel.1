Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D05C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:25:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A41FC20449
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UMnStrVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41FC20449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cmG-0006rA-WD
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52901)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5c9d-0006Je-UJ
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5c9b-0006sI-Dg
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:25 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:36736)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5c9b-0006rb-4w
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:23 -0400
Received: by mail-pf1-x430.google.com with SMTP id y22so42968pfr.3
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=slEwt35AByzjU9Ubr6zMEmDVhlGjx8ZzwD/PYybphKw=;
 b=UMnStrVYvd/RNYanNLDF9REk42LeewIj8RBhxFMm9wS+KyxQXrllGOm/d7j+khGdLg
 dPbbRfM+mqAjUsJzOQ8HOrZHxnlo4VMvUlFc7ju/SfaQ3FuDCt4d6cpJ0qKL84GKPOc9
 INq0MxB/BJENzLalp6LH7QTtPhz9QPksOOaViLI+gO/Lf/swUphHGUqptg7Qsgj56BZF
 qeVnN0WsCKz3jwM9M648Vj4WYIYPnMEQU6f7fA0zLgbAsxnKGLZlXwaVR2PK0JDlHTgZ
 MRClU4ITUO+s2WhBE3PwfU4pBOqQ4wCQyXJliw+IGVnMDI7Jx5t9Es7lDIYZ1WAmfKS+
 uaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=slEwt35AByzjU9Ubr6zMEmDVhlGjx8ZzwD/PYybphKw=;
 b=eSF20GWxQknqJ217zn8c32mqd2CGA+2HxjgycFceHZRMvIke5uTLcxWNJSUeLsP0J8
 iaHnkwsJXCF8N6OFHuWoW6HNwytivk+qsvCydNwpj6s9FLoBjVdZ32LU2JLqaAJSMwO+
 DuDWF4moFz457ya3zoSF3ALY9Bf4Wej0NhcGXJRY62LZapK3Wm/G71e8t26AgPz60urj
 w/zC1MQhkqNDsW0JZHksExzL5veEprncOggJBnhd7hTqeHc577PHXfcDHcQ71k28nztD
 UxFhVN2399GU+rVxg6HydhO+hg/cLjEmbQH/8dDjL8tBz51wXaNCGyZ5I27z3G/yhWnN
 NQAA==
X-Gm-Message-State: APjAAAWg3JJpQ7jP0S01NtR7HR9BNkddlsFmDxy5s9FkdUhr9dRP0ITf
 w4OQlOiboxBpPLSZhDnzPP7rKunOWIc=
X-Google-Smtp-Source: APXvYqyyA0nIi9efCgUCgecygo2myZ3ti58mF5EZbcBFW6PnwpSrP4aFvHTyEhdB6avFnLMV7AAbqg==
X-Received: by 2002:aa7:93a8:: with SMTP id x8mr15781391pff.151.1567629921841; 
 Wed, 04 Sep 2019 13:45:21 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id n66sm8104610pfn.90.2019.09.04.13.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:45:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 13:45:04 -0700
Message-Id: <20190904204507.32457-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904204507.32457-1-richard.henderson@linaro.org>
References: <20190904204507.32457-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::430
Subject: [Qemu-devel] [PULL 10/13] target/openrisc: Implement unordered fp
 comparisons
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These were added to the 1.3 spec.  For OF32S, validate AVR.
But OF64A32 is itself new to 1.3 so no extra check needed.

Reviewed-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/helper.h     |  4 ++
 target/openrisc/disas.c      | 24 ++++++++++
 target/openrisc/fpu_helper.c | 20 +++++++++
 target/openrisc/translate.c  | 85 ++++++++++++++++++++++++++++++++++++
 target/openrisc/insns.decode | 12 +++++
 5 files changed, 145 insertions(+)

diff --git a/target/openrisc/helper.h b/target/openrisc/helper.h
index 94b823580e..d847814a28 100644
--- a/target/openrisc/helper.h
+++ b/target/openrisc/helper.h
@@ -52,6 +52,10 @@ DEF_HELPER_FLAGS_3(float_ ## op ## _d, TCG_CALL_NO_RWG, tl, env, i64, i64)
 FOP_CMP(eq)
 FOP_CMP(lt)
 FOP_CMP(le)
+FOP_CMP(un)
+FOP_CMP(ueq)
+FOP_CMP(ule)
+FOP_CMP(ult)
 #undef FOP_CMP
 
 /* interrupt */
diff --git a/target/openrisc/disas.c b/target/openrisc/disas.c
index 4de5c632de..e51cbb24c6 100644
--- a/target/openrisc/disas.c
+++ b/target/openrisc/disas.c
@@ -166,6 +166,12 @@ FP_INSN(sfgt, s, "r%d, r%d", a->a, a->b)
 FP_INSN(sfge, s, "r%d, r%d", a->a, a->b)
 FP_INSN(sflt, s, "r%d, r%d", a->a, a->b)
 FP_INSN(sfle, s, "r%d, r%d", a->a, a->b)
+FP_INSN(sfun, s, "r%d, r%d", a->a, a->b)
+FP_INSN(sfueq, s, "r%d, r%d", a->a, a->b)
+FP_INSN(sfuge, s, "r%d, r%d", a->a, a->b)
+FP_INSN(sfugt, s, "r%d, r%d", a->a, a->b)
+FP_INSN(sfule, s, "r%d, r%d", a->a, a->b)
+FP_INSN(sfult, s, "r%d, r%d", a->a, a->b)
 
 FP_INSN(add, d,  "r%d,r%d, r%d,r%d, r%d,r%d",
         a->d, a->d + a->dp + 1,
@@ -222,3 +228,21 @@ FP_INSN(sflt, d, "r%d,r%d, r%d,r%d",
 FP_INSN(sfle, d, "r%d,r%d, r%d,r%d",
         a->a, a->a + a->ap + 1,
         a->b, a->b + a->bp + 1)
+FP_INSN(sfun, d, "r%d,r%d, r%d,r%d",
+        a->a, a->a + a->ap + 1,
+        a->b, a->b + a->bp + 1)
+FP_INSN(sfueq, d, "r%d,r%d, r%d,r%d",
+        a->a, a->a + a->ap + 1,
+        a->b, a->b + a->bp + 1)
+FP_INSN(sfuge, d, "r%d,r%d, r%d,r%d",
+        a->a, a->a + a->ap + 1,
+        a->b, a->b + a->bp + 1)
+FP_INSN(sfugt, d, "r%d,r%d, r%d,r%d",
+        a->a, a->a + a->ap + 1,
+        a->b, a->b + a->bp + 1)
+FP_INSN(sfule, d, "r%d,r%d, r%d,r%d",
+        a->a, a->a + a->ap + 1,
+        a->b, a->b + a->bp + 1)
+FP_INSN(sfult, d, "r%d,r%d, r%d,r%d",
+        a->a, a->a + a->ap + 1,
+        a->b, a->b + a->bp + 1)
diff --git a/target/openrisc/fpu_helper.c b/target/openrisc/fpu_helper.c
index 9d7dfc0fb9..7bcef9dc53 100644
--- a/target/openrisc/fpu_helper.c
+++ b/target/openrisc/fpu_helper.c
@@ -135,4 +135,24 @@ target_ulong helper_float_ ## name ## _s(CPUOpenRISCState *env,           \
 FLOAT_CMP(le, le)
 FLOAT_CMP(lt, lt)
 FLOAT_CMP(eq, eq_quiet)
+FLOAT_CMP(un, unordered_quiet)
 #undef FLOAT_CMP
+
+#define FLOAT_UCMP(name, expr) \
+target_ulong helper_float_ ## name ## _d(CPUOpenRISCState *env,           \
+                                         uint64_t fdt0, uint64_t fdt1)    \
+{                                                                         \
+    int r = float64_compare_quiet(fdt0, fdt1, &env->fp_status);           \
+    return expr;                                                          \
+}                                                                         \
+target_ulong helper_float_ ## name ## _s(CPUOpenRISCState *env,           \
+                                         uint32_t fdt0, uint32_t fdt1)    \
+{                                                                         \
+    int r = float32_compare_quiet(fdt0, fdt1, &env->fp_status);           \
+    return expr;                                                          \
+}
+
+FLOAT_UCMP(ueq, r == float_relation_equal || r == float_relation_unordered)
+FLOAT_UCMP(ult, r == float_relation_less || r == float_relation_unordered)
+FLOAT_UCMP(ule, r != float_relation_greater)
+#undef FLOAT_UCMP
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index b8ef485903..6e8bc23568 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -46,6 +46,7 @@ typedef struct DisasContext {
     uint32_t tb_flags;
     uint32_t delayed_branch;
     uint32_t cpucfgr;
+    uint32_t avr;
 
     /* If not -1, jmp_pc contains this value and so is a direct jump.  */
     target_ulong jmp_pc_imm;
@@ -141,6 +142,11 @@ static void gen_illegal_exception(DisasContext *dc)
     dc->base.is_jmp = DISAS_NORETURN;
 }
 
+static bool check_v1_3(DisasContext *dc)
+{
+    return dc->avr >= 0x01030000;
+}
+
 static bool check_of32s(DisasContext *dc)
 {
     return dc->cpucfgr & CPUCFGR_OF32S;
@@ -1265,6 +1271,54 @@ static bool trans_lf_sfle_s(DisasContext *dc, arg_ab *a)
     return do_fpcmp(dc, a, gen_helper_float_le_s, false, false);
 }
 
+static bool trans_lf_sfueq_s(DisasContext *dc, arg_ab *a)
+{
+    if (!check_v1_3(dc)) {
+        return false;
+    }
+    return do_fpcmp(dc, a, gen_helper_float_ueq_s, false, false);
+}
+
+static bool trans_lf_sfult_s(DisasContext *dc, arg_ab *a)
+{
+    if (!check_v1_3(dc)) {
+        return false;
+    }
+    return do_fpcmp(dc, a, gen_helper_float_ult_s, false, false);
+}
+
+static bool trans_lf_sfugt_s(DisasContext *dc, arg_ab *a)
+{
+    if (!check_v1_3(dc)) {
+        return false;
+    }
+    return do_fpcmp(dc, a, gen_helper_float_ult_s, false, true);
+}
+
+static bool trans_lf_sfule_s(DisasContext *dc, arg_ab *a)
+{
+    if (!check_v1_3(dc)) {
+        return false;
+    }
+    return do_fpcmp(dc, a, gen_helper_float_ule_s, false, false);
+}
+
+static bool trans_lf_sfuge_s(DisasContext *dc, arg_ab *a)
+{
+    if (!check_v1_3(dc)) {
+        return false;
+    }
+    return do_fpcmp(dc, a, gen_helper_float_ule_s, false, true);
+}
+
+static bool trans_lf_sfun_s(DisasContext *dc, arg_ab *a)
+{
+    if (!check_v1_3(dc)) {
+        return false;
+    }
+    return do_fpcmp(dc, a, gen_helper_float_un_s, false, false);
+}
+
 static bool check_pair(DisasContext *dc, int r, int p)
 {
     return r + 1 + p < 32;
@@ -1490,6 +1544,36 @@ static bool trans_lf_sfle_d(DisasContext *dc, arg_ab_pair *a)
     return do_dpcmp(dc, a, gen_helper_float_le_d, false, false);
 }
 
+static bool trans_lf_sfueq_d(DisasContext *dc, arg_ab_pair *a)
+{
+    return do_dpcmp(dc, a, gen_helper_float_ueq_d, false, false);
+}
+
+static bool trans_lf_sfule_d(DisasContext *dc, arg_ab_pair *a)
+{
+    return do_dpcmp(dc, a, gen_helper_float_ule_d, false, false);
+}
+
+static bool trans_lf_sfuge_d(DisasContext *dc, arg_ab_pair *a)
+{
+    return do_dpcmp(dc, a, gen_helper_float_ule_d, false, true);
+}
+
+static bool trans_lf_sfult_d(DisasContext *dc, arg_ab_pair *a)
+{
+    return do_dpcmp(dc, a, gen_helper_float_ult_d, false, false);
+}
+
+static bool trans_lf_sfugt_d(DisasContext *dc, arg_ab_pair *a)
+{
+    return do_dpcmp(dc, a, gen_helper_float_ult_d, false, true);
+}
+
+static bool trans_lf_sfun_d(DisasContext *dc, arg_ab_pair *a)
+{
+    return do_dpcmp(dc, a, gen_helper_float_un_d, false, false);
+}
+
 static void openrisc_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
 {
     DisasContext *dc = container_of(dcb, DisasContext, base);
@@ -1500,6 +1584,7 @@ static void openrisc_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
     dc->tb_flags = dc->base.tb->flags;
     dc->delayed_branch = (dc->tb_flags & TB_FLAGS_DFLAG) != 0;
     dc->cpucfgr = env->cpucfgr;
+    dc->avr = env->avr;
     dc->jmp_pc_imm = -1;
 
     bound = -(dc->base.pc_first | TARGET_PAGE_MASK) / 4;
diff --git a/target/openrisc/insns.decode b/target/openrisc/insns.decode
index 334d4e9668..71e0d740db 100644
--- a/target/openrisc/insns.decode
+++ b/target/openrisc/insns.decode
@@ -190,6 +190,12 @@ lf_sfgt_s       110010 ----- a:5 b:5 --- 00001010
 lf_sfge_s       110010 ----- a:5 b:5 --- 00001011
 lf_sflt_s       110010 ----- a:5 b:5 --- 00001100
 lf_sfle_s       110010 ----- a:5 b:5 --- 00001101
+lf_sfueq_s      110010 ----- a:5 b:5 --- 00101000
+lf_sfuge_s      110010 ----- a:5 b:5 --- 00101011
+lf_sfugt_s      110010 ----- a:5 b:5 --- 00101010
+lf_sfule_s      110010 ----- a:5 b:5 --- 00101101
+lf_sfult_s      110010 ----- a:5 b:5 --- 00101100
+lf_sfun_s       110010 ----- a:5 b:5 --- 00101110
 
 ####
 # DP Instructions
@@ -218,3 +224,9 @@ lf_sfgt_d       110010 00000 ..... ..... 0.. 00011010  @ab_pair
 lf_sfge_d       110010 00000 ..... ..... 0.. 00011011  @ab_pair
 lf_sflt_d       110010 00000 ..... ..... 0.. 00011100  @ab_pair
 lf_sfle_d       110010 00000 ..... ..... 0.. 00011101  @ab_pair
+lf_sfueq_d      110010 00000 ..... ..... 0.. 00111000  @ab_pair
+lf_sfuge_d      110010 00000 ..... ..... 0.. 00111011  @ab_pair
+lf_sfugt_d      110010 00000 ..... ..... 0.. 00111010  @ab_pair
+lf_sfule_d      110010 00000 ..... ..... 0.. 00111101  @ab_pair
+lf_sfult_d      110010 00000 ..... ..... 0.. 00111100  @ab_pair
+lf_sfun_d       110010 00000 ..... ..... 0.. 00111110  @ab_pair
-- 
2.17.1


