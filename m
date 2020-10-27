Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DEBC55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:41:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 278C3223B0
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Z2ef93m8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 278C3223B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQAG-0005aq-1z
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXPnc-0002B6-P6; Tue, 27 Oct 2020 10:18:08 -0400
Received: from ozlabs.org ([203.11.71.1]:38393)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXPnW-0007ax-3L; Tue, 27 Oct 2020 10:18:08 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CLDLm6qFMz9shq; Wed, 28 Oct 2020 01:17:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603808272;
 bh=tx9W2JqJhMoAwAA7x8UGF9wHsCmD4YZ6QCcENhw1uGs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Z2ef93m8F5yDKwABEg4PoYglW0XbX9UKt+qJxpvgWOuAXQa1D3jzG3LUt2VKQJKIO
 8zzXPpvbcp3ZXwcptz25BHynhgws853QW4c6+hScd97ciOxL0nplysF398oLU+9Fbh
 FES6+jigKB52DvN+HLi/m/CHiZr3vhazzqhviwmc=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 09/18] spapr: Simplify spapr_cpu_core_realize() and
 spapr_cpu_core_unrealize()
Date: Wed, 28 Oct 2020 01:17:26 +1100
Message-Id: <20201027141735.728821-10-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027141735.728821-1-david@gibson.dropbear.id.au>
References: <20201027141735.728821-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 10:17:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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

Now that the error path of spapr_cpu_core_realize() is just to call
idempotent spapr_cpu_core_unrealize() for rollback, no need to create
and realize the vCPUs in two separate loops.

Merge them and do them same in spapr_cpu_core_unrealize() for symmetry.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <160279673321.1808373.2248221100790367912.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 317fb9934f..2f7dc3c23d 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -238,10 +238,6 @@ static void spapr_cpu_core_unrealize(DeviceState *dev)
                                          &error_abort)) {
                 spapr_unrealize_vcpu(sc->threads[i], sc);
             }
-        }
-    }
-    for (i = 0; i < cc->nr_threads; i++) {
-        if (sc->threads[i]) {
             spapr_delete_vcpu(sc->threads[i]);
         }
     }
@@ -326,7 +322,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
                                                   TYPE_SPAPR_MACHINE);
     SpaprCpuCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
     CPUCore *cc = CPU_CORE(OBJECT(dev));
-    int i, j;
+    int i;
 
     if (!spapr) {
         error_setg(errp, TYPE_SPAPR_CPU_CORE " needs a pseries machine");
@@ -337,14 +333,8 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
     sc->threads = g_new0(PowerPCCPU *, cc->nr_threads);
     for (i = 0; i < cc->nr_threads; i++) {
         sc->threads[i] = spapr_create_vcpu(sc, i, errp);
-        if (!sc->threads[i]) {
-            spapr_cpu_core_unrealize(dev);
-            return;
-        }
-    }
-
-    for (j = 0; j < cc->nr_threads; j++) {
-        if (!spapr_realize_vcpu(sc->threads[j], spapr, sc, errp)) {
+        if (!sc->threads[i] ||
+            !spapr_realize_vcpu(sc->threads[i], spapr, sc, errp)) {
             spapr_cpu_core_unrealize(dev);
             return;
         }
-- 
2.26.2


