Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C75C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:34:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56A9F2082C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="csH9Zwa5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A9F2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39754 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbPrj-00008Q-IL
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 09:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59736)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdu-0008Tf-22
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdh-0004ur-S8
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:43 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:44903)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOdc-0004iv-Dp
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:29 -0400
Received: by mail-wr1-x42f.google.com with SMTP id r16so1385216wrl.11
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=dlG/h4e/09Nwqt8ZUUNPJpFZPx9E3DXWrZDW3I5mo2w=;
 b=csH9Zwa5FP+jekeVGIuXk6esmvwkb7NPhHCyy6TpP5TcfS5mIFRnAHLZGqOO5YPoGr
 CyPO/Rtd3RGwN/a9QbxgX8w+EHReSxLaZ6J7wcWhJKk3ueuRJC2KSuaB99qnHjNXHXGv
 9rWHlohSW12bt0Y6QoGir2HCHP9Dk1ZgrPo5gQ1yvFjV1uFSEhFeY3bVDynq6Ch4K2tJ
 XvRqsW1ZJR6wePcYhZeihTxID4JCCYY9mimCU7uXW9DxsIAaaXe6KjPMLr5XGjS9sq3A
 tue4ESCnF3yoftZGBC/Q4EJKwu/3GRyfc7r2Qcz2hSKs5xxpwT1wOBdYiR7iJlLDo1ya
 Okqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dlG/h4e/09Nwqt8ZUUNPJpFZPx9E3DXWrZDW3I5mo2w=;
 b=c+DZznvtUkSk/EqNeQod8dL/ylOtvfb56v5B28uDarFVG+rrW2s5ofRD6ZZJ3bjss+
 N+pvMkXjChSvlnp/w8ADDiReo/3Bg2fWwa6puUOhcXhvLL3MRt031RlS4tGWpYUnHBVF
 fPgOWxLM78Q4YdLC8dH5HVkvLQdF9h/IzjF7KNRKok0FCJ5lMifQsndGgfPfrl/nXAcP
 dOYGRw5hK7tNtH+f9LWWwBTQ2Q6tQ6UJOPht0xCLx3Nk3WL9y1qj5NTmzoCKycotWqvw
 pk4vvZIMNTtGrMUY5braebgkMGbDT7qPy08igWPA8k2GO8mQDS+EF2NWHfjey/lJhu8c
 3N9w==
X-Gm-Message-State: APjAAAWdpIvwZCxTakdpF/n+gWFRBr9cCaR9vGxE5Oy/Ah9tAzHzUhU6
 CiYfp2hcCPtQ3DxOI1bPPgS8lmxnQ53FrQ==
X-Google-Smtp-Source: APXvYqzg0Ja3i0yfIjsrEeT3203wwLiGkHYdUdndF5JzYicNmCuNP7Ngq0JQwY0OGJA6KtuLEN2pRQ==
X-Received: by 2002:adf:e8cb:: with SMTP id k11mr58142015wrn.244.1560428122859; 
 Thu, 13 Jun 2019 05:15:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.15.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:15:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:14:30 +0100
Message-Id: <20190613121433.5246-46-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
Subject: [Qemu-devel] [PULL 45/48] target/arm: Convert VJCVT to decodetree
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

Convert the VJCVT instruction to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 28 ++++++++++++++++++++++++++++
 target/arm/translate.c         | 12 +-----------
 target/arm/vfp.decode          |  4 ++++
 3 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index cc3f61d9c41..161f0fdd888 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -2426,3 +2426,31 @@ static bool trans_VCVT_int_dp(DisasContext *s, arg_VCVT_int_dp *a)
     tcg_temp_free_ptr(fpst);
     return true;
 }
+
+static bool trans_VJCVT(DisasContext *s, arg_VJCVT *a)
+{
+    TCGv_i32 vd;
+    TCGv_i64 vm;
+
+    if (!dc_isar_feature(aa32_jscvt, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vm & 0x10)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    vm = tcg_temp_new_i64();
+    vd = tcg_temp_new_i32();
+    neon_load_reg64(vm, a->vm);
+    gen_helper_vjcvt(vd, vm, cpu_env);
+    neon_store_reg32(vd, a->vd);
+    tcg_temp_free_i64(vm);
+    tcg_temp_free_i32(vd);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index da4d4e9d012..d5347c55ad4 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3050,7 +3050,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 return 1;
             case 15:
                 switch (rn) {
-                case 0 ... 17:
+                case 0 ... 19:
                     /* Already handled by decodetree */
                     return 1;
                 default:
@@ -3085,13 +3085,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                     rm_is_dp = false;
                     break;
 
-                case 0x13: /* vjcvt */
-                    if (!dp || !dc_isar_feature(aa32_jscvt, s)) {
-                        return 1;
-                    }
-                    rd_is_dp = false;
-                    break;
-
                 default:
                     return 1;
                 }
@@ -3177,9 +3170,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 switch (op) {
                 case 15: /* extension space */
                     switch (rn) {
-                    case 19: /* vjcvt */
-                        gen_helper_vjcvt(cpu_F0s, cpu_F0d, cpu_env);
-                        break;
                     case 20: /* fshto */
                         gen_vfp_shto(dp, 16 - rm, 0);
                         break;
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 6da9a7913da..1a7c9b533de 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -220,3 +220,7 @@ VCVT_int_sp  ---- 1110 1.11 1000 .... 1010 s:1 1.0 .... \
              vd=%vd_sp vm=%vm_sp
 VCVT_int_dp  ---- 1110 1.11 1000 .... 1011 s:1 1.0 .... \
              vd=%vd_dp vm=%vm_sp
+
+# VJCVT is always dp to sp
+VJCVT        ---- 1110 1.11 1001 .... 1011 11.0 .... \
+             vd=%vd_sp vm=%vm_dp
-- 
2.20.1


