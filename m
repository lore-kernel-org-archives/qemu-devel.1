Received: from eggs.gnu.org ([209.51.188.92]:38343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1go3VB-00051i-BZ
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:46:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1go3VA-0002ls-4f
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:46:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54082
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1go3V9-0002l7-UX
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:46:48 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0S9hlR0100368
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:46:47 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q9xekan9a-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:46:47 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Mon, 28 Jan 2019 09:46:45 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 28 Jan 2019 10:46:09 +0100
In-Reply-To: <20190128094625.4428-1-clg@kaod.org>
References: <20190128094625.4428-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190128094625.4428-4-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/19] xive: extend the XiveRouter get_tctx()
 method with the page offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The PowerNV machine can perform indirect loads and stores on the TIMA
on behalf of another CPU. The PIR of the CPU is controlled by a set of
4 registers, one per TIMA page. To know which page is being accessed,
we need to inform the controller model of the operation offset.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h |  4 ++--
 hw/intc/spapr_xive.c  |  3 ++-
 hw/intc/xive.c        | 12 +++++++-----
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 04d54e8315f7..a1f5ea2d9143 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -352,7 +352,7 @@ typedef struct XiveRouterClass {
                    XiveNVT *nvt);
     int (*write_nvt)(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_idx=
,
                      XiveNVT *nvt, uint8_t word_number);
-    XiveTCTX *(*get_tctx)(XiveRouter *xrtr, CPUState *cs);
+    XiveTCTX *(*get_tctx)(XiveRouter *xrtr, CPUState *cs, hwaddr offset)=
;
 } XiveRouterClass;
=20
 void xive_eas_pic_print_info(XiveEAS *eas, uint32_t lisn, Monitor *mon);
@@ -367,7 +367,7 @@ int xive_router_get_nvt(XiveRouter *xrtr, uint8_t nvt=
_blk, uint32_t nvt_idx,
                         XiveNVT *nvt);
 int xive_router_write_nvt(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nv=
t_idx,
                           XiveNVT *nvt, uint8_t word_number);
-XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, CPUState *cs);
+XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, CPUState *cs, hwaddr of=
fset);
=20
 /*
  * XIVE END ESBs
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index a0f5ff929447..c41ee96c4c84 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -391,7 +391,8 @@ static int spapr_xive_write_nvt(XiveRouter *xrtr, uin=
t8_t nvt_blk,
     g_assert_not_reached();
 }
=20
-static XiveTCTX *spapr_xive_get_tctx(XiveRouter *xrtr, CPUState *cs)
+static XiveTCTX *spapr_xive_get_tctx(XiveRouter *xrtr, CPUState *cs,
+                                     hwaddr offset)
 {
     PowerPCCPU *cpu =3D POWERPC_CPU(cs);
=20
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index f5642f2338de..39dff557fadc 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -320,7 +320,8 @@ static const XiveTmOp *xive_tm_find_op(hwaddr offset,=
 unsigned size, bool write)
 static void xive_tm_write(void *opaque, hwaddr offset,
                           uint64_t value, unsigned size)
 {
-    XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), current=
_cpu);
+    XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), current=
_cpu,
+                                          offset);
     const XiveTmOp *xto;
=20
     /*
@@ -358,7 +359,8 @@ static void xive_tm_write(void *opaque, hwaddr offset=
,
=20
 static uint64_t xive_tm_read(void *opaque, hwaddr offset, unsigned size)
 {
-    XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), current=
_cpu);
+    XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), current=
_cpu,
+                                          offset);
     const XiveTmOp *xto;
=20
     /*
@@ -1134,11 +1136,11 @@ int xive_router_write_nvt(XiveRouter *xrtr, uint8=
_t nvt_blk, uint32_t nvt_idx,
    return xrc->write_nvt(xrtr, nvt_blk, nvt_idx, nvt, word_number);
 }
=20
-XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, CPUState *cs)
+XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, CPUState *cs, hwaddr of=
fset)
 {
     XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
=20
-    return xrc->get_tctx(xrtr, cs);
+    return xrc->get_tctx(xrtr, cs, offset);
 }
=20
 /*
@@ -1234,7 +1236,7 @@ static bool xive_presenter_match(XiveRouter *xrtr, =
uint8_t format,
      */
=20
     CPU_FOREACH(cs) {
-        XiveTCTX *tctx =3D xive_router_get_tctx(xrtr, cs);
+        XiveTCTX *tctx =3D xive_router_get_tctx(xrtr, cs, 0);
         int ring;
=20
         /*
--=20
2.20.1
