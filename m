Received: from eggs.gnu.org ([209.51.188.92]:38979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjxZ-0006Dl-Ur
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:31:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjxQ-0002vd-Mh
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:31:48 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Feb 2019 01:30:25 +1100
Message-Id: <20190218143049.17142-20-david@gibson.dropbear.id.au>
In-Reply-To: <20190218143049.17142-1-david@gibson.dropbear.id.au>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/43] xics: Handle KVM ICP realize from the
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

The realization of KVM ICP currently follows the parent_realize logic,
which is a bit overkill here. Also we want to get rid of the KVM ICP
class. Explicitely call icp_kvm_realize() from the base ICP realize
function.

Note that ICPStateClass::parent_realize is retained because powernv
needs it.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155023080049.1011724.15423463482790260696.stgit@bahia.lan>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c        |  8 ++++++++
 hw/intc/xics_kvm.c    | 10 +---------
 include/hw/ppc/xics.h |  1 +
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 822d367e63..acd63ab5e0 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -349,6 +349,14 @@ static void icp_realize(DeviceState *dev, Error **er=
rp)
         return;
     }
=20
+    if (kvm_irqchip_in_kernel()) {
+        icp_kvm_realize(dev, &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+    }
+
     qemu_register_reset(icp_reset_handler, dev);
     vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, icp)=
;
 }
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 80321e9b75..4eebced516 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -115,11 +115,9 @@ int icp_set_kvm_state(ICPState *icp)
     return 0;
 }
=20
-static void icp_kvm_realize(DeviceState *dev, Error **errp)
+void icp_kvm_realize(DeviceState *dev, Error **errp)
 {
     ICPState *icp =3D ICP(dev);
-    ICPStateClass *icpc =3D ICP_GET_CLASS(icp);
-    Error *local_err =3D NULL;
     CPUState *cs;
     KVMEnabledICP *enabled_icp;
     unsigned long vcpu_id;
@@ -129,12 +127,6 @@ static void icp_kvm_realize(DeviceState *dev, Error =
**errp)
         abort();
     }
=20
-    icpc->parent_realize(dev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
     cs =3D icp->cs;
     vcpu_id =3D kvm_arch_vcpu_id(cs);
=20
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index e33282a576..ab61dc2401 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -202,5 +202,6 @@ Object *icp_create(Object *cpu, const char *type, XIC=
SFabric *xi,
 void icp_get_kvm_state(ICPState *icp);
 int icp_set_kvm_state(ICPState *icp);
 void icp_synchronize_state(ICPState *icp);
+void icp_kvm_realize(DeviceState *dev, Error **errp);
=20
 #endif /* XICS_H */
--=20
2.20.1
