Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E949C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BB292133F
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WvA5T8K6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB292133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hycBF-00009m-65
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6k-0003K5-FE
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6i-0005Mk-Fu
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:30 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:42461)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyc6h-0005Kd-2d
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:27 -0400
Received: by mail-wr1-x42f.google.com with SMTP id b16so1513065wrq.9
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 06:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=tFLJu0RLA65KkfF6V+67H4j4yUsOojJ5LomME9mNzd4=;
 b=WvA5T8K62NxxvOTjJieO7dadeWdv207vdtt+JA/1oCAPBvYpBgSGc1huJkt0o8EFqd
 t4Ulde8EK3lq3WM2+Z5nOrjdJykSGRzio8e+fHXx4XjRK5lbsgAcuzTbYbRyiRRSbD7G
 ZSlnd/5okLGA+zoRM03sImM+6mmnzw6v5Kq51RMkx9RkIZ8E5ep7vcnDWiCIb8CVf3IP
 Zah+g2sCiZs/PDTqTf8p43efNfAuFmGdLrepSACla7EhGQbP0kSTJh8m30mJ+/emkU/P
 zKpaw+1brjTDgOuKIuybYB3ik+B8zscjNaxUhJcJvoceH2g9nh28NYUwUQHNjlFiHs03
 5X8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tFLJu0RLA65KkfF6V+67H4j4yUsOojJ5LomME9mNzd4=;
 b=QGeL85MFuY9zDoaDZhaAlWsTG6S/NNRWjnE8SUi7xjRuMkqS+2gHzrCwnVluAaWcqo
 v3jo5xePHPaUhlnoKZQZNMySwMRNciOMpA1UBbvk6lj9WXGJmC85dD5FTVuTqi33L7yW
 iYwTJM2+lwpclYHqVV0kkKe+I+mJuc7S23rC2p4OdRAvz4wzZreSL7Nc0cRvy436uyEF
 FmY163H1Q1KgKYYk45i8SgsObSv/F5/T0UDabJJfajnmZeDqsG9brdaFbq2VPDO9VUE+
 AAZwaUuzjhXA8pB3/vRY25kjCD245cPQMeu/xmDAqew1O2VGibpBUUO6siFxKBNWpmSO
 z79g==
X-Gm-Message-State: APjAAAX/ScHG52i3zHEAjyLr0MG62vLfOSxUaqfsmM9mXo4JR5OiaiF/
 PUJDTwyvh90CDGlieCfFgKvt6bnSwJg4mA==
X-Google-Smtp-Source: APXvYqwc68GIl8wPWQNIFNkx3Uvw0XgRLgWbIyX+ym0D6wY6+TH6bZP80Ax86HTS13opAi7fCv5mpA==
X-Received: by 2002:adf:90e7:: with SMTP id i94mr10340421wri.224.1565961445789; 
 Fri, 16 Aug 2019 06:17:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 4sm8705796wro.78.2019.08.16.06.17.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 06:17:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 14:16:54 +0100
Message-Id: <20190816131719.28244-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816131719.28244-1-peter.maydell@linaro.org>
References: <20190816131719.28244-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
Subject: [Qemu-devel] [PULL 04/29] target/arm: Factor out 'generate
 singlestep exception' function
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

Factor out code to 'generate a singlestep exception', which is
currently repeated in four places.

To do this we need to also pull the identical copies of the
gen-exception() function out of translate-a64.c and translate.c
into translate.h.

(There is a bug in the code: we're taking the exception to the wrong
target EL.  This will be simpler to fix if there's only one place to
do it.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20190805130952.4415-2-peter.maydell@linaro.org
---
 target/arm/translate.h     | 23 +++++++++++++++++++++++
 target/arm/translate-a64.c | 19 ++-----------------
 target/arm/translate.c     | 20 ++------------------
 3 files changed, 27 insertions(+), 35 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index a20f6e20568..45053190baa 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -2,6 +2,7 @@
 #define TARGET_ARM_TRANSLATE_H
 
 #include "exec/translator.h"
+#include "internals.h"
 
 
 /* internal defines */
@@ -232,6 +233,28 @@ static inline void gen_ss_advance(DisasContext *s)
     }
 }
 
