Received: from eggs.gnu.org ([209.51.188.92]:47977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gk2Ur-0002EZ-E4
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:53:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gk2Un-0005Vw-0D
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:53:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55532
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gk2Uj-0005P3-Rx
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:53:47 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0H7rcO8049035
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 02:53:40 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q2mjxtn5a-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 02:53:40 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Thu, 17 Jan 2019 07:53:37 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 17 Jan 2019 08:53:24 +0100
In-Reply-To: <20190117075327.22194-1-clg@kaod.org>
References: <20190117075327.22194-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190117075327.22194-2-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/4] xive: add a get_tctx() method to the
 XiveRouter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

It provides a mean to retrieve the XiveTCTX of a CPU. This will become
necessary with future changes which move the interrupt presenter
object pointers under the PowerPCCPU machine_data.

The PowerNV machine has an extra requirement on TIMA accesses that
this new method addresses. The machine can perform indirect loads and
stores on the TIMA on behalf of another CPU. The PIR being defined in
the controller registers, we need a way to peek in the controller
model to find the PIR value.

The XiveTCTX is moved above the XiveRouter definition to avoid forward
typedef declarations.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h | 57 ++++++++++++++++++++++---------------------
 hw/intc/spapr_xive.c  |  8 ++++++
 hw/intc/xive.c        | 16 +++++++-----
 3 files changed, 47 insertions(+), 34 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 5d31c801ee53..ec3bb2aae45a 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -294,6 +294,33 @@ static inline void xive_source_irq_set(XiveSource *x=
src, uint32_t srcno,
=20
 void xive_source_set_irq(void *opaque, int srcno, int val);
=20
+/*
+ * XIVE Thread interrupt Management (TM) context
+ */
+
+#define TYPE_XIVE_TCTX "xive-tctx"
+#define XIVE_TCTX(obj) OBJECT_CHECK(XiveTCTX, (obj), TYPE_XIVE_TCTX)
+
+/*
+ * XIVE Thread interrupt Management register rings :
+ *
+ *   QW-0  User       event-based exception state
+ *   QW-1  O/S        OS context for priority management, interrupt acks
+ *   QW-2  Pool       hypervisor pool context for virtual processors dis=
patched
+ *   QW-3  Physical   physical thread context and security context
+ */
+#define XIVE_TM_RING_COUNT      4
+#define XIVE_TM_RING_SIZE       0x10
+
+typedef struct XiveTCTX {
+    DeviceState parent_obj;
+
+    CPUState    *cs;
+    qemu_irq    output;
+
+    uint8_t     regs[XIVE_TM_RING_COUNT * XIVE_TM_RING_SIZE];
+} XiveTCTX;
+
 /*
  * XIVE Router
  */
@@ -324,6 +351,7 @@ typedef struct XiveRouterClass {
                    XiveNVT *nvt);
     int (*write_nvt)(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_idx=
,
                      XiveNVT *nvt, uint8_t word_number);
+    XiveTCTX *(*get_tctx)(XiveRouter *xrtr, CPUState *cs);
 } XiveRouterClass;
=20
 void xive_eas_pic_print_info(XiveEAS *eas, uint32_t lisn, Monitor *mon);
@@ -338,7 +366,7 @@ int xive_router_get_nvt(XiveRouter *xrtr, uint8_t nvt=
_blk, uint32_t nvt_idx,
                         XiveNVT *nvt);
 int xive_router_write_nvt(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nv=
t_idx,
                           XiveNVT *nvt, uint8_t word_number);
