Received: from eggs.gnu.org ([2001:4830:134:3::10]:58396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98xM-0001Ve-MH
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98xI-00018g-Od
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:46:32 -0400
Received: from 20.mo7.mail-out.ovh.net ([46.105.49.208]:45266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f98xI-000181-GR
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:46:28 -0400
Received: from player792.ha.ovh.net (unknown [10.109.108.85])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 1343BA28FB
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:46:26 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Apr 2018 14:43:24 +0200
Message-Id: <20180419124331.3915-29-clg@kaod.org>
In-Reply-To: <20180419124331.3915-1-clg@kaod.org>
References: <20180419124331.3915-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 28/35] intc: introduce a CPUIntc interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

which we will use in the sPAPR machine to reset the interrupt
controller of each CPU at the KVM level.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/intc.c         | 26 ++++++++++++++++++++++++++
 include/hw/intc/intc.h | 21 +++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/hw/intc/intc.c b/hw/intc/intc.c
index 2e1e29e753a1..bb08ff51596a 100644
--- a/hw/intc/intc.c
+++ b/hw/intc/intc.c
@@ -32,10 +32,36 @@ static const TypeInfo intctrl_info =3D {
     .class_size =3D sizeof(InterruptStatsProviderClass),
 };
=20
+static const TypeInfo cpu_intc_info =3D {
+    .name =3D TYPE_CPU_INTC,
+    .parent =3D TYPE_INTERFACE,
+    .class_size =3D sizeof(CPUIntcClass),
+};
+
 static void intc_register_types(void)
 {
+    type_register_static(&cpu_intc_info);
     type_register_static(&intctrl_info);
 }
=20
 type_init(intc_register_types)
=20
+void cpu_intc_disconnect(CPUIntc *intc, Error **errp)
+{
+    CPUIntcClass *cic;
+
+    cic =3D CPU_INTC_GET_CLASS(intc);
+    if (cic->disconnect) {
+        cic->disconnect(intc, errp);
+    }
+}
+
+void cpu_intc_connect(CPUIntc *intc, Error **errp)
+{
+    CPUIntcClass *cic;
+
+    cic =3D CPU_INTC_GET_CLASS(intc);
+    if (cic->connect) {
+        cic->connect(intc, errp);
+    }
+}
diff --git a/include/hw/intc/intc.h b/include/hw/intc/intc.h
index 27d9828943ae..3536e7d57ffd 100644
--- a/include/hw/intc/intc.h
+++ b/include/hw/intc/intc.h
@@ -30,4 +30,25 @@ typedef struct InterruptStatsProviderClass {
     void (*print_info)(InterruptStatsProvider *obj, Monitor *mon);
 } InterruptStatsProviderClass;
=20
+#define TYPE_CPU_INTC "cpu-intc"
+#define CPU_INTC(obj)                                     \
+    OBJECT_CHECK(CPUIntc, (obj), TYPE_CPU_INTC)
+#define CPU_INTC_CLASS(klass)                                     \
+    OBJECT_CLASS_CHECK(CPUIntcClass, (klass), TYPE_CPU_INTC)
+#define CPU_INTC_GET_CLASS(obj)                                   \
+    OBJECT_GET_CLASS(CPUIntcClass, (obj), TYPE_CPU_INTC)
+
+typedef struct CPUIntc {
+    Object parent;
+} CPUIntc;
+
+typedef struct CPUIntcClass {
+    InterfaceClass parent;
+    void (*connect)(CPUIntc *icp, Error **errp);
+    void (*disconnect)(CPUIntc *icp, Error **errp);
+} CPUIntcClass;
+
+void cpu_intc_disconnect(CPUIntc *intc, Error **errp);
+void cpu_intc_connect(CPUIntc *intc, Error **errp);
+
 #endif
--=20
2.13.6
