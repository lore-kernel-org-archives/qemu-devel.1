Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B0EC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:45:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2869122258
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Oo5Iaknu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2869122258
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQDf-0001jm-2a
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXPnc-0002BX-TF; Tue, 27 Oct 2020 10:18:08 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:37139 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXPnW-0007aO-Tq; Tue, 27 Oct 2020 10:18:08 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CLDLd6BVMz9sW4; Wed, 28 Oct 2020 01:17:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603808265;
 bh=qk9USLB1WY7s4/hoobaUMDtYnDz9yCpUwkkpc3E9324=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Oo5IaknuJefbaEeKJLopL7xkjFopS0IirFfu75ktinvHqittC7/VVkFwqciqUUoAQ
 uPxl9guVioi6mKnMpoW7BMKCLGROP68/NXGPGtp+lSIG6TJRQn6iqhHJBwmQT2SXWS
 9If+R31k59Lg/vBTATl6fSCC9+aH0dnCfpawYM2c=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 05/18] spapr: Fix leak of CPU machine specific data
Date: Wed, 28 Oct 2020 01:17:22 +1100
Message-Id: <20201027141735.728821-6-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027141735.728821-1-david@gibson.dropbear.id.au>
References: <20201027141735.728821-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

When a CPU core is being removed, the machine specific data of each
CPU thread object is leaked.

Fix this by calling the dedicated helper we have for that instead of
simply unparenting the CPU object. Call it from a separate loop in
spapr_cpu_core_unrealize() for symmetry with spapr_cpu_core_realize().

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <160279670540.1808373.17319746576919615623.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index b03620823a..c552112145 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -188,7 +188,6 @@ static void spapr_unrealize_vcpu(PowerPCCPU *cpu, SpaprCpuCore *sc)
     }
     spapr_irq_cpu_intc_destroy(SPAPR_MACHINE(qdev_get_machine()), cpu);
     cpu_remove_sync(CPU(cpu));
-    object_unparent(OBJECT(cpu));
 }
 
 /*
@@ -213,6 +212,15 @@ static void spapr_cpu_core_reset_handler(void *opaque)
     spapr_cpu_core_reset(opaque);
 }
 
+static void spapr_delete_vcpu(PowerPCCPU *cpu, SpaprCpuCore *sc)
+{
+    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
+
+    cpu->machine_data = NULL;
+    g_free(spapr_cpu);
+    object_unparent(OBJECT(cpu));
+}
+
 static void spapr_cpu_core_unrealize(DeviceState *dev)
 {
     SpaprCpuCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
@@ -224,6 +232,9 @@ static void spapr_cpu_core_unrealize(DeviceState *dev)
     for (i = 0; i < cc->nr_threads; i++) {
         spapr_unrealize_vcpu(sc->threads[i], sc);
     }
+    for (i = 0; i < cc->nr_threads; i++) {
+        spapr_delete_vcpu(sc->threads[i], sc);
+    }
     g_free(sc->threads);
 }
 
@@ -294,15 +305,6 @@ err:
     return NULL;
 }
 
-static void spapr_delete_vcpu(PowerPCCPU *cpu, SpaprCpuCore *sc)
-{
-    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
-
-    cpu->machine_data = NULL;
-    g_free(spapr_cpu);
-    object_unparent(OBJECT(cpu));
-}
-
 static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
 {
     /* We don't use SPAPR_MACHINE() in order to exit gracefully if the user
-- 
2.26.2


