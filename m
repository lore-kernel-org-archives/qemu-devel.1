Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3133EC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFC2520659
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="amuUyuNw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC2520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsvRn-0007DJ-FH
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 16:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60867)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMl-0004WE-LW
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMk-0003SQ-DR
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:31 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36177)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsvMk-0003Rf-6C
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:30 -0400
Received: by mail-pf1-x442.google.com with SMTP id r7so32515298pfl.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 13:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CFTl19ZF5edhUenxmEwmpn5Y/VYa/1WL6bwC0O5YAUU=;
 b=amuUyuNwDci6gXi5XG1g/VwjnH2iPNi7yLWFwNScGq65RDwAoi1nJAx+bRS0q49EN5
 oK8W2K/TN2nqy7CVzonuNVUM+JIITKfOG98/TCzvh0qNE/5HUHTEcKWDHY+FQxVCvYf3
 B12VxhY/wLtFJj7v1fkdvPULody89gFCTh2UOaJ0cpDRbdLVrMb01o6/FeA2a+OgjPPA
 o+QTwKVmcBEfzSi6tcyetU2ubXGsd7xC7M1Km/POBvW4rvsa9hJYImXfTFTPIJWeSl4M
 RLDvQ3r5WBeYo1ZY8wZJbqKQ8Gy2XL8dk/5bYFMAXb9kW6zqdiUfSKPIBz5QYYKJ1cBY
 WHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CFTl19ZF5edhUenxmEwmpn5Y/VYa/1WL6bwC0O5YAUU=;
 b=IH9dm9xvqnY7eVUBNfIOdkVhJI4nbhlI2sg+LCvm9BR+nmyS4d7gVDWfFDzI0IlD/a
 tuLbdBNbuhqHZ9A3yjitJyjgTl8Y+Gkee3jsx6rqQBGRPz7sSjeUzELPKyz57GXSxolj
 LKapKrMS7oWj/YqJt42RkM2JGpjuq2Y0uypmJjzYZF5M+6RkQnV2Od8ewqkeQbbrxi5a
 FojBTndSjxThByguzHhUKv5PO0ECd6tOywoUtnnWEZGf73Zkzuy8kAAyBjHYIFze9MTa
 U2AQjTlfBqQ+NwLCK/gZ6hSrcunaf7RyfQK+d1t3xKTCFsSvCQXWz/Nr1MbXDC6i4cKy
 MJVw==
X-Gm-Message-State: APjAAAWEQqT/gln7hd91yS3U3vmQKSUQ2kYqrJIBo8PtC+8+/atM/YdJ
 Lxh8lpinfcLlpRjAkws2MYFe0ow5QBA=
X-Google-Smtp-Source: APXvYqyGLOOxqQiryuyFxgUVwuW7mgaPqKiJOD2c2zGANGfK5om39sexJYEq4WObtiteKWKW8qlNng==
X-Received: by 2002:a17:90a:2ec1:: with SMTP id
 h1mr4754846pjs.101.1564605508954; 
 Wed, 31 Jul 2019 13:38:28 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g4sm84054164pfo.93.2019.07.31.13.38.27
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 13:38:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:37:52 -0700
Message-Id: <20190731203813.30765-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731203813.30765-1-richard.henderson@linaro.org>
References: <20190731203813.30765-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v2 11/32] target/arm: Add the hypervisor
 virtual counter
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-qom.h |  1 +
 target/arm/cpu.h     | 11 +++++----
 target/arm/cpu.c     |  2 ++
 target/arm/helper.c  | 57 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index 2049fa9612..43fc8296db 100644
--- a/target/arm/cpu-qom.h
+++ b/target/arm/cpu-qom.h
@@ -76,6 +76,7 @@ void arm_gt_ptimer_cb(void *opaque);
 void arm_gt_vtimer_cb(void *opaque);
 void arm_gt_htimer_cb(void *opaque);
 void arm_gt_stimer_cb(void *opaque);
+void arm_gt_hvtimer_cb(void *opaque);
 
 #define ARM_AFF0_SHIFT 0
 #define ARM_AFF0_MASK  (0xFFULL << ARM_AFF0_SHIFT)
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e37008a4f7..bba4e1f984 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -144,11 +144,12 @@ typedef struct ARMGenericTimer {
     uint64_t ctl; /* Timer Control register */
 } ARMGenericTimer;
 
