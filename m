Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903C9C43457
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:05:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29E602076C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pB1gdTf6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E602076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS0KG-00068J-9u
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 12:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRztn-0003ku-0S
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:38:07 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38397)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRztf-0007mZ-H5
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:38:06 -0400
Received: by mail-wm1-x342.google.com with SMTP id b127so5150029wmb.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=karobGThPUBbxRoaP+yKeLZSzAdIl7EhuaiEL3CMR4I=;
 b=pB1gdTf6L1Hy1roe0BRvGPb8EXrIBhUrtaB+/QVj4KAv+etAljPqtZ+CMfpTatXXU5
 PTCmXyMsX4aaf0l5BqBHW3kztsLnAOd0qVsOhcIJ0kUzwZwYjF2BAat89k0XWk5ACnRU
 vQwGt3Jd5J5kRjfQyj1M7VDXP2S3XSngTGcFG1iu15ss+s2O0e5LuMg7i0BSrxFoZrwO
 uQ1mZ6k/zJAUJMNtX14faQ8iU6zgvT5mSMTNIQahGmw7BwHjH4gbMQ/WpTEJ3MwWYD8b
 26SA9d9tEDuDqk/0WZIKLXnByjvlbI7a2HwilvbrUWVGqjsg7LtsrBjXe3Hb4b8zOaa7
 y6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=karobGThPUBbxRoaP+yKeLZSzAdIl7EhuaiEL3CMR4I=;
 b=oPkbPk5oj28gRTecpwMUWlR6G9kNP1JeD+zO5GECl8e00vL6osgQvz/07979FR23uh
 JZ6Ks5d6sGBcOBsjGiV1g50oFR8VyL0Qk2jqUbb9U2UXzvAsmKr5oHUUTvVjNb8pMXgk
 J/UPjCMMgIVhnzZmSNKfT0d8CP8eNPs+zLjBVD5nnfUm5vZrHum1E3dj+2HEBUBevoRv
 CR4WO3n7jTr1gPT6syatRB31bXi5NoaF+OZ44kaPcstlZplmjErLifA2EDn8P2Gm3C2R
 LWpE75b4gPaMLaBIQsBb4olXK5TR6/ETIwB64y+/vsUVbrIU1IQhvUyEhJJfuIOKq/jN
 3AfQ==
X-Gm-Message-State: AOAM533jKl93esov9eKo+cFTYnLdY6TJzHpZZGnlB9eGQ6Mnx3r/MNoA
 GatAgqvmH1z/bM562KJX0DVu+Q==
X-Google-Smtp-Source: ABdhPJw0Am8eqctO9howY6+TfcneaCBHujPTjQeL4K6ppinePQxEQ0slLXi2xPwIWrng9xOPQ9FQjw==
X-Received: by 2002:a1c:5a06:: with SMTP id o6mr11718388wmb.181.1602517077201; 
 Mon, 12 Oct 2020 08:37:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y66sm7095961wmd.14.2020.10.12.08.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 08:37:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 08/10] target/arm: Fix has_vfp/has_neon ID reg squashing for
 M-profile
Date: Mon, 12 Oct 2020 16:37:44 +0100
Message-Id: <20201012153746.9996-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201012153746.9996-1-peter.maydell@linaro.org>
References: <20201012153746.9996-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In arm_cpu_realizefn(), if the CPU has VFP or Neon disabled then we
squash the ID register fields so that we don't advertise it to the
guest.  This code was written for A-profile and needs some tweaks to
work correctly on M-profile:

 * A-profile only fields should not be zeroed on M-profile:
   - MVFR0.FPSHVEC,FPTRAP
   - MVFR1.SIMDLS,SIMDINT,SIMDSP,SIMDHP
   - MVFR2.SIMDMISC
 * M-profile only fields should be zeroed on M-profile:
   - MVFR1.FP16

In particular, because MVFR1.SIMDHP on A-profile is the same field as
MVFR1.FP16 on M-profile this code was incorrectly disabling FP16
support on an M-profile CPU (where has_neon is always false).  This
isn't a visible bug yet because we don't have any M-profile CPUs with
FP16 support, but the change is necessary before we introduce any.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 056319859fb..186ee621a65 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1429,17 +1429,22 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         u = cpu->isar.mvfr0;
         u = FIELD_DP32(u, MVFR0, FPSP, 0);
         u = FIELD_DP32(u, MVFR0, FPDP, 0);
-        u = FIELD_DP32(u, MVFR0, FPTRAP, 0);
         u = FIELD_DP32(u, MVFR0, FPDIVIDE, 0);
         u = FIELD_DP32(u, MVFR0, FPSQRT, 0);
-        u = FIELD_DP32(u, MVFR0, FPSHVEC, 0);
         u = FIELD_DP32(u, MVFR0, FPROUND, 0);
+        if (!arm_feature(env, ARM_FEATURE_M)) {
+            u = FIELD_DP32(u, MVFR0, FPTRAP, 0);
+            u = FIELD_DP32(u, MVFR0, FPSHVEC, 0);
+        }
         cpu->isar.mvfr0 = u;
 
         u = cpu->isar.mvfr1;
         u = FIELD_DP32(u, MVFR1, FPFTZ, 0);
         u = FIELD_DP32(u, MVFR1, FPDNAN, 0);
         u = FIELD_DP32(u, MVFR1, FPHP, 0);
+        if (arm_feature(env, ARM_FEATURE_M)) {
+            u = FIELD_DP32(u, MVFR1, FP16, 0);
+        }
         cpu->isar.mvfr1 = u;
 
         u = cpu->isar.mvfr2;
@@ -1475,16 +1480,18 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         u = FIELD_DP32(u, ID_ISAR6, FHM, 0);
         cpu->isar.id_isar6 = u;
 
-        u = cpu->isar.mvfr1;
-        u = FIELD_DP32(u, MVFR1, SIMDLS, 0);
-        u = FIELD_DP32(u, MVFR1, SIMDINT, 0);
-        u = FIELD_DP32(u, MVFR1, SIMDSP, 0);
-        u = FIELD_DP32(u, MVFR1, SIMDHP, 0);
-        cpu->isar.mvfr1 = u;
+        if (!arm_feature(env, ARM_FEATURE_M)) {
+            u = cpu->isar.mvfr1;
+            u = FIELD_DP32(u, MVFR1, SIMDLS, 0);
+            u = FIELD_DP32(u, MVFR1, SIMDINT, 0);
+            u = FIELD_DP32(u, MVFR1, SIMDSP, 0);
+            u = FIELD_DP32(u, MVFR1, SIMDHP, 0);
+            cpu->isar.mvfr1 = u;
 
-        u = cpu->isar.mvfr2;
-        u = FIELD_DP32(u, MVFR2, SIMDMISC, 0);
-        cpu->isar.mvfr2 = u;
+            u = cpu->isar.mvfr2;
+            u = FIELD_DP32(u, MVFR2, SIMDMISC, 0);
+            cpu->isar.mvfr2 = u;
+        }
     }
 
     if (!cpu->has_neon && !cpu->has_vfp) {
-- 
2.20.1


