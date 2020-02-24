Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB0EC38BFA
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:28:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5F9A21744
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rdl7P8Hq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F9A21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6MDR-0006T6-NO
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 17:28:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7q-0004cD-Dj
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7p-0005wD-9i
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:54 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42366)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6M7p-0005va-4s
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:53 -0500
Received: by mail-pf1-x441.google.com with SMTP id 4so6063337pfz.9
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 14:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+oOoLUU3WLw+5ICoiVu4+Hc3ZhB0R58hfDF27U8damo=;
 b=rdl7P8Hq3/Kg6rc5J+JkXLQCkrD0N+nW18ABtWYzqGWWkBGsh7eEjsudKWGDZ7ZfEY
 wZoQL1mW+Hc49keUzSaVOAlix7bgnO1oLscek8OrwZ32UHD6WQoIgb+ZdMIm1eXyYzbU
 UAa4rWrVsgHqo601t0T5xz00ihQS1EL0lCeJgC/jyJAQzcLyattgoA717oZhwROmD7Q4
 tTDjkP/nIgC5ApOYGOu7JhW7323wE4rWCpGlZylwqmLrMdlWxl28SNhzcfjyff7dOvcj
 wMLhEU7rGOCfm1JNTy7p8quWT4edfyC1/VPbxboWZUjgZUqv4wxOIuM1XYNTe/FSWHV/
 OkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+oOoLUU3WLw+5ICoiVu4+Hc3ZhB0R58hfDF27U8damo=;
 b=mL0YQ1wRfHxjtG0m3dJwT/d5fONL/kNsC0MhxS/VyzLZ6+SLz9SpiwhQJcRjtVfjQB
 OOSZJEVSQwDBI/KS0gG5h5T89BOwNqYcg+Nj7PLZydUM0CPeM3a74RNegQ2HdEl/Hcja
 exmqRr4vNodd/wh5Hssb7vLGLFmLCKxP5AMBb6tnyHPLop4PzeqkHGApjf7mumb+Hvt3
 RFWntUut5Al4gOD3SzYhjzdsa2Ri5iuPxDnk9IG2PGKoNj/7m9R7Iuta0gdtjvmO7sHz
 w95QyC4XdjqzgGYFCY73QSPBNUmWzdNMjWDriJXhkoRVjosIkgBfOACfEGamLWmP28JL
 N1Dg==
X-Gm-Message-State: APjAAAWIAewxJFMWEphoVfdPhZsI+D0c90XqGaayUtk8Tp3+GT1ymBoS
 dgis1ti52NvgTEuUeDcnL7o5QRROvgI=
X-Google-Smtp-Source: APXvYqzZlR4s42/tRY8RTpc3Kj66ewkh3S4EAA9jDI9FfwXMLG+N+Dg/zSpmePMT7WjdmNwysXi2cw==
X-Received: by 2002:a62:1dca:: with SMTP id
 d193mr54769709pfd.140.1582582971891; 
 Mon, 24 Feb 2020 14:22:51 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id o6sm13897097pgg.37.2020.02.24.14.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 14:22:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/17] linux-user/arm: Replace ARM_FEATURE_VFP* tests for
 HWCAP
Date: Mon, 24 Feb 2020 14:22:28 -0800
Message-Id: <20200224222232.13807-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200224222232.13807-1-richard.henderson@linaro.org>
References: <20200224222232.13807-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use isar feature tests instead of feature bit tests.

Although none of QEMUs current cpus have VFPv3 without D32,
replace the large comment explaining why with one line that
sets ARM_HWCAP_ARM_VFPv3D16 under the correct conditions.
Mirror the test sequence used in the linux kernel.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Use isar_feature_aa32_vfp.
---
 linux-user/elfload.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index b1a895f24c..86cda127b7 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -468,22 +468,25 @@ static uint32_t get_elf_hwcap(void)
 
     /* EDSP is in v5TE and above, but all our v5 CPUs are v5TE */
     GET_FEATURE(ARM_FEATURE_V5, ARM_HWCAP_ARM_EDSP);
-    GET_FEATURE(ARM_FEATURE_VFP, ARM_HWCAP_ARM_VFP);
     GET_FEATURE(ARM_FEATURE_IWMMXT, ARM_HWCAP_ARM_IWMMXT);
     GET_FEATURE(ARM_FEATURE_THUMB2EE, ARM_HWCAP_ARM_THUMBEE);
     GET_FEATURE(ARM_FEATURE_NEON, ARM_HWCAP_ARM_NEON);
-    GET_FEATURE(ARM_FEATURE_VFP3, ARM_HWCAP_ARM_VFPv3);
     GET_FEATURE(ARM_FEATURE_V6K, ARM_HWCAP_ARM_TLS);
-    GET_FEATURE(ARM_FEATURE_VFP4, ARM_HWCAP_ARM_VFPv4);
+    GET_FEATURE(ARM_FEATURE_LPAE, ARM_HWCAP_ARM_LPAE);
     GET_FEATURE_ID(aa32_arm_div, ARM_HWCAP_ARM_IDIVA);
     GET_FEATURE_ID(aa32_thumb_div, ARM_HWCAP_ARM_IDIVT);
-    /* All QEMU's VFPv3 CPUs have 32 registers, see VFP_DREG in translate.c.
-     * Note that the ARM_HWCAP_ARM_VFPv3D16 bit is always the inverse of
-     * ARM_HWCAP_ARM_VFPD32 (and so always clear for QEMU); it is unrelated
-     * to our VFP_FP16 feature bit.
-     */
-    GET_FEATURE(ARM_FEATURE_VFP3, ARM_HWCAP_ARM_VFPD32);
-    GET_FEATURE(ARM_FEATURE_LPAE, ARM_HWCAP_ARM_LPAE);
+    GET_FEATURE_ID(aa32_vfp, ARM_HWCAP_ARM_VFP);
+
+    if (cpu_isar_feature(aa32_fpsp_v3, cpu) ||
+        cpu_isar_feature(aa32_fpdp_v3, cpu)) {
+        hwcaps |= ARM_HWCAP_ARM_VFPv3;
+        if (cpu_isar_feature(aa32_simd_r32, cpu)) {
+            hwcaps |= ARM_HWCAP_ARM_VFPD32;
+        } else {
+            hwcaps |= ARM_HWCAP_ARM_VFPv3D16;
+        }
+    }
+    GET_FEATURE_ID(aa32_simdfmac, ARM_HWCAP_ARM_VFPv4);
 
     return hwcaps;
 }
-- 
2.20.1


