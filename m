Received: from eggs.gnu.org ([209.51.188.92]:33602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gw92B-0002K9-CO
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:18:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gw928-0007Qs-N3
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:18:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gw928-0007Li-1P
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:18:16 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1JHES9o017163
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 12:18:13 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qrkyryhfr-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 12:18:12 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 19 Feb 2019 17:18:10 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 19 Feb 2019 18:18:03 +0100
In-Reply-To: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155059668360.1466090.5969630516627776426.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [PATCH v5 06/17] xics: Write source state to KVM at
 claim time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Greg Kurz <groug@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

The pseries machine only uses LSIs to support legacy PCI devices. Every
PHB claims 4 LSIs at realize time. When using in-kernel XICS (or upcoming
in-kernel XIVE), QEMU synchronizes the state of all irqs, including these
LSIs, later on at machine reset.

In order to support PHB hotplug, we need a way to tell KVM about the LSIs
that doesn't require a machine reset. An easy way to do that is to always
inform KVM when an interrupt is claimed, which really isn't a performance
path.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics.c        |    4 +++
 hw/intc/xics_kvm.c    |   74 ++++++++++++++++++++++++++++---------------------
 include/hw/ppc/xics.h |    1 +
 3 files changed, 48 insertions(+), 31 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 767fdeb82900..af7dc709abab 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -758,6 +758,10 @@ void ics_set_irq_type(ICSState *ics, int srcno, bool lsi)
 
     ics->irqs[srcno].flags |=
         lsi ? XICS_FLAGS_IRQ_LSI : XICS_FLAGS_IRQ_MSI;
+
+    if (kvm_irqchip_in_kernel()) {
+        ics_set_kvm_state_one(ics, srcno);
+    }
 }
 
 static void xics_register_types(void)
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index a00d0a7962e1..c6e1b630a404 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -213,45 +213,57 @@ void ics_synchronize_state(ICSState *ics)
     ics_get_kvm_state(ics);
 }
 
-int ics_set_kvm_state(ICSState *ics)
+int ics_set_kvm_state_one(ICSState *ics, int srcno)
 {
     uint64_t state;
-    int i;
     Error *local_err = NULL;
+    ICSIRQState *irq = &ics->irqs[srcno];
+    int ret;
 
-    for (i = 0; i < ics->nr_irqs; i++) {
-        ICSIRQState *irq = &ics->irqs[i];
-        int ret;
-
-        state = irq->server;
-        state |= (uint64_t)(irq->saved_priority & KVM_XICS_PRIORITY_MASK)
-            << KVM_XICS_PRIORITY_SHIFT;
-        if (irq->priority != irq->saved_priority) {
-            assert(irq->priority == 0xff);
-            state |= KVM_XICS_MASKED;
-        }
+    state = irq->server;
+    state |= (uint64_t)(irq->saved_priority & KVM_XICS_PRIORITY_MASK)
+        << KVM_XICS_PRIORITY_SHIFT;
+    if (irq->priority != irq->saved_priority) {
+        assert(irq->priority == 0xff);
+        state |= KVM_XICS_MASKED;
+    }
 
-        if (ics->irqs[i].flags & XICS_FLAGS_IRQ_LSI) {
-            state |= KVM_XICS_LEVEL_SENSITIVE;
-            if (irq->status & XICS_STATUS_ASSERTED) {
-                state |= KVM_XICS_PENDING;
-            }
-        } else {
-            if (irq->status & XICS_STATUS_MASKED_PENDING) {
-                state |= KVM_XICS_PENDING;
-            }
+    if (irq->flags & XICS_FLAGS_IRQ_LSI) {
+        state |= KVM_XICS_LEVEL_SENSITIVE;
+        if (irq->status & XICS_STATUS_ASSERTED) {
+            state |= KVM_XICS_PENDING;
         }
-        if (irq->status & XICS_STATUS_PRESENTED) {
-                state |= KVM_XICS_PRESENTED;
-        }
-        if (irq->status & XICS_STATUS_QUEUED) {
-                state |= KVM_XICS_QUEUED;
+    } else {
+        if (irq->status & XICS_STATUS_MASKED_PENDING) {
+            state |= KVM_XICS_PENDING;
         }
+    }
+    if (irq->status & XICS_STATUS_PRESENTED) {
+        state |= KVM_XICS_PRESENTED;
+    }
+    if (irq->status & XICS_STATUS_QUEUED) {
+        state |= KVM_XICS_QUEUED;
+    }
+
+    ret = kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
+                            srcno + ics->offset, &state, true, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return ret;
+    }
+
+    return 0;
+}
+
+int ics_set_kvm_state(ICSState *ics)
+{
+    int i;
+
+    for (i = 0; i < ics->nr_irqs; i++) {
+        int ret;
 
-        ret = kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
-                                i + ics->offset, &state, true, &local_err);
-        if (local_err) {
-            error_report_err(local_err);
+        ret = ics_set_kvm_state_one(ics, i);
+        if (ret) {
             return ret;
         }
     }
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index d36bbe11ee2e..eb65ad7e43b7 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -195,6 +195,7 @@ void icp_synchronize_state(ICPState *icp);
 void icp_kvm_realize(DeviceState *dev, Error **errp);
 
 void ics_get_kvm_state(ICSState *ics);
+int ics_set_kvm_state_one(ICSState *ics, int srcno);
 int ics_set_kvm_state(ICSState *ics);
 void ics_synchronize_state(ICSState *ics);
 void ics_kvm_set_irq(ICSState *ics, int srcno, int val);
