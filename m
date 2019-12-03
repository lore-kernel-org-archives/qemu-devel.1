Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A54C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 04:18:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F8C5206E0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 04:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="jv6kpy63";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uT9tE2oL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8C5206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibzdd-0002HD-7V
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 23:18:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1ibzZ9-0005ma-IJ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 23:13:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1ibzZ6-0001KK-2c
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 23:13:35 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:56489)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1ibzZ1-0001El-7c; Mon, 02 Dec 2019 23:13:27 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 08B10ED2;
 Mon,  2 Dec 2019 23:13:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 02 Dec 2019 23:13:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=UnMHwPPfQ4KRN
 61OUf/u4EXG5kQhV6gU2lUxKArzxDo=; b=jv6kpy63xqnWAhau27nV+ZCposTPf
 kiQ61fjwkzCXyx/Nk8bWtxMAnkHfKVViOVY6PuS4AA0EoEMDAdlaNL4FsmyLGDtJ
 rt/WrlC9YEZy+fSFRIOMgQOImGseiVyLrxYGTc3JUtFUzf1vNQTYHVHK9sltf/i8
 6nxyFr72oG1+huUPdAydtc5eV/JL5uvxTze4u3sRc13hrUlTAYXewTBO+SiZmRLY
 txueFKm1YRVYmq44VXzQnLBq3qeSAAQ/c8ELJNsLyLLmKOqgWtbzNfuVvZ0Pxzsk
 a/EA/R3XwU+weeGsAnc9R7JDTQyZ9GiuV7VNtwQUybiR8qVBQeTE6mJTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=UnMHwPPfQ4KRN61OUf/u4EXG5kQhV6gU2lUxKArzxDo=; b=uT9tE2oL
 Y9GYFM8myJifEkSq33gIoLUwOb63A9AWdaSmY1Qmn8x/WnFmmIv8d2cOsTRTb3DR
 vxqo3/C/xn4ssizCYw1XEJDyprvPyirB7GT2NcgRk7wOIvSwNI83cwTRH/Nxe7or
 BYo3kIMWkXQPrk+fmrUIBm4nsy4zWRCwnBJ+L1X+WaWQXCtDWpLFywlYDwXPQzBv
 X1NYDo/mjfaQcKzapjqDZLWYfiY1LPY4MWO275HE2o09CKkHC55M9oGxdPBbxMGH
 oHxRkK4sbptx0G5IrmZVJJVK1IFmoIfU3R5uZDSdq1iOelYt/coWxTVov1vzyMd3
 ta+nnviQ9FhXFg==
X-ME-Sender: <xms:5eDlXbuWf5VT0ro_t6-l6lLZmANbWhaoU2CRougc20g6g_2_rRFKAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejiedgieeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetnhgurhgv
 ficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfkphepvddtvd
 drkedurddukedrfedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghj
 rdhiugdrrghunecuvehluhhsthgvrhfuihiivgepud
X-ME-Proxy: <xmx:5eDlXcpLeCTy47eAR6Fgx_mHDpaYDApJnbsTdcwCS6LzL374YubFvQ>
 <xmx:5eDlXRYma_nzpTQVJoSQssLT6KBxs1x2u670W5h30yQtyy_VT45evg>
 <xmx:5eDlXVzynv05OrXuFqFxuJb310JNllRX8LtYH80Vzu-qSggj2fsYfA>
 <xmx:5eDlXUYRuKr3hm6K5emS2Fq127s0utPQL9EGoX63lw9P_qUXKCWD6Q>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
 by mail.messagingengine.com (Postfix) with ESMTPA id EE4028005A;
 Mon,  2 Dec 2019 23:13:22 -0500 (EST)
From: Andrew Jeffery <andrew@aj.id.au>
To: qemu-arm@nongnu.org
Subject: [PATCH v2 3/4] target/arm: Prepare generic timer for per-platform
 CNTFRQ
Date: Tue,  3 Dec 2019 14:44:39 +1030
Message-Id: <20191203041440.6275-4-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191203041440.6275-1-andrew@aj.id.au>
References: <20191203041440.6275-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 64.147.123.24
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, clg@kaod.org, joel@jms.id.au
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
of an integer scaling factor. The effect is QEMUTimer cannot exactly
capture the period of frequencies that do not cleanly divide
NANOSECONDS_PER_SECOND for scaling ticks to time. As such, provide an
equally inaccurate scaling factor for scaling time to ticks so at least
a self-consistent inverse relationship holds.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
index 2622a9a8d02f..da960d17040b 100644
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


