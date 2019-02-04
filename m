Received: from eggs.gnu.org ([209.51.188.92]:38400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8j-0000cT-8J
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8h-0007lb-MJ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:05 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  4 Feb 2019 20:01:02 +1100
Message-Id: <20190204090124.26191-16-david@gibson.dropbear.id.au>
In-Reply-To: <20190204090124.26191-1-david@gibson.dropbear.id.au>
References: <20190204090124.26191-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/37] xive: add a get_tctx() method to the
 XiveRouter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

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
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive.c  |  8 ++++++
 hw/intc/xive.c        | 16 +++++++-----
 include/hw/ppc/xive.h | 57 ++++++++++++++++++++++---------------------
 3 files changed, 47 insertions(+), 34 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index d391177ab8..136d872f16 100644
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
index 7f567a57d2..2e9b8efd43 100644
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
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 5d31c801ee..ec3bb2aae4 100644
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
--=20
2.20.1
