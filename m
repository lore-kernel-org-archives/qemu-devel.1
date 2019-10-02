Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CDAECE587
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 03:09:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7029620B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 03:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="JKRgt1VB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7029620B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFV1G-0001Yb-AN
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 23:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59907)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iFUkp-0001g4-2L
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 22:52:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iFUkl-0002uL-6G
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 22:52:38 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:39019)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iFUkk-0002po-Da; Tue, 01 Oct 2019 22:52:34 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46jgf826WZz9sRQ; Wed,  2 Oct 2019 12:52:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569984736;
 bh=Wye/qEPS8JlbxvZNXB3cl6mwul/+AF68CA7+4TAPj1c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JKRgt1VBPWAToOvQttyaYjprHL+OEZ/+Q9gCdNyRaI6I6h4aQp80KyRIF7qrg/scq
 sJIiW15F46t4Uvw67jLjgMyAETJSr3R0es3YoGWa1LP76UHVOsQdcirVdZz1C9sHyg
 kFdljDHbz1vav2MpepUJsYug4ggD8060Q2Z3AaT4=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-ppc@nongnu.org,
	clg@kaod.org,
	qemu-devel@nongnu.org
Subject: [PATCH v3 16/34] spapr, xics,
 xive: Better use of assert()s on irq claim/free paths
Date: Wed,  2 Oct 2019 12:51:50 +1000
Message-Id: <20191002025208.3487-17-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191002025208.3487-1-david@gibson.dropbear.id.au>
References: <20191002025208.3487-1-david@gibson.dropbear.id.au>
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, groug@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The irq claim and free paths for both XICS and XIVE check for some
validity conditions.  Some of these represent genuine runtime failures,
however others - particularly checking that the basic irq number is in a
sane range - could only fail in the case of bugs in the callin code.
Therefore use assert()s instead of runtime failures for those.

In addition the non backend-specific part of the claim/free paths should
only be used for PAPR external irqs, that is in the range SPAPR_XIRQ_BASE
to the maximum irq number.  Put assert()s for that into the top level
dispatchers as well.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/spapr_xive.c |  8 ++------
 hw/ppc/spapr_irq.c   | 18 ++++++++++--------
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index c1c97192a7..47b5ec0b56 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -532,9 +532,7 @@ bool spapr_xive_irq_claim(SpaprXive *xive, uint32_t l=
isn, bool lsi)
 {
     XiveSource *xsrc =3D &xive->source;
=20
-    if (lisn >=3D xive->nr_irqs) {
-        return false;
-    }
+    assert(lisn < xive->nr_irqs);
=20
     /*
      * Set default values when allocating an IRQ number
@@ -559,9 +557,7 @@ bool spapr_xive_irq_claim(SpaprXive *xive, uint32_t l=
isn, bool lsi)
=20
 bool spapr_xive_irq_free(SpaprXive *xive, uint32_t lisn)
 {
-    if (lisn >=3D xive->nr_irqs) {
-        return false;
-    }
+    assert(lisn < xive->nr_irqs);
=20
     xive->eat[lisn].w &=3D cpu_to_be64(~EAS_VALID);
     return true;
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index d2ac35bbe1..025c802e7b 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -118,11 +118,7 @@ static int spapr_irq_claim_xics(SpaprMachineState *s=
papr, int irq, bool lsi,
     ICSState *ics =3D spapr->ics;
=20
     assert(ics);
-
-    if (!ics_valid_irq(ics, irq)) {
-        error_setg(errp, "IRQ %d is invalid", irq);
-        return -1;
-    }
+    assert(ics_valid_irq(ics, irq));
=20
     if (!ics_irq_free(ics, irq - ics->offset)) {
         error_setg(errp, "IRQ %d is not free", irq);
@@ -138,9 +134,9 @@ static void spapr_irq_free_xics(SpaprMachineState *sp=
apr, int irq)
     ICSState *ics =3D spapr->ics;
     uint32_t srcno =3D irq - ics->offset;
=20
-    if (ics_valid_irq(ics, irq)) {
-        memset(&ics->irqs[srcno], 0, sizeof(ICSIRQState));
-    }
+    assert(ics_valid_irq(ics, irq));
+
+    memset(&ics->irqs[srcno], 0, sizeof(ICSIRQState));
 }
=20
 static void spapr_irq_print_info_xics(SpaprMachineState *spapr, Monitor =
*mon)
@@ -623,6 +619,9 @@ void spapr_irq_init(SpaprMachineState *spapr, Error *=
*errp)
=20
 int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error *=
*errp)
 {
+    assert(irq >=3D SPAPR_XIRQ_BASE);
+    assert(irq < (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));
+
     return spapr->irq->claim(spapr, irq, lsi, errp);
 }
=20
@@ -630,6 +629,9 @@ void spapr_irq_free(SpaprMachineState *spapr, int irq=
, int num)
 {
     int i;
=20
+    assert(irq >=3D SPAPR_XIRQ_BASE);
+    assert((irq + num) <=3D (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));
+
     for (i =3D irq; i < (irq + num); i++) {
         spapr->irq->free(spapr, i);
     }
--=20
2.21.0


