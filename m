Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86954C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C92A218AE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C92A218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAdAB-0002NJ-Pn
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 12:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iAcU1-0002xS-U2
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iAcU0-0002c4-Fu
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:07:09 -0400
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:32989)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iAcU0-0002bD-8Q
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:07:08 -0400
Received: from player799.ha.ovh.net (unknown [10.108.35.185])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 916F21AD385
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 18:07:06 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player799.ha.ovh.net (Postfix) with ESMTPSA id C2DBD9F0E37F;
 Wed, 18 Sep 2019 16:07:00 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 18 Sep 2019 18:06:22 +0200
Message-Id: <20190918160645.25126-3-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918160645.25126-1-clg@kaod.org>
References: <20190918160645.25126-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 6208775040059739110
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudekgdeljecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.181.248
Subject: [Qemu-devel] [PATCH v4 02/25] ppc/xive: Implement the XivePresenter
 interface
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
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Each XIVE Router model, sPAPR and PowerNV, now implements the 'match_nvt'
handler of the XivePresenter QOM interface. This is simply moving code
and taking into account the new API.

To be noted that the xive_router_get_tctx() helper is not used anymore
when doing CAM matching and will be removed later on after other changes.

The XIVE presenter model is still too simple for the PowerNV machine
and the CAM matching algo is not correct on multichip system. Subsequent
patches will introduce more changes to scan all chips of the system.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/pnv_xive.c   | 41 +++++++++++++++++++++++++++++++++++++++++
 hw/intc/spapr_xive.c | 41 +++++++++++++++++++++++++++++++++++++++++
 hw/intc/xive.c       | 43 +++++++------------------------------------
 3 files changed, 89 insertions(+), 36 deletions(-)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index ed6e9d71bbfa..ae449aa1119b 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -392,6 +392,45 @@ static int pnv_xive_get_eas(XiveRouter *xrtr, uint8_=
t blk, uint32_t idx,
     return pnv_xive_vst_read(xive, VST_TSEL_IVT, blk, idx, eas);
 }
=20
+static int pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
+                              uint8_t nvt_blk, uint32_t nvt_idx,
+                              bool cam_ignore, uint8_t priority,
+                              uint32_t logic_serv, XiveTCTXMatch *match)
+{
+    CPUState *cs;
+    int count =3D 0;
+
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+        XiveTCTX *tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
+        int ring;
+
+        /*
+         * Check the thread context CAM lines and record matches.
+         */
+        ring =3D xive_presenter_tctx_match(xptr, tctx, format, nvt_blk, =
nvt_idx,
+                                         cam_ignore, logic_serv);
+        /*
+         * Save the context and follow on to catch duplicates, that we
+         * don't support yet.
+         */
+        if (ring !=3D -1) {
+            if (match->tctx) {
+                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found a "
+                              "thread context NVT %x/%x\n",
+                              nvt_blk, nvt_idx);
+                return -1;
+            }
+
+            match->ring =3D ring;
+            match->tctx =3D tctx;
+            count++;
+        }
+    }
+
+    return count;
+}
+
 static XiveTCTX *pnv_xive_get_tctx(XiveRouter *xrtr, CPUState *cs)
 {
     PowerPCCPU *cpu =3D POWERPC_CPU(cs);
@@ -1797,6 +1836,7 @@ static void pnv_xive_class_init(ObjectClass *klass,=
 void *data)
     PnvXScomInterfaceClass *xdc =3D PNV_XSCOM_INTERFACE_CLASS(klass);
     XiveRouterClass *xrc =3D XIVE_ROUTER_CLASS(klass);
     XiveNotifierClass *xnc =3D XIVE_NOTIFIER_CLASS(klass);
+    XivePresenterClass *xpc =3D XIVE_PRESENTER_CLASS(klass);
=20
     xdc->dt_xscom =3D pnv_xive_dt_xscom;
=20
@@ -1812,6 +1852,7 @@ static void pnv_xive_class_init(ObjectClass *klass,=
 void *data)
     xrc->get_tctx =3D pnv_xive_get_tctx;
=20
     xnc->notify =3D pnv_xive_notify;
+    xpc->match_nvt  =3D pnv_xive_match_nvt;
 };
