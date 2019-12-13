Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A0FC2D0BF
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 05:54:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B67CC2465B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 05:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="F9z4/wml";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b5PJu6cm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67CC2465B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifdu0-0007BF-UH
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 00:54:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1ifdow-0003Cp-66
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 00:48:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1ifdou-00051g-KX
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 00:48:58 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:37341)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1ifdor-0004tR-7N; Fri, 13 Dec 2019 00:48:53 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id E226890C;
 Fri, 13 Dec 2019 00:48:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Fri, 13 Dec 2019 00:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=gNZ9DXDMNR7Ep
 JAh12OKvhgw7oyqCMhiE3JvRC5PYi4=; b=F9z4/wmlnuMoEM8t3BpJwYqegqG9X
 l5MYDk1Q+9wp1vL9o/jYbPb+9Rq5vlauosaKqFOPboOJOiFDfV3G6r+FLwuYfSa9
 E2dTDYKVwewMidtzTeYzm2JmAqek86JIjsmiaIar+YFbc8zbaBtQt24j7YkjoO+T
 RhzpFC6HEydyZktcjkEV5EM7efkw6t9hm2wPPM3bg7YDRZFlu5+r6tMfT3PMjXxw
 nbmFx8vxfvtrBM700q9MRSZlCKOnkSzXxksREtKE9F1xx0jfckGPTUDhthqWW33C
 A/3/pLK/sqkdjW62RA231xQh0hfoiQ4nKFqWXBOdvfqZhmE9QpueQuLuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=gNZ9DXDMNR7EpJAh12OKvhgw7oyqCMhiE3JvRC5PYi4=; b=b5PJu6cm
 yvHUmvH1n0U8Enp1QB0jNq+4crZddxjabwf32CLZFM4a7E08UVwys6x5+rZY/rwk
 xwP18oHvqZF6OI+9+CNXjD8CboI/RkglPMqYOJ659Swz+7nsvdExLr+fKeQrn01U
 9/4NfwQWMZDqiHUaDf2CbWsT3tQjIYgoD0oDwc/NHQPnikxVMpmXflaVMxnQK15+
 qAQsBhvfjJ/vhpqjD4IgM6eGJvX113/6Yx9969FqmgsmuWgWfaQpXpeenHjlw8E+
 bb9TnDBxWX4ypam124dh163fl8k3yUuLQKI7XjPswhViSg5PFUSoOwGf9Nn2XorE
 qxbg08B4TPOpMQ==
X-ME-Sender: <xms:QybzXZQcIz_rJi3yW96emt2VB-TqwDhQn8YJNQRG6STFKLnYmqP16A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudelkedgkeejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetnhgurhgv
 ficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucffohhmrghinh
 epthgrghdrthgrrhhgvghtnecukfhppedvtddvrdekuddrudekrdeftdenucfrrghrrghm
 pehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghruf
 hiiigvpedt
X-ME-Proxy: <xmx:QybzXdcovfyJR9c2xlMm-NsSC-VLMPCqhoWzp_8V6clsKxQOiNIXRg>
 <xmx:QybzXXhX8VThQDTAwWDg_2FZr2etjGEvQkUN_dmlMcQRtGe7XEjrQg>
 <xmx:QybzXYKw7WuZ-eaXtTK87B37wItyN-d2woMocBtPDoJy3xpIPs2YTQ>
 <xmx:QybzXT1qVwFBvq4o35df_sMsOBCTAFV2lpJn9uwsJGLjfihp3Ist5w>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
 by mail.messagingengine.com (Postfix) with ESMTPA id 61DDE80060;
 Fri, 13 Dec 2019 00:48:48 -0500 (EST)
From: Andrew Jeffery <andrew@aj.id.au>
To: qemu-arm@nongnu.org
Subject: [PATCH v3 3/4] target/arm: Prepare generic timer for per-platform
 CNTFRQ
Date: Fri, 13 Dec 2019 16:19:50 +1030
Message-Id: <a22db9325f96e39f76e3c2baddcb712149f46bf2.1576215453.git-series.andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.ec85a2db47c3e10de70fba144e1bc75caf2f0a91.1576215453.git-series.andrew@aj.id.au>
References: <cover.ec85a2db47c3e10de70fba144e1bc75caf2f0a91.1576215453.git-series.andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 64.147.123.19
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
Cc: peter.maydell@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, clg@kaod.org, philmd@redhat.com, joel@jms.id.au
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
v3:
* Relocate comment as a consequence of uninlining gt_cntfrq_period_ns() in 2/4.
Philippe - I haven't moved it to the previous patch based on my reasoning on
the list. I'm not sure whether you're satisfied by that, so I haven't added
your Reviewed-by tag.

 target/arm/cpu.c    | 61 ++++++++++++++++++++++++++++++++++++++--------
 target/arm/helper.c |  9 ++++++-
 2 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index cd0dbe005d9f..7b21eb544eae 100644
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
index 2622a9a8d02f..94a05cd978bc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2683,6 +2683,13 @@ void arm_gt_stimer_cb(void *opaque)
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
git-series 0.9.1

