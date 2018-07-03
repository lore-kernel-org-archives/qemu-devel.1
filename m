Received: from eggs.gnu.org ([2001:4830:134:3::10]:39584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKP-0002lf-V6
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKM-0006oZ-AA
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:18 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  3 Jul 2018 15:57:35 +1000
Message-Id: <20180703055804.13449-7-david@gibson.dropbear.id.au>
In-Reply-To: <20180703055804.13449-1-david@gibson.dropbear.id.au>
References: <20180703055804.13449-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/35] ppc/xics: move the instance_init handler
 under the ics-base class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index d6066d561f..83340770f7 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -611,13 +611,6 @@ static const VMStateDescription vmstate_ics_simple =3D=
 {
     },
 };
=20
-static void ics_simple_initfn(Object *obj)
-{
-    ICSState *ics =3D ICS_SIMPLE(obj);
-
-    ics->offset =3D XICS_IRQ_BASE;
-}
-
 static void ics_simple_realize(DeviceState *dev, Error **errp)
 {
     ICSState *ics =3D ICS_SIMPLE(dev);
@@ -655,7 +648,6 @@ static const TypeInfo ics_simple_info =3D {
     .instance_size =3D sizeof(ICSState),
     .class_init =3D ics_simple_class_init,
     .class_size =3D sizeof(ICSStateClass),
-    .instance_init =3D ics_simple_initfn,
 };
=20
 static void ics_base_realize(DeviceState *dev, Error **errp)
@@ -679,6 +671,13 @@ static void ics_base_realize(DeviceState *dev, Error=
 **errp)
     ics->irqs =3D g_malloc0(ics->nr_irqs * sizeof(ICSIRQState));
 }
=20
+static void ics_base_instance_init(Object *obj)
+{
+    ICSState *ics =3D ICS_BASE(obj);
+
+    ics->offset =3D XICS_IRQ_BASE;
+}
+
 static Property ics_base_properties[] =3D {
     DEFINE_PROP_UINT32("nr-irqs", ICSState, nr_irqs, 0),
     DEFINE_PROP_END_OF_LIST(),
@@ -697,6 +696,7 @@ static const TypeInfo ics_base_info =3D {
     .parent =3D TYPE_DEVICE,
     .abstract =3D true,
     .instance_size =3D sizeof(ICSState),
+    .instance_init =3D ics_base_instance_init,
     .class_init =3D ics_base_class_init,
     .class_size =3D sizeof(ICSStateClass),
 };
--=20
2.17.1
