Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD7CC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 21:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3333320658
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 21:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rRn/fRV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3333320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ1dl-00031L-As
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 17:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jJ1Zp-0006YV-3N
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 17:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jJ1Zn-0002ha-Nl
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 17:04:09 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45687)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jJ1Zn-0002gQ-HS
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 17:04:07 -0400
Received: by mail-wr1-x443.google.com with SMTP id t7so23376371wrw.12
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 14:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Xwn3cC+kkWDU3qbOHlus1u59utOB7m1NhZTU25s+Z3I=;
 b=rRn/fRV36kzerrPWtvd81Uv7oqVpAId6q6Rax5W3B91ObZLyfdIHoyBxmr1BWxfSS2
 fcSYojWnmbKXfUE024RQSOfpOd1vBAXlNfodC4dx7TIoUblfwUxS0SgANzvgLAvupdrr
 BaETpItJ/FpPaMFtXm8pN2uM0m+QzN7iC9/nBX56XO/eF/KVRfPBwUJYts8hoXbbK012
 soxLgm58kNL5InvyhCOHO0LkbSq0M3zleCTrcCAxisnvGYopSLUSdjRKm5u3xnuGuVkI
 iFp3LRgglgKjzAeRw/1t0uYUytZ2qeaPshUQZH/c5j3U3GgRVYh1pS6O3wGsqk8ZVYeZ
 Z5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Xwn3cC+kkWDU3qbOHlus1u59utOB7m1NhZTU25s+Z3I=;
 b=K9R2Yz+/h0xUxa7rKkSuMzl4XhV8mMhsWohibhwd9mdqQAgHYUU1K1jsMBksAldK0S
 CS0FFCUV3d1SQHLIxcOQMoOIw2PIJzXWF1JvfL4esIxvqQMFPSn4TNOCovb9t5/HNbz/
 0X8THVMFRaWdqZfvmGzXASm/DG5zDiHJzLAnja7y0+nP63c+Kes+e2URe8F8/QlttNh9
 dDkDZ2lOOovCjceBv/Q0W5bGqbp59xeMs746dZG8djCjM+212vCXZS+TSz7t/G2gRosC
 POtyKGJeuF1cvKlKMMWCVrJAa+xCZLLIC9xnLOYTChGWoaiDI3Fb/yjhn58pqhW3cGbZ
 h3Cw==
X-Gm-Message-State: ANhLgQ0WcMoCK4YDLkcQSMqZJWGPTvTJ3M9ZMFoLSwWCmoB7UoH+FKC7
 fnurw5HP3O09fixlpEWF6epAWv3IHI/5Ew==
X-Google-Smtp-Source: ADFU+vtYM7v/+pjqutFqt/xhE6qIL8VJt0dneNW68orLoO62ueh07LKIM4vGiqFU6mUhEvowYqjBPQ==
X-Received: by 2002:a5d:4004:: with SMTP id n4mr16953382wrp.180.1585602246496; 
 Mon, 30 Mar 2020 14:04:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p21sm1012700wma.0.2020.03.30.14.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 14:04:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 4/4] target/arm: Implement ARMv8.2-TTS2UXN
Date: Mon, 30 Mar 2020 22:04:00 +0100
Message-Id: <20200330210400.11724-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200330210400.11724-1-peter.maydell@linaro.org>
References: <20200330210400.11724-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

The ARMv8.2-TTS2UXN feature extends the XN field in stage 2
translation table descriptors from just bit [54] to bits [54:53],
allowing stage 2 to control execution permissions separately for EL0
and EL1. Implement the new semantics of the XN field and enable
the feature for our 'max' CPU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    | 15 +++++++++++++++
 target/arm/cpu.c    |  1 +
 target/arm/cpu64.c  |  2 ++
 target/arm/helper.c | 37 +++++++++++++++++++++++++++++++------
 4 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index fe03a74bf08..9aae324d0f6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3610,6 +3610,11 @@ static inline bool isar_feature_aa32_ccidx(const ARMISARegisters *id)
     return FIELD_EX32(id->id_mmfr4, ID_MMFR4, CCIDX) != 0;
 }
 
+static inline bool isar_feature_aa32_tts2uxn(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, XNX) != 0;
+}
+
 /*
  * 64-bit feature tests via id registers.
  */
@@ -3822,6 +3827,11 @@ static inline bool isar_feature_aa64_ccidx(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, CCIDX) != 0;
 }
 
+static inline bool isar_feature_aa64_tts2uxn(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, XNX) != 0;
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
@@ -3850,6 +3860,11 @@ static inline bool isar_feature_any_ccidx(const ARMISARegisters *id)
     return isar_feature_aa64_ccidx(id) || isar_feature_aa32_ccidx(id);
 }
 
