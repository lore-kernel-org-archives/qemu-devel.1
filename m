Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EAFC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:44:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C8CF20661
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SpKaS64m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8CF20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ZZq-0007Ac-3l
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 12:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZTl-0005oa-Qx
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZTj-0004C1-5p
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:45 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40396)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1ZTi-0004A7-RL
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:43 -0500
Received: by mail-wr1-x441.google.com with SMTP id t3so13488946wru.7
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 09:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Jy3CpiCNUfrp1JLIEXg9qAR4jJdj8q8ZZ8kelkkxy8w=;
 b=SpKaS64mlxQdPnaH5yk7jYv5re9yiJUx+jkvWW4GYSQuXOTsRfnhiWz/2yqbmHfDhG
 UzwgSBtRHfOhrVUU5maOrRBDIiRsA01Ry5c6vTIVp/+7nvGsNczxHzsRPFKTQHUFjVtR
 eakXX/O2E0trzOMktV4VZct8K8zzTSlt+vye1FgN5xY4fbRgt01SsbBv6syx+xYHxVgb
 Nf6Iakfu+XaTjaRdgRFS/QSdXtqL8jBEILTBO1zpfZH1qGb/J2ZceRgNJdReDPSX585D
 ksjLAKEVWv1TZASfN2+bJcMiMdByq193s15+CFot7LzkxW9Np4a3JM5J6Zq0yAEZxh6e
 /9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Jy3CpiCNUfrp1JLIEXg9qAR4jJdj8q8ZZ8kelkkxy8w=;
 b=UBFhCwRdGhnybyFZJUEO67OjeDxbfabgGCh3RYrL6GkMfzxO6AUHtnE8+phrAM0F39
 9h8Xwga+FIyIbqe/7StG3EQEHv9PxrCX+Rv6myFe5z7ACvyB0SXF80eZvzbzffUNkPIn
 2ClBalWpRpQZHKFB1x4Z07aR1f7uGkPM6p44rDvOBxadyXUc/FYNMa9zzijSCpaRKoOb
 dmM+Ukz1uBbJsCAemxx0qH9R11kkXoLOwwWEx1WnxFXP9oMoE5nRlnMksA+97ICzbluN
 c2mquyuvwX8xgWIoxhUiUpMDsyI5ll86Ph0mzxfh1aJg+z9REozhimk5Lz7JFuWTsxZk
 jEBA==
X-Gm-Message-State: APjAAAU4+dbzhBO6YNvdUlCgls0D9HI5WTQmblu5WYr+xRyXnI0HPAhh
 8F9pkWjn5BYcLXpbXSF2/6LOXQ==
X-Google-Smtp-Source: APXvYqzbr11ubOV7QNdbkESNTUUG4AbYe/HV5MDhanmGZpa+ecd+euF7WiFK9JYPTU6i8EJGfbz8oA==
X-Received: by 2002:a05:6000:1043:: with SMTP id
 c3mr9206184wrx.330.1581442661806; 
 Tue, 11 Feb 2020 09:37:41 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y1sm6109675wrq.16.2020.02.11.09.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 09:37:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 10/13] target/arm: Implement ARMv8.4-PMU extension
Date: Tue, 11 Feb 2020 17:37:23 +0000
Message-Id: <20200211173726.22541-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200211173726.22541-1-peter.maydell@linaro.org>
References: <20200211173726.22541-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

The ARMv8.4-PMU extension adds:
 * one new required event, STALL
 * one new system register PMMIR_EL1

