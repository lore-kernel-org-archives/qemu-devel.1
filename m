Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B73C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:24:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26940206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ALrj4K9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26940206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58IB-0008Or-B9
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:24:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582P-0007Eo-CF
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582N-0002wW-UM
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:13 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:55607)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582N-0002vn-Ny
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:11 -0500
Received: by mail-wm1-x32e.google.com with SMTP id q9so1719957wmj.5
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=EsdiaTm0IFB2gzMCnWsA71C+8ZH9oy94y+EHWu8Arx4=;
 b=ALrj4K9M14gp9kwKII/ofaQUUYxEa+RBEdM+s3KPYHpmzINtVg3CsOhv3pNyPsffkB
 mxfsEZ05lnmdCQdQnoBBFRWd0biZqCJwWgijG7IQ2MzIkyup9R5bV8+WgTNHziRjRjO+
 SAHu2c5d9N4+/2qfVTmOwkDbTqj84V5RgkUGUFyXskKqUoOSNp4fJr9hUP6+IPbTIiDN
 mkKK6Bb3XBh4NVxiB/7OJUZ1yi/WLSexq8uR5M84lABGunpqptGJWb5Yo+2VdnJLeXgm
 hL68FOKQVRgCyMpLwLfj+3g3NxUFNMADKpL3LnuJNh+HqiMSVP9LUvqR6YzE2mcziNUS
 3XYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EsdiaTm0IFB2gzMCnWsA71C+8ZH9oy94y+EHWu8Arx4=;
 b=XKN1tXAf5pNKZv7YoEYVlosIbSZIV/30IL9itkjHlDw9Jrs3QIYH+yFLO3FiKUVGU4
 ycsgP9lOl9+qY/jn7XHDPN0kUBJhogrqDUfm/2AoXNfF/AVSHr4jdLZuPsM3lAz4zGfm
 Q2yXJyYIRE9E93w4QSv2v4GU/potGxxkfddtqkRsHh8u5g2wb/lCbVZCYpUnN0WfOY4n
 +C6qRZ51r1YLJ5vb8j3CPt2vHEweaGCN5j2GocKdS6+wwNdt7mRM+sI8zcCFPZ/4CzQO
 BT5sf2gcC1EFh5he96V+Sg62mKuGvCBpHhbnBeuucsFnZ/jrT73kCMIL9uHiGt6OthFp
 WVYg==
X-Gm-Message-State: APjAAAX2tvlCSoh6UWKSn9md62/e0leFk3RY52lDaqNYAPmXOSevOFUR
 T/08Lq1nZmk3+rphkEuDVy13vT83g2VJsA==
X-Google-Smtp-Source: APXvYqwnRhnzRjhvq6d7Q0INO69kT3UnorSyctzRZ6PoTgnN+/MRCbKLo1DOgkRIUYDKOVzcIYmEhQ==
X-Received: by 2002:a05:600c:21da:: with SMTP id
 x26mr3711841wmj.114.1582290489546; 
 Fri, 21 Feb 2020 05:08:09 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.08.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:08:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/52] target/arm: Add _aa64_ and _any_ versions of pmu_8_1
 isar checks
Date: Fri, 21 Feb 2020 13:07:10 +0000
Message-Id: <20200221130740.7583-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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

Add the 64-bit version of the "is this a v8.1 PMUv3?"
ID register check function, and the _any_ version that
checks for either AArch32 or AArch64 support. We'll use
this in a later commit.

We don't (yet) do any isar_feature checks on ID_AA64DFR1_EL1,
but we move id_aa64dfr1 into the ARMISARegisters struct with
id_aa64dfr0, for consistency.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200214175116.9164-10-peter.maydell@linaro.org
---
 target/arm/cpu.h    | 15 +++++++++++++--
 target/arm/cpu.c    |  3 ++-
 target/arm/cpu64.c  |  6 +++---
 target/arm/helper.c | 12 +++++++-----
 4 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 6c6088eb587..98240224c0c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -873,6 +873,8 @@ struct ARMCPU {
         uint64_t id_aa64mmfr0;
         uint64_t id_aa64mmfr1;
         uint64_t id_aa64mmfr2;
+        uint64_t id_aa64dfr0;
+        uint64_t id_aa64dfr1;
     } isar;
     uint32_t midr;
     uint32_t revidr;
@@ -889,8 +891,6 @@ struct ARMCPU {
     uint32_t id_mmfr2;
     uint32_t id_mmfr3;
     uint32_t id_mmfr4;
-    uint64_t id_aa64dfr0;
-    uint64_t id_aa64dfr1;
     uint64_t id_aa64afr0;
     uint64_t id_aa64afr1;
     uint32_t dbgdidr;
@@ -3686,6 +3686,12 @@ static inline bool isar_feature_aa64_bti(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, BT) != 0;
 }
 
+static inline bool isar_feature_aa64_pmu_8_1(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) >= 4 &&
+        FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) != 0xf;
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
@@ -3699,6 +3705,11 @@ static inline bool isar_feature_any_predinv(const ARMISARegisters *id)
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
index b85040d36bc..7759e0f9329 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1718,7 +1718,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
                 cpu);
 #endif
     } else {
-        cpu->id_aa64dfr0 = FIELD_DP64(cpu->id_aa64dfr0, ID_AA64DFR0, PMUVER, 0);
+        cpu->isar.id_aa64dfr0 =
+            FIELD_DP64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, PMUVER, 0);
         cpu->isar.id_dfr0 = FIELD_DP32(cpu->isar.id_dfr0, ID_DFR0, PERFMON, 0);
         cpu->pmceid0 = 0;
         cpu->pmceid1 = 0;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 9e4387158f9..2030e5e384b 100644
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
index f78500e2a9e..679f340c55f 100644
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
@@ -6266,9 +6267,10 @@ static void define_debug_regs(ARMCPU *cpu)
      * check that if they both exist then they agree.
      */
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-        assert(FIELD_EX64(cpu->id_aa64dfr0, ID_AA64DFR0, BRPS) == brps);
-        assert(FIELD_EX64(cpu->id_aa64dfr0, ID_AA64DFR0, WRPS) == wrps);
-        assert(FIELD_EX64(cpu->id_aa64dfr0, ID_AA64DFR0, CTX_CMPS) == ctx_cmps);
+        assert(FIELD_EX64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, BRPS) == brps);
+        assert(FIELD_EX64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, WRPS) == wrps);
+        assert(FIELD_EX64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, CTX_CMPS)
+               == ctx_cmps);
     }
 
     define_one_arm_cp_reg(cpu, &dbgdidr);
@@ -7010,12 +7012,12 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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


