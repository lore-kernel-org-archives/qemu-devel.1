Received: from eggs.gnu.org ([2001:4830:134:3::10]:38532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fSPbS-0003ee-K5
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:23:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fSPbO-0006rc-LK
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:23:34 -0400
Received: from 2.mo6.mail-out.ovh.net ([46.105.76.65]:41628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fSPbO-0006me-BO
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:23:30 -0400
Received: from player762.ha.ovh.net (unknown [10.109.105.92])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 8D62916341D
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 18:23:20 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 11 Jun 2018 18:23:10 +0200
Message-Id: <20180611162310.19968-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] xics_kvm: use KVM helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The KVM helpers hide the low level interface used to communicate to
the XICS KVM device and provide a good cleanup to the XICS KVM models.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics_kvm.c | 52 ++++++++++++++----------------------------------=
----
 1 file changed, 14 insertions(+), 38 deletions(-)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 89fb20e2c55c..8bdf6afe82a0 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -56,10 +56,6 @@ static QLIST_HEAD(, KVMEnabledICP)
 static void icp_get_kvm_state(ICPState *icp)
 {
     uint64_t state;
-    struct kvm_one_reg reg =3D {
-        .id =3D KVM_REG_PPC_ICP_STATE,
-        .addr =3D (uintptr_t)&state,
-    };
     int ret;
=20
     /* ICP for this CPU thread is not in use, exiting */
@@ -67,7 +63,7 @@ static void icp_get_kvm_state(ICPState *icp)
         return;
     }
=20
-    ret =3D kvm_vcpu_ioctl(icp->cs, KVM_GET_ONE_REG, &reg);
+    ret =3D kvm_get_one_reg(icp->cs, KVM_REG_PPC_ICP_STATE, &state);
     if (ret !=3D 0) {
         error_report("Unable to retrieve KVM interrupt controller state"
                 " for CPU %ld: %s", kvm_arch_vcpu_id(icp->cs), strerror(=
errno));
@@ -96,10 +92,6 @@ static void icp_synchronize_state(ICPState *icp)
 static int icp_set_kvm_state(ICPState *icp, int version_id)
 {
     uint64_t state;
-    struct kvm_one_reg reg =3D {
-        .id =3D KVM_REG_PPC_ICP_STATE,
-        .addr =3D (uintptr_t)&state,
-    };
     int ret;
=20
     /* ICP for this CPU thread is not in use, exiting */
@@ -111,7 +103,7 @@ static int icp_set_kvm_state(ICPState *icp, int versi=
on_id)
         | ((uint64_t)icp->mfrr << KVM_REG_PPC_ICP_MFRR_SHIFT)
         | ((uint64_t)icp->pending_priority << KVM_REG_PPC_ICP_PPRI_SHIFT=
);
=20
-    ret =3D kvm_vcpu_ioctl(icp->cs, KVM_SET_ONE_REG, &reg);
+    ret =3D kvm_set_one_reg(icp->cs, KVM_REG_PPC_ICP_STATE, &state);
     if (ret !=3D 0) {
         error_report("Unable to restore KVM interrupt controller state (=
0x%"
                 PRIx64 ") for CPU %ld: %s", state, kvm_arch_vcpu_id(icp-=
>cs),
@@ -185,21 +177,15 @@ static const TypeInfo icp_kvm_info =3D {
 static void ics_get_kvm_state(ICSState *ics)
 {
     uint64_t state;
-    struct kvm_device_attr attr =3D {
-        .flags =3D 0,
-        .group =3D KVM_DEV_XICS_GRP_SOURCES,
-        .addr =3D (uint64_t)(uintptr_t)&state,
-    };
     int i;
+    Error *local_err =3D NULL;
=20
     for (i =3D 0; i < ics->nr_irqs; i++) {
         ICSIRQState *irq =3D &ics->irqs[i];
-        int ret;
-
-        attr.attr =3D i + ics->offset;
=20
-        ret =3D ioctl(kernel_xics_fd, KVM_GET_DEVICE_ATTR, &attr);
-        if (ret !=3D 0) {
+        kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
+                          i + ics->offset, &state, false, &local_err);
+        if (local_err) {
             error_report("Unable to retrieve KVM interrupt controller st=
ate"
                     " for IRQ %d: %s", i + ics->offset, strerror(errno))=
;
             exit(1);
@@ -255,19 +241,13 @@ static void ics_synchronize_state(ICSState *ics)
 static int ics_set_kvm_state(ICSState *ics, int version_id)
 {
     uint64_t state;
-    struct kvm_device_attr attr =3D {
-        .flags =3D 0,
-        .group =3D KVM_DEV_XICS_GRP_SOURCES,
-        .addr =3D (uint64_t)(uintptr_t)&state,
-    };
     int i;
+    Error *local_err =3D NULL;
=20
     for (i =3D 0; i < ics->nr_irqs; i++) {
         ICSIRQState *irq =3D &ics->irqs[i];
         int ret;
=20
-        attr.attr =3D i + ics->offset;
-
         state =3D irq->server;
         state |=3D (uint64_t)(irq->saved_priority & KVM_XICS_PRIORITY_MA=
SK)
             << KVM_XICS_PRIORITY_SHIFT;
@@ -293,8 +273,9 @@ static int ics_set_kvm_state(ICSState *ics, int versi=
on_id)
                 state |=3D KVM_XICS_QUEUED;
         }
=20
-        ret =3D ioctl(kernel_xics_fd, KVM_SET_DEVICE_ATTR, &attr);
-        if (ret !=3D 0) {
+        kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
+                          i + ics->offset, &state, true, &local_err);
+        if (local_err) {
             error_report("Unable to restore KVM interrupt controller sta=
te"
                     " for IRQs %d: %s", i + ics->offset, strerror(errno)=
);
             return ret;
@@ -391,10 +372,6 @@ static void rtas_dummy(PowerPCCPU *cpu, sPAPRMachine=
State *spapr,
 int xics_kvm_init(sPAPRMachineState *spapr, Error **errp)
 {
     int rc;
-    struct kvm_create_device xics_create_device =3D {
-        .type =3D KVM_DEV_TYPE_XICS,
-        .flags =3D 0,
-    };
=20
     if (!kvm_enabled() || !kvm_check_extension(kvm_state, KVM_CAP_IRQ_XI=
CS)) {
         error_setg(errp,
@@ -431,20 +408,19 @@ int xics_kvm_init(sPAPRMachineState *spapr, Error *=
*errp)
         goto fail;
     }
=20
-    /* Create the kernel ICP */
-    rc =3D kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &xics_create_devic=
e);
+    /* Create the KVM XICS device */
+    rc =3D kvm_create_device(kvm_state, KVM_DEV_TYPE_XICS, false);
     if (rc < 0) {
         error_setg_errno(errp, -rc, "Error on KVM_CREATE_DEVICE for XICS=
");
         goto fail;
     }
=20
-    kernel_xics_fd =3D xics_create_device.fd;
-
+    kernel_xics_fd =3D rc;
     kvm_kernel_irqchip =3D true;
     kvm_msi_via_irqfd_allowed =3D true;
     kvm_gsi_direct_mapping =3D true;
=20
-    return rc;
+    return 0;
=20
 fail:
     kvmppc_define_rtas_kernel_token(0, "ibm,set-xive");
--=20
2.13.6
