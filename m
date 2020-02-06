Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FEEC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:09:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2645E206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U/vGI36Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2645E206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izf2V-0005kx-9P
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:09:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoe-0003Ss-9h
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoc-0008Rz-8u
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:24 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39499)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izeoa-0008II-BY
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:22 -0500
Received: by mail-wr1-x441.google.com with SMTP id y11so6578298wrt.6
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 02:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rHwW2MijaLV3MYZXc94ajn3WaeSF6QeB769XQ1wido8=;
 b=U/vGI36ZJxez1Xp5AtXmAgmNMwFPq5MvVL14xaoHRiGc0zxTZchO4DYR6uGthZ28wu
 0zb+HcWb7fS+vLMHsOMc4JWpRI9YZAEiUaL2+k1z8Z1iX+D3h/sG5oBYL3VHvdsm4ZWA
 /LlSfaXS+OQCPIgIhfWIxBARnEL+qs+VUqOUimWDcpCrLkP5G2qrvO5cTrXpOfsWqLvk
 Bsrm5cKmPj9mEdUcPZk5GjRP5NFyO1AyhFxHS3wibWhRottv8tORHMF999NHCsm6o3Dn
 Q+7cTNQY8eYUcymZ02x9FWtfDH9RwTAD/WhjdURQ+zAofXbJr3cco57MvtUfgcERzOi/
 CJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rHwW2MijaLV3MYZXc94ajn3WaeSF6QeB769XQ1wido8=;
 b=EB+Rg58eXzq5ZEr2FWQtdLbUqAEO2BHh/YgijT2RCEoIIDHzzo5+k2cZT6eD86cYXJ
 MxB7tKk6bMwCrHhJ9acLfN9UGOcOLGUI1PFhGTnLw8MyVGKOaO3y45+t9tTrNGDOhf1k
 x/6N57kTZUyel/AD3W67+pmBCIvLqNLSIe+pqhaGAOlfcdBwhpzpUVTunWftRZM5emAJ
 muD4m8yE/L3rp9O8fz3SVTZFMmUQUlu9upalIgrdYagEw22hRF/5RfTs59WmNPbQjkVG
 qh7o/9qQRdoWTofNEF97tW4jc672AVo1PasQbcD4+Pw/U0f7GugMlGt5x2YHc8vxYdZz
 +ssQ==
X-Gm-Message-State: APjAAAVvt1JRs6+Ok5W8asQA/Zmt4gOp0E7JLgM24RmGm0hTV9TXl5+C
 LHv69WCZfd8UEmzF5hTR3fcmv+VpAGF/6w==
X-Google-Smtp-Source: APXvYqxv25c9vxHmP7dzbs+bmhsHjamKFFdCNlBPgYeCLzw0NaqwefjADwYO8uTaWQO6ZcYcYlkKjA==
X-Received: by 2002:adf:f586:: with SMTP id f6mr3123651wro.46.1580986519001;
 Thu, 06 Feb 2020 02:55:19 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id m21sm3364995wmi.27.2020.02.06.02.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 02:55:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 34/41] target/arm: check TGE and E2H flags for EL0 pauth
 traps
Date: Thu,  6 Feb 2020 10:54:41 +0000
Message-Id: <20200206105448.4726-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206105448.4726-1-richard.henderson@linaro.org>
References: <20200206105448.4726-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Bennée <alex.bennee@linaro.org>

According to ARM ARM we should only trap from the EL1&0 regime.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/pauth_helper.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
index e0c401c4a9..9746e32bf8 100644
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