+static inline void gen_exception(int excp, uint32_t syndrome,
+                                 uint32_t target_el)
+{
+    TCGv_i32 tcg_excp = tcg_const_i32(excp);
+    TCGv_i32 tcg_syn = tcg_const_i32(syndrome);
+    TCGv_i32 tcg_el = tcg_const_i32(target_el);
+
+    gen_helper_exception_with_syndrome(cpu_env, tcg_excp,
+                                       tcg_syn, tcg_el);
+
+    tcg_temp_free_i32(tcg_el);
+    tcg_temp_free_i32(tcg_syn);
+    tcg_temp_free_i32(tcg_excp);
+}
+
+/* Generate an architectural singlestep exception */
+static inline void gen_swstep_exception(DisasContext *s, int isv, int ex)
+{
+    gen_exception(EXCP_UDEF, syn_swstep(s->ss_same_el, isv, ex),
+                  default_exception_el(s));
+}
+
 /*
  * Given a VFP floating point constant encoded into an 8 bit immediate in an
  * instruction, expand it to the actual constant value of the specified
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d3231477a27..f6729b96fd0 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -253,19 +253,6 @@ static void gen_exception_internal(int excp)
     tcg_temp_free_i32(tcg_excp);
 }
 
-static void gen_exception(int excp, uint32_t syndrome, uint32_t target_el)
-{
-    TCGv_i32 tcg_excp = tcg_const_i32(excp);
-    TCGv_i32 tcg_syn = tcg_const_i32(syndrome);
-    TCGv_i32 tcg_el = tcg_const_i32(target_el);
-
-    gen_helper_exception_with_syndrome(cpu_env, tcg_excp,
-                                       tcg_syn, tcg_el);
-    tcg_temp_free_i32(tcg_el);
-    tcg_temp_free_i32(tcg_syn);
-    tcg_temp_free_i32(tcg_excp);
-}
-
 static void gen_exception_internal_insn(DisasContext *s, int offset, int excp)
 {
     gen_a64_set_pc_im(s->pc - offset);
@@ -305,8 +292,7 @@ static void gen_step_complete_exception(DisasContext *s)
      * of the exception, and our syndrome information is always correct.
      */
     gen_ss_advance(s);
-    gen_exception(EXCP_UDEF, syn_swstep(s->ss_same_el, 1, s->is_ldex),
-                  default_exception_el(s));
+    gen_swstep_exception(s, 1, s->is_ldex);
     s->base.is_jmp = DISAS_NORETURN;
 }
 
@@ -14261,8 +14247,7 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
          * bits should be zero.
          */
         assert(dc->base.num_insns == 1);
-        gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
-                      default_exception_el(dc));
+        gen_swstep_exception(dc, 0, 0);
         dc->base.is_jmp = DISAS_NORETURN;
     } else {
         disas_a64_insn(env, dc);
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7853462b21b..19b9d8f2725 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -282,20 +282,6 @@ static void gen_exception_internal(int excp)
     tcg_temp_free_i32(tcg_excp);
 }
 
-static void gen_exception(int excp, uint32_t syndrome, uint32_t target_el)
-{
-    TCGv_i32 tcg_excp = tcg_const_i32(excp);
-    TCGv_i32 tcg_syn = tcg_const_i32(syndrome);
-    TCGv_i32 tcg_el = tcg_const_i32(target_el);
-
-    gen_helper_exception_with_syndrome(cpu_env, tcg_excp,
-                                       tcg_syn, tcg_el);
-
-    tcg_temp_free_i32(tcg_el);
-    tcg_temp_free_i32(tcg_syn);
-    tcg_temp_free_i32(tcg_excp);
-}
-
 static void gen_step_complete_exception(DisasContext *s)
 {
     /* We just completed step of an insn. Move from Active-not-pending
@@ -308,8 +294,7 @@ static void gen_step_complete_exception(DisasContext *s)
      * of the exception, and our syndrome information is always correct.
      */
     gen_ss_advance(s);
-    gen_exception(EXCP_UDEF, syn_swstep(s->ss_same_el, 1, s->is_ldex),
-                  default_exception_el(s));
+    gen_swstep_exception(s, 1, s->is_ldex);
     s->base.is_jmp = DISAS_NORETURN;
 }
 
@@ -12024,8 +12009,7 @@ static bool arm_pre_translate_insn(DisasContext *dc)
          * bits should be zero.
          */
         assert(dc->base.num_insns == 1);
-        gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
-                      default_exception_el(dc));
+        gen_swstep_exception(dc, 0, 0);
         dc->base.is_jmp = DISAS_NORETURN;
         return true;
     }
-- 
2.20.1


