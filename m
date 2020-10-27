Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CDEC55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:26:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAF95207BB
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Vam4PjeB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF95207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPvK-00043N-TX
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXPnX-0001yS-Gz; Tue, 27 Oct 2020 10:18:03 -0400
Received: from ozlabs.org ([203.11.71.1]:42485)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXPnV-0007aX-KK; Tue, 27 Oct 2020 10:18:03 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CLDLg5K0vz9shj; Wed, 28 Oct 2020 01:17:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603808267;
 bh=Pf4juhFstmmAMYCHTE12mN63e/5PUNwa8GocFdwzAdM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Vam4PjeBKkjJv5jzYBfc4sTXJiRdS7lmkJlKJrsrgy2ChO/p7RxA8QjcLVWvOLJmO
 Nta6dRjJZMr3IeY5qdQurkeNJEqSw4V7sJVnJMGHlo+L6wRpF8dNUDStDRrZ+5ZDF9
 f7VRiCrbA/fbG0kIlUcWI5TMjRLXl+WuqLNTFshA=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 08/18] spapr: Make spapr_cpu_core_unrealize() idempotent
Date: Wed, 28 Oct 2020 01:17:25 +1100
Message-Id: <20201027141735.728821-9-david@gibson.dropbear.id.au>
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

spapr_cpu_core_realize() has a rollback path which partially duplicates
the code of spapr_cpu_core_unrealize().

Let's make spapr_cpu_core_unrealize() idempotent and call it instead. This
requires to:
- move the registration and unregistration of the reset handler around
  but it is harmless,
- allocate the array of vCPUs with g_new0() to be able to filter out
  unused slots,
- make sure to only unrealize vCPUs that have been already realized.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <160279672626.1808373.14142129300586424514.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 45eb212187..317fb9934f 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -227,15 +227,26 @@ static void spapr_cpu_core_unrealize(DeviceState *dev)
     CPUCore *cc = CPU_CORE(dev);
     int i;
 
-    qemu_unregister_reset(spapr_cpu_core_reset_handler, sc);
-
     for (i = 0; i < cc->nr_threads; i++) {
-        spapr_unrealize_vcpu(sc->threads[i], sc);
+        if (sc->threads[i]) {
+            /*
+             * Since this we can get here from the error path of
+             * spapr_cpu_core_realize(), make sure we only unrealize
+             * vCPUs that have already been realized.
+             */
+            if (object_property_get_bool(OBJECT(sc->threads[i]), "realized",
+                                         &error_abort)) {
+                spapr_unrealize_vcpu(sc->threads[i], sc);
+            }
+        }
     }
     for (i = 0; i < cc->nr_threads; i++) {
-        spapr_delete_vcpu(sc->threads[i]);
+        if (sc->threads[i]) {
+            spapr_delete_vcpu(sc->threads[i]);
+        }
     }
     g_free(sc->threads);
+    qemu_unregister_reset(spapr_cpu_core_reset_handler, sc);
 }
 
 static bool spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
@@ -322,32 +333,22 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    sc->threads = g_new(PowerPCCPU *, cc->nr_threads);
+    qemu_register_reset(spapr_cpu_core_reset_handler, sc);
+    sc->threads = g_new0(PowerPCCPU *, cc->nr_threads);
     for (i = 0; i < cc->nr_threads; i++) {
         sc->threads[i] = spapr_create_vcpu(sc, i, errp);
         if (!sc->threads[i]) {
-            goto err;
+            spapr_cpu_core_unrealize(dev);
+            return;
         }
     }
 
     for (j = 0; j < cc->nr_threads; j++) {
         if (!spapr_realize_vcpu(sc->threads[j], spapr, sc, errp)) {
-            goto err_unrealize;
+            spapr_cpu_core_unrealize(dev);
+            return;
         }
     }
-
-    qemu_register_reset(spapr_cpu_core_reset_handler, sc);
-    return;
-
-err_unrealize:
-    while (--j >= 0) {
-        spapr_unrealize_vcpu(sc->threads[j], sc);
-    }
-err:
-    while (--i >= 0) {
-        spapr_delete_vcpu(sc->threads[i]);
-    }
-    g_free(sc->threads);
 }
 
 static Property spapr_cpu_core_properties[] = {
-- 
2.26.2


