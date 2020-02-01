Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C58FC33CB7
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:45:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B9CF205F4
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TjhpUV38"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9CF205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixyhd-0007Sk-Dp
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 14:45:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySa-0007V7-R0
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySZ-0006nH-MN
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:40 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42680)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ixySZ-0006mm-G6
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:39 -0500
Received: by mail-pg1-x543.google.com with SMTP id s64so5454303pgb.9
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 11:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zRgB8efNbAKyUVxLAqmxP7UnRJX0xqtjC+kQnc9eL3A=;
 b=TjhpUV38IcoklT+kDVx8Df7THMQ1ZAZHBH8D7V7t6OX/w+exsv7ZjwOF5Esd7v+YaL
 Fx4g7Gx5aWzySKakWeNlJHJOzdmLjlUGvsEYTy35UsyHCnDkAyaSfCoNiEX/vD1jwVXz
 YKz/feun0oT3C1b0oTzGdwagwOkNzBxOMC9CG6Wd6MvLTg9PdiDgo/e8OZx419pf3za8
 UQdBg5KM/tC85G57tv+vw+PeouxV29bStVQk3chgFZ71gYjUc+JbuqB7w7XX44nem3oH
 wJZ/etaCxNQGTO/geHeuwAegG5I/Tb+oCMlvvdo/SRqFaujEY0NcsMg3O1WA5AznPa0R
 c9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zRgB8efNbAKyUVxLAqmxP7UnRJX0xqtjC+kQnc9eL3A=;
 b=FohNQCkaz1EwmumDryCcNrvOU9KE+rW9hWlw/SdeDoxfgoxxtoDFtVBjBYg4c8m/Gw
 lK6dlTraOyn2Wb73M8gl+O+d1lAYQkajhcKnFBrpraET72V/gXtv0NAybnRcHiZRSVDE
 NwCZnI7Pj+IMosbsq5fDC7wdzM9GDTpW+L75AHgDa9PwVdenHA8YiHw/Nmkbk5U6YTXQ
 ShPAfoPRoXwhFr3oSpaJ/fbTxWBB/fN7oHhbbtsFdG1uQ6UVbUxyLr8BKs+xwDplo36h
 EgGKETyXcCPPo3kTwjRnanMT27xSIxqKucYf4BzxAjoxDL61Z5zA+fciiSskqjYfcji0
 dgQQ==
X-Gm-Message-State: APjAAAV27hJWPaNtYKymMtPiHrQQTSuGNBqoXrwrhzcVhWMshNUHAFB2
 es5b10m4rln3VXm8VfBIyiYAsqZnGJ0=
X-Google-Smtp-Source: APXvYqyTd1wsJI9YzU+lpu3OrEm22x1rD6+PtoNwpdSL3AaB6liTXX8+G9UBM2UMOQhP9yIFHhJovg==
X-Received: by 2002:a63:4503:: with SMTP id s3mr17154838pga.311.1580585378338; 
 Sat, 01 Feb 2020 11:29:38 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id l7sm3668509pga.27.2020.02.01.11.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 11:29:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 17/41] target/arm: Rearrange ARMMMUIdxBit
Date: Sat,  1 Feb 2020 11:28:52 -0800
Message-Id: <20200201192916.31796-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200201192916.31796-1-richard.henderson@linaro.org>
References: <20200201192916.31796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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


