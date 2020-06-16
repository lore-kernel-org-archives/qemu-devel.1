Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1471C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:25:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AC1520707
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sw7pWtSr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC1520707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlFKe-00087w-QO
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 13:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF5I-0001uJ-7E
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:09:16 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38846)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF5G-0007Z7-9t
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:09:15 -0400
Received: by mail-wr1-x442.google.com with SMTP id e1so21601784wrt.5
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 10:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CA/am0GygyJkpXmDs56auXtZMrbcHbWGBURQkVmFBWU=;
 b=sw7pWtSrf1H8ttGQBjWunzN20yqFiAQAyxD/DQ7UwNmojcDHLDaQZyb3XevNUKUiTZ
 E+xco2zzKuA7PImp8kyXQ5YCsbMjXWxr1zYNMVTVWZhcWbmtlngfjLA/aR/ki5Zl6Yhd
 yM0PJTIWFYql9UZUTk3jD5B1XQA8gdYr9Vp0SWWC2BbBI8zY1iaQ0LIJqQxKs4wBz/zh
 QAsgDYDQUYJJw5lVYX196/md5eH0rdOyl59KD6WVwnkiCOBwFvTC3p837+ayju5ZRCX/
 mPq0pG69axg5NVe5aQLaIIFeN4ZPifXEZsIT4BF3GtCkSM6uancGYipMkruCiGRe8bOz
 ILww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CA/am0GygyJkpXmDs56auXtZMrbcHbWGBURQkVmFBWU=;
 b=sXU9sYX4Wmk8ixKRxGXC00COYTNZW9PE4hqv9/YQ37BzFnrfK2IeW8DSx2TTnzw3pc
 4kQ951ScMlv6X/FI7NbU2GEExFv4/d7A5zVEh212qRo4vh23ACqyfDyEM6byGXb7vhjv
 e+2lL62d3iY2v/dJsOLwf9XlZB/DaHBVa9ivwwKhdvDizvU2e7uCjpy0NubPfmgsVfKu
 EuRmH+eNqCFs3inqpmnTB+p5DHLmS5uE5ZKN4ADD+qwqeULByPC9vDdB0pyqwVTJ9gdd
 4dKHtweQ33rqzF4g0E4eRk7SGVwXqzaXAuHNfOtU9fBdUdqPiJ3vB/UEZoVS/AhzLPrv
 d7bw==
X-Gm-Message-State: AOAM530VM8vsxSTFcEfbKnZ4uqc3ZrsuR5Db5PlZ7ZcGhIh49i0AHN/v
 nEWqdR+UvtciEeJrPGFu+AF+aA==
X-Google-Smtp-Source: ABdhPJxfZhu/gCTaaG0kEWnfYxV0CAont2woyconsfcVZcBq0Ofi/ldrXd0qWnaavHtSjIux/KemWA==
X-Received: by 2002:adf:e883:: with SMTP id d3mr4040993wrm.274.1592327351748; 
 Tue, 16 Jun 2020 10:09:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y80sm5263216wmc.34.2020.06.16.10.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 10:09:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 19/21] target/arm: Convert Neon VSWP to decodetree
Date: Tue, 16 Jun 2020 18:08:42 +0100
Message-Id: <20200616170844.13318-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616170844.13318-1-peter.maydell@linaro.org>
References: <20200616170844.13318-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the Neon VSWP insn to decodetree. Since the new implementation
doesn't have to share a pass-loop with the other 2-reg-misc operations
we can implement the swap with 64-bit accesses rather than 32-bits
(which brings us into line with the pseudocode and is more efficient).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-dp.decode       |  2 ++
 target/arm/translate-neon.inc.c | 41 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          |  5 +---
 3 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 5507c3e4623..2f64841de52 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -488,6 +488,8 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
     VABS_F       1111 001 11 . 11 .. 01 .... 0 1110 . . 0 .... @2misc
     VNEG_F       1111 001 11 . 11 .. 01 .... 0 1111 . . 0 .... @2misc
 
+    VSWP         1111 001 11 . 11 .. 10 .... 0 0000 . . 0 .... @2misc
+
     VUZP         1111 001 11 . 11 .. 10 .... 0 0010 . . 0 .... @2misc
     VZIP         1111 001 11 . 11 .. 10 .... 0 0011 . . 0 .... @2misc
 
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 29bc161f36a..01da7fad462 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -3927,3 +3927,44 @@ DO_VCVT(VCVTPU, FPROUNDING_POSINF, false)
 DO_VCVT(VCVTPS, FPROUNDING_POSINF, true)
 DO_VCVT(VCVTMU, FPROUNDING_NEGINF, false)
 DO_VCVT(VCVTMS, FPROUNDING_NEGINF, true)
+
+static bool trans_VSWP(DisasContext *s, arg_2misc *a)
+{
+    TCGv_i64 rm, rd;
+    int pass;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if (a->size != 0) {
+        return false;
+    }
+
+    if ((a->vd | a->vm) & a->q) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    rm = tcg_temp_new_i64();
+    rd = tcg_temp_new_i64();
+    for (pass = 0; pass < (a->q ? 2 : 1); pass++) {
+        neon_load_reg64(rm, a->vm + pass);
+        neon_load_reg64(rd, a->vd + pass);
+        neon_store_reg64(rm, a->vd + pass);
+        neon_store_reg64(rd, a->vm + pass);
+    }
+    tcg_temp_free_i64(rm);
+    tcg_temp_free_i64(rd);
+
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index b0181062020..e8cd4a9c61f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4944,6 +4944,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 case NEON_2RM_VCVTPS:
                 case NEON_2RM_VCVTMU:
                 case NEON_2RM_VCVTMS:
+                case NEON_2RM_VSWP:
                     /* handled by decodetree */
                     return 1;
                 case NEON_2RM_VTRN:
@@ -4965,10 +4966,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     for (pass = 0; pass < (q ? 4 : 2); pass++) {
                         tmp = neon_load_reg(rm, pass);
                         switch (op) {
-                        case NEON_2RM_VSWP:
-                            tmp2 = neon_load_reg(rd, pass);
-                            neon_store_reg(rm, pass, tmp2);
-                            break;
                         case NEON_2RM_VTRN:
                             tmp2 = neon_load_reg(rd, pass);
                             switch (size) {
-- 
2.20.1


