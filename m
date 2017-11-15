Received: from eggs.gnu.org ([2001:4830:134:3::10]:39662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eEsAx-0003aR-V7
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 02:32:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eEsAw-0005lc-Vy
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 02:31:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1eEsAw-0005kB-NJ
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 02:31:58 -0500
From: Ladi Prosek <lprosek@redhat.com>
Date: Wed, 15 Nov 2017 08:31:44 +0100
Message-Id: <20171115073144.14758-4-lprosek@redhat.com>
In-Reply-To: <20171115073144.14758-1-lprosek@redhat.com>
References: <20171115073144.14758-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/3] ivshmem: Improve MSI irqfd error
 handling
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

To reproduce, run:

  ivshmem-server -n 0

and QEMU with:

  -device ivshmem-doorbell,chardev=iv
  -chardev socket,path=/tmp/ivshmem_socket,id=iv

then load, unload, and load again the Windows driver, at the time of writing
available at:

https://github.com/virtio-win/kvm-guest-drivers-windows/tree/master/ivshmem

The issue is believed to have been masked by other guest drivers, notably
Linux ones, not enabling MSI-X on the device.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 hw/misc/ivshmem.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 91364d8364..d1bb246d12 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -786,6 +786,20 @@ static int ivshmem_setup_interrupts(IVShmemState *s, Error **errp)
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
@@ -797,7 +811,7 @@ static void ivshmem_enable_irqfd(IVShmemState *s)
         ivshmem_add_kvm_msi_virq(s, i, &err);
         if (err) {
             error_report_err(err);
-            /* TODO do we need to handle the error? */
+            goto undo;
         }
     }
 
@@ -806,21 +820,14 @@ static void ivshmem_enable_irqfd(IVShmemState *s)
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
@@ -828,6 +835,10 @@ static void ivshmem_disable_irqfd(IVShmemState *s)
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
