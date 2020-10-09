Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51984C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:36:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDF27221FC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="diKR/PwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF27221FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQpld-00079j-IL
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 06:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kQpVa-0005Np-KK
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:20:18 -0400
Received: from ozlabs.org ([203.11.71.1]:55957)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kQpVX-0001nf-Nw
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:20:18 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4C73wb4qr1z9sWK; Fri,  9 Oct 2020 21:19:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602238799;
 bh=7UAQ27JWZpmDGCPmSO/grFPvEyc6GK1bknvnZwBLyhw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=diKR/PwYDbQB2WSJ0XHoC+L74F5M9Fnc88a+7Km7uc5jgutDmviIPTQaCAzZGhGzd
 ja8hbbkLsxGvvFmbeoQoBLE1lJVIEgWnOvKn/r15k4he6faljmxgj6JWTW/ik35Zz9
 wexDBHlFs7HNPJbThsu5Ey60sDBm6Cd2abjFMwkI=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 12/20] spapr: Simplify error handling in
 spapr_cpu_core_realize()
Date: Fri,  9 Oct 2020 21:19:43 +1100
Message-Id: <20201009101951.1569252-13-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201009101951.1569252-1-david@gibson.dropbear.id.au>
References: <20201009101951.1569252-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 06:19:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 dbarboza@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nonngu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

As recommended in "qapi/error.h", add a bool return value to
spapr_realize_vcpu() and use it in spapr_cpu_core_realize()
in order to get rid of the error propagation overhead.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <20200914123505.612812-12-groug@kaod.org>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 0c879d4da2..b03620823a 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -227,14 +227,14 @@ static void spapr_cpu_core_unrealize(DeviceState *dev)
     g_free(sc->threads);
 }
 
-static void spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
+static bool spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
                                SpaprCpuCore *sc, Error **errp)
 {
     CPUPPCState *env = &cpu->env;
     CPUState *cs = CPU(cpu);
 
     if (!qdev_realize(DEVICE(cpu), NULL, errp)) {
-        return;
+        return false;
     }
 
     /* Set time-base frequency to 512 MHz */
@@ -245,13 +245,14 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
 
     if (spapr_irq_cpu_intc_create(spapr, cpu, errp) < 0) {
         cpu_remove_sync(CPU(cpu));
-        return;
+        return false;
     }
 
     if (!sc->pre_3_0_migration) {
         vmstate_register(NULL, cs->cpu_index, &vmstate_spapr_cpu_state,
                          cpu->machine_data);
     }
+    return true;
 }
 
 static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, int i, Error **errp)
@@ -312,7 +313,6 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
                                                   TYPE_SPAPR_MACHINE);
     SpaprCpuCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
     CPUCore *cc = CPU_CORE(OBJECT(dev));
-    Error *local_err = NULL;
     int i, j;
 
     if (!spapr) {
@@ -322,15 +322,14 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
 
     sc->threads = g_new(PowerPCCPU *, cc->nr_threads);
     for (i = 0; i < cc->nr_threads; i++) {
-        sc->threads[i] = spapr_create_vcpu(sc, i, &local_err);
-        if (local_err) {
+        sc->threads[i] = spapr_create_vcpu(sc, i, errp);
+        if (!sc->threads[i]) {
             goto err;
         }
     }
 
     for (j = 0; j < cc->nr_threads; j++) {
-        spapr_realize_vcpu(sc->threads[j], spapr, sc, &local_err);
-        if (local_err) {
+        if (!spapr_realize_vcpu(sc->threads[j], spapr, sc, errp)) {
             goto err_unrealize;
         }
     }
@@ -347,7 +346,6 @@ err:
         spapr_delete_vcpu(sc->threads[i], sc);
     }
     g_free(sc->threads);
-    error_propagate(errp, local_err);
 }
 
 static Property spapr_cpu_core_properties[] = {
-- 
2.26.2


