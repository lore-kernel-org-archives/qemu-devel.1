Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD11C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 630F220661
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LBvNWR9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 630F220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ZYT-0004v4-Gy
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 12:42:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZTm-0005pM-3d
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZTh-00048P-Oa
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:45 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39501)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1ZTh-00043p-1K
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:41 -0500
Received: by mail-wr1-x444.google.com with SMTP id y11so13492359wrt.6
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 09:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ucNrZJf0C4BvTU3CzZYsrcIsc3eh6wBiuuMARDrwH1U=;
 b=LBvNWR9HqQoe/2KybHe22GjBYmuDYNR6IUJPFf7OAEwAVhDKTQ8MyYCLwfMrwa7wU1
 Geg6iMGb1Yz3QojrwIXUk1l3s6eyQO9CNfp8mp5+NMaDFqEdtZRxVmlW0u3Oic4rYz56
 u0NKNiMeOTlZQGBaw8eyZtufO2rFgBE8dNF6+yxzSQ6GDYmdRz+9nlxolzGqHNMUph7D
 p3Mgf8Pe75W+ij1LpUhE/Qp8px7wQwpKr1X24Kzlwng09komnwZHgzZeDuSowjVmgpxZ
 54aNladC7wI61EFsX7HGtejmGTkNOxywIc11lTEmp5WMCFCifjon3JlyZoOngyvPmO5v
 w2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ucNrZJf0C4BvTU3CzZYsrcIsc3eh6wBiuuMARDrwH1U=;
 b=su1zB2aAEAQnpwWaNmoc14s5iPUs2eOrQtYvlZhlU+08fY9IF0JfStk/g6MBeP6dpf
 MNSXCCLgTNUa6T1Cq795Uc/iVIBH0eLn1wMRvaIteqlnS73uEp5eCIuRWvDYGShK4Otm
 1+LsggYq9nPSzxM1lAksiHAcnyOJ9XuWiZDpmQUrgPC9FApf8eTTcL4er22GYvtlkPob
 Pl1V+vWJ7Qd/IQ9qpnT1GXNSOejgP8XEC+KeJBiOar7jNcg3H49EvsqwX0A10pchGYAD
 ROfZ267lYxrU/PJmtU+jzS0B1XuNRRyZ1QfE8vEmdbLUI4+919iu5ba5m4tBSSId9C6u
 rLvg==
X-Gm-Message-State: APjAAAXYNw8Hf944jytJU+UWnYjUgpiAfPNzY/Za2iIk9R1PSItjF0M2
 drE3sb6Ow3f9ywrnUX3X3A88qQ==
X-Google-Smtp-Source: APXvYqzzVdNnAbNvN1VqmhPk7/SJZhRQRfyyOR5kMz7ZQlkDcf/5gdAlDQ7COEmT3eqHp3XnHc6jDw==
X-Received: by 2002:a5d:530e:: with SMTP id e14mr9482508wrv.250.1581442659558; 
 Tue, 11 Feb 2020 09:37:39 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y1sm6109675wrq.16.2020.02.11.09.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 09:37:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 08/13] target/arm: Add _aa64_ and _any_ versions of pmu_8_1
 isar checks
Date: Tue, 11 Feb 2020 17:37:21 +0000
Message-Id: <20200211173726.22541-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200211173726.22541-1-peter.maydell@linaro.org>
References: <20200211173726.22541-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the 64-bit version of the "is this a v8.1 PMUv3?"
ID register check function, and the _any_ version that
checks for either AArch32 or AArch64 support. We'll use
this in a later commit.

We don't (yet) do any isar_feature checks on ID_AA64DFR1_EL1,
but we move id_aa64dfr1 into the ARMISARegisters struct with
id_aa64dfr0, for consistency.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    | 15 +++++++++++++--
 target/arm/cpu.c    |  3 ++-
 target/arm/cpu64.c  |  6 +++---
 target/arm/helper.c | 12 +++++++-----
 4 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b55f6c8b7d3..2b3124fd76b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -871,6 +871,8 @@ struct ARMCPU {
         uint64_t id_aa64pfr1;
         uint64_t id_aa64mmfr0;
         uint64_t id_aa64mmfr1;
+        uint64_t id_aa64dfr0;
+        uint64_t id_aa64dfr1;
     } isar;
     uint32_t midr;
     uint32_t revidr;
@@ -887,8 +889,6 @@ struct ARMCPU {
     uint32_t id_mmfr2;
     uint32_t id_mmfr3;
     uint32_t id_mmfr4;
-    uint64_t id_aa64dfr0;
-    uint64_t id_aa64dfr1;
     uint64_t id_aa64afr0;
     uint64_t id_aa64afr1;
     uint32_t dbgdidr;
@@ -3728,6 +3728,12 @@ static inline bool isar_feature_aa64_bti(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, BT) != 0;
 }
 
