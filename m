Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90878C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1660221D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YWwkeYfu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1660221D7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46191 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD1PR-0002qm-9E
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 03:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iD13p-0008MV-4x
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:46:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iD13n-0003aN-3G
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:46:00 -0400
Received: from ozlabs.org ([203.11.71.1]:58927)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iD13l-0003Vt-8G; Wed, 25 Sep 2019 02:45:58 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46dT8q3pKmz9sR5; Wed, 25 Sep 2019 16:45:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569393947;
 bh=qzWCECiW3SZYCp/MyCzF23lwrQKJGr9u6PHBmtIcAtg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YWwkeYfuOBJBlo0zBanX8iiPKp0U2ptGs7IshxsWWGEUkcvPvXUIIBqWTdrjlXJyL
 uiJs1LVQo8xiOqog6tOJglCEduPQ5fG+4s91GHN3T6piXDewdyM5GTBXe/aKVBisoV
 kx/YTAKDPQ8bAb5Bh4uWvxg0NTiwBzazVwdDDcEk=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-ppc@nongnu.org,
	clg@kaod.org,
	qemu-devel@nongnu.org
Subject: [PATCH 15/20] spapr: Handle freeing of multiple irqs in frontend only
Date: Wed, 25 Sep 2019 16:45:29 +1000
Message-Id: <20190925064534.19155-16-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190925064534.19155-1-david@gibson.dropbear.id.au>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 groug@kaod.org, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

spapr_irq_free() can be used to free multiple irqs at once. That's useful
for its callers, but there's no need to make the individual backend hooks
handle this.  We can loop across the irqs in spapr_irq_free() itself and
have the hooks just do one at time.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_irq.c         | 27 ++++++++++++---------------
 include/hw/ppc/spapr_irq.h |  2 +-
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index db6755f3ab..c40357a985 100644
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
@@ -438,10 +431,10 @@ static int spapr_irq_claim_dual(SpaprMachineState *=
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
@@ -640,7 +633,11 @@ int spapr_irq_claim(SpaprMachineState *spapr, int ir=
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


