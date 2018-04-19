Received: from eggs.gnu.org ([2001:4830:134:3::10]:58473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98xS-0001bH-CA
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:46:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98xO-0001Bl-DU
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:46:38 -0400
Received: from 10.mo3.mail-out.ovh.net ([87.98.165.232]:52202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f98xO-0001Am-3e
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:46:34 -0400
Received: from player792.ha.ovh.net (unknown [10.109.120.49])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id A8C4D1B38FE
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:46:32 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Apr 2018 14:43:25 +0200
Message-Id: <20180419124331.3915-30-clg@kaod.org>
In-Reply-To: <20180419124331.3915-1-clg@kaod.org>
References: <20180419124331.3915-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 29/35] spapr/xive,
 xics: use the CPU_INTC handlers to reset KVM
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

The vCPUs are disconnected from the KVM device using a 'disable=3D1' as
last argument of the KVM_ENABLE_CAP ioctl. This is a bit hacky, we
should probably introduce a KVM_DISABLE_CAP ioctl.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive_kvm.c | 55 ++++++++++++++++++++++++++++++++++++++++++=
++++--
 hw/intc/xics.c           |  4 ++++
 hw/intc/xics_kvm.c       | 48 ++++++++++++++++++++++++++++++++++++++++--
 hw/intc/xive.c           |  5 +++++
 hw/ppc/spapr_cpu_core.c  |  8 +++++++
 5 files changed, 116 insertions(+), 4 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index ec5613fc2804..e3851991653e 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -15,6 +15,7 @@
 #include "sysemu/cpus.h"
 #include "sysemu/kvm.h"
 #include "monitor/monitor.h"
+#include "hw/intc/intc.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_xive.h"
 #include "hw/ppc/xive.h"
@@ -47,6 +48,25 @@ static bool xive_nvt_kvm_cpu_is_enabled(CPUState *cs)
     return false;
 }
=20
+static void xive_nvt_kvm_cpu_disable(CPUState *cs, Error **errp)
+{
+    KVMEnabledCPU *enabled_cpu;
+    unsigned long vcpu_id =3D kvm_arch_vcpu_id(cs);
+
+    QLIST_FOREACH(enabled_cpu, &kvm_enabled_cpus, node) {
+        if (enabled_cpu->vcpu_id =3D=3D vcpu_id) {
+            break;
+        }
+    }
+
+    if (enabled_cpu->vcpu_id =3D=3D vcpu_id) {
+        QLIST_REMOVE(enabled_cpu, node);
+        g_free(enabled_cpu);
+    } else {
+        error_setg(errp, "Can not find enabled CPU%ld", vcpu_id);
+    }
+}
+
 static void xive_nvt_kvm_cpu_enable(CPUState *cs)
 {
     KVMEnabledCPU *enabled_cpu;
@@ -183,8 +203,36 @@ static void xive_nvt_kvm_reset(XiveNVT *nvt)
     xive_nvt_kvm_set_state(nvt, 1);
 }
