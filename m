Received: from eggs.gnu.org ([2001:4830:134:3::10]:38217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ceMQM-0001ZD-PV
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:48:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ceMQL-00059h-UD
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:48:42 -0500
Received: from 6.mo173.mail-out.ovh.net ([46.105.43.93]:53237)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ceMQL-00059G-Nl
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:48:41 -0500
Received: from player791.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 931B224154
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 14:48:40 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 16 Feb 2017 14:47:28 +0100
Message-Id: <1487252865-12064-6-git-send-email-clg@kaod.org>
In-Reply-To: <1487252865-12064-1-git-send-email-clg@kaod.org>
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 05/22] ppc/xics: introduce a QOM interface
 to handle ICSs
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

This QOM interface provides two simple handlers. One is to get an ICS
object from an irq number and a second to resend the irqs when needed.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics.c        |  7 +++++++
 include/hw/ppc/xics.h | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index b1294417a0ae..3e80d2d0f0d9 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -726,6 +726,12 @@ static const TypeInfo ics_base_info =3D {
     .class_size =3D sizeof(ICSStateClass),
 };
=20
+static const TypeInfo xics_interface_info =3D {
+    .name =3D TYPE_XICS_INTERFACE,
+    .parent =3D TYPE_INTERFACE,
+    .class_size =3D sizeof(XICSInterfaceClass),
+};
+
 /*
  * Exported functions
  */
@@ -766,6 +772,7 @@ static void xics_register_types(void)
     type_register_static(&ics_simple_info);
     type_register_static(&ics_base_info);
     type_register_static(&icp_info);
+    type_register_static(&xics_interface_info);
 }
=20
 type_init(xics_register_types)
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 6d443ce09dba..fe2bb5c8ef54 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -177,6 +177,24 @@ struct ICSIRQState {
     uint8_t flags;
 };
=20
+typedef struct XICSInterface {
+    Object parent;
+} XICSInterface;
+
+#define TYPE_XICS_INTERFACE "xics-interface"
+#define XICS_INTERFACE(obj)                                     \
+    OBJECT_CHECK(XICSInterface, (obj), TYPE_XICS_INTERFACE)
+#define XICS_INTERFACE_CLASS(klass)                                     =
\
+    OBJECT_CLASS_CHECK(XICSInterfaceClass, (klass), TYPE_XICS_INTERFACE)
+#define XICS_INTERFACE_GET_CLASS(obj)                                   =
\
+    OBJECT_GET_CLASS(XICSInterfaceClass, (obj), TYPE_XICS_INTERFACE)
+
+typedef struct XICSInterfaceClass {
+    InterfaceClass parent;
+    ICSState *(*ics_get)(XICSInterface *xi, int irq);
+    void (*ics_resend)(XICSInterface *xi);
+} XICSInterfaceClass;
+
 #define XICS_IRQS_SPAPR               1024
=20
 qemu_irq xics_get_qirq(XICSState *icp, int irq);
--=20
2.7.4
