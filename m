Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66761C49ED9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 06:57:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FDC7208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 06:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="MNlsoIKa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vcB3C3Bk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FDC7208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8J2p-00054h-Ao
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 02:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1i8J1l-000448-D6
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 02:56:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1i8J1j-00053O-S4
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 02:56:25 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56387)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1i8J1g-00050f-0L; Thu, 12 Sep 2019 02:56:20 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id DCBB722503;
 Thu, 12 Sep 2019 02:56:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Thu, 12 Sep 2019 02:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm3; bh=Zz4wdxa1IyEFTr3gCC31Xp9Ygb
 M4DnB0s2+ypeZ1K/8=; b=MNlsoIKasJmLeBsRY3dK8IfZ24j+IESCvYu1bUU81t
 8pPlOnQuBTIAiCkcbqM14Lsgjj5jqIbdUscrdtax5KFaGpSwqmxMqBnZObVJU9hI
 uT45fWEpabTzuUAfa/as3wVvzfNWJ8o1HqlUZ0I+71A6o17Q66eHsZrV4hMpVPrH
 hICE5S7cpS/bGPIt25e4awOdeF0QLSOsq/TZkjk4E5Rm3ypg22E4W6cNto/zJ3L2
 Z8jzRVrJCOsjyZzHdbwHwj7imqS323pS3B2gxY0iThVwwQXumuNy9iNtBAPg3evi
 FZ5BOqte8MuOBh3HkZlvrLMwV9hHI/DVLaNZp6O67qCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Zz4wdxa1IyEFTr3gC
 C31Xp9YgbM4DnB0s2+ypeZ1K/8=; b=vcB3C3BkH+2IU5oR1F6gCyogPlTXR5dYM
 TxkOIygPp8RLYYYiIW0Cov/kgF6oVvtEvsGpghMe0PJcnFU7FYRGBy8e3HecjueQ
 w/sVoP6vuifp0OTNvzIqMbJyt3OEdF4MKZP7ovcMtCV3RcOP9kMZNxnSZYKTbu2E
 0Di4g2c0NSGw5mLDuF9twI4eFjablPD3KNGa8O+ZGsbgkPeXy82bpyP5r/5OraIh
 oCJInm4TxZjSBu88J8NAmdBSF9qGQZ1jqy9OQ+OY4gCInIWuynKaHAP5Zwjs2grh
 chp6rFOaxkTBbc0diZegypcFN8xOU6AKx+1bXBRlxT8cOWpmst/eQ==
X-ME-Sender: <xms:Eux5XTWghfWyuu-zmHoIu3bzwKCxhgo_izYvz-zQztm_ZFwl0H41QQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrtdeggdduudegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
 dttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegrjhdr
 ihgurdgruheqnecuffhomhgrihhnpehoiihlrggsshdrohhrghenucfkphepvddtvddrke
 durddukedrfedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhi
 ugdrrghunecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:Eux5XdPbeVSdSWliwDLnnxuOsfAO0rV6uURtHJHhfRQW_rZIry-sFA>
 <xmx:Eux5XTcQqHpTu4oXs6zGkOz0immBmm-MH_bB4bnTDnOleJNWc5Ws2w>
 <xmx:Eux5XUz45aLPwnaZM9gHScek5yBku9cImHuZdprxV6PS4LTHhfPUjA>
 <xmx:Eux5XTp85tFNc2Ubq5oZCZoQ7PcRQ0MAFkoyvTP-rgj2hsCxQON71w>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
 by mail.messagingengine.com (Postfix) with ESMTPA id 22B9DD60069;
 Thu, 12 Sep 2019 02:56:15 -0400 (EDT)
From: Andrew Jeffery <andrew@aj.id.au>
To: qemu-arm@nongnu.org
Date: Thu, 12 Sep 2019 16:26:31 +0930
Message-Id: <20190912065631.12473-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 66.111.4.26
Subject: [Qemu-devel] [PATCH v5] target-arm: Make the counter tick relative
 to cntfrq
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
Cc: Andrew Jeffery <andrew@aj.id.au>, peter.maydell@linaro.org, clg@kaod.org,
 qemu-devel@nongnu.org, joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow machines to configure CNTFRQ via a property if the ARM core
supports the generic timer. This is necessary on e.g. the ASPEED AST2600
SoC where the generic timer clock is run at 800MHz or above. The default
value for CNTFRQ remains at 62.50MHz (based on GTIMER_SCALE).

CNTFRQ is a read-as-written co-processor register; the property sets the
register's initial value which is used during realize() to configure the
QEMUTimers that back the generic timers. Beyond that the firmware can to
do whatever it sees fit with the CNTFRQ register though changes to the
value will not be reflected in the timers' rate.

