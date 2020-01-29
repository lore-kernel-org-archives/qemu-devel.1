Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FF7C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:13:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B269D2070E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yuH0JFfT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B269D2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxSz-0007Mx-VN
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 19:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCj-0004Wj-J9
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:57:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCi-0000NO-K5
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:57:05 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41627)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwxCi-0000Jp-DT
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:57:04 -0500
Received: by mail-pf1-x444.google.com with SMTP id w62so487241pfw.8
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SGeLc3qxQKehoU2r6strpWrIYiHy87e8XV3hfYvH5nc=;
 b=yuH0JFfTChQoH7NzGD+5AmfG5ugXTRNY1y4EazBqd9Ob5pNRM5NwYxuCfwHgY14gel
 +xRdy8G69qPJGN4C7PSyhu22GK18Y21efOmSXfRdTzQSzRVi7h+Oy+xB2aI2gAkmaKpJ
 P+nV4u816s31byIbNNaFJtQQ8xoVrufn5q8a1bclpA/JsB7hWBXrg7whhswhdgNuAJtk
 e3PnVkzy24Upq/cQ0jsJX2lN1MBkEzcxlH0wQHi+GX2uZ+LgvXGX44Ht59M7PIPGZyo8
 lXkfyGHwD0ymz9P+U3zMqZZ3Od2F+TntXbdXSXAxJuplo3parGxriJ3oTl3lKU7pQI6H
 OIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SGeLc3qxQKehoU2r6strpWrIYiHy87e8XV3hfYvH5nc=;
 b=NRUIVHFHi372JEW05HX+Zda17vkylEKpckSIhDXs+ExU0VRVxP+neEkFl8gKNdA5bv
 QMCjce2diXiShPKCCd6Rs72ow5aQ5AyPSDXxwguxOVndsZrrd0P5DQEirGT+46g1/pH9
 f5ZUhFQhHMeghpw/XB6D4jJKOOj+iApgqAW+UulH5jtmBEu3TjKm3KRAmhtbHIIzTguT
 bT99uvc4Rty7ThIcA1DKSsvvw7UoCerFJ0ItzcKhjBbZaSUaOAlzRB0JB/CVG2O+DfXD
 Vr/OkGyh+ev0r+jq4PSXOPPCNKRkhzbnOwR29fqwaB3lmkNmo2iQtiYM469XjPBHhkpL
 LKiw==
X-Gm-Message-State: APjAAAVin8oM5jdkF24Q28JzgpVfnjh/CME8GaCFJdVefEGiTARZg1FG
 jomG9AY+jgWa/LXrrfhi5PFXkgGF4Ek=
X-Google-Smtp-Source: APXvYqwtid2ZGp6kVWRPtfWoyiFrnVftatvzQ+nD3KFLox5eZHq9QE0/+KRLKDkzfbHkG+e7VHZWXg==
X-Received: by 2002:aa7:8149:: with SMTP id d9mr2057401pfn.170.1580342221881; 
 Wed, 29 Jan 2020 15:57:01 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm3953626pfg.145.2020.01.29.15.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:57:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 36/41] target/arm: Update arm_cpu_do_interrupt_aarch64 for
 VHE
Date: Wed, 29 Jan 2020 15:56:09 -0800
Message-Id: <20200129235614.29829-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129235614.29829-1-richard.henderson@linaro.org>
References: <20200129235614.29829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

When VHE is enabled, the exception level below EL2 is not EL1,
but EL0, and so to identify the entry vector offset for exceptions
targeting EL2 we need to look at the width of EL0, not of EL1.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a2eb01f97c..a089ba8a5f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9036,14 +9036,19 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
          * immediately lower than the target level is using AArch32 or AArch64
          */
         bool is_aa64;
+        uint64_t hcr;
 
         switch (new_el) {
         case 3:
             is_aa64 = (env->cp15.scr_el3 & SCR_RW) != 0;
             break;
         case 2:
-            is_aa64 = (env->cp15.hcr_el2 & HCR_RW) != 0;
-            break;
+            hcr = arm_hcr_el2_eff(env);
+            if ((hcr & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {
+                is_aa64 = (hcr & HCR_RW) != 0;
+                break;
+            }
+            /* fall through */
         case 1:
             is_aa64 = is_a64(env);
             break;
-- 
2.20.1


