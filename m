Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D98C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 356BE20659
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WVnieliE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 356BE20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izeyq-0005kk-Bu
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:05:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoM-00033N-Ki
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoK-0006yM-AM
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:06 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35825)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izeoJ-0006n2-0l
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:03 -0500
Received: by mail-wm1-x343.google.com with SMTP id b17so6490520wmb.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 02:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=A36GAA/1p9IXKMNloeUlzi4wG3sSBRwvb103CBr6Oro=;
 b=WVnieliE574vVKlhKY8vlu8dyzPivkS3caVq1h+Cfpp3Cl4iund0uXKbV7KkPyyU5/
 H6zVu5LyBy1spOPsBvWRMrWG6ETST1e9Fdw7DO+5ePJ4s1/FuNgXtkoxNVY2MkuJFxg/
 q3mhNC25FA7dXMlX9kJ/bMMPL8gcN/gcF0FAIU7/D7J+s6rwM2GozO+Gq7T4ydLs+ohr
 YjYVlwGIFj6FUIdDCGgg68HPTvKQyvTshKdyQkrqI34/xuqCjoT8N52npBUEocSvqDxI
 vVfQiM1OV9RsbQEVzh3rNLhGJtDRK/IA2fnVYdH+YBAdhHaHWM2WQkRO2CjNJ6G5Y53V
 rBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A36GAA/1p9IXKMNloeUlzi4wG3sSBRwvb103CBr6Oro=;
 b=dZzvO+poH/aNm52nPde/zft/OVoRR8CNw4SRNWQkVvUHnpLOWqZwxGqxabm9Ph//d6
 oq26+xGe4VkZI29vU5MxesJOANaW2oqcMO9R6AzUtpZaDBeeTe/oGYmkSbA+oB+MJjHn
 SxKkO8h446YGbsdfgHcNT78rEU92XfH6LfDiZfmu3tC8llJTOCidKtOLFR4mFumkCyz0
 wQrwUhepqjuqvqUb+mWrTJ5vOt5npry2axU5YBOvQFFHbBJKYrLEyIs/B4td5g53rjEB
 96BzUkc6Ltiio+VUop/j0FosvMJOBjwAm0rNxucF+GyP4RCsOM0k2KRfHk1bEve+X1J9
 xV2g==
X-Gm-Message-State: APjAAAX61NCFO6NL6tZi4CHqcWhmjeESybo2NamLpt2azY1qg4Ibi397
 KMdu6HYUFFGZbo33U5xF42iTcXdSUYOshg==
X-Google-Smtp-Source: APXvYqw7PnhKrV8xq0uZIFTElc9k2Bne4qbP6RB6eGTuuTtVej465HGC4YX/RD7wd0QnFVfh1+hTqg==
X-Received: by 2002:a05:600c:2215:: with SMTP id
 z21mr3934203wml.55.1580986499513; 
 Thu, 06 Feb 2020 02:54:59 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id m21sm3364995wmi.27.2020.02.06.02.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 02:54:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 12/41] target/arm: Rename ARMMMUIdx_S1SE[01] to
 ARMMMUIdx_SE10_[01]
