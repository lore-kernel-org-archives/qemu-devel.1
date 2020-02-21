Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53826C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:22:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 211C924650
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TWqNjT1o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 211C924650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58GG-0005DY-7k
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:22:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56810)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582U-0007Sv-P4
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582T-00035L-Ap
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:18 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37066)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582T-00034w-3Q
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:17 -0500
Received: by mail-wm1-x343.google.com with SMTP id a6so1777892wme.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=FgrSznS6GQA2r5mNaBbVlZPpkueYI11Yncfhcl8nXSI=;
 b=TWqNjT1oW4nBL+siIovxN33o+NgO5a+tqblWw8YdCWdkmqq/9S1NxRafrrOc2AcBUx
 URAhxMxcMa/1JeASX7LCg5s7r+XFOWgt36IsFkj6GJDqAS72+VWbpt+iPIDnMTpgz99H
 1mH+2Fol6x+63UeYR6n0QrhKuePBVKzj0bl8e/IzkIVnJPdcymiYPgTSCWQBXbouju+y
 v1YBse5lIsLF2OoLMS/AWpGbJ/kJLxh3Ha4dCfH8K9Nt1HLB0/lkJfE/EMnuca0/E3+g
 ICEUC2mZXmYbZVIJfMsQlY6Bw/IF+wytaQOZRMN1uFApcMIxwoq4eJLZraSjUX/r6MKm
 Anow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FgrSznS6GQA2r5mNaBbVlZPpkueYI11Yncfhcl8nXSI=;
 b=bx9yFmAmKd35r06WlUgRMynoKypDgqgn4wRsNlf8E9KTpvJVcbv3n7NBiTHZK9Kv9b
 LFlyD705H52/bJsQbv0LXV3H4CoAt4GJsYRnoSvL1AphvKo7ED64RcVbCPakGzKNcs2O
 XBO8XMymSD3CPjKNQiBoJ+wz358TcY4sEp24lryz7a21YnSkaVuiJX76Luqwka0rzS6f
 1F2JFAvAykf2eaUXA4fOPh7PqJB0grvS438KKf7qeIvbPtIg9H8s1X0cQJsEZGQ3ckQB
 d6VwSbIhUo9RmaX/nMr3rAt2DLIa+HK4kuRNntDZaL+KG+InL3XMbAnNi/368wjFfmr/
 IZsw==
X-Gm-Message-State: APjAAAXSbGj4d6TkDy8qHAXxiDCjV8xHtjChb70GU9dU315x4DrGfqT9
 MMDKxC0x7uE0mWZ2RWVjVhwsshpXr1IcEA==
X-Google-Smtp-Source: APXvYqyXIucbqCKyD0rnmJc6s2WICrYIgd6sWDnDvNhIuKaVxkn5/1n+BrA89ebcKwYQYPICITKTcA==
X-Received: by 2002:a7b:c4c3:: with SMTP id g3mr3702295wmk.131.1582290495626; 
 Fri, 21 Feb 2020 05:08:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.08.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:08:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/52] target/arm: Implement ARMv8.4-PMU extension
Date: Fri, 21 Feb 2020 13:07:15 +0000
Message-Id: <20200221130740.7583-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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
Message-id: 20200214175116.9164-15-peter.maydell@linaro.org
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
index 2fe09c1d604..72c9c7e694a 100644
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


