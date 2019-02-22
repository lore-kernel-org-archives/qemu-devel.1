Received: from eggs.gnu.org ([209.51.188.92]:40634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gxApD-0000qj-3X
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:25:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gxAef-0004l2-1C
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:14:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34988
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gxAed-0003tO-BQ
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:14:16 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1MDB6DS114212
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 08:13:36 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qtgx32yjn-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 08:13:36 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Fri, 22 Feb 2019 13:13:34 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 22 Feb 2019 14:13:14 +0100
In-Reply-To: <20190222131322.26079-1-clg@kaod.org>
References: <20190222131322.26079-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190222131322.26079-6-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 05/13] spapr/xive: introduce a VM state
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
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

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
 include/hw/ppc/spapr_xive.h |  1 +
 hw/intc/spapr_xive_kvm.c    | 77 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index ebd65e7fe36b..298d204d54ef 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -42,6 +42,7 @@ typedef struct sPAPRXive {
     /* KVM support */
     int           fd;
     void          *tm_mmap;
+    VMChangeStateEntry *change;
 } sPAPRXive;
=20
 /*
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 4b1ffb9835f9..44d80175b1b5 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -419,9 +419,81 @@ static void kvmppc_xive_get_queues(sPAPRXive *xive, =
Error **errp)
     }
 }
=20
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
+     * notification that should be enqueued in the EQs and mark the
+     * XIVE EQ pages dirty to collect all updates.
+     */
+    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_CTRL,
+                      KVM_DEV_XIVE_EQ_SYNC, NULL, true, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return;
+    }
+}
+
 void kvmppc_xive_synchronize_state(sPAPRXive *xive, Error **errp)
 {
-    kvmppc_xive_source_get_state(&xive->source);
+    /*
+     * When the VM is stopped, the sources are masked and the previous
+     * state is saved in anticipation of a migration. We should not
+     * synchronize the source state in that case else we will override
+     * the saved state.
+     */
+    if (runstate_is_running()) {
+        kvmppc_xive_source_get_state(&xive->source);
+    }
=20
     /* EAT: there is no extra state to query from KVM */
=20
@@ -501,6 +573,9 @@ void kvmppc_xive_connect(sPAPRXive *xive, Error **err=
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
2.20.1
