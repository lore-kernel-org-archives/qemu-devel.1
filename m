Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D23C4360D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 03:43:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B63B121D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 03:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Xcqd2gTe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SEUvgoG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B63B121D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7tXu-0004az-UT
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 23:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43537)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1i7tWo-00042y-2d
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 23:42:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1i7tWm-0000Ci-R4
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 23:42:45 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37663)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1i7tWj-0000BN-OF; Tue, 10 Sep 2019 23:42:42 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id CB77320D87;
 Tue, 10 Sep 2019 23:42:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 10 Sep 2019 23:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm3; bh=JyW6xA25HDGt7k2em1rU8VchDz
 UxSHPtjD3hQIROWd0=; b=Xcqd2gTe9fO1QQayHKlU8zhznp6/jzscgM9o7Njjmg
 XzsFmeM4AfBWPjVJ7W3gaQu5JKIu/fobrPkg+rUUAW0MJGGxRWw2jzTIk0lpK46a
 BAUf2tz0kKfE6S+SpQA2lcFrKfEBq+H/0gXUZqBXw7ze5HiMcMSDdIcR8Yz0dhPs
 dbmaib548y0zEi9yj/TFc9B8L9OOnzOMG1ivvUm2K1zxwSKX/zDQCc53zM2ZhZbG
 lkqRkfFKl0PDmpmXbSZv8mVrj9PDKDwUO0pRuTcYXiX8isVnq/H+C2KBfZf4oqWn
 JwEMkquHSNfsmyoOqfzpJ3x94zMqW/6rMaaAQv6AxMbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=JyW6xA25HDGt7k2em
 1rU8VchDzUxSHPtjD3hQIROWd0=; b=SEUvgoG6H5SfNlT6WDohAvD8yVEA6lqme
 STTp9tiVg26N2E/4IbplBqkbZOCDQqtjiuwuaIQsnndZvnuCIKXB97bqQi914acH
 cbGBkynbqVMFW7BODyVID5F06sk1tMQrDi+DUKxK40kfA4p7MRa7StX9gZee6na7
 S+AD2SuePSP8x3GN2a7pxmuUSqvkh4zVdynw6P3ZXZeTsSGI3e7bNF7KY+7kBZSi
 CTdIfsFxtZnH4WAOiHtOBAEvJmJNYDD3exrSB3Xw4qQ/faN6fZztAapdNiNjVYuL
 vnzSzLlvaO4IMp+kk4tO8hsf2Eh3l5BavMHzNBE5KoQAfhGUY58Cg==
X-ME-Sender: <xms:L214XehxuZk0YsK6gLJzb2iPuYBGLnZgLiYG8yphKU0gwoLHOVnyKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrtddugdejgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
 dtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghjrdhi
 ugdrrghuqeenucffohhmrghinhepphgvrhhiohgurddqqddqthgrrhhgvghtnecukfhppe
 dvtddvrdekuddrudekrdeftdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgif
 segrjhdrihgurdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:L214XfPldHbFBKEjePn390mqO5cefSaMWx43IpfgoaeVKvv2PYjHhg>
 <xmx:L214XX6DPFQlDe7QilTSKj0ERicFuEDb3VpPyu7DZvH7QcqLnb7uOQ>
 <xmx:L214XV2u1aFThRoQVbQNMOoF3A9FQuiehbdfnLwE-cSMgqkq6fYFEg>
 <xmx:L214XQW8_i216cEeAXhRfrH8JKf52-g21g0GbX5OfI3sPZ5MXVLo4g>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
 by mail.messagingengine.com (Postfix) with ESMTPA id C4F888005A;
 Tue, 10 Sep 2019 23:42:36 -0400 (EDT)
From: Andrew Jeffery <andrew@aj.id.au>
To: qemu-arm@nongnu.org
Date: Wed, 11 Sep 2019 13:13:02 +0930
Message-Id: <20190911034302.29108-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 66.111.4.29
Subject: [Qemu-devel] [PATCH v3] target-arm: Make the counter tick relative
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
SoC where the generic timer clock is run at 800MHz or above.

CNTFRQ is a read-as-written co-processor register; the property sets the
register's initial value which is used during realize() to configure the
QEMUTimers that back the generic timers. Beyond that the firmware can to
do whatever it sees fit with the CNTFRQ register though changes to the
value will not be reflected in the timers' rate.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
Peter - I think this addresses most of your feedback. I still reach into
the QEMUTimer to fetch out scale when adjusting the nexttick
calculation, but we no longer need to update the scale member and force
a recalculation of the period.
---
 target/arm/cpu.c    | 36 ++++++++++++++++++++++++++++--------
 target/arm/helper.c | 20 +++++++++++++++++---
 2 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 2399c144718d..7ac422729608 100644
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
 
+static Property arm_cpu_cp_cntfrq_property =
+            DEFINE_PROP_UINT64("cntfrq", ARMCPU, env.cp15.c14_cntfrq,
+                               (1000 * 1000 * 1000) / GTIMER_SCALE);
+
 static Property arm_cpu_reset_cbar_property =
             DEFINE_PROP_UINT64("reset-cbar", ARMCPU, reset_cbar, 0);
 
@@ -1172,6 +1178,11 @@ void arm_cpu_post_init(Object *obj)
 
     qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property,
                              &error_abort);
+
+    if (arm_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER)) {
+        qdev_property_add_static(DEVICE(cpu), &arm_cpu_cp_cntfrq_property,
+                                 &error_abort);
+    }
 }
 
 static void arm_cpu_finalizefn(Object *obj)
@@ -1238,14 +1249,23 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
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
+    if (!env->cp15.c14_cntfrq) {
+        error_setg(errp, "Invalid CNTFRQ: %"PRIx64"Hz", env->cp15.c14_cntfrq);
+        return;
+    }
+
+    {
+        uint64_t scale = MAX(1, NANOSECONDS_PER_SECOND / env->cp15.c14_cntfrq);
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
index 507026c9154b..8783f92c718c 100644
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
-- 
2.20.1


