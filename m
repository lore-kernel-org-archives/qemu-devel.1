Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68ACC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:08:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81B7D206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r+k2cRqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B7D206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxNm-0005dO-Lf
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 19:08:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCO-00044g-No
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCN-00081W-Gn
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:44 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:33185)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwxCM-0007yN-A7
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:43 -0500
Received: by mail-pl1-x643.google.com with SMTP id ay11so600984plb.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JDOCFaQ6y0Hh/DoHVS321IziZQyNO2RiFuPIzlgNE1o=;
 b=r+k2cRqAHWcPO62X1NEPabMvG0y3Emmte0GZpXqsxrIwI0/vafcPUSz6QMKVAJ7Vvv
 YfVza+CkRUOFTGOOgEc7pb89ap7uPheSjy7mCr0EO5Im9z/Z8RYfo/WuTck+hhFEAXeC
 HXsyC6/fyIYj1I+iUuDztuvysK9BTzRaa7kjZSC3gTo3hmF/INpW8/KZoWeMYQcxJsfn
 vyxWXxJUyRi/ex165aksTXzpMwsho3/0uC8sz7uj6I2lZlK0PLvlQT+THWIjsMNFx1BN
 MRohEv+pgI3m2vgmtePphXkmNjVBghAm0VrizU0Y22uFgH+WPZbUa3sDwCvtgNnua7bC
 wpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JDOCFaQ6y0Hh/DoHVS321IziZQyNO2RiFuPIzlgNE1o=;
 b=i62Gx8cr2PLt4PRFv+5LulzyH8nOCgzfaVpZKrwH9ZfUKrAqsptkj/Q3ySSl46ZQTp
 bVi6Db5mF1Of1FFkRPWQW1gu3lr15zFDBE4HQcxhQtsG8pg1KGrs98Vz7NhC8ZzuZUmX
 7osVl29C1QxheIag/Ztao281faBNCnVAD3/BcbIoZRuDeVofgihdIbw7ElD84XsQPb4t
 vbeCngjioBt1iiXovwJuWC2G9mHTsyHi4u22YO5SGJQQjRK/7S8fI8jLV9pLZuuIojKv
 WW2GmFaa0FU/zl46NlDi9wkoKaTqDqfcAEtB0GzjvjjEI1eZsgvJvZwOCzUjKvnhAwt8
 /Dww==
X-Gm-Message-State: APjAAAVIYy/auxl8YVpo6tEfsrr2jAdfd4hL8arGzhGSp70baH+Tbx+v
 VleyejbhrM7cPcaIQgdza53HISJM6hs=
X-Google-Smtp-Source: APXvYqwvoi7upWBrNB10904M5NMn+ynJEd3UpQ4B/NwUFJxSIDCBKmNL7MFpOmODyfdZWXPoukqKWA==
X-Received: by 2002:a17:90a:ac18:: with SMTP id
 o24mr2581788pjq.33.1580342201026; 
 Wed, 29 Jan 2020 15:56:41 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm3953626pfg.145.2020.01.29.15.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:56:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 20/41] target/arm: Add regime_has_2_ranges
Date: Wed, 29 Jan 2020 15:55:53 -0800
Message-Id: <20200129235614.29829-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129235614.29829-1-richard.henderson@linaro.org>
References: <20200129235614.29829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Create a predicate to indicate whether the regime has
both positive and negative addresses.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h     | 18 ++++++++++++++++++
 target/arm/helper.c        | 23 ++++++-----------------
 target/arm/translate-a64.c |  3 +--
 3 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 0c4119a3a2..6d4a942bde 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -837,6 +837,24 @@ static inline void arm_call_el_change_hook(ARMCPU *cpu)
     }
 }
 
+/* Return true if this address translation regime has two ranges.  */
+static inline bool regime_has_2_ranges(ARMMMUIdx mmu_idx)
+{
+    switch (mmu_idx) {
+    case ARMMMUIdx_Stage1_E0:
+    case ARMMMUIdx_Stage1_E1:
+    case ARMMMUIdx_E10_0:
+    case ARMMMUIdx_E10_1:
+    case ARMMMUIdx_E20_0:
+    case ARMMMUIdx_E20_2:
+    case ARMMMUIdx_SE10_0:
+    case ARMMMUIdx_SE10_1:
+        return true;
+    default:
+        return false;
+    }
+}
+
 /* Return true if this address translation regime is secure */
 static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index bf9d85e484..aba79db2a1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9030,15 +9030,8 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
     }
 
     if (is_aa64) {
-        switch (regime_el(env, mmu_idx)) {
-        case 1:
-            if (!is_user) {
-                xn = pxn || (user_rw & PAGE_WRITE);
-            }
-            break;
-        case 2:
-        case 3:
-            break;
+        if (regime_has_2_ranges(mmu_idx) && !is_user) {
+            xn = pxn || (user_rw & PAGE_WRITE);
         }
     } else if (arm_feature(env, ARM_FEATURE_V7)) {
         switch (regime_el(env, mmu_idx)) {
@@ -9572,7 +9565,6 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
                                         ARMMMUIdx mmu_idx)
 {
     uint64_t tcr = regime_tcr(env, mmu_idx)->raw_tcr;
-    uint32_t el = regime_el(env, mmu_idx);
     bool tbi, tbid, epd, hpd, using16k, using64k;
     int select, tsz;
 
@@ -9582,7 +9574,7 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
      */
     select = extract64(va, 55, 1);
 
-    if (el > 1) {
+    if (!regime_has_2_ranges(mmu_idx)) {
         tsz = extract32(tcr, 0, 6);
         using64k = extract32(tcr, 14, 1);
         using16k = extract32(tcr, 15, 1);
@@ -9738,10 +9730,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         param = aa64_va_parameters(env, address, mmu_idx,
                                    access_type != MMU_INST_FETCH);
         level = 0;
-        /* If we are in 64-bit EL2 or EL3 then there is no TTBR1, so mark it
-         * invalid.
-         */
-        ttbr1_valid = (el < 2);
+        ttbr1_valid = regime_has_2_ranges(mmu_idx);
         addrsize = 64 - 8 * param.tbi;
         inputsize = 64 - param.tsz;
     } else {
@@ -11457,8 +11446,8 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
 
     flags = FIELD_DP32(flags, TBFLAG_ANY, AARCH64_STATE, 1);
 
-    /* FIXME: ARMv8.1-VHE S2 translation regime.  */
-    if (regime_el(env, stage1) < 2) {
+    /* Get control bits for tagged addresses.  */
+    if (regime_has_2_ranges(mmu_idx)) {
         ARMVAParameters p1 = aa64_va_parameters_both(env, -1, stage1);
         tbid = (p1.tbi << 1) | p0.tbi;
         tbii = tbid & ~((p1.tbid << 1) | p0.tbid);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 4ec6f0dad1..9cac6c9232 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -175,8 +175,7 @@ static void gen_top_byte_ignore(DisasContext *s, TCGv_i64 dst,
     if (tbi == 0) {
         /* Load unmodified address */
         tcg_gen_mov_i64(dst, src);
-    } else if (s->current_el >= 2) {
-        /* FIXME: ARMv8.1-VHE S2 translation regime.  */
+    } else if (!regime_has_2_ranges(s->mmu_idx)) {
         /* Force tag byte to all zero */
         tcg_gen_extract_i64(dst, src, 0, 56);
     } else {
-- 
2.20.1


