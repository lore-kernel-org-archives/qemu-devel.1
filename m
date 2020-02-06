Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14ED1C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:07:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D89F6206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ir8HeMz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D89F6206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izf0U-0000zN-1V
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:07:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoO-00034O-7C
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoM-0007B3-LQ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:08 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42610)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izeoM-00073k-C0
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:06 -0500
Received: by mail-wr1-x442.google.com with SMTP id k11so6550050wrd.9
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 02:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6GrGdVij1LEfH8uaHPt30B16FVSaZDBvRCDaruXRkoU=;
 b=ir8HeMz5HCdyrAlZGKVgmJN7uHvxQsqIz0ME+V66o15woP0EDhQm3qZW5I3lT+F3TO
 U3zwZr5zqCtmKlL3ueaznMdHauNTj5GXRHVM1jV1RNulmW+dp2IlvhBD53wbz8CwrKE5
 pFJtYou+hIDnoh0Ik6IQ5F5wve9sgWmSGNqmhlVNSQ0iuQJd78UZQ0pfI2L05sO8bRqa
 +coUAlfwJ0RJmCIuSEtYuTyYGP5Mho87mjQCIAIto3r1nZ8TcG+oqpu9NSxNv6uxAUhS
 sDAktYWRDgTfNx/lrdDUEc90onSix88jj55YL4HDmG7bOM/UlcEXGNdTZ+QWbBKCC790
 ASqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6GrGdVij1LEfH8uaHPt30B16FVSaZDBvRCDaruXRkoU=;
 b=oGD3+ulA0GMOPPW64cgN9uPuVz4M2qW+L0n57JBxA8AWjmZX+mvIYYDpvETRd7kPkp
 D0jFgYJW5dRzafwfxdMr536WS6gJxYE/qD/0uosXaf+RfwRfOczA45LtiwgmHv74XHTN
 YHD58EwvrsdMn+Yd93BJer2hyK+7GxOjnm9J5kZxBd8FKQYAReDnC98dfAYW5kr/DaPC
 rkUn/G1Qu7XUaeZWG96i5nOVPO9F6sY9mwwTQhc0DlswSIui2qptbVh/XJQzzvNRfSpr
 48mJ2Ck5cDRiqSjxjYRWrWKVAYlo3x4RCsKlqicVx3PB+O3blpOCQC8vOCWP+nHlZH3D
 NolQ==
X-Gm-Message-State: APjAAAVzLqoNx1Xt3/uMe58h23wBlSXKnT1Vluh28dulY/EEphDpQnla
 b0lFzEGyff/0I8PFQm89ARNdRNvE/lWOzA==
X-Google-Smtp-Source: APXvYqzSDBYzqxPx5lZMbVEzyCC7wkC0zVfq2NMTCbE/UL8d2nucwQwHIAIZvoGaftobiyhag1/ZzQ==
X-Received: by 2002:adf:ca07:: with SMTP id o7mr3117668wrh.49.1580986504442;
 Thu, 06 Feb 2020 02:55:04 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id m21sm3364995wmi.27.2020.02.06.02.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 02:55:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 17/41] target/arm: Rearrange ARMMMUIdxBit
Date: Thu,  6 Feb 2020 10:54:24 +0000
Message-Id: <20200206105448.4726-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206105448.4726-1-richard.henderson@linaro.org>
References: <20200206105448.4726-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Define via macro expansion, so that renumbering of the base ARMMMUIdx
symbols is automatically reflected in the bit definitions.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index aa9728cff6..aa121cd9d0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2927,27 +2927,34 @@ typedef enum ARMMMUIdx {
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


