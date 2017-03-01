Received: from eggs.gnu.org ([2001:4830:134:3::10]:46488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7o-00082i-Ba
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7m-00006t-39
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:28 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  1 Mar 2017 15:43:45 +1100
Message-Id: <20170301044405.1792-31-david@gibson.dropbear.id.au>
In-Reply-To: <20170301044405.1792-1-david@gibson.dropbear.id.au>
References: <20170301044405.1792-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 30/50] ppc/xics: introduce a XICSFabric QOM
 interface to handle ICSs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, thuth@redhat.com, lvivier@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

This interface provides two simple handlers. One is to get an ICS
(Interrupt Source Controller) object from an irq number and a second
to resend the irqs when needed.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c        |  7 +++++++
 include/hw/ppc/xics.h | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index c7c9bd6..433869a 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -745,6 +745,12 @@ static const TypeInfo ics_base_info =3D {
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
@@ -785,6 +791,7 @@ static void xics_register_types(void)
     type_register_static(&ics_simple_info);
     type_register_static(&ics_base_info);
     type_register_static(&icp_info);
+    type_register_static(&xics_fabric_info);
 }
=20
 type_init(xics_register_types)
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 37d4d9c..1c43305 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -178,6 +178,24 @@ struct ICSIRQState {
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
2.9.3
