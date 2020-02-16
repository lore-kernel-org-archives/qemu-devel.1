Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119E7C2BA83
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 19:45:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D165A20726
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 19:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MFJ51olg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D165A20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3Pqp-0005Wd-2G
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 14:45:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3PpZ-0003iF-1e
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 14:43:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3PpX-0005cs-Mh
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 14:43:52 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40646)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3PpX-0005bh-HE
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 14:43:51 -0500
Received: by mail-pg1-x544.google.com with SMTP id z7so7889893pgk.7
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 11:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jKe60JzIR9wTTCupClDTcPlRGkah6P8mFmzkvCXt/nU=;
 b=MFJ51olgXjMW5MdZBN1Ft5GvIN6GtY9huC3Q8048vWVMuorOEKJA+zdx2AradH6XZX
 fVITTHDj6SRPYPSFxeVMIWcq2HK/Gh4ZkSD/mDSMFQP7qhHagU22iPIcsSZH0hGI40pi
 yW19rvbo8IjqlwBXZHQyIZpXjA1SzjqUyremndbhlOzg4PynZd6nt4eydyfwpN/DCL1B
 raVdyg5m1SVaSrFmpbndHEkdWT5du5nV9x6lLYpjvbgmFgwtp0Wwun9yPvMP+slBGzx0
 HbcxY93qSld49VKCjf1A1VrgwlOjq2rVdMHA6ydnUqo5lB69bD36WuV2m6mipGno2Qv7
 MiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jKe60JzIR9wTTCupClDTcPlRGkah6P8mFmzkvCXt/nU=;
 b=FXPEvcZ67gE+Q9wLlWfpBSaxu65pz1PK3SX7Pw5TVTNdAf0eLfX2qyiYPNlNLuk80M
 IoFmZ1kmbvwb6pKzT511MLXY1vLFeK6ZxKuX1Q+0NmnydbfjxmE0Up2CvEU/kKiQnFNW
 BGyymWYGy70vBe98GMetBNRc+XpDhpyNZf++5Vr0ONb1YI2hWmAV4LWy3gcApZhI8cYA
 rHUgeglmhZ7YmQzac7oEMlYROubUzmiVdYLUGFwhwgkIo/z+xEzy9dHfHjMUN+uFkyR1
 6LJbUL3Mi1TeNuXgI2bpnq+I9Ka65aQFBK3M2TyT6nL7o7OySF32DTWa1Rwag1/9S8tY
 +KDw==
X-Gm-Message-State: APjAAAX/PpVR5qS4AdPpps5xIGc45h2wMzL7vn93W9m7OQAlyJ+NEsww
 piZDukEeDa1WUxX9XzCsNdMkPp2qdKk=
X-Google-Smtp-Source: APXvYqxZ60gqk5v0a9rT8c+ERL1tVguPhAtyxK40v5WLu58j+mWAaVnEeiHbyzsJvbDI/GjqmqPbyw==
X-Received: by 2002:a63:e755:: with SMTP id j21mr14372101pgk.330.1581882230265; 
 Sun, 16 Feb 2020 11:43:50 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id y127sm13945188pfg.22.2020.02.16.11.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2020 11:43:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/4] target/arm: Split out aa64_va_parameter_tbi,
 aa64_va_parameter_tbid
Date: Sun, 16 Feb 2020 11:43:43 -0800
Message-Id: <20200216194343.21331-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200216194343.21331-1-richard.henderson@linaro.org>
References: <20200216194343.21331-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For the purpose of rebuild_hflags_a64, we do not need to compute
all of the va parameters, only tbi.  Moreover, we can compute them
in a form that is more useful to storing in hflags.

This eliminates the need for aa64_va_parameter_both, so fold that
in to aa64_va_parameter.  The remaining calls to aa64_va_parameter
are in get_phys_addr_lpae and in pauth_helper.c.

This reduces the total cpu consumption of aa64_va_parameter in a
kernel boot plus a kvm guest kernel boot from 3% to 0.5%.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h |  3 --
 target/arm/helper.c    | 68 +++++++++++++++++++++++-------------------
 2 files changed, 37 insertions(+), 34 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 58c4d707c5..14328e3f7d 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1127,15 +1127,12 @@ typedef struct ARMVAParameters {
     unsigned tsz    : 8;
     unsigned select : 1;
     bool tbi        : 1;
-    bool tbid       : 1;
     bool epd        : 1;
     bool hpd        : 1;
     bool using16k   : 1;
     bool using64k   : 1;
 } ARMVAParameters;
 
-ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
-                                        ARMMMUIdx mmu_idx);
 ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
                                    ARMMMUIdx mmu_idx, bool data);
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index eec7b01ab3..8d0f6eca27 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10234,12 +10234,34 @@ static uint8_t convert_stage2_attrs(CPUARMState *env, uint8_t s2attrs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
-                                        ARMMMUIdx mmu_idx)
+static int aa64_va_parameter_tbi(uint64_t tcr, ARMMMUIdx mmu_idx)
+{
+    if (regime_has_2_ranges(mmu_idx)) {
+        return extract64(tcr, 37, 2);
+    } else if (mmu_idx == ARMMMUIdx_Stage2) {
+        return 0; /* VTCR_EL2 */
+    } else {
+        return extract32(tcr, 20, 1);
+    }
+}
+
+static int aa64_va_parameter_tbid(uint64_t tcr, ARMMMUIdx mmu_idx)
+{
+    if (regime_has_2_ranges(mmu_idx)) {
+        return extract64(tcr, 51, 2);
+    } else if (mmu_idx == ARMMMUIdx_Stage2) {
+        return 0; /* VTCR_EL2 */
+    } else {
+        return extract32(tcr, 29, 1);
+    }
+}
+
+ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
+                                   ARMMMUIdx mmu_idx, bool data)
 {
     uint64_t tcr = regime_tcr(env, mmu_idx)->raw_tcr;
-    bool tbi, tbid, epd, hpd, using16k, using64k;
-    int select, tsz;
+    bool epd, hpd, using16k, using64k;
+    int select, tsz, tbi;
 
     if (!regime_has_2_ranges(mmu_idx)) {
         select = 0;
@@ -10248,11 +10270,9 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
         using16k = extract32(tcr, 15, 1);
         if (mmu_idx == ARMMMUIdx_Stage2) {
             /* VTCR_EL2 */
-            tbi = tbid = hpd = false;
+            hpd = false;
         } else {
-            tbi = extract32(tcr, 20, 1);
             hpd = extract32(tcr, 24, 1);
-            tbid = extract32(tcr, 29, 1);
         }
         epd = false;
     } else {
@@ -10266,28 +10286,30 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
             epd = extract32(tcr, 7, 1);
             using64k = extract32(tcr, 14, 1);
             using16k = extract32(tcr, 15, 1);
-            tbi = extract64(tcr, 37, 1);
             hpd = extract64(tcr, 41, 1);
-            tbid = extract64(tcr, 51, 1);
         } else {
             int tg = extract32(tcr, 30, 2);
             using16k = tg == 1;
             using64k = tg == 3;
             tsz = extract32(tcr, 16, 6);
             epd = extract32(tcr, 23, 1);
-            tbi = extract64(tcr, 38, 1);
             hpd = extract64(tcr, 42, 1);
-            tbid = extract64(tcr, 52, 1);
         }
     }
     tsz = MIN(tsz, 39);  /* TODO: ARMv8.4-TTST */
     tsz = MAX(tsz, 16);  /* TODO: ARMv8.2-LVA  */
 
+    /* Present TBI as a composite with TBID.  */
+    tbi = aa64_va_parameter_tbi(tcr, mmu_idx);
+    if (!data) {
+        tbi &= ~aa64_va_parameter_tbid(tcr, mmu_idx);
+    }
+    tbi = (tbi >> select) & 1;
+
     return (ARMVAParameters) {
         .tsz = tsz,
         .select = select,
         .tbi = tbi,
-        .tbid = tbid,
         .epd = epd,
         .hpd = hpd,
         .using16k = using16k,
@@ -10295,16 +10317,6 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
     };
 }
 
-ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
-                                   ARMMMUIdx mmu_idx, bool data)
-{
-    ARMVAParameters ret = aa64_va_parameters_both(env, va, mmu_idx);
-
-    /* Present TBI as a composite with TBID.  */
-    ret.tbi &= (data || !ret.tbid);
-    return ret;
-}
-
 #ifndef CONFIG_USER_ONLY
 static ARMVAParameters aa32_va_parameters(CPUARMState *env, uint32_t va,
                                           ARMMMUIdx mmu_idx)
@@ -12134,21 +12146,15 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
 {
     uint32_t flags = rebuild_hflags_aprofile(env);
     ARMMMUIdx stage1 = stage_1_mmu_idx(mmu_idx);
-    ARMVAParameters p0 = aa64_va_parameters_both(env, 0, stage1);
+    uint64_t tcr = regime_tcr(env, mmu_idx)->raw_tcr;
     uint64_t sctlr;
     int tbii, tbid;
 
     flags = FIELD_DP32(flags, TBFLAG_ANY, AARCH64_STATE, 1);
 
     /* Get control bits for tagged addresses.  */
-    if (regime_has_2_ranges(mmu_idx)) {
-        ARMVAParameters p1 = aa64_va_parameters_both(env, -1, stage1);
-        tbid = (p1.tbi << 1) | p0.tbi;
-        tbii = tbid & ~((p1.tbid << 1) | p0.tbid);
-    } else {
-        tbid = p0.tbi;
-        tbii = tbid & !p0.tbid;
-    }
+    tbid = aa64_va_parameter_tbi(tcr, mmu_idx);
+    tbii = tbid & ~aa64_va_parameter_tbid(tcr, mmu_idx);
 
     flags = FIELD_DP32(flags, TBFLAG_A64, TBII, tbii);
     flags = FIELD_DP32(flags, TBFLAG_A64, TBID, tbid);
-- 
2.20.1


