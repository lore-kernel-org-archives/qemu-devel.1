Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E69C4CECE
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:35:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9600D206B7
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QLp/FKO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9600D206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJmS8-0007Bv-BQ
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 18:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJJ-0006g8-NQ
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:25:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJI-0000rU-CP
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:25:57 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41783)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iJmJI-0000rA-7H
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:25:56 -0400
Received: by mail-pg1-x542.google.com with SMTP id t3so8924514pga.8
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 15:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=KJht3k8cNEabdOtAXgVHE9ekZLuMtQn0jx2AnG8ofpM=;
 b=QLp/FKO4M0qA4ADBqrRPJCQ/lN5iGSKIKF+VV3HuLOZQ+uzDkyPrgnuWEV8rK+bvQy
 sEVd4DlkgNSPibeACTWrAfLjhI+DvCOq8Vjg7nQW1E3pFsQdTmnOYUl69mlAVqOwHO/Z
 hUjorcnQDLxV/fHdt6YN4dD9I9DYOe726/1tXcoETs3CbMFMG5akXsizjGvLMECeF7le
 yuVqA50QrVdC6BvQiZHQaH3xQS1ZVIPZ4PHcAeDC2ML0yEC9ERi1gP/NkTc2dHUh8O1/
 0/KaM6Mb7hY31PAlUMx1maSjQOQ1maxmoFwaXrrT0q8CQyBM7IA1TJ5abENb4RSdZgYZ
 rnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=KJht3k8cNEabdOtAXgVHE9ekZLuMtQn0jx2AnG8ofpM=;
 b=VUftQbQk19m8xmBmrR2W25s2lXer2O2uoapPZgZtshUaunZnYiLoIQZ7y+KVZUgFTk
 35CD9y56Mk0vZbkRdxhTKL8gNCBq76nq/9kNEmJJcdyA7R0j/rNiL0kLM8uEdlNkQRXf
 CFDzt2TdQEqk8UqH/OxZ7azvEwUeeTrAPiCT/DDI7tOKxepJFveKxHYAaO+TWwRSafs7
 WspVjo6KDKX01msuYZwHu2uAOYl/0HAthq/to0NFM9pWBr2GWNo6C5pOwDv0znbr51EI
 ELjVE6HGFvRrQ7RLvjU05bfoZ5GJGP1p0gVi9o8UuVLX2hlNTTi+xZrXHP12uEJyGNCN
 jO2Q==
X-Gm-Message-State: APjAAAWQgqZgih7HsfOa3VVIJUjdbc9xH9jpCiIHOVnF0O5y0+QOXF+3
 NDcDu1kAmFQvbpWndY1dWdzWozL9vco=
X-Google-Smtp-Source: APXvYqx4ek9+WtgzH34BPTQRE2NhHP8MLiJmEIQmtMcEVTufu/5yZjdLSJp2V2c4OgwV7p2gTi3HXA==
X-Received: by 2002:a63:9751:: with SMTP id d17mr10324393pgo.427.1571005554792; 
 Sun, 13 Oct 2019 15:25:54 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d76sm15940571pfd.185.2019.10.13.15.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2019 15:25:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/23] tcg/ppc: Replace HAVE_ISEL macro with a variable
Date: Sun, 13 Oct 2019 15:25:27 -0700
Message-Id: <20191013222544.3679-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191013222544.3679-1-richard.henderson@linaro.org>
References: <20191013222544.3679-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Previously we've been hard-coding knowledge that Power7 has ISEL, but
it was an optional instruction before that.  Use the AT_HWCAP2 bit,
when present, to properly determine support.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.inc.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 7cb0002c14..db28ae7eb1 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -65,8 +65,7 @@
 static tcg_insn_unit *tb_ret_addr;
 
 TCGPowerISA have_isa;
-
-#define HAVE_ISEL      have_isa_2_06
+static bool have_isel;
 
 #ifndef CONFIG_SOFTMMU
 #define TCG_GUEST_BASE_REG 30
@@ -1100,7 +1099,7 @@ static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
     /* If we have ISEL, we can implement everything with 3 or 4 insns.
        All other cases below are also at least 3 insns, so speed up the
        code generator by not considering them and always using ISEL.  */
-    if (HAVE_ISEL) {
+    if (have_isel) {
         int isel, tab;
 
         tcg_out_cmp(s, cond, arg1, arg2, const_arg2, 7, type);
@@ -1203,7 +1202,7 @@ static void tcg_out_movcond(TCGContext *s, TCGType type, TCGCond cond,
 
     tcg_out_cmp(s, cond, c1, c2, const_c2, 7, type);
 
-    if (HAVE_ISEL) {
+    if (have_isel) {
         int isel = tcg_to_isel[cond];
 
         /* Swap the V operands if the operation indicates inversion.  */
@@ -1247,7 +1246,7 @@ static void tcg_out_cntxz(TCGContext *s, TCGType type, uint32_t opc,
     } else {
         tcg_out_cmp(s, TCG_COND_EQ, a1, 0, 1, 7, type);
         /* Note that the only other valid constant for a2 is 0.  */
-        if (HAVE_ISEL) {
+        if (have_isel) {
             tcg_out32(s, opc | RA(TCG_REG_R0) | RS(a1));
             tcg_out32(s, tcg_to_isel[TCG_COND_EQ] | TAB(a0, a2, TCG_REG_R0));
         } else if (!const_a2 && a0 == a2) {
@@ -2795,6 +2794,14 @@ static void tcg_target_init(TCGContext *s)
     }
 #endif
 
+#ifdef PPC_FEATURE2_HAS_ISEL
+    /* Prefer explicit instruction from the kernel. */
+    have_isel = (hwcap2 & PPC_FEATURE2_HAS_ISEL) != 0;
+#else
+    /* Fall back to knowing Power7 (2.06) has ISEL. */
+    have_isel = have_isa_2_06;
+#endif
+
     tcg_target_available_regs[TCG_TYPE_I32] = 0xffffffff;
     tcg_target_available_regs[TCG_TYPE_I64] = 0xffffffff;
 
-- 
2.17.1


