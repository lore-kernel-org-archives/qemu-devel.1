Received: from eggs.gnu.org ([2001:4830:134:3::10]:47115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCRz-0003zC-Ta
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCRy-0006fX-AH
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:11 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  9 Jun 2017 15:26:45 +1000
Message-Id: <20170609052652.23200-14-david@gibson.dropbear.id.au>
In-Reply-To: <20170609052652.23200-1-david@gibson.dropbear.id.au>
References: <20170609052652.23200-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/20] xics: add reset() handler to ICPStateClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, sursingh@redhat.com, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Taking into account that qemu_set_irq() returns immediatly if its first
argument is NULL, icp_kvm_reset() largely duplicates icp_reset().

This patch introduces a reset() handler, so that the common logic can
be implemented in icp_reset() only.

While there we can also drop icp_kvm_realize() and icp_kvm_unrealize(). T=
his
causes icp-kvm to be realized in icp_realize(), which sets icp->xics, but
it has no impact.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c        |  5 +++++
 hw/intc/xics_kvm.c    | 27 ++-------------------------
 include/hw/ppc/xics.h |  1 +
 3 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index ea35167..ec73f02 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -325,6 +325,7 @@ static const VMStateDescription vmstate_icp_server =3D=
 {
 static void icp_reset(void *dev)
 {
     ICPState *icp =3D ICP(dev);
+    ICPStateClass *icpc =3D ICP_GET_CLASS(icp);
=20
     icp->xirr =3D 0;
     icp->pending_priority =3D 0xff;
@@ -332,6 +333,10 @@ static void icp_reset(void *dev)
=20
     /* Make all outputs are deasserted */
     qemu_set_irq(icp->output, 0);
+
+    if (icpc->reset) {
+        icpc->reset(icp);
+    }
 }
=20
 static void icp_realize(DeviceState *dev, Error **errp)
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 14b8f6f..45bf110 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -110,19 +110,8 @@ static int icp_set_kvm_state(ICPState *icp, int vers=
ion_id)
     return 0;
 }
=20
-static void icp_kvm_reset(void *dev)
+static void icp_kvm_reset(ICPState *icp)
 {
-    ICPState *icp =3D ICP(dev);
-
-    icp->xirr =3D 0;
-    icp->pending_priority =3D 0xff;
-    icp->mfrr =3D 0xff;
-
-    /* Make all outputs as deasserted only if the CPU thread is in use *=
/
-    if (icp->output) {
-        qemu_set_irq(icp->output, 0);
-    }
-
     icp_set_kvm_state(icp, 1);
 }
=20
@@ -159,26 +148,14 @@ static void icp_kvm_cpu_setup(ICPState *icp, PowerP=
CCPU *cpu)
     QLIST_INSERT_HEAD(&kvm_enabled_icps, enabled_icp, node);
 }
=20
-static void icp_kvm_realize(DeviceState *dev, Error **errp)
-{
-    qemu_register_reset(icp_kvm_reset, dev);
-}
-
-static void icp_kvm_unrealize(DeviceState *dev, Error **errp)
-{
-    qemu_unregister_reset(icp_kvm_reset, dev);
-}
-
 static void icp_kvm_class_init(ObjectClass *klass, void *data)
 {
-    DeviceClass *dc =3D DEVICE_CLASS(klass);
     ICPStateClass *icpc =3D ICP_CLASS(klass);
=20
-    dc->realize =3D icp_kvm_realize;
-    dc->unrealize =3D icp_kvm_unrealize;
     icpc->pre_save =3D icp_get_kvm_state;
     icpc->post_load =3D icp_set_kvm_state;
     icpc->cpu_setup =3D icp_kvm_cpu_setup;
+    icpc->reset =3D icp_kvm_reset;
 }
=20
 static const TypeInfo icp_kvm_info =3D {
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index a3073f9..40a506e 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -69,6 +69,7 @@ struct ICPStateClass {
     void (*pre_save)(ICPState *s);
     int (*post_load)(ICPState *s, int version_id);
     void (*cpu_setup)(ICPState *icp, PowerPCCPU *cpu);
+    void (*reset)(ICPState *icp);
 };
=20
 struct ICPState {
--=20
2.9.4
