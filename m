Received: from eggs.gnu.org ([2001:4830:134:3::10]:34604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gNbrr-0000bo-1v
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 06:01:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gNbrm-00019n-0f
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 06:00:54 -0500
Received: from 9.mo173.mail-out.ovh.net ([46.105.72.44]:55060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gNbri-0000xW-Vh
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 06:00:49 -0500
Received: from player734.ha.ovh.net (unknown [10.109.160.46])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 5D1C6DC945
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 12:00:29 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 16 Nov 2018 11:57:23 +0100
Message-Id: <20181116105729.23240-31-clg@kaod.org>
In-Reply-To: <20181116105729.23240-1-clg@kaod.org>
References: <20181116105729.23240-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 30/36] spapr: check for KVM IRQ device
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
 hw/intc/spapr_xive_kvm.c |  5 +++++
 hw/intc/xics_kvm.c       | 20 ++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 176083c37d61..b9fee4ea240f 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -656,6 +656,11 @@ static int spapr_xive_kvm_pre_save(sPAPRXive *xive)
     int i;
     int ret =3D 0;
=20
+    /* The KVM XIVE device is not in use */
+    if (xive->fd =3D=3D -1) {
+        return 0;
+    }
+
     /* Quiesce the sources, to stop the flow of event notifications */
     for (i =3D 0; i < xsrc->nr_irqs; i++) {
         /*
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 9662e208fa81..eabc901a4556 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -58,6 +58,11 @@ static void icp_get_kvm_state(ICPState *icp)
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
@@ -94,6 +99,11 @@ static int icp_set_kvm_state(ICPState *icp, int versio=
n_id)
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
@@ -209,6 +219,11 @@ static void ics_get_kvm_state(ICSState *ics)
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
@@ -268,6 +283,11 @@ static int ics_set_kvm_state(ICSState *ics, int vers=
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
--=20
2.17.2
