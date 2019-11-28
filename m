Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A44C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 05:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A11B0208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 05:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="n6nIrfCo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DPjvE5sz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11B0208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaCiG-0003X2-QH
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 00:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1iaCbC-0006qh-37
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 00:44:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1iaCbA-0001xT-HI
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 00:44:17 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54713)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1iaCb7-0001qE-BX; Thu, 28 Nov 2019 00:44:13 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 1FA592275C;
 Thu, 28 Nov 2019 00:44:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Thu, 28 Nov 2019 00:44:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=QtPlHzwjC4iXC
 CxuQoeirIh5WeTqNoM7oHnbBwCwgY8=; b=n6nIrfCo944EVJQldW2x/3inI9TH/
 HicuPhJgQJK+NyoNXNlJ7ClYy58EvOPzaZQ7leiqoFeIbz+/q/09or6JnmEF8oBv
 i2cPSkIRKlStUdzZ30sMZoooDJBHKvbpfwDvV51pEltkZ26Mp7WZcThQnSd6c428
 8J8SrkLmUcP8FI8HNUaHWpDajhSzE0GMuxOVENqRqNBJkkoHduRfgjmnDeAyQoa3
 aq9Jx3/OVqGCo4CRY6uPorVlZuSe4OW4dHfOldjgu6YG7zc3U9nirOvZNSuFn6TJ
 kQWNwmyOFcP+R8qE59BnRSQdhBYczqq7vxawKLI8WAZckSCXAs/XLsj2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=QtPlHzwjC4iXCCxuQoeirIh5WeTqNoM7oHnbBwCwgY8=; b=DPjvE5sz
 befuCv1GS3fOqu1ur3qGGTV6mZFBfCy5EWsrHJSvcxGS5YLuIK+ynYLjIJz0eo4N
 oLjfv+ZlZcjUIMtA1dFaTcA8GQFDumadf6Nhl9kt8V1JsYPu8WP1Ck7mo5EGUuL3
 t6qWfZURb8IHxDEKbnbMwiuGp+2/1ueMJcKYi9LAKAhujpbenTXLL0OPqR0Ku7mG
 yTRH6a1sZs1SVP0rLA3t3TRMagQD59miRKAOVS6go+z8stX5CvXHDFxzz05zqf8l
 LYcCpI+j9d1QcmhYQr9fTt6y27BOyD1SsGLLYAyb2psvtl7KW9fep1JR5M+Go+A3
 QI3O1RHs1k/sIQ==
X-ME-Sender: <xms:rF7fXZifHmoCCnnKEaluXN0fhbplwCa_ojuzhFh3dKBwwRMjCsYu-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudeiiedgkeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
 jhdrihgurdgruheqnecukfhppedvtddvrdekuddrudekrdeftdenucfrrghrrghmpehmrg
 hilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghrufhiiigv
 pedu
X-ME-Proxy: <xmx:rV7fXSR5sUPFqGVvUFwQCbue8DpU1XvM0dZ-nXMOTICXfy0i5U0y5w>
 <xmx:rV7fXUHZQez54iJIEEmMg1YNcZAVDAL3WafuPwwsRYKwrbH7xRyDeg>
 <xmx:rV7fXSnwJHZmKNLbMl_RsFi7NU4K5sd9xDVIYpFsQ7g3R1eb0Wuifg>
 <xmx:rV7fXUhmVraKWNO7w7MJK3L79XE841Tr_0tq0f_W-T0674hxO1HlVQ>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
 by mail.messagingengine.com (Postfix) with ESMTPA id A8FA38005A;
 Thu, 28 Nov 2019 00:44:10 -0500 (EST)
From: Andrew Jeffery <andrew@aj.id.au>
To: qemu-arm@nongnu.org
Subject: [PATCH 3/4] target/arm: Prepare generic timer for per-platform CNTFRQ
Date: Thu, 28 Nov 2019 16:15:26 +1030
Message-Id: <20191128054527.25450-4-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191128054527.25450-1-andrew@aj.id.au>
References: <20191128054527.25450-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 66.111.4.26
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, clg@kaod.org,
 joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ASPEED AST2600 clocks the generic timer at the rate of HPLL. On
recent firmwares this is at 1125MHz, which is considerably quicker than
the assumed 62.5MHz of the current generic timer implementation. The
delta between the value as read from CNTFRQ and the true rate of the
underlying QEMUTimer leads to sticky behaviour in AST2600 guests.

Add a feature-gated property exposing CNTFRQ for ARM CPUs providing the
generic timer. This allows platforms to configure CNTFRQ (and the
associated QEMUTimer) to the appropriate frequency prior to starting the
guest.

As the platform can now determine the rate of CNTFRQ we're exposed to
limitations of QEMUTimer that didn't previously materialise: In the
course of emulation we need to arbitrarily and accurately convert
between guest ticks and time, but we're constrained by QEMUTimer's use
of an integer scaling factor. Its effect is QEMUTimer cannot exactly
capture the period of frequencies that do not cleanly divide
NANOSECONDS_PER_SECOND for scaling ticks to time. As such, provide an
equally inaccurate scaling factor for scaling time to ticks so at least
an self-consistent inverse relationship holds.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 target/arm/cpu.c    | 43 +++++++++++++++++++++++++++++++++----------
 target/arm/cpu.h    | 18 ++++++++++++++++++
 target/arm/helper.c |  9 ++++++++-
 3 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5698a74061bb..f186019a77fd 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -974,10 +974,12 @@ static void arm_cpu_initfn(Object *obj)
     if (tcg_enabled()) {
         cpu->psci_version = 2; /* TCG implements PSCI 0.2 */
     }
