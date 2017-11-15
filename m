Received: from eggs.gnu.org ([2001:4830:134:3::10]:39644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eEsAv-0003Zw-PY
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 02:31:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eEsAu-0005iw-Q1
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 02:31:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1eEsAu-0005iR-Gh
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 02:31:56 -0500
From: Ladi Prosek <lprosek@redhat.com>
Date: Wed, 15 Nov 2017 08:31:43 +0100
Message-Id: <20171115073144.14758-3-lprosek@redhat.com>
In-Reply-To: <20171115073144.14758-1-lprosek@redhat.com>
References: <20171115073144.14758-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/3] ivshmem: Always remove irqfd notifiers
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
---
 hw/misc/ivshmem.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 6e46669744..91364d8364 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -77,6 +77,7 @@ typedef struct Peer {
 typedef struct MSIVector {
     PCIDevice *pdev;
     int virq;
+    bool unmasked;
 } MSIVector;
 
 typedef struct IVShmemState {
@@ -321,6 +322,7 @@ static int ivshmem_vector_unmask(PCIDevice *dev, unsigned vector,
         error_report("ivshmem: vector %d route does not exist", vector);
         return -EINVAL;
     }
+    assert(!v->unmasked);
 
     ret = kvm_irqchip_update_msi_route(kvm_state, v->virq, msg, dev);
     if (ret < 0) {
@@ -328,7 +330,13 @@ static int ivshmem_vector_unmask(PCIDevice *dev, unsigned vector,
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
@@ -343,11 +351,14 @@ static void ivshmem_vector_mask(PCIDevice *dev, unsigned vector)
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
@@ -817,11 +828,20 @@ static void ivshmem_disable_irqfd(IVShmemState *s)
     PCIDevice *pdev = PCI_DEVICE(s);
     int i;
 
-    for (i = 0; i < s->peers[s->vm_id].nb_eventfds; i++) {
-        ivshmem_remove_kvm_msi_virq(s, i);
-    }
-
     msix_unset_vector_notifiers(pdev);
+
+    for (i = 0; i < s->peers[s->vm_id].nb_eventfds; i++) {
+        /*
+         * MSI-X is already disabled here so msix_unset_vector_notifiers()
+         * didn't call our release notifier.  Do it now to keep our masks and
+         * unmasks balanced.
+         */
+        if (s->msi_vectors[i].unmasked) {
+            ivshmem_vector_mask(pdev, i);
+        }
+        ivshmem_remove_kvm_msi_virq(s, i);
+    }
+
 }
 
 static void ivshmem_write_config(PCIDevice *pdev, uint32_t address,
-- 
2.13.5
