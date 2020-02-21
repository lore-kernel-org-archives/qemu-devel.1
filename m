Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60492C35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C12B2073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UpolRszc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C12B2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58E3-0001fd-BT
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:20:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582R-0007L3-Q2
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582Q-00032I-CM
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:15 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:34906)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582Q-0002zb-5P
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:14 -0500
Received: by mail-wm1-x334.google.com with SMTP id b17so1786783wmb.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ayxTwKJPtrH+7ITeMQGolZtlE+otPOpXrIHYXAP1MJg=;
 b=UpolRszcWk2bBb/8nqkb8iEEkbuCX9ChgH1jRV/747x8OdA8ohnHadF28jH5/TkCSx
 l3CBKIrS8w80uMeb2SOD3DZggZwyLbUawSjDlqa+xBH+OwomoXEAVnvrZRltkibapXCJ
 jZfJ4orjsZ0BeekqcJys1BPTfKUY2IwVX4pbchssrgLevR6yeYQ6Xn2vjpKurJMYHI/V
 T50+Q0ugM4xhzhSsDa/8OPrZTr3FpIUcrx/Mojcbnx7IVMwv1AO8cHpvoomQUaoPke0I
 ObleRdU7GNHDg4covXnwPSSef1ovnqePC7ZEemFyZ02thn7B+ISNjyBx/3vZq3UA+9V3
 cqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ayxTwKJPtrH+7ITeMQGolZtlE+otPOpXrIHYXAP1MJg=;
 b=jzzcA9+YJZbZ5pa/gsoMKEUntlDZCmIHaQ4H7qiO/f2HeO90gdcr/DpN1DTeUpDM14
 fi8FCCfKjXFc+2gAz7q/2ERNqedTu9ibYGyTjM0Nge74K6oH1AsnRmTFsMb7KxLLSRcU
 jFIk54wA/bXVKECkpdJYcGS6tWb4xGnWTR0G6fav5JAPHzQEyGiJ/6SkNcONI9Ydxcj2
 ToTQNUJeyxCnmDgqRVsxIEEsNBvEFfo3KwV15q+aVlRzv0E3qfhrFCNg1eTjng/bWFBi
 BYHgtHlr0UNXsfmD94CH7sinjln2awUqykccrc/mIiaJ0T9VMegcKo96jPE6LSIGNLU9
 lVDg==
X-Gm-Message-State: APjAAAWVpeior6P2uYhQpfYFRdz7pshctu8GlMg4tVwfSpBsiY3MPhu8
 HguwrQUMpd0yZyPAfTurWrlxJ1BtZmFB4Q==
X-Google-Smtp-Source: APXvYqzk72vcv2HUL5uodtyW6scMLzu0C8hBn/l773FRAGj+G//hdGxfHXgzwiBwa8aZ2NeHR7+WDA==
X-Received: by 2002:a7b:c389:: with SMTP id s9mr3650328wmj.7.1582290491975;
 Fri, 21 Feb 2020 05:08:11 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.08.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:08:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/52] target/arm: Move DBGDIDR into ARMISARegisters
Date: Fri, 21 Feb 2020 13:07:12 +0000
Message-Id: <20200221130740.7583-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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

