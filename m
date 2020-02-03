Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB44C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:53:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49BB02082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LhDXlIAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BB02082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyd6c-00023A-Fw
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 09:53:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0m-0007Hv-I4
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0l-0003VD-D3
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:40 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38267)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iyd0l-0003Sh-6g
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:39 -0500
Received: by mail-wr1-x441.google.com with SMTP id y17so18550482wrh.5
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 06:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JSoxWa3cljnlHVlVCNXL6Dtt3Ft2EaSM4NkE+KvUy1o=;
 b=LhDXlIAYlGQoxULJ1aL2M2PuCCsffiUtg3+tzKF/REVKWhflCJhFA8uOeXArqL0m3F
 qhosnnxFxUxc2i5Csu6n0lIMKGN7rooh5G1V37CbjwIALt1kXUtcxNXBS09CfKarYUj4
 c3/CwQZIq3isofwbq+YbjXHixlrX44bJ/5Gh+pT2DdGB4LCpoikYNUeLB8MxyXlGRiHx
 4Y+KQW6S7HPJJhzTup/4t0FvdQE0n8iWv+YJkpehay5CfPTwwuhamRFfOmKxgs7h1tw0
 9z0POq6DN6VVOHbqq376TKDUZJYsfmi9/v+mTDQdOP39at0hj/nIA9dsLAaIQZOIJkif
 lcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JSoxWa3cljnlHVlVCNXL6Dtt3Ft2EaSM4NkE+KvUy1o=;
 b=AyykF46YKUA9HdIpmGAbF82TIXpmrlK1L2iUjor0B07AFZiOLmTiBnO6HXA6VEr2Dc
 y+Eghuv8ueAVPcablHvPinZNABI0xdCZKb6puSVgYBNWfO+5KC1f6TAZZ+ABl7ZIQtZM
 Hj17h6+8ZOBR3KjLjbVtINYxIRRQ5iRzG6FukUPtVyeOgwI6hMbDyne62rzIFhjij7rA
 Bg7EMfSp/WxdOYqce+mHe7JfDozNJYZbKfRM0SqRuZ15aEqULnk9/qONoLrYtcIBJ/RD
 ny7ZaE1mWlpBL/je4KKL9k3lSso9s4m2KZqbrMNkTebI4peFCNym5t2AJGmXZ3iCoMVp
 4wlw==
X-Gm-Message-State: APjAAAW28svzVpTdiZLuDhfX0Wfoc/UI3LNFDKIOfVr2A3Io5Ek440X5
 2HMz75fVyjZ2vOTMmHasz6+QcteLfEVh+g==
X-Google-Smtp-Source: APXvYqymT3gTO7OvOfzWpHn38gu8neTIBMaLCKiu1j+kZJrbo+DRvskBncCgjDynG3VgCBr3qanxGQ==
X-Received: by 2002:adf:f28c:: with SMTP id k12mr16876820wro.360.1580741257423; 
 Mon, 03 Feb 2020 06:47:37 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id h2sm26429739wrt.45.2020.02.03.06.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 06:47:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 19/20] target/arm: Implement UAO semantics
Date: Mon,  3 Feb 2020 14:47:15 +0000
Message-Id: <20200203144716.32204-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203144716.32204-1-richard.henderson@linaro.org>
References: <20200203144716.32204-1-richard.henderson@linaro.org>
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
index d847b0f40b..b24a6a6526 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12194,28 +12194,29 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
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


