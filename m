Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B3BC43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:08:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B91DC206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ATEStrUI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91DC206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39887 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJu2Z-00078t-U8
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 02:08:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0T-0005Mx-Qk
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0S-0004Gv-Nz
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:45 -0400
Received: from ozlabs.org ([203.11.71.1]:45171)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hJu0R-00042T-5z; Fri, 26 Apr 2019 02:06:44 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44r3Tk1kmRz9s9N; Fri, 26 Apr 2019 16:06:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1556258794;
	bh=6Ag/QVok6X8QbcCfqfvcwtXbf9oCeHbgRVcFV9il+Ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ATEStrUI4np4kfJK1xz36/2v9iDvOC7GFFREwl2ubJNeFFfV8kbFD0AeCTppK/fm9
	sie8C52YNnR3NvDJPiFO//m07DfXb1vdol+Lnixlwg4jWVeCaGRMXUAePRbC2U456x
	ComzIwN8o7znq3OxpCwlL2D7aXGo31mXlLiN788c=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Fri, 26 Apr 2019 16:05:55 +1000
Message-Id: <20190426060627.18153-5-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 04/36] spapr/irq: remove spapr_ics_create()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: gkurz@kaod.org, David Gibson <david@gibson.dropbear.id.au>,
	qemu-ppc@nongnu.org, clg@kaod.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426060555.tgl73psf1kGKtkTUwnzKziEoqF_jHJ0A3P4W5yfBuvY@z>

From: C=C3=A9dric Le Goater <clg@kaod.org>

spapr_ics_create() is only called once. Merge it in spapr_irq_init_xics()
and simplify a bit the error handling by using 'error_fatal' .

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190321144914.19934-13-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_irq.c | 44 ++++++++++++++------------------------------
 1 file changed, 14 insertions(+), 30 deletions(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 0a84e4cf63..b1f79ea9de 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -67,36 +67,11 @@ void spapr_irq_msi_reset(SpaprMachineState *spapr)
  * XICS IRQ backend.
  */
=20
-static ICSState *spapr_ics_create(SpaprMachineState *spapr,
-                                  int nr_irqs, Error **errp)
-{
-    Error *local_err =3D NULL;
-    Object *obj;
-
-    obj =3D object_new(TYPE_ICS_SIMPLE);
-    object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
-    object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
-                                   &error_abort);
-    object_property_set_int(obj, nr_irqs, "nr-irqs", &local_err);
-    if (local_err) {
-        goto error;
-    }
-    object_property_set_bool(obj, true, "realized", &local_err);
-    if (local_err) {
-        goto error;
-    }
-
-    return ICS_BASE(obj);
-
-error:
-    error_propagate(errp, local_err);
-    return NULL;
-}
-
 static void spapr_irq_init_xics(SpaprMachineState *spapr, int nr_irqs,
                                 Error **errp)
 {
     MachineState *machine =3D MACHINE(spapr);
+    Object *obj;
     Error *local_err =3D NULL;
     bool xics_kvm =3D false;
=20
@@ -108,7 +83,8 @@ static void spapr_irq_init_xics(SpaprMachineState *spa=
pr, int nr_irqs,
         if (machine_kernel_irqchip_required(machine) && !xics_kvm) {
             error_prepend(&local_err,
                           "kernel_irqchip requested but unavailable: ");
-            goto error;
+            error_propagate(errp, local_err);
+            return;
         }
         error_free(local_err);
         local_err =3D NULL;
@@ -118,10 +94,18 @@ static void spapr_irq_init_xics(SpaprMachineState *s=
papr, int nr_irqs,
         xics_spapr_init(spapr);
     }
=20
-    spapr->ics =3D spapr_ics_create(spapr, nr_irqs, &local_err);
+    obj =3D object_new(TYPE_ICS_SIMPLE);
+    object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
+    object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
+                                   &error_fatal);
+    object_property_set_int(obj, nr_irqs, "nr-irqs",  &error_fatal);
+    object_property_set_bool(obj, true, "realized", &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
=20
-error:
-    error_propagate(errp, local_err);
+    spapr->ics =3D ICS_BASE(obj);
 }
=20
 #define ICS_IRQ_FREE(ics, srcno)   \
--=20
2.20.1


