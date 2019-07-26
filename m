Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEB4C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:53:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ABE3218B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nHLntBke"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ABE3218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4Ox-00035C-5s
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57433)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Mm-0002Pc-Uc
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Mj-0007hy-Q4
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:51 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:42185)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4Mj-0007g1-JA
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:49 -0400
Received: by mail-pg1-x542.google.com with SMTP id t132so25100896pgb.9
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=nQkh2An2kFZsAIQLEJuPgVfqt44IAx9vqtUtFyE7/Qo=;
 b=nHLntBkexNHKSWsXkmEB+IE2sg7znr577TTLhAa2uCifkD4yBhqMItocTfOLYc7eSg
 bNBDzDu0VhHCU3UnX0pVqWALgpBK/Cp1BTz9mEcn1RATqWNF2NlGAIT3KGGJ98y8HMlF
 ULMa8sV3oOzMrPKknF6yU9SLmx+aXECNG0s1leBp+3kpURqs+j+wBnwpOt1DbZ4Oz9go
 os4g/MTQXVloASFGIfbPuRtOgy2ufcTo5ZMA450lETtXaaH1JMhJd/H24AWfpLLIOxxf
 Lho9Hwd3SpN/FOQx6Zm6FJ6yZ/vOVJ/Qbz8JdTfYxZhyc4TDpzDlHza+9/JO7lZP6JVq
 BZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=nQkh2An2kFZsAIQLEJuPgVfqt44IAx9vqtUtFyE7/Qo=;
 b=GozWpePHFKZMKwTbHttFYAlqhwWnVuw49xBqo3xp/osXLLdxfp3TDw4MUgE5Onv+mp
 5WLaBeaoivGw8dLfG24tIdJfe0xKtoWJPFQt7I3k82BCPfo6Qs0C/lYN1OUMV8k0UZ2T
 eIVwK2e3OMEsqIpxZ4FHFm/7JTrt9D01PviZXZr3Ed/xJxGUVguEAEjU3SmsFDa+HpMK
 vzGEVYvqo5bYPvQYRncAF1aDyHfbLb5oWrlMggJuHEW65IBznkgWyUOamJZtSlbxUwem
 t6IbC29bklRyESO2KFVJrLtslNxvPzWmv+1MWKI2VWjOpPT+D+Q3pAWj0rqJNGQaivOM
 EW5g==
X-Gm-Message-State: APjAAAWPffWTMMLgg5wUl46h4PYfEi9MAQmm4fO0pn7kl3Rga5461Ta/
 V7Km9dhGGizEkezhOXGAauACwnEKdKo=
X-Google-Smtp-Source: APXvYqzb/RrE3v/cVejadmuj0wfOat1ZbaVTsjgfv5aO/STGnfdsTORa7sgGJCktsvw5B10t9hHb2Q==
X-Received: by 2002:a17:90a:b903:: with SMTP id
 p3mr97691321pjr.79.1564163448309; 
 Fri, 26 Jul 2019 10:50:48 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.50.47
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:50:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:49:37 -0700
Message-Id: <20190726175032.6769-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH 12/67] target/arm: Introduce gen_illegal_op
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

Unify the code sequence for generating an illegal opcode exception.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c |  3 +--
 target/arm/translate.c         | 21 +++++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 4066b2febf..1b08930649 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -108,8 +108,7 @@ static bool full_vfp_access_check(DisasContext *s, bool ignore_vfp_enabled)
 
     if (!s->vfp_enabled && !ignore_vfp_enabled) {
         assert(!arm_dc_feature(s, ARM_FEATURE_M));
-        gen_exception_insn(s, EXCP_UDEF, syn_uncategorized(),
-                           default_exception_el(s));
+        gen_illegal_op(s);
         return false;
     }
 
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4738b91957..0f21ee9ce7 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1279,6 +1279,12 @@ static void gen_exception_bkpt_insn(DisasContext *s, uint32_t syn)
     s->base.is_jmp = DISAS_NORETURN;
 }
 
+static void gen_illegal_op(DisasContext *s)
+{
+    gen_exception_insn(s, EXCP_UDEF, syn_uncategorized(),
+                       default_exception_el(s));
+}
+
 /* Force a TB lookup after an instruction that changes the CPU state.  */
 static inline void gen_lookup_tb(DisasContext *s)
 {
@@ -1309,8 +1315,7 @@ static inline void gen_hlt(DisasContext *s, int imm)
         return;
     }
 
-    gen_exception_insn(s, EXCP_UDEF, syn_uncategorized(),
-                       default_exception_el(s));
+    gen_illegal_op(s);
 }
 
 static inline void gen_add_data_offset(DisasContext *s, unsigned int insn,
@@ -7631,8 +7636,7 @@ static void gen_srs(DisasContext *s,
     }
 
     if (undef) {
-        gen_exception_insn(s, EXCP_UDEF, syn_uncategorized(),
-                           default_exception_el(s));
+        gen_illegal_op(s);
         return;
     }
 
@@ -9299,8 +9303,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             break;
         default:
         illegal_op:
-            gen_exception_insn(s, EXCP_UDEF, syn_uncategorized(),
-                               default_exception_el(s));
+            gen_illegal_op(s);
             break;
         }
     }
@@ -10990,8 +10993,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
     }
     return;
 illegal_op:
-    gen_exception_insn(s, EXCP_UDEF, syn_uncategorized(),
-                       default_exception_el(s));
+    gen_illegal_op(s);
 }
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
@@ -11816,8 +11818,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
     return;
 illegal_op:
 undef:
-    gen_exception_insn(s, EXCP_UDEF, syn_uncategorized(),
-                       default_exception_el(s));
+    gen_illegal_op(s);
 }
 
 static bool insn_crosses_page(CPUARMState *env, DisasContext *s)
-- 
2.17.1


