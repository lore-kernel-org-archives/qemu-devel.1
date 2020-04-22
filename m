Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F944C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:19:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9066206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aHcIYtbC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9066206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR42t-0004CX-Uk
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 21:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41S-0001pz-Ut
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41S-0002Gq-2v
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:54 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46719)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR41R-0002BW-IR
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:53 -0400
Received: by mail-pg1-x543.google.com with SMTP id j7so237383pgj.13
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 18:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zkNLdD4lJapTD7P5RW5mO/2wUgiJHORElGCA3liJ3rI=;
 b=aHcIYtbCvJoAiWpeMUYEnhwEUU14jrmGgRBo5HDXpieN7t622WBHAEkEaePZNPAzM9
 BwqQ1BuzXS1qOwFEMB42A8+Lml2L6IOZwQibO4oNJnEx3osHEDI0hlL5FBpdlIvrxv+4
 es9nMzNXJfqhEFI9XsrjI2j3OP8HDAzJ3dZkgdB6+F2CN4U2e+y/dJCqGeX2t9GrXQLh
 qfzw/K+2XHIXwbZJulkJef+Yn0IFKFLhI2fH7RcZEO2VK5w3zD6isooRUapJBoVVjtG1
 CH5+Nn+bI4oQh6KhF2DpRB5PLnKqKn5HgxNEgo+H057ymSVcatfhY76iyj1LmjmVm1/z
 M7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zkNLdD4lJapTD7P5RW5mO/2wUgiJHORElGCA3liJ3rI=;
 b=EWDNBFsMNXa6dAX/mCrQcWTSqzmI7iRZs9O0ZUwylSDzawaEBaroXFofVyEpHEpW2E
 Mjtmorxq1KqCELdYasUZGyGtM6XkiLHBiqru/y2RkL4FufCucu9nLOAuy2rrnH9+buP9
 ljHcN8nmwtidsjCBvmoP/qPtyGvQQdxBMbuodC1j8jKZTlsFoYuTENtGHw0lexvAwZkk
 xK8q0GtW5t/PeQ4frzZVokcUGB4q/AM/mpfkntuYbZGqJbbeEe0bgpKngUYeKrEXIbYw
 GmIhwQG8IJmjg4WOIZD2CWTLi2S3Ga3VN9NkpEYWpxId6W4kX2klYlFZw1v7Fb+G/ERm
 i4eg==
X-Gm-Message-State: AGi0PuZm+vOTiRNxY2uul1PO5hTI+CWCiM2gU6Gk8mV0zB0pQuM2oKT7
 UIA1ZnXqAduzujYF8k/sT6VxcAQ9bLA=
X-Google-Smtp-Source: APiQypIkqLFVeK3kG24xux9RUij0d9evBlx4kbk5v9ZLTjqA0Dy+/YPNOYMEhskKUM4WEJL6jJocHw==
X-Received: by 2002:aa7:85c2:: with SMTP id z2mr23606747pfn.25.1587518271811; 
 Tue, 21 Apr 2020 18:17:51 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m4sm3673561pfm.26.2020.04.21.18.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 18:17:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 22/36] tcg: Increase tcg_out_dupi_vec immediate to int64_t
Date: Tue, 21 Apr 2020 18:17:08 -0700
Message-Id: <20200422011722.13287-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422011722.13287-1-richard.henderson@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While we don't store more than tcg_target_long in TCGTemp,
we shouldn't be limited to that for code generation.  We will
be able to use this for INDEX_op_dup2_vec with 2 constants.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c |  2 +-
 tcg/i386/tcg-target.inc.c    | 20 ++++++++++++--------
 tcg/ppc/tcg-target.inc.c     | 15 ++++++++-------
 tcg/tcg.c                    |  4 ++--
 4 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index e5c9ab70a9..3b5a5d78c7 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -856,7 +856,7 @@ static void tcg_out_logicali(TCGContext *s, AArch64Insn insn, TCGType ext,
 }
 
 static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
-                             TCGReg rd, tcg_target_long v64)
+                             TCGReg rd, int64_t v64)
 {
     bool q = type == TCG_TYPE_V128;
     int cmode, imm8, i;
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 07424f7ef9..9cb627d6eb 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -945,7 +945,7 @@ static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
 }
 
 static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
-                             TCGReg ret, tcg_target_long arg)
+                             TCGReg ret, int64_t arg)
 {
     int vex_l = (type == TCG_TYPE_V256 ? P_VEXL : 0);
 
@@ -958,7 +958,14 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
         return;
     }
 
