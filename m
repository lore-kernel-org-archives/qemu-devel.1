Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96961C35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:01:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46EB620726
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q3x3wOZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46EB620726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0Pjj-0005lX-DO
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 08:01:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Pgn-0000PX-Bg
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Pgm-0004eM-7j
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:25 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39683)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j0Pgm-0004cd-1X
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:24 -0500
Received: by mail-wr1-x444.google.com with SMTP id y11so2041590wrt.6
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 04:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MWLtQ/ag+NbaBqsy4KxfJtC383rnR0ndbUAkAnWV62s=;
 b=q3x3wOZQvXuB4LPB4zbEIkoPpjRb6/jTBJMTTy1twEuLqqyWyH4TqLeFo0vNo+fu7m
 aIxA5obm0+l0DN/H7/iO/toOyWG+5rvNtgPzK1e7Yg0MClTJtIH6sWdlY6JUrdSv2eID
 ROxgrzlPunEemdY9ddnKyghpxTcrlb0l+XpA9BHlVKOTHdtgbCfUp+OFok+Q/sxFkqwT
 Bj3yN2JOa8uNsb4MRcg/OEOQEjBairL8BC+pTWOcdwOzBT9ykpJVQBI6Ym52merIimC8
 BH2Sti/h9dJJi2OFf7gblPptrUbmtcq0DuXtKrNtC94bytgi1BLGmJM+EoHBVIj5edwx
 ywFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MWLtQ/ag+NbaBqsy4KxfJtC383rnR0ndbUAkAnWV62s=;
 b=bZ0rFw2OHzqONBnVu9i5p1iC0CweN9Dc8bvA9HWU6LBfBKDdoSJY5vd1l/rkfgmCfT
 +k/HdkKdE4qO//WvsDd4xRh9Y1JArs6tbI+c3QXvm2QMu8fuRRfUkvLchaNw5HFJvEqq
 PPQqKQuN7Suq/m4oXOCXWpW3a8KLtmq3MCobgnBuj7D4DFtcHVyoGwnF8OME3g2iaCby
 L7RvVIJTgFqIPzJmBIG2z4RjvwiqPGH9sz9+hjwjviWkocKsYci/FfGUXglY9zwpj/it
 dIQ1fUA4/6Ay1hyPtNTvyOIyIFokV0H4UTyKWwakoWUHfHGY46aixDSCP+rjh10XQw29
 YUKw==
X-Gm-Message-State: APjAAAXw5yIji6Crl41tnLvvfVDPHPGiswAX5JnfWyfx+jNzDPe5YnQE
 +xceApdsRO6zVh17ZrsvSXhVRdneR/SFLw==
X-Google-Smtp-Source: APXvYqx2EdVsHY6qOGo7/Ef8CUvSJajctcU0mlwo2SjoiptgC4vmYC11cCEOli/ff0Q/QCOtM7G/SA==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr5608705wrc.175.1581166702843; 
 Sat, 08 Feb 2020 04:58:22 -0800 (PST)
Received: from localhost.localdomain ([82.3.55.76])
 by smtp.gmail.com with ESMTPSA id p5sm7490534wrt.79.2020.02.08.04.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 04:58:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 05/20] target/arm: Split out aarch32_cpsr_valid_mask
Date: Sat,  8 Feb 2020 12:58:01 +0000
Message-Id: <20200208125816.14954-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200208125816.14954-1-richard.henderson@linaro.org>
References: <20200208125816.14954-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

Split this helper out of msr_mask in translate.c.  At the same time,
transform the negative reductive logic to positive accumulative logic.
It will be usable along the exception paths.

While touching msr_mask, fix up formatting.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v4: Keep CPSR_J unconditionally in this patch.
    Fix all formatting in msr_mask.
---
 target/arm/internals.h | 21 +++++++++++++++++++++
 target/arm/translate.c | 40 +++++++++++++++++-----------------------
 2 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 6be8b2d1a9..4d4896fcdc 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1061,6 +1061,27 @@ static inline bool arm_mmu_idx_is_stage1_of_2(ARMMMUIdx mmu_idx)
     }
 }
 
+static inline uint32_t aarch32_cpsr_valid_mask(uint64_t features,
+                                               const ARMISARegisters *id)
+{
+    uint32_t valid = CPSR_M | CPSR_AIF | CPSR_IL | CPSR_NZCV | CPSR_J;
+
+    if ((features >> ARM_FEATURE_V4T) & 1) {
+        valid |= CPSR_T;
+    }
+    if ((features >> ARM_FEATURE_V5) & 1) {
+        valid |= CPSR_Q; /* V5TE in reality*/
+    }
+    if ((features >> ARM_FEATURE_V6) & 1) {
+        valid |= CPSR_E | CPSR_GE;
+    }
+    if ((features >> ARM_FEATURE_THUMB2) & 1) {
+        valid |= CPSR_IT;
+    }
+
+    return valid;
+}
+
 /*
  * Parameters of a given virtual address, as extracted from the
  * translation control register (TCR) for a given regime.
diff --git a/target/arm/translate.c b/target/arm/translate.c
index d58c328e08..20f89ace2f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -2734,39 +2734,33 @@ static inline void gen_mulxy(TCGv_i32 t0, TCGv_i32 t1, int x, int y)
 /* Return the mask of PSR bits set by a MSR instruction.  */
 static uint32_t msr_mask(DisasContext *s, int flags, int spsr)
 {
-    uint32_t mask;
+    uint32_t mask = 0;
 
-    mask = 0;
-    if (flags & (1 << 0))
+    if (flags & (1 << 0)) {
         mask |= 0xff;
-    if (flags & (1 << 1))
+    }
+    if (flags & (1 << 1)) {
         mask |= 0xff00;
-    if (flags & (1 << 2))
+    }
+    if (flags & (1 << 2)) {
         mask |= 0xff0000;
-    if (flags & (1 << 3))
+    }
+    if (flags & (1 << 3)) {
         mask |= 0xff000000;
+    }
 
-    /* Mask out undefined bits.  */
-    mask &= ~CPSR_RESERVED;
-    if (!arm_dc_feature(s, ARM_FEATURE_V4T)) {
-        mask &= ~CPSR_T;
-    }
-    if (!arm_dc_feature(s, ARM_FEATURE_V5)) {
-        mask &= ~CPSR_Q; /* V5TE in reality*/
-    }
-    if (!arm_dc_feature(s, ARM_FEATURE_V6)) {
-        mask &= ~(CPSR_E | CPSR_GE);
-    }
-    if (!arm_dc_feature(s, ARM_FEATURE_THUMB2)) {
-        mask &= ~CPSR_IT;
-    }
-    /* Mask out execution state and reserved bits.  */
+    /* Mask out undefined and reserved bits.  */
+    mask &= aarch32_cpsr_valid_mask(s->features, s->isar);
+
+    /* Mask out execution state.  */
     if (!spsr) {
-        mask &= ~(CPSR_EXEC | CPSR_RESERVED);
+        mask &= ~CPSR_EXEC;
     }
+
     /* Mask out privileged bits.  */
-    if (IS_USER(s))
+    if (IS_USER(s)) {
         mask &= CPSR_USER;
+    }
     return mask;
 }
 
-- 
2.20.1


