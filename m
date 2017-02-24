Received: from eggs.gnu.org ([2001:4830:134:3::10]:60432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1chCyD-0005ZE-VA
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:19:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1chCy9-0006do-Uh
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:19:25 -0500
Received: from 6.mo5.mail-out.ovh.net ([178.32.119.138]:38938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1chCy9-0006cF-PE
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:19:21 -0500
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 640A4DCAA0
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 11:19:20 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 24 Feb 2017 11:18:06 +0100
Message-Id: <1487931503-10607-8-git-send-email-clg@kaod.org>
In-Reply-To: <1487931503-10607-1-git-send-email-clg@kaod.org>
References: <1487931503-10607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 07/24] ppc/xics: introduce a XICSFabric QOM
 interface to handle ICSs
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

This interface provides two simple handlers. One is to get an ICS
(Interrupt Source Controller) object from an irq number and a second
to resend the irqs when needed.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics.c        |  7 +++++++
 include/hw/ppc/xics.h | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index b1294417a0ae..ba800bacc9ac 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -726,6 +726,12 @@ static const TypeInfo ics_base_info =3D {
     .class_size =3D sizeof(ICSStateClass),
 };
=20
+static const TypeInfo xics_fabric_info =3D {
+    .name =3D TYPE_XICS_FABRIC,
+    .parent =3D TYPE_INTERFACE,
+    .class_size =3D sizeof(XICSFabricClass),
+};
+
 /*
  * Exported functions
  */
@@ -766,6 +772,7 @@ static void xics_register_types(void)
     type_register_static(&ics_simple_info);
     type_register_static(&ics_base_info);
     type_register_static(&icp_info);
+    type_register_static(&xics_fabric_info);
 }
=20
 type_init(xics_register_types)
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index a36dae79cab5..58d1caa42ad3 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -177,6 +177,24 @@ struct ICSIRQState {
     uint8_t flags;
 };
=20
+typedef struct XICSFabric {
+    Object parent;
+} XICSFabric;
+
+#define TYPE_XICS_FABRIC "xics-fabric"
+#define XICS_FABRIC(obj)                                     \
+    OBJECT_CHECK(XICSFabric, (obj), TYPE_XICS_FABRIC)
+#define XICS_FABRIC_CLASS(klass)                                     \
+    OBJECT_CLASS_CHECK(XICSFabricClass, (klass), TYPE_XICS_FABRIC)
+#define XICS_FABRIC_GET_CLASS(obj)                                   \
+    OBJECT_GET_CLASS(XICSFabricClass, (obj), TYPE_XICS_FABRIC)
+
+typedef struct XICSFabricClass {
+    InterfaceClass parent;
+    ICSState *(*ics_get)(XICSFabric *xi, int irq);
+    void (*ics_resend)(XICSFabric *xi);
+} XICSFabricClass;
+
 #define XICS_IRQS_SPAPR               1024
=20
 qemu_irq xics_get_qirq(XICSState *icp, int irq);
--=20
2.7.4
