Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9405AC3B1B9
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6016B2168B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P2a3DJc5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6016B2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2faf-0006Y2-Hx
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:21:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVZ-0004cJ-3E
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVX-0000Hq-W1
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:09 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38895)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2fVX-0000HU-Pz
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:07 -0500
Received: by mail-pg1-x542.google.com with SMTP id d6so5339844pgn.5
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=M8UM5e+3VRfykuEhj/KpHZJCPyatXYB/tx3EOhHQRHg=;
 b=P2a3DJc5xDlZOW9ERiwMm2spp1DfTNP6HytA05EBy4VJ6VjnjDmpDWo3u1al6wnrcu
 4eu6uz1lmVNk6+n8YQXvZiGj5XOPC6yDBt+InvAaKmEL8VzaJEqN8LYaPc5FyxFiTW8I
 jgC8s+c8/9a+WSFRPcmhBnXkeQY6VAmslVw/KczReCT3bLvNxKRXX3VkJA6TL3+Et0aF
 QZrP78lB5CGcujeJHbaIMvCTAPAi63ZochngZinYJgXgxCQIy+0lEC+TIDCZMYo08hpk
 4dTnDb9lPrj94DvEAsVuo1/AUPjITVSIZqKsqpcvmr0uaCwPFCmfyIuoI17/snwsk3b4
 +EzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=M8UM5e+3VRfykuEhj/KpHZJCPyatXYB/tx3EOhHQRHg=;
 b=oNiJ7Ga/K1wtov2rRFMSHKTtD0/z3lEkwDJL32oN2ekmhDgNGwrWVOtgeLtM2UwqAD
 iIHhRYpLoiUpKC5UuNZypNjSdacoMLmc2MgVbEc72YP+r1XpldH8vq5pGYtOWkep8/pd
 I45o30G63gkuwEaiV8NJcXc1+Rh6R6F8YZPfccAI6LjkcYkKw343K3cufUtLRPWy1BbL
 PhwrgAP/MGmRQtzjapA6MgiVbky7rrehSh7eE4TR7litY717cz62BoNFqe7b2pGnAA11
 fZqYzzbtmjjV/jr7nZ/RH/0Nqn3RNnGqF3wzcbaC/2dhc2TJvTLElAoo8wVDkCHaw3ma
 kMyg==
X-Gm-Message-State: APjAAAXAjZSDaXHiZiFCIadShd9PJJGcbTbfFZloqqn5nZTzIg3RR4Bs
 OJKYK3Pyo6tNLsvU5FBqFY+Q6mB/Sbk=
X-Google-Smtp-Source: APXvYqzl2nh4H3juslcW0ct9JvnktgZ0ZbSimHMGZ1sL+hncyiRAImarJeZmWCehSZseN5tu+Ea7/Q==
X-Received: by 2002:a63:5a65:: with SMTP id k37mr5002076pgm.264.1581704166488; 
 Fri, 14 Feb 2020 10:16:06 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id i3sm7525123pfg.94.2020.02.14.10.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 10:16:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/19] linux-user/arm: Replace ARM_FEATURE_VFP* tests for HWCAP
Date: Fri, 14 Feb 2020 10:15:43 -0800
Message-Id: <20200214181547.21408-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214181547.21408-1-richard.henderson@linaro.org>
References: <20200214181547.21408-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: peter.maydell@linaro.org
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
 linux-user/elfload.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f3080a1635..c52c814a2e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -468,22 +468,28 @@ static uint32_t get_elf_hwcap(void)
 
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
+
     GET_FEATURE_ID(arm_div, ARM_HWCAP_ARM_IDIVA);
     GET_FEATURE_ID(thumb_div, ARM_HWCAP_ARM_IDIVT);
-    /* All QEMU's VFPv3 CPUs have 32 registers, see VFP_DREG in translate.c.
-     * Note that the ARM_HWCAP_ARM_VFPv3D16 bit is always the inverse of
-     * ARM_HWCAP_ARM_VFPD32 (and so always clear for QEMU); it is unrelated
-     * to our VFP_FP16 feature bit.
+    /*
+     * Note that none of QEMU's cpus have double precision without single
+     * precision support in VFP, so only test the single precision field.
      */
-    GET_FEATURE(ARM_FEATURE_VFP3, ARM_HWCAP_ARM_VFPD32);
-    GET_FEATURE(ARM_FEATURE_LPAE, ARM_HWCAP_ARM_LPAE);
+    GET_FEATURE_ID(aa32_fpsp_v2, ARM_HWCAP_ARM_VFP);
+    if (cpu_isar_feature(aa32_fpsp_v3, cpu)) {
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


