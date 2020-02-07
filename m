Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DBFC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:41:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E4E521741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CfCO/UYb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4E521741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04p8-00078h-Ke
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:41:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04he-0008FK-Vl
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:33:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hd-0002Q6-Fw
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:33:54 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40010)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04hd-0002Mw-9X
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:33:53 -0500
Received: by mail-wm1-x343.google.com with SMTP id t14so2990209wmi.5
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Jao/xEGUWWybaAe9JIFeCQwc4HndZ45KTdA+bMec2T8=;
 b=CfCO/UYbv1fYdo06QVoNZHJnVc40Yj5C7DS8Y8iWzFC29NUCWkgramczSTn90Zz5w7
 xy20Sxxo74X3N34TW1B4UW3nZ1cNagk2NSg78WCRkuQu88rmF7ULHB9GIS7RKZXlSR64
 JAHEcE3/D4qQ1og81w6hBFYf8WaslJj2Xcxt0lMebKj06wDlI6ua1bg9CiJOOfk+nox3
 wv71MxbrrL2DbbNbwTv2CsXKAO5+lANghzmGcbdF9WMklKVkAE0fVUZKyJj7uqzkCvNh
 7Na7F0nPQmFZLw7aSTDAKMUTcIStWrBGCFyF8LThX6n2ddeRNTCoIPH8tkXWPwX+czQM
 NkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Jao/xEGUWWybaAe9JIFeCQwc4HndZ45KTdA+bMec2T8=;
 b=mp33Ht59ex2iiZF3+qlRFjuM1q0HtQ4FpITRKqB0bSRsSgqYbKIciB9VG28bOnnwOx
 HbhYekiqTXg0QMcOvxOVZaPUQePcBLxQFEkhqHqcfzZvhj8pE09/LBoHxbOPtXZY8rkO
 X730ZT28JqH6k8cCwFGennTg7hmtoCmxGqkcrlpM+J8nagyC6zwDvnpPgRJCalOPPMVx
 p+BjJtdny2vwgfFTs0eHZflxZuYKyJJz0kk0W4uid4r/K0WNLW9sWDBdQcTjR9OX/g6r
 QJ5v7YslnQW2XJr32fq7YCGWF25YnXhOMlKMJ5soXLgAFVn7HrWLE5QF92RhtSVWSD6Y
 OPGw==
X-Gm-Message-State: APjAAAU1V15KuM/8uGxTi0WPgC2FehdCRCUQQoP+GGuQM+/F5VzI7kdn
 FNQGffpxY2A3LRh86/8nAS2cOaBwMJc=
X-Google-Smtp-Source: APXvYqxGLOkWyoM0qUxQCsbPiq+x533ZORX8rIjNyc6n4J+eYo7s/NZ6lIG6wykdTC85BbhvZD+5Aw==
X-Received: by 2002:a1c:dfd6:: with SMTP id w205mr4780123wmg.151.1581086031968; 
 Fri, 07 Feb 2020 06:33:51 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.33.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:33:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/48] target/arm: Update CNTVCT_EL0 for VHE
Date: Fri,  7 Feb 2020 14:33:01 +0000
Message-Id: <20200207143343.30322-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

From: Richard Henderson <richard.henderson@linaro.org>

The virtual offset may be 0 depending on EL, E2H and TGE.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200206105448.4726-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c7ee0d603f4..dbfdf2324b4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2515,9 +2515,31 @@ static uint64_t gt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
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
@@ -2532,7 +2554,13 @@ static void gt_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
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
@@ -2542,7 +2570,13 @@ static void gt_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
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
2.20.1


