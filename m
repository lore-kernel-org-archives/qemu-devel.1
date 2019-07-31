Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D0DC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 14:16:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D57206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 14:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D57206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hspPE-0004Rm-18
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 10:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34097)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hspLs-00079r-5k
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:13:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hspLq-0001hB-Ju
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:13:12 -0400
Received: from 9.mo4.mail-out.ovh.net ([46.105.40.176]:36738)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hspLq-0001gT-DD
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:13:10 -0400
Received: from player715.ha.ovh.net (unknown [10.108.35.74])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 0DB4B200680
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 16:13:09 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player715.ha.ovh.net (Postfix) with ESMTPSA id 87C93850B82A;
 Wed, 31 Jul 2019 14:13:02 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 31 Jul 2019 16:12:18 +0200
Message-Id: <20190731141233.1340-4-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731141233.1340-1-clg@kaod.org>
References: <20190731141233.1340-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 11669952537534761958
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrleehgdejvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.40.176
Subject: [Qemu-devel] [PATCH v3 03/18] ppc/xive: Introduce the XiveFabric
 and XivePresenter interfaces
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

When the XIVE IVRE sub-engine (XiveRouter) looks for a Notification
Virtual Target (NVT) to notify, it broadcasts a message on the
PowerBUS to find an XIVE IVPE sub-engine (Presenter) which has the NVT
dispatched on one of its HW threads, and then forwards the
notification if any response was received.

The current XIVE presenter model is sufficient for the pseries machine
because it has a single interrupt controller device, but the PowerNV
machine can have multiple chips each having its own interrupt
controller. In this case, the XIVE presenter model is too simple and
the CAM line matching should scan all chips of the system.

We introduce a XiveFabric QOM interface which needs to be implemented
by the machine. It acts as the PowerBUS interface between the
interrupt controller and the system. On HW, the XIVE sub-engine
responsible for the communication with the other chip is the Common
Queue (CQ) bridge unit. This interface offers a 'match_nvt' handler to
perform the CAM line matching when looking for a XIVE Presenter with a
dispatched NVT.

We also introduce a XivePresenter QOM interface to represent the XIVE
Presenter (PC) sub-engine of the XIVE controller with a similar
'match_nvt' handler to perform the CAM line matching. This interface
could be merged in the XiveRouter but as it is stateless and performs
the XIVE IVPE sub-engine tasks, it makes sense to keep it independent.
It should have its use in POWER10.

Fixes: af53dbf6227a ("ppc/xive: introduce a simplified XIVE presenter")
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h | 54 +++++++++++++++++++++++++++++++++++++++++++
 hw/intc/xive.c        | 36 +++++++++++++++++++++--------
 2 files changed, 81 insertions(+), 9 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 4851ff87e795..165134ce52a5 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -368,6 +368,60 @@ int xive_router_write_nvt(XiveRouter *xrtr, uint8_t =
nvt_blk, uint32_t nvt_idx,
 XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, CPUState *cs);
 void xive_router_notify(XiveNotifier *xn, uint32_t lisn);
=20
+/*
+ * XIVE Presenter
+ */
+
+typedef struct XiveTCTXMatch {
+    XiveTCTX *tctx;
+    uint8_t ring;
+} XiveTCTXMatch;
+
+typedef struct XivePresenter XivePresenter;
+
+#define TYPE_XIVE_PRESENTER "xive-presenter"
+#define XIVE_PRESENTER(obj)                                     \
+    INTERFACE_CHECK(XivePresenter, (obj), TYPE_XIVE_PRESENTER)
+#define XIVE_PRESENTER_CLASS(klass)                                     =
\
+    OBJECT_CLASS_CHECK(XivePresenterClass, (klass), TYPE_XIVE_PRESENTER)
+#define XIVE_PRESENTER_GET_CLASS(obj)                                   =
\
+    OBJECT_GET_CLASS(XivePresenterClass, (obj), TYPE_XIVE_PRESENTER)
+
+typedef struct XivePresenterClass {
+    InterfaceClass parent;
+    int (*match_nvt)(XivePresenter *xptr, uint8_t format,
+                     uint8_t nvt_blk, uint32_t nvt_idx,
+                     bool cam_ignore, uint8_t priority,
+                     uint32_t logic_serv, XiveTCTXMatch *match);
+} XivePresenterClass;
+
+int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
+                              uint8_t format,
+                              uint8_t nvt_blk, uint32_t nvt_idx,
+                              bool cam_ignore, uint32_t logic_serv);
+
+/*
+ * XIVE Fabric (Interface between Interrupt Controller and Machine)
+ */
+
+typedef struct XiveFabric XiveFabric;
+
+#define TYPE_XIVE_FABRIC "xive-fabric"
+#define XIVE_FABRIC(obj)                                     \
+    INTERFACE_CHECK(XiveFabric, (obj), TYPE_XIVE_FABRIC)
+#define XIVE_FABRIC_CLASS(klass)                                     \
+    OBJECT_CLASS_CHECK(XiveFabricClass, (klass), TYPE_XIVE_FABRIC)
+#define XIVE_FABRIC_GET_CLASS(obj)                                   \
+    OBJECT_GET_CLASS(XiveFabricClass, (obj), TYPE_XIVE_FABRIC)
+
+typedef struct XiveFabricClass {
+    InterfaceClass parent;
+    int (*match_nvt)(XiveFabric *xfb, uint8_t format,
+                     uint8_t nvt_blk, uint32_t nvt_idx,
+                     bool cam_ignore, uint8_t priority,
+                     uint32_t logic_serv, XiveTCTXMatch *match);
+} XiveFabricClass;
+
 /*
  * XIVE END ESBs
  */
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 88f2e560db0f..4bdedab13047 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1294,9 +1294,10 @@ static uint32_t xive_tctx_hw_cam_line(XiveTCTX *tc=
tx)
 /*
  * The thread context register words are in big-endian format.
  */
