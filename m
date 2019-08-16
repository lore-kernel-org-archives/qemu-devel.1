Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170A4C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8BBB2086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KNu8Nx1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8BBB2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hycGE-0007RJ-GE
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6u-0003Q3-0e
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6s-0005Y0-TW
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:39 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50783)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyc6s-0005Vz-NK
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:38 -0400
Received: by mail-wm1-x342.google.com with SMTP id v15so4027865wml.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 06:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=JW+EAPalvU8sJOK/3AzigF90RPDipGFjQ/LE5CWN+3s=;
 b=KNu8Nx1wV+pwCGj4tkAS1H9yphYyfAMZHlL2Kpkea38Zq1iXTQUdZMHmP87m8sjZjw
 XN7/v1EQh48Do6ZQsh+yGVp8CAHmoToQIgU+Pcipmi7zFNc8/nQ1GgQMqIMi3jsJRpVD
 qSDE2heNVecCDkYbUd4jcd4gnLL+MoZS9WOfYa0FRYznvqyMLkMqIx5e9nF8/5lLupaJ
 DIBP1r1Oahiq3DcwFogODX03o/m6Bp3EhWF6V6OsIpyUEqs7rXv6iqVOImNTt5mllBm7
 6jYK8bqwmZWe6jAC0i6QRBfiTI8QNmzLvaxxrHezUdd7EXMWNl1IAXy/3RiG1nhcqcBG
 i+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JW+EAPalvU8sJOK/3AzigF90RPDipGFjQ/LE5CWN+3s=;
 b=fd+Cw5qk4g3GXJuUfGIFVzDZAyeF4tUmWflouWoGH9dwoHpftLjB+ZE2DMzvlGWMpj
 m99jXdqkd7edMsE5+ZwUBtqz2xRJLxU7TXokOLyrR2CYRr0G/C/+YOqrViTURVmfoyDL
 qUevSjYOnRCsLDnwWxA1iwmc8ndF1aLwdGU4HxeMsaYtP58/nA6/Mz2uH3k+5TRl5IDz
 0KZ5spbDQ2UpnRekUNoRQ8UzkiFAJu+s5tSt2euWwGqzTskJ0WrnTk9CuSv+tQOt0WkL
 NdAHrj7JHS+qxbCpHUVMoQuoIYrad9G0vQ6gqTaZbDSvbT92XhAjViC3U4zSHuRIMQcd
 QFVg==
X-Gm-Message-State: APjAAAUXID3lMotT0hlEYkzcBMkXw+QTrfsvcE3JstvvYcc198RSsz2S
 BSPh0CgMmhka5Pd1OYX5Ke1HD6OuD5w47A==
X-Google-Smtp-Source: APXvYqxILMxTCEFSjzQrhnkCAV+DoLs3RQ43wUev9ZsWt9hEHqCvk5oQb+LA0y+JI5PCVUfzdSVp0A==
X-Received: by 2002:a05:600c:ce:: with SMTP id u14mr7366248wmm.5.1565961456004; 
 Fri, 16 Aug 2019 06:17:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 4sm8705796wro.78.2019.08.16.06.17.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 06:17:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 14:17:04 +0100
Message-Id: <20190816131719.28244-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816131719.28244-1-peter.maydell@linaro.org>
References: <20190816131719.28244-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PULL 14/29] target/arm: Remove offset argument to
 gen_exception_bkpt_insn
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Unlike the other more generic gen_exception{,_internal}_insn
interfaces, breakpoints always refer to the current instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190807045335.1361-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 7 +++----
 target/arm/translate.c     | 8 ++++----
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2f8eea02e3b..55324333dab 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -268,12 +268,11 @@ static void gen_exception_insn(DisasContext *s, uint64_t pc, int excp,
     s->base.is_jmp = DISAS_NORETURN;
 }
 
-static void gen_exception_bkpt_insn(DisasContext *s, int offset,
-                                    uint32_t syndrome)
+static void gen_exception_bkpt_insn(DisasContext *s, uint32_t syndrome)
 {
     TCGv_i32 tcg_syn;
 
-    gen_a64_set_pc_im(s->base.pc_next - offset);
+    gen_a64_set_pc_im(s->pc_curr);
     tcg_syn = tcg_const_i32(syndrome);
     gen_helper_exception_bkpt_insn(cpu_env, tcg_syn);
     tcg_temp_free_i32(tcg_syn);
@@ -1900,7 +1899,7 @@ static void disas_exc(DisasContext *s, uint32_t insn)
             break;
         }
         /* BRK */
-        gen_exception_bkpt_insn(s, 4, syn_aa64_bkpt(imm16));
+        gen_exception_bkpt_insn(s, syn_aa64_bkpt(imm16));
         break;
     case 2:
         if (op2_ll != 0) {
diff --git a/target/arm/translate.c b/target/arm/translate.c
index c26d3376b3c..8bae0c39933 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1258,12 +1258,12 @@ static void gen_exception_insn(DisasContext *s, uint32_t pc, int excp,
     s->base.is_jmp = DISAS_NORETURN;
 }
 
-static void gen_exception_bkpt_insn(DisasContext *s, int offset, uint32_t syn)
+static void gen_exception_bkpt_insn(DisasContext *s, uint32_t syn)
 {
     TCGv_i32 tcg_syn;
 
     gen_set_condexec(s);
-    gen_set_pc_im(s, s->base.pc_next - offset);
+    gen_set_pc_im(s, s->pc_curr);
     tcg_syn = tcg_const_i32(syn);
     gen_helper_exception_bkpt_insn(cpu_env, tcg_syn);
     tcg_temp_free_i32(tcg_syn);
@@ -8140,7 +8140,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             case 1:
                 /* bkpt */
                 ARCH(5);
-                gen_exception_bkpt_insn(s, 4, syn_aa32_bkpt(imm16, false));
+                gen_exception_bkpt_insn(s, syn_aa32_bkpt(imm16, false));
                 break;
             case 2:
                 /* Hypervisor call (v7) */
@@ -11566,7 +11566,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         {
             int imm8 = extract32(insn, 0, 8);
             ARCH(5);
-            gen_exception_bkpt_insn(s, 2, syn_aa32_bkpt(imm8, true));
+            gen_exception_bkpt_insn(s, syn_aa32_bkpt(imm8, true));
             break;
         }
 
-- 
2.20.1


