Received: from eggs.gnu.org ([209.51.188.92]:40617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gxAp1-0000qe-5j
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:25:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gxAef-0004lY-7e
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:14:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gxAed-00041Z-W6
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:14:16 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1MDB8Dq129500
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 08:13:46 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qtg1tw8a2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 08:13:45 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Fri, 22 Feb 2019 13:13:39 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 22 Feb 2019 14:13:20 +0100
In-Reply-To: <20190222131322.26079-1-clg@kaod.org>
References: <20190222131322.26079-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190222131322.26079-12-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 11/13] spapr: check for the activation of
 the KVM IRQ device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The activation of the KVM IRQ device depends on the interrupt mode
chosen at CAS time by the machine and some methods used at reset or by
the migration need to be protected.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive_kvm.c | 28 ++++++++++++++++++++++++++++
 hw/intc/xics_kvm.c       | 26 +++++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index e31035c90260..cd81cdb23a5e 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -96,9 +96,15 @@ static void kvmppc_xive_cpu_set_state(XiveTCTX *tctx, =
Error **errp)
=20
 void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp)
 {
+    sPAPRXive *xive =3D SPAPR_MACHINE(qdev_get_machine())->xive;
     uint64_t state[4] =3D { 0 };
     int ret;
=20
+    /* The KVM XIVE device is not in use */
+    if (xive->fd =3D=3D -1) {
+        return;
+    }
+
     ret =3D kvm_get_one_reg(tctx->cs, KVM_REG_PPC_NVT_STATE, state);
     if (ret !=3D 0) {
         error_setg_errno(errp, errno,
@@ -152,6 +158,11 @@ void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error *=
*errp)
     unsigned long vcpu_id;
     int ret;
=20
+    /* The KVM XIVE device is not in use */
+    if (xive->fd =3D=3D -1) {
+        return;
+    }
+
     /* Check if CPU was hot unplugged and replugged. */
     if (kvm_cpu_is_enabled(tctx->cs)) {
         return;
@@ -330,9 +341,13 @@ static void kvmppc_xive_source_get_state(XiveSource =
*xsrc)
 void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val)
 {
     XiveSource *xsrc =3D opaque;
+    sPAPRXive *xive =3D SPAPR_XIVE(xsrc->xive);
     struct kvm_irq_level args;
     int rc;
=20
+    /* The KVM XIVE device should be in use */
+    assert(xive->fd !=3D -1);
+
     args.irq =3D srcno;
     if (!xive_source_irq_is_lsi(xsrc, srcno)) {
         if (!val) {
@@ -519,6 +534,11 @@ static void kvmppc_xive_change_state_handler(void *o=
paque, int running,
=20
 void kvmppc_xive_synchronize_state(sPAPRXive *xive, Error **errp)
 {
+    /* The KVM XIVE device is not in use */
+    if (xive->fd =3D=3D -1) {
+        return;
+    }
+
     /*
      * When the VM is stopped, the sources are masked and the previous
      * state is saved in anticipation of a migration. We should not
@@ -544,6 +564,11 @@ int kvmppc_xive_pre_save(sPAPRXive *xive)
 {
     Error *local_err =3D NULL;
=20
+    /* The KVM XIVE device is not in use */
+    if (xive->fd =3D=3D -1) {
+        return 0;
+    }
+
     /* EAT: there is no extra state to query from KVM */
=20
     /* ENDT */
@@ -568,6 +593,9 @@ int kvmppc_xive_post_load(sPAPRXive *xive, int versio=
n_id)
     CPUState *cs;
     int i;
=20
+    /* The KVM XIVE device should be in use */
+    assert(xive->fd !=3D -1);
+
     /* Restore the ENDT first. The targetting depends on it. */
     for (i =3D 0; i < xive->nr_ends; i++) {
         kvmppc_xive_set_queue_config(xive, SPAPR_XIVE_BLOCK_ID, i,
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 373de3155f6b..9855316e4831 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -69,6 +69,11 @@ void icp_get_kvm_state(ICPState *icp)
     uint64_t state;
     int ret;
=20
+    /* The KVM XICS device is not in use */
+    if (kernel_xics_fd =3D=3D -1) {
+        return;
+    }
+
     /* ICP for this CPU thread is not in use, exiting */
     if (!icp->cs) {
         return;
@@ -105,6 +110,11 @@ int icp_set_kvm_state(ICPState *icp)
     uint64_t state;
     int ret;
=20
+    /* The KVM XICS device is not in use */
+    if (kernel_xics_fd =3D=3D -1) {
+        return 0;
+    }
+
     /* ICP for this CPU thread is not in use, exiting */
     if (!icp->cs) {
         return 0;
@@ -133,8 +143,9 @@ void icp_kvm_realize(DeviceState *dev, Error **errp)
     unsigned long vcpu_id;
     int ret;
=20
+    /* The KVM XICS device is not in use */
     if (kernel_xics_fd =3D=3D -1) {
-        abort();
+        return;
     }
=20
     cs =3D icp->cs;
@@ -170,6 +181,11 @@ void ics_get_kvm_state(ICSState *ics)
     uint64_t state;
     int i;
=20
+    /* The KVM XICS device is not in use */
+    if (kernel_xics_fd =3D=3D -1) {
+        return;
+    }
+
     for (i =3D 0; i < ics->nr_irqs; i++) {
         ICSIRQState *irq =3D &ics->irqs[i];
=20
@@ -269,6 +285,11 @@ int ics_set_kvm_state(ICSState *ics)
 {
     int i;
=20
+    /* The KVM XICS device is not in use */
+    if (kernel_xics_fd =3D=3D -1) {
+        return 0;
+    }
+
     for (i =3D 0; i < ics->nr_irqs; i++) {
         int ret;
=20
@@ -286,6 +307,9 @@ void ics_kvm_set_irq(ICSState *ics, int srcno, int va=
l)
     struct kvm_irq_level args;
     int rc;
=20
+    /* The KVM XICS device should be in use */
+    assert(kernel_xics_fd !=3D -1);
+
     args.irq =3D srcno + ics->offset;
     if (ics->irqs[srcno].flags & XICS_FLAGS_IRQ_MSI) {
         if (!val) {
--=20
2.20.1