(There are also some more L1-cache related events, but since
we don't implement any cache we don't provide these, in the
same way we don't provide the base-PMUv3 cache events.)

The STALL event "counts every attributable cycle on which no
attributable instruction or operation was sent for execution on this
PE".  QEMU doesn't stall in this sense, so this is another
always-reads-zero event.

The PMMIR_EL1 register is a read-only register providing
implementation-specific information about the PMU; currently it has
only one field, SLOTS, which defines behaviour of the STALL_SLOT PMU
event.  Since QEMU doesn't implement the STALL_SLOT event, we can
validly make the register read zero.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    | 18 ++++++++++++++++++
 target/arm/helper.c | 22 +++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2b3124fd76b..cfe7cfd1a4d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3569,6 +3569,13 @@ static inline bool isar_feature_aa32_pmu_8_1(const ARMISARegisters *id)
         FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) != 0xf;
 }
 
+static inline bool isar_feature_aa32_pmu_8_4(const ARMISARegisters *id)
+{
+    /* 0xf means "non-standard IMPDEF PMU" */
+    return FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) >= 5 &&
+        FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) != 0xf;
+}
+
 /*
  * 64-bit feature tests via id registers.
  */
@@ -3734,6 +3741,12 @@ static inline bool isar_feature_aa64_pmu_8_1(const ARMISARegisters *id)
         FIELD_EX32(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) != 0xf;
 }
 
+static inline bool isar_feature_aa64_pmu_8_4(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) >= 5 &&
+        FIELD_EX32(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) != 0xf;
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
@@ -3752,6 +3765,11 @@ static inline bool isar_feature_any_pmu_8_1(const ARMISARegisters *id)
     return isar_feature_aa64_pmu_8_1(id) || isar_feature_aa32_pmu_8_1(id);
 }
 
+static inline bool isar_feature_any_pmu_8_4(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_pmu_8_4(id) || isar_feature_aa32_pmu_8_4(id);
+}
+
 /*
  * Forward to the above feature tests given an ARMCPU pointer.
  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c896ad0b7ee..cb3c30f1725 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1130,6 +1130,12 @@ static bool pmu_8_1_events_supported(CPUARMState *env)
     return cpu_isar_feature(any_pmu_8_1, env_archcpu(env));
 }
 
+static bool pmu_8_4_events_supported(CPUARMState *env)
+{
+    /* For events which are supported in any v8.1 PMU */
+    return cpu_isar_feature(any_pmu_8_4, env_archcpu(env));
+}
+
 static uint64_t zero_event_get_count(CPUARMState *env)
 {
     /* For events which on QEMU never fire, so their count is always zero */
@@ -1170,6 +1176,11 @@ static const pm_event pm_events[] = {
       .get_count = zero_event_get_count,
       .ns_per_count = zero_event_ns_per,
     },
+    { .number = 0x03c, /* STALL */
+      .supported = pmu_8_4_events_supported,
+      .get_count = zero_event_get_count,
+      .ns_per_count = zero_event_ns_per,
+    },
 };
 
 /*
@@ -1178,7 +1189,7 @@ static const pm_event pm_events[] = {
  * should first be updated to something sparse instead of the current
  * supported_event_map[] array.
  */
-#define MAX_EVENT_ID 0x24
+#define MAX_EVENT_ID 0x3c
 #define UNSUPPORTED_EVENT UINT16_MAX
 static uint16_t supported_event_map[MAX_EVENT_ID + 1];
 
@@ -5930,6 +5941,15 @@ static void define_pmu_regs(ARMCPU *cpu)
         };
         define_arm_cp_regs(cpu, v81_pmu_regs);
     }
+    if (cpu_isar_feature(any_pmu_8_4, cpu)) {
+        static const ARMCPRegInfo v84_pmmir = {
+            .name = "PMMIR_EL1", .state = ARM_CP_STATE_BOTH,
+            .opc0 = 3, .opc1 = 0, .crn = 9, .crm = 14, .opc2 = 6,
+            .access = PL1_R, .accessfn = pmreg_access, .type = ARM_CP_CONST,
+            .resetvalue = 0
+        };
+        define_one_arm_cp_reg(cpu, &v84_pmmir);
+    }
 }
 
 /* We don't know until after realize whether there's a GICv3
-- 
2.20.1


