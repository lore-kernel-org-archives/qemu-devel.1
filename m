Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9C9C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:23:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 573A02073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LTfocQDJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573A02073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmaO-0004sM-Hy
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKm-0005Hl-KI
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:04 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a]:33646)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKj-00063e-Gz
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:04 -0400
Received: by mail-pj1-x102a.google.com with SMTP id np15so179866pjb.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EI+R+4tP0x4knj3otgEq+jCMs+pFcf+NyvuwzVQpXIE=;
 b=LTfocQDJ5u07X2Wa1qppcpeAo9gjdFJZotwqEDmCYgSXk7VXF1aP5+O5+0Y8vHN1Ie
 sI8upcUbTY0yNb3f2AlTRRIMztnxHUg3LZNbZzD3dRqsslvYe1gDNIlooVjwW8B2LTUY
 aq/akQXn7GuAT72sxUS3jZNLV4IxdFrVYmyx8jcLe+qCqurIZHVrH7xiST8xRhHW3GuS
 oRBdZHw+6X12VZDJcEDPPIwjZMueY9chw/SgNNNB7X+iziz7S6b6KnWIeiN8GhC3drKn
 4ulINwb8D2ByUsCJs2hpHltpA2gOCGdHKaS9aDCcWTD1X81IduchM7IEjqBjdn/BJBfW
 WY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EI+R+4tP0x4knj3otgEq+jCMs+pFcf+NyvuwzVQpXIE=;
 b=aMBAu3LPizcO0gChoe1D2Os1RZlawMuiyO/AQnk6kfBXqSNon+SOgydxeXf6yYZgSb
 A1vDwIs95BzBLSSTTULNxuUYh+ceTfWjm/lWjorKMi4h2JKBJEiiWlfiWdQEwfHzQwWy
 UPK1wQz8o/LYZl/jlqeg1CclhGaS0wQbiEpgg5XBU/CEGORsNfKMurHo9eMl0kq4rV9S
 9Y0MBh2dHEpnFgnkpOcqlj2XFvOD1Zj47hm7XpfOXzaMnvERfJ6UFZmtpVP1xZm3tAj3
 BERJ9PHXcxm+pXQjDfRxVuDCSlCx2Hu/B58FOtBul0iyhuP5WuxtUdznr3LVfO0L1sWE
 XKEg==
X-Gm-Message-State: AOAM532CJ4VXzEiq8I4lU2lzX/bVVFEVd1nfSb3OHbKGKQMPJUwDITR5
 o9cgsMzAvzrSO7BX7DdVWyR7IZ5NgTI/fQ==
X-Google-Smtp-Source: ABdhPJxSQ4hkTbCVwdXWubraq1s8aFldA8QMjrXDszXZAdNcazg0Cy2QxvNeIIZ4boI6u8vKAtMc+g==
X-Received: by 2002:a17:90a:384c:: with SMTP id l12mr73115pjf.27.1598890019651; 
 Mon, 31 Aug 2020 09:06:59 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:06:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/76] target/microblaze: Convert dec_mul to decodetree
Date: Mon, 31 Aug 2020 09:05:26 -0700
Message-Id: <20200831160601.833692-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/insns.decode |  6 +++
 target/microblaze/translate.c  | 77 ++++++++++++++--------------------
 2 files changed, 37 insertions(+), 46 deletions(-)

diff --git a/target/microblaze/insns.decode b/target/microblaze/insns.decode
index 93bd51c78b..1a2e22e44a 100644
--- a/target/microblaze/insns.decode
+++ b/target/microblaze/insns.decode
@@ -50,6 +50,12 @@ andni           101011 ..... ..... ................     @typeb
 cmp             000101 ..... ..... ..... 000 0000 0001  @typea
 cmpu            000101 ..... ..... ..... 000 0000 0011  @typea
 
