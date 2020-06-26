Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDBBC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:19:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B4B420702
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nMaaip0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4B420702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joq8o-0001Vq-KF
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq41-0002Au-T8
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:49 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq3y-0006KP-3o
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:49 -0400
Received: by mail-wr1-x442.google.com with SMTP id j4so7404011wrp.10
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=9pMs3LEbOiq50D52Qgdo7AAYpmJBtOiQsJyttNTt1Gw=;
 b=nMaaip0NLvOoecvmqwY1FB62j5Q2DqpLUIUcrnibC9h2ZynG7JK1QfJBsc2HiLOJEB
 4A2NOBDxA7HsZ2NO2RfoMMLjMU/rGlI/PRJRbiGS+VqCOzMDBQuK0W3xAzAjj0imrMz4
 2b1ysRQnzDgAT3TZM9FfYK3a5Ti9VPRlMbp32d+HW36fDIG79V9rpqSdnEwkQztTLDty
 Z2FETzqFOoIyCh1LaR5Cnbim0c2oiCOSf2Vf4Ck1v3n97GqpSExqsNw8gSD1VLvt+nqH
 606qlBMac8FZOkCe4U5wtTtFS8LGZFuBXirDvLbQi1l3O8TG1lS6QImUXDJuAwbfzVKh
 jwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9pMs3LEbOiq50D52Qgdo7AAYpmJBtOiQsJyttNTt1Gw=;
 b=NpvVfxMmXtSXswX8qCsHIAiUyZNg9M8GU5OA+9XfxgmUmzDbJp84/AhR6BZEkhq4gW
 w81eLzG2EuyoUkfrYtZ5LZVn/pn1if8QOvcWnOwOdidL+/iOyNVlMkPifAyRAclb8LWr
 z02Be7f25P7/f/uE5Q19sbBELgxAKFlqknmDaZ6BejUSqmBb0FeNnyBtwOQWmUQkf0zw
 mKNd8XARfXYAJnXSi1ppOa6a0jem328GB2Q8qvaQ2DDT/V3F6vFFBJ6pn8j/CISl2g1u
 AK9GDWQQ7zogIq8Vba1X0+dwleMwfTu1nj/ngLNxnbBRT/paXocPMzSzdWlCIdqHeV9S
 zvlw==
X-Gm-Message-State: AOAM531ZaxT6eDYeHjF7lvSf9aDoCwNuAyp/07Hpl5UwdB6xOSfa6U5j
 gzSq2+mRtc8p35D45s8hb+BSR/pmL2PF5A==
X-Google-Smtp-Source: ABdhPJxMNd8uNVQ7P5xw0ouvPSOT7C3sYY6kPzEX6rP3EzyyBlER2nPlCEBgv9w+O+UqFk0bZb+7Pg==
X-Received: by 2002:a5d:6a04:: with SMTP id m4mr4216479wru.418.1593184484148; 
 Fri, 26 Jun 2020 08:14:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.14.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:14:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/57] target/arm: Add support for MTE to HCR_EL2 and SCR_EL3
Date: Fri, 26 Jun 2020 16:13:43 +0100
Message-Id: <20200626151424.30117-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200626033144.790098-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8a0fb015819..d6c326b58e8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2021,6 +2021,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         if (cpu_isar_feature(aa64_pauth, cpu)) {
             valid_mask |= SCR_API | SCR_APK;
         }
+        if (cpu_isar_feature(aa64_mte, cpu)) {
+            valid_mask |= SCR_ATA;
+        }
     } else {
         valid_mask &= ~(SCR_RW | SCR_ST);
     }
@@ -5248,17 +5251,22 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
         if (cpu_isar_feature(aa64_pauth, cpu)) {
             valid_mask |= HCR_API | HCR_APK;
         }
+        if (cpu_isar_feature(aa64_mte, cpu)) {
+            valid_mask |= HCR_ATA | HCR_DCT | HCR_TID5;
+        }
     }
 
     /* Clear RES0 bits.  */
     value &= valid_mask;
 
-    /* These bits change the MMU setup:
+    /*
+     * These bits change the MMU setup:
      * HCR_VM enables stage 2 translation
      * HCR_PTW forbids certain page-table setups
-     * HCR_DC Disables stage1 and enables stage2 translation
+     * HCR_DC disables stage1 and enables stage2 translation
+     * HCR_DCT enables tagging on (disabled) stage1 translation
      */
-    if ((env->cp15.hcr_el2 ^ value) & (HCR_VM | HCR_PTW | HCR_DC)) {
+    if ((env->cp15.hcr_el2 ^ value) & (HCR_VM | HCR_PTW | HCR_DC | HCR_DCT)) {
         tlb_flush(CPU(cpu));
     }
     env->cp15.hcr_el2 = value;
-- 
2.20.1


