Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC27CC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:31:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A5A2206CB
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YEJSnFI4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5A2206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJJ8-0002I1-Fh
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:31:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iiJF1-0004lf-3G
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:26:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iiJEz-0006wi-36
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:26:54 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:39376)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iiJEy-0006sC-Oa
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:26:52 -0500
Received: by mail-wm1-x330.google.com with SMTP id 20so9307770wmj.4
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 06:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Gbu+WbBDFzD2YgTHbagiyWS90NksqhC1RztZJbMJG+c=;
 b=YEJSnFI4rHJHkkUlL+1Ml3Pm5H4WquiC2tp6Q/MeePfsZX/geGWgpCNtonJSdgjX92
 RUcAU+OW0WF5WB60lQrfE8GK/CbTRR4BXK2LaC3WhcrxYEFhGOVo6qcyZMalFL0iob+A
 co3n5wbfkN+HwPDoH6L5VFn2s2OUiDaImAgf0J9zIsBgd5Fq+vuaq/cBoM/OmepOdsKr
 dEYNznvfoDa62R8ktMM/GjN1ekiGr2t5HCda6f0pyantSnZmZ/OfLlex3Oq636N3WbkA
 EstKsHYTzQzK4JXJJq0eIULvpfSWsYCQEl0kBNw9jdfu8wnjrulZVUy9F2B+XIAPBj2d
 ltGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Gbu+WbBDFzD2YgTHbagiyWS90NksqhC1RztZJbMJG+c=;
 b=LWXtSQ9eO0Sp4YCdmF6zPvtURZxnJGJZAvW1wu/o6afUNwhoLMkV4biXfU8cAJaGaS
 3v5vpQGNu020EFjmsvrXCcfol+yEav2cA4fHVE5cqCNBtsL6J3Kt63hOsX1V8qgFP9B9
 4+uC6EYcW/N+m8MbQ3oeP/qc4fspYNeK2ZeHYgca/iODOUxibIRcNlEUDO2Hvkg389cZ
 xw3qUin7DoWl3pJojLm6IJfg3IHjpz7ag/hi5G2F6ZOyxg/OEveJQfUT/ZVdIjkrOLxi
 EyKNgXQVs3L7M7+RTpWieBHDIDuS5R2UHftdEiUfN9YUZbw0Ng+BOuX11uhLm24Bj8Ga
 J2qw==
X-Gm-Message-State: APjAAAUhZj8Bf9vfdGspIZ6xtSsf/SnhFFeWUHeX0zES9rwujnJZRNgz
 wTHxLV5ItHhg1bPUWUIHjj4SIU3HjlCg3Q==
X-Google-Smtp-Source: APXvYqzCtgb5DL3fmArXqzhfhZD8w7WiAto2pbjGg7CZO/mwT8rZoH5A4UxYjSaAblQITw0swyLISQ==
X-Received: by 2002:a05:600c:218b:: with SMTP id
 e11mr15736508wme.121.1576852011095; 
 Fri, 20 Dec 2019 06:26:51 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t5sm9741814wrr.35.2019.12.20.06.26.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 06:26:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/12] target/arm: Prepare generic timer for per-platform CNTFRQ
Date: Fri, 20 Dec 2019 14:26:35 +0000
Message-Id: <20191220142644.31076-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220142644.31076-1-peter.maydell@linaro.org>
References: <20191220142644.31076-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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

From: Andrew Jeffery <andrew@aj.id.au>

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
Message-id: a22db9325f96e39f76e3c2baddcb712149f46bf2.1576215453.git-series.andrew@aj.id.au
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c    | 61 +++++++++++++++++++++++++++++++++++++--------
 target/arm/helper.c |  9 ++++++-
 2 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 0abe288e38c..d62fd5fdc64 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -974,10 +974,12 @@ static void arm_cpu_initfn(Object *obj)
     if (tcg_enabled()) {
         cpu->psci_version = 2; /* TCG implements PSCI 0.2 */
     }
-
-    cpu->gt_cntfrq_hz = NANOSECONDS_PER_SECOND / GTIMER_SCALE;
 }
 
+static Property arm_cpu_gt_cntfrq_property =
+            DEFINE_PROP_UINT64("cntfrq", ARMCPU, gt_cntfrq_hz,
+                               NANOSECONDS_PER_SECOND / GTIMER_SCALE);
+
 static Property arm_cpu_reset_cbar_property =
             DEFINE_PROP_UINT64("reset-cbar", ARMCPU, reset_cbar, 0);
 
@@ -1059,6 +1061,24 @@ static void arm_set_init_svtor(Object *obj, Visitor *v, const char *name,
 
 unsigned int gt_cntfrq_period_ns(ARMCPU *cpu)
 {
+    /*
+     * The exact approach to calculating guest ticks is:
+     *
+     *     muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), cpu->gt_cntfrq_hz,
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
     return NANOSECONDS_PER_SECOND > cpu->gt_cntfrq_hz ?
       NANOSECONDS_PER_SECOND / cpu->gt_cntfrq_hz : 1;
 }
@@ -1180,6 +1200,11 @@ void arm_cpu_post_init(Object *obj)
 
     qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property,
                              &error_abort);
+
+    if (arm_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER)) {
+        qdev_property_add_static(DEVICE(cpu), &arm_cpu_gt_cntfrq_property,
+                                 &error_abort);
+    }
 }
 
 static void arm_cpu_finalizefn(Object *obj)
@@ -1259,14 +1284,30 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
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
+            if (!cpu->gt_cntfrq_hz) {
+                error_setg(errp, "Invalid CNTFRQ: %"PRId64"Hz",
+                           cpu->gt_cntfrq_hz);
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
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 85963789f7d..1d9af2d8b28 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2723,6 +2723,13 @@ void arm_gt_stimer_cb(void *opaque)
     gt_recalc_timer(cpu, GTIMER_SEC);
 }
 
+static void arm_gt_cntfrq_reset(CPUARMState *env, const ARMCPRegInfo *opaque)
+{
+    ARMCPU *cpu = env_archcpu(env);
+
+    cpu->env.cp15.c14_cntfrq = cpu->gt_cntfrq_hz;
+}
+
 static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     /* Note that CNTFRQ is purely reads-as-written for the benefit
      * of software; writing it doesn't actually change the timer frequency.
@@ -2737,7 +2744,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
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


