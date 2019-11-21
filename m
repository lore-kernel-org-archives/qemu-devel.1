Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDA5C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 00:14:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B70E20885
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 00:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sngSs25s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B70E20885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXa7A-0006AD-9b
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 19:14:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iXa2Z-0000JY-QT
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 19:09:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iXa2Y-0005pP-Cq
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 19:09:43 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36167)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iXa2Y-0005p1-8d
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 19:09:42 -0500
Received: by mail-ot1-x341.google.com with SMTP id f10so1338004oto.3
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 16:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Rdoo/trm2kfQbHrpXryTEVHE3GHeXymHmhFHGDwpeds=;
 b=sngSs25sWQUSqJMDGvDXVQEzAQlgRRZiiFG0+slzGADNnd7glffB0YktsqjeF+7hKO
 7bpD+FmpW1YNuLXby9+kuKqMzF2aL03X6aeYe7RCcbYM78kF5NvivS7E+OPAQ4Z98n2Q
 02r2pF8fRl8+j/4ELA8Lu30AlQyj/Bf+dPxNosQoy+MlVB6bGHXY5ZtP2UVyduWaTncb
 3FlDZMMM8ODEErbcUM65ofqJuASMYhmCTHTBtrVXQlIAOd9lvxhV9UpSOEfJ37eBDld4
 il9dvh4kNgAnU+iMr9ARhUauEXFxf/wqndtRQM0vYDQ48L5upcoQ2Qarv+O+dfOc7kLI
 NISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Rdoo/trm2kfQbHrpXryTEVHE3GHeXymHmhFHGDwpeds=;
 b=fivhQMNUSB8Qh77wsuUjb3rJhfDrpRPcIuMQmAWiUUtCaMoEGENo0cam5c06/44sjo
 tZKTV4vxi+eN8Y8+XNGb3eDr08NWRJUoYJjBUqwthRKAIKNW8Bc4ARKp/Cd3Jyg13VGL
 4dQpNSas3XJcuy3GJHJikhFEEMkHCz0J8FKweITO7NGzO6T9UN1AjG0gRy9igoHPZbuv
 Y4HCkX+N1k5YTrym9vy+3lOqyfzORcEIPxXXZCP+8P6TgPA8Hl2hoZtiT/AvX56W+V3Z
 1ZvM/pfj2NHVBkMfMUDoWgQ3lpWNP7tZC7GB2juAcp2TQpifu0F+54rXKF9XoBQbO757
 g73A==
X-Gm-Message-State: APjAAAWIhNUh9meXGQ0NocUPFEiEvX1TSWNjoUKGpxVLFTf5BEOJyyFs
 RANcrRJ4RHOV/bJcOVZdGSv+qLonYs7iSg==
X-Google-Smtp-Source: APXvYqxolcYUacdkXJpKZX6xSSBKx+1V9eLJfXP1J/QWskDaR8x8QdPN6xSWkUX19ZxvzuZxB0nPeg==
X-Received: by 2002:a05:6830:155a:: with SMTP id
 l26mr4316290otp.119.1574294981368; 
 Wed, 20 Nov 2019 16:09:41 -0800 (PST)
Received: from moi-limbo-9350.arm.com
 (host86-181-127-240.range86-181.btcentralplus.com. [86.181.127.240])
 by smtp.gmail.com with ESMTPSA id z17sm351439otk.40.2019.11.20.16.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 16:09:40 -0800 (PST)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/4] target/arm: Add support for DC CVAP & DC CVADP ins
Date: Thu, 21 Nov 2019 00:08:43 +0000
Message-Id: <20191121000843.24844-5-beata.michalska@linaro.org>
In-Reply-To: <20191121000843.24844-1-beata.michalska@linaro.org>
References: <20191121000843.24844-1-beata.michalska@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: peter.maydell@linaro.org, quintela@redhat.com, richard.henderson@linaro.org,
 dgilbert@redhat.com, shameerali.kolothum.thodi@huawei.com,
 eric.auger@redhat.com, qemu-arm@nongnu.org, pbonzini@redhat.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ARMv8.2 introduced support for Data Cache Clean instructions
to PoP (point-of-persistence) - DC CVAP and PoDP (point-of-deep-persistence)
- DV CVADP. Both specify conceptual points in a memory system where all writes
that are to reach them are considered persistent.
The support provided considers both to be actually the same so there is no
distinction between the two. If none is available (there is no backing store
for given memory) both will result in Data Cache Clean up to the point of
coherency. Otherwise sync for the specified range shall be performed.

Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c |  2 ++
 target/arm/cpu.h     | 10 ++++++++++
 target/arm/cpu64.c   |  1 +
 target/arm/helper.c  | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f6693e5..07b16cc 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -656,6 +656,7 @@ static uint32_t get_elf_hwcap(void)
     GET_FEATURE_ID(aa64_jscvt, ARM_HWCAP_A64_JSCVT);
     GET_FEATURE_ID(aa64_sb, ARM_HWCAP_A64_SB);
     GET_FEATURE_ID(aa64_condm_4, ARM_HWCAP_A64_FLAGM);
