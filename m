Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2686C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:24:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CEFE2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FNUYrMxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CEFE2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmbi-0008Oz-Li
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKk-0005Bh-79
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:02 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034]:52135)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKi-00063T-6t
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:01 -0400
Received: by mail-pj1-x1034.google.com with SMTP id ds1so31667pjb.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CI+VZXsPGJ7eYoplXgk1haktp6HN35hn5kbwRUCynbg=;
 b=FNUYrMxXNrbYjUdXjDPGKvnxeDDnfvKYOLGg4wCSHbkZIATRSpShcPWaPRY7nZFYcA
 FrHHLtfW1ThJJc6DUjxLpTaNBlxWGSemy/n/Og/QW9TwkxWGYnZyj16Nnfrc1Eao1038
 7Y909g33tEJJHk8XaYbYEgpflUsHGNBQ8z+tUZRICtP8oEdvHFizvAbD2GUCVMet/rOR
 p6j3TDA+3+Dzdlp1gQJcP3Qj8466xX37apf1CG4OWNfqby99u88JF9QVQX9dkdHU3/Sw
 Nk1EcQupoWjKEa76jEzvEHMi6hQNvgzYYH6GmbrlNiz+q97jYCmBYGJA/EOSFqUdxjkA
 7jRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CI+VZXsPGJ7eYoplXgk1haktp6HN35hn5kbwRUCynbg=;
 b=P47MfNyN5f131/XfGSDZspIzss6wgbdx5VNI+BZDuZp4Gry83OWdh4eZW3gexg+Jcv
 AbPz4NbVqMACgWAGCI8J+zevpKMlZTzNnM2BdBqFfpLyG8eU56rwcVEs/y4gB5IrDXmU
 m0OGwqTdPo6XaWCro0fSavob6X1yyIJMZ7xwQG9UAaPEU9vohGhO6VRoI2MAqdRwUuox
 PPE9ywCc9AwrT7Wtzq7p7CJmAKGesSGvoNmzb4Jx0zlcjjeYOX5vLK4H1gMgb49xf93g
 NMfmSjh0gHjD1qsxloUUi7Klvgdu4lXx2J/XVaiHbT98BDTF3ESjMsMJRIQsmCciLsr0
 hFbw==
X-Gm-Message-State: AOAM530LjsFSrm0SA3N3C69UvHMYtyJANY0hhSXvIN1oXT9eHG19yJFT
 uyWNdY/d5ebYFA8AAQ5hzP2sqc9y+3xMuQ==
X-Google-Smtp-Source: ABdhPJwbNx/ZLWgU/c7PAcQEKEEKSb+ib0FZht0W8jVwLaYj3b6UxGzsC31v2HDkx2eBl+lCa1QTpg==
X-Received: by 2002:a17:90a:744c:: with SMTP id o12mr71378pjk.63.1598890018299; 
 Mon, 31 Aug 2020 09:06:58 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:06:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/76] target/microblaze: Convert dec_and, dec_or,
 dec_xor to decodetree
Date: Mon, 31 Aug 2020 09:05:25 -0700
Message-Id: <20200831160601.833692-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
 target/microblaze/insns.decode | 12 +++++++++
 target/microblaze/translate.c  | 46 ++++++++++++----------------------
 2 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/target/microblaze/insns.decode b/target/microblaze/insns.decode
index 16519f05dc..93bd51c78b 100644
--- a/target/microblaze/insns.decode
+++ b/target/microblaze/insns.decode
@@ -41,9 +41,18 @@ addic           001010 ..... ..... ................     @typeb
 addik           001100 ..... ..... ................     @typeb
 addikc          001110 ..... ..... ................     @typeb
 
+and             100001 ..... ..... ..... 000 0000 0000  @typea
+andi            101001 ..... ..... ................     @typeb
+
+andn            100011 ..... ..... ..... 000 0000 0000  @typea
+andni           101011 ..... ..... ................     @typeb
+
 cmp             000101 ..... ..... ..... 000 0000 0001  @typea
 cmpu            000101 ..... ..... ..... 000 0000 0011  @typea
 
