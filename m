Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5361AC3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 15:20:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F15320828
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 15:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hJ+v5dbc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F15320828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Gmp-0003yv-S4
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 11:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54855)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i2Gie-0000wB-JH
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 11:15:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i2Gic-0008HK-Pg
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 11:15:44 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33644)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i2Gic-0008Gh-Jc
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 11:15:42 -0400
Received: by mail-pf1-x444.google.com with SMTP id g2so12008001pfq.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 08:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6Wc/MxLOr6YwXjgMWjLSNrJcZWJyujD788Ome0kD52E=;
 b=hJ+v5dbcFtjBPjywGUMdwsq0JFDTsk8lcqlIpKiI9Jbs6wtIi2u5EhjMTiz9qj449R
 w7de7pp1qO+0fTRSIzkHNrQUsBE4tLEVy53YyxyvVONEtp4G5/WtsLOoXsAnci7+u4ze
 L/rBLvmM/XxONMWD7RS+qBIYV9XAOOSMltGR0GRQq979ZmXcEzr3rUwCDt3caOTQVKct
 LrV9vU6ClbQ8Ceoz5OBZLmY5+O6GgY2sUgR45+g4wuYBs+/w5PvpRell2HKs8pCd/WOm
 w81c240uIb81WpkjARvloMgiEixfhiF7V9r/R+5wPmUynggoAHRlbjX06N3FrRs+0ZP/
 ruBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6Wc/MxLOr6YwXjgMWjLSNrJcZWJyujD788Ome0kD52E=;
 b=JwwmU34YHyJg4u9KEB7dO5ThK5L/+LxMPNWk4mv5w+ONZWthXwFXl2Z3M33+9mErVq
 j8cxoGDqvNu7s7rDh/g4p3b87bgscRxJTxoB+qoB9gzdp6N+NnXtOokVHvDizPpd+x1+
 KZHCJUvWQYMF+zzSzZBYTTB8UW7Z5xUl7k8+nmxBD910s1fFPx1IhJtvXdsxnzalBwIP
 OXuep9ZTpzuHCfaxtj5Srk+8qJSUQ/MfQ/ACCDZBHHpJbn97fPsmc0qsJ/5qQqJfwLRw
 pIPOGFX73HDqRlKiXCsM/do10vlcdtyONQO9oQzgdoonLFvzJkiX+gZ0wYpLmlLKtqFf
 6L/A==
X-Gm-Message-State: APjAAAWJ8RSPqkGS9fz4OKz5DnrmfmyXs0svopOmov331keFq9J3YXaT
 OzhnQeD3rjFy96304wrMUeiO7rRDxOk=
X-Google-Smtp-Source: APXvYqymnlkc5BW8Wz8R3XD4t1PV/DphGyD7RLUfEMeTMW8NwK/uyxI+08VFL9uja5Plx9VfES7VyA==
X-Received: by 2002:a17:90a:cb88:: with SMTP id
 a8mr7557845pju.111.1566832541150; 
 Mon, 26 Aug 2019 08:15:41 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q4sm13563612pff.183.2019.08.26.08.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 08:15:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 08:15:36 -0700
Message-Id: <20190826151536.6771-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826151536.6771-1-richard.henderson@linaro.org>
References: <20190826151536.6771-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH 2/2] target/arm: Factor out
 unallocated_encoding for aarch32
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make this a static function private to translate.c.
Thus we can use the same idiom between aarch64 and aarch32
without actually sharing function implementations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c |  3 +--
 target/arm/translate.c         | 22 ++++++++++++----------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 5065d4524c..3e8ea80493 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -108,8 +108,7 @@ static bool full_vfp_access_check(DisasContext *s, bool ignore_vfp_enabled)
 
     if (!s->vfp_enabled && !ignore_vfp_enabled) {
         assert(!arm_dc_feature(s, ARM_FEATURE_M));
-        gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
-                           default_exception_el(s));
+        unallocated_encoding(s);
         return false;
     }
 
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 2aac9aae68..66311580c0 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1231,6 +1231,13 @@ static void gen_exception_bkpt_insn(DisasContext *s, uint32_t syn)
     s->base.is_jmp = DISAS_NORETURN;
 }
 
+static void unallocated_encoding(DisasContext *s)
+{
+    /* Unallocated and reserved encodings are uncategorized */
+    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
+                       default_exception_el(s));
+}
+
 /* Force a TB lookup after an instruction that changes the CPU state.  */
 static inline void gen_lookup_tb(DisasContext *s)
 {
@@ -1261,8 +1268,7 @@ static inline void gen_hlt(DisasContext *s, int imm)
         return;
     }
 
-    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
-                       default_exception_el(s));
+    unallocated_encoding(s);
 }
 
 static inline void gen_add_data_offset(DisasContext *s, unsigned int insn,
@@ -7574,8 +7580,7 @@ static void gen_srs(DisasContext *s,
     }
 
     if (undef) {
-        gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
-                           default_exception_el(s));
+        unallocated_encoding(s);
         return;
     }
 
@@ -9196,8 +9201,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             break;
         default:
         illegal_op:
-            gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
-                               default_exception_el(s));
+            unallocated_encoding(s);
             break;
         }
     }
@@ -10882,8 +10886,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
     }
     return;
 illegal_op:
-    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
-                       default_exception_el(s));
+    unallocated_encoding(s);
 }
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
@@ -11706,8 +11709,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
     return;
 illegal_op:
 undef:
-    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
-                       default_exception_el(s));
+    unallocated_encoding(s);
 }
 
 static bool insn_crosses_page(CPUARMState *env, DisasContext *s)
-- 
2.17.1