=20
 static const TypeInfo pnv_xive_info =3D {
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index c1c97192a7d2..eefc0d4c36b9 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -422,6 +422,44 @@ static XiveTCTX *spapr_xive_get_tctx(XiveRouter *xrt=
r, CPUState *cs)
     return spapr_cpu_state(cpu)->tctx;
 }
=20
+static int spapr_xive_match_nvt(XivePresenter *xptr, uint8_t format,
+                                uint8_t nvt_blk, uint32_t nvt_idx,
+                                bool cam_ignore, uint8_t priority,
+                                uint32_t logic_serv, XiveTCTXMatch *matc=
h)
+{
+    CPUState *cs;
+    int count =3D 0;
+
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+        XiveTCTX *tctx =3D spapr_cpu_state(cpu)->tctx;
+        int ring;
+
+        /*
+         * Check the thread context CAM lines and record matches.
+         */
+        ring =3D xive_presenter_tctx_match(xptr, tctx, format, nvt_blk, =
nvt_idx,
+                                         cam_ignore, logic_serv);
+        /*
+         * Save the matching thread interrupt context and follow on to
+         * check for duplicates which are invalid.
+         */
+        if (ring !=3D -1) {
+            if (match->tctx) {
+                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found a th=
read "
+                              "context NVT %x/%x\n", nvt_blk, nvt_idx);
+                return -1;
+            }
+
+            match->ring =3D ring;
+            match->tctx =3D tctx;
+            count++;
+        }
+    }
+
+    return count;
+}
+
 static const VMStateDescription vmstate_spapr_xive_end =3D {
     .name =3D TYPE_SPAPR_XIVE "/end",
     .version_id =3D 1,
@@ -499,6 +537,7 @@ static void spapr_xive_class_init(ObjectClass *klass,=
 void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     XiveRouterClass *xrc =3D XIVE_ROUTER_CLASS(klass);
+    XivePresenterClass *xpc =3D XIVE_PRESENTER_CLASS(klass);
=20
     dc->desc    =3D "sPAPR XIVE Interrupt Controller";
     dc->props   =3D spapr_xive_properties;
@@ -511,6 +550,8 @@ static void spapr_xive_class_init(ObjectClass *klass,=
 void *data)
     xrc->get_nvt =3D spapr_xive_get_nvt;
     xrc->write_nvt =3D spapr_xive_write_nvt;
     xrc->get_tctx =3D spapr_xive_get_tctx;
+
+    xpc->match_nvt  =3D spapr_xive_match_nvt;
 }
=20
 static const TypeInfo spapr_xive_info =3D {
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index aa45ac2e06cb..fff50429f8ac 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1381,43 +1381,14 @@ static bool xive_presenter_match(XiveRouter *xrtr=
, uint8_t format,
                                  bool cam_ignore, uint8_t priority,
                                  uint32_t logic_serv, XiveTCTXMatch *mat=
ch)
 {
-    CPUState *cs;
+    XivePresenter *xptr =3D XIVE_PRESENTER(xrtr);
+    XivePresenterClass *xpc =3D XIVE_PRESENTER_GET_CLASS(xptr);
+    int count;
=20
-    /*
-     * TODO (PowerNV): handle chip_id overwrite of block field for
-     * hardwired CAM compares
-     */
-
-    CPU_FOREACH(cs) {
-        XiveTCTX *tctx =3D xive_router_get_tctx(xrtr, cs);
-        int ring;
-
-        /*
-         * HW checks that the CPU is enabled in the Physical Thread
-         * Enable Register (PTER).
-         */
-
-        /*
-         * Check the thread context CAM lines and record matches. We
-         * will handle CPU exception delivery later
-         */
-        ring =3D xive_presenter_tctx_match(XIVE_PRESENTER(xrtr), tctx, f=
ormat,
-                                         nvt_blk, nvt_idx,
-                                         cam_ignore, logic_serv);
-        /*
-         * Save the context and follow on to catch duplicates, that we
-         * don't support yet.
-         */
-        if (ring !=3D -1) {
-            if (match->tctx) {
-                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found a th=
read "
-                              "context NVT %x/%x\n", nvt_blk, nvt_idx);
-                return false;
-            }
-
-            match->ring =3D ring;
-            match->tctx =3D tctx;
-        }
+    count =3D xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_ignore,
+                           priority, logic_serv, match);
+    if (count < 0) {
+        return false;
     }
=20
     if (!match->tctx) {
--=20
2.21.0


