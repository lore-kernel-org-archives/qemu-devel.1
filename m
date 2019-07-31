Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E4AC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 14:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C07320449
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 14:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C07320449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hspQp-0000XD-CB
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 10:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34439)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hspMR-0000Uc-Ne
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hspMP-00026B-Um
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:13:47 -0400
Received: from 5.mo68.mail-out.ovh.net ([46.105.62.179]:45493)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hspMP-00024i-Oi
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:13:45 -0400
Received: from player715.ha.ovh.net (unknown [10.108.42.176])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 5F8E013E043
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 16:13:44 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player715.ha.ovh.net (Postfix) with ESMTPSA id EB5B3850BAAB;
 Wed, 31 Jul 2019 14:13:37 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 31 Jul 2019 16:12:24 +0200
Message-Id: <20190731141233.1340-10-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731141233.1340-1-clg@kaod.org>
References: <20190731141233.1340-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 11680085637226073062
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrleehgdejvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.62.179
Subject: [Qemu-devel] [PATCH v3 09/18] ppc/xive: Move the TIMA operations to
 the controller model
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

This also removes the need of the get_tctx() XiveRouter handler in the
core XIVE framework.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h |  3 ---
 hw/intc/pnv_xive.c    | 48 ++++++++++++++++++++++++++++++-------------
 hw/intc/spapr_xive.c  | 41 +++++++++++++++++++++++++++---------
 hw/intc/xive.c        | 36 --------------------------------
 4 files changed, 65 insertions(+), 63 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index ba43a4a129d9..b34e2ad43a82 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -352,7 +352,6 @@ typedef struct XiveRouterClass {
                    XiveNVT *nvt);
     int (*write_nvt)(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_idx=
,
                      XiveNVT *nvt, uint8_t word_number);
-    XiveTCTX *(*get_tctx)(XiveRouter *xrtr, CPUState *cs);
 } XiveRouterClass;
=20
 int xive_router_get_eas(XiveRouter *xrtr, uint8_t eas_blk, uint32_t eas_=
idx,
@@ -365,7 +364,6 @@ int xive_router_get_nvt(XiveRouter *xrtr, uint8_t nvt=
_blk, uint32_t nvt_idx,
                         XiveNVT *nvt);
 int xive_router_write_nvt(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nv=
t_idx,
                           XiveNVT *nvt, uint8_t word_number);
-XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, CPUState *cs);
 void xive_router_notify(XiveNotifier *xn, uint32_t lisn);
=20
 /*
@@ -463,7 +461,6 @@ typedef struct XiveENDSource {
 #define XIVE_TM_OS_PAGE         0x2
 #define XIVE_TM_USER_PAGE       0x3
=20
-extern const MemoryRegionOps xive_tm_ops;
 void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offs=
et,
                         uint64_t value, unsigned size);
 uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr o=
ffset,
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index e598857359d8..982f5eef380c 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -485,18 +485,6 @@ static PnvXive *pnv_xive_tm_get_xive(PowerPCCPU *cpu=
)
     return xive;
 }
=20
-static XiveTCTX *pnv_xive_get_tctx(XiveRouter *xrtr, CPUState *cs)
-{
-    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-    PnvXive *xive =3D pnv_xive_tm_get_xive(cpu);
-
-    if (!xive) {
-        return NULL;
-    }
-
-    return XIVE_TCTX(pnv_cpu_state(cpu)->intc);
-}
-
 /*
  * The internal sources (IPIs) of the interrupt controller have no
  * knowledge of the XIVE chip on which they reside. Encode the block
@@ -1475,6 +1463,39 @@ static const MemoryRegionOps xive_tm_indirect_ops =
=3D {
     },
 };
=20
+static void pnv_xive_tm_write(void *opaque, hwaddr offset,
+                              uint64_t value, unsigned size)
+{
+    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
+    PnvXive *xive =3D pnv_xive_tm_get_xive(cpu);
+    XiveTCTX *tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
+
+    xive_tctx_tm_write(XIVE_PRESENTER(xive), tctx, offset, value, size);
+}
+
+static uint64_t pnv_xive_tm_read(void *opaque, hwaddr offset, unsigned s=
ize)
+{
+    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
+    PnvXive *xive =3D pnv_xive_tm_get_xive(cpu);
+    XiveTCTX *tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
+
+    return xive_tctx_tm_read(XIVE_PRESENTER(xive), tctx, offset, size);
+}
+
+const MemoryRegionOps pnv_xive_tm_ops =3D {
+    .read =3D pnv_xive_tm_read,
+    .write =3D pnv_xive_tm_write,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+    .valid =3D {
+        .min_access_size =3D 1,
+        .max_access_size =3D 8,
+    },
+    .impl =3D {
+        .min_access_size =3D 1,
+        .max_access_size =3D 8,
+    },
+};
+
 /*
  * Interrupt controller XSCOM region.
  */
@@ -1832,7 +1853,7 @@ static void pnv_xive_realize(DeviceState *dev, Erro=
r **errp)
                           "xive-pc", PNV9_XIVE_PC_SIZE);
=20
     /* Thread Interrupt Management Area (Direct) */
-    memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive_tm_ops,
+    memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &pnv_xive_tm_ops=
,
                           xive, "xive-tima", PNV9_XIVE_TM_SIZE);
=20
     qemu_register_reset(pnv_xive_reset, dev);
