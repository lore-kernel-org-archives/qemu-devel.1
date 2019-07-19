Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428C7C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:04:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C87F2184E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ts3f1ohr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C87F2184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoa3h-0008B1-Ll
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 17:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55014)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa3L-00077w-Er
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa32-0005L3-P6
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:16 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42557)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hoa2z-00058z-Eh
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:10 -0400
Received: by mail-pl1-x642.google.com with SMTP id ay6so16193603plb.9
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 14:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bTH7aSoItBiIk3DIxJaTq67j1jqzFDHGY5zqBaAqigU=;
 b=ts3f1ohrVi+w84vD2lKk6gGOI0rKYllupe9O4OkDqd6abAHxL0JI6H2vu3i3xA36ny
 LLFyQ3h/0PbFQv1ATKJeLcSMBpIwDZ9Db4Q4RLyjjaG0ojYQu3vUUe9lwPq5cAkLAKJe
 ydp5EhO9hByFc7qCXuO6mx5abo3ABIXi7WceTGO3C0Z7CkEKld9hJFT+Ok6PkW8xfiCu
 nlmggDWTzCJfByJhQdWX02SqtrTSaMiP2fADUJQJpjjNGpoCPtv3BIYn24VjtnkwmzRw
 qVc6euvnDQy4S4AVbpdD80AndlBOblWfs07TEx5D1K6FqsUHTyb11nbF5+TiWUVEBXO2
 xs7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=bTH7aSoItBiIk3DIxJaTq67j1jqzFDHGY5zqBaAqigU=;
 b=AkjtRs7ng34vC43Y3ddeBx0i+owSWPDXdT70ufiXD+6tFIMIL4uMvcL5fEKVdglKHi
 +Ahru30+lRosML1ayLgC9GWsSppXSrlHePQ8ICbcZG5+cLuX2uOptiT5u8bFUZ6mMc4g
 G0hhNSDTLmBd41jcdPY2ZkbtEoRY11PV4oI9MssUviQMYeNa8bweHauEV8ljzlqDIPhj
 yuFumITeDCQL+Nu1vMnlBQVoBVkr47Y/NniTL+KXiRybssmEgaVSE9BmOLXjRTHNvyU0
 eTGtT9f9+zXxg1XbFDolyo/e+mUerS3osOSFzUNHBdYksVPEOE3SwOyWFTjBEVCvG7s7
 XatQ==
X-Gm-Message-State: APjAAAVBBC0xVlxkgfX+mjgwRL6sNY3yCQrpLl/ryG1Kp3x0H3Ntqsun
 gAsyOSfbW8JwTbmdCQeLKdlidMsgpUc=
X-Google-Smtp-Source: APXvYqySamxj9aFej566eULQ1gN20ntLVEf/Ok2hdYslK0NmDfeMwMzAI2nyUNJLH9NK6Ow33lbCDg==
X-Received: by 2002:a17:902:290b:: with SMTP id
 g11mr58074777plb.26.1563570221373; 
 Fri, 19 Jul 2019 14:03:41 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id i6sm32724751pgi.40.2019.07.19.14.03.40
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 14:03:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 14:03:13 -0700
Message-Id: <20190719210326.15466-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190719210326.15466-1-richard.henderson@linaro.org>
References: <20190719210326.15466-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH for-4.2 11/24] target/arm: Add the hypervisor
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
Cc: peter.maydell@linaro.org, beata.michalska@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
index 1959467fdc..90352decc5 100644
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
index 3124d682a2..329548e45d 100644
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
@@ -6852,6 +6889,26 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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


