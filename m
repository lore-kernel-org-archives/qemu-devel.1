Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B91C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11785214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cSdLRQd9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11785214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izf2T-0005gt-6U
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:09:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoU-0003HB-Oy
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoS-0007ai-F5
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:14 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41437)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izeoS-0007V0-49
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:12 -0500
Received: by mail-wr1-x442.google.com with SMTP id c9so6558856wrw.8
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 02:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Vp9D6vKlu4QBbznrbO+dIp2/5nLaszhJLHmUjsHyQQo=;
 b=cSdLRQd9k8TmOEBB1+sGpOsImEZgatsvavr1V+rq4Y+trKMSumFSm0/AqAqCDkJbJh
 DrqDA4pIJQUi/0stIzxd88z6WSZFgd65Av5FxUVPixT97DwfV8g3ihDMWKJ/85GHosEU
 V9SYZW1+Gy6mJhCgGroIWSgO35z2kZex64las5DAUFF8xjBxLxGc7WemC6k5GH+i8AGs
 feytoEjFU6eXt526+wII6qx+DI31MOSfE/W1CtC1yhqxRv8FQysXOZrqVSa6U1hFHE4f
 i0ZgU2FpKYpnM6Jm26fOJPyxSs/LlgV2n1L1XalkWU/Z0qDYk1YjgLwuIafE/pmvaVVA
 Tuyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Vp9D6vKlu4QBbznrbO+dIp2/5nLaszhJLHmUjsHyQQo=;
 b=D0k9Fh2YOaMHOLVC4H3b5lyL2PBTB9HB469f68NMopRPVumDP9jzdRGQujw6vkygL8
 cxVo4NWJKRlcXXE/dKj/sFTAYiaCoI8PGP8pTqdW80MIIHuVK70tLlv1UvsDB/qKojQg
 /DoeUOeCacQrg3qGdWPg3/Aj1YtS7I4FQtjpo8du9U2zAad2EiHMPRAfzyLc3mSoSQqy
 eKiiMix2M6cxp0FLNU7MLAXoSUJo/ac+b+uIU8M1IeQntY8DpPlP/CpYsIfA5cL9KkRw
 4SxjOZLPKkvVAwdISJ+ngBd3FK5GpDUk+hQ5rfRlb1oZx/niacL383njtIRmSw0POJqx
 Y+OA==
X-Gm-Message-State: APjAAAXXTD3gCXLKuYoaNPiBI7PdPKH2pDU1woG33XI9WTeYkjENmacS
 j19sjCoVIWW/dR7rFhXks3Lbm4YkZMVs4w==
X-Google-Smtp-Source: APXvYqzT4H5QKmlEHrvIzBiVShwJ4gfmi/YYqRa8/QrBtC/B+qn1cu31u64Q+ANRxYxRVGgR8zG7jQ==
X-Received: by 2002:adf:ee41:: with SMTP id w1mr3223829wro.368.1580986510852; 
 Thu, 06 Feb 2020 02:55:10 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id m21sm3364995wmi.27.2020.02.06.02.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 02:55:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 25/41] target/arm: Add the hypervisor virtual counter
Date: Thu,  6 Feb 2020 10:54:32 +0000
Message-Id: <20200206105448.4726-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206105448.4726-1-richard.henderson@linaro.org>
References: <20200206105448.4726-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-qom.h |  1 +
 target/arm/cpu.h     | 11 +++++----
 target/arm/cpu.c     |  3 ++-
 target/arm/helper.c  | 56 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index 7f5b244bde..3a9d31ea9d 100644
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
index 68e11f0eda..ded1e8e0a8 100644
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
index f86e71a260..1ecf2adb6a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1272,7 +1272,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
-
     {
         uint64_t scale;
 
@@ -1295,6 +1294,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
                                               arm_gt_htimer_cb, cpu);
         cpu->gt_timer[GTIMER_SEC] = timer_new(QEMU_CLOCK_VIRTUAL, scale,
                                               arm_gt_stimer_cb, cpu);
+        cpu->gt_timer[GTIMER_HYPVIRT] = timer_new(QEMU_CLOCK_VIRTUAL, scale,
+                                                  arm_gt_hvtimer_cb, cpu);
     }
 #endif
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 72b336e3b5..996865a3a2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2556,6 +2556,7 @@ static uint64_t gt_tval_read(CPUARMState *env, const ARMCPRegInfo *ri,
 
     switch (timeridx) {
     case GTIMER_VIRT:
+    case GTIMER_HYPVIRT:
         offset = gt_virt_cnt_offset(env);
         break;
     }
@@ -2572,6 +2573,7 @@ static void gt_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     switch (timeridx) {
     case GTIMER_VIRT:
+    case GTIMER_HYPVIRT:
         offset = gt_virt_cnt_offset(env);
         break;
     }
@@ -2727,6 +2729,34 @@ static void gt_sec_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
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
@@ -2755,6 +2785,13 @@ void arm_gt_stimer_cb(void *opaque)
     gt_recalc_timer(cpu, GTIMER_SEC);
 }
 
+void arm_gt_hvtimer_cb(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+
+    gt_recalc_timer(cpu, GTIMER_HYPVIRT);
+}
+
 static void arm_gt_cntfrq_reset(CPUARMState *env, const ARMCPRegInfo *opaque)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -6164,6 +6201,25 @@ static const ARMCPRegInfo vhe_reginfo[] = {
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 1,
       .access = PL2_RW, .writefn = vmsa_tcr_ttbr_el2_write,
       .fieldoffset = offsetof(CPUARMState, cp15.ttbr1_el[2]) },
+#ifndef CONFIG_USER_ONLY
+    { .name = "CNTHV_CVAL_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 3, .opc2 = 2,
+      .fieldoffset =
+        offsetof(CPUARMState, cp15.c14_timer[GTIMER_HYPVIRT].cval),
+      .type = ARM_CP_IO, .access = PL2_RW,
+      .writefn = gt_hv_cval_write, .raw_writefn = raw_write },
+    { .name = "CNTHV_TVAL_EL2", .state = ARM_CP_STATE_BOTH,
+      .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 3, .opc2 = 0,
+      .type = ARM_CP_NO_RAW | ARM_CP_IO, .access = PL2_RW,
+      .resetfn = gt_hv_timer_reset,
+      .readfn = gt_hv_tval_read, .writefn = gt_hv_tval_write },
+    { .name = "CNTHV_CTL_EL2", .state = ARM_CP_STATE_BOTH,
+      .type = ARM_CP_IO,
+      .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 3, .opc2 = 1,
+      .access = PL2_RW,
+      .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_HYPVIRT].ctl),
+      .writefn = gt_hv_ctl_write, .raw_writefn = raw_write },
+#endif
     REGINFO_SENTINEL
 };
 
-- 
2.20.1


