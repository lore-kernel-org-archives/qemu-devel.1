Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2905C352A1
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:03:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FCA020726
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AZZPNasi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FCA020726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0PlS-0000sN-CD
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 08:03:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Pgz-0000w3-9l
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Pgy-0005DF-7G
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:37 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46542)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j0Pgy-0005Cv-0q
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:36 -0500
Received: by mail-wr1-x441.google.com with SMTP id z7so1983559wrl.13
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 04:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=k/k5v7TYVkBZgnpFZntRFjxp8rADwUlaXt3p2gBQVc4=;
 b=AZZPNasiCTisHChLRWnP7pA6o7XQ05Oip72av1GxrImGkxwr4I4dmHK4EWmyv9Mnbt
 9UpuX26bmxrEPN5UUKdUvEgft/CyGe10e3Tuk/xuD0rjaB4MzZS1CXuGba/nfVQG1K6H
 Jnm3dMcI7tzVBD5ndtE80GYgzRelSSTjzxbDMFX1xLrOMtdX2QICyBs9qz+BFEs/CkOi
 lShBM7TqdZMrDVtXtyRouN52HkejgdzmeVJh2BqjGIkakv079z59DWyTo7LHXEPcGfKF
 sdWRkXhrYjlM4RkKTxrDn+lM54wJMse5zN67oh6ne+Cu/hhJACaKKYLJSEzqDnYWrwsm
 sVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=k/k5v7TYVkBZgnpFZntRFjxp8rADwUlaXt3p2gBQVc4=;
 b=K7/OdksxWG1c3MV/EiRzxN+dhPZ1bAV04I9JppGfF9aWMV/QB4DU/XEy0x8o18EU6C
 njStPaPOR09cJcHWVO9HhtTaElVYqo6k2EfjBBv7JHeecyDQ92XlmBzVmpZJ8CXcg4H2
 75zRQsGtpBMF6antt6qc1y5NQkBDn/MjAGPhQmiYJhqJ8CbSZ0AMFyBhAxcGJO79+D6Z
 PW4CeN6N2RM5JI7j0XLcmS5fsGetCpN9Qt2hmE/T2XpmBwgd3faYWPlByJPSxUwGdWjT
 dSgdqMBh8OFWGRF5z9VUVoZwglNJ1WEvzm1XS0JpT6pz3J50O8qRdfmvHpm9+NikjVIF
 NMOw==
X-Gm-Message-State: APjAAAWHvWMN85BM5qZ+ypAOp3wER5SYZ0xWqW1Hi3t28MgEj6dLroii
 D1CFnldstwcq0V1anCPceEKKcti41p8iaw==
X-Google-Smtp-Source: APXvYqwJIUFCCxlLJlvri0gGebFpxK0dGT6763ezmzyZmsu6A+2Jx+Vhos+HIgTCNyGJY5lypjI2aQ==
X-Received: by 2002:adf:dc8d:: with SMTP id r13mr5571560wrj.357.1581166714886; 
 Sat, 08 Feb 2020 04:58:34 -0800 (PST)
Received: from localhost.localdomain ([82.3.55.76])
 by smtp.gmail.com with ESMTPSA id p5sm7490534wrt.79.2020.02.08.04.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 04:58:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 17/20] target/arm: Add ID_AA64MMFR2_EL1
Date: Sat,  8 Feb 2020 12:58:13 +0000
Message-Id: <20200208125816.14954-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200208125816.14954-1-richard.henderson@linaro.org>
References: <20200208125816.14954-1-richard.henderson@linaro.org>
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add definitions for all of the fields, up to ARMv8.5.
Convert the existing RESERVED register to a full register.
Query KVM for the value of the register for the host.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    | 17 +++++++++++++++++
 target/arm/helper.c |  4 ++--
 target/arm/kvm64.c  |  2 ++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 65a0ef8cd6..71879393c2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -871,6 +871,7 @@ struct ARMCPU {
         uint64_t id_aa64pfr1;
         uint64_t id_aa64mmfr0;
         uint64_t id_aa64mmfr1;
+        uint64_t id_aa64mmfr2;
     } isar;
     uint32_t midr;
     uint32_t revidr;
@@ -1803,6 +1804,22 @@ FIELD(ID_AA64MMFR1, PAN, 20, 4)
 FIELD(ID_AA64MMFR1, SPECSEI, 24, 4)
 FIELD(ID_AA64MMFR1, XNX, 28, 4)
 
+FIELD(ID_AA64MMFR2, CNP, 0, 4)
+FIELD(ID_AA64MMFR2, UAO, 4, 4)
+FIELD(ID_AA64MMFR2, LSM, 8, 4)
+FIELD(ID_AA64MMFR2, IESB, 12, 4)
+FIELD(ID_AA64MMFR2, VARANGE, 16, 4)
+FIELD(ID_AA64MMFR2, CCIDX, 20, 4)
+FIELD(ID_AA64MMFR2, NV, 24, 4)
+FIELD(ID_AA64MMFR2, ST, 28, 4)
+FIELD(ID_AA64MMFR2, AT, 32, 4)
+FIELD(ID_AA64MMFR2, IDS, 36, 4)
+FIELD(ID_AA64MMFR2, FWB, 40, 4)
+FIELD(ID_AA64MMFR2, TTL, 48, 4)
+FIELD(ID_AA64MMFR2, BBM, 52, 4)
+FIELD(ID_AA64MMFR2, EVT, 56, 4)
+FIELD(ID_AA64MMFR2, E0PD, 60, 4)
+
 FIELD(ID_DFR0, COPDBG, 0, 4)
 FIELD(ID_DFR0, COPSDBG, 4, 4)
 FIELD(ID_DFR0, MMAPDBG, 8, 4)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index d99661d4ea..d29722d8ac 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7073,11 +7073,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
               .resetvalue = cpu->isar.id_aa64mmfr1 },
-            { .name = "ID_AA64MMFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
+            { .name = "ID_AA64MMFR2_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = 0 },
+              .resetvalue = cpu->isar.id_aa64mmfr2 },
             { .name = "ID_AA64MMFR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index fb21ab9e73..3bae9e4a66 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -549,6 +549,8 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                               ARM64_SYS_REG(3, 0, 0, 7, 0));
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr1,
                               ARM64_SYS_REG(3, 0, 0, 7, 1));
+        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr2,
+                              ARM64_SYS_REG(3, 0, 0, 7, 2));
 
         /*
          * Note that if AArch32 support is not present in the host,
-- 
2.20.1