=20
-static void xive_nvt_kvm_realize(XiveNVT *nvt, Error **errp)
+static void xive_nvt_kvm_disconnect(CPUIntc *intc, Error **errp)
 {
+    XiveNVT *nvt =3D XIVE_NVT_KVM(intc);
+    CPUState *cs =3D nvt->cs;
+    unsigned long vcpu_id =3D kvm_arch_vcpu_id(cs);
+    int ret;
+
+    if (kernel_xive_fd =3D=3D -1) {
+        return;
+    }
+
+    /* Disable IRQ capability with a 'disable=3D1' as last argument.
+     *
+     * This is a bit hacky, we should introduce a KVM_DISABLE_CAP
+     * iotcl
+     */
+    ret =3D kvm_vcpu_enable_cap(cs, KVM_CAP_PPC_IRQ_XIVE, 0, kernel_xive=
_fd,
+                              vcpu_id, 1);
+    if (ret < 0) {
+        error_setg(errp, "Unable to disconnect CPU%ld from KVM XIVE devi=
ce: %s",
+                   vcpu_id, strerror(errno));
+        return;
+    }
+
+    xive_nvt_kvm_cpu_disable(cs, errp);
+}
+
+static void xive_nvt_kvm_connect(CPUIntc *intc, Error **errp)
+{
+    XiveNVT *nvt =3D XIVE_NVT_KVM(intc);
     CPUState *cs =3D nvt->cs;
     unsigned long vcpu_id =3D kvm_arch_vcpu_id(cs);
     int ret;
@@ -209,14 +257,17 @@ static void xive_nvt_kvm_class_init(ObjectClass *kl=
ass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     XiveNVTClass *xnc =3D XIVE_NVT_CLASS(klass);
+    CPUIntcClass *cic =3D CPU_INTC_CLASS(klass);
=20
     dc->desc =3D "XIVE KVM Interrupt Presenter";
=20
-    xnc->realize =3D xive_nvt_kvm_realize;
     xnc->synchronize_state =3D xive_nvt_kvm_synchronize_state;
     xnc->reset =3D xive_nvt_kvm_reset;
     xnc->pre_save =3D xive_nvt_kvm_get_state;
     xnc->post_load =3D xive_nvt_kvm_set_state;
+
+    cic->connect =3D xive_nvt_kvm_connect;
+    cic->disconnect =3D xive_nvt_kvm_disconnect;
 }
=20
 static const TypeInfo xive_nvt_kvm_info =3D {
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index e73e623e3b53..48fed2731fd2 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -381,6 +381,10 @@ static const TypeInfo icp_info =3D {
     .instance_size =3D sizeof(ICPState),
     .class_init =3D icp_class_init,
     .class_size =3D sizeof(ICPStateClass),
+    .interfaces =3D (InterfaceInfo[]) {
+        { TYPE_CPU_INTC },
+        { }
+    }
 };
=20
 Object *icp_create(Object *cpu, const char *type, XICSFabric *xi, Error =
**errp)
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index e727397c4a4d..62ea4ea150f2 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -32,6 +32,7 @@
 #include "hw/hw.h"
 #include "trace.h"
 #include "sysemu/kvm.h"
+#include "hw/intc/intc.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/xics.h"
 #include "kvm_ppc.h"
@@ -137,8 +138,48 @@ static void icp_kvm_reset(ICPState *icp)
     icp_set_kvm_state(icp, 1);
 }
=20
-static void icp_kvm_realize(ICPState *icp, Error **errp)
+static void icp_kvm_disconnect(CPUIntc *intc, Error **errp)
 {
+    ICPState *icp =3D ICP(intc);
+    CPUState *cs =3D icp->cs;
+    KVMEnabledICP *enabled_icp;
+    unsigned long vcpu_id =3D kvm_arch_vcpu_id(cs);
+    int ret;
+
+    if (kernel_xics_fd =3D=3D -1) {
+        return;
+    }
+
+    /* Disable IRQ capability with a 'disable=3D1' as last argument.
+     *
+     * This is a bit hacky, we should introduce a KVM_DISABLE_CAP
+     * iotcl
+     */
+    ret =3D kvm_vcpu_enable_cap(cs, KVM_CAP_IRQ_XICS, 0, kernel_xics_fd,
+                              vcpu_id, 1);
+    if (ret < 0) {
+        error_setg(errp, "Unable to disconnect CPU%ld to kernel XICS: %s=
",
+                   vcpu_id, strerror(errno));
+        return;
+    }
+
+    QLIST_FOREACH(enabled_icp, &kvm_enabled_icps, node) {
+        if (enabled_icp->vcpu_id =3D=3D vcpu_id) {
+            break;
+        }
+    }
+
+    if (enabled_icp->vcpu_id =3D=3D vcpu_id) {
+        QLIST_REMOVE(enabled_icp, node);
+        g_free(enabled_icp);
+    } else {
+        error_setg(errp, "Can not find enabled CPU%ld", vcpu_id);
+    }
+ }
+
+static void icp_kvm_connect(CPUIntc *intc, Error **errp)
+{
+    ICPState *icp =3D ICP(intc);
     CPUState *cs =3D icp->cs;
     KVMEnabledICP *enabled_icp;
     unsigned long vcpu_id =3D kvm_arch_vcpu_id(cs);
@@ -173,12 +214,15 @@ static void icp_kvm_realize(ICPState *icp, Error **=
errp)
 static void icp_kvm_class_init(ObjectClass *klass, void *data)
 {
     ICPStateClass *icpc =3D ICP_CLASS(klass);
+    CPUIntcClass *cic =3D CPU_INTC_CLASS(klass);
=20
     icpc->pre_save =3D icp_get_kvm_state;
     icpc->post_load =3D icp_set_kvm_state;
-    icpc->realize =3D icp_kvm_realize;
     icpc->reset =3D icp_kvm_reset;
     icpc->synchronize_state =3D icp_synchronize_state;
+
+    cic->connect =3D icp_kvm_connect;
+    cic->disconnect =3D icp_kvm_disconnect;
 }
=20
 static const TypeInfo icp_kvm_info =3D {
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index d96732cfe6be..4a9b09e3d819 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -14,6 +14,7 @@
 #include "sysemu/cpus.h"
 #include "sysemu/dma.h"
 #include "monitor/monitor.h"
+#include "hw/intc/intc.h"
 #include "hw/ppc/xics.h" /* for ICP_PROP_CPU */
 #include "hw/ppc/xive.h"
 #include "hw/ppc/xive_regs.h"
@@ -513,6 +514,10 @@ static const TypeInfo xive_nvt_info =3D {
     .instance_init =3D xive_nvt_init,
     .class_init    =3D xive_nvt_class_init,
     .class_size    =3D sizeof(XiveNVTClass),
+    .interfaces =3D (InterfaceInfo[]) {
+        { TYPE_CPU_INTC },
+        { }
+    }
 };
=20
 /*
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 3df2bda53f50..aa612cb1c9f6 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -16,6 +16,7 @@
 #include "sysemu/cpus.h"
 #include "sysemu/kvm.h"
 #include "target/ppc/kvm_ppc.h"
+#include "hw/intc/intc.h"
 #include "hw/ppc/ppc.h"
 #include "target/ppc/mmu-hash64.h"
 #include "sysemu/numa.h"
@@ -105,6 +106,7 @@ static void spapr_cpu_core_unrealizefn(DeviceState *d=
ev, Error **errp)
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
=20
         spapr_cpu_destroy(cpu);
+        cpu_intc_disconnect(CPU_INTC(cpu->intc), NULL);
         object_unparent(cpu->intc);
         cpu_remove_sync(cs);
         object_unparent(obj);
@@ -134,6 +136,10 @@ static void spapr_cpu_core_realize_child(Object *chi=
ld,
         goto error;
     }
=20
+    cpu_intc_connect(CPU_INTC(cpu->intc), &local_err);
+    if (local_err) {
+        goto error;
+    }
     return;
=20
 error:
@@ -263,6 +269,7 @@ void spapr_cpu_core_reset_icp(Error **errp)
=20
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+        cpu_intc_disconnect(CPU_INTC(cpu->intc), errp);
         cpu->intc =3D NULL;
     }
 }
@@ -298,5 +305,6 @@ void spapr_cpu_core_set_icp(const char *icp_type, Err=
or **errp)
         }
=20
         cpu->intc =3D args.icp;
+        cpu_intc_connect(CPU_INTC(cpu->intc), errp);
     }
 }
--=20
2.13.6
