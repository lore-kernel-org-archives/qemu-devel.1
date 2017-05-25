Received: from eggs.gnu.org ([2001:4830:134:3::10]:57296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoQ-0006VW-5W
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoO-0007Th-HM
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:46 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 25 May 2017 13:51:20 +1000
Message-Id: <20170525035132.24268-7-david@gibson.dropbear.id.au>
In-Reply-To: <20170525035132.24268-1-david@gibson.dropbear.id.au>
References: <20170525035132.24268-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/18] xics_kvm: cache already enabled vCPU ids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, sbobroff@redhat.com, sursingh@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Since commit a45863bda90d ("xics_kvm: Don't enable KVM_CAP_IRQ_XICS if
already enabled"), we were able to re-hotplug a vCPU that had been hot-
unplugged ealier, thanks to a boolean flag in ICPState that we set when
enabling KVM_CAP_IRQ_XICS.

This could work because the lifecycle of all ICPState objects was the
same as the machine. Commit 5bc8d26de20c ("spapr: allocate the ICPState
object from under sPAPRCPUCore") broke this assumption and now we always
pass a freshly allocated ICPState object (ie, with the flag unset) to
icp_kvm_cpu_setup().

This cause re-hotplug to fail with:

Unable to connect CPU8 to kernel XICS: Device or resource busy

Let's fix this by caching all the vCPU ids for which KVM_CAP_IRQ_XICS was
enabled. This also drops the now useless boolean flag from ICPState.

Reported-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
Tested-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics_kvm.c    | 27 ++++++++++++++++++++-------
 include/hw/ppc/xics.h |  1 -
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index dd93531..dd7f298 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -42,6 +42,14 @@
=20
 static int kernel_xics_fd =3D -1;
=20
+typedef struct KVMEnabledICP {
+    unsigned long vcpu_id;
+    QLIST_ENTRY(KVMEnabledICP) node;
+} KVMEnabledICP;
+
+static QLIST_HEAD(, KVMEnabledICP)
+    kvm_enabled_icps =3D QLIST_HEAD_INITIALIZER(&kvm_enabled_icps);
+
 /*
  * ICP-KVM
  */
@@ -121,6 +129,8 @@ static void icp_kvm_reset(void *dev)
 static void icp_kvm_cpu_setup(ICPState *icp, PowerPCCPU *cpu)
 {
     CPUState *cs =3D CPU(cpu);
+    KVMEnabledICP *enabled_icp;
+    unsigned long vcpu_id =3D kvm_arch_vcpu_id(cs);
     int ret;
=20
     if (kernel_xics_fd =3D=3D -1) {
@@ -132,18 +142,21 @@ static void icp_kvm_cpu_setup(ICPState *icp, PowerP=
CCPU *cpu)
      * which was hot-removed earlier we don't have to renable
      * KVM_CAP_IRQ_XICS capability again.
      */
-    if (icp->cap_irq_xics_enabled) {
-        return;
+    QLIST_FOREACH(enabled_icp, &kvm_enabled_icps, node) {
+        if (enabled_icp->vcpu_id =3D=3D vcpu_id) {
+            return;
+        }
     }
=20
-    ret =3D kvm_vcpu_enable_cap(cs, KVM_CAP_IRQ_XICS, 0, kernel_xics_fd,
-                              kvm_arch_vcpu_id(cs));
+    ret =3D kvm_vcpu_enable_cap(cs, KVM_CAP_IRQ_XICS, 0, kernel_xics_fd,=
 vcpu_id);
     if (ret < 0) {
-        error_report("Unable to connect CPU%ld to kernel XICS: %s",
-                     kvm_arch_vcpu_id(cs), strerror(errno));
+        error_report("Unable to connect CPU%ld to kernel XICS: %s", vcpu=
_id,
+                     strerror(errno));
         exit(1);
     }
-    icp->cap_irq_xics_enabled =3D true;
+    enabled_icp =3D g_malloc(sizeof(*enabled_icp));
+    enabled_icp->vcpu_id =3D vcpu_id;
+    QLIST_INSERT_HEAD(&kvm_enabled_icps, enabled_icp, node);
 }
=20
 static void icp_kvm_realize(DeviceState *dev, Error **errp)
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index d6cb51f..a3073f9 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -81,7 +81,6 @@ struct ICPState {
     uint8_t pending_priority;
     uint8_t mfrr;
     qemu_irq output;
-    bool cap_irq_xics_enabled;
=20
     XICSFabric *xics;
 };
--=20
2.9.4
