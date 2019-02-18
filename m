Received: from eggs.gnu.org ([209.51.188.92]:39150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjxo-0006Q3-0a
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjxl-00034m-Jg
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:07 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Feb 2019 01:30:29 +1100
Message-Id: <20190218143049.17142-24-david@gibson.dropbear.id.au>
In-Reply-To: <20190218143049.17142-1-david@gibson.dropbear.id.au>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 23/43] xics: Handle KVM ICS reset from the
 "simple" ICS code
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

The KVM ICS reset handler simply writes the ICS state to KVM. This
doesn't need the overkill parent_reset logic we have today. Also
we want to use the same ICS type for the KVM and non-KVM case with
pseries.

Call icp_set_kvm_state() from the "simple" ICS reset function.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155023082407.1011724.1983100830860273401.stgit@bahia.lan>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c     |  4 ++++
 hw/intc/xics_kvm.c | 18 ------------------
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index ae5d5ea135..49401745c4 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -553,6 +553,10 @@ static void ics_simple_reset(DeviceState *dev)
     ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(dev);
=20
     icsc->parent_reset(dev);
+
+    if (kvm_irqchip_in_kernel()) {
+        ics_set_kvm_state(ICS_BASE(dev));
+    }
 }
=20
 static void ics_simple_reset_handler(void *dev)
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 642351e579..e7b8d4c29c 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -280,20 +280,6 @@ void ics_kvm_set_irq(void *opaque, int srcno, int va=
l)
     }
 }
=20
-static void ics_kvm_reset(DeviceState *dev)
-{
-    ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(dev);
-
-    icsc->parent_reset(dev);
-
-    ics_set_kvm_state(ICS_KVM(dev));
-}
-
-static void ics_kvm_reset_handler(void *dev)
-{
-    ics_kvm_reset(dev);
-}
-
 static void ics_kvm_realize(DeviceState *dev, Error **errp)
 {
     ICSState *ics =3D ICS_KVM(dev);
@@ -305,8 +291,6 @@ static void ics_kvm_realize(DeviceState *dev, Error *=
*errp)
         error_propagate(errp, local_err);
         return;
     }
-
-    qemu_register_reset(ics_kvm_reset_handler, ics);
 }
=20
 static void ics_kvm_class_init(ObjectClass *klass, void *data)
@@ -316,8 +300,6 @@ static void ics_kvm_class_init(ObjectClass *klass, vo=
id *data)
=20
     device_class_set_parent_realize(dc, ics_kvm_realize,
                                     &icsc->parent_realize);
-    device_class_set_parent_reset(dc, ics_kvm_reset,
-                                  &icsc->parent_reset);
 }
=20
 static const TypeInfo ics_kvm_info =3D {
--=20
2.20.1
