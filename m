Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE588C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:51:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9E3922BF5
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mdDlubgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E3922BF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4NB-0003Si-EI
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57004)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Mb-0001lW-7p
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Ma-0007IJ-8i
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:41 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38249)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4Ma-0007D6-2u
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:40 -0400
Received: by mail-pf1-x443.google.com with SMTP id y15so24860118pfn.5
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0JuwQx0rsSZ8qsmRHdUvrfpwMYNiERG9Y6tvmeQiWIA=;
 b=mdDlubgVyDpI0gBB/9wS4I3ZOTQgv4PpfZOk+KWeOqCkAjg83eDxHSixsyqM/xsBH/
 BUVd6oQhdvo5O9aiW5mkGLz7dEIhy3r0ivcthlWlYuq4gGzBsfLKkHKBneIkiO919vcx
 t1WvOzaFxWjUepiRoMhwm5dfyd/rmBatVGkWj0EmEZAEC+syAvh0jVEbFIZmuA+YoA6t
 ysnYu1tw3IFx1kJynkc7h3HfJyre+u0vB8LD4He5RzXNQMnMiQlfcT2jvVgTb3AVFOfw
 y/ZcEUS0wdrLVSzBk/yeO36PMtHFp9rn7/FUPQRpmh53uzbZ+jZYm8uuGIhZtB1sk5lg
 sDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=0JuwQx0rsSZ8qsmRHdUvrfpwMYNiERG9Y6tvmeQiWIA=;
 b=ffr9owdpy1THOs+hARYCoc8X4jsBDORmRC5DodLJbcTaaX9LYmZlWbBkd0l+zBsGpm
 A9UTEDG4CCA1RY3eeUjiDWfCYJjbXTYh3aa5UccM3aPOcu13zxbxZ1OQDlkVhjFP/q4e
 8ShejMFIY64eOj11x0OjVQe6fqZTzmsFYMtTImp0Mu52kVHwCTOeJsBEZ3CfhaYinZ5c
 VGNkrZexU/Bsg9CERrIbBLmX0grd+iGk25ti9mygn/GyCSLG3Jmdul2WfImVVNN+z56/
 5P8Y2qLi8WddPqRuJfC1YXo2v02IL715fzYIRh5FljGT6vWMkr4vndpnqHXgfFeqYXbU
 7c6g==
X-Gm-Message-State: APjAAAUXdiiip2N6vUUj1a1A83wCiKcVGxYGemS8bSqPSUdiFsEvLNnV
 7whWKJxx4AU24jCSfNUe4ogaRTgdPNY=
X-Google-Smtp-Source: APXvYqwvTy4iDYLI8dksQMq4dUVkoUFdrcz7PpaveHPuTEiudndRV441C6L2lXW/dW7b2EFVS2Wx7Q==
X-Received: by 2002:a17:90a:3463:: with SMTP id
 o90mr101503225pjb.15.1564163437889; 
 Fri, 26 Jul 2019 10:50:37 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.50.36
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:50:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:49:28 -0700
Message-Id: <20190726175032.6769-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH 03/67] target/arm: Remove offset argument to
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The address of the current insn is still available in s->base.pc_next.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 33f78296eb..19b126d4f3 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1256,12 +1256,12 @@ static void gen_exception_insn(DisasContext *s, int excp, int syn,
     s->base.is_jmp = DISAS_NORETURN;
 }
 
-static void gen_exception_bkpt_insn(DisasContext *s, int offset, uint32_t syn)
+static void gen_exception_bkpt_insn(DisasContext *s, uint32_t syn)
 {
     TCGv_i32 tcg_syn;
 
     gen_set_condexec(s);
-    gen_set_pc_im(s, s->pc - offset);
+    gen_set_pc_im(s, s->base.pc_next);
     tcg_syn = tcg_const_i32(syn);
     gen_helper_exception_bkpt_insn(cpu_env, tcg_syn);
     tcg_temp_free_i32(tcg_syn);
@@ -8139,7 +8139,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             case 1:
                 /* bkpt */
                 ARCH(5);
-                gen_exception_bkpt_insn(s, 4, syn_aa32_bkpt(imm16, false));
+                gen_exception_bkpt_insn(s, syn_aa32_bkpt(imm16, false));
                 break;
             case 2:
                 /* Hypervisor call (v7) */
@@ -11611,7 +11611,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         {
             int imm8 = extract32(insn, 0, 8);
             ARCH(5);
-            gen_exception_bkpt_insn(s, 2, syn_aa32_bkpt(imm8, true));
+            gen_exception_bkpt_insn(s, syn_aa32_bkpt(imm8, true));
             break;
         }
 
-- 
2.17.1


