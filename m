Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16091C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C459820720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WuEg2ooY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C459820720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04q7-0000am-UF
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:42:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04i5-0000wB-Px
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04i3-0003HO-LB
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:21 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53645)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04i3-0003FG-Ct
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:19 -0500
Received: by mail-wm1-x341.google.com with SMTP id s10so2805537wmh.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=u9RJZS78twZl1mO1NG+LgdpwTwcS641C9DNG32q4kwo=;
 b=WuEg2ooYDbe7HNcvP1JUSCAtX76fA6xDFJ5xFi7nHLbPP3IWEVK8hiCguXomZldtH6
 0FkTmCAqLoLdlAbtjZjpxyhJxD8mCHQipQi/+PvOXocyqDpf7VnW2BuEQB8/Gfa01LtB
 p24VpX0PAhDQLE2PP08l5HRn1e59umQ/FKk7w4GHTVZ09E1wwqB9GnuLAZFAdjc0Q1Ch
 EuyTZ3dJLtlNrGbedoZYTH7RjVw0yb2L8nXtqKc4z/SnqLKSyMGQYFV8nrdKA2rpcemi
 Y0XvnlbU+uIBICkNMG/nan7mZ388+9lVC2j094gpymiCiaWtXtldH+goykFWsxM5/pVA
 tbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u9RJZS78twZl1mO1NG+LgdpwTwcS641C9DNG32q4kwo=;
 b=kJdEeNUMLAmtoo1NMvRef4aqX3EdZ2Fx8YuGSiXbpztoKr/0cieBH8tuqOsfG8jDde
 ys4+tY8l/EZpew8wIaVJi0/L1CZXl8ona0l/5oEMeBHrkOtIMGYyUi9j2ekUtH8fZoF4
 +EU5gRLMSE5KBebVlKXX4cAdLsumXOZp7frZPsKBI9TGhSg8YutfveHpojL6H4FwvC1k
 4q1yGKV8VhVR9z7gAuZ6GcVfA8Yg4mWFe63O8W7b64zldTeOMkflDokfXddUJAZRWxRp
 wM3BekuPn7ETX9yWMGoLAp/awhdd1XCFg3TdYAtL+Y+oLLoAwrQpt1dj6dtFP2plyhXg
 zCQA==
X-Gm-Message-State: APjAAAWL8KtXHPccw0EeBPV4vCGgGFXTq31oW1pg6FjR67Z/axGFWgXS
 7hAP0G5CxUGGqN04YM8wk30PH27DiHg=
X-Google-Smtp-Source: APXvYqxK7huXRtpaMCc6L2mpnMv98VWSn5TOtesgfteohR23WX47m9OavxVRQNMU96pIDNTjEZCVbA==
X-Received: by 2002:a1c:9c87:: with SMTP id f129mr4912600wme.26.1581086057755; 
 Fri, 07 Feb 2020 06:34:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.34.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:34:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/48] target/arm: Add VHE timer register redirection and
 aliasing
Date: Fri,  7 Feb 2020 14:33:25 +0000
Message-Id: <20200207143343.30322-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

From: Richard Henderson <richard.henderson@linaro.org>

Apart from the wholesale redirection that HCR_EL2.E2H performs
for EL2, there's a separate redirection specific to the timers
that happens for EL0 when running in the EL2&0 regime.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200206105448.4726-30-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 181 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 169 insertions(+), 12 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8f7620f2434..cfa6ce59dc8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2695,6 +2695,70 @@ static void gt_phys_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
     gt_ctl_write(env, ri, GTIMER_PHYS, value);
 }
 
