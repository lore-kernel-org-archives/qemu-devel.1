Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A485C19759
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 04:58:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF4B21743
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 04:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OqT2BEgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF4B21743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvE1a-000205-8o
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 00:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40737)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvDxU-0001Ol-5P
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvDxS-0004t7-Tp
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:56 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35430)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvDxS-0004ss-OV
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:54 -0400
Received: by mail-pg1-x542.google.com with SMTP id n4so1063480pgv.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 21:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=wDovHb8+ljpi4sI8lS1gqNoa7uBRHGNbFn35mP5+duU=;
 b=OqT2BEgIEQuSd8ShFb3RaeD82r3Bh/yyMtSbdIegm7GtN/0mckol0Dk8e4CEQ9atBS
 9r584wbilgkg7XYqXAxTZ/Uxjvr74kX+H+fcN5OLDoQrHPej+ca94YDPcy9ho4UFNHuq
 ZdnJQSASU/HJCbEY0RmnonneN3CaLWvi4c5YJMIdM3skY9kjrWlhOkzPq0h4FNTPtpF+
 NDGqmRGJC7P2Dbijt1aF5MRIQ7tXbvmWZVm5abW+IuVdH2qccZW43718n7Zu5MWaNhyt
 FDDbnnBNlT3Asfqqscp+nh/92mCtHE19TCW8vUIY4ssvYsDsTzK22aIE+Zk6/NvcrpXA
 fBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=wDovHb8+ljpi4sI8lS1gqNoa7uBRHGNbFn35mP5+duU=;
 b=FypQEuLpaaC74GX2Y3RjfuMPciLQ7KD6xF6ci6I4QtB+z8/b57lQyWd230LtiDoyFf
 L+l4ZX82zLs+8HE1BNjysZJ/eskHhdMdq/1YTECuNNfWSja/7wEI3+dc9Z3vDTr9TfR8
 yz6sqHg2BCfV6oNUUZr0oLdKjgHuBDNVLJ/7IubhLZQFvASjIRwBLd+A5/bVrzD+Xa+Y
 H/qWUrjjWj+7aIRLkJLAuTZH7dPg1OTVakvVGIWA0ZKKuTMecdyeMGgNQRfc6skCo/od
 XZ+rLURGl7GRczE3vJmLFL17a1FEtv5VxTM2OjeP+6ZNf6zvkQ+N86JKxIFWbafwKCc9
 X0+w==
X-Gm-Message-State: APjAAAUDoc9c4fn+4coI2xjPyVgXELjxBZPBwHtW5s7MESGLLl2nCFxR
 jsqCSI4RnM7DwSW1NP7ke1iqu/9ZGh0=
X-Google-Smtp-Source: APXvYqwF4b+4wAIQm78Yxq8+GdyAEojxYNT4zArU45A676At5fa82rQ9GY2S0xP5zRaYOJvVuyikrg==
X-Received: by 2002:a17:90a:2385:: with SMTP id
 g5mr6788791pje.12.1565153633487; 
 Tue, 06 Aug 2019 21:53:53 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id t9sm24347921pji.18.2019.08.06.21.53.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 06 Aug 2019 21:53:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  6 Aug 2019 21:53:32 -0700
Message-Id: <20190807045335.1361-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190807045335.1361-1-richard.henderson@linaro.org>
References: <20190807045335.1361-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH 08/11] target/arm: Replace offset with pc in
 gen_exception_internal_insn
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

The offset is variable depending on the instruction set.
Passing in the actual value is clearer in intent.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 8 ++++----
 target/arm/translate.c     | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 92aa6db12e..c8504d221a 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -266,9 +266,9 @@ static void gen_exception(int excp, uint32_t syndrome, uint32_t target_el)
     tcg_temp_free_i32(tcg_excp);
 }
 
-static void gen_exception_internal_insn(DisasContext *s, int offset, int excp)
+static void gen_exception_internal_insn(DisasContext *s, uint64_t pc, int excp)
 {
-    gen_a64_set_pc_im(s->base.pc_next - offset);
+    gen_a64_set_pc_im(pc);
     gen_exception_internal(excp);
     s->base.is_jmp = DISAS_NORETURN;
 }
@@ -1938,7 +1938,7 @@ static void disas_exc(DisasContext *s, uint32_t insn)
                 break;
             }
 #endif
-            gen_exception_internal_insn(s, 0, EXCP_SEMIHOST);
+            gen_exception_internal_insn(s, s->base.pc_next, EXCP_SEMIHOST);
         } else {
             unsupported_encoding(s, insn);
         }
@@ -14234,7 +14234,7 @@ static bool aarch64_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
         /* End the TB early; it likely won't be executed */
         dc->base.is_jmp = DISAS_TOO_MANY;
     } else {
-        gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
+        gen_exception_internal_insn(dc, dc->base.pc_next, EXCP_DEBUG);
         /* The address covered by the breakpoint must be
            included in [tb->pc, tb->pc + tb->size) in order
            to for it to be properly cleared -- thus we
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7a05ecae87..e6b18ecdaf 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1256,10 +1256,10 @@ static inline void gen_smc(DisasContext *s)
     s->base.is_jmp = DISAS_SMC;
 }
 
-static void gen_exception_internal_insn(DisasContext *s, int offset, int excp)
+static void gen_exception_internal_insn(DisasContext *s, uint32_t pc, int excp)
 {
     gen_set_condexec(s);
-    gen_set_pc_im(s, s->base.pc_next - offset);
+    gen_set_pc_im(s, pc);
     gen_exception_internal(excp);
     s->base.is_jmp = DISAS_NORETURN;
 }
@@ -1311,7 +1311,7 @@ static inline void gen_hlt(DisasContext *s, int imm)
         s->current_el != 0 &&
 #endif
         (imm == (s->thumb ? 0x3c : 0xf000))) {
-        gen_exception_internal_insn(s, 0, EXCP_SEMIHOST);
+        gen_exception_internal_insn(s, s->base.pc_next, EXCP_SEMIHOST);
         return;
     }
 
@@ -11953,7 +11953,7 @@ static bool arm_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
         /* End the TB early; it's likely not going to be executed */
         dc->base.is_jmp = DISAS_TOO_MANY;
     } else {
-        gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
+        gen_exception_internal_insn(dc, dc->base.pc_next, EXCP_DEBUG);
         /* The address covered by the breakpoint must be
            included in [tb->pc, tb->pc + tb->size) in order
            to for it to be properly cleared -- thus we
-- 
2.17.1


