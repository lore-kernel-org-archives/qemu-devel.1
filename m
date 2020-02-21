Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD36C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:17:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AB5A24656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SJ4YHADB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB5A24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58Bq-0006Ge-CN
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:17:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582H-0006sV-EW
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582G-0002ks-3M
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:05 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:34596)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582F-0002k0-Ss
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:04 -0500
Received: by mail-wr1-x431.google.com with SMTP id n10so2019296wrm.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=h5+A342D2iRjcWA3VICQY7RA9sDnarYqczi5siHyDGg=;
 b=SJ4YHADB8qITxhD0/V1SQ09SbxJ7d0BDYvVJ9vWgbZ2wEb+ntJWK6jR3CV6oAxVKiY
 O3+XOR88dPEV9YHZthnMxYO+CV8svltgHjL/sT8LczIXBwAbcw7VyztqS9Hnv83eGp8Q
 L/7DhiKSUceoS8c7hbz46R6MLmrdzHUyHtI0sqnY8o8tb7JDB08oQVv5Fq4mONGb0WtG
 /hTwlyhV+Xattv3OBUo8MMfhJPIAhYTzK6pCqWNPiPgHKSxQUXC9PT3HAjBvnVnIjw/A
 YKFl8gh2xLvpV8ES2nwf5iM2GRRJQKr30bT0bVCxq/byzPJOg62YFfRRmyS7/wJCbms/
 e3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h5+A342D2iRjcWA3VICQY7RA9sDnarYqczi5siHyDGg=;
 b=KuwcaPUP/jONf8LSfc3pVH2UaSo24Z0fXE7mqeDig/1LqgOvmArbHqFywAeYTSRLSH
 tHNG26x5X+56ilm64uxBd7HpbgYhf6xPh7/PSJRueeW08ZlDzvqXdfavWW2P3qBVYlGw
 p9j5cyeWe8jgijEg3d262Mn8F/VorTfVpATdsSOu6jxF3uh2lpAfPr0e3qs0mevHl0tZ
 SYYhoYVIaUFGY6/LERF3+71q6CoYhb10nEUUdCH+EUcrqqiN92X6TIri3/bA6iXUOYot
 gtxp4ZKAFcNIrftoKVs1dgVmu4E9q5dab84bTVV/tXP8LeEklblMu1gi3GXTT1c0QqRC
 dpkw==
X-Gm-Message-State: APjAAAXlUfCD78q4PyBpuUhnZB22ueZLmb6GD67FEN7jVjmqmZ34OjuL
 NXafcvdHSzKcrRVDAgBtPeTvO/q5+F41tw==
X-Google-Smtp-Source: APXvYqxLdSYqjv24iEI9fHKQDkD1ESMif3uph7uJg4QgFydkLxKmTd++whEYXAxbWTFJJPAvq/JwoA==
X-Received: by 2002:adf:b605:: with SMTP id f5mr46476770wre.383.1582290482505; 
 Fri, 21 Feb 2020 05:08:02 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.08.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:08:02 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/52] target/arm: Add isar_feature_any_fp16 and document
 naming/usage conventions
Date: Fri, 21 Feb 2020 13:07:04 +0000
Message-Id: <20200221130740.7583-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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

Our current usage of the isar_feature feature tests almost always
uses an _aa32_ test when the code path is known to be AArch32
specific and an _aa64_ test when the code path is known to be
AArch64 specific. There is just one exception: in the vfp_set_fpscr
helper we check aa64_fp16 to determine whether the FZ16 bit in
the FP(S)CR exists, but this code is also used for AArch32.
There are other places in future where we're likely to want
a general "does this feature exist for either AArch32 or
AArch64" check (typically where architecturally the feature exists
for both CPU states if it exists at all, but the CPU might be
AArch32-only or AArch64-only, and so only have one set of ID
registers).

Introduce a new category of isar_feature_* functions:
isar_feature_any_foo() should be tested when what we want to
know is "does this feature exist for either AArch32 or AArch64",
and always returns the logical OR of isar_feature_aa32_foo()
and isar_feature_aa64_foo().

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200214175116.9164-4-peter.maydell@linaro.org
---
 target/arm/cpu.h        | 19 ++++++++++++++++++-
 target/arm/vfp_helper.c |  2 +-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 37d40e57901..7ccd65bdce3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3328,7 +3328,16 @@ extern const uint64_t pred_esz_masks[4];
  * Naming convention for isar_feature functions:
  * Functions which test 32-bit ID registers should have _aa32_ in
  * their name. Functions which test 64-bit ID registers should have
- * _aa64_ in their name.
+ * _aa64_ in their name. These must only be used in code where we
+ * know for certain that the CPU has AArch32 or AArch64 respectively
+ * or where the correct answer for a CPU which doesn't implement that
+ * CPU state is "false" (eg when generating A32 or A64 code, if adding
+ * system registers that are specific to that CPU state, for "should
+ * we let this system register bit be set" tests where the 32-bit
+ * flavour of the register doesn't have the bit, and so on).
+ * Functions which simply ask "does this feature exist at all" have
+ * _any_ in their name, and always return the logical OR of the _aa64_
+ * and the _aa32_ function.
  */
 
 /*
@@ -3660,6 +3669,14 @@ static inline bool isar_feature_aa64_bti(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, BT) != 0;
 }
 
+/*
+ * Feature tests for "does this exist in either 32-bit or 64-bit?"
+ */
+static inline bool isar_feature_any_fp16(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_fp16(id) || isar_feature_aa32_fp16_arith(id);
+}
+
 /*
  * Forward to the above feature tests given an ARMCPU pointer.
  */
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 0ae7d4f34a9..930d6e747f6 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -185,7 +185,7 @@ uint32_t vfp_get_fpscr(CPUARMState *env)
 void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
 {
     /* When ARMv8.2-FP16 is not supported, FZ16 is RES0.  */
-    if (!cpu_isar_feature(aa64_fp16, env_archcpu(env))) {
+    if (!cpu_isar_feature(any_fp16, env_archcpu(env))) {
         val &= ~FPCR_FZ16;
     }
 
-- 
2.20.1


