Received: from eggs.gnu.org ([2001:4830:134:3::10]:38702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMLS-0002aZ-N5
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:32:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMLO-00088z-OE
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:32:10 -0500
Received: from 12.mo6.mail-out.ovh.net ([178.32.125.228]:50646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ciMLO-00088X-HM
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:32:06 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 44AB8B31FC
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 15:32:05 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 27 Feb 2017 15:29:24 +0100
Message-Id: <1488205773-30436-18-git-send-email-clg@kaod.org>
In-Reply-To: <1488205773-30436-1-git-send-email-clg@kaod.org>
References: <1488205773-30436-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 17/26] ppc/xics: move the cpu_setup()
 handler under the ICPState class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The cpu_setup() handler is currently under the XICSState class but it
really belongs under ICPState as it is setting up an individual vCPU.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics.c        |  8 +++----
 hw/intc/xics_kvm.c    | 58 +++++++++++++++++++++++++--------------------=
------
 include/hw/ppc/xics.h |  3 +--
 3 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index a5be0d83cf36..674ac4c91b77 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -66,15 +66,15 @@ void xics_cpu_setup(XICSState *xics, PowerPCCPU *cpu)
     CPUState *cs =3D CPU(cpu);
     CPUPPCState *env =3D &cpu->env;
     ICPState *ss =3D &xics->ss[cs->cpu_index];
-    XICSStateClass *info;
+    ICPStateClass *icpc;
=20
     assert(cs->cpu_index < xics->nr_servers);
=20
     ss->cs =3D cs;
=20
-    info =3D XICS_COMMON_GET_CLASS(xics);
-    if (info->cpu_setup) {
-        info->cpu_setup(ss, cpu);
+    icpc =3D ICP_GET_CLASS(ss);
+    if (icpc->cpu_setup) {
+        icpc->cpu_setup(ss, cpu);
     }
=20
     switch (PPC_INPUT(env)) {
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 7588280b5d69..07298b09712d 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -124,6 +124,34 @@ static void icp_kvm_reset(DeviceState *dev)
     icp_set_kvm_state(icp, 1);
 }
=20
+static void icp_kvm_cpu_setup(ICPState *ss, PowerPCCPU *cpu)
+{
+    CPUState *cs =3D CPU(cpu);
+    int ret;
+
+    if (kernel_xics_fd =3D=3D -1) {
+        abort();
+    }
+
+    /*
+     * If we are reusing a parked vCPU fd corresponding to the CPU
+     * which was hot-removed earlier we don't have to renable
+     * KVM_CAP_IRQ_XICS capability again.
+     */
+    if (ss->cap_irq_xics_enabled) {
+        return;
+    }
+
+    ret =3D kvm_vcpu_enable_cap(cs, KVM_CAP_IRQ_XICS, 0, kernel_xics_fd,
+                              kvm_arch_vcpu_id(cs));
+    if (ret < 0) {
+        error_report("Unable to connect CPU%ld to kernel XICS: %s",
+                     kvm_arch_vcpu_id(cs), strerror(errno));
+        exit(1);
+    }
+    ss->cap_irq_xics_enabled =3D true;
+}
+
 static void icp_kvm_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -132,6 +160,7 @@ static void icp_kvm_class_init(ObjectClass *klass, vo=
id *data)
     dc->reset =3D icp_kvm_reset;
     icpc->pre_save =3D icp_get_kvm_state;
     icpc->post_load =3D icp_set_kvm_state;
+    icpc->cpu_setup =3D icp_kvm_cpu_setup;
 }
=20
 static const TypeInfo icp_kvm_info =3D {
@@ -324,33 +353,6 @@ static const TypeInfo ics_kvm_info =3D {
 /*
  * XICS-KVM
  */
-static void xics_kvm_cpu_setup(ICPState *ss, PowerPCCPU *cpu)
-{
-    CPUState *cs =3D CPU(cpu);
-    int ret;
-
-    if (kernel_xics_fd =3D=3D -1) {
-        abort();
-    }
-
-    /*
-     * If we are reusing a parked vCPU fd corresponding to the CPU
-     * which was hot-removed earlier we don't have to renable
-     * KVM_CAP_IRQ_XICS capability again.
-     */
-    if (ss->cap_irq_xics_enabled) {
-        return;
-    }
-
-    ret =3D kvm_vcpu_enable_cap(cs, KVM_CAP_IRQ_XICS, 0, kernel_xics_fd,
-                              kvm_arch_vcpu_id(cs));
-    if (ret < 0) {
-        error_report("Unable to connect CPU%ld to kernel XICS: %s",
-                     kvm_arch_vcpu_id(cs), strerror(errno));
-        exit(1);
-    }
-    ss->cap_irq_xics_enabled =3D true;
-}
=20
 static void rtas_dummy(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                        uint32_t token,
@@ -429,10 +431,8 @@ fail:
 static void xics_kvm_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(oc);
-    XICSStateClass *xsc =3D XICS_COMMON_CLASS(oc);
=20
     dc->realize =3D xics_kvm_realize;
-    xsc->cpu_setup =3D xics_kvm_cpu_setup;
 }
=20
 static const TypeInfo xics_spapr_kvm_info =3D {
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 8325dbdaf104..d17f62c5cc82 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -73,8 +73,6 @@ typedef struct XICSFabric XICSFabric;
=20
 struct XICSStateClass {
     DeviceClass parent_class;
-
-    void (*cpu_setup)(ICPState *icp, PowerPCCPU *cpu);
 };
=20
 struct XICSState {
@@ -101,6 +99,7 @@ struct ICPStateClass {
=20
     void (*pre_save)(ICPState *s);
     int (*post_load)(ICPState *s, int version_id);
+    void (*cpu_setup)(ICPState *icp, PowerPCCPU *cpu);
 };
=20
 struct ICPState {
--=20
2.7.4
