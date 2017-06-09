Received: from eggs.gnu.org ([2001:4830:134:3::10]:47092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCRz-0003yY-DD
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCRy-0006fJ-3Z
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:11 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  9 Jun 2017 15:26:51 +1000
Message-Id: <20170609052652.23200-20-david@gibson.dropbear.id.au>
In-Reply-To: <20170609052652.23200-1-david@gibson.dropbear.id.au>
References: <20170609052652.23200-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/20] xics: drop ICPStateClass::cpu_setup()
 handler
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

The cpu_setup() handler is only implemented by xics_kvm, where it really
does a typical "realize" job. Moreover, the realize() handler is called
shortly after cpu_setup(), on the same path.

This patch converts xics_kvm to implement realize() instead of cpu_setup(=
).

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c        |  4 ----
 hw/intc/xics_kvm.c    | 12 ++++++------
 include/hw/ppc/xics.h |  1 -
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index fdbfddf..7ccfb53 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -324,10 +324,6 @@ static void icp_realize(DeviceState *dev, Error **er=
rp)
     cpu->intc =3D OBJECT(icp);
     icp->cs =3D CPU(obj);
=20
-    if (icpc->cpu_setup) {
-        icpc->cpu_setup(icp, cpu);
-    }
-
     env =3D &cpu->env;
     switch (PPC_INPUT(env)) {
     case PPC_FLAGS_INPUT_POWER7:
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 41c5b94..3091ad3 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -115,9 +115,9 @@ static void icp_kvm_reset(ICPState *icp)
     icp_set_kvm_state(icp, 1);
 }
=20
-static void icp_kvm_cpu_setup(ICPState *icp, PowerPCCPU *cpu)
+static void icp_kvm_realize(ICPState *icp, Error **errp)
 {
-    CPUState *cs =3D CPU(cpu);
+    CPUState *cs =3D icp->cs;
     KVMEnabledICP *enabled_icp;
     unsigned long vcpu_id =3D kvm_arch_vcpu_id(cs);
     int ret;
@@ -139,9 +139,9 @@ static void icp_kvm_cpu_setup(ICPState *icp, PowerPCC=
PU *cpu)
=20
     ret =3D kvm_vcpu_enable_cap(cs, KVM_CAP_IRQ_XICS, 0, kernel_xics_fd,=
 vcpu_id);
     if (ret < 0) {
-        error_report("Unable to connect CPU%ld to kernel XICS: %s", vcpu=
_id,
-                     strerror(errno));
-        exit(1);
+        error_setg(errp, "Unable to connect CPU%ld to kernel XICS: %s", =
vcpu_id,
+                   strerror(errno));
+        return;
     }
     enabled_icp =3D g_malloc(sizeof(*enabled_icp));
     enabled_icp->vcpu_id =3D vcpu_id;
@@ -154,7 +154,7 @@ static void icp_kvm_class_init(ObjectClass *klass, vo=
id *data)
=20
     icpc->pre_save =3D icp_get_kvm_state;
     icpc->post_load =3D icp_set_kvm_state;
-    icpc->cpu_setup =3D icp_kvm_cpu_setup;
+    icpc->realize =3D icp_kvm_realize;
     icpc->reset =3D icp_kvm_reset;
 }
=20
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 37b8fb1..28d248a 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -68,7 +68,6 @@ struct ICPStateClass {
     void (*realize)(ICPState *icp, Error **errp);
     void (*pre_save)(ICPState *icp);
     int (*post_load)(ICPState *icp, int version_id);
-    void (*cpu_setup)(ICPState *icp, PowerPCCPU *cpu);
     void (*reset)(ICPState *icp);
 };
=20
--=20
2.9.4
