Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21E8C432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:39:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 692B120684
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="clOw8n7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692B120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iby5p-00044V-71
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 21:39:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxwi-000329-5w
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:29:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxwg-00082i-RA
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:29:47 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35153)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibxwg-00081I-LK
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:29:46 -0500
Received: by mail-pf1-x444.google.com with SMTP id b19so991719pfo.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 18:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B4OK5efhSNwYjg2uPjOpVrsLC64wOt5gZm1Hay36cdk=;
 b=clOw8n7wldm1zRwqprAH0AohlYp0Z82dbX+3fEU1Q3IGgXz6GVClQNHF1CSaIj68/6
 8BA/KuvYj4WnZzWSuMJVU7z9v+GbDzq3mbiYpV5jbfHQNHdhH8BzQS2E2F2akJqPcigw
 eVTRar3ZaWAL40y3xcRMpxhWXE4+hiPyYRF6d+vHWBklyPydLP98o63d4/T/yi4LltRC
 jNOJmeMD3PV/EGT+ez6X+hsb9Uk2MeDVM9y+qS2exz7tfAzqPafomdtQMzb1uKGN/h4x
 tbfFDYORuqjfxax7+kw30tE3SKNtBPo5xTtb5m1E4j9DL+ZSNlkvusRLqI0nf5C8UZoj
 HJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B4OK5efhSNwYjg2uPjOpVrsLC64wOt5gZm1Hay36cdk=;
 b=DIRSpbWiNoSuCEXtVCeh2Wvlx/qME/wIp0Eo2Q83WRmiXDCDdKNNa4sT2IQzJyPyIx
 +UxXSYDk8kJ76MNVpXJPWOxF7ZP6biL/N47Q7S+Cjz7ma7S2vuGWEXbLcxpeLQN/EQ8H
 +wGqVxE3M5NrhPNP9lncnwdZBA9mPLCwi3UzmHYyOC20xFqFtGmtTVCU157aKDxl42r9
 RmP6DvbHVKlZ51yQJooERHnNkmYzpo22+iEemq0UFNVsG3MWewFaTXhahlU3OjL9A8rx
 VA9476OSIwE5oL6EO6DlKB3WEAXwktCzLJxMtz0nsJoDlPu5WfFEBL76tsqHqZimfDnz
 eDLw==
X-Gm-Message-State: APjAAAXpOQcldsdJXZe+VjQkM44aOfBVpD9b3IrS9y2rolYsbzuc1Xnh
 IZ8pbS5GHjMOWJ69w9nkC+xeBibhBxI=
X-Google-Smtp-Source: APXvYqyf6mLa6Rmqb19Fu9HGxekCaIwUYBcXwtxvw04TJyHn3shdulXF2ldjDVwS0Bli15Zt6Wa/rg==
X-Received: by 2002:a63:5346:: with SMTP id t6mr2545902pgl.302.1575340185457; 
 Mon, 02 Dec 2019 18:29:45 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm873695pfg.170.2019.12.02.18.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 18:29:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 05/40] target/arm: Update CNTVCT_EL0 for VHE
Date: Mon,  2 Dec 2019 18:29:02 -0800
Message-Id: <20191203022937.1474-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203022937.1474-1-richard.henderson@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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

The virtual offset may be 0 depending on EL, E2H and TGE.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 06ec4641f3..731507a82f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2475,9 +2475,31 @@ static uint64_t gt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return gt_get_countervalue(env);
 }
 
+static uint64_t gt_virt_cnt_offset(CPUARMState *env)
+{
+    uint64_t hcr;
+
+    switch (arm_current_el(env)) {
+    case 2:
+        hcr = arm_hcr_el2_eff(env);
+        if (hcr & HCR_E2H) {
+            return 0;
+        }
+        break;
+    case 0:
+        hcr = arm_hcr_el2_eff(env);
+        if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
+            return 0;
+        }
+        break;
+    }
+
+    return env->cp15.cntvoff_el2;
+}
+
 static uint64_t gt_virt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    return gt_get_countervalue(env) - env->cp15.cntvoff_el2;
+    return gt_get_countervalue(env) - gt_virt_cnt_offset(env);
 }
 
 static void gt_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -2492,7 +2514,13 @@ static void gt_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static uint64_t gt_tval_read(CPUARMState *env, const ARMCPRegInfo *ri,
                              int timeridx)
 {
-    uint64_t offset = timeridx == GTIMER_VIRT ? env->cp15.cntvoff_el2 : 0;
+    uint64_t offset = 0;
+
+    switch (timeridx) {
+    case GTIMER_VIRT:
+        offset = gt_virt_cnt_offset(env);
+        break;
+    }
 
     return (uint32_t)(env->cp15.c14_timer[timeridx].cval -
                       (gt_get_countervalue(env) - offset));
@@ -2502,7 +2530,13 @@ static void gt_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
                           int timeridx,
                           uint64_t value)
 {
-    uint64_t offset = timeridx == GTIMER_VIRT ? env->cp15.cntvoff_el2 : 0;
+    uint64_t offset = 0;
+
+    switch (timeridx) {
+    case GTIMER_VIRT:
+        offset = gt_virt_cnt_offset(env);
+        break;
+    }
 
     trace_arm_gt_tval_write(timeridx, value);
     env->cp15.c14_timer[timeridx].cval = gt_get_countervalue(env) - offset +
-- 
2.17.1


