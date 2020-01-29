Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22A9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 23:59:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD126205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 23:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wDnyDihT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD126205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxFO-0000eP-SY
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 18:59:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCK-0003uL-JZ
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCJ-0007pZ-Hn
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:40 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:34915)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwxCI-0007gy-Ai
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:39 -0500
Received: by mail-pj1-x1041.google.com with SMTP id q39so534405pjc.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gVIYBMmIalIMw01cTrDxho+UQPcwIYSJMS1wimlyU34=;
 b=wDnyDihT0BV04GYS8nOcVnM1RqkHEPRLZhZonacVEvlIxdPqnTI5jVu1DxZmUEQSX6
 iSN4xNvw6htbHf6GBhYKen9+eLaMwUcHamWpiPCoDbs3rjE53EDeNFAkpzCfrkMR8Ob2
 +lsE2V4D5wUkI+TzKk/esFrMZb13NFf+bkAfE7v/xuzdVpV4aEj79MglHQi8tq8aEfju
 WbkIhHceQRgMxnqJ3PwDbH5eCN+Zfobv4w0oxX8/75Jd++S+2RDGckw5tVJVnKE5djP/
 zsmETe3Cobzm6PmQtAKdPQq0KGzESraMwtC+MuemoK/8nBDrm/PA8Yxs98xkTaBT1MK/
 ESfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gVIYBMmIalIMw01cTrDxho+UQPcwIYSJMS1wimlyU34=;
 b=sIk/ElOxu60ZElzJ4QR0Gwl5qEQlUL7KNHXG8mSNWaLw5f0QcpT/qkMaOqLbRk18Nc
 ZKr3B0KmfUI2035dapYQaGsdZsz4f1e51JCkFKoMg+XgpGnTLfNWcsAHOBx/kpUAcimF
 +IG2SbmXixdgb5Uc4Q8xw3zPJhYnXXrtfFSOP7oXrIfa7me8rHo3uYvuIleWX+QF4uY1
 gytFJrwcf6/xNne4qgcT4i4iCp3aqwg53m2vBaO+dQDzVTeJx3HiEk/tmj88SZnDhvG2
 5hFZKmy5hNv0wjxG+ar8sU6s/a4apuO/9jXOI3WCbNrdP9Ay+NBGECF4W/qGUdlcnTrQ
 FADQ==
X-Gm-Message-State: APjAAAVAy+iLVCw4ciO7R4BppScphiLd8YzTc+GjpYz8aY1yM4T8Lz3N
 3+QzwpESNvGKnAxPsDu7OFIeY97oxnI=
X-Google-Smtp-Source: APXvYqxBwF48M4UXN60D9jPnMd4+6hWf/Hc7QDER95JJPxyo/vQmWX55SeDI9h9he1Ed3YGRSQ7AEA==
X-Received: by 2002:a17:90b:3cc:: with SMTP id
 go12mr2478285pjb.89.1580342197105; 
 Wed, 29 Jan 2020 15:56:37 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm3953626pfg.145.2020.01.29.15.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:56:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 17/41] target/arm: Rearrange ARMMMUIdxBit
Date: Wed, 29 Jan 2020 15:55:50 -0800
Message-Id: <20200129235614.29829-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129235614.29829-1-richard.henderson@linaro.org>
References: <20200129235614.29829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Define via macro expansion, so that renumbering of the base ARMMMUIdx
symbols is automatically reflected in the bit definitions.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 893b1f1918..68ad96f8e8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2920,27 +2920,34 @@ typedef enum ARMMMUIdx {
     ARMMMUIdx_Stage1_E1 = 1 | ARM_MMU_IDX_NOTLB,
 } ARMMMUIdx;
 
-/* Bit macros for the core-mmu-index values for each index,
+/*
+ * Bit macros for the core-mmu-index values for each index,
  * for use when calling tlb_flush_by_mmuidx() and friends.
  */
+#define TO_CORE_BIT(NAME) \
+    ARMMMUIdxBit_##NAME = 1 << (ARMMMUIdx_##NAME & ARM_MMU_IDX_COREIDX_MASK)
+
 typedef enum ARMMMUIdxBit {
-    ARMMMUIdxBit_E10_0 = 1 << 0,
-    ARMMMUIdxBit_E10_1 = 1 << 1,
-    ARMMMUIdxBit_E2 = 1 << 2,
-    ARMMMUIdxBit_SE3 = 1 << 3,
-    ARMMMUIdxBit_SE10_0 = 1 << 4,
-    ARMMMUIdxBit_SE10_1 = 1 << 5,
-    ARMMMUIdxBit_Stage2 = 1 << 6,
-    ARMMMUIdxBit_MUser = 1 << 0,
-    ARMMMUIdxBit_MPriv = 1 << 1,
-    ARMMMUIdxBit_MUserNegPri = 1 << 2,
-    ARMMMUIdxBit_MPrivNegPri = 1 << 3,
-    ARMMMUIdxBit_MSUser = 1 << 4,
-    ARMMMUIdxBit_MSPriv = 1 << 5,
-    ARMMMUIdxBit_MSUserNegPri = 1 << 6,
-    ARMMMUIdxBit_MSPrivNegPri = 1 << 7,
+    TO_CORE_BIT(E10_0),
+    TO_CORE_BIT(E10_1),
+    TO_CORE_BIT(E2),
+    TO_CORE_BIT(SE10_0),
+    TO_CORE_BIT(SE10_1),
+    TO_CORE_BIT(SE3),
+    TO_CORE_BIT(Stage2),
+
+    TO_CORE_BIT(MUser),
+    TO_CORE_BIT(MPriv),
+    TO_CORE_BIT(MUserNegPri),
+    TO_CORE_BIT(MPrivNegPri),
+    TO_CORE_BIT(MSUser),
+    TO_CORE_BIT(MSPriv),
+    TO_CORE_BIT(MSUserNegPri),
+    TO_CORE_BIT(MSPrivNegPri),
 } ARMMMUIdxBit;
 
+#undef TO_CORE_BIT
+
 #define MMU_USER_IDX 0
 
 static inline int arm_to_core_mmu_idx(ARMMMUIdx mmu_idx)
-- 
2.20.1