+static int gt_phys_redir_timeridx(CPUARMState *env)
+{
+    switch (arm_mmu_idx(env)) {
+    case ARMMMUIdx_E20_0:
+    case ARMMMUIdx_E20_2:
+        return GTIMER_HYP;
+    default:
+        return GTIMER_PHYS;
+    }
+}
+
+static int gt_virt_redir_timeridx(CPUARMState *env)
+{
+    switch (arm_mmu_idx(env)) {
+    case ARMMMUIdx_E20_0:
+    case ARMMMUIdx_E20_2:
+        return GTIMER_HYPVIRT;
+    default:
+        return GTIMER_VIRT;
+    }
+}
+
+static uint64_t gt_phys_redir_cval_read(CPUARMState *env,
+                                        const ARMCPRegInfo *ri)
+{
+    int timeridx = gt_phys_redir_timeridx(env);
+    return env->cp15.c14_timer[timeridx].cval;
+}
+
+static void gt_phys_redir_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                     uint64_t value)
+{
+    int timeridx = gt_phys_redir_timeridx(env);
+    gt_cval_write(env, ri, timeridx, value);
+}
+
+static uint64_t gt_phys_redir_tval_read(CPUARMState *env,
+                                        const ARMCPRegInfo *ri)
+{
+    int timeridx = gt_phys_redir_timeridx(env);
+    return gt_tval_read(env, ri, timeridx);
+}
+
+static void gt_phys_redir_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                     uint64_t value)
+{
+    int timeridx = gt_phys_redir_timeridx(env);
+    gt_tval_write(env, ri, timeridx, value);
+}
+
+static uint64_t gt_phys_redir_ctl_read(CPUARMState *env,
+                                       const ARMCPRegInfo *ri)
+{
+    int timeridx = gt_phys_redir_timeridx(env);
+    return env->cp15.c14_timer[timeridx].ctl;
+}
+
+static void gt_phys_redir_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                    uint64_t value)
+{
+    int timeridx = gt_phys_redir_timeridx(env);
+    gt_ctl_write(env, ri, timeridx, value);
+}
+
 static void gt_virt_timer_reset(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     gt_timer_reset(env, ri, GTIMER_VIRT);
@@ -2733,6 +2797,48 @@ static void gt_cntvoff_write(CPUARMState *env, const ARMCPRegInfo *ri,
     gt_recalc_timer(cpu, GTIMER_VIRT);
 }
 
+static uint64_t gt_virt_redir_cval_read(CPUARMState *env,
+                                        const ARMCPRegInfo *ri)
+{
+    int timeridx = gt_virt_redir_timeridx(env);
+    return env->cp15.c14_timer[timeridx].cval;
+}
+
+static void gt_virt_redir_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                     uint64_t value)
+{
+    int timeridx = gt_virt_redir_timeridx(env);
+    gt_cval_write(env, ri, timeridx, value);
+}
+
+static uint64_t gt_virt_redir_tval_read(CPUARMState *env,
+                                        const ARMCPRegInfo *ri)
+{
+    int timeridx = gt_virt_redir_timeridx(env);
+    return gt_tval_read(env, ri, timeridx);
+}
+
+static void gt_virt_redir_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                     uint64_t value)
+{
+    int timeridx = gt_virt_redir_timeridx(env);
+    gt_tval_write(env, ri, timeridx, value);
+}
+
+static uint64_t gt_virt_redir_ctl_read(CPUARMState *env,
+                                       const ARMCPRegInfo *ri)
+{
+    int timeridx = gt_virt_redir_timeridx(env);
+    return env->cp15.c14_timer[timeridx].ctl;
+}
+
+static void gt_virt_redir_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                    uint64_t value)
+{
+    int timeridx = gt_virt_redir_timeridx(env);
+    gt_ctl_write(env, ri, timeridx, value);
+}
+
 static void gt_hyp_timer_reset(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     gt_timer_reset(env, ri, GTIMER_HYP);
@@ -2889,7 +2995,8 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
       .accessfn = gt_ptimer_access,
       .fieldoffset = offsetoflow32(CPUARMState,
                                    cp15.c14_timer[GTIMER_PHYS].ctl),
-      .writefn = gt_phys_ctl_write, .raw_writefn = raw_write,
+      .readfn = gt_phys_redir_ctl_read, .raw_readfn = raw_read,
+      .writefn = gt_phys_redir_ctl_write, .raw_writefn = raw_write,
     },
     { .name = "CNTP_CTL_S",
       .cp = 15, .crn = 14, .crm = 2, .opc1 = 0, .opc2 = 1,
@@ -2906,14 +3013,16 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
       .accessfn = gt_ptimer_access,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_PHYS].ctl),
       .resetvalue = 0,
