Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073F9C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:00:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C609420872
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="aPvCqwum"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C609420872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDjIl-0000L3-3B
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 02:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iDj9V-0006px-6N
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 01:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iDj9T-00053i-4B
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 01:50:48 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:32783)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iDj9S-00050o-JJ; Fri, 27 Sep 2019 01:50:46 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46fgrF2DRcz9sR8; Fri, 27 Sep 2019 15:50:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569563437;
 bh=bhSwqceFFZud22ocBvY1ARrAtt9EQB3ydAXlu/7z83g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aPvCqwum/uYyCJB1bahe1rG0d/zUSDbq0F14iMcT1bI5+A1WT/1Qn5SRTQhiEgCNX
 NQHm+p4KtPxmcIK6+OpO5SxTE99NtPrQwZrVxav/oIbTx/gPQ2AFSpemWzMHvtLOIt
 yTTJMt7UYjA5OdZF71AjXgQD6aSZB5rK+ZbRT3jY=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	clg@kaod.org,
	qemu-ppc@nongnu.org
Subject: [PATCH v2 15/33] spapr: Handle freeing of multiple irqs in frontend
 only
Date: Fri, 27 Sep 2019 15:50:10 +1000
Message-Id: <20190927055028.11493-16-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190927055028.11493-1-david@gibson.dropbear.id.au>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
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
 groug@kaod.org, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

spapr_irq_free() can be used to free multiple irqs at once. That's useful
for its callers, but there's no need to make the individual backend hooks
handle this.  We can loop across the irqs in spapr_irq_free() itself and
have the hooks just do one at time.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_irq.c         | 27 ++++++++++++---------------
 include/hw/ppc/spapr_irq.h |  2 +-
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 9919910a86..37c51c96ae 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -133,16 +133,13 @@ static int spapr_irq_claim_xics(SpaprMachineState *=
spapr, int irq, bool lsi,
     return 0;
 }
=20
-static void spapr_irq_free_xics(SpaprMachineState *spapr, int irq, int n=
um)
+static void spapr_irq_free_xics(SpaprMachineState *spapr, int irq)
 {
     ICSState *ics =3D spapr->ics;
     uint32_t srcno =3D irq - ics->offset;
-    int i;
=20
     if (ics_valid_irq(ics, irq)) {
-        for (i =3D srcno; i < srcno + num; ++i) {
-            memset(&ics->irqs[i], 0, sizeof(ICSIRQState));
-        }
+        memset(&ics->irqs[srcno], 0, sizeof(ICSIRQState));
     }
 }
=20
@@ -269,13 +266,9 @@ static int spapr_irq_claim_xive(SpaprMachineState *s=
papr, int irq, bool lsi,
     return 0;
 }
=20
-static void spapr_irq_free_xive(SpaprMachineState *spapr, int irq, int n=
um)
+static void spapr_irq_free_xive(SpaprMachineState *spapr, int irq)
 {
-    int i;
-
-    for (i =3D irq; i < irq + num; ++i) {
-        spapr_xive_irq_free(spapr->xive, i);
-    }
+    spapr_xive_irq_free(spapr->xive, irq);
 }
=20
 static void spapr_irq_print_info_xive(SpaprMachineState *spapr,
@@ -433,10 +426,10 @@ static int spapr_irq_claim_dual(SpaprMachineState *=
spapr, int irq, bool lsi,
     return ret;
 }
=20
-static void spapr_irq_free_dual(SpaprMachineState *spapr, int irq, int n=
um)
+static void spapr_irq_free_dual(SpaprMachineState *spapr, int irq)
 {
-    spapr_irq_xics.free(spapr, irq, num);
-    spapr_irq_xive.free(spapr, irq, num);
+    spapr_irq_xics.free(spapr, irq);
+    spapr_irq_xive.free(spapr, irq);
 }
=20
 static void spapr_irq_print_info_dual(SpaprMachineState *spapr, Monitor =
*mon)
@@ -635,7 +628,11 @@ int spapr_irq_claim(SpaprMachineState *spapr, int ir=
q, bool lsi, Error **errp)
=20
 void spapr_irq_free(SpaprMachineState *spapr, int irq, int num)
 {
-    spapr->irq->free(spapr, irq, num);
+    int i;
+
+    for (i =3D irq; i < (irq + num); i++) {
+        spapr->irq->free(spapr, irq);
+    }
 }
=20
 qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq)
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 9b60378e28..ed88b4599a 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -43,7 +43,7 @@ typedef struct SpaprIrq {
=20
     void (*init)(SpaprMachineState *spapr, Error **errp);
     int (*claim)(SpaprMachineState *spapr, int irq, bool lsi, Error **er=
rp);
-    void (*free)(SpaprMachineState *spapr, int irq, int num);
+    void (*free)(SpaprMachineState *spapr, int irq);
     void (*print_info)(SpaprMachineState *spapr, Monitor *mon);
     void (*dt_populate)(SpaprMachineState *spapr, uint32_t nr_servers,
                         void *fdt, uint32_t phandle);
--=20
2.21.0


