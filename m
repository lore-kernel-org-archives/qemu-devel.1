Return-Path: <SRS0=1g4J=U5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7689FC5B576
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 20:53:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 506822086D
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 20:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 506822086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhgpX-0008Or-K5
	for qemu-devel@archiver.kernel.org; Sun, 30 Jun 2019 16:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36220)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hhgjT-0000GP-IE
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 16:47:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hhgjR-0002ho-65
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 16:47:31 -0400
Received: from 7.mo7.mail-out.ovh.net ([46.105.43.131]:37844)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hhgjM-0002T3-58
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 16:47:26 -0400
Received: from player157.ha.ovh.net (unknown [10.108.42.5])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 1604A121DEF
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 22:47:08 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id A5FFC7575AD9;
 Sun, 30 Jun 2019 20:47:01 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 30 Jun 2019 22:45:59 +0200
Message-Id: <20190630204601.30574-9-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190630204601.30574-1-clg@kaod.org>
References: <20190630204601.30574-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 2290924837335370726
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrvdeggdduheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.43.131
Subject: [Qemu-devel] [PATCH 08/10] ppc/xive: Extend XiveTCTX with an router
 object pointer
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
 Greg Kurz <groug@kaod.org>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is to perform lookups in the NVT table when a vCPU is dispatched
and possibly resend interrupts.

Future XIVE chip will use a different class for the model of the
interrupt controller. So use an 'Object *' instead of a 'XiveRouter *'.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h |  4 +++-
 hw/intc/xive.c        | 11 ++++++++++-
 hw/ppc/pnv.c          |  2 +-
 hw/ppc/spapr_irq.c    |  2 +-
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index d922524982d3..b764e1e4e6d4 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -321,6 +321,8 @@ typedef struct XiveTCTX {
     qemu_irq    os_output;
=20
     uint8_t     regs[XIVE_TM_RING_COUNT * XIVE_TM_RING_SIZE];
+
+    Object      *xrtr;
 } XiveTCTX;
=20
 /*
@@ -416,7 +418,7 @@ void xive_tctx_tm_write(XiveTCTX *tctx, hwaddr offset=
, uint64_t value,
 uint64_t xive_tctx_tm_read(XiveTCTX *tctx, hwaddr offset, unsigned size)=
;
=20
 void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon);
-Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp);
+Object *xive_tctx_create(Object *cpu, Object *xrtr, Error **errp);
=20
 static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nvt_i=
dx)
 {
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index f7ba1c3b622f..56700681884f 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -573,6 +573,14 @@ static void xive_tctx_realize(DeviceState *dev, Erro=
r **errp)
     Object *obj;
     Error *local_err =3D NULL;
=20
+    obj =3D object_property_get_link(OBJECT(dev), "xrtr", &local_err);
+    if (!obj) {
+        error_propagate(errp, local_err);
+        error_prepend(errp, "required link 'xrtr' not found: ");
+        return;
+    }
+    tctx->xrtr =3D obj;
+
     obj =3D object_property_get_link(OBJECT(dev), "cpu", &local_err);
     if (!obj) {
         error_propagate(errp, local_err);
@@ -657,7 +665,7 @@ static const TypeInfo xive_tctx_info =3D {
     .class_init    =3D xive_tctx_class_init,
 };
=20
-Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp)
+Object *xive_tctx_create(Object *cpu, Object *xrtr, Error **errp)
 {
     Error *local_err =3D NULL;
     Object *obj;
@@ -666,6 +674,7 @@ Object *xive_tctx_create(Object *cpu, XiveRouter *xrt=
r, Error **errp)
     object_property_add_child(cpu, TYPE_XIVE_TCTX, obj, &error_abort);
     object_unref(obj);
     object_property_add_const_link(obj, "cpu", cpu, &error_abort);
+    object_property_add_const_link(obj, "xrtr", xrtr, &error_abort);
     object_property_set_bool(obj, true, "realized", &local_err);
     if (local_err) {
         goto error;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index b87e01e5b925..11916dc273c2 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -765,7 +765,7 @@ static void pnv_chip_power9_intc_create(PnvChip *chip=
, PowerPCCPU *cpu,
      * controller object is initialized afterwards. Hopefully, it's
      * only used at runtime.
      */
-    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(&chip9->xive), &lo=
cal_err);
+    obj =3D xive_tctx_create(OBJECT(cpu), OBJECT(&chip9->xive), &local_e=
rr);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index b2b01e850de8..5b3c3c50967b 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -353,7 +353,7 @@ static void spapr_irq_cpu_intc_create_xive(SpaprMachi=
neState *spapr,
     Object *obj;
     SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
=20
-    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(spapr->xive), &loc=
al_err);
+    obj =3D xive_tctx_create(OBJECT(cpu), OBJECT(spapr->xive), &local_er=
r);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
--=20
2.21.0