-#define GTIMER_PHYS 0
-#define GTIMER_VIRT 1
-#define GTIMER_HYP  2
-#define GTIMER_SEC  3
-#define NUM_GTIMERS 4
+#define GTIMER_PHYS     0
+#define GTIMER_VIRT     1
+#define GTIMER_HYP      2
+#define GTIMER_SEC      3
+#define GTIMER_HYPVIRT  4
+#define NUM_GTIMERS     5
 
 typedef struct {
     uint64_t raw_tcr;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 9eb40ff755..e10b510c0b 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1218,6 +1218,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
                                           arm_gt_htimer_cb, cpu);
     cpu->gt_timer[GTIMER_SEC] = timer_new(QEMU_CLOCK_VIRTUAL, GTIMER_SCALE,
                                           arm_gt_stimer_cb, cpu);
+    cpu->gt_timer[GTIMER_HYPVIRT] = timer_new(QEMU_CLOCK_VIRTUAL, GTIMER_SCALE,
+                                              arm_gt_hvtimer_cb, cpu);
 #endif
 
     cpu_exec_realizefn(cs, &local_err);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index e2fcb03da5..e0f5627218 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2527,6 +2527,7 @@ static uint64_t gt_tval_read(CPUARMState *env, const ARMCPRegInfo *ri,
 
     switch (timeridx) {
     case GTIMER_VIRT:
+    case GTIMER_HYPVIRT:
         offset = gt_virt_cnt_offset(env);
         break;
     }
@@ -2543,6 +2544,7 @@ static void gt_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     switch (timeridx) {
     case GTIMER_VIRT:
+    case GTIMER_HYPVIRT:
         offset = gt_virt_cnt_offset(env);
         break;
     }
@@ -2698,6 +2700,34 @@ static void gt_sec_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
     gt_ctl_write(env, ri, GTIMER_SEC, value);
 }
 
+static void gt_hv_timer_reset(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    gt_timer_reset(env, ri, GTIMER_HYPVIRT);
+}
+
+static void gt_hv_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
+{
+    gt_cval_write(env, ri, GTIMER_HYPVIRT, value);
+}
+
+static uint64_t gt_hv_tval_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    return gt_tval_read(env, ri, GTIMER_HYPVIRT);
+}
+
+static void gt_hv_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
+{
+    gt_tval_write(env, ri, GTIMER_HYPVIRT, value);
+}
+
+static void gt_hv_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                            uint64_t value)
+{
+    gt_ctl_write(env, ri, GTIMER_HYPVIRT, value);
+}
+
 void arm_gt_ptimer_cb(void *opaque)
 {
     ARMCPU *cpu = opaque;
@@ -2726,6 +2756,13 @@ void arm_gt_stimer_cb(void *opaque)
     gt_recalc_timer(cpu, GTIMER_SEC);
 }
 
+void arm_gt_hvtimer_cb(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+
+    gt_recalc_timer(cpu, GTIMER_HYPVIRT);
+}
+
 static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     /* Note that CNTFRQ is purely reads-as-written for the benefit
      * of software; writing it doesn't actually change the timer frequency.
@@ -6849,6 +6886,26 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 1,
               .access = PL2_RW, .writefn = vmsa_tcr_ttbr_el2_write,
               .fieldoffset = offsetof(CPUARMState, cp15.ttbr1_el[2]) },
+#ifndef CONFIG_USER_ONLY
+            { .name = "CNTHV_CVAL_EL2", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 3, .opc2 = 2,
+              .fieldoffset =
+                offsetof(CPUARMState, cp15.c14_timer[GTIMER_HYPVIRT].cval),
+              .type = ARM_CP_IO, .access = PL2_RW,
+              .writefn = gt_hv_cval_write, .raw_writefn = raw_write },
+            { .name = "CNTHV_TVAL_EL2", .state = ARM_CP_STATE_BOTH,
+              .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 3, .opc2 = 0,
+              .type = ARM_CP_NO_RAW | ARM_CP_IO, .access = PL2_RW,
+              .resetfn = gt_hv_timer_reset,
+              .readfn = gt_hv_tval_read, .writefn = gt_hv_tval_write },
+            { .name = "CNTHV_CTL_EL2", .state = ARM_CP_STATE_BOTH,
+              .type = ARM_CP_IO,
+              .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 3, .opc2 = 1,
+              .access = PL2_RW,
+              .fieldoffset =
+                offsetof(CPUARMState, cp15.c14_timer[GTIMER_HYPVIRT].ctl),
+              .writefn = gt_hv_ctl_write, .raw_writefn = raw_write },
+#endif
             REGINFO_SENTINEL
         };
         define_arm_cp_regs(cpu, vhe_reginfo);
-- 
2.17.1


