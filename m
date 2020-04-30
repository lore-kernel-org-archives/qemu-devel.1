Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E250C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:26:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CFC020836
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YyWb/2bP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CFC020836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUDte-0008Sm-7Q
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDeO-00026L-DN
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDds-0001HA-4K
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:08 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDdr-0001GU-NC
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:35 -0400
Received: by mail-wm1-x341.google.com with SMTP id h4so2976991wmb.4
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XKGUFsA+PQ5gNasR70DiFZqblEfd/NvB+SNX6wf5d6o=;
 b=YyWb/2bPWDGE8YO/Njwu+/vFsjD2t6seWQx7FgYDIBdIqtq64fx2dp0cNc/aVEcmeo
 RF4JdTwJzHUHluT9zeKE+loYFNVOvGT8Qfz755nNGwKoyNKGZ4U2LDyg+RlokcGErN+Q
 Y+wdSQRI3RfhXLtXtTatmQ729fl8BDgBdUYpjuGN5YJtzkBo4cF2/4ie0nwzxUFQPl89
 DPzn675PvJ3Jfmi6EfhSZ3P3nt5Lmy1V1A0KxEwHY8tkppPF+7eAU11wMbyZHz1+psHu
 eK9tS67XG+AIcIOkINZQfTKeGTDeVADi0IKfaQBux0jSjJZpYD9JtWBc8PcTddMD5LDH
 LYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XKGUFsA+PQ5gNasR70DiFZqblEfd/NvB+SNX6wf5d6o=;
 b=V+ETa7xZ4f2jYwKk1Y1sy3k4A0iVzyLJvsCYeJ0dH6Nvbi3czOUn5c4qaixnRf7E6v
 Xxwpf4yVs5qhRT26DIMrWV+bF+Uf+UZY121mNPLc0HoN/PsxBvPH6HZF5beMqqVi4Ucb
 j/UR6wCNysxqC90BeMGfYEoPdsoX8Uvb4seTa26VmqDiozPIrxnJTZR97QbNP5C7H90X
 wMJwGhIket9u0F2rtlcw2uXuyInVD/1ojgRRVCUfwB9dVdvDWluj9zhGjDVX5bJLLGyw
 S5kUNLStCin42KEc8eIGMfHRlPj4WkMaOsMoyNp6+oNzlwAvvcv5RjVCh7FffGw0tMz0
 S9wA==
X-Gm-Message-State: AGi0PuYBJSPQQndio4joUXwZkhgeZIpM+eFfDMWjVL/dtKW+kIR8Igca
 FYo0OAYaAud2XPfBfzINSBpytg==
X-Google-Smtp-Source: APiQypJ4AFo81FFaCmMMM49+IbvvazojGO/bYpTaq6XUXs7vYf79DKGpX5KtFqVVvW0cbOaMH5OIVw==
X-Received: by 2002:a1c:8141:: with SMTP id c62mr4307463wmd.87.1588270234537; 
 Thu, 30 Apr 2020 11:10:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t8sm652421wrq.88.2020.04.30.11.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:10:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 22/36] target/arm: Move gen_ function typedefs to translate.h
Date: Thu, 30 Apr 2020 19:09:49 +0100
Message-Id: <20200430181003.21682-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430181003.21682-1-peter.maydell@linaro.org>
References: <20200430181003.21682-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::341
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

We're going to want at least some of the NeonGen* typedefs
for the refactored 32-bit Neon decoder, so move them all
to translate.h since it makes more sense to keep them in
one group.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.h     | 17 +++++++++++++++++
 target/arm/translate-a64.c | 17 -----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index 95b43e7ab65..cb7925ea461 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -314,4 +314,21 @@ typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
 typedef void GVecGen4Fn(unsigned, uint32_t, uint32_t, uint32_t,
                         uint32_t, uint32_t, uint32_t);
 
+/* Function prototype for gen_ functions for calling Neon helpers */
+typedef void NeonGenOneOpEnvFn(TCGv_i32, TCGv_ptr, TCGv_i32);
+typedef void NeonGenTwoOpFn(TCGv_i32, TCGv_i32, TCGv_i32);
+typedef void NeonGenTwoOpEnvFn(TCGv_i32, TCGv_ptr, TCGv_i32, TCGv_i32);
+typedef void NeonGenTwo64OpFn(TCGv_i64, TCGv_i64, TCGv_i64);
+typedef void NeonGenTwo64OpEnvFn(TCGv_i64, TCGv_ptr, TCGv_i64, TCGv_i64);
+typedef void NeonGenNarrowFn(TCGv_i32, TCGv_i64);
+typedef void NeonGenNarrowEnvFn(TCGv_i32, TCGv_ptr, TCGv_i64);
+typedef void NeonGenWidenFn(TCGv_i64, TCGv_i32);
+typedef void NeonGenTwoSingleOPFn(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_ptr);
+typedef void NeonGenTwoDoubleOPFn(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_ptr);
+typedef void NeonGenOneOpFn(TCGv_i64, TCGv_i64);
+typedef void CryptoTwoOpFn(TCGv_ptr, TCGv_ptr);
+typedef void CryptoThreeOpIntFn(TCGv_ptr, TCGv_ptr, TCGv_i32);
+typedef void CryptoThreeOpFn(TCGv_ptr, TCGv_ptr, TCGv_ptr);
+typedef void AtomicThreeOpFn(TCGv_i64, TCGv_i64, TCGv_i64, TCGArg, MemOp);
+
 #endif /* TARGET_ARM_TRANSLATE_H */
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index efb1c4adc4e..a896f9c4b83 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -70,23 +70,6 @@ typedef struct AArch64DecodeTable {
     AArch64DecodeFn *disas_fn;
 } AArch64DecodeTable;
 
-/* Function prototype for gen_ functions for calling Neon helpers */
-typedef void NeonGenOneOpEnvFn(TCGv_i32, TCGv_ptr, TCGv_i32);
-typedef void NeonGenTwoOpFn(TCGv_i32, TCGv_i32, TCGv_i32);
-typedef void NeonGenTwoOpEnvFn(TCGv_i32, TCGv_ptr, TCGv_i32, TCGv_i32);
-typedef void NeonGenTwo64OpFn(TCGv_i64, TCGv_i64, TCGv_i64);
-typedef void NeonGenTwo64OpEnvFn(TCGv_i64, TCGv_ptr, TCGv_i64, TCGv_i64);
-typedef void NeonGenNarrowFn(TCGv_i32, TCGv_i64);
-typedef void NeonGenNarrowEnvFn(TCGv_i32, TCGv_ptr, TCGv_i64);
-typedef void NeonGenWidenFn(TCGv_i64, TCGv_i32);
-typedef void NeonGenTwoSingleOPFn(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_ptr);
-typedef void NeonGenTwoDoubleOPFn(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_ptr);
-typedef void NeonGenOneOpFn(TCGv_i64, TCGv_i64);
-typedef void CryptoTwoOpFn(TCGv_ptr, TCGv_ptr);
-typedef void CryptoThreeOpIntFn(TCGv_ptr, TCGv_ptr, TCGv_i32);
-typedef void CryptoThreeOpFn(TCGv_ptr, TCGv_ptr, TCGv_ptr);
-typedef void AtomicThreeOpFn(TCGv_i64, TCGv_i64, TCGv_i64, TCGArg, MemOp);
-
 /* initialize TCG globals.  */
 void a64_translate_init(void)
 {
-- 
2.20.1