+mul             010000 ..... ..... ..... 000 0000 0000  @typea
+mulh            010000 ..... ..... ..... 000 0000 0001  @typea
+mulhu           010000 ..... ..... ..... 000 0000 0011  @typea
+mulhsu          010000 ..... ..... ..... 000 0000 0010  @typea
+muli            011000 ..... ..... ................     @typeb
+
 or              100000 ..... ..... ..... 000 0000 0000  @typea
 ori             101000 ..... ..... ................     @typeb
 
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index a143f17e9d..617e208583 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -287,6 +287,10 @@ static bool do_typeb_val(DisasContext *dc, arg_typeb *arg, bool side_effects,
     static bool trans_##NAME(DisasContext *dc, arg_typeb *a) \
     { return do_typeb_imm(dc, a, SE, FNI); }
 
+#define DO_TYPEBI_CFG(NAME, CFG, SE, FNI) \
+    static bool trans_##NAME(DisasContext *dc, arg_typeb *a) \
+    { return dc->cpu->cfg.CFG && do_typeb_imm(dc, a, SE, FNI); }
+
 #define DO_TYPEBV(NAME, SE, FN) \
     static bool trans_##NAME(DisasContext *dc, arg_typeb *a) \
     { return do_typeb_val(dc, a, SE, FN); }
@@ -364,6 +368,33 @@ static void gen_cmpu(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 DO_TYPEA(cmp, false, gen_cmp)
 DO_TYPEA(cmpu, false, gen_cmpu)
 
+static void gen_mulh(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
+{
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    tcg_gen_muls2_i32(tmp, out, ina, inb);
+    tcg_temp_free_i32(tmp);
+}
+
+static void gen_mulhu(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
+{
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    tcg_gen_mulu2_i32(tmp, out, ina, inb);
+    tcg_temp_free_i32(tmp);
+}
+
+static void gen_mulhsu(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
+{
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    tcg_gen_mulsu2_i32(tmp, out, ina, inb);
+    tcg_temp_free_i32(tmp);
+}
+
+DO_TYPEA_CFG(mul, use_hw_mul, false, tcg_gen_mul_i32)
+DO_TYPEA_CFG(mulh, use_hw_mul >= 2, false, gen_mulh)
+DO_TYPEA_CFG(mulhu, use_hw_mul >= 2, false, gen_mulhu)
+DO_TYPEA_CFG(mulhsu, use_hw_mul >= 2, false, gen_mulhsu)
+DO_TYPEBI_CFG(muli, use_hw_mul, false, tcg_gen_muli_i32)
+
 DO_TYPEA(or, false, tcg_gen_or_i32)
 DO_TYPEBI(ori, false, tcg_gen_ori_i32)
 
@@ -652,51 +683,6 @@ static void dec_msr(DisasContext *dc)
     }
 }
 
-/* Multiplier unit.  */
-static void dec_mul(DisasContext *dc)
-{
-    TCGv_i32 tmp;
-    unsigned int subcode;
-
-    if (trap_illegal(dc, !dc->cpu->cfg.use_hw_mul)) {
-        return;
-    }
-
-    subcode = dc->imm & 3;
-
-    if (dc->type_b) {
-        tcg_gen_mul_i32(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
-        return;
-    }
-
-    /* mulh, mulhsu and mulhu are not available if C_USE_HW_MUL is < 2.  */
-    if (subcode >= 1 && subcode <= 3 && dc->cpu->cfg.use_hw_mul < 2) {
-        /* nop??? */
-    }
-
-    tmp = tcg_temp_new_i32();
-    switch (subcode) {
-        case 0:
-            tcg_gen_mul_i32(cpu_R[dc->rd], cpu_R[dc->ra], cpu_R[dc->rb]);
-            break;
-        case 1:
-            tcg_gen_muls2_i32(tmp, cpu_R[dc->rd],
-                              cpu_R[dc->ra], cpu_R[dc->rb]);
-            break;
-        case 2:
-            tcg_gen_mulsu2_i32(tmp, cpu_R[dc->rd],
-                               cpu_R[dc->ra], cpu_R[dc->rb]);
-            break;
-        case 3:
-            tcg_gen_mulu2_i32(tmp, cpu_R[dc->rd], cpu_R[dc->ra], cpu_R[dc->rb]);
-            break;
-        default:
-            cpu_abort(CPU(dc->cpu), "unknown MUL insn %x\n", subcode);
-            break;
-    }
-    tcg_temp_free_i32(tmp);
-}
-
 /* Div unit.  */
 static void dec_div(DisasContext *dc)
 {
@@ -1579,7 +1565,6 @@ static struct decoder_info {
     {DEC_BCC, dec_bcc},
     {DEC_RTS, dec_rts},
     {DEC_FPU, dec_fpu},
-    {DEC_MUL, dec_mul},
     {DEC_DIV, dec_div},
     {DEC_MSR, dec_msr},
     {DEC_STREAM, dec_stream},
-- 
2.25.1