-      .writefn = gt_phys_ctl_write, .raw_writefn = raw_write,
+      .readfn = gt_phys_redir_ctl_read, .raw_readfn = raw_read,
+      .writefn = gt_phys_redir_ctl_write, .raw_writefn = raw_write,
     },
     { .name = "CNTV_CTL", .cp = 15, .crn = 14, .crm = 3, .opc1 = 0, .opc2 = 1,
       .type = ARM_CP_IO | ARM_CP_ALIAS, .access = PL0_RW,
       .accessfn = gt_vtimer_access,
       .fieldoffset = offsetoflow32(CPUARMState,
                                    cp15.c14_timer[GTIMER_VIRT].ctl),
-      .writefn = gt_virt_ctl_write, .raw_writefn = raw_write,
+      .readfn = gt_virt_redir_ctl_read, .raw_readfn = raw_read,
+      .writefn = gt_virt_redir_ctl_write, .raw_writefn = raw_write,
     },
     { .name = "CNTV_CTL_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 3, .opc2 = 1,
@@ -2921,14 +3030,15 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
       .accessfn = gt_vtimer_access,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_VIRT].ctl),
       .resetvalue = 0,
-      .writefn = gt_virt_ctl_write, .raw_writefn = raw_write,
+      .readfn = gt_virt_redir_ctl_read, .raw_readfn = raw_read,
+      .writefn = gt_virt_redir_ctl_write, .raw_writefn = raw_write,
     },
     /* TimerValue views: a 32 bit downcounting view of the underlying state */
     { .name = "CNTP_TVAL", .cp = 15, .crn = 14, .crm = 2, .opc1 = 0, .opc2 = 0,
       .secure = ARM_CP_SECSTATE_NS,
       .type = ARM_CP_NO_RAW | ARM_CP_IO, .access = PL0_RW,
       .accessfn = gt_ptimer_access,
-      .readfn = gt_phys_tval_read, .writefn = gt_phys_tval_write,
+      .readfn = gt_phys_redir_tval_read, .writefn = gt_phys_redir_tval_write,
     },
     { .name = "CNTP_TVAL_S",
       .cp = 15, .crn = 14, .crm = 2, .opc1 = 0, .opc2 = 0,
@@ -2941,18 +3051,18 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 2, .opc2 = 0,
       .type = ARM_CP_NO_RAW | ARM_CP_IO, .access = PL0_RW,
       .accessfn = gt_ptimer_access, .resetfn = gt_phys_timer_reset,
-      .readfn = gt_phys_tval_read, .writefn = gt_phys_tval_write,
+      .readfn = gt_phys_redir_tval_read, .writefn = gt_phys_redir_tval_write,
     },
     { .name = "CNTV_TVAL", .cp = 15, .crn = 14, .crm = 3, .opc1 = 0, .opc2 = 0,
       .type = ARM_CP_NO_RAW | ARM_CP_IO, .access = PL0_RW,
       .accessfn = gt_vtimer_access,
-      .readfn = gt_virt_tval_read, .writefn = gt_virt_tval_write,
+      .readfn = gt_virt_redir_tval_read, .writefn = gt_virt_redir_tval_write,
     },
     { .name = "CNTV_TVAL_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 3, .opc2 = 0,
       .type = ARM_CP_NO_RAW | ARM_CP_IO, .access = PL0_RW,
       .accessfn = gt_vtimer_access, .resetfn = gt_virt_timer_reset,
-      .readfn = gt_virt_tval_read, .writefn = gt_virt_tval_write,
+      .readfn = gt_virt_redir_tval_read, .writefn = gt_virt_redir_tval_write,
     },
     /* The counter itself */
     { .name = "CNTPCT", .cp = 15, .crm = 14, .opc1 = 0,
@@ -2982,7 +3092,8 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
       .type = ARM_CP_64BIT | ARM_CP_IO | ARM_CP_ALIAS,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_PHYS].cval),
       .accessfn = gt_ptimer_access,
-      .writefn = gt_phys_cval_write, .raw_writefn = raw_write,
+      .readfn = gt_phys_redir_cval_read, .raw_readfn = raw_read,
+      .writefn = gt_phys_redir_cval_write, .raw_writefn = raw_write,
     },
     { .name = "CNTP_CVAL_S", .cp = 15, .crm = 14, .opc1 = 2,
       .secure = ARM_CP_SECSTATE_S,
@@ -2998,14 +3109,16 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
       .type = ARM_CP_IO,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_PHYS].cval),
       .resetvalue = 0, .accessfn = gt_ptimer_access,
