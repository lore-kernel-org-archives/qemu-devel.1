Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AE5C35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A519C21775
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hq2l7CnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A519C21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0Pos-000081-RI
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 08:06:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41565)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Ph1-00011R-6m
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Ph0-0005Gq-6Z
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:39 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33984)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j0Pgz-0005FV-Vz
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:38 -0500
Received: by mail-wr1-x441.google.com with SMTP id t2so2072875wrr.1
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 04:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6QhxeX6zK49ooY7+NT0s0wBH571TqTaLG1uXkEqzD/o=;
 b=Hq2l7CnX356ZC7G1PTAnahBVSZo3OvL/OYoSzyHE/WdonV+n1MvYaqFAaiy2XWAzmM
 thh1CJrEgwoAQdewaE1jheTaJgVhz2Y/7Y7X2DdT+bzmG2RBX4A75UFr7tR6hLy0wkGg
 3yOUmLd7bxDrPk2QU6y7UlVh95Q0kRvY/L+lngPLZybdQ5peV+tWMlr/Ic4UZ5+veTwA
 sLYrH1RRAv/Wcj/yAcrg0xwESGkEOd4EIvc0t/yxqBRXNuuG0NH/S1XnUlggY8csy7YN
 fAcENAE5wHwkYFKD6ygVAEmwvEjyZfrbUJCMKUVQcqFQIC0EOnQPthUaMpSslaSfvyZt
 +mfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6QhxeX6zK49ooY7+NT0s0wBH571TqTaLG1uXkEqzD/o=;
 b=tZI/TbX4XPcJ+oX+aLgt1WEVoNM90n2WraZq4Q3y26qRmJf6jmN8ZWTe8uA/o8rJ2U
 arFEQubO4cZy/YtYMyYiJNZkGrXmy8iWjTLPiZW6cvBoTfLsYNhj/YhTkvZPV1vxSNep
 mQN1iHEb5Dng1y42lJ63HPUjSqMIF0gNO3ROeWjvGTugqiA1otiLRnVvQRc2Ga8xqzqY
 2uA501KytPuWh8pcGEOH93HqT+ELneVBG7ZGk6P8bljzj1Qy/7KQM6RXT2mxb9k6OlBN
 4faqQKSyn9uDIuXT5189V34QnAcUVQaO+8UtGrLO8+O1aPdkSQ2SU6dXgRpLZkEvGO3u
 GlCw==
X-Gm-Message-State: APjAAAVUM8J4VEWjrB29JqQ/AqVzY43SzCVNxvVS0NNKaGnaIRNcaMk3
 CfbF66TEIFk/V1OizXxB0JGN9QQ6BPezeA==
X-Google-Smtp-Source: APXvYqysnwPwR3kDWmxS47B1AeT/kt8g7XO2ZRsttxboT1xxqOlB96VEw+hM94gT9d5Bzg65zTeGAw==
X-Received: by 2002:a05:6000:50:: with SMTP id
 k16mr5105725wrx.145.1581166716838; 
 Sat, 08 Feb 2020 04:58:36 -0800 (PST)
Received: from localhost.localdomain ([82.3.55.76])
 by smtp.gmail.com with ESMTPSA id p5sm7490534wrt.79.2020.02.08.04.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 04:58:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 19/20] target/arm: Implement UAO semantics
Date: Sat,  8 Feb 2020 12:58:15 +0000
Message-Id: <20200208125816.14954-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200208125816.14954-1-richard.henderson@linaro.org>
References: <20200208125816.14954-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need only override the current condition under which
TBFLAG_A64.UNPRIV is set.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 11a5f0be52..366dbcf460 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12198,28 +12198,29 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
     }
 
     /* Compute the condition for using AccType_UNPRIV for LDTR et al. */
-    /* TODO: ARMv8.2-UAO */
-    switch (mmu_idx) {
-    case ARMMMUIdx_E10_1:
-    case ARMMMUIdx_E10_1_PAN:
-    case ARMMMUIdx_SE10_1:
-    case ARMMMUIdx_SE10_1_PAN:
-        /* TODO: ARMv8.3-NV */
-        flags = FIELD_DP32(flags, TBFLAG_A64, UNPRIV, 1);
-        break;
-    case ARMMMUIdx_E20_2:
-    case ARMMMUIdx_E20_2_PAN:
-        /* TODO: ARMv8.4-SecEL2 */
-        /*
-         * Note that E20_2 is gated by HCR_EL2.E2H == 1, but E20_0 is
-         * gated by HCR_EL2.<E2H,TGE> == '11', and so is LDTR.
-         */
-        if (env->cp15.hcr_el2 & HCR_TGE) {
+    if (!(env->pstate & PSTATE_UAO)) {
+        switch (mmu_idx) {
+        case ARMMMUIdx_E10_1:
+        case ARMMMUIdx_E10_1_PAN:
+        case ARMMMUIdx_SE10_1:
+        case ARMMMUIdx_SE10_1_PAN:
+            /* TODO: ARMv8.3-NV */
             flags = FIELD_DP32(flags, TBFLAG_A64, UNPRIV, 1);
+            break;
+        case ARMMMUIdx_E20_2:
+        case ARMMMUIdx_E20_2_PAN:
+            /* TODO: ARMv8.4-SecEL2 */
+            /*
+             * Note that EL20_2 is gated by HCR_EL2.E2H == 1, but EL20_0 is
+             * gated by HCR_EL2.<E2H,TGE> == '11', and so is LDTR.
+             */
+            if (env->cp15.hcr_el2 & HCR_TGE) {
+                flags = FIELD_DP32(flags, TBFLAG_A64, UNPRIV, 1);
+            }
+            break;
+        default:
+            break;
         }
-        break;
-    default:
-        break;
     }
 
     return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
-- 
2.20.1


