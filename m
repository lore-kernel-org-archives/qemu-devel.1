Received: from eggs.gnu.org ([2001:4830:134:3::10]:44874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSR-0004dN-Tp
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSQ-00054a-8b
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:39 -0500
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:37775)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimSQ-00054M-1Q
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:38 -0500
Received: by mail-wr0-x22f.google.com with SMTP id a43so23273386wrc.4
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:37 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:41 +0100
Message-Id: <1517858941-5538-28-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 27/47] ivshmem: Always remove irqfd notifiers
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

As of commit 660c97eef6f8 ("ivshmem: use kvm irqfd for msi notifications"),
QEMU crashes with:

ivshmem: msix_set_vector_notifiers failed
msix_unset_vector_notifiers: Assertion `dev->msix_vector_use_notifier && dev->msix_vector_release_notifier' failed.

if MSI-X is repeatedly enabled and disabled on the ivshmem device, for example
by loading and unloading the Windows ivshmem driver. This is because
msix_unset_vector_notifiers() doesn't call any of the release notifier callbacks
since MSI-X is already disabled at that point (msix_enabled() returning false
is how this transition is detected in the first place). Thus ivshmem_vector_mask()
doesn't run and when MSI-X is subsequently enabled again ivshmem_vector_unmask()
fails.

This is fixed by keeping track of unmasked vectors and making sure that
ivshmem_vector_mask() always runs on MSI-X disable.

Fixes: 660c97eef6f8 ("ivshmem: use kvm irqfd for msi notifications")
Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20171211072110.9058-3-lprosek@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/misc/ivshmem.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 0b471d9..95e85e4 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -76,6 +76,7 @@ typedef struct Peer {
 typedef struct MSIVector {
     PCIDevice *pdev;
     int virq;
+    bool unmasked;
 } MSIVector;
 
 typedef struct IVShmemState {
@@ -320,6 +321,7 @@ static int ivshmem_vector_unmask(PCIDevice *dev, unsigned vector,
         error_report("ivshmem: vector %d route does not exist", vector);
         return -EINVAL;
     }
+    assert(!v->unmasked);
 
     ret = kvm_irqchip_update_msi_route(kvm_state, v->virq, msg, dev);
     if (ret < 0) {
@@ -327,7 +329,13 @@ static int ivshmem_vector_unmask(PCIDevice *dev, unsigned vector,
     }
     kvm_irqchip_commit_routes(kvm_state);
 
-    return kvm_irqchip_add_irqfd_notifier_gsi(kvm_state, n, NULL, v->virq);
+    ret = kvm_irqchip_add_irqfd_notifier_gsi(kvm_state, n, NULL, v->virq);
+    if (ret < 0) {
+        return ret;
+    }
+    v->unmasked = true;
+
+    return 0;
 }
 
 static void ivshmem_vector_mask(PCIDevice *dev, unsigned vector)
@@ -342,11 +350,14 @@ static void ivshmem_vector_mask(PCIDevice *dev, unsigned vector)
         error_report("ivshmem: vector %d route does not exist", vector);
         return;
     }
+    assert(v->unmasked);
 
     ret = kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, n, v->virq);
-    if (ret != 0) {
+    if (ret < 0) {
         error_report("remove_irqfd_notifier_gsi failed");
+        return;
     }
+    v->unmasked = false;
 }
 
 static void ivshmem_vector_poll(PCIDevice *dev,
@@ -816,11 +827,20 @@ static void ivshmem_disable_irqfd(IVShmemState *s)
     PCIDevice *pdev = PCI_DEVICE(s);
     int i;
 
+    msix_unset_vector_notifiers(pdev);
+
     for (i = 0; i < s->peers[s->vm_id].nb_eventfds; i++) {
+        /*
+         * MSI-X is already disabled here so msix_unset_vector_notifiers()
+         * didn't call our release notifier.  Do it now to keep our masks and
+         * unmasks balanced.
+         */
+        if (s->msi_vectors[i].unmasked) {
+            ivshmem_vector_mask(pdev, i);
+        }
         ivshmem_remove_kvm_msi_virq(s, i);
     }
 
-    msix_unset_vector_notifiers(pdev);
 }
 
 static void ivshmem_write_config(PCIDevice *pdev, uint32_t address,
-- 
1.8.3.1
