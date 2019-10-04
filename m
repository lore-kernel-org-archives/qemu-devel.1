Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7987FC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 10:28:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 461C5207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 10:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="M5xqBPUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461C5207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGKoo-000867-9v
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 06:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK3R-0006CC-Ut
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:39:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK3Q-0006Ib-Nf
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:39:17 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42411 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iGK3Q-0005z4-C2; Fri, 04 Oct 2019 05:39:16 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46l4YR1VgKz9sSR; Fri,  4 Oct 2019 19:38:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570181883;
 bh=KAjpXK1XJaeXMysUyEuwfLiwnpMGp2yr5NbNM5um/d4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=M5xqBPUaqXaDM9QfsDIdxz4PjU13cm/6p9w3nULjyY73LBn0t5DAswRoJ1ABvWGE5
 yyzrNwSuVYqO265O+bnG9G6WZPLwCfYGkV+GR4ZA5K1tw7hhftnxnw3sIFFm1/C4s5
 XJnp8X2MtRFI58wZAQfW4qBleKFwhQ63RDlLABFA=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 43/53] spapr: Fix indexing of XICS irqs
Date: Fri,  4 Oct 2019 19:37:37 +1000
Message-Id: <20191004093747.31350-44-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191004093747.31350-1-david@gibson.dropbear.id.au>
References: <20191004093747.31350-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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

spapr global irq numbers are different from the source numbers on the ICS
when using XICS - they're offset by XICS_IRQ_BASE (0x1000).  But
spapr_irq_set_irq_xics() was passing through the global irq number to
the ICS code unmodified.

We only got away with this because of a counteracting bug - we were
incorrectly adjusting the qemu_irq we returned for a requested global irq
number.

That approach mostly worked but is very confusing, incorrectly relies on
the way the qemu_irq array is allocated, and undermines the intention of
having the global array of qemu_irqs for spapr have a consistent meaning
regardless of irq backend.

So, fix both set_irq and qemu_irq indexing.  We rename some parameters at
the same time to make it clear that they are referring to spapr global
irq numbers.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_irq.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index cded3a0154..8f79aa829f 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -153,10 +153,9 @@ static void spapr_irq_free_xics(SpaprMachineState *s=
papr, int irq, int num)
 static qemu_irq spapr_qirq_xics(SpaprMachineState *spapr, int irq)
 {
     ICSState *ics =3D spapr->ics;
-    uint32_t srcno =3D irq - ics->offset;
=20
     if (ics_valid_irq(ics, irq)) {
-        return spapr->qirqs[srcno];
+        return spapr->qirqs[irq];
     }
=20
     return NULL;
@@ -204,9 +203,10 @@ static int spapr_irq_post_load_xics(SpaprMachineStat=
e *spapr, int version_id)
     return 0;
 }
=20
-static void spapr_irq_set_irq_xics(void *opaque, int srcno, int val)
+static void spapr_irq_set_irq_xics(void *opaque, int irq, int val)
 {
     SpaprMachineState *spapr =3D opaque;
+    uint32_t srcno =3D irq - spapr->ics->offset;
=20
     ics_set_irq(spapr->ics, srcno, val);
 }
@@ -377,14 +377,14 @@ static void spapr_irq_reset_xive(SpaprMachineState =
*spapr, Error **errp)
     spapr_xive_mmio_set_enabled(spapr->xive, true);
 }
=20
-static void spapr_irq_set_irq_xive(void *opaque, int srcno, int val)
+static void spapr_irq_set_irq_xive(void *opaque, int irq, int val)
 {
     SpaprMachineState *spapr =3D opaque;
=20
     if (kvm_irqchip_in_kernel()) {
-        kvmppc_xive_source_set_irq(&spapr->xive->source, srcno, val);
+        kvmppc_xive_source_set_irq(&spapr->xive->source, irq, val);
     } else {
-        xive_source_set_irq(&spapr->xive->source, srcno, val);
+        xive_source_set_irq(&spapr->xive->source, irq, val);
     }
 }
=20
@@ -558,11 +558,11 @@ static void spapr_irq_reset_dual(SpaprMachineState =
*spapr, Error **errp)
     spapr_irq_current(spapr)->reset(spapr, errp);
 }
=20
-static void spapr_irq_set_irq_dual(void *opaque, int srcno, int val)
+static void spapr_irq_set_irq_dual(void *opaque, int irq, int val)
 {
     SpaprMachineState *spapr =3D opaque;
=20
-    spapr_irq_current(spapr)->set_irq(spapr, srcno, val);
+    spapr_irq_current(spapr)->set_irq(spapr, irq, val);
 }
=20
 static const char *spapr_irq_get_nodename_dual(SpaprMachineState *spapr)
--=20
2.21.0


