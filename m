Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844F8C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 01:00:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51EEA20730
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 01:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="d5Yl8X8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51EEA20730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXapa-0002ug-1L
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 20:00:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iXao5-0001Qf-Rj
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 19:58:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iXao4-0001s0-Fe
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 19:58:49 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:57659 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iXao4-0001r2-51; Wed, 20 Nov 2019 19:58:48 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47JLm43p1Sz9sQp; Thu, 21 Nov 2019 11:58:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574297924;
 bh=kjLCHlKyKt7jP0NFe7tI8vqbJnysCqs9Js2O7NlIAAQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=d5Yl8X8jt5f6X3VYPrSZIeC4Sr8ahHtnfT9r4tRoBX95XiR92/bUGI6IPEAELp+p/
 gj4PkS/PiYEpGg2AlbgHsnkezWv9MlYEin1RnA0QOdA8ICddY5MvLGDgMhrae1DmfQ
 tN1PBz0gCD0y8oOnF1ZySK7+BH5GU5e+myP++TYw=
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex Williamson <alex.williamson@redhat.com>,
	clg@kaod.org
Subject: [PATCH 5/5] spapr: Work around spurious warnings from vfio INTx
 initialization
Date: Thu, 21 Nov 2019 11:56:07 +1100
Message-Id: <20191121005607.274347-6-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121005607.274347-1-david@gibson.dropbear.id.au>
References: <20191121005607.274347-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
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
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, groug@kaod.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Traditional PCI INTx for vfio devices can only perform well if using
an in-kernel irqchip.  Therefore, vfio_intx_update() issues a warning
if an in kernel irqchip is not available.

We usually do have an in-kernel irqchip available for pseries machines
on POWER hosts.  However, because the platform allows feature
negotiation of what interrupt controller model to use, we don't
currently initialize it until machine reset.  vfio_intx_update() is
called (first) from vfio_realize() before that, so it can issue a
spurious warning, even if we will have an in kernel irqchip by the
time we need it.

To workaround this, make a call to spapr_irq_update_active_intc() from
spapr_irq_init() which is called at machine realize time, before the
vfio realize.  This call will be pretty much obsoleted by the later
call at reset time, but it serves to suppress the spurious warning
from VFIO.

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_irq.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 1d27034962..d6bb7fd2d6 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -373,6 +373,14 @@ void spapr_irq_init(SpaprMachineState *spapr, Error =
**errp)
=20
     spapr->qirqs =3D qemu_allocate_irqs(spapr_set_irq, spapr,
                                       smc->nr_xirqs + SPAPR_XIRQ_BASE);
+
+    /*
+     * Mostly we don't actually need this until reset, except that not
+     * having this set up can cause VFIO devices to issue a
+     * false-positive warning during realize(), because they don't yet
+     * have an in-kernel irq chip.
+     */
+    spapr_irq_update_active_intc(spapr);
 }
=20
 int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error *=
*errp)
@@ -528,7 +536,8 @@ void spapr_irq_update_active_intc(SpaprMachineState *=
spapr)
          * this.
          */
         new_intc =3D SPAPR_INTC(spapr->xive);
-    } else if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+    } else if (spapr->ov5_cas
+               && spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
         new_intc =3D SPAPR_INTC(spapr->xive);
     } else {
         new_intc =3D SPAPR_INTC(spapr->ics);
--=20
2.23.0


