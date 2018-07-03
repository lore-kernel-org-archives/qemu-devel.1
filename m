Received: from eggs.gnu.org ([2001:4830:134:3::10]:39591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKQ-0002ll-2W
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKO-0006tb-L1
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:18 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  3 Jul 2018 15:57:33 +1000
Message-Id: <20180703055804.13449-5-david@gibson.dropbear.id.au>
In-Reply-To: <20180703055804.13449-1-david@gibson.dropbear.id.au>
References: <20180703055804.13449-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/35] ppc/xics: introduce ICP DeviceRealize and
 DeviceReset handlers
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

This changes the ICP realize and reset handlers in DeviceRealize and
DeviceReset handlers. parent handlers are now called from the
inheriting classes which is a cleaner object pattern.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c        | 10 ----------
 hw/intc/xics_kvm.c    | 34 +++++++++++++++++++++++++++-------
 hw/intc/xics_pnv.c    | 15 +++++++++++++--
 include/hw/ppc/xics.h |  5 +++--
 4 files changed, 43 insertions(+), 21 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index e73e623e3b..063491f387 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -294,7 +294,6 @@ static const VMStateDescription vmstate_icp_server =3D=
 {
 static void icp_reset(void *dev)
 {
     ICPState *icp =3D ICP(dev);
-    ICPStateClass *icpc =3D ICP_GET_CLASS(icp);
=20
     icp->xirr =3D 0;
     icp->pending_priority =3D 0xff;
@@ -302,16 +301,11 @@ static void icp_reset(void *dev)
=20
     /* Make all outputs are deasserted */
     qemu_set_irq(icp->output, 0);
-
-    if (icpc->reset) {
-        icpc->reset(icp);
-    }
 }
=20
 static void icp_realize(DeviceState *dev, Error **errp)
 {
     ICPState *icp =3D ICP(dev);
-    ICPStateClass *icpc =3D ICP_GET_CLASS(dev);
     PowerPCCPU *cpu;
     CPUPPCState *env;
     Object *obj;
@@ -351,10 +345,6 @@ static void icp_realize(DeviceState *dev, Error **er=
rp)
         return;
     }
=20
-    if (icpc->realize) {
-        icpc->realize(icp, errp);
-    }
-
     qemu_register_reset(icp_reset, dev);
     vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, icp)=
;
 }
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 8dba2f84e7..f511e50a80 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -114,22 +114,38 @@ static int icp_set_kvm_state(ICPState *icp, int ver=
sion_id)
     return 0;
 }
=20
-static void icp_kvm_reset(ICPState *icp)
+static void icp_kvm_reset(DeviceState *dev)
 {
-    icp_set_kvm_state(icp, 1);
+    ICPStateClass *icpc =3D ICP_GET_CLASS(dev);
+
+    icpc->parent_reset(dev);
+
+    icp_set_kvm_state(ICP(dev), 1);
 }
=20
-static void icp_kvm_realize(ICPState *icp, Error **errp)
+static void icp_kvm_realize(DeviceState *dev, Error **errp)
 {
-    CPUState *cs =3D icp->cs;
+    ICPState *icp =3D ICP(dev);
+    ICPStateClass *icpc =3D ICP_GET_CLASS(icp);
+    Error *local_err =3D NULL;
+    CPUState *cs;
     KVMEnabledICP *enabled_icp;
-    unsigned long vcpu_id =3D kvm_arch_vcpu_id(cs);
+    unsigned long vcpu_id;
     int ret;
=20
     if (kernel_xics_fd =3D=3D -1) {
         abort();
     }
=20
+    icpc->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    cs =3D icp->cs;
+    vcpu_id =3D kvm_arch_vcpu_id(cs);
+
     /*
      * If we are reusing a parked vCPU fd corresponding to the CPU
      * which was hot-removed earlier we don't have to renable
@@ -154,12 +170,16 @@ static void icp_kvm_realize(ICPState *icp, Error **=
errp)
=20
 static void icp_kvm_class_init(ObjectClass *klass, void *data)
 {
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
     ICPStateClass *icpc =3D ICP_CLASS(klass);
=20
+    device_class_set_parent_realize(dc, icp_kvm_realize,
+                                    &icpc->parent_realize);
+    device_class_set_parent_reset(dc, icp_kvm_reset,
+                                  &icpc->parent_reset);
+
     icpc->pre_save =3D icp_get_kvm_state;
     icpc->post_load =3D icp_set_kvm_state;
-    icpc->realize =3D icp_kvm_realize;
-    icpc->reset =3D icp_kvm_reset;
     icpc->synchronize_state =3D icp_synchronize_state;
 }
=20
diff --git a/hw/intc/xics_pnv.c b/hw/intc/xics_pnv.c
index c87de2189c..fa48505f36 100644
--- a/hw/intc/xics_pnv.c
+++ b/hw/intc/xics_pnv.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
 #include "hw/ppc/xics.h"
@@ -158,9 +159,18 @@ static const MemoryRegionOps pnv_icp_ops =3D {
     },
 };
=20
-static void pnv_icp_realize(ICPState *icp, Error **errp)
+static void pnv_icp_realize(DeviceState *dev, Error **errp)
 {
+    ICPState *icp =3D ICP(dev);
     PnvICPState *pnv_icp =3D PNV_ICP(icp);
+    ICPStateClass *icpc =3D ICP_GET_CLASS(icp);
+    Error *local_err =3D NULL;
+
+    icpc->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
=20
     memory_region_init_io(&pnv_icp->mmio, OBJECT(icp), &pnv_icp_ops,
                           icp, "icp-thread", 0x1000);
@@ -171,7 +181,8 @@ static void pnv_icp_class_init(ObjectClass *klass, vo=
id *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     ICPStateClass *icpc =3D ICP_CLASS(klass);
=20
-    icpc->realize =3D pnv_icp_realize;
+    device_class_set_parent_realize(dc, pnv_icp_realize,
+                                    &icpc->parent_realize);
     dc->desc =3D "PowerNV ICP";
 }
=20
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 6cebff47a7..4b04b295a7 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -65,10 +65,11 @@ typedef struct XICSFabric XICSFabric;
 struct ICPStateClass {
     DeviceClass parent_class;
=20
-    void (*realize)(ICPState *icp, Error **errp);
+    DeviceRealize parent_realize;
+    DeviceReset parent_reset;
+
     void (*pre_save)(ICPState *icp);
     int (*post_load)(ICPState *icp, int version_id);
-    void (*reset)(ICPState *icp);
     void (*synchronize_state)(ICPState *icp);
 };
=20
--=20
2.17.1
