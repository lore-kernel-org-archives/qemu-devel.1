Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D983FC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A7E1206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nz3DZOYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7E1206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7tJh-0006gE-R2
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 00:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t6c-0008VH-JT; Tue, 18 Aug 2020 00:20:14 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48627 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t6a-0006Oj-BS; Tue, 18 Aug 2020 00:20:14 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BVyNf2jZfz9sVm; Tue, 18 Aug 2020 14:19:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597724370;
 bh=1fY7gsMnGeqZ/lY92mpYJITNA+piIKuRjGuAk/i1iQ0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nz3DZOYfB8c4GPc24FZLfrRYFknolmy5sA+/ojUJq1y/co93W2RnIL8iOCPkgBToT
 tL07YGsEr41wM2eQGVW5N9Zix1PtBxjHcacFFFGZw7O32TYkTMkmDq8KB1XQpUcvhp
 E8qTLHH4YlbN0JQjwiNGFGgSqwEJeC6BHYD3I35g=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org,
	groug@kaod.org
Subject: [PULL 26/40] spapr/xive: Rework error handling of
 kvmppc_xive_cpu_connect()
Date: Tue, 18 Aug 2020 14:19:08 +1000
Message-Id: <20200818041922.251708-27-david@gibson.dropbear.id.au>
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

Use error_setg_errno() instead of error_setg(strerror()). While here,
use -ret instead of errno since kvm_vcpu_enable_cap() returns a negative
errno on failure.

Use ERRP_GUARD() to ensure that errp can be passed to error_append_hint(),
and get rid of the local_err boilerplate.

Propagate the return value so that callers may use it as well to check
failures.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <159707844549.1489912.4862921680328017645.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive_kvm.c | 21 ++++++++++-----------
 include/hw/ppc/xive.h    |  2 +-
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 82a6f99f02..aa1a2f9153 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -144,8 +144,9 @@ void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp)
     }
 }
 
-void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
+int kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
 {
+    ERRP_GUARD();
     SpaprXive *xive = SPAPR_XIVE(tctx->xptr);
     unsigned long vcpu_id;
     int ret;
@@ -154,7 +155,7 @@ void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
 
     /* Check if CPU was hot unplugged and replugged. */
     if (kvm_cpu_is_enabled(tctx->cs)) {
-        return;
+        return 0;
     }
 
     vcpu_id = kvm_arch_vcpu_id(tctx->cs);
@@ -162,20 +163,18 @@ void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
     ret = kvm_vcpu_enable_cap(tctx->cs, KVM_CAP_PPC_IRQ_XIVE, 0, xive->fd,
                               vcpu_id, 0);
     if (ret < 0) {
-        Error *local_err = NULL;
-
-        error_setg(&local_err,
-                   "XIVE: unable to connect CPU%ld to KVM device: %s",
-                   vcpu_id, strerror(errno));
-        if (errno == ENOSPC) {
-            error_append_hint(&local_err, "Try -smp maxcpus=N with N < %u\n",
+        error_setg_errno(errp, -ret,
+                         "XIVE: unable to connect CPU%ld to KVM device",
+                         vcpu_id);
+        if (ret == -ENOSPC) {
+            error_append_hint(errp, "Try -smp maxcpus=N with N < %u\n",
                               MACHINE(qdev_get_machine())->smp.max_cpus);
         }
-        error_propagate(errp, local_err);
-        return;
+        return ret;
     }
 
     kvm_cpu_enable(tctx->cs);
+    return 0;
 }
 
 /*
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 2f3c5af810..2d87ed4372 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -487,7 +487,7 @@ void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb);
 
 int kvmppc_xive_source_reset_one(XiveSource *xsrc, int srcno, Error **errp);
 void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val);
-void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp);
+int kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp);
 void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp);
 void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp);
 void kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **errp);
-- 
2.26.2


