Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC871C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:40:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74ECE2054F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Q4BDq/NT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74ECE2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7tQI-0003P5-Mw
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 00:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t7W-00013r-5Z; Tue, 18 Aug 2020 00:21:10 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38513 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t7T-0006Rh-2d; Tue, 18 Aug 2020 00:21:09 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BVyNh4sT8z9sW4; Tue, 18 Aug 2020 14:19:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597724372;
 bh=190f+V+vuJPVY9rkM/6szxDl+6qCDUsVZleu5RtI4uU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Q4BDq/NTxdlUl1I0ClKcaRRq6ewbT/jJo81tIh/1pbZZYNJIwIRAtpT0uG2Uv6Krs
 X+H2AgL+rM9eUPKBf66ZuQiMOllVLcpuQnDdL6Q4hDC7YFCf9SWDws2DS7SUOauJn9
 PHkjP5ThMZfnxr3ex/chRQzwbWFDaVbrsqBDYYZg=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org,
	groug@kaod.org
Subject: [PULL 34/40] spapr/xive: Fix error handling in kvmppc_xive_post_load()
Date: Tue, 18 Aug 2020 14:19:16 +1000
Message-Id: <20200818041922.251708-35-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818041922.251708-1-david@gibson.dropbear.id.au>
References: <20200818041922.251708-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 00:19:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Now that all these functions return a negative errno on failure, check
that because it is preferred to local_err. And most of all, propagate it
because vmstate expects negative errnos.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <159707850148.1489912.18355118622296682631.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive_kvm.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 1686b036eb..005729ebff 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -631,6 +631,7 @@ int kvmppc_xive_post_load(SpaprXive *xive, int version_id)
     Error *local_err = NULL;
     CPUState *cs;
     int i;
+    int ret;
 
     /* The KVM XIVE device should be in use */
     assert(xive->fd != -1);
@@ -641,11 +642,10 @@ int kvmppc_xive_post_load(SpaprXive *xive, int version_id)
             continue;
         }
 
-        kvmppc_xive_set_queue_config(xive, SPAPR_XIVE_BLOCK_ID, i,
-                                     &xive->endt[i], &local_err);
-        if (local_err) {
-            error_report_err(local_err);
-            return -1;
+        ret = kvmppc_xive_set_queue_config(xive, SPAPR_XIVE_BLOCK_ID, i,
+                                           &xive->endt[i], &local_err);
+        if (ret < 0) {
+            goto fail;
         }
     }
 
@@ -660,16 +660,14 @@ int kvmppc_xive_post_load(SpaprXive *xive, int version_id)
          * previously set in KVM. Since we don't do that for all interrupts
          * at reset time anymore, let's do it now.
          */
-        kvmppc_xive_source_reset_one(&xive->source, i, &local_err);
-        if (local_err) {
-            error_report_err(local_err);
-            return -1;
+        ret = kvmppc_xive_source_reset_one(&xive->source, i, &local_err);
+        if (ret < 0) {
+            goto fail;
         }
 
-        kvmppc_xive_set_source_config(xive, i, &xive->eat[i], &local_err);
-        if (local_err) {
-            error_report_err(local_err);
-            return -1;
+        ret = kvmppc_xive_set_source_config(xive, i, &xive->eat[i], &local_err);
+        if (ret < 0) {
+            goto fail;
         }
     }
 
@@ -686,15 +684,18 @@ int kvmppc_xive_post_load(SpaprXive *xive, int version_id)
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
 
-        kvmppc_xive_cpu_set_state(spapr_cpu_state(cpu)->tctx, &local_err);
-        if (local_err) {
-            error_report_err(local_err);
-            return -1;
+        ret = kvmppc_xive_cpu_set_state(spapr_cpu_state(cpu)->tctx, &local_err);
+        if (ret < 0) {
+            goto fail;
         }
     }
 
     /* The source states will be restored when the machine starts running */
     return 0;
+
+fail:
+    error_report_err(local_err);
+    return ret;
 }
 
 /* Returns MAP_FAILED on error and sets errno */
-- 
2.26.2


