Received: from eggs.gnu.org ([2001:4830:134:3::10]:44841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgYA-0007vt-O1
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:25:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgY6-0004FV-Ba
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:25:50 -0500
Received: from 15.mo6.mail-out.ovh.net ([188.165.39.161]:34781)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gUgY5-00044f-Ru
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:25:46 -0500
Received: from player714.ha.ovh.net (unknown [10.109.160.62])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 9424D19C3BD
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 00:25:24 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  6 Dec 2018 00:22:40 +0100
Message-Id: <20181205232251.10446-27-clg@kaod.org>
In-Reply-To: <20181205232251.10446-1-clg@kaod.org>
References: <20181205232251.10446-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 26/37] spapr/xive: introduce a VM state
 change handler
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

This handler is in charge of stabilizing the flow of event notifications
in the XIVE controller before migrating a guest. This is a requirement
before transferring the guest EQ pages to a destination.

When the VM is stopped, the handler masks the sources (PQ=3D01) to stop
the flow of events and saves their previous state. The XIVE controller
is then synced through KVM to flush any in-flight event notification
and to stabilize the EQs. At this stage, the EQ pages are marked dirty
to make sure the EQ pages are transferred if a migration sequence is
in progress.

The previous configuration of the sources is restored when the VM
resumes, after a migration or a stop.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr_xive.h |   1 +
 hw/intc/spapr_xive_kvm.c    | 111 +++++++++++++++++++++++++++++++++++-
 2 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index bd81bb4d7608..c447534b6b29 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -39,6 +39,7 @@ typedef struct sPAPRXive {
     /* KVM support */
     int           fd;
     void          *tm_mmap;
+    VMChangeStateEntry *change;
 } sPAPRXive;
=20
 bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t lisn, bool lsi);
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 7cdf08ca368c..5cb7461e9743 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -334,12 +334,118 @@ static void kvmppc_xive_get_eas_state(sPAPRXive *x=
ive, Error **errp)
     }
 }
=20
+/*
+ * Sync the XIVE controller through KVM to flush any in-flight event
+ * notification and stabilize the EQs.
+ */
+ static void kvmppc_xive_sync_all(sPAPRXive *xive, Error **errp)
+{
+    XiveSource *xsrc =3D &xive->source;
+    Error *local_err =3D NULL;
+    int i;
+
+    /* Sync the KVM source. This reaches the XIVE HW through OPAL */
+    for (i =3D 0; i < xsrc->nr_irqs; i++) {
+        XiveEAS *eas =3D &xive->eat[i];
+
+        if (!xive_eas_is_valid(eas)) {
+            continue;
+        }
+
+        kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_SYNC, i, NULL, true=
,
+                          &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
+}
+
+/*
+ * The primary goal of the XIVE VM change handler is to mark the EQ
+ * pages dirty when all XIVE event notifications have stopped.
+ *
+ * Whenever the VM is stopped, the VM change handler masks the sources
+ * (PQ=3D01) to stop the flow of events and saves the previous state in
+ * anticipation of a migration. The XIVE controller is then synced
+ * through KVM to flush any in-flight event notification and stabilize
+ * the EQs.
+ *
+ * At this stage, we can mark the EQ page dirty and let a migration
+ * sequence transfer the EQ pages to the destination, which is done
+ * just after the stop state.
+ *
+ * The previous configuration of the sources is restored when the VM
+ * runs again.
+ */
+static void kvmppc_xive_change_state_handler(void *opaque, int running,
+                                             RunState state)
+{
+    sPAPRXive *xive =3D opaque;
+    XiveSource *xsrc =3D &xive->source;
+    Error *local_err =3D NULL;
+    int i;
+
+    /*
+     * Restore the sources to their initial state. This is called when
+     * the VM resumes after a stop or a migration.
+     */
+    if (running) {
+        for (i =3D 0; i < xsrc->nr_irqs; i++) {
+            uint8_t pq =3D xive_source_esb_get(xsrc, i);
+            if (xive_esb_read(xsrc, i, XIVE_ESB_SET_PQ_00 + (pq << 8)) !=
=3D 0x1) {
+                error_report("XIVE: IRQ %d has an invalid state", i);
+            }
+        }
+
+        return;
+    }
+
+    /*
+     * Mask the sources, to stop the flow of event notifications, and
+     * save the PQs locally in the XiveSource object. The XiveSource
+     * state will be collected later on by its vmstate handler if a
+     * migration is in progress.
+     */
+    for (i =3D 0; i < xsrc->nr_irqs; i++) {
+        uint8_t pq =3D xive_esb_read(xsrc, i, XIVE_ESB_SET_PQ_01);
+        xive_source_esb_set(xsrc, i, pq);
+    }
+
+    /*
+     * Sync the XIVE controller in KVM, to flush in-flight event
+     * notification that should be enqueued in the EQs.
+     */
+    kvmppc_xive_sync_all(xive, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return;
+    }
+
+    /*
+     * Mark the XIVE EQ pages dirty to collect all updates.
+     */
+    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_CTRL,
+                      KVM_DEV_XIVE_SAVE_EQ_PAGES, NULL, true, &local_err=
);
+    if (local_err) {
+        error_report_err(local_err);
+    }
+}
+
 void kvmppc_xive_synchronize_state(sPAPRXive *xive)
 {
     XiveSource *xsrc =3D &xive->source;
     CPUState *cs;
=20
-    kvmppc_xive_source_get_state(xsrc);
+    /*
+     * When the VM is stopped, the sources are masked and the previous
+     * state is saved in anticipation of a migration. We should not
+     * synchronize the source state in that case else we will override
+     * the saved state.
+     */
+    if (runstate_is_running()) {
+        kvmppc_xive_source_get_state(xsrc);
+    }
=20
     kvmppc_xive_get_eas_state(xive, &error_fatal);
=20
@@ -442,6 +548,9 @@ void kvmppc_xive_connect(sPAPRXive *xive, Error **err=
p)
                                       "xive.tima", tima_len, xive->tm_mm=
ap);
     sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xive->tm_mmio);
=20
+    xive->change =3D qemu_add_vm_change_state_handler(
+        kvmppc_xive_change_state_handler, xive);
+
     kvm_kernel_irqchip =3D true;
     kvm_msi_via_irqfd_allowed =3D true;
     kvm_gsi_direct_mapping =3D true;
--=20
2.17.2
