Received: from eggs.gnu.org ([2001:4830:134:3::10]:44889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSS-0004eE-OR
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSR-000553-FH
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:40 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:55659)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimSR-00054g-7n
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:39 -0500
Received: by mail-wm0-x244.google.com with SMTP id 143so28225646wma.5
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:39 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:42 +0100
Message-Id: <1517858941-5538-29-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 28/47] ivshmem: Improve MSI irqfd error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ladi Prosek <lprosek@redhat.com>

From: Ladi Prosek <lprosek@redhat.com>

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
Message-Id: <20171211072110.9058-4-lprosek@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/misc/ivshmem.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 95e85e4..fe1d8d1 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -785,6 +785,20 @@ static int ivshmem_setup_interrupts(IVShmemState *s, Error **errp)
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
@@ -796,7 +810,7 @@ static void ivshmem_enable_irqfd(IVShmemState *s)
         ivshmem_add_kvm_msi_virq(s, i, &err);
         if (err) {
             error_report_err(err);
-            /* TODO do we need to handle the error? */
+            goto undo;
         }
     }
 
@@ -805,21 +819,14 @@ static void ivshmem_enable_irqfd(IVShmemState *s)
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
@@ -827,6 +834,10 @@ static void ivshmem_disable_irqfd(IVShmemState *s)
     PCIDevice *pdev = PCI_DEVICE(s);
     int i;
 
+    if (!pdev->msix_vector_use_notifier) {
+        return;
+    }
+
     msix_unset_vector_notifiers(pdev);
 
     for (i = 0; i < s->peers[s->vm_id].nb_eventfds; i++) {
-- 
1.8.3.1
