Received: from eggs.gnu.org ([209.51.188.92]:38329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1go3VB-00051P-3R
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:46:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1go3V9-0002lK-QX
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:46:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52294
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1go3V9-0002km-Jk
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:46:47 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0S9hnfN002645
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:46:47 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q9x59udpj-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:46:46 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Mon, 28 Jan 2019 09:46:45 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 28 Jan 2019 10:46:10 +0100
In-Reply-To: <20190128094625.4428-1-clg@kaod.org>
References: <20190128094625.4428-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190128094625.4428-5-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 04/19] ppc/pnv: xive: export the TIMA memory
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
 hw/intc/xive.c        | 27 ++++++++++++++++++++-------
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index a1f5ea2d9143..763691e9bae9 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -414,6 +414,9 @@ void xive_end_queue_pic_print_info(XiveEND *end, uint=
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
index 39dff557fadc..ee6e81425784 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -317,11 +317,9 @@ static const XiveTmOp *xive_tm_find_op(hwaddr offset=
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
_cpu,
-                                          offset);
     const XiveTmOp *xto;
=20
     /*
@@ -357,10 +355,8 @@ static void xive_tm_write(void *opaque, hwaddr offse=
t,
     xive_tm_raw_write(tctx, offset, value, size);
 }
=20
-static uint64_t xive_tm_read(void *opaque, hwaddr offset, unsigned size)
+uint64_t xive_tctx_tm_read(XiveTCTX *tctx, hwaddr offset, unsigned size)
 {
-    XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), current=
_cpu,
-                                          offset);
     const XiveTmOp *xto;
=20
     /*
@@ -394,6 +390,23 @@ static uint64_t xive_tm_read(void *opaque, hwaddr of=
fset, unsigned size)
     return xive_tm_raw_read(tctx, offset, size);
 }
=20
+static void xive_tm_write(void *opaque, hwaddr offset,
+                          uint64_t value, unsigned size)
+{
+    XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), current=
_cpu,
+                                          offset);
+
+    xive_tctx_tm_write(tctx, offset, value, size);
+}
+
+static uint64_t xive_tm_read(void *opaque, hwaddr offset, unsigned size)
+{
+    XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), current=
_cpu,
+                                          offset);
+
+    return xive_tctx_tm_read(tctx, offset, size);
+}
+
 const MemoryRegionOps xive_tm_ops =3D {
     .read =3D xive_tm_read,
     .write =3D xive_tm_write,
--=20
2.20.1
