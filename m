Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742CFC47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:29:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EF9520B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BD8zsfyJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF9520B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIEqT-00017A-Rt
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 12:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iI59d-0001cI-3R
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 02:08:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iI59b-000707-Uq
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 02:08:57 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45821 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iI59b-0006aJ-JZ; Wed, 09 Oct 2019 02:08:55 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46p3gG2hDYz9sRW; Wed,  9 Oct 2019 17:08:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570601306;
 bh=P19XTnLDc5zaBQFC5rg5tlmv5YglHHtbZRWyyk9OMWw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BD8zsfyJoFG9xUBavxd6Ba6ezZv8GfJta6rGmlRFgMzopoY+RkLw4OXk0LA1jWAwX
 YaDahK1VPYebg0KVw4xEwAmLPWIdJXIeCCeu8q8kjhQuIj84Lwo3OCS2kGR7GLBWyn
 L0/OmuZAosCmkdQpYQiGis2vWcYTLjO8zQId+6TI=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	clg@kaod.org,
	qemu-ppc@nongnu.org
Subject: [PATCH v4 19/19] spapr: Work around spurious warnings from vfio INTx
 initialization
Date: Wed,  9 Oct 2019 17:08:18 +1100
Message-Id: <20191009060818.29719-20-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191009060818.29719-1-david@gibson.dropbear.id.au>
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Jason Wang <jasowang@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, groug@kaod.org,
 Laurent Vivier <laurent@vivier.eu>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
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
index 7964e4a1b8..3aeb523f3e 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -274,6 +274,14 @@ void spapr_irq_init(SpaprMachineState *spapr, Error =
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
@@ -429,7 +437,8 @@ void spapr_irq_update_active_intc(SpaprMachineState *=
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
2.21.0