-
+XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, CPUState *cs);
=20
 /*
  * XIVE END ESBs
@@ -371,33 +399,6 @@ typedef struct XiveENDSource {
 void xive_end_pic_print_info(XiveEND *end, uint32_t end_idx, Monitor *mo=
n);
 void xive_end_queue_pic_print_info(XiveEND *end, uint32_t width, Monitor=
 *mon);
=20
-/*
- * XIVE Thread interrupt Management (TM) context
- */
-
-#define TYPE_XIVE_TCTX "xive-tctx"
-#define XIVE_TCTX(obj) OBJECT_CHECK(XiveTCTX, (obj), TYPE_XIVE_TCTX)
-
-/*
- * XIVE Thread interrupt Management register rings :
- *
- *   QW-0  User       event-based exception state
- *   QW-1  O/S        OS context for priority management, interrupt acks
- *   QW-2  Pool       hypervisor pool context for virtual processors dis=
patched
- *   QW-3  Physical   physical thread context and security context
- */
-#define XIVE_TM_RING_COUNT      4
-#define XIVE_TM_RING_SIZE       0x10
-
-typedef struct XiveTCTX {
-    DeviceState parent_obj;
-
-    CPUState    *cs;
-    qemu_irq    output;
-
-    uint8_t     regs[XIVE_TM_RING_COUNT * XIVE_TM_RING_SIZE];
-} XiveTCTX;
-
 /*
  * XIVE Thread Interrupt Management Aera (TIMA)
  *
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index d391177ab81f..136d872f16bc 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -390,6 +390,13 @@ static int spapr_xive_write_nvt(XiveRouter *xrtr, ui=
nt8_t nvt_blk,
     g_assert_not_reached();
 }
=20
+static XiveTCTX *spapr_xive_get_tctx(XiveRouter *xrtr, CPUState *cs)
+{
+    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+
+    return cpu->tctx;
+}
+
 static const VMStateDescription vmstate_spapr_xive_end =3D {
     .name =3D TYPE_SPAPR_XIVE "/end",
     .version_id =3D 1,
@@ -454,6 +461,7 @@ static void spapr_xive_class_init(ObjectClass *klass,=
 void *data)
     xrc->write_end =3D spapr_xive_write_end;
     xrc->get_nvt =3D spapr_xive_get_nvt;
     xrc->write_nvt =3D spapr_xive_write_nvt;
+    xrc->get_tctx =3D spapr_xive_get_tctx;
 }
=20
 static const TypeInfo spapr_xive_info =3D {
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 7f567a57d25a..2e9b8efd4342 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -320,8 +320,7 @@ static const XiveTmOp *xive_tm_find_op(hwaddr offset,=
 unsigned size, bool write)
 static void xive_tm_write(void *opaque, hwaddr offset,
                           uint64_t value, unsigned size)
 {
-    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
-    XiveTCTX *tctx =3D cpu->tctx;
+    XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), current=
_cpu);
     const XiveTmOp *xto;
=20
     /*
@@ -359,8 +358,7 @@ static void xive_tm_write(void *opaque, hwaddr offset=
,
=20
 static uint64_t xive_tm_read(void *opaque, hwaddr offset, unsigned size)
 {
-    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
-    XiveTCTX *tctx =3D cpu->tctx;
+    XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), current=
_cpu);
     const XiveTmOp *xto;
=20
     /*
@@ -1107,6 +1105,13 @@ int xive_router_write_nvt(XiveRouter *xrtr, uint8_=
t nvt_blk, uint32_t nvt_idx,
    return xrc->write_nvt(xrtr, nvt_blk, nvt_idx, nvt, word_number);
 }
=20
+XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, CPUState *cs)
+{
+    XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
+
+    return xrc->get_tctx(xrtr, cs);
+}
+
 /*
  * The thread context register words are in big-endian format.
  */
@@ -1182,8 +1187,7 @@ static bool xive_presenter_match(XiveRouter *xrtr, =
uint8_t format,
      */
=20
     CPU_FOREACH(cs) {
-        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-        XiveTCTX *tctx =3D cpu->tctx;
+        XiveTCTX *tctx =3D xive_router_get_tctx(xrtr, cs);
         int ring;
=20
         /*
--=20
2.20.1
