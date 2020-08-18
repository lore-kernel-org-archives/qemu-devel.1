Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DECC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:29:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A758207BB
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BRWsQzFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A758207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7tFO-0008LX-IG
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 00:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t6D-0007aO-Me; Tue, 18 Aug 2020 00:19:49 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35941 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t6B-0006Mx-7i; Tue, 18 Aug 2020 00:19:49 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BVyNc1ZwYz9sRK; Tue, 18 Aug 2020 14:19:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597724368;
 bh=6HX359pDH9E5Ws1o3UwRlX/kLzA+QilZAfwnA0x4H1k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BRWsQzFPIysHs6RDu4ED3pIJE7gDO6CPDKS79i8CeUbOHIV3CeLZ/2tOKP8PEFOuJ
 cb7EMNlg1r0Q93I0dnmKAIQoPN2EJjhRqV3cAu8+LLRHy4WK2AcFWan82pF+5ruqbc
 AplqYaJ63sw1VqZiHMyoW+XP5xaFo+UYG+tfs5Z8=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org,
	groug@kaod.org
Subject: [PULL 18/40] spapr: Clarify error and documentation for broken KVM
 XICS
Date: Tue, 18 Aug 2020 14:19:00 +1000
Message-Id: <20200818041922.251708-19-david@gibson.dropbear.id.au>
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
Cc: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

When starting an L2 KVM guest with `ic-mode=dual,kernel-irqchip=on`,
QEMU fails with:

KVM is too old to support ic-mode=dual,kernel-irqchip=on

This error message was introduced to detect older KVM versions that
didn't allow destruction and re-creation of the XICS KVM device that
we do at reboot. But it is actually the same issue that we get with
nested guests : when running under pseries, KVM currently provides
a genuine XICS device (not the XICS-on-XIVE device that we get
under powernv) which doesn't support destruction/re-creation.

This will eventually be fixed in KVM but in the meantime, update
the error message and documentation to mention the nested case.
While here, mention that in "No XIVE support in KVM" section that
this can also happen with "guest OSes supporting XIVE" since
we check this at init time before starting the guest.

Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Buglink: https://bugs.launchpad.net/qemu/+bug/1890290
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <159664243614.622889.18307368735989783528.stgit@bahia.lan>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 docs/specs/ppc-spapr-xive.rst |  5 ++++-
 hw/ppc/spapr_irq.c            | 12 +++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/docs/specs/ppc-spapr-xive.rst b/docs/specs/ppc-spapr-xive.rst
index 7199db730b..7144347560 100644
--- a/docs/specs/ppc-spapr-xive.rst
+++ b/docs/specs/ppc-spapr-xive.rst
@@ -126,6 +126,9 @@ xics            XICS KVM       XICS emul.     XICS KVM
 
 (1) QEMU warns with ``warning: kernel_irqchip requested but unavailable:
     IRQ_XIVE capability must be present for KVM``
+    In some cases (old host kernels or KVM nested guests), one may hit a
+    QEMU/KVM incompatibility due to device destruction in reset. QEMU fails
+    with ``KVM is incompatible with ic-mode=dual,kernel-irqchip=on``
 (2) QEMU fails with ``kernel_irqchip requested but unavailable:
     IRQ_XIVE capability must be present for KVM``
 
@@ -148,7 +151,7 @@ xics            XICS KVM       XICS emul.     XICS KVM
     mode (XICS), either don't set the ic-mode machine property or try
     ic-mode=xics or ic-mode=dual``
 (4) QEMU/KVM incompatibility due to device destruction in reset. QEMU fails
-    with ``KVM is too old to support ic-mode=dual,kernel-irqchip=on``
+    with ``KVM is incompatible with ic-mode=dual,kernel-irqchip=on``
 
 
 XIVE Device tree properties
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 2f8f7d62f8..72bb938375 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -139,6 +139,7 @@ SpaprIrq spapr_irq_dual = {
 
 static int spapr_irq_check(SpaprMachineState *spapr, Error **errp)
 {
+    ERRP_GUARD();
     MachineState *machine = MACHINE(spapr);
 
     /*
@@ -179,14 +180,19 @@ static int spapr_irq_check(SpaprMachineState *spapr, Error **errp)
 
     /*
      * On a POWER9 host, some older KVM XICS devices cannot be destroyed and
-     * re-created. Detect that early to avoid QEMU to exit later when the
-     * guest reboots.
+     * re-created. Same happens with KVM nested guests. Detect that early to
+     * avoid QEMU to exit later when the guest reboots.
      */
     if (kvm_enabled() &&
         spapr->irq == &spapr_irq_dual &&
         kvm_kernel_irqchip_required() &&
         xics_kvm_has_broken_disconnect(spapr)) {
-        error_setg(errp, "KVM is too old to support ic-mode=dual,kernel-irqchip=on");
+        error_setg(errp,
+            "KVM is incompatible with ic-mode=dual,kernel-irqchip=on");
+        error_append_hint(errp,
+            "This can happen with an old KVM or in a KVM nested guest.\n");
+        error_append_hint(errp,
+            "Try without kernel-irqchip or with kernel-irqchip=off.\n");
         return -1;
     }
 
-- 
2.26.2