+static inline bool isar_feature_any_tts2uxn(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_tts2uxn(id) || isar_feature_aa32_tts2uxn(id);
+}
+
 /*
  * Forward to the above feature tests given an ARMCPU pointer.
  */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a79f233b170..d5dfb30525d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2684,6 +2684,7 @@ static void arm_max_initfn(Object *obj)
             t = FIELD_DP32(t, ID_MMFR4, HPDS, 1); /* AA32HPD */
             t = FIELD_DP32(t, ID_MMFR4, AC2, 1); /* ACTLR2, HACTLR2 */
             t = FIELD_DP32(t, ID_MMFR4, CNP, 1); /* TTCNP */
+            t = FIELD_DP32(t, ID_MMFR4, XNX, 1); /* TTS2UXN */
             cpu->isar.id_mmfr4 = t;
         }
 #endif
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 62d36f9e8d3..5fc6330c968 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -673,6 +673,7 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64MMFR1, VH, 1);
         t = FIELD_DP64(t, ID_AA64MMFR1, PAN, 2); /* ATS1E1 */
         t = FIELD_DP64(t, ID_AA64MMFR1, VMIDBITS, 2); /* VMID16 */
+        t = FIELD_DP64(t, ID_AA64MMFR1, XNX, 1); /* TTS2UXN */
         cpu->isar.id_aa64mmfr1 = t;
 
         t = cpu->isar.id_aa64mmfr2;
@@ -706,6 +707,7 @@ static void aarch64_max_initfn(Object *obj)
         u = FIELD_DP32(u, ID_MMFR4, HPDS, 1); /* AA32HPD */
         u = FIELD_DP32(u, ID_MMFR4, AC2, 1); /* ACTLR2, HACTLR2 */
         u = FIELD_DP32(t, ID_MMFR4, CNP, 1); /* TTCNP */
+        u = FIELD_DP32(t, ID_MMFR4, XNX, 1); /* TTS2UXN */
         cpu->isar.id_mmfr4 = u;
 
         u = cpu->isar.id_aa64dfr0;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 47a175b8e9d..cba8ac57983 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9891,9 +9891,10 @@ simple_ap_to_rw_prot(CPUARMState *env, ARMMMUIdx mmu_idx, int ap)
  *
  * @env:     CPUARMState
  * @s2ap:    The 2-bit stage2 access permissions (S2AP)
- * @xn:      XN (execute-never) bit
+ * @xn:      XN (execute-never) bits
+ * @s1_is_el0: true if this is S2 of an S1+2 walk for EL0
  */
-static int get_S2prot(CPUARMState *env, int s2ap, int xn)
+static int get_S2prot(CPUARMState *env, int s2ap, int xn, bool s1_is_el0)
 {
     int prot = 0;
 
@@ -9903,9 +9904,32 @@ static int get_S2prot(CPUARMState *env, int s2ap, int xn)
     if (s2ap & 2) {
         prot |= PAGE_WRITE;
     }
-    if (!xn) {
-        if (arm_el_is_aa64(env, 2) || prot & PAGE_READ) {
+
+    if (cpu_isar_feature(any_tts2uxn, env_archcpu(env))) {
+        switch (xn) {
+        case 0:
             prot |= PAGE_EXEC;
+            break;
+        case 1:
+            if (s1_is_el0) {
+                prot |= PAGE_EXEC;
+            }
+            break;
+        case 2:
+            break;
+        case 3:
+            if (!s1_is_el0) {
+                prot |= PAGE_EXEC;
+            }
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    } else {
+        if (!extract32(xn, 1, 1)) {
+            if (arm_el_is_aa64(env, 2) || prot & PAGE_READ) {
+                prot |= PAGE_EXEC;
+            }
         }
     }
     return prot;
@@ -10889,13 +10913,14 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
     }
 
     ap = extract32(attrs, 4, 2);
-    xn = extract32(attrs, 12, 1);
 
     if (mmu_idx == ARMMMUIdx_Stage2) {
         ns = true;
-        *prot = get_S2prot(env, ap, xn);
+        xn = extract32(attrs, 11, 2);
+        *prot = get_S2prot(env, ap, xn, s1_is_el0);
     } else {
         ns = extract32(attrs, 3, 1);
+        xn = extract32(attrs, 12, 1);
         pxn = extract32(attrs, 11, 1);
         *prot = get_S1prot(env, mmu_idx, aarch64, ap, ns, xn, pxn);
     }
-- 
2.20.1


