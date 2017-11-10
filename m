Received: from eggs.gnu.org ([2001:4830:134:3::10]:50135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eDDCS-0002v0-Hc
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:34:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eDDCR-00021B-OL
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:34:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1eDDCR-00020Z-Ie
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:34:39 -0500
From: Ladi Prosek <lprosek@redhat.com>
Date: Fri, 10 Nov 2017 18:34:21 +0100
Message-Id: <20171110173421.17904-4-lprosek@redhat.com>
In-Reply-To: <20171110173421.17904-1-lprosek@redhat.com>
References: <20171110173421.17904-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] ivshmem: Improve MSI irqfd error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: geoff@hostfission.com, pbonzini@redhat.com, armbru@redhat.com, marcandre.lureau@redhat.com

Adds a rollback path to ivshmem_enable_irqfd() and fixes
ivshmem_disable_irqfd() to bail if irqfd has not been enabled.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
---
 hw/misc/ivshmem.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 493a5030a1..ff07a94691 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -784,6 +784,20 @@ static int ivshmem_setup_interrupts(IVShmemState *s, Error **errp)
     return 0;
 }
 
+static void ivshmem_remove_kvm_msi_virq(IVShmemState *s, int vector)
+{
+    IVSHMEM_DPRINTF("ivshmem_remove_kvm_msi_virq vector:%d\n", vector);
+
+    if (s->msi_vectors[vector].pdev == NULL) {
+        return;
+    }
+
+    /* it was cleaned when masked in the frontend. */
+    kvm_irqchip_release_virq(kvm_state, s->msi_vectors[vector].virq);
+
+    s->msi_vectors[vector].pdev = NULL;
+}
+
 static void ivshmem_enable_irqfd(IVShmemState *s)
 {
     PCIDevice *pdev = PCI_DEVICE(s);
@@ -795,7 +809,7 @@ static void ivshmem_enable_irqfd(IVShmemState *s)
         ivshmem_add_kvm_msi_virq(s, i, &err);
         if (err) {
             error_report_err(err);
-            /* TODO do we need to handle the error? */
+            goto undo;
         }
     }
 
@@ -804,21 +818,14 @@ static void ivshmem_enable_irqfd(IVShmemState *s)
                                   ivshmem_vector_mask,
                                   ivshmem_vector_poll)) {
         error_report("ivshmem: msix_set_vector_notifiers failed");
+        goto undo;
     }
-}
+    return;
 
-static void ivshmem_remove_kvm_msi_virq(IVShmemState *s, int vector)
-{
-    IVSHMEM_DPRINTF("ivshmem_remove_kvm_msi_virq vector:%d\n", vector);
-
-    if (s->msi_vectors[vector].pdev == NULL) {
-        return;
+undo:
+    while (--i >= 0) {
+        ivshmem_remove_kvm_msi_virq(s, i);
     }
-
-    /* it was cleaned when masked in the frontend. */
-    kvm_irqchip_release_virq(kvm_state, s->msi_vectors[vector].virq);
-
-    s->msi_vectors[vector].pdev = NULL;
 }
 
 static void ivshmem_disable_irqfd(IVShmemState *s)
@@ -826,6 +833,10 @@ static void ivshmem_disable_irqfd(IVShmemState *s)
     PCIDevice *pdev = PCI_DEVICE(s);
     int i;
 
+    if (!pdev->msix_vector_use_notifier) {
+        return;
+    }
+
     msix_unset_vector_notifiers(pdev);
 
     for (i = 0; i < s->peers[s->vm_id].nb_eventfds; i++) {
-- 
2.13.5
