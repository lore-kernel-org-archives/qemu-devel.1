Received: from eggs.gnu.org ([209.51.188.92]:42993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2toU-0001LD-1C
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2toT-0001YY-19
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:05 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:26 +1100
Message-Id: <20190310082703.1245-24-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 23/60] ppc/xive: export the TIMA memory accessors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The PowerNV machine can perform indirect loads and stores on the TIMA
on behalf of another CPU. Give the controller the possibility to call
the TIMA memory accessors with a XiveTCTX of its choice.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190306085032.15744-4-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xive.c        | 23 ++++++++++++++++++-----
 include/hw/ppc/xive.h |  3 +++
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index b21759c938..3d7de864e9 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -317,10 +317,9 @@ static const XiveTmOp *xive_tm_find_op(hwaddr offset=
, unsigned size, bool write)
 /*
  * TIMA MMIO handlers
  */
-static void xive_tm_write(void *opaque, hwaddr offset,
-                          uint64_t value, unsigned size)
+void xive_tctx_tm_write(XiveTCTX *tctx, hwaddr offset, uint64_t value,
+                        unsigned size)
 {
-    XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), current=
_cpu);
     const XiveTmOp *xto;
=20
     /*
@@ -356,9 +355,8 @@ static void xive_tm_write(void *opaque, hwaddr offset=
,
     xive_tm_raw_write(tctx, offset, value, size);
 }
=20
-static uint64_t xive_tm_read(void *opaque, hwaddr offset, unsigned size)
+uint64_t xive_tctx_tm_read(XiveTCTX *tctx, hwaddr offset, unsigned size)
 {
-    XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), current=
_cpu);
     const XiveTmOp *xto;
=20
     /*
@@ -392,6 +390,21 @@ static uint64_t xive_tm_read(void *opaque, hwaddr of=
fset, unsigned size)
     return xive_tm_raw_read(tctx, offset, size);
 }
=20
+static void xive_tm_write(void *opaque, hwaddr offset,
+                          uint64_t value, unsigned size)
+{
+    XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), current=
_cpu);
+
+    xive_tctx_tm_write(tctx, offset, value, size);
+}
+
+static uint64_t xive_tm_read(void *opaque, hwaddr offset, unsigned size)
+{
+    XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), current=
_cpu);
+
+    return xive_tctx_tm_read(tctx, offset, size);
+}
+
 const MemoryRegionOps xive_tm_ops =3D {
     .read =3D xive_tm_read,
     .write =3D xive_tm_write,
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 13a487527b..7dd80e0f46 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -410,6 +410,9 @@ void xive_end_queue_pic_print_info(XiveEND *end, uint=
32_t width, Monitor *mon);
 #define XIVE_TM_USER_PAGE       0x3
=20
 extern const MemoryRegionOps xive_tm_ops;
+void xive_tctx_tm_write(XiveTCTX *tctx, hwaddr offset, uint64_t value,
+                        unsigned size);
+uint64_t xive_tctx_tm_read(XiveTCTX *tctx, hwaddr offset, unsigned size)=
;
=20
 void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon);
 Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp);
--=20
2.20.1
