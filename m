Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7430EC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:56:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A2020848
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ph7WIM0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A2020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fCv-0000EN-Fz
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 12:56:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f7t-0005ya-9o
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f7q-0000sB-Tx
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:40 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35079)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2f7o-0000pL-7K
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:37 -0500
Received: by mail-wr1-x444.google.com with SMTP id w12so11894048wrt.2
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 09:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dw/oKtuPvdBDo/uw+ysmB9G26Zom6TRdfrmN+nZGS2g=;
 b=Ph7WIM0M+/oaSmorCsXPKgJGq8/zc+TGGs6DkwcMRbCJBSgdJMpIW8B7reKxumnrZ/
 h0/x2oBl+N4apaqLU68eGKd28nieZ2Tmw4seXx43rnZLWQpHNNo7DhP7g4MVrhGfn/X5
 NHALJoSAYhzG0nGnXbtdSJoLKxrT987so8TxDQDEijvLPbtDPDvGidh23o2JDQDEZy6o
 UnHR4PIzOsFzoBxO8yfDYuqIRx6ZtrVhUytGqtw2tyvVNZdIVolzXUZTHEZ7MBw5Ry7X
 fNKiKsgHxsYkf5mAvpKzrIJm6xUDOMkUGipFaZPltMtoUSTPoVFdCezLHYAFpZ4gFxxo
 h0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dw/oKtuPvdBDo/uw+ysmB9G26Zom6TRdfrmN+nZGS2g=;
 b=j3fChaaDMF9UsccOqROdveFPb1Pmm0bhSRVcoqS1Fr+vUTdL4Lt48VxTDs4eaz84jI
 wzYnUrMxrDvAl8H0G0txQ5CO3q+ymesi5ro3wFaIO1s/Lp/+kvVSkrr8uk0rZ5aNO9R3
 dtjPF19VGa4jiILR/pk2p3qSZNd+CA5HBq8hXU78vSoCvGFvY/BKktWtuLNajuuQS/vt
 lcFKWblGHO24eiRh4qDxnOpxCKn+ZwuQjnPehkw/NlXgAAlyObtE6RK69FIFuMugV6+1
 keSGdKjo/XG0rb3FZ+GIeSeybopyPCEkixeysQZknSGR2ecs/BhtEGUmbCNIlQ42HwlZ
 3ZRw==
X-Gm-Message-State: APjAAAVaIPs7AFNHUfWu7d1pUN5ddM46ZGHn4nuyhmcnDzJuggdqe+Ly
 FmeI1lfABFuSpvUBGnvSeqkjlBtLVvw=
X-Google-Smtp-Source: APXvYqx0nG2dlKhQr8/DJURN9S3a50yxke21GtXA0kNrNU5qe8Mt3g8EZHOgw3rmvF2wFFM3Q0i9xw==
X-Received: by 2002:adf:fe50:: with SMTP id m16mr5400914wrs.217.1581702694862; 
 Fri, 14 Feb 2020 09:51:34 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v8sm8001857wrw.2.2020.02.14.09.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 09:51:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 11/21] target/arm: Move DBGDIDR into ARMISARegisters
Date: Fri, 14 Feb 2020 17:51:06 +0000
Message-Id: <20200214175116.9164-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214175116.9164-1-peter.maydell@linaro.org>
References: <20200214175116.9164-1-peter.maydell@linaro.org>
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
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We're going to want to read the DBGDIDR register from KVM in
a subsequent commit, which means it needs to be in the
ARMISARegisters sub-struct. Move it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
index 39239186def..309d2f4ea95 100644
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
index 8415cc6b154..1dcbb68e49b 100644
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


