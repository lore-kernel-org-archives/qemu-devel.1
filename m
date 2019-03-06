Received: from eggs.gnu.org ([209.51.188.92]:55145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SGq-0006GP-RZ
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SGo-0001lw-T1
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h1SGk-0001DZ-KF
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:21 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x268mbwO046197
	for <qemu-devel@nongnu.org>; Wed, 6 Mar 2019 03:50:50 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r29u4c1k1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 03:50:49 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Wed, 6 Mar 2019 08:50:47 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  6 Mar 2019 09:50:08 +0100
In-Reply-To: <20190306085032.15744-1-clg@kaod.org>
References: <20190306085032.15744-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190306085032.15744-4-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/27] ppc/xive: export the TIMA memory
 accessors
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
on behalf of another CPU. Give the controller the possibility to call
the TIMA memory accessors with a XiveTCTX of its choice.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h |  3 +++
 hw/intc/xive.c        | 23 ++++++++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 13a487527b11..7dd80e0f46ef 100644
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
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index b21759c93856..3d7de864e93f 100644
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
--=20
2.20.1
