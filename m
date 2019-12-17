Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CF5C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:57:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE3CF20733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ejBv/UPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3CF20733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih4uv-0000mq-DY
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 23:57:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33710)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4iG-0008JP-5U
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4iB-0005Zs-S7
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:58 -0500
Received: from ozlabs.org ([203.11.71.1]:34159)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4iB-0005TW-BU; Mon, 16 Dec 2019 23:43:55 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWT6bt3z9sSk; Tue, 17 Dec 2019 15:43:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557813;
 bh=qLrrxGz/L7uIfowC5RKd93eD4t4+MzoytoM8oaYxtik=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ejBv/UPj41KRJgeI9Ed4GCrnoIiNVoycWAnLumAStDEtYXfK52hW40S2OwHD5dSqy
 7UX2ZlppC6sb8Apjsh1oIwkjS4LGrJa+Jqpz+Q9JcIXuoja+/S3eyQ8oj5IZUH3ycy
 AoUOimvg8qtFgE1QhY/yL1XQ7FxCpSIGaBIgkX84=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 27/88] ppc/xive: Introduce a XivePresenter interface
Date: Tue, 17 Dec 2019 15:42:21 +1100
Message-Id: <20191217044322.351838-28-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

When the XIVE IVRE sub-engine (XiveRouter) looks for a Notification
Virtual Target (NVT) to notify, it broadcasts a message on the
PowerBUS to find an XIVE IVPE sub-engine (Presenter) with the NVT
dispatched on one of its HW threads, and then forwards the
notification if any response was received.

The current XIVE presenter model is sufficient for the pseries machine
because it has a single interrupt controller device, but the PowerNV
machine can have multiple chips each having its own interrupt
controller. In this case, the XIVE presenter model is too simple and
the CAM line matching should scan all chips of the system.

To start fixing this issue, we first extend the XIVE Router model with
a new XivePresenter QOM interface representing the XIVE IVPE
sub-engine. This interface exposes a 'match_nvt' handler which the
sPAPR and PowerNV XIVE Router models will need to implement to perform
the CAM line matching.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191125065820.927-2-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xive.c        | 26 +++++++++++++++++---------
 include/hw/ppc/xive.h | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 511e1a9363..344bb3f3bc 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1363,9 +1363,10 @@ static uint32_t xive_tctx_hw_cam_line(XiveTCTX *tc=
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
@@ -1422,11 +1423,6 @@ static int xive_presenter_tctx_match(XiveTCTX *tct=
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
@@ -1460,7 +1456,8 @@ static bool xive_presenter_match(XiveRouter *xrtr, =
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
@@ -1754,6 +1751,7 @@ static const TypeInfo xive_router_info =3D {
     .class_init    =3D xive_router_class_init,
     .interfaces    =3D (InterfaceInfo[]) {
         { TYPE_XIVE_NOTIFIER },
+        { TYPE_XIVE_PRESENTER },
         { }
     }
 };
@@ -1923,10 +1921,20 @@ static const TypeInfo xive_notifier_info =3D {
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
 static void xive_register_types(void)
 {
     type_register_static(&xive_source_info);
     type_register_static(&xive_notifier_info);
+    type_register_static(&xive_presenter_info);
     type_register_static(&xive_router_info);
     type_register_static(&xive_end_source_info);
     type_register_static(&xive_tctx_info);
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index fa7adf87fe..f9aa0fa0da 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -367,6 +367,38 @@ int xive_router_write_nvt(XiveRouter *xrtr, uint8_t =
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
 /*
  * XIVE END ESBs
  */
--=20
2.23.0


