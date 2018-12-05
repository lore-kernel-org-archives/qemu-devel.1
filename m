Received: from eggs.gnu.org ([2001:4830:134:3::10]:45709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgYy-0000AZ-6e
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:26:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgYt-0004zw-Tg
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:26:39 -0500
Received: from 3.mo177.mail-out.ovh.net ([46.105.36.172]:58827)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gUgYr-0004m1-Rk
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:26:35 -0500
Received: from player714.ha.ovh.net (unknown [10.109.159.139])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id ECB36D5D62
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 00:26:16 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  6 Dec 2018 00:22:50 +0100
Message-Id: <20181205232251.10446-37-clg@kaod.org>
In-Reply-To: <20181205232251.10446-1-clg@kaod.org>
References: <20181205232251.10446-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 36/37] spapr: check for KVM IRQ device
 activation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The KVM IRQ device activation will depend on the interrupt mode chosen
at CAS time by the machine and some methods used at reset or by the
migration need to be protected.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive_kvm.c | 28 ++++++++++++++++++++++++++++
 hw/intc/xics_kvm.c       | 25 ++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index dba3344831c6..6135b8c11e63 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -94,9 +94,15 @@ static void kvmppc_xive_cpu_set_state(XiveTCTX *tctx, =
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
         error_setg_errno(errp, errno, "Could capture KVM XIVE CPU %ld st=
ate",
@@ -132,6 +138,11 @@ void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error *=
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
@@ -215,9 +226,13 @@ static void kvmppc_xive_source_get_state(XiveSource =
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
@@ -564,6 +579,11 @@ int kvmppc_xive_pre_save(sPAPRXive *xive)
     Error *local_err =3D NULL;
     CPUState *cs;
=20
+    /* The KVM XIVE device is not in use */
+    if (xive->fd =3D=3D -1) {
+        return 0;
+    }
+
     /* Grab the EAT */
     kvmppc_xive_get_eas_state(xive, &local_err);
     if (local_err) {
@@ -596,6 +616,9 @@ int kvmppc_xive_post_load(sPAPRXive *xive, int versio=
n_id)
     Error *local_err =3D NULL;
     CPUState *cs;
=20
+    /* The KVM XIVE device should be in use */
+    assert(xive->fd !=3D -1);
+
     /* Restore the ENDT first. The targetting depends on it. */
     CPU_FOREACH(cs) {
         kvmppc_xive_set_eq_state(xive, cs, &local_err);
@@ -632,6 +655,11 @@ void kvmppc_xive_synchronize_state(sPAPRXive *xive)
     XiveSource *xsrc =3D &xive->source;
     CPUState *cs;
=20
+    /* The KVM XIVE device is not in use */
+    if (xive->fd =3D=3D -1) {
+        return;
+    }
+
     /*
      * When the VM is stopped, the sources are masked and the previous
      * state is saved in anticipation of a migration. We should not
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 2a60ae71730b..4355c9d12160 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -68,6 +68,11 @@ static void icp_get_kvm_state(ICPState *icp)
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
@@ -104,6 +109,11 @@ static int icp_set_kvm_state(ICPState *icp, int vers=
ion_id)
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
@@ -140,8 +150,8 @@ static void icp_kvm_connect(ICPState *icp, Error **er=
rp)
     unsigned long vcpu_id;
     int ret;
=20
+    /* The KVM XICS device is not in use */
     if (kernel_xics_fd =3D=3D -1) {
-        abort();
         return;
     }
=20
@@ -220,6 +230,11 @@ static void ics_get_kvm_state(ICSState *ics)
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
@@ -279,6 +294,11 @@ static int ics_set_kvm_state(ICSState *ics, int vers=
ion_id)
     int i;
     Error *local_err =3D NULL;
=20
+    /* The KVM XICS device is not in use */
+    if (kernel_xics_fd =3D=3D -1) {
+        return 0;
+    }
+
     for (i =3D 0; i < ics->nr_irqs; i++) {
         ICSIRQState *irq =3D &ics->irqs[i];
         int ret;
@@ -325,6 +345,9 @@ static void ics_kvm_set_irq(void *opaque, int srcno, =
int val)
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
2.17.2
