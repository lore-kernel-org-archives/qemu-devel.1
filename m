Received: from eggs.gnu.org ([2001:4830:134:3::10]:39075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMM3-00033O-Jx
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:32:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMLz-0008LQ-Ii
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:32:47 -0500
Received: from 13.mo6.mail-out.ovh.net ([188.165.56.124]:44047)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ciMLz-0008Ky-9W
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:32:43 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 018D3B38EF
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 15:32:41 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 27 Feb 2017 15:29:33 +0100
Message-Id: <1488205773-30436-27-git-send-email-clg@kaod.org>
In-Reply-To: <1488205773-30436-1-git-send-email-clg@kaod.org>
References: <1488205773-30436-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 26/26] ppc/xics: rename 'ICPState *'
 variables to 'icp'
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

'ICPState *' variables are currently named 'ss'. This is confusing, so
let's give them an appropriate name: 'icp'.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics.c     | 154 ++++++++++++++++++++++++++---------------------=
------
 hw/intc/xics_kvm.c |  34 ++++++------
 2 files changed, 94 insertions(+), 94 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 5bcb9550abb5..ffc0747c7fa2 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -52,38 +52,38 @@ int xics_get_cpu_index_by_dt_id(int cpu_dt_id)
 void xics_cpu_destroy(XICSFabric *xi, PowerPCCPU *cpu)
 {
     CPUState *cs =3D CPU(cpu);
-    ICPState *ss =3D xics_icp_get(xi, cs->cpu_index);
+    ICPState *icp =3D xics_icp_get(xi, cs->cpu_index);
=20
-    assert(ss);
-    assert(cs =3D=3D ss->cs);
+    assert(icp);
+    assert(cs =3D=3D icp->cs);
=20
-    ss->output =3D NULL;
-    ss->cs =3D NULL;
+    icp->output =3D NULL;
+    icp->cs =3D NULL;
 }