I've tested this using an out-of-tree AST2600 SoC model (Cortex-A7) with
the SDK u-boot that sets CNTFRQ as appropriate, and by starting/running
machines with assorted ARM CPUs (palmetto-bmc with the ARM926EJ-S,
romulus-bmc with the ARM1176 and raspi2 with the Cortex-A53).

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
v5: Remove unrelated submodule updates that snuck into v4

v4: https://patchwork.ozlabs.org/patch/1161340/
Fix configuration for cores without a generic timer

v3: https://patchwork.ozlabs.org/patch/1160634/
Peter - I think this addresses most of your feedback. I still reach into
the QEMUTimer to fetch out scale when adjusting the nexttick
calculation, but we no longer need to update the scale member and force
a recalculation of the period.

v2: https://patchwork.ozlabs.org/patch/1144389/
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 target/arm/cpu.c    | 43 +++++++++++++++++++++++++++++++++++--------
 target/arm/cpu.h    |  3 +++
 target/arm/helper.c | 30 ++++++++++++++++++++++++++----
 3 files changed, 64 insertions(+), 12 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 2399c144718d..8b63a27761bb 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -40,6 +40,8 @@
 #include "disas/capstone.h"
 #include "fpu/softfloat.h"
 
+#include <inttypes.h>
+
 static void arm_cpu_set_pc(CPUState *cs, vaddr value)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -976,6 +978,10 @@ static void arm_cpu_initfn(Object *obj)
     }
 }
 
+static Property arm_cpu_gt_cntfrq_property =
+            DEFINE_PROP_UINT64("cntfrq", ARMCPU, gt_cntfrq,
+                               (1000 * 1000 * 1000) / GTIMER_SCALE);
+
 static Property arm_cpu_reset_cbar_property =
             DEFINE_PROP_UINT64("reset-cbar", ARMCPU, reset_cbar, 0);
 
@@ -1172,6 +1178,11 @@ void arm_cpu_post_init(Object *obj)
 
     qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property,
                              &error_abort);
+
+    if (arm_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER)) {
+        qdev_property_add_static(DEVICE(cpu), &arm_cpu_gt_cntfrq_property,
+                                 &error_abort);
+    }
 }
 
 static void arm_cpu_finalizefn(Object *obj)
@@ -1238,14 +1249,30 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
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
+            scale = MAX(1, NANOSECONDS_PER_SECOND / cpu->gt_cntfrq);
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
index 297ad5e47ad8..8bd576f834ba 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -915,6 +915,9 @@ struct ARMCPU {
 
     /* Used to set the maximum vector length the cpu will support.  */
     uint32_t sve_max_vq;
+
+    /* Used to configure the generic timer input clock */
+    uint64_t gt_cntfrq;
 };
 
 void arm_cpu_post_init(Object *obj);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 507026c9154b..09975704d47f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2409,7 +2409,21 @@ static CPAccessResult gt_stimer_access(CPUARMState *env,
 
 static uint64_t gt_get_countervalue(CPUARMState *env)
 {
-    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / GTIMER_SCALE;
+    uint64_t effective;
+
+    /*
+     * Deal with quantized clock scaling by calculating the effective frequency
+     * in terms of the timer scale.
+     */
+    if (env->cp15.c14_cntfrq <= NANOSECONDS_PER_SECOND) {
+        uint32_t scale = NANOSECONDS_PER_SECOND / env->cp15.c14_cntfrq;
+        effective = NANOSECONDS_PER_SECOND / scale;
+    } else {
+        effective = NANOSECONDS_PER_SECOND;
+    }
+
+    return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), effective,
+                    NANOSECONDS_PER_SECOND);
 }
 
 static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
@@ -2445,8 +2459,8 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
          * set the timer for as far in the future as possible. When the
          * timer expires we will reset the timer for any remaining period.
          */
-        if (nexttick > INT64_MAX / GTIMER_SCALE) {
-            nexttick = INT64_MAX / GTIMER_SCALE;
+        if (nexttick > INT64_MAX / cpu->gt_timer[timeridx]->scale) {
+            nexttick = INT64_MAX / cpu->gt_timer[timeridx]->scale;
         }
         timer_mod(cpu->gt_timer[timeridx], nexttick);
         trace_arm_gt_recalc(timeridx, irqstate, nexttick);
@@ -2680,6 +2694,14 @@ void arm_gt_stimer_cb(void *opaque)
     gt_recalc_timer(cpu, GTIMER_SEC);
 }
 
+static void arm_gt_cntfrq_reset(CPUARMState *env, const ARMCPRegInfo *opaque)
+{
+    ARMCPU *cpu = env_archcpu(env);
+
+    cpu->env.cp15.c14_cntfrq =
+        cpu->gt_cntfrq ?: (1000 * 1000 * 1000) / GTIMER_SCALE;
+}
+
 static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     /* Note that CNTFRQ is purely reads-as-written for the benefit
      * of software; writing it doesn't actually change the timer frequency.
@@ -2694,7 +2716,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
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