-      .writefn = gt_phys_cval_write, .raw_writefn = raw_write,
+      .readfn = gt_phys_redir_cval_read, .raw_readfn = raw_read,
+      .writefn = gt_phys_redir_cval_write, .raw_writefn = raw_write,
     },
     { .name = "CNTV_CVAL", .cp = 15, .crm = 14, .opc1 = 3,
       .access = PL0_RW,
       .type = ARM_CP_64BIT | ARM_CP_IO | ARM_CP_ALIAS,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_VIRT].cval),
       .accessfn = gt_vtimer_access,
-      .writefn = gt_virt_cval_write, .raw_writefn = raw_write,
+      .readfn = gt_virt_redir_cval_read, .raw_readfn = raw_read,
+      .writefn = gt_virt_redir_cval_write, .raw_writefn = raw_write,
     },
     { .name = "CNTV_CVAL_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 3, .opc2 = 2,
@@ -3013,7 +3126,8 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
       .type = ARM_CP_IO,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_VIRT].cval),
       .resetvalue = 0, .accessfn = gt_vtimer_access,
-      .writefn = gt_virt_cval_write, .raw_writefn = raw_write,
+      .readfn = gt_virt_redir_cval_read, .raw_readfn = raw_read,
+      .writefn = gt_virt_redir_cval_write, .raw_writefn = raw_write,
     },
     /* Secure timer -- this is actually restricted to only EL3
      * and configurably Secure-EL1 via the accessfn.
@@ -3044,6 +3158,15 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     REGINFO_SENTINEL
 };
 
+static CPAccessResult e2h_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                 bool isread)
+{
+    if (!(arm_hcr_el2_eff(env) & HCR_E2H)) {
+        return CP_ACCESS_TRAP;
+    }
+    return CP_ACCESS_OK;
+}
+
 #else
 
 /* In user-mode most of the generic timer registers are inaccessible
@@ -6431,6 +6554,40 @@ static const ARMCPRegInfo vhe_reginfo[] = {
       .access = PL2_RW,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_HYPVIRT].ctl),
       .writefn = gt_hv_ctl_write, .raw_writefn = raw_write },
+    { .name = "CNTP_CTL_EL02", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 5, .crn = 14, .crm = 2, .opc2 = 1,
+      .type = ARM_CP_IO | ARM_CP_ALIAS,
+      .access = PL2_RW, .accessfn = e2h_access,
+      .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_PHYS].ctl),
+      .writefn = gt_phys_ctl_write, .raw_writefn = raw_write },
+    { .name = "CNTV_CTL_EL02", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 5, .crn = 14, .crm = 3, .opc2 = 1,
+      .type = ARM_CP_IO | ARM_CP_ALIAS,
+      .access = PL2_RW, .accessfn = e2h_access,
+      .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_VIRT].ctl),
+      .writefn = gt_virt_ctl_write, .raw_writefn = raw_write },
+    { .name = "CNTP_TVAL_EL02", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 5, .crn = 14, .crm = 2, .opc2 = 0,
+      .type = ARM_CP_NO_RAW | ARM_CP_IO | ARM_CP_ALIAS,
+      .access = PL2_RW, .accessfn = e2h_access,
+      .readfn = gt_phys_tval_read, .writefn = gt_phys_tval_write },
+    { .name = "CNTV_TVAL_EL02", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 5, .crn = 14, .crm = 3, .opc2 = 0,
+      .type = ARM_CP_NO_RAW | ARM_CP_IO | ARM_CP_ALIAS,
+      .access = PL2_RW, .accessfn = e2h_access,
+      .readfn = gt_virt_tval_read, .writefn = gt_virt_tval_write },
+    { .name = "CNTP_CVAL_EL02", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 5, .crn = 14, .crm = 2, .opc2 = 2,
+      .type = ARM_CP_IO | ARM_CP_ALIAS,
+      .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_PHYS].cval),
+      .access = PL2_RW, .accessfn = e2h_access,
+      .writefn = gt_phys_cval_write, .raw_writefn = raw_write },
+    { .name = "CNTV_CVAL_EL02", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 5, .crn = 14, .crm = 3, .opc2 = 2,
+      .type = ARM_CP_IO | ARM_CP_ALIAS,
+      .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_VIRT].cval),
+      .access = PL2_RW, .accessfn = e2h_access,
+      .writefn = gt_virt_cval_write, .raw_writefn = raw_write },
 #endif
     REGINFO_SENTINEL
 };
-- 
2.20.1