-
-    cpu->gt_cntfrq = NANOSECONDS_PER_SECOND / GTIMER_SCALE;
 }
 
+static Property arm_cpu_gt_cntfrq_property =
+            DEFINE_PROP_UINT64("cntfrq", ARMCPU, gt_cntfrq,
+                               NANOSECONDS_PER_SECOND / GTIMER_SCALE);
+
 static Property arm_cpu_reset_cbar_property =
             DEFINE_PROP_UINT64("reset-cbar", ARMCPU, reset_cbar, 0);
 
@@ -1174,6 +1176,11 @@ void arm_cpu_post_init(Object *obj)
 
     qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property,
                              &error_abort);
+
+    if (arm_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER)) {
+        qdev_property_add_static(DEVICE(cpu), &arm_cpu_gt_cntfrq_property,
+                                 &error_abort);
+    }
 }
 
 static void arm_cpu_finalizefn(Object *obj)
@@ -1253,14 +1260,30 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
-    cpu->gt_timer[GTIMER_PHYS] = timer_new(QEMU_CLOCK_VIRTUAL, GTIMER_SCALE,
-                                           arm_gt_ptimer_cb, cpu);
-    cpu->gt_timer[GTIMER_VIRT] = timer_new(QEMU_CLOCK_VIRTUAL, GTIMER_SCALE,
-                                           arm_gt_vtimer_cb, cpu);
-    cpu->gt_timer[GTIMER_HYP] = timer_new(QEMU_CLOCK_VIRTUAL, GTIMER_SCALE,
-                                          arm_gt_htimer_cb, cpu);
-    cpu->gt_timer[GTIMER_SEC] = timer_new(QEMU_CLOCK_VIRTUAL, GTIMER_SCALE,
-                                          arm_gt_stimer_cb, cpu);
+
+    {
+        uint64_t scale;
+
+        if (arm_feature(env, ARM_FEATURE_GENERIC_TIMER)) {
+            if (!cpu->gt_cntfrq) {
+                error_setg(errp, "Invalid CNTFRQ: %"PRId64"Hz",
+                           cpu->gt_cntfrq);
+                return;
+            }
+            scale = gt_cntfrq_period_ns(cpu);
+        } else {
+            scale = GTIMER_SCALE;
+        }
+
+        cpu->gt_timer[GTIMER_PHYS] = timer_new(QEMU_CLOCK_VIRTUAL, scale,
+                                               arm_gt_ptimer_cb, cpu);
+        cpu->gt_timer[GTIMER_VIRT] = timer_new(QEMU_CLOCK_VIRTUAL, scale,
+                                               arm_gt_vtimer_cb, cpu);
+        cpu->gt_timer[GTIMER_HYP] = timer_new(QEMU_CLOCK_VIRTUAL, scale,
+                                              arm_gt_htimer_cb, cpu);
+        cpu->gt_timer[GTIMER_SEC] = timer_new(QEMU_CLOCK_VIRTUAL, scale,
+                                              arm_gt_stimer_cb, cpu);
+    }
 #endif
 
     cpu_exec_realizefn(cs, &local_err);
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 666c03871fdf..0bcd13dcac81 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -939,6 +939,24 @@ struct ARMCPU {
 
 static inline unsigned int gt_cntfrq_period_ns(ARMCPU *cpu)
 {
+    /*
+     * The exact approach to calculating guest ticks is:
+     *
+     *     muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), cpu->gt_cntfrq,
+     *              NANOSECONDS_PER_SECOND);
+     *
+     * We don't do that. Rather we intentionally use integer division
+     * truncation below and in the caller for the conversion of host monotonic
+     * time to guest ticks to provide the exact inverse for the semantics of
+     * the QEMUTimer scale factor. QEMUTimer's scale facter is an integer, so
+     * it loses precision when representing frequencies where
+     * `(NANOSECONDS_PER_SECOND % cpu->gt_cntfrq) > 0` holds. Failing to
+     * provide an exact inverse leads to scheduling timers with negative
+     * periods, which in turn leads to sticky behaviour in the guest.
+     *
+     * Finally, CNTFRQ is effectively capped at 1GHz to ensure our scale factor
+     * cannot become zero.
+     */
     /* XXX: Could include qemu/timer.h to get NANOSECONDS_PER_SECOND? */
     const unsigned int ns_per_s = 1000 * 1000 * 1000;
     return ns_per_s > cpu->gt_cntfrq ? ns_per_s / cpu->gt_cntfrq : 1;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1cc0551081a0..79e278e78291 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2683,6 +2683,13 @@ void arm_gt_stimer_cb(void *opaque)
     gt_recalc_timer(cpu, GTIMER_SEC);
 }
 
+static void arm_gt_cntfrq_reset(CPUARMState *env, const ARMCPRegInfo *opaque)
+{
+    ARMCPU *cpu = env_archcpu(env);
+
+    cpu->env.cp15.c14_cntfrq = cpu->gt_cntfrq;
+}
+
 static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     /* Note that CNTFRQ is purely reads-as-written for the benefit
      * of software; writing it doesn't actually change the timer frequency.
@@ -2697,7 +2704,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 0,
       .access = PL1_RW | PL0_R, .accessfn = gt_cntfrq_access,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_cntfrq),
-      .resetvalue = (1000 * 1000 * 1000) / GTIMER_SCALE,
+      .resetfn = arm_gt_cntfrq_reset,
     },
     /* overall control: mostly access permissions */
     { .name = "CNTKCTL", .state = ARM_CP_STATE_BOTH,
-- 
2.20.1


