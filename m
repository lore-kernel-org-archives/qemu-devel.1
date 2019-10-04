Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83A4C47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 09:44:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7571D207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 09:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Iev88hby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7571D207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGK8G-0002to-V5
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 05:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2H-0004rg-9J
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2F-000542-LM
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:05 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:44225)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iGK2F-0004zu-6U; Fri, 04 Oct 2019 05:38:03 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46l4YG3Q9xz9sR8; Fri,  4 Oct 2019 19:37:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570181874;
 bh=7qmQ0NPe5Pwt53ZjSvHdmIBoaYR9AETfU8EFeGxMU4g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Iev88hbyLbNLGqKDVxVgppkcUr7eohyidw9sXZk85HKojrJJXXTsvVa4KtLwlzgxE
 r/cP3NPe17qjECRXqOh1Dqqz5yCnWPhT5aNI1qROGp1ROrVEMQARyF+9vCt6q90J3y
 YONtyOu0xpDl7C+CXCCvRzJs2PVeDxrc7sum75bs=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 09/53] spapr/irq: Introduce an ics_irq_free() helper
Date: Fri,  4 Oct 2019 19:37:03 +1000
Message-Id: <20191004093747.31350-10-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191004093747.31350-1-david@gibson.dropbear.id.au>
References: <20191004093747.31350-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

It will help us to discard interrupt numbers which have not been
claimed in the next patch.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190911133937.2716-2-clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_irq.c    | 9 +++------
 include/hw/ppc/xics.h | 5 +++++
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 06fe2432ba..d8f46b6797 100644
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
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index f2a8d6a4b4..64a2c8862a 100644
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
--=20
2.21.0


