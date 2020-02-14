Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608EAC3B1B1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:52:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 352EC206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PhLe/1C/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 352EC206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2f8p-0007jm-9c
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 12:52:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f7g-0005nQ-Fs
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f7e-0000h4-HF
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:28 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:44432)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2f7e-0000gR-BH
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:26 -0500
Received: by mail-wr1-x435.google.com with SMTP id m16so11859597wrx.11
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 09:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s9mIaxlTRZ5zTlxqg89/DuL6snOn9SxxzOctwBKWPcM=;
 b=PhLe/1C/I4v1Cb7dLryZk3KEi9Tx4DFExGHh+uNYmxxFrcafekGoV1iDQuzOakfQJ+
 uGxbwW7t/RF1rVsKcRkicSVdQ+LUklRjDNC4+AWLRG/TQtp9zemkgY3Z5TGWc06pqxpH
 dlgDpt+ONIXr1Cjp/x5Qn9ojeg86YfAySpzkI5fC3ctCGiY8jFCkzy0hN0zNy+uNjkUW
 lIjA0qk0/lHEvOSRnsy9rMs5G023FJYesKQtnCxJmUvwcFidJXdDM44p0jBM61i8goLd
 +SXYTrONEvP0zL+dm4VJG4jbdroH9kTLZJu3GcJ6UFhGNtjHWc9s/k5j7Opno/0jN6gC
 SUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s9mIaxlTRZ5zTlxqg89/DuL6snOn9SxxzOctwBKWPcM=;
 b=mSlXlJTnhYyvvIzgGa4/deaXNAxdZYr1hBUONoMfcEsM79YFqVHabTMMbqtwhL9397
 5moFpTsi5oKkrLF5vPiG+vDnORunkh2zgBZqrYgSMLpDk0OA3u2E4HUocctPoE0e/6ZV
 IM8vaolUMXN2AA0riAXVQWqQKXh/gPa9Vszlfxk3HZik+aIceK0+f3Cxmego77iv1TaX
 b9Y+dAEHqAkubJpm2MjgwZclJl5plmu6bMtFCkwnmpPR1R35uEoS/Ok168Ku7hiP+QdT
 rD8eagyb11P5jvWz4E6MGCmEi5Crxlr0YVEIfmuY5Ivd2KFkKmcf+y4wxLkXjNY4P/Eq
 Rc2Q==
X-Gm-Message-State: APjAAAUImkRUrfEVIfrHR83e6pyddATeGfNRm55Zl0sNIQA5psR9JZt4
 0jY1prbgo6Pa8L+FI1XbMGxs2w==
X-Google-Smtp-Source: APXvYqxF7917xGze3mt/9JLPt423aLnN1aY6hfmAn4/+0gI37pEK+eD1SGBfPzqKerg0J45wHxOGyw==
X-Received: by 2002:a05:6000:1251:: with SMTP id
 j17mr5464470wrx.210.1581702685128; 
 Fri, 14 Feb 2020 09:51:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v8sm8001857wrw.2.2020.02.14.09.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 09:51:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 03/21] target/arm: Add isar_feature_any_fp16 and document
 naming/usage conventions
Date: Fri, 14 Feb 2020 17:50:58 +0000
Message-Id: <20200214175116.9164-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214175116.9164-1-peter.maydell@linaro.org>
References: <20200214175116.9164-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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


