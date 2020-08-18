Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC48C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:35:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16DF8206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="A0v1hKrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16DF8206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7tLg-0002Hq-8w
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 00:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t6d-00005a-56; Tue, 18 Aug 2020 00:20:15 -0400
Received: from ozlabs.org ([203.11.71.1]:58825)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t6a-0006Oh-AT; Tue, 18 Aug 2020 00:20:14 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BVyNf0vsjz9sVl; Tue, 18 Aug 2020 14:19:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597724370;
 bh=1da+r63XMtfDKfovfHV2ixQ8/lrIVVmvb8+ZRQhBjuc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=A0v1hKrhYwcsiNQ+fm17n7pDcN14Qum9N/UtgU5n4cqMXgJVeZdDK6CTQ9XA6B/6w
 fGM7mYBc1V643oW7MBpJaPRyg8Qt0PbZOzBawmXxiY+lDloIHQaXQSqvkCMonP310m
 o3I4iCiT3ngeLO1w6byi45/5XTVnoImkBujak3IU=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org,
	groug@kaod.org
Subject: [PULL 25/40] spapr: Simplify error handling in spapr_phb_realize()
Date: Tue, 18 Aug 2020 14:19:07 +1000
Message-Id: <20200818041922.251708-26-david@gibson.dropbear.id.au>
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

The spapr_phb_realize() function has a local_err variable which
is used to:

1) check failures of spapr_irq_findone() and spapr_irq_claim()

2) prepend extra information to the error message

Recent work from Markus Armbruster highlighted we get better
code when testing the return value of a function, rather than
setting up all the local_err boiler plate. For similar reasons,
it is now preferred to use ERRP_GUARD() and error_prepend()
rather than error_propagate_prepend().

Since spapr_irq_findone() and spapr_irq_claim() return negative
values in case of failure, do both changes.

This is just cleanup, no functional impact.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <159707843851.1489912.6108405733810934642.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 363cdb3f7b..0a418f1e67 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1796,6 +1796,7 @@ static void spapr_phb_destroy_msi(gpointer opaque)
 
 static void spapr_phb_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_GUARD();
     /* We don't use SPAPR_MACHINE() in order to exit gracefully if the user
      * tries to add a sPAPR PHB to a non-pseries machine.
      */
@@ -1813,7 +1814,6 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     uint64_t msi_window_size = 4096;
     SpaprTceTable *tcet;
     const unsigned windows_supported = spapr_phb_windows_supported(sphb);
-    Error *local_err = NULL;
 
     if (!spapr) {
         error_setg(errp, TYPE_SPAPR_PCI_HOST_BRIDGE " needs a pseries machine");
@@ -1964,13 +1964,12 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
 
     /* Initialize the LSI table */
     for (i = 0; i < PCI_NUM_PINS; i++) {
-        uint32_t irq = SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS + i;
+        int irq = SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS + i;
 
         if (smc->legacy_irq_allocation) {
-            irq = spapr_irq_findone(spapr, &local_err);
-            if (local_err) {
-                error_propagate_prepend(errp, local_err,
-                                        "can't allocate LSIs: ");
+            irq = spapr_irq_findone(spapr, errp);
+            if (irq < 0) {
+                error_prepend(errp, "can't allocate LSIs: ");
                 /*
                  * Older machines will never support PHB hotplug, ie, this is an
                  * init only path and QEMU will terminate. No need to rollback.
@@ -1979,9 +1978,8 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
             }
         }
 
-        spapr_irq_claim(spapr, irq, true, &local_err);
-        if (local_err) {
-            error_propagate_prepend(errp, local_err, "can't allocate LSIs: ");
+        if (spapr_irq_claim(spapr, irq, true, errp) < 0) {
+            error_prepend(errp, "can't allocate LSIs: ");
             goto unrealize;
         }
 
-- 
2.26.2


