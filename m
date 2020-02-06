Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD514C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:16:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7240E206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wxIXF1hc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7240E206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izf9Q-0001CS-Lg
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:16:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50147)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoY-0003Po-Dl
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoV-0007xm-UY
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:18 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:56295)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izeoV-0007sH-K7
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:15 -0500
Received: by mail-wm1-x343.google.com with SMTP id q9so5784177wmj.5
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 02:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E/R5JMzr4q6N3RFvJibLfVpPCbeNsqQHAHOH3+mr4kQ=;
 b=wxIXF1hc2Mp0Ch9jB7I4fJfNCxj3p9S8fjciO1nz8hKuzkX1c2FnuezviozMsC9X/G
 yPzazELvAMBrg7SYIVprW1JDeUxUiGLCNYRl6/mUV6HoGLvTCUKOlbIjIBzFcfb6t+pp
 07Uco/A8MXAHUakkgLPIcnl11X6k5XrhgQZQX/rO0c2ihM9+5QzWtnugAJ+M+frKSQf4
 4UTmKOMIRqcdcn5z//l7SIi6BItcSNdvqLaVDmpypEske0QXYuUDboRt2LcN0iCsYeFT
 t+4WX/lRuRC6+oSWwCI4i4krleuWl2M2rJ/tD83YzNy4bKC+4hCoB3TD0UyLrrYBbucF
 NUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E/R5JMzr4q6N3RFvJibLfVpPCbeNsqQHAHOH3+mr4kQ=;
 b=UJW/TZVI9y+1Z14wqj9j9x43cOAI31may17eNsMcvB7AFjS3JtZWCvuOew3Q8GmjJT
 GkJvsznyvqZ5AvcoWNfsO4VyReEDuTGx/jjGqPA74IQ9hqTa/LIUVTxAKeC9ar/56Y3R
 AS0aZGpsf6oFL7CxrRc89ypUP+h9Zcf9iuOo77Vi95YhpjkzzgOXJoUoA8hEDTFYYbAH
 +Ofmdfhj3DXG4vlNTDSi4AwPjXjAnO/t/fAYs4sGWagVO7gkgJbPKCkwV2DQNwnQa75Z
 rR6tobxYtYiqEsvEt+ddCWU6acz1AidDkR1HSs9nb3S0IUwLXPZbyFCFLHps+mhK7rL2
 WQ1A==
X-Gm-Message-State: APjAAAWyrNRg10XdCUZAxQYazU2TPQ/98q8rb9mG4MDhxgdLUEHq5lqF
 /3+AteRdDYbWEcnjO0u5eAawRmoGNlxwVA==
X-Google-Smtp-Source: APXvYqwgeM2b8FF8ch57Rj9D5TnnpkS58cH6s0H7l21QD3hxhpIgsgeLnFrglHh54NjrPd7+zFeeqg==
X-Received: by 2002:a05:600c:2207:: with SMTP id
 z7mr3955331wml.138.1580986514066; 
 Thu, 06 Feb 2020 02:55:14 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id m21sm3364995wmi.27.2020.02.06.02.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 02:55:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 29/41] target/arm: Add VHE timer register redirection and
 aliasing
Date: Thu,  6 Feb 2020 10:54:36 +0000
Message-Id: <20200206105448.4726-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206105448.4726-1-richard.henderson@linaro.org>
References: <20200206105448.4726-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Apart from the wholesale redirection that HCR_EL2.E2H performs
for EL2, there's a separate redirection specific to the timers
that happens for EL0 when running in the EL2&0 regime.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 181 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 169 insertions(+), 12 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8f7620f243..cfa6ce59dc 100644
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


