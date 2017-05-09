Received: from eggs.gnu.org ([2001:4830:134:3::10]:35378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d7wlT-000399-As
	for qemu-devel@nongnu.org; Tue, 09 May 2017 00:28:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d7wlS-00024V-Eq
	for qemu-devel@nongnu.org; Tue, 09 May 2017 00:28:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d7wlS-00023z-92
	for qemu-devel@nongnu.org; Tue, 09 May 2017 00:28:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4157088E60
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 04:28:45 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue,  9 May 2017 12:28:28 +0800
Message-Id: <1494304108-9805-4-git-send-email-peterx@redhat.com>
In-Reply-To: <1494304108-9805-1-git-send-email-peterx@redhat.com>
References: <1494304108-9805-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] kvm: irqchip: skip update msi when disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com

It's possible that one device kept its irqfd/virq there even when
MSI/MSIX was disabled globally for that device. One example is
virtio-net-pci (see commit f1d0f15a6 and virtio_pci_vq_vector_mask()).
It is used as a fast path to avoid allocate/release irqfd/virq
frequently when guest enables/disables MSIX.

However, this fast path brought a problem to msi_route_list, that the
device MSIRouteEntry is still dangling there even if MSIX disabled -
then we cannot know which message to fetch, even if we can, the messages
are meaningless. In this case, we can just simply ignore this entry.

It's safe, since when MSIX is enabled again, we'll rebuild them no
matter what.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1448813

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 target/i386/kvm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 55865db..3a85b54 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -3510,12 +3510,16 @@ static void kvm_update_msi_routes_all(void *private, bool global,
     int cnt = 0;
     MSIRouteEntry *entry;
     MSIMessage msg;
+    PCIDevice *dev;
+
     /* TODO: explicit route update */
     QLIST_FOREACH(entry, &msi_route_list, list) {
-        cnt++;
-        msg = pci_get_msi_message(entry->dev, entry->vector);
-        kvm_irqchip_update_msi_route(kvm_state, entry->virq,
-                                     msg, entry->dev);
+        dev = entry->dev;
+        if (!msix_enabled(dev) && !msi_enabled(dev)) {
+            continue;
+        }
+        msg = pci_get_msi_message(dev, entry->vector);
+        kvm_irqchip_update_msi_route(kvm_state, entry->virq, msg, dev);
     }
     kvm_irqchip_commit_routes(kvm_state);
     trace_kvm_x86_update_msi_routes(cnt);
-- 
2.7.4
