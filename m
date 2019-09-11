Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9235C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 13:41:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EE3D20863
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 13:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE3D20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i82sE-0000Wd-Jr
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 09:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1i82qn-0007bY-8S
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:40:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1i82qm-0006QN-4H
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:40:01 -0400
Received: from 19.mo1.mail-out.ovh.net ([178.32.97.206]:54793)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1i82ql-0006Pc-VH
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:40:00 -0400
Received: from player792.ha.ovh.net (unknown [10.109.146.122])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 50B0C18D526
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 15:39:58 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player792.ha.ovh.net (Postfix) with ESMTPSA id 661879C4DEE8;
 Wed, 11 Sep 2019 13:39:51 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 11 Sep 2019 15:39:36 +0200
Message-Id: <20190911133937.2716-2-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190911133937.2716-1-clg@kaod.org>
References: <20190911133937.2716-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 17955288766735289318
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrtdefgdegtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.97.206
Subject: [Qemu-devel] [PATCH v2 1/2] spapr/irq: Introduce an ics_irq_free()
 helper
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
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It will help us to discard interrupt numbers which have not been
claimed in the next patch.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xics.h | 5 +++++
 hw/ppc/spapr_irq.c    | 9 +++------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index f2a8d6a4b4f9..64a2c8862a72 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -179,6 +179,11 @@ void ics_simple_write_xive(ICSState *ics, int nr, in=
t server,
                            uint8_t priority, uint8_t saved_priority);
 void ics_simple_set_irq(void *opaque, int srcno, int val);
=20
+static inline bool ics_irq_free(ICSState *ics, uint32_t srcno)
+{
+    return !(ics->irqs[srcno].flags & XICS_FLAGS_IRQ_MASK);
+}
+
 void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
 void icp_pic_print_info(ICPState *icp, Monitor *mon);
 void ics_pic_print_info(ICSState *ics, Monitor *mon);
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 06fe2432bae5..d8f46b6797f8 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -114,9 +114,6 @@ static void spapr_irq_init_xics(SpaprMachineState *sp=
apr, int nr_irqs,
     xics_spapr_init(spapr);
 }
=20
-#define ICS_IRQ_FREE(ics, srcno)   \
-    (!((ics)->irqs[(srcno)].flags & (XICS_FLAGS_IRQ_MASK)))
-
 static int spapr_irq_claim_xics(SpaprMachineState *spapr, int irq, bool =
lsi,
                                 Error **errp)
 {
@@ -129,7 +126,7 @@ static int spapr_irq_claim_xics(SpaprMachineState *sp=
apr, int irq, bool lsi,
         return -1;
     }
=20
-    if (!ICS_IRQ_FREE(ics, irq - ics->offset)) {
+    if (!ics_irq_free(ics, irq - ics->offset)) {
         error_setg(errp, "IRQ %d is not free", irq);
         return -1;
     }
@@ -147,7 +144,7 @@ static void spapr_irq_free_xics(SpaprMachineState *sp=
apr, int irq, int num)
     if (ics_valid_irq(ics, irq)) {
         trace_spapr_irq_free(0, irq, num);
         for (i =3D srcno; i < srcno + num; ++i) {
-            if (ICS_IRQ_FREE(ics, i)) {
+            if (ics_irq_free(ics, i)) {
                 trace_spapr_irq_free_warn(0, i);
             }
             memset(&ics->irqs[i], 0, sizeof(ICSIRQState));
@@ -767,7 +764,7 @@ static int ics_find_free_block(ICSState *ics, int num=
, int alignnum)
             return -1;
         }
         for (i =3D first; i < first + num; ++i) {
-            if (!ICS_IRQ_FREE(ics, i)) {
+            if (!ics_irq_free(ics, i)) {
                 break;
             }
         }
--=20
2.21.0


