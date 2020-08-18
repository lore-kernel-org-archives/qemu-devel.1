Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C35C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:30:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59496206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gYTbsqkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59496206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7tGb-0001vO-GC
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 00:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t6c-0008TJ-2m; Tue, 18 Aug 2020 00:20:14 -0400
Received: from ozlabs.org ([203.11.71.1]:36883)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t6Z-0006OO-En; Tue, 18 Aug 2020 00:20:12 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BVyNd61y6z9sVk; Tue, 18 Aug 2020 14:19:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597724369;
 bh=W8W6ApiPFY78TyXOgwighd9yWvwfZ8AmkgzUw8Fi1/4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gYTbsqkTdxH1wl3hLPeyl7oVMwJKAzapIq01tPm+4Nl+YoVDHqjlk4N9QatytabCv
 xLgnU3scTj/2uab3ZvSY797H+O1aXEOkl6ZbLPZEwAR7Fm+jga6k2EoAg8DzNmwpv/
 hCvHA5aZoQkIZfDy0ckSQZgxt4a181LvBMrAMn2s=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org,
	groug@kaod.org
Subject: [PULL 24/40] spapr/xive: Convert KVM device fd checks to assert()
Date: Tue, 18 Aug 2020 14:19:06 +1000
Message-Id: <20200818041922.251708-25-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818041922.251708-1-david@gibson.dropbear.id.au>
References: <20200818041922.251708-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

All callers guard these functions with an xive_in_kernel() helper. Make
it clear that they are only to be called when the KVM XIVE device exists.

Note that the check on xive is dropped in kvmppc_xive_disconnect(). It
really cannot be NULL since it comes from set_active_intc() which only
passes pointers to allocated objects.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <159679994169.876294.11026653581505077112.stgit@bahia.lan>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive_kvm.c | 35 +++++++----------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 6130882be6..82a6f99f02 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -79,10 +79,7 @@ void kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **errp)
     uint64_t state[2];
     int ret;
 
-    /* The KVM XIVE device is not in use yet */
-    if (xive->fd == -1) {
-        return;
-    }
+    assert(xive->fd != -1);
 
     /* word0 and word1 of the OS ring. */
     state[0] = *((uint64_t *) &tctx->regs[TM_QW1_OS]);
@@ -101,10 +98,7 @@ void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp)
     uint64_t state[2] = { 0 };
     int ret;
 
-    /* The KVM XIVE device is not in use */
-    if (xive->fd == -1) {
-        return;
-    }
+    assert(xive->fd != -1);
 
     ret = kvm_get_one_reg(tctx->cs, KVM_REG_PPC_VP_STATE, state);
     if (ret != 0) {
@@ -156,10 +150,7 @@ void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
     unsigned long vcpu_id;
     int ret;
 
-    /* The KVM XIVE device is not in use */
-    if (xive->fd == -1) {
-        return;
-    }
+    assert(xive->fd != -1);
 
     /* Check if CPU was hot unplugged and replugged. */
     if (kvm_cpu_is_enabled(tctx->cs)) {
@@ -245,10 +236,7 @@ int kvmppc_xive_source_reset_one(XiveSource *xsrc, int srcno, Error **errp)
     SpaprXive *xive = SPAPR_XIVE(xsrc->xive);
     uint64_t state = 0;
 
-    /* The KVM XIVE device is not in use */
-    if (xive->fd == -1) {
-        return -ENODEV;
-    }
+    assert(xive->fd != -1);
 
     if (xive_source_irq_is_lsi(xsrc, srcno)) {
         state |= KVM_XIVE_LEVEL_SENSITIVE;
@@ -592,10 +580,7 @@ static void kvmppc_xive_change_state_handler(void *opaque, int running,
 
 void kvmppc_xive_synchronize_state(SpaprXive *xive, Error **errp)
 {
-    /* The KVM XIVE device is not in use */
-    if (xive->fd == -1) {
-        return;
-    }
+    assert(xive->fd != -1);
 
     /*
      * When the VM is stopped, the sources are masked and the previous
@@ -622,10 +607,7 @@ int kvmppc_xive_pre_save(SpaprXive *xive)
 {
     Error *local_err = NULL;
 
-    /* The KVM XIVE device is not in use */
-    if (xive->fd == -1) {
-        return 0;
-    }
+    assert(xive->fd != -1);
 
     /* EAT: there is no extra state to query from KVM */
 
@@ -845,10 +827,7 @@ void kvmppc_xive_disconnect(SpaprInterruptController *intc)
     XiveSource *xsrc;
     size_t esb_len;
 
-    /* The KVM XIVE device is not in use */
-    if (!xive || xive->fd == -1) {
-        return;
-    }
+    assert(xive->fd != -1);
 
     /* Clear the KVM mapping */
     xsrc = &xive->source;
-- 
2.26.2