We're going to want to read the DBGDIDR register from KVM in
a subsequent commit, which means it needs to be in the
ARMISARegisters sub-struct. Move it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200214175116.9164-12-peter.maydell@linaro.org
---
 target/arm/cpu.h       | 2 +-
 target/arm/internals.h | 6 +++---
 target/arm/cpu.c       | 8 ++++----
 target/arm/cpu64.c     | 6 +++---
 target/arm/helper.c    | 2 +-
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0f21b6ed803..3c996db3e45 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -866,6 +866,7 @@ struct ARMCPU {
         uint32_t mvfr1;
         uint32_t mvfr2;
         uint32_t id_dfr0;
+        uint32_t dbgdidr;
         uint64_t id_aa64isar0;
         uint64_t id_aa64isar1;
         uint64_t id_aa64pfr0;
@@ -893,7 +894,6 @@ struct ARMCPU {
     uint32_t id_mmfr4;
     uint64_t id_aa64afr0;
     uint64_t id_aa64afr1;
-    uint32_t dbgdidr;
     uint32_t clidr;
     uint64_t mp_affinity; /* MP ID without feature bits */
     /* The elements of this array are the CCSIDR values for each cache,
diff --git a/target/arm/internals.h b/target/arm/internals.h
index e07a7306c77..9f96a2359f3 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -941,7 +941,7 @@ static inline int arm_num_brps(ARMCPU *cpu)
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         return FIELD_EX64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, BRPS) + 1;
     } else {
-        return FIELD_EX32(cpu->dbgdidr, DBGDIDR, BRPS) + 1;
+        return FIELD_EX32(cpu->isar.dbgdidr, DBGDIDR, BRPS) + 1;
     }
 }
 
@@ -955,7 +955,7 @@ static inline int arm_num_wrps(ARMCPU *cpu)
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         return FIELD_EX64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, WRPS) + 1;
     } else {
-        return FIELD_EX32(cpu->dbgdidr, DBGDIDR, WRPS) + 1;
+        return FIELD_EX32(cpu->isar.dbgdidr, DBGDIDR, WRPS) + 1;
     }
 }
 
@@ -969,7 +969,7 @@ static inline int arm_num_ctx_cmps(ARMCPU *cpu)
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         return FIELD_EX64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, CTX_CMPS) + 1;
     } else {
-        return FIELD_EX32(cpu->dbgdidr, DBGDIDR, CTX_CMPS) + 1;
+        return FIELD_EX32(cpu->isar.dbgdidr, DBGDIDR, CTX_CMPS) + 1;
     }
 }
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7759e0f9329..f58b4da4427 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2298,7 +2298,7 @@ static void cortex_a8_initfn(Object *obj)
     cpu->isar.id_isar2 = 0x21232031;
     cpu->isar.id_isar3 = 0x11112131;
     cpu->isar.id_isar4 = 0x00111142;
-    cpu->dbgdidr = 0x15141000;
+    cpu->isar.dbgdidr = 0x15141000;
     cpu->clidr = (1 << 27) | (2 << 24) | 3;
     cpu->ccsidr[0] = 0xe007e01a; /* 16k L1 dcache. */
     cpu->ccsidr[1] = 0x2007e01a; /* 16k L1 icache. */
@@ -2371,7 +2371,7 @@ static void cortex_a9_initfn(Object *obj)
     cpu->isar.id_isar2 = 0x21232041;
     cpu->isar.id_isar3 = 0x11112131;
     cpu->isar.id_isar4 = 0x00111142;
-    cpu->dbgdidr = 0x35141000;
+    cpu->isar.dbgdidr = 0x35141000;
     cpu->clidr = (1 << 27) | (1 << 24) | 3;
     cpu->ccsidr[0] = 0xe00fe019; /* 16k L1 dcache. */
     cpu->ccsidr[1] = 0x200fe019; /* 16k L1 icache. */
@@ -2439,7 +2439,7 @@ static void cortex_a7_initfn(Object *obj)
     cpu->isar.id_isar2 = 0x21232041;
     cpu->isar.id_isar3 = 0x11112131;
     cpu->isar.id_isar4 = 0x10011142;
-    cpu->dbgdidr = 0x3515f005;
+    cpu->isar.dbgdidr = 0x3515f005;
     cpu->clidr = 0x0a200023;
     cpu->ccsidr[0] = 0x701fe00a; /* 32K L1 dcache */
     cpu->ccsidr[1] = 0x201fe00a; /* 32K L1 icache */
@@ -2482,7 +2482,7 @@ static void cortex_a15_initfn(Object *obj)
     cpu->isar.id_isar2 = 0x21232041;
     cpu->isar.id_isar3 = 0x11112131;
     cpu->isar.id_isar4 = 0x10011142;
-    cpu->dbgdidr = 0x3515f021;
+    cpu->isar.dbgdidr = 0x3515f021;
     cpu->clidr = 0x0a200023;
     cpu->ccsidr[0] = 0x701fe00a; /* 32K L1 dcache */
     cpu->ccsidr[1] = 0x201fe00a; /* 32K L1 icache */
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 2030e5e384b..f8f74a7ecda 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -138,7 +138,7 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->isar.id_aa64dfr0 = 0x10305106;
     cpu->isar.id_aa64isar0 = 0x00011120;
     cpu->isar.id_aa64mmfr0 = 0x00001124;
-    cpu->dbgdidr = 0x3516d000;
+    cpu->isar.dbgdidr = 0x3516d000;
     cpu->clidr = 0x0a200023;
     cpu->ccsidr[0] = 0x701fe00a; /* 32KB L1 dcache */
     cpu->ccsidr[1] = 0x201fe012; /* 48KB L1 icache */
@@ -192,7 +192,7 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->isar.id_aa64dfr0 = 0x10305106;
     cpu->isar.id_aa64isar0 = 0x00011120;
     cpu->isar.id_aa64mmfr0 = 0x00001122; /* 40 bit physical addr */
-    cpu->dbgdidr = 0x3516d000;
+    cpu->isar.dbgdidr = 0x3516d000;
     cpu->clidr = 0x0a200023;
     cpu->ccsidr[0] = 0x700fe01a; /* 32KB L1 dcache */
     cpu->ccsidr[1] = 0x201fe00a; /* 32KB L1 icache */
@@ -244,7 +244,7 @@ static void aarch64_a72_initfn(Object *obj)
     cpu->isar.id_aa64dfr0 = 0x10305106;
     cpu->isar.id_aa64isar0 = 0x00011120;
     cpu->isar.id_aa64mmfr0 = 0x00001124;
-    cpu->dbgdidr = 0x3516d000;
+    cpu->isar.dbgdidr = 0x3516d000;
     cpu->clidr = 0x0a200023;
     cpu->ccsidr[0] = 0x701fe00a; /* 32KB L1 dcache */
     cpu->ccsidr[1] = 0x201fe012; /* 48KB L1 icache */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 87e71fb8c78..68649121250 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6252,7 +6252,7 @@ static void define_debug_regs(ARMCPU *cpu)
     ARMCPRegInfo dbgdidr = {
         .name = "DBGDIDR", .cp = 14, .crn = 0, .crm = 0, .opc1 = 0, .opc2 = 0,
         .access = PL0_R, .accessfn = access_tda,
-        .type = ARM_CP_CONST, .resetvalue = cpu->dbgdidr,
+        .type = ARM_CP_CONST, .resetvalue = cpu->isar.dbgdidr,
     };
 
     /* Note that all these register fields hold "number of Xs minus 1". */
-- 
2.20.1