Date: Thu,  6 Feb 2020 10:54:19 +0000
Message-Id: <20200206105448.4726-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206105448.4726-1-richard.henderson@linaro.org>
References: <20200206105448.4726-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is part of a reorganization to the set of mmu_idx.
This emphasizes that they apply to the Secure EL1&0 regime.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           |  8 ++++----
 target/arm/internals.h     |  4 ++--
 target/arm/translate.h     |  2 +-
 target/arm/helper.c        | 26 +++++++++++++-------------
 target/arm/translate-a64.c |  4 ++--
 target/arm/translate.c     |  6 +++---
 6 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index afc3e76ce5..6cf2b3d6fd 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2909,8 +2909,8 @@ typedef enum ARMMMUIdx {
     ARMMMUIdx_E10_1 = 1 | ARM_MMU_IDX_A,
     ARMMMUIdx_S1E2 = 2 | ARM_MMU_IDX_A,
     ARMMMUIdx_S1E3 = 3 | ARM_MMU_IDX_A,
-    ARMMMUIdx_S1SE0 = 4 | ARM_MMU_IDX_A,
-    ARMMMUIdx_S1SE1 = 5 | ARM_MMU_IDX_A,
+    ARMMMUIdx_SE10_0 = 4 | ARM_MMU_IDX_A,
+    ARMMMUIdx_SE10_1 = 5 | ARM_MMU_IDX_A,
     ARMMMUIdx_Stage2 = 6 | ARM_MMU_IDX_A,
     ARMMMUIdx_MUser = 0 | ARM_MMU_IDX_M,
     ARMMMUIdx_MPriv = 1 | ARM_MMU_IDX_M,
@@ -2935,8 +2935,8 @@ typedef enum ARMMMUIdxBit {
     ARMMMUIdxBit_E10_1 = 1 << 1,
     ARMMMUIdxBit_S1E2 = 1 << 2,
     ARMMMUIdxBit_S1E3 = 1 << 3,
-    ARMMMUIdxBit_S1SE0 = 1 << 4,
-    ARMMMUIdxBit_S1SE1 = 1 << 5,
+    ARMMMUIdxBit_SE10_0 = 1 << 4,
+    ARMMMUIdxBit_SE10_1 = 1 << 5,
     ARMMMUIdxBit_Stage2 = 1 << 6,
     ARMMMUIdxBit_MUser = 1 << 0,
     ARMMMUIdxBit_MPriv = 1 << 1,
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 280b5b0c82..eafcd326e1 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -820,8 +820,8 @@ static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_MUser:
         return false;
     case ARMMMUIdx_S1E3:
-    case ARMMMUIdx_S1SE0:
-    case ARMMMUIdx_S1SE1:
+    case ARMMMUIdx_SE10_0:
+    case ARMMMUIdx_SE10_1:
     case ARMMMUIdx_MSPrivNegPri:
     case ARMMMUIdx_MSUserNegPri:
     case ARMMMUIdx_MSPriv:
diff --git a/target/arm/translate.h b/target/arm/translate.h
index b837b7fcbf..a32b6b1b3a 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -126,7 +126,7 @@ static inline int default_exception_el(DisasContext *s)
      * exceptions can only be routed to ELs above 1, so we target the higher of
      * 1 or the current EL.
      */
-    return (s->mmu_idx == ARMMMUIdx_S1SE0 && s->secure_routed_to_el3)
+    return (s->mmu_idx == ARMMMUIdx_SE10_0 && s->secure_routed_to_el3)
             ? 3 : MAX(1, s->current_el);
 }
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2d87c3a2e5..bbceb7a38e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3193,7 +3193,7 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
             mmu_idx = ARMMMUIdx_Stage1_E1;
             break;
         case 1:
-            mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_Stage1_E1;
+            mmu_idx = secure ? ARMMMUIdx_SE10_1 : ARMMMUIdx_Stage1_E1;
             break;
         default:
             g_assert_not_reached();
@@ -3203,13 +3203,13 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         /* stage 1 current state PL0: ATS1CUR, ATS1CUW */
         switch (el) {
         case 3:
-            mmu_idx = ARMMMUIdx_S1SE0;
+            mmu_idx = ARMMMUIdx_SE10_0;
             break;
         case 2:
             mmu_idx = ARMMMUIdx_Stage1_E0;
             break;
         case 1:
-            mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_Stage1_E0;
+            mmu_idx = secure ? ARMMMUIdx_SE10_0 : ARMMMUIdx_Stage1_E0;
             break;
         default:
             g_assert_not_reached();
@@ -3263,7 +3263,7 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
     case 0:
         switch (ri->opc1) {
         case 0: /* AT S1E1R, AT S1E1W */
-            mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_Stage1_E1;
+            mmu_idx = secure ? ARMMMUIdx_SE10_1 : ARMMMUIdx_Stage1_E1;
             break;
         case 4: /* AT S1E2R, AT S1E2W */
             mmu_idx = ARMMMUIdx_S1E2;
@@ -3276,13 +3276,13 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
         }
         break;
     case 2: /* AT S1E0R, AT S1E0W */
-        mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_Stage1_E0;
+        mmu_idx = secure ? ARMMMUIdx_SE10_0 : ARMMMUIdx_Stage1_E0;
         break;
     case 4: /* AT S12E1R, AT S12E1W */
-        mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_E10_1;
+        mmu_idx = secure ? ARMMMUIdx_SE10_1 : ARMMMUIdx_E10_1;
         break;
     case 6: /* AT S12E0R, AT S12E0W */
-        mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_E10_0;
+        mmu_idx = secure ? ARMMMUIdx_SE10_0 : ARMMMUIdx_E10_0;
         break;
     default:
         g_assert_not_reached();
@@ -3945,7 +3945,7 @@ static CPAccessResult aa64_cacheop_access(CPUARMState *env,
 static int vae1_tlbmask(CPUARMState *env)
 {
     if (arm_is_secure_below_el3(env)) {
-        return ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
+        return ARMMMUIdxBit_SE10_1 | ARMMMUIdxBit_SE10_0;
     } else {
         return ARMMMUIdxBit_E10_1 | ARMMMUIdxBit_E10_0;
     }
@@ -3981,7 +3981,7 @@ static int alle1_tlbmask(CPUARMState *env)
      * stage 1 translations.
      */
     if (arm_is_secure_below_el3(env)) {
-        return ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
+        return ARMMMUIdxBit_SE10_1 | ARMMMUIdxBit_SE10_0;
     } else if (arm_feature(env, ARM_FEATURE_EL2)) {
         return ARMMMUIdxBit_E10_1 | ARMMMUIdxBit_E10_0 | ARMMMUIdxBit_Stage2;
     } else {
@@ -8715,9 +8715,9 @@ static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
         return 2;
     case ARMMMUIdx_S1E3:
         return 3;
-    case ARMMMUIdx_S1SE0:
+    case ARMMMUIdx_SE10_0:
         return arm_el_is_aa64(env, 3) ? 1 : 3;
-    case ARMMMUIdx_S1SE1:
+    case ARMMMUIdx_SE10_1:
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_Stage1_E1:
     case ARMMMUIdx_MPrivNegPri:
@@ -8856,7 +8856,7 @@ bool arm_s1_regime_using_lpae_format(CPUARMState *env, ARMMMUIdx mmu_idx)
 static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
-    case ARMMMUIdx_S1SE0:
+    case ARMMMUIdx_SE10_0:
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_MUser:
     case ARMMMUIdx_MSUser:
@@ -11296,7 +11296,7 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
     }
 
     if (el < 2 && arm_is_secure_below_el3(env)) {
-        return ARMMMUIdx_S1SE0 + el;
+        return ARMMMUIdx_SE10_0 + el;
     } else {
         return ARMMMUIdx_E10_0 + el;
     }
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d0d13e2175..fcfb96ce1f 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -116,8 +116,8 @@ static inline int get_a64_user_mem_index(DisasContext *s)
     case ARMMMUIdx_E10_1:
         useridx = ARMMMUIdx_E10_0;
         break;
-    case ARMMMUIdx_S1SE1:
-        useridx = ARMMMUIdx_S1SE0;
+    case ARMMMUIdx_SE10_1:
+        useridx = ARMMMUIdx_SE10_0;
         break;
     case ARMMMUIdx_Stage2:
         g_assert_not_reached();
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 70b1fd3fe2..a2019a9b2a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -157,9 +157,9 @@ static inline int get_a32_user_mem_index(DisasContext *s)
     case ARMMMUIdx_E10_1:
         return arm_to_core_mmu_idx(ARMMMUIdx_E10_0);
     case ARMMMUIdx_S1E3:
-    case ARMMMUIdx_S1SE0:
-    case ARMMMUIdx_S1SE1:
-        return arm_to_core_mmu_idx(ARMMMUIdx_S1SE0);
+    case ARMMMUIdx_SE10_0:
+    case ARMMMUIdx_SE10_1:
+        return arm_to_core_mmu_idx(ARMMMUIdx_SE10_0);
     case ARMMMUIdx_MUser:
     case ARMMMUIdx_MPriv:
         return arm_to_core_mmu_idx(ARMMMUIdx_MUser);
-- 
2.20.1


