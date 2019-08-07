Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07A9C19759
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 04:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB4D21743
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 04:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QAEn9u0Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB4D21743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvDzr-0006j4-0U
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 00:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40768)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvDxV-0001Ry-7v
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvDxU-0004u1-53
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:57 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42006)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvDxT-0004tP-Uc
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:56 -0400
Received: by mail-pf1-x442.google.com with SMTP id q10so42748180pff.9
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 21:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=UlqJA+9OtOIxQsXhtvfeB1bXxV7N+Aorv6VBupensFc=;
 b=QAEn9u0Ym0ad5dh9yIMsWRcOVWzhx0B4Z1kznE3zTtN3t5ogG33OKegtSs1Rnb+wi0
 rTUaWmKP/mDnNkhhYqDO4kJsoaeuj4MIyu9fnVRIgZW9Lguw+R6LBwd0z8DEtcxTHjJD
 exxXpMx9mo6RtOITA2yqLj+6AEXwHa5iHl97IwlfSPfAtgLO1GwWGP+ghtHdhWtj4OHw
 z8fogGbqZpskzAObq8DFtQdxQV8JjfGX1I9OLXi5jESbTPFwuzRJw9nwdAukzmpLkHlS
 rJSBIWnSI8UDIoguqba/3nZdnoWmrpdG4xq6+F50m9O4kUAJceX9b0Wk8Y92aHRq/3G/
 MGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=UlqJA+9OtOIxQsXhtvfeB1bXxV7N+Aorv6VBupensFc=;
 b=Ps/N7xDo732IzS5wmZVgK1SMx1lL8oXYXK5ENTATDqrHKN0aPcGSY33JdGO3D5IU4X
 fTokzb3SCXNt4JJQYAns5u+6DLhFzIzZxkfVvAx9FH20ZUf73kRwug793sxT3BwDI7+v
 bKIBAKcrUgOEikUfzVOIe09dJKbMU0ZvXsr2AXjIo6LQXhyoNeGjyWE0QMIUfZBiTvhp
 NfowGz2vky9Q87r6umdWDDckQZKAUMhQ0vLkW+5t4QisGYKL7hL3qenWB/S+ob9KOKGh
 4OJ/9zi4P21bxF+gyhfNuctHRBnsNYUvqS10NExbujX90nYtaYuurrCTS6BbF1KFhSzw
 h0Tw==
X-Gm-Message-State: APjAAAUYLFM11ob4XujRHeKxI3rWhP2F2w0QAF1oJSLGLeTMJE34/fbD
 QREI8kVYSakFK9DYNH8zQzRJC/Lct+c=
X-Google-Smtp-Source: APXvYqw9y/8Grgf3T3eqt2OFzDL/MgUU3XD75Y5we4DlEW+3ogWEgfnXYbIK7GZTEhtTkVGQTS6/LA==
X-Received: by 2002:a62:1d11:: with SMTP id d17mr7453663pfd.249.1565153634726; 
 Tue, 06 Aug 2019 21:53:54 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id t9sm24347921pji.18.2019.08.06.21.53.53
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 06 Aug 2019 21:53:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  6 Aug 2019 21:53:33 -0700
Message-Id: <20190807045335.1361-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190807045335.1361-1-richard.henderson@linaro.org>
References: <20190807045335.1361-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH 09/11] target/arm: Remove offset argument to
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Unlike the other more generic gen_exception{,_internal}_insn
interfaces, breakpoints always refer to the current instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 7 +++----
 target/arm/translate.c     | 8 ++++----
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index c8504d221a..d68bfc66d3 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -281,12 +281,11 @@ static void gen_exception_insn(DisasContext *s, uint64_t pc, int excp,
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
@@ -1914,7 +1913,7 @@ static void disas_exc(DisasContext *s, uint32_t insn)
             break;
         }
         /* BRK */
-        gen_exception_bkpt_insn(s, 4, syn_aa64_bkpt(imm16));
+        gen_exception_bkpt_insn(s, syn_aa64_bkpt(imm16));
         break;
     case 2:
         if (op2_ll != 0) {
diff --git a/target/arm/translate.c b/target/arm/translate.c
index e6b18ecdaf..d6b0ab7247 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1273,12 +1273,12 @@ static void gen_exception_insn(DisasContext *s, uint32_t pc, int excp,
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
@@ -8155,7 +8155,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             case 1:
                 /* bkpt */
                 ARCH(5);
-                gen_exception_bkpt_insn(s, 4, syn_aa32_bkpt(imm16, false));
+                gen_exception_bkpt_insn(s, syn_aa32_bkpt(imm16, false));
                 break;
             case 2:
                 /* Hypervisor call (v7) */
@@ -11581,7 +11581,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         {
             int imm8 = extract32(insn, 0, 8);
             ARCH(5);
-            gen_exception_bkpt_insn(s, 2, syn_aa32_bkpt(imm8, true));
+            gen_exception_bkpt_insn(s, syn_aa32_bkpt(imm8, true));
             break;
         }
 
-- 
2.17.1


