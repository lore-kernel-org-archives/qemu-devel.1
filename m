Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C85C35249
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 01:06:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1173B20661
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 01:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EgaQAMmt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1173B20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iy3i5-0005G1-7R
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 20:06:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iy3gs-0003Tk-OE
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:04:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iy3gr-0001ta-Mz
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:04:46 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37085)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iy3gq-0001r2-Mh
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:04:45 -0500
Received: by mail-pg1-x544.google.com with SMTP id q127so5742890pga.4
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 17:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l/G8fLMWaw+s2JrEJLiGNPxIjNmHgqejNi56OPBy7lc=;
 b=EgaQAMmtBFnVIr2PMYg6VORoesp4mzCyTZCJ2SXtAWppLldzgL4AqZC3GXPWB+JjiL
 bFhglyVtZuyRA2C5cpnfwjwe+GTvRSiBL7u2WtuOExLx31G4+u1xdb5/6YGwWjb1I7Hg
 cNBpOUdBFbT0nSM9vyMpciCRBZY9hqLrcMA6bIxrxzGb0G0d5IbAtCWUn6TnJ8vr7inw
 LkfR1z5CqIVDpMHY+o2RNssqIMVkDNSRXNZbX04VWa6hKfA3fQk1Yr18bAE6xFYninrX
 ItMdq8lpQjudkVjFpmVPOF/wluAmCOtZ+cvqFmK5l11GdcsyJ4XLPtSL9k0qM3TIJr/s
 Fg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l/G8fLMWaw+s2JrEJLiGNPxIjNmHgqejNi56OPBy7lc=;
 b=TYAy2z9yPQTa+XRVKaYbLws+YYjRaMM88nQHwFC3SASQVcwCIlj5Y6YGSSIXJZreel
 rLO8i7cf0JyKqFKIx0ZC8aslxJ5Kvrs1OH+hfOZtRMeiW4zQuGghRjplO5joXPi9Ofd6
 6Qw9EHmdvBvhEKby1cy30OdqWrlETqjkQrEd489HgGUNVbmxWEEYeHfokGW/Qyiw/x+3
 5wIQGLqWozknFKN1GDAW27wCSila/gySTvay08ydFuNG+NDZXQSHLQdVIdFBuYfTYfd3
 Xuk83Ug5DNg7F8tYAmY0HHATNXCqgJHXyS36+lixLyUW69klNEyT7reXjxj2vIeFoJ22
 t1zA==
X-Gm-Message-State: APjAAAVObgnHOHZuVIAo5d7836/eOahFbVA151BTYiahGHU9iFLmNEFq
 Z6/iCtls9U0WDHgTKFpq9JdEFbk7F1E=
X-Google-Smtp-Source: APXvYqz9FdR+wnYoEmij+n70m6sdjztyL6qyXI4YH5I5UX4oF5Z1oaCqJyKFEz2+O9Ue0mbigmv9tw==
X-Received: by 2002:a65:6454:: with SMTP id s20mr18761683pgv.59.1580605482346; 
 Sat, 01 Feb 2020 17:04:42 -0800 (PST)
Received: from cloudburst.WiFi.IPv4InfoBelow
 (h210.212.133.40.static.ip.windstream.net. [40.133.212.210])
 by smtp.gmail.com with ESMTPSA id 13sm14678975pfi.78.2020.02.01.17.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 17:04:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/14] target/arm: Add arm_mmu_idx_is_stage1_of_2
Date: Sat,  1 Feb 2020 17:04:26 -0800
Message-Id: <20200202010439.6410-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200202010439.6410-1-richard.henderson@linaro.org>
References: <20200202010439.6410-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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

Use a common predicate for querying stage1-ness.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Rename from arm_mmu_idx_is_stage1 to arm_mmu_idx_is_stage1_of_2
---
 target/arm/internals.h | 18 ++++++++++++++++++
 target/arm/helper.c    |  8 +++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 6d4a942bde..1f8ee5f573 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1034,6 +1034,24 @@ static inline ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env)
 ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env);
 #endif
 
+/**
+ * arm_mmu_idx_is_stage1_of_2:
+ * @mmu_idx: The ARMMMUIdx to test
+ *
+ * Return true if @mmu_idx is a NOTLB mmu_idx that is the
+ * first stage of a two stage regime.
+ */
+static inline bool arm_mmu_idx_is_stage1_of_2(ARMMMUIdx mmu_idx)
+{
+    switch (mmu_idx) {
+    case ARMMMUIdx_Stage1_E0:
+    case ARMMMUIdx_Stage1_E1:
+        return true;
+    default:
+        return false;
+    }
+}
+
 /*
  * Parameters of a given virtual address, as extracted from the
  * translation control register (TCR) for a given regime.
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 70b10428c5..852fd71dcc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3261,8 +3261,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
         bool take_exc = false;
 
         if (fi.s1ptw && current_el == 1 && !arm_is_secure(env)
-            && (mmu_idx == ARMMMUIdx_Stage1_E1 ||
-                mmu_idx == ARMMMUIdx_Stage1_E0)) {
+            && arm_mmu_idx_is_stage1_of_2(mmu_idx)) {
             /*
              * Synchronous stage 2 fault on an access made as part of the
              * translation table walk for AT S1E0* or AT S1E1* insn
@@ -9294,8 +9293,7 @@ static inline bool regime_translation_disabled(CPUARMState *env,
         }
     }
 
-    if ((env->cp15.hcr_el2 & HCR_DC) &&
-        (mmu_idx == ARMMMUIdx_Stage1_E0 || mmu_idx == ARMMMUIdx_Stage1_E1)) {
+    if ((env->cp15.hcr_el2 & HCR_DC) && arm_mmu_idx_is_stage1_of_2(mmu_idx)) {
         /* HCR.DC means SCTLR_EL1.M behaves as 0 */
         return true;
     }
@@ -9604,7 +9602,7 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
                                hwaddr addr, MemTxAttrs txattrs,
                                ARMMMUFaultInfo *fi)
 {
-    if ((mmu_idx == ARMMMUIdx_Stage1_E0 || mmu_idx == ARMMMUIdx_Stage1_E1) &&
+    if (arm_mmu_idx_is_stage1_of_2(mmu_idx) &&
         !regime_translation_disabled(env, ARMMMUIdx_Stage2)) {
         target_ulong s2size;
         hwaddr s2pa;
-- 
2.20.1