-static int xive_presenter_tctx_match(XiveTCTX *tctx, uint8_t format,
-                                     uint8_t nvt_blk, uint32_t nvt_idx,
-                                     bool cam_ignore, uint32_t logic_ser=
v)
+int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
+                              uint8_t format,
+                              uint8_t nvt_blk, uint32_t nvt_idx,
+                              bool cam_ignore, uint32_t logic_serv)
 {
     uint32_t cam =3D xive_nvt_cam_line(nvt_blk, nvt_idx);
     uint32_t qw3w2 =3D xive_tctx_word2(&tctx->regs[TM_QW3_HV_PHYS]);
@@ -1353,11 +1354,6 @@ static int xive_presenter_tctx_match(XiveTCTX *tct=
x, uint8_t format,
     return -1;
 }
=20
-typedef struct XiveTCTXMatch {
-    XiveTCTX *tctx;
-    uint8_t ring;
-} XiveTCTXMatch;
-
 static bool xive_presenter_match(XiveRouter *xrtr, uint8_t format,
                                  uint8_t nvt_blk, uint32_t nvt_idx,
                                  bool cam_ignore, uint8_t priority,
@@ -1383,7 +1379,8 @@ static bool xive_presenter_match(XiveRouter *xrtr, =
uint8_t format,
          * Check the thread context CAM lines and record matches. We
          * will handle CPU exception delivery later
          */
-        ring =3D xive_presenter_tctx_match(tctx, format, nvt_blk, nvt_id=
x,
+        ring =3D xive_presenter_tctx_match(XIVE_PRESENTER(xrtr), tctx, f=
ormat,
+                                         nvt_blk, nvt_idx,
                                          cam_ignore, logic_serv);
         /*
          * Save the context and follow on to catch duplicates, that we
@@ -1670,6 +1667,7 @@ static const TypeInfo xive_router_info =3D {
     .class_init    =3D xive_router_class_init,
     .interfaces    =3D (InterfaceInfo[]) {
         { TYPE_XIVE_NOTIFIER },
+        { TYPE_XIVE_PRESENTER },
         { }
     }
 };
@@ -1841,10 +1839,30 @@ static const TypeInfo xive_notifier_info =3D {
     .class_size =3D sizeof(XiveNotifierClass),
 };
=20
+/*
+ * XIVE Presenter
+ */
+static const TypeInfo xive_presenter_info =3D {
+    .name =3D TYPE_XIVE_PRESENTER,
+    .parent =3D TYPE_INTERFACE,
+    .class_size =3D sizeof(XivePresenterClass),
+};
+
+/*
+ * XIVE Fabric
+ */
+static const TypeInfo xive_fabric_info =3D {
+    .name =3D TYPE_XIVE_FABRIC,
+    .parent =3D TYPE_INTERFACE,
+    .class_size =3D sizeof(XiveFabricClass),
+};
+
 static void xive_register_types(void)
 {
     type_register_static(&xive_source_info);
     type_register_static(&xive_notifier_info);
+    type_register_static(&xive_presenter_info);
+    type_register_static(&xive_fabric_info);
     type_register_static(&xive_router_info);
     type_register_static(&xive_end_source_info);
     type_register_static(&xive_tctx_info);
--=20
2.21.0