-    if (TCG_TARGET_REG_BITS == 64) {
+    if (TCG_TARGET_REG_BITS == 32 && arg == dup_const(MO_32, arg)) {
+        if (have_avx2) {
+            tcg_out_vex_modrm_pool(s, OPC_VPBROADCASTW + vex_l, ret);
+        } else {
+            tcg_out_vex_modrm_pool(s, OPC_VBROADCASTSS, ret);
+        }
+        new_pool_label(s, arg, R_386_32, s->code_ptr - 4, 0);
+    } else {
         if (type == TCG_TYPE_V64) {
             tcg_out_vex_modrm_pool(s, OPC_MOVQ_VqWq, ret);
         } else if (have_avx2) {
@@ -966,14 +973,11 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
         } else {
             tcg_out_vex_modrm_pool(s, OPC_MOVDDUP, ret);
         }
-        new_pool_label(s, arg, R_386_PC32, s->code_ptr - 4, -4);
-    } else {
-        if (have_avx2) {
-            tcg_out_vex_modrm_pool(s, OPC_VPBROADCASTW + vex_l, ret);
+        if (TCG_TARGET_REG_BITS == 64) {
+            new_pool_label(s, arg, R_386_PC32, s->code_ptr - 4, -4);
         } else {
-            tcg_out_vex_modrm_pool(s, OPC_VBROADCASTSS, ret);
+            new_pool_l2(s, R_386_32, s->code_ptr - 4, 0, arg, arg >> 32);
         }
-        new_pool_label(s, arg, R_386_32, s->code_ptr - 4, 0);
     }
 }
 
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 7ab1e32064..3333b55766 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -913,7 +913,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
 }
 
 static void tcg_out_dupi_vec(TCGContext *s, TCGType type, TCGReg ret,
-                             tcg_target_long val)
+                             int64_t val)
 {
     uint32_t load_insn;
     int rel, low;
@@ -921,20 +921,20 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, TCGReg ret,
 
     low = (int8_t)val;
     if (low >= -16 && low < 16) {
-        if (val == (tcg_target_long)dup_const(MO_8, low)) {
+        if (val == dup_const(MO_8, low)) {
             tcg_out32(s, VSPLTISB | VRT(ret) | ((val & 31) << 16));
             return;
         }
-        if (val == (tcg_target_long)dup_const(MO_16, low)) {
+        if (val == dup_const(MO_16, low)) {
             tcg_out32(s, VSPLTISH | VRT(ret) | ((val & 31) << 16));
             return;
         }
-        if (val == (tcg_target_long)dup_const(MO_32, low)) {
+        if (val == dup_const(MO_32, low)) {
             tcg_out32(s, VSPLTISW | VRT(ret) | ((val & 31) << 16));
             return;
         }
     }
-    if (have_isa_3_00 && val == (tcg_target_long)dup_const(MO_8, val)) {
+    if (have_isa_3_00 && val == dup_const(MO_8, val)) {
         tcg_out32(s, XXSPLTIB | VRT(ret) | ((val & 0xff) << 11));
         return;
     }
@@ -956,14 +956,15 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, TCGReg ret,
         if (TCG_TARGET_REG_BITS == 64) {
             new_pool_label(s, val, rel, s->code_ptr, add);
         } else {
-            new_pool_l2(s, rel, s->code_ptr, add, val, val);
+            new_pool_l2(s, rel, s->code_ptr, add, val >> 32, val);
         }
     } else {
         load_insn = LVX | VRT(ret) | RB(TCG_REG_TMP1);
         if (TCG_TARGET_REG_BITS == 64) {
             new_pool_l2(s, rel, s->code_ptr, add, val, val);
         } else {
-            new_pool_l4(s, rel, s->code_ptr, add, val, val, val, val);
+            new_pool_l4(s, rel, s->code_ptr, add,
+                        val >> 32, val, val >> 32, val);
         }
     }
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 4f1ed1d2fe..fc1c97d586 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -117,7 +117,7 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
 static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
                              TCGReg dst, TCGReg base, intptr_t offset);
 static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
-                             TCGReg dst, tcg_target_long arg);
+                             TCGReg dst, int64_t arg);
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc, unsigned vecl,
                            unsigned vece, const TCGArg *args,
                            const int *const_args);
@@ -133,7 +133,7 @@ static inline bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
     g_assert_not_reached();
 }
 static inline void tcg_out_dupi_vec(TCGContext *s, TCGType type,
-                                    TCGReg dst, tcg_target_long arg)
+                                    TCGReg dst, int64_t arg)
 {
     g_assert_not_reached();
 }
-- 
2.20.1