+    GET_FEATURE_ID(aa64_dcpop, ARM_HWCAP_A64_DCPOP);
 
     return hwcaps;
 }
@@ -665,6 +666,7 @@ static uint32_t get_elf_hwcap2(void)
     ARMCPU *cpu = ARM_CPU(thread_cpu);
     uint32_t hwcaps = 0;
 
+    GET_FEATURE_ID(aa64_dcpodp, ARM_HWCAP2_A64_DCPODP);
     GET_FEATURE_ID(aa64_condm_5, ARM_HWCAP2_A64_FLAGM2);
     GET_FEATURE_ID(aa64_frint, ARM_HWCAP2_A64_FRINT);
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 83a809d..c3c0bf5 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3616,6 +3616,16 @@ static inline bool isar_feature_aa64_frint(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, FRINTTS) != 0;
 }
 
+static inline bool isar_feature_aa64_dcpop(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, DPB) != 0;
+}
+
+static inline bool isar_feature_aa64_dcpodp(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, DPB) >= 2;
+}
+
 static inline bool isar_feature_aa64_fp16(const ARMISARegisters *id)
 {
     /* We always set the AdvSIMD and FP fields identically wrt FP16.  */
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index a39d6fc..61fd0ad 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -646,6 +646,7 @@ static void aarch64_max_initfn(Object *obj)
         cpu->isar.id_aa64isar0 = t;
 
         t = cpu->isar.id_aa64isar1;
+        t = FIELD_DP64(t, ID_AA64ISAR1, DPB, 2);
         t = FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 1);
         t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 1);
         t = FIELD_DP64(t, ID_AA64ISAR1, APA, 1); /* PAuth, architected only */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index a089fb5..f90f3ec 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5929,6 +5929,52 @@ static const ARMCPRegInfo rndr_reginfo[] = {
       .access = PL0_R, .readfn = rndr_readfn },
     REGINFO_SENTINEL
 };
+
+#ifndef CONFIG_USER_ONLY
+static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
+                          uint64_t value)
+{
+    ARMCPU *cpu = env_archcpu(env);
+    /* CTR_EL0 System register -> DminLine, bits [19:16] */
+    uint64_t dline_size = 4 << ((cpu->ctr >> 16) & 0xF);
+    uint64_t vaddr_in = (uint64_t) value;
+    uint64_t vaddr = vaddr_in & ~(dline_size - 1);
+    void *haddr;
+    int mem_idx = cpu_mmu_index(env, false);
+
+    /* This won't be crossing page boundaries */
+    haddr = probe_read(env, vaddr, dline_size, mem_idx, GETPC());
+    if (haddr) {
+
+        ram_addr_t offset;
+        MemoryRegion *mr;
+
+        /* RCU lock is already being held */
+        mr = memory_region_from_host(haddr, &offset);
+
+        if (mr) {
+            memory_region_do_writeback(mr, offset, dline_size);
+        }
+    }
+}
+
+static const ARMCPRegInfo dcpop_reg[] = {
+    { .name = "DC_CVAP", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 12, .opc2 = 1,
+      .access = PL0_W, .type = ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END,
+      .accessfn = aa64_cacheop_access, .writefn = dccvap_writefn },
+    REGINFO_SENTINEL
+};
+
+static const ARMCPRegInfo dcpodp_reg[] = {
+    { .name = "DC_CVADP", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 13, .opc2 = 1,
+      .access = PL0_W, .type = ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END,
+      .accessfn = aa64_cacheop_access, .writefn = dccvap_writefn },
+    REGINFO_SENTINEL
+};
+#endif /*CONFIG_USER_ONLY*/
+
 #endif
 
 static CPAccessResult access_predinv(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -6889,6 +6935,16 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_rndr, cpu)) {
         define_arm_cp_regs(cpu, rndr_reginfo);
     }
+#ifndef CONFIG_USER_ONLY
+    /* Data Cache clean instructions up to PoP */
+    if (cpu_isar_feature(aa64_dcpop, cpu)) {
+        define_one_arm_cp_reg(cpu, dcpop_reg);
+
+        if (cpu_isar_feature(aa64_dcpodp, cpu)) {
+            define_one_arm_cp_reg(cpu, dcpodp_reg);
+        }
+    }
+#endif /*CONFIG_USER_ONLY*/
 #endif
 
     /*
-- 
2.7.4


