Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDD0C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:20:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9BE72183E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9BE72183E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53714 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbpsX-0006Lm-5k
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 13:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53943)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hbphH-0005sJ-7Y
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:09:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hbpYK-0007Sd-8J
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 12:59:49 -0400
Received: from 1.mo69.mail-out.ovh.net ([178.33.251.173]:38721)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hbpYI-0007Qb-W8
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 12:59:47 -0400
Received: from player692.ha.ovh.net (unknown [10.108.35.103])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id A3BC15C856
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 18:59:44 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player692.ha.ovh.net (Postfix) with ESMTPSA id B6B616DB37F1;
 Fri, 14 Jun 2019 16:59:38 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 14 Jun 2019 18:59:20 +0200
Message-Id: <20190614165920.12670-3-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190614165920.12670-1-clg@kaod.org>
References: <20190614165920.12670-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 15168123545457298406
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudeiuddguddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.251.173
Subject: [Qemu-devel] [PATCH 2/2] spapr/xive: simplify
 spapr_irq_init_device() to remove the emulated init
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The init_emu() handles are now empty. Remove them and rename
spapr_irq_init_device() to spapr_irq_init_kvm().

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr_irq.h |  1 -
 hw/ppc/spapr_irq.c         | 20 +++-----------------
 2 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 14cab73c9c07..f965a58f8954 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -48,7 +48,6 @@ typedef struct SpaprIrq {
     void (*reset)(SpaprMachineState *spapr, Error **errp);
     void (*set_irq)(void *opaque, int srcno, int val);
     const char *(*get_nodename)(SpaprMachineState *spapr);
-    void (*init_emu)(SpaprMachineState *spapr, Error **errp);
     void (*init_kvm)(SpaprMachineState *spapr, Error **errp);
 } SpaprIrq;
=20
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 73e6f10da165..84b9b32fe40f 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -62,7 +62,7 @@ void spapr_irq_msi_reset(SpaprMachineState *spapr)
     bitmap_clear(spapr->irq_map, 0, spapr->irq_map_nr);
 }
=20
-static void spapr_irq_init_device(SpaprMachineState *spapr,
+static void spapr_irq_init_kvm(SpaprMachineState *spapr,
                                   SpaprIrq *irq, Error **errp)
 {
     MachineState *machine =3D MACHINE(spapr);
@@ -88,8 +88,6 @@ static void spapr_irq_init_device(SpaprMachineState *sp=
apr,
         error_prepend(&local_err, "kernel_irqchip allowed but unavailabl=
e: ");
         warn_report_err(local_err);
     }
-
-    irq->init_emu(spapr, errp);
 }
=20
 /*
@@ -224,7 +222,7 @@ static void spapr_irq_reset_xics(SpaprMachineState *s=
papr, Error **errp)
 {
     Error *local_err =3D NULL;
=20
-    spapr_irq_init_device(spapr, &spapr_irq_xics, &local_err);
+    spapr_irq_init_kvm(spapr, &spapr_irq_xics, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -236,10 +234,6 @@ static const char *spapr_irq_get_nodename_xics(Spapr=
MachineState *spapr)
     return XICS_NODENAME;
 }
=20
-static void spapr_irq_init_emu_xics(SpaprMachineState *spapr, Error **er=
rp)
-{
-}
-
 static void spapr_irq_init_kvm_xics(SpaprMachineState *spapr, Error **er=
rp)
 {
     if (kvm_enabled()) {
@@ -267,7 +261,6 @@ SpaprIrq spapr_irq_xics =3D {
     .reset       =3D spapr_irq_reset_xics,
     .set_irq     =3D spapr_irq_set_irq_xics,
     .get_nodename =3D spapr_irq_get_nodename_xics,
-    .init_emu    =3D spapr_irq_init_emu_xics,
     .init_kvm    =3D spapr_irq_init_kvm_xics,
 };
=20
@@ -385,7 +378,7 @@ static void spapr_irq_reset_xive(SpaprMachineState *s=
papr, Error **errp)
         spapr_xive_set_tctx_os_cam(spapr_cpu_state(cpu)->tctx);
     }
=20
-    spapr_irq_init_device(spapr, &spapr_irq_xive, &local_err);
+    spapr_irq_init_kvm(spapr, &spapr_irq_xive, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -411,10 +404,6 @@ static const char *spapr_irq_get_nodename_xive(Spapr=
MachineState *spapr)
     return spapr->xive->nodename;
 }
=20
-static void spapr_irq_init_emu_xive(SpaprMachineState *spapr, Error **er=
rp)
-{
-}
-
 static void spapr_irq_init_kvm_xive(SpaprMachineState *spapr, Error **er=
rp)
 {
     if (kvm_enabled()) {
@@ -446,7 +435,6 @@ SpaprIrq spapr_irq_xive =3D {
     .reset       =3D spapr_irq_reset_xive,
     .set_irq     =3D spapr_irq_set_irq_xive,
     .get_nodename =3D spapr_irq_get_nodename_xive,
-    .init_emu    =3D spapr_irq_init_emu_xive,
     .init_kvm    =3D spapr_irq_init_kvm_xive,
 };
=20
@@ -624,7 +612,6 @@ SpaprIrq spapr_irq_dual =3D {
     .reset       =3D spapr_irq_reset_dual,
     .set_irq     =3D spapr_irq_set_irq_dual,
     .get_nodename =3D spapr_irq_get_nodename_dual,
-    .init_emu    =3D NULL, /* should not be used */
     .init_kvm    =3D NULL, /* should not be used */
 };
=20
@@ -840,6 +827,5 @@ SpaprIrq spapr_irq_xics_legacy =3D {
     .reset       =3D spapr_irq_reset_xics,
     .set_irq     =3D spapr_irq_set_irq_xics,
     .get_nodename =3D spapr_irq_get_nodename_xics,
-    .init_emu    =3D spapr_irq_init_emu_xics,
     .init_kvm    =3D spapr_irq_init_kvm_xics,
 };
--=20
2.21.0