=20
 void xics_cpu_setup(XICSFabric *xi, PowerPCCPU *cpu)
 {
     CPUState *cs =3D CPU(cpu);
     CPUPPCState *env =3D &cpu->env;
-    ICPState *ss =3D xics_icp_get(xi, cs->cpu_index);
+    ICPState *icp =3D xics_icp_get(xi, cs->cpu_index);
     ICPStateClass *icpc;
=20
-    assert(ss);
+    assert(icp);
=20
-    ss->cs =3D cs;
+    icp->cs =3D cs;
=20
-    icpc =3D ICP_GET_CLASS(ss);
+    icpc =3D ICP_GET_CLASS(icp);
     if (icpc->cpu_setup) {
-        icpc->cpu_setup(ss, cpu);
+        icpc->cpu_setup(icp, cpu);
     }
=20
     switch (PPC_INPUT(env)) {
     case PPC_FLAGS_INPUT_POWER7:
-        ss->output =3D env->irq_inputs[POWER7_INPUT_INT];
+        icp->output =3D env->irq_inputs[POWER7_INPUT_INT];
         break;
=20
     case PPC_FLAGS_INPUT_970:
-        ss->output =3D env->irq_inputs[PPC970_INPUT_INT];
+        icp->output =3D env->irq_inputs[PPC970_INPUT_INT];
         break;
=20
     default:
@@ -137,8 +137,8 @@ void ics_pic_print_info(ICSState *ics, Monitor *mon)
 #define XISR_MASK  0x00ffffff
 #define CPPR_MASK  0xff000000
=20
-#define XISR(ss)   (((ss)->xirr) & XISR_MASK)
-#define CPPR(ss)   (((ss)->xirr) >> 24)
+#define XISR(icp)   (((icp)->xirr) & XISR_MASK)
+#define CPPR(icp)   (((icp)->xirr) >> 24)
=20
 static void ics_reject(ICSState *ics, uint32_t nr)
 {
@@ -167,152 +167,152 @@ static void ics_eoi(ICSState *ics, int nr)
     }
 }
=20
-static void icp_check_ipi(ICPState *ss)
+static void icp_check_ipi(ICPState *icp)
 {
-    if (XISR(ss) && (ss->pending_priority <=3D ss->mfrr)) {
+    if (XISR(icp) && (icp->pending_priority <=3D icp->mfrr)) {
         return;
     }
=20
-    trace_xics_icp_check_ipi(ss->cs->cpu_index, ss->mfrr);
+    trace_xics_icp_check_ipi(icp->cs->cpu_index, icp->mfrr);
=20
-    if (XISR(ss) && ss->xirr_owner) {
-        ics_reject(ss->xirr_owner, XISR(ss));
+    if (XISR(icp) && icp->xirr_owner) {
+        ics_reject(icp->xirr_owner, XISR(icp));
     }
=20
-    ss->xirr =3D (ss->xirr & ~XISR_MASK) | XICS_IPI;
-    ss->pending_priority =3D ss->mfrr;
-    ss->xirr_owner =3D NULL;
-    qemu_irq_raise(ss->output);
+    icp->xirr =3D (icp->xirr & ~XISR_MASK) | XICS_IPI;
+    icp->pending_priority =3D icp->mfrr;
+    icp->xirr_owner =3D NULL;
+    qemu_irq_raise(icp->output);
 }
=20
-void icp_resend(ICPState *ss)
+void icp_resend(ICPState *icp)
 {
-    XICSFabric *xi =3D ss->xics;
+    XICSFabric *xi =3D icp->xics;
     XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(xi);
=20
-    if (ss->mfrr < CPPR(ss)) {
-        icp_check_ipi(ss);
+    if (icp->mfrr < CPPR(icp)) {
+        icp_check_ipi(icp);
     }
=20
     xic->ics_resend(xi);
 }
=20
-void icp_set_cppr(ICPState *ss, uint8_t cppr)
+void icp_set_cppr(ICPState *icp, uint8_t cppr)
 {
     uint8_t old_cppr;
     uint32_t old_xisr;
=20
-    old_cppr =3D CPPR(ss);
-    ss->xirr =3D (ss->xirr & ~CPPR_MASK) | (cppr << 24);
+    old_cppr =3D CPPR(icp);
+    icp->xirr =3D (icp->xirr & ~CPPR_MASK) | (cppr << 24);
=20
     if (cppr < old_cppr) {
-        if (XISR(ss) && (cppr <=3D ss->pending_priority)) {
-            old_xisr =3D XISR(ss);
-            ss->xirr &=3D ~XISR_MASK; /* Clear XISR */
-            ss->pending_priority =3D 0xff;
-            qemu_irq_lower(ss->output);
-            if (ss->xirr_owner) {
-                ics_reject(ss->xirr_owner, old_xisr);
-                ss->xirr_owner =3D NULL;
+        if (XISR(icp) && (cppr <=3D icp->pending_priority)) {
+            old_xisr =3D XISR(icp);
+            icp->xirr &=3D ~XISR_MASK; /* Clear XISR */
+            icp->pending_priority =3D 0xff;
+            qemu_irq_lower(icp->output);
+            if (icp->xirr_owner) {
+                ics_reject(icp->xirr_owner, old_xisr);
+                icp->xirr_owner =3D NULL;
             }
         }
     } else {
-        if (!XISR(ss)) {
-            icp_resend(ss);
+        if (!XISR(icp)) {
+            icp_resend(icp);
         }
     }
 }
=20
-void icp_set_mfrr(ICPState *ss, uint8_t mfrr)
+void icp_set_mfrr(ICPState *icp, uint8_t mfrr)
 {
-    ss->mfrr =3D mfrr;
-    if (mfrr < CPPR(ss)) {
-        icp_check_ipi(ss);
+    icp->mfrr =3D mfrr;
+    if (mfrr < CPPR(icp)) {
+        icp_check_ipi(icp);
     }
 }
=20
-uint32_t icp_accept(ICPState *ss)
+uint32_t icp_accept(ICPState *icp)
 {
-    uint32_t xirr =3D ss->xirr;
+    uint32_t xirr =3D icp->xirr;
=20
-    qemu_irq_lower(ss->output);
-    ss->xirr =3D ss->pending_priority << 24;
-    ss->pending_priority =3D 0xff;
-    ss->xirr_owner =3D NULL;
+    qemu_irq_lower(icp->output);
+    icp->xirr =3D icp->pending_priority << 24;
+    icp->pending_priority =3D 0xff;
+    icp->xirr_owner =3D NULL;
=20
-    trace_xics_icp_accept(xirr, ss->xirr);
+    trace_xics_icp_accept(xirr, icp->xirr);
=20
     return xirr;
 }
=20
-uint32_t icp_ipoll(ICPState *ss, uint32_t *mfrr)
+uint32_t icp_ipoll(ICPState *icp, uint32_t *mfrr)
 {
     if (mfrr) {
-        *mfrr =3D ss->mfrr;
+        *mfrr =3D icp->mfrr;
     }
-    return ss->xirr;
+    return icp->xirr;
 }
=20
-void icp_eoi(ICPState *ss, uint32_t xirr)
+void icp_eoi(ICPState *icp, uint32_t xirr)
 {
-    XICSFabric *xi =3D ss->xics;
+    XICSFabric *xi =3D icp->xics;
     XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(xi);
     ICSState *ics;
     uint32_t irq;
=20
     /* Send EOI -> ICS */
-    ss->xirr =3D (ss->xirr & ~CPPR_MASK) | (xirr & CPPR_MASK);
-    trace_xics_icp_eoi(ss->cs->cpu_index, xirr, ss->xirr);
+    icp->xirr =3D (icp->xirr & ~CPPR_MASK) | (xirr & CPPR_MASK);
+    trace_xics_icp_eoi(icp->cs->cpu_index, xirr, icp->xirr);
     irq =3D xirr & XISR_MASK;
=20
     ics =3D xic->ics_get(xi, irq);
     if (ics) {
         ics_eoi(ics, irq);
     }
-    if (!XISR(ss)) {
-        icp_resend(ss);
+    if (!XISR(icp)) {
+        icp_resend(icp);
     }
 }
=20
 static void icp_irq(ICSState *ics, int server, int nr, uint8_t priority)
 {
-    ICPState *ss =3D xics_icp_get(ics->xics, server);
+    ICPState *icp =3D xics_icp_get(ics->xics, server);
=20
     trace_xics_icp_irq(server, nr, priority);
=20
-    if ((priority >=3D CPPR(ss))
-        || (XISR(ss) && (ss->pending_priority <=3D priority))) {
+    if ((priority >=3D CPPR(icp))
+        || (XISR(icp) && (icp->pending_priority <=3D priority))) {
         ics_reject(ics, nr);
     } else {
-        if (XISR(ss) && ss->xirr_owner) {
-            ics_reject(ss->xirr_owner, XISR(ss));
-            ss->xirr_owner =3D NULL;
+        if (XISR(icp) && icp->xirr_owner) {
+            ics_reject(icp->xirr_owner, XISR(icp));
+            icp->xirr_owner =3D NULL;
         }
-        ss->xirr =3D (ss->xirr & ~XISR_MASK) | (nr & XISR_MASK);
-        ss->xirr_owner =3D ics;
-        ss->pending_priority =3D priority;
-        trace_xics_icp_raise(ss->xirr, ss->pending_priority);
-        qemu_irq_raise(ss->output);
+        icp->xirr =3D (icp->xirr & ~XISR_MASK) | (nr & XISR_MASK);
+        icp->xirr_owner =3D ics;
+        icp->pending_priority =3D priority;
+        trace_xics_icp_raise(icp->xirr, icp->pending_priority);
+        qemu_irq_raise(icp->output);
     }
 }
=20
 static void icp_dispatch_pre_save(void *opaque)
 {
-    ICPState *ss =3D opaque;
-    ICPStateClass *info =3D ICP_GET_CLASS(ss);
+    ICPState *icp =3D opaque;
+    ICPStateClass *info =3D ICP_GET_CLASS(icp);
=20
     if (info->pre_save) {
-        info->pre_save(ss);
+        info->pre_save(icp);
     }
 }
=20
 static int icp_dispatch_post_load(void *opaque, int version_id)
 {
-    ICPState *ss =3D opaque;
-    ICPStateClass *info =3D ICP_GET_CLASS(ss);
+    ICPState *icp =3D opaque;
+    ICPStateClass *info =3D ICP_GET_CLASS(icp);
=20
     if (info->post_load) {
-        return info->post_load(ss, version_id);
+        return info->post_load(icp, version_id);
     }
=20
     return 0;
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 14de5d4bb8cc..0a3daca3bb5a 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -45,7 +45,7 @@ static int kernel_xics_fd =3D -1;
 /*
  * ICP-KVM
  */
-static void icp_get_kvm_state(ICPState *ss)
+static void icp_get_kvm_state(ICPState *icp)
 {
     uint64_t state;
     struct kvm_one_reg reg =3D {
@@ -55,25 +55,25 @@ static void icp_get_kvm_state(ICPState *ss)
     int ret;
=20
     /* ICP for this CPU thread is not in use, exiting */
-    if (!ss->cs) {
+    if (!icp->cs) {
         return;
     }
=20
-    ret =3D kvm_vcpu_ioctl(ss->cs, KVM_GET_ONE_REG, &reg);
+    ret =3D kvm_vcpu_ioctl(icp->cs, KVM_GET_ONE_REG, &reg);
     if (ret !=3D 0) {
         error_report("Unable to retrieve KVM interrupt controller state"
-                " for CPU %ld: %s", kvm_arch_vcpu_id(ss->cs), strerror(e=
rrno));
+                " for CPU %ld: %s", kvm_arch_vcpu_id(icp->cs), strerror(=
errno));
         exit(1);
     }
=20
-    ss->xirr =3D state >> KVM_REG_PPC_ICP_XISR_SHIFT;
-    ss->mfrr =3D (state >> KVM_REG_PPC_ICP_MFRR_SHIFT)
+    icp->xirr =3D state >> KVM_REG_PPC_ICP_XISR_SHIFT;
+    icp->mfrr =3D (state >> KVM_REG_PPC_ICP_MFRR_SHIFT)
         & KVM_REG_PPC_ICP_MFRR_MASK;
-    ss->pending_priority =3D (state >> KVM_REG_PPC_ICP_PPRI_SHIFT)
+    icp->pending_priority =3D (state >> KVM_REG_PPC_ICP_PPRI_SHIFT)
         & KVM_REG_PPC_ICP_PPRI_MASK;
 }
=20
-static int icp_set_kvm_state(ICPState *ss, int version_id)
+static int icp_set_kvm_state(ICPState *icp, int version_id)
 {
     uint64_t state;
     struct kvm_one_reg reg =3D {
@@ -83,18 +83,18 @@ static int icp_set_kvm_state(ICPState *ss, int versio=
n_id)
     int ret;
=20
     /* ICP for this CPU thread is not in use, exiting */
-    if (!ss->cs) {
+    if (!icp->cs) {
         return 0;
     }
=20
-    state =3D ((uint64_t)ss->xirr << KVM_REG_PPC_ICP_XISR_SHIFT)
-        | ((uint64_t)ss->mfrr << KVM_REG_PPC_ICP_MFRR_SHIFT)
-        | ((uint64_t)ss->pending_priority << KVM_REG_PPC_ICP_PPRI_SHIFT)=
;
+    state =3D ((uint64_t)icp->xirr << KVM_REG_PPC_ICP_XISR_SHIFT)
+        | ((uint64_t)icp->mfrr << KVM_REG_PPC_ICP_MFRR_SHIFT)
+        | ((uint64_t)icp->pending_priority << KVM_REG_PPC_ICP_PPRI_SHIFT=
);
=20
-    ret =3D kvm_vcpu_ioctl(ss->cs, KVM_SET_ONE_REG, &reg);
+    ret =3D kvm_vcpu_ioctl(icp->cs, KVM_SET_ONE_REG, &reg);
     if (ret !=3D 0) {
         error_report("Unable to restore KVM interrupt controller state (=
0x%"
-                PRIx64 ") for CPU %ld: %s", state, kvm_arch_vcpu_id(ss->=
cs),
+                PRIx64 ") for CPU %ld: %s", state, kvm_arch_vcpu_id(icp-=
>cs),
                 strerror(errno));
         return ret;
     }
@@ -118,7 +118,7 @@ static void icp_kvm_reset(DeviceState *dev)
     icp_set_kvm_state(icp, 1);
 }
=20
-static void icp_kvm_cpu_setup(ICPState *ss, PowerPCCPU *cpu)
+static void icp_kvm_cpu_setup(ICPState *icp, PowerPCCPU *cpu)
 {
     CPUState *cs =3D CPU(cpu);
     int ret;
@@ -132,7 +132,7 @@ static void icp_kvm_cpu_setup(ICPState *ss, PowerPCCP=
U *cpu)
      * which was hot-removed earlier we don't have to renable
      * KVM_CAP_IRQ_XICS capability again.
      */
-    if (ss->cap_irq_xics_enabled) {
+    if (icp->cap_irq_xics_enabled) {
         return;
     }
=20
@@ -143,7 +143,7 @@ static void icp_kvm_cpu_setup(ICPState *ss, PowerPCCP=
U *cpu)
                      kvm_arch_vcpu_id(cs), strerror(errno));
         exit(1);
     }
-    ss->cap_irq_xics_enabled =3D true;
+    icp->cap_irq_xics_enabled =3D true;
 }
=20
 static void icp_kvm_class_init(ObjectClass *klass, void *data)
--=20
2.7.4
