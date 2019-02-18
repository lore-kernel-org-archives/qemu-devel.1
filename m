Received: from eggs.gnu.org ([209.51.188.92]:39147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjxo-0006Q2-0C
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjxh-00032L-Si
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:07 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Feb 2019 01:30:24 +1100
Message-Id: <20190218143049.17142-19-david@gibson.dropbear.id.au>
In-Reply-To: <20190218143049.17142-1-david@gibson.dropbear.id.au>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/43] xics: Handle KVM ICP reset from the
 common code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

The KVM ICP reset handler simply writes the ICP state to KVM. This
doesn't need the overkill parent_reset logic we have today. Call
icp_set_kvm_state() from the base ICP reset function instead.

Since there are no other users for ICPStateClass::parent_reset, and
it isn't currently expected to change, drop it as well.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155023079461.1011724.12644984391500635645.stgit@bahia.lan>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c        | 12 ++++--------
 hw/intc/xics_kvm.c    | 11 -----------
 include/hw/ppc/xics.h |  1 -
 3 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 988b53abd1..822d367e63 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -289,7 +289,7 @@ static const VMStateDescription vmstate_icp_server =3D=
 {
     },
 };
=20
-static void icp_reset(DeviceState *dev)
+static void icp_reset_handler(void *dev)
 {
     ICPState *icp =3D ICP(dev);
=20
@@ -299,13 +299,10 @@ static void icp_reset(DeviceState *dev)
=20
     /* Make all outputs are deasserted */
     qemu_set_irq(icp->output, 0);
-}
=20
-static void icp_reset_handler(void *dev)
-{
-    DeviceClass *dc =3D DEVICE_GET_CLASS(dev);
-
-    dc->reset(dev);
+    if (kvm_irqchip_in_kernel()) {
+        icp_set_kvm_state(ICP(dev));
+    }
 }
=20
 static void icp_realize(DeviceState *dev, Error **errp)
@@ -370,7 +367,6 @@ static void icp_class_init(ObjectClass *klass, void *=
data)
=20
     dc->realize =3D icp_realize;
     dc->unrealize =3D icp_unrealize;
-    dc->reset =3D icp_reset;
 }
=20
 static const TypeInfo icp_info =3D {
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 7efa99b8b4..80321e9b75 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -115,15 +115,6 @@ int icp_set_kvm_state(ICPState *icp)
     return 0;
 }
=20
-static void icp_kvm_reset(DeviceState *dev)
-{
-    ICPStateClass *icpc =3D ICP_GET_CLASS(dev);
-
-    icpc->parent_reset(dev);
-
-    icp_set_kvm_state(ICP(dev));
-}
-
 static void icp_kvm_realize(DeviceState *dev, Error **errp)
 {
     ICPState *icp =3D ICP(dev);
@@ -176,8 +167,6 @@ static void icp_kvm_class_init(ObjectClass *klass, vo=
id *data)
=20
     device_class_set_parent_realize(dc, icp_kvm_realize,
                                     &icpc->parent_realize);
-    device_class_set_parent_reset(dc, icp_kvm_reset,
-                                  &icpc->parent_reset);
 }
=20
 static const TypeInfo icp_kvm_info =3D {
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 3236ccec92..e33282a576 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -65,7 +65,6 @@ struct ICPStateClass {
     DeviceClass parent_class;
=20
     DeviceRealize parent_realize;
-    DeviceReset parent_reset;
 };
=20
 struct ICPState {
--=20
2.20.1
