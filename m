Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EE0C352AB
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:05:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B154D20863
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ILQC4BU0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B154D20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDjNW-0004U1-Gv
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 02:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iDj9W-0006s9-JP
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 01:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iDj9U-00055R-3x
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 01:50:50 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:41565)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iDj9T-00051B-AM; Fri, 27 Sep 2019 01:50:47 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46fgrF66Pfz9sRK; Fri, 27 Sep 2019 15:50:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569563437;
 bh=JZoGH/PdnTn6YG0PtufiiqBI360xzCsdLvrTTuP4eIs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ILQC4BU0BvV/hkgPCVJKZPnA34z/pM0dmgrq0DY8EUiivl4hmj0SnZATVPW4naePa
 6oQc2f3nMHBAYhlO8YLmr/5t7LxxsCsrgOXkZXwRQgHw2Oedw1QpzcQ7GpcMy2FGvB
 95fsYB8NkyEYo3wswHiC6oFG0E+UiZebX0ZDsgHo=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	clg@kaod.org,
	qemu-ppc@nongnu.org
Subject: [PATCH v2 20/33] spapr, xics,
 xive: Introduce SpaprInterruptController QOM interface
Date: Fri, 27 Sep 2019 15:50:15 +1000
Message-Id: <20190927055028.11493-21-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190927055028.11493-1-david@gibson.dropbear.id.au>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 groug@kaod.org, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The SpaprIrq structure is used to represent ths spapr machine's irq
backend.  Except that it kind of conflates two concepts: one is the
backend proper - a specific interrupt controller that we might or
might not be using, the other is the irq configuration which covers
the layout of irq space and which interrupt controllers are allowed.

This leads to some pretty confusing code paths for the "dual"
configuration where its hooks redirect to other SpaprIrq structures
depending on the currently active irq controller.

To clean this up, we start by introducing a new
SpaprInterruptController QOM interface to represent strictly an
interrupt controller backend, not counting anything configuration
related.  We implement this interface in the XICs and XIVE interrupt
controllers, and in future we'll move relevant methods from SpaprIrq
into it.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive.c       |  4 ++++
 hw/intc/xics_spapr.c       |  4 ++++
 hw/ppc/spapr_irq.c         | 13 +++++++++++++
 include/hw/ppc/spapr_irq.h | 14 ++++++++++++++
 4 files changed, 35 insertions(+)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 04879abf2e..b67e9c3245 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -519,6 +519,10 @@ static const TypeInfo spapr_xive_info =3D {
     .instance_init =3D spapr_xive_instance_init,
     .instance_size =3D sizeof(SpaprXive),
     .class_init =3D spapr_xive_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { TYPE_SPAPR_INTC },
+        { }
+    },
 };
=20
 static void spapr_xive_register_types(void)
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 6e5eb24b3c..4874e6be55 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -343,6 +343,10 @@ static const TypeInfo ics_spapr_info =3D {
     .name =3D TYPE_ICS_SPAPR,
     .parent =3D TYPE_ICS,
     .class_init =3D ics_spapr_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { TYPE_SPAPR_INTC },
+        { }
+    },
 };
=20
 static void xics_spapr_register_types(void)
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 5e448b1fd4..0603c82fe8 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -23,6 +23,12 @@
=20
 #include "trace.h"
=20
+static const TypeInfo spapr_intc_info =3D {
+    .name =3D TYPE_SPAPR_INTC,
+    .parent =3D TYPE_INTERFACE,
+    .class_size =3D sizeof(SpaprInterruptControllerClass),
+};
+
 void spapr_irq_msi_init(SpaprMachineState *spapr, uint32_t nr_msis)
 {
     spapr->irq_map_nr =3D nr_msis;
@@ -763,3 +769,10 @@ SpaprIrq spapr_irq_xics_legacy =3D {
     .set_irq     =3D spapr_irq_set_irq_xics,
     .init_kvm    =3D spapr_irq_init_kvm_xics,
 };
+
+static void spapr_irq_register_types(void)
+{
+    type_register_static(&spapr_intc_info);
+}
+
+type_init(spapr_irq_register_types)
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 69a37f608e..b9398e0be3 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -31,6 +31,20 @@
=20
 typedef struct SpaprMachineState SpaprMachineState;
=20
+typedef struct SpaprInterruptController SpaprInterruptController;
+
+#define TYPE_SPAPR_INTC "spapr-interrupt-controller"
+#define SPAPR_INTC(obj)                                     \
+    INTERFACE_CHECK(SpaprInterruptController, (obj), TYPE_SPAPR_INTC)
+#define SPAPR_INTC_CLASS(klass)                                     \
+    OBJECT_CLASS_CHECK(SpaprInterruptControllerClass, (klass), TYPE_SPAP=
R_INTC)
+#define SPAPR_INTC_GET_CLASS(obj)                                   \
+    OBJECT_GET_CLASS(SpaprInterruptControllerClass, (obj), TYPE_SPAPR_IN=
TC)
+
+typedef struct SpaprInterruptControllerClass {
+    InterfaceClass parent;
+} SpaprInterruptControllerClass;
+
 void spapr_irq_msi_init(SpaprMachineState *spapr, uint32_t nr_msis);
 int spapr_irq_msi_alloc(SpaprMachineState *spapr, uint32_t num, bool ali=
gn,
                         Error **errp);
--=20
2.21.0