+or              100000 ..... ..... ..... 000 0000 0000  @typea
+ori             101000 ..... ..... ................     @typeb
+
 pcmpbf          100000 ..... ..... ..... 100 0000 0000  @typea
 pcmpeq          100010 ..... ..... ..... 100 0000 0000  @typea
 pcmpne          100011 ..... ..... ..... 100 0000 0000  @typea
@@ -57,3 +66,6 @@ rsubi           001001 ..... ..... ................     @typeb
 rsubic          001011 ..... ..... ................     @typeb
 rsubik          001101 ..... ..... ................     @typeb
 rsubikc         001111 ..... ..... ................     @typeb
+
+xor             100010 ..... ..... ..... 000 0000 0000  @typea
+xori            101010 ..... ..... ................     @typeb
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 7ebf0e1e7d..a143f17e9d 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -331,6 +331,16 @@ DO_TYPEBV(addic, true, gen_addc)
 DO_TYPEBI(addik, false, tcg_gen_addi_i32)
 DO_TYPEBV(addikc, true, gen_addkc)
 
+static void gen_andni(TCGv_i32 out, TCGv_i32 ina, int32_t imm)
+{
+    tcg_gen_andi_i32(out, ina, ~imm);
+}
+
+DO_TYPEA(and, false, tcg_gen_and_i32)
+DO_TYPEBI(andi, false, tcg_gen_andi_i32)
+DO_TYPEA(andn, false, tcg_gen_andc_i32)
+DO_TYPEBI(andni, false, gen_andni)
+
 static void gen_cmp(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 {
     TCGv_i32 lt = tcg_temp_new_i32();
@@ -354,6 +364,9 @@ static void gen_cmpu(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 DO_TYPEA(cmp, false, gen_cmp)
 DO_TYPEA(cmpu, false, gen_cmpu)
 
+DO_TYPEA(or, false, tcg_gen_or_i32)
+DO_TYPEBI(ori, false, tcg_gen_ori_i32)
+
 static void gen_pcmpeq(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 {
     tcg_gen_setcond_i32(TCG_COND_EQ, out, ina, inb);
@@ -417,6 +430,9 @@ DO_TYPEBV(rsubic, true, gen_rsubc)
 DO_TYPEBV(rsubik, false, gen_rsubk)
 DO_TYPEBV(rsubikc, true, gen_rsubkc)
 
+DO_TYPEA(xor, false, tcg_gen_xor_i32)
+DO_TYPEBI(xori, false, tcg_gen_xori_i32)
+
 static bool trans_zero(DisasContext *dc, arg_zero *arg)
 {
     /* If opcode_0_illegal, trap.  */
@@ -431,33 +447,6 @@ static bool trans_zero(DisasContext *dc, arg_zero *arg)
     return false;
 }
 
-static void dec_and(DisasContext *dc)
-{
-    unsigned int not;
-
-    not = dc->opcode & (1 << 1);
-
-    if (!dc->rd)
-        return;
-
-    if (not) {
-        tcg_gen_andc_i32(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
-    } else
-        tcg_gen_and_i32(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
-}
-
-static void dec_or(DisasContext *dc)
-{
-    if (dc->rd)
-        tcg_gen_or_i32(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
-}
-
-static void dec_xor(DisasContext *dc)
-{
-    if (dc->rd)
-        tcg_gen_xor_i32(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
-}
-
 static void msr_read(DisasContext *dc, TCGv_i32 d)
 {
     TCGv_i32 t;
@@ -1581,9 +1570,6 @@ static struct decoder_info {
     };
     void (*dec)(DisasContext *dc);
 } decinfo[] = {
-    {DEC_AND, dec_and},
-    {DEC_XOR, dec_xor},
-    {DEC_OR, dec_or},
     {DEC_BIT, dec_bit},
     {DEC_BARREL, dec_barrel},
     {DEC_LD, dec_load},
-- 
2.25.1


