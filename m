Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498A0C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:42:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1856920C09
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c0wevK6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1856920C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnoog-00057q-9S
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 15:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojF-0003F1-I6
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:09 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:34877)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojE-0005WB-0L
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:09 -0400
Received: by mail-pg1-x544.google.com with SMTP id f3so27246pgr.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 12:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AlIgM6p7oAT+zID+rk9BPqh6DFQ2CZ3GNfJxW/eCI2s=;
 b=c0wevK6U65i14/qwTuSTYORUsvxx1u0fzHDtfuQM6yEuMT4D1BU91SuEDKZ6IHZnDa
 Dl7+T8tHAlaoJqyz2B6ERtTzubUZS296aY6OTRRl7ckZyb5u1VCMT7Z80lBD33jvTjFh
 hgwRjfU24w2NDUR9CtfBL9kWjuYAftZmvV4WBRNA/qO959qUF63Rgw/DJXs76qMSLpDI
 V1qtS6f5RaC69EjJ22STz5E5AzMvsUIFHyWAX4g23CtPd3X/YRklt5dC6cKJRzM9lm1U
 A5MWXvVLMVBHT9UAO07ZMbnXPqVKl91/CjxizK/QriZ1ZcZ+9ek7iMHbdM+gOaQiTc4T
 WGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AlIgM6p7oAT+zID+rk9BPqh6DFQ2CZ3GNfJxW/eCI2s=;
 b=HXEQzzzZOAu5a6GFE+uqjRfnDmpGAfBe21XKy6KlInYWZBs1UTJEtzA2237wTOzfca
 aJea/6RCXuYD+dBoiA/08wqxHUSnp8egvGZhWWfFQN0BnrhXosHgoBKBDia4wiLycEHL
 f90Zjvv8KvQtukPujjI45f/dL0FyCvdxuHwjLr5lTjO7Ib/qVHhv7g68a9cEX71KnSnI
 jprwWPBBRcHMgQ0Y94hULDPbii/0+oQDn46vDebVblAByDjt+W2+ic5Fn4hdIjBjfOiy
 tp62K1po0iDMnz7AJUaDSZ/A+Kz6fKA1WarzOaE4ylTsD4rhon6ivs1kgaLc+bxaGy+h
 RgGQ==
X-Gm-Message-State: AOAM530snFrkwzS5cLlsP41CF493B82T0PlnXzSONm5/SY24XQcKmvJr
 u+gXsAcJUCozj3gtV2qTv5ZHJbkO7EI=
X-Google-Smtp-Source: ABdhPJytF1fso/ZkK+CSha8Xv36x6bSVFzEjFxRne2pR58+g6LEqcA5Djt6CMEyfQ4Rmwgwkjqs4Eg==
X-Received: by 2002:a05:6a00:801:: with SMTP id
 m1mr26967413pfk.200.1592941026133; 
 Tue, 23 Jun 2020 12:37:06 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p12sm17927642pfq.69.2020.06.23.12.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 12:37:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 04/45] target/arm: Add support for MTE to HCR_EL2 and
 SCR_EL3
Date: Tue, 23 Jun 2020 12:36:17 -0700
Message-Id: <20200623193658.623279-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623193658.623279-1-richard.henderson@linaro.org>
References: <20200623193658.623279-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v8: Include HCR_DCT.
---
 target/arm/helper.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8a0fb01581..d6c326b58e 100644
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
2.25.1


