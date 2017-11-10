Received: from eggs.gnu.org ([2001:4830:134:3::10]:50089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eDDCP-0002t6-TZ
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:34:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eDDCO-0001z2-4g
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:34:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1eDDCN-0001ya-VR
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:34:36 -0500
From: Ladi Prosek <lprosek@redhat.com>
Date: Fri, 10 Nov 2017 18:34:19 +0100
Message-Id: <20171110173421.17904-2-lprosek@redhat.com>
In-Reply-To: <20171110173421.17904-1-lprosek@redhat.com>
References: <20171110173421.17904-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] ivshmem: Don't update non-existent MSI
 routes
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

  kvm_irqchip_commit_routes: Assertion `ret == 0' failed.

if the ivshmem device is configured with more vectors than what the server
supports. This is caused by the ivshmem_vector_unmask() being called on
vectors that have not been initialized by ivshmem_add_kvm_msi_virq().

This commit fixes it by adding a simple check to the mask and unmask
callbacks.

Note that the opposite mismatch, if the server supplies more vectors than
what the device is configured for, is already handled and leads to output
like:

  Too many eventfd received, device has 1 vectors

Fixes: 660c97eef6f8 ("ivshmem: use kvm irqfd for msi notifications")
Signed-off-by: Ladi Prosek <lprosek@redhat.com>
---
 hw/misc/ivshmem.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index a5a46827fe..6e46669744 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -317,6 +317,10 @@ static int ivshmem_vector_unmask(PCIDevice *dev, unsigned vector,
     int ret;
 
     IVSHMEM_DPRINTF("vector unmask %p %d\n", dev, vector);
+    if (!v->pdev) {
+        error_report("ivshmem: vector %d route does not exist", vector);
+        return -EINVAL;
+    }
 
     ret = kvm_irqchip_update_msi_route(kvm_state, v->virq, msg, dev);
     if (ret < 0) {
@@ -331,12 +335,16 @@ static void ivshmem_vector_mask(PCIDevice *dev, unsigned vector)
 {
     IVShmemState *s = IVSHMEM_COMMON(dev);
     EventNotifier *n = &s->peers[s->vm_id].eventfds[vector];
+    MSIVector *v = &s->msi_vectors[vector];
     int ret;
 
     IVSHMEM_DPRINTF("vector mask %p %d\n", dev, vector);
+    if (!v->pdev) {
+        error_report("ivshmem: vector %d route does not exist", vector);
+        return;
+    }
 
-    ret = kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, n,
-                                                s->msi_vectors[vector].virq);
+    ret = kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, n, v->virq);
     if (ret != 0) {
         error_report("remove_irqfd_notifier_gsi failed");
     }
-- 
2.13.5
