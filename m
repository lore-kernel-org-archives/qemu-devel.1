Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012B4C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:46:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFEA420720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N7aYYpbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFEA420720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04tR-0007t4-U2
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:46:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04iA-000175-5f
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04i9-0003QH-1G
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:26 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:54638)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04i8-0003Pn-Qx
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:24 -0500
Received: by mail-wm1-x32a.google.com with SMTP id g1so2787283wmh.4
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=W0Qpa2hYGMFldDVElC0iTJqXAjKbmW/746HYct4hLys=;
 b=N7aYYpbUvUZz765PoDU/8I01uaKGtR7VEYxW4PL/8sB9Z2Bw7EDQZNJRBXY2+pTQSi
 +yXXaKbsn3gcvkrnnCtfn4bNuT7K0cPsFrFmz4+yuWCoItv3K6CRpUJVOwJB3+NLyR3r
 mD88gmqwq7WdnG7octmZcq+/BKyUKPoMyBeyBjDLLP6uyDM6znrYsiaig1kS5BfU1BGa
 mqth5w8sp867rC3IaY8jgzgEsi4Bx8mKu4jgt7RZNWZb4dEW2Cbvj6mmA1T1napJb3Kd
 pCYNINg4VEl9tQ8OSH2nzyDphjjFfa/NrgY4IZMFrVLGYAZlO5Awq33+vPrDl6LgKJ6S
 FlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W0Qpa2hYGMFldDVElC0iTJqXAjKbmW/746HYct4hLys=;
 b=RFpNN6CSDDSCYIt0f3VbIUKoViTYu+MQOOVgak2Iy8z/pqPmSpmye47SCabXXyB+VL
 J8dQA9cknUQ1ENtsPsxeTWfDIcEqhpwf4DsNHM4Arhm+VT/ect/tsPiWh68jtCwNZv8q
 OSR7uBGXKLIvci4ur8/gCbxSwX2APbEVgsLVoaGPWMcyElmCdPfo+GDgh2DHM4SYzbJQ
 ZMX00z/tkt9KQ6azeo3l7+uksjaUEMxVXyXBGur2ac+EHqGXzKnRKPal3Bu07kjMwUuo
 oGrVYRf4pCRfoHGNWPNFXJxIYffzjtzsrZ0ZvXlv+aI3D1gLe27aMhOuW+FRiaNj/WpO
 DjMw==
X-Gm-Message-State: APjAAAVps37WtVWL0j8oNDdkzta0mUDAHAwo4XaL3K5U9Ja2JWlkQ0Ia
 SyJON0ozZYvBa9j+9eHM8cBx8Agq/8k=
X-Google-Smtp-Source: APXvYqymwiu5otYA1K+6ClI0OIRFmAi5o19rILdhAkUBcxvX7+qV8TGKOcqP+dvZQnY/NbJlQ/lqHA==
X-Received: by 2002:a1c:5445:: with SMTP id p5mr4655199wmi.75.1581086062881;
 Fri, 07 Feb 2020 06:34:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.34.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:34:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/48] target/arm: check TGE and E2H flags for EL0 pauth traps
Date: Fri,  7 Feb 2020 14:33:30 +0000
Message-Id: <20200207143343.30322-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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

From: Alex Bennée <alex.bennee@linaro.org>

According to ARM ARM we should only trap from the EL1&0 regime.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200206105448.4726-35-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/pauth_helper.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
index e0c401c4a9e..9746e32bf81 100644
--- a/target/arm/pauth_helper.c
+++ b/target/arm/pauth_helper.c
@@ -371,7 +371,10 @@ static void pauth_check_trap(CPUARMState *env, int el, uintptr_t ra)
     if (el < 2 && arm_feature(env, ARM_FEATURE_EL2)) {
         uint64_t hcr = arm_hcr_el2_eff(env);
         bool trap = !(hcr & HCR_API);
-        /* FIXME: ARMv8.1-VHE: trap only applies to EL1&0 regime.  */
+        if (el == 0) {
+            /* Trap only applies to EL1&0 regime.  */
+            trap &= (hcr & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE);
+        }
         /* FIXME: ARMv8.3-NV: HCR_NV trap takes precedence for ERETA[AB].  */
         if (trap) {
             pauth_trap(env, 2, ra);
-- 
2.20.1