+static inline bool isar_feature_aa64_pmu_8_1(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) >= 4 &&
+        FIELD_EX32(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) != 0xf;
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
@@ -3741,6 +3747,11 @@ static inline bool isar_feature_any_predinv(const ARMISARegisters *id)
     return isar_feature_aa64_predinv(id) || isar_feature_aa32_predinv(id);
 }
 
+static inline bool isar_feature_any_pmu_8_1(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_pmu_8_1(id) || isar_feature_aa32_pmu_8_1(id);
+}
+
 /*
  * Forward to the above feature tests given an ARMCPU pointer.
  */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ac0c96322d1..df44df1a43a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1602,7 +1602,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
                 cpu);
 #endif
     } else {
-        cpu->id_aa64dfr0 = FIELD_DP32(cpu->id_aa64dfr0, ID_AA64DFR0, PMUVER, 0);
+        cpu->isar.id_aa64dfr0 =
+            FIELD_DP32(cpu->isar.id_aa64dfr0, ID_AA64DFR0, PMUVER, 0);
         cpu->isar.id_dfr0 = FIELD_DP32(cpu->isar.id_dfr0, ID_DFR0, PERFMON, 0);
         cpu->pmceid0 = 0;
         cpu->pmceid1 = 0;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index f8fda7e0988..4b4b134ef84 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -135,7 +135,7 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->isar.id_isar5 = 0x00011121;
     cpu->isar.id_isar6 = 0;
     cpu->isar.id_aa64pfr0 = 0x00002222;
-    cpu->id_aa64dfr0 = 0x10305106;
+    cpu->isar.id_aa64dfr0 = 0x10305106;
     cpu->isar.id_aa64isar0 = 0x00011120;
     cpu->isar.id_aa64mmfr0 = 0x00001124;
     cpu->dbgdidr = 0x3516d000;
@@ -189,7 +189,7 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->isar.id_isar5 = 0x00011121;
     cpu->isar.id_isar6 = 0;
     cpu->isar.id_aa64pfr0 = 0x00002222;
-    cpu->id_aa64dfr0 = 0x10305106;
+    cpu->isar.id_aa64dfr0 = 0x10305106;
     cpu->isar.id_aa64isar0 = 0x00011120;
     cpu->isar.id_aa64mmfr0 = 0x00001122; /* 40 bit physical addr */
     cpu->dbgdidr = 0x3516d000;
@@ -241,7 +241,7 @@ static void aarch64_a72_initfn(Object *obj)
     cpu->isar.id_isar4 = 0x00011142;
     cpu->isar.id_isar5 = 0x00011121;
     cpu->isar.id_aa64pfr0 = 0x00002222;
-    cpu->id_aa64dfr0 = 0x10305106;
+    cpu->isar.id_aa64dfr0 = 0x10305106;
     cpu->isar.id_aa64isar0 = 0x00011120;
     cpu->isar.id_aa64mmfr0 = 0x00001124;
     cpu->dbgdidr = 0x3516d000;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index ca0bf3402ca..9537785104e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -25,6 +25,7 @@
 #include "hw/semihosting/semihost.h"
 #include "sysemu/cpus.h"
 #include "sysemu/kvm.h"
+#include "sysemu/tcg.h"
 #include "qemu/range.h"
 #include "qapi/qapi-commands-machine-target.h"
 #include "qapi/error.h"
@@ -5771,9 +5772,10 @@ static void define_debug_regs(ARMCPU *cpu)
      * check that if they both exist then they agree.
      */
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-        assert(FIELD_EX32(cpu->id_aa64dfr0, ID_AA64DFR0, BRPS) == brps);
-        assert(FIELD_EX32(cpu->id_aa64dfr0, ID_AA64DFR0, WRPS) == wrps);
-        assert(FIELD_EX32(cpu->id_aa64dfr0, ID_AA64DFR0, CTX_CMPS) == ctx_cmps);
+        assert(FIELD_EX32(cpu->isar.id_aa64dfr0, ID_AA64DFR0, BRPS) == brps);
+        assert(FIELD_EX32(cpu->isar.id_aa64dfr0, ID_AA64DFR0, WRPS) == wrps);
+        assert(FIELD_EX32(cpu->isar.id_aa64dfr0, ID_AA64DFR0, CTX_CMPS)
+               == ctx_cmps);
     }
 
     define_one_arm_cp_reg(cpu, &dbgdidr);
@@ -6395,12 +6397,12 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->id_aa64dfr0 },
+              .resetvalue = cpu->isar.id_aa64dfr0 },
             { .name = "ID_AA64DFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->id_aa64dfr1 },
+              .resetvalue = cpu->isar.id_aa64dfr1 },
             { .name = "ID_AA64DFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
-- 
2.20.1


