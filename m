Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78847C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4337120716
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="on4o/zGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4337120716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxKD-0007kf-CR
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 19:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCU-0004Ba-JJ
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCT-0008Fw-E0
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:50 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37261)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwxCQ-000883-4k
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:49 -0500
Received: by mail-pg1-x544.google.com with SMTP id q127so650647pga.4
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qRKwqyVud14kmLqcBJZ9BOc7sQ/amtWCt21hXg2UNtM=;
 b=on4o/zGUYgNqRKSks1mmwPFQd2ioIxvx3Q0OMSb/fvonp+3RiI2G9ut3MbXHj0Rcg4
 qsWkXai61NxzA4RDD3IBtTR+GNDqkL1OgqR35ngqCzssokXyEeL2WuYF90kFv+nLMjDs
 f24xtJ5iYKW/5yjRbWTtbesmldLhH4GAG5umTaayvEVoFBzERBdB1VhFShk/aIi54IAf
 mFYDKLa6VFK4xwawtG8lBbiZwyUZ57h8UgP/SKafgfnlvcxDz1yRhknp4jNZtWMoKhW0
 7LlNlg9Y25MaN+eA/6FS8asj9cEd+D6du9vlSRnejnbr8YLCTMxhIrj4W69FCxo0VlVi
 G34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qRKwqyVud14kmLqcBJZ9BOc7sQ/amtWCt21hXg2UNtM=;
 b=jB4QnXWKQfsYi8wombvSKmHm9/LYl+8MPuG7Rx//EHofJHoSXvFl8wH5BWWmAJJOMD
 SaLLIwUPFd54PRJZXFpNapTtdYgiJc+4iXoypwj5Zw4H+gH7gEVnW97w3LALQgIUjBWG
 sqWv63djhM0ILYK6/15dzGScTbugrpj9LMubJN2aFH+2HyRZxtMT6Efl+4SwXxdH1kxd
 JuFAQlyVnWZV1kNnzilR9/vWoGJTYlYbg5yG2/JxiltoXd+NlWSVDAqgWtxGr1FYu0Kr
 S7KhzLUQ5fl1EeIHp1hmwQy7qQwur/Zk3KxCC8p301q0afBBdouzJ6gWx5VVAgESejIy
 4Gzw==
X-Gm-Message-State: APjAAAXg4rWv/SIAMUZmnJOc9h7feNP6qdMyNm72YkWPNyvUrNDKJJK2
 9Cjzw5x1ys+QS1hUREUCksnjUriWsVA=
X-Google-Smtp-Source: APXvYqwFx8FMeDStpEeg/Q6ALLJfz7hOCe7LIQxt/sNaXjfxxokyXoWaoW7afAp0zkjvh6GsehrdtA==
X-Received: by 2002:a63:7119:: with SMTP id m25mr1716444pgc.131.1580342204867; 
 Wed, 29 Jan 2020 15:56:44 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm3953626pfg.145.2020.01.29.15.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:56:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 23/41] target/arm: Update aa64_zva_access for EL2
Date: Wed, 29 Jan 2020 15:55:56 -0800
Message-Id: <20200129235614.29829-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129235614.29829-1-richard.henderson@linaro.org>
References: <20200129235614.29829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The comment that we don't support EL2 is somewhat out of date.
Update to include checks against HCR_EL2.TDZ.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 37ea382050..33f4cbbc64 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4159,11 +4159,27 @@ static void tlbi_aa64_ipas2e1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static CPAccessResult aa64_zva_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                       bool isread)
 {
-    /* We don't implement EL2, so the only control on DC ZVA is the
-     * bit in the SCTLR which can prohibit access for EL0.
-     */
-    if (arm_current_el(env) == 0 && !(env->cp15.sctlr_el[1] & SCTLR_DZE)) {
-        return CP_ACCESS_TRAP;
+    int cur_el = arm_current_el(env);
+
+    if (cur_el < 2) {
+        uint64_t hcr = arm_hcr_el2_eff(env);
+
+        if (cur_el == 0) {
+            if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
+                if (!(env->cp15.sctlr_el[2] & SCTLR_DZE)) {
+                    return CP_ACCESS_TRAP_EL2;
+                }
+            } else {
+                if (!(env->cp15.sctlr_el[1] & SCTLR_DZE)) {
+                    return CP_ACCESS_TRAP;
+                }
+                if (hcr & HCR_TDZ) {
+                    return CP_ACCESS_TRAP_EL2;
+                }
+            }
+        } else if (hcr & HCR_TDZ) {
+            return CP_ACCESS_TRAP_EL2;
+        }
     }
     return CP_ACCESS_OK;
 }
-- 
2.20.1


