Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A0EC3B1B5
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:03:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7471B20848
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bJq6wSO6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7471B20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fJi-0003E9-Iy
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:03:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f7w-00064p-4d
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f7t-0000up-7I
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:43 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46886)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2f7s-0000sV-5R
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:40 -0500
Received: by mail-wr1-x443.google.com with SMTP id z7so11872841wrl.13
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 09:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4BLXsVcN28YFgzh7RunR4by8doFHHVtIkmiy7Jly1NU=;
 b=bJq6wSO64nQ7655iHrQy8uQ33zF92z6mllFOsd9mCZz9w/YAosZY/9qPsG69XByf4u
 ZcANLz6nOXrvhQJi4Ybn0eQTHvzbNrNUS8Qf3srvCqzUfQ96ycljrzhaalZYE3CKdpcr
 BDuP5yjRB9ClLPtg/a7/yseWhUV3a4vRBun+5dT/4Vm5lQLybz6KOZ4yps4GI82zDs22
 qojNNb4P3LxD69VBsrF4G1xF2dldKCKJ396BUQF/JMkTSRBIZMiwvA8+fsDpMp/RiLuX
 z+uN9q/Y2105JXkzLHHyoEU/fneulHwbP8nsDSgnebVUQ1BAXfvpKEahMUAr2Z1DNgkt
 GZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4BLXsVcN28YFgzh7RunR4by8doFHHVtIkmiy7Jly1NU=;
 b=qXu3+wDEH0a5fxem9WJd/zy9c8iuehUZLsp8YYT7GS/TPubytAn12DRcpb5RXwCZAh
 Tak849R983/0q6S81L5k+1zgILcKhvNnSPqZjPCozWk/Ndztxmf7KCBN/Oq0vBXVpIyH
 UVODNRgb3WWo9Goufdluob230N+BM9fkr6zlOfW37EZxwnylr1gXdyzXpiEdbovseWcU
 bpKy/5pLc5no4/JfZn2LOH5gIRJrjWj8Zn2hBT4tR/MYJsiCXgJYKmGI6wIhC6W/rTAt
 yi+gFHUoQJKloP+0OUYQT+yWxDorMg1UFQOMeF9YY9H8Ee9Sryd3tkYFQ+3FOqOJn4BO
 uuWg==
X-Gm-Message-State: APjAAAWGrh3lKbQrXAv4LNOYunhyTgqM3ulnvwJndTsVWBm6Z/3O6cGY
 Bbp/RfnnHq0TWB/XermCHy58Qluymts=
X-Google-Smtp-Source: APXvYqyAtnb4zGMsTJryfLntnFWOYcBV/xbFG14HBh7YCfI8bZDOSFdCgeWO3rOBAI6QaC0dtygT9w==
X-Received: by 2002:adf:b64b:: with SMTP id i11mr5502856wre.58.1581702698797; 
 Fri, 14 Feb 2020 09:51:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v8sm8001857wrw.2.2020.02.14.09.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 09:51:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 14/21] target/arm: Implement ARMv8.4-PMU extension
Date: Fri, 14 Feb 2020 17:51:09 +0000
Message-Id: <20200214175116.9164-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214175116.9164-1-peter.maydell@linaro.org>
References: <20200214175116.9164-1-peter.maydell@linaro.org>
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    | 18 ++++++++++++++++++
 target/arm/helper.c | 22 +++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e043932fcb1..cfa9fd6c1b9 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3519,6 +3519,13 @@ static inline bool isar_feature_aa32_pmu_8_1(const ARMISARegisters *id)
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
@@ -3704,6 +3711,12 @@ static inline bool isar_feature_aa64_pmu_8_1(const ARMISARegisters *id)
         FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) != 0xf;
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
@@ -3722,6 +3735,11 @@ static inline bool isar_feature_any_pmu_8_1(const ARMISARegisters *id)
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
index aeb01617150..2feded1518c 100644
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
 
@@ -6414,6 +6425,15 @@ static void define_pmu_regs(ARMCPU *cpu)
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