@@ -1888,7 +1909,6 @@ static void pnv_xive_class_init(ObjectClass *klass,=
 void *data)
     xrc->write_end =3D pnv_xive_write_end;
     xrc->get_nvt =3D pnv_xive_get_nvt;
     xrc->write_nvt =3D pnv_xive_write_nvt;
-    xrc->get_tctx =3D pnv_xive_get_tctx;
=20
     xnc->notify =3D pnv_xive_notify;
     xpc->match_nvt  =3D pnv_xive_match_nvt;
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index beb5049ad9da..4abb099d341c 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -219,6 +219,35 @@ void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx)
     memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &nvt_cam, 4);
 }
=20
+static void spapr_xive_tm_write(void *opaque, hwaddr offset,
+                          uint64_t value, unsigned size)
+{
+    XiveTCTX *tctx =3D spapr_cpu_state(POWERPC_CPU(current_cpu))->tctx;
+
+    xive_tctx_tm_write(XIVE_PRESENTER(opaque), tctx, offset, value, size=
);
+}
+
+static uint64_t spapr_xive_tm_read(void *opaque, hwaddr offset, unsigned=
 size)
+{
+    XiveTCTX *tctx =3D spapr_cpu_state(POWERPC_CPU(current_cpu))->tctx;
+
+    return xive_tctx_tm_read(XIVE_PRESENTER(opaque), tctx, offset, size)=
;
+}
+
+const MemoryRegionOps spapr_xive_tm_ops =3D {
+    .read =3D spapr_xive_tm_read,
+    .write =3D spapr_xive_tm_write,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+    .valid =3D {
+        .min_access_size =3D 1,
+        .max_access_size =3D 8,
+    },
+    .impl =3D {
+        .min_access_size =3D 1,
+        .max_access_size =3D 8,
+    },
+};
+
 static void spapr_xive_end_reset(XiveEND *end)
 {
     memset(end, 0, sizeof(*end));
@@ -328,8 +357,8 @@ static void spapr_xive_realize(DeviceState *dev, Erro=
r **errp)
     qemu_register_reset(spapr_xive_reset, dev);
=20
     /* TIMA initialization */
-    memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive_tm_ops, xi=
ve,
-                          "xive.tima", 4ull << TM_SHIFT);
+    memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &spapr_xive_tm_o=
ps,
+                          xive, "xive.tima", 4ull << TM_SHIFT);
     sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xive->tm_mmio);
=20
     /*
@@ -412,13 +441,6 @@ static int spapr_xive_write_nvt(XiveRouter *xrtr, ui=
nt8_t nvt_blk,
     g_assert_not_reached();
 }
=20
-static XiveTCTX *spapr_xive_get_tctx(XiveRouter *xrtr, CPUState *cs)
-{
-    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-
-    return spapr_cpu_state(cpu)->tctx;
-}
-
 static int spapr_xive_match_nvt(XivePresenter *xptr, uint8_t format,
                                 uint8_t nvt_blk, uint32_t nvt_idx,
                                 bool cam_ignore, uint8_t priority,
@@ -546,7 +568,6 @@ static void spapr_xive_class_init(ObjectClass *klass,=
 void *data)
     xrc->write_end =3D spapr_xive_write_end;
     xrc->get_nvt =3D spapr_xive_get_nvt;
     xrc->write_nvt =3D spapr_xive_write_nvt;
-    xrc->get_tctx =3D spapr_xive_get_tctx;
=20
     xpc->match_nvt  =3D spapr_xive_match_nvt;
 }
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 9ca015969143..6f74b4dcbbd4 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -480,35 +480,6 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, Xive=
TCTX *tctx, hwaddr offset,
     return xive_tm_raw_read(tctx, offset, size);
 }
=20
-static void xive_tm_write(void *opaque, hwaddr offset,
-                          uint64_t value, unsigned size)
-{
-    XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), current=
_cpu);
-
-    xive_tctx_tm_write(XIVE_PRESENTER(opaque), tctx, offset, value, size=
);
-}
-
-static uint64_t xive_tm_read(void *opaque, hwaddr offset, unsigned size)
-{
-    XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), current=
_cpu);
-
-    return xive_tctx_tm_read(XIVE_PRESENTER(opaque), tctx, offset, size)=
;
-}
-
-const MemoryRegionOps xive_tm_ops =3D {
-    .read =3D xive_tm_read,
-    .write =3D xive_tm_write,
-    .endianness =3D DEVICE_BIG_ENDIAN,
-    .valid =3D {
-        .min_access_size =3D 1,
-        .max_access_size =3D 8,
-    },
-    .impl =3D {
-        .min_access_size =3D 1,
-        .max_access_size =3D 8,
-    },
-};
-
 static char *xive_tctx_ring_print(uint8_t *ring)
 {
     uint32_t w2 =3D xive_tctx_word2(ring);
@@ -1277,13 +1248,6 @@ int xive_router_write_nvt(XiveRouter *xrtr, uint8_=
t nvt_blk, uint32_t nvt_idx,
    return xrc->write_nvt(xrtr, nvt_blk, nvt_idx, nvt, word_number);
 }
=20
-XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, CPUState *cs)
-{
-    XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
-
-    return xrc->get_tctx(xrtr, cs);
-}
-
 /*
  * Encode the HW CAM line in the block group mode format :
  *
--=20
2.21.0


