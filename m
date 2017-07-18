Received: from eggs.gnu.org ([2001:4830:134:3::10]:58335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dXTRA-000738-9f
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:25:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dXTR8-0004x5-8E
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:25:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dXTR8-0004wh-1d
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:25:18 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 18 Jul 2017 16:24:54 +0200
Message-Id: <20170718142455.32676-9-cohuck@redhat.com>
In-Reply-To: <20170718142455.32676-1-cohuck@redhat.com>
References: <20170718142455.32676-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v2 8/9] s390x/kvm: msi route fixup for
 non-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, Cornelia Huck <cohuck@redhat.com>

If we don't provide pci, we cannot have a pci device for which we
have to translate to adapter routes: just return -ENODEV.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/kvm.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 60688888c3..df0e5af151 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2424,22 +2424,27 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
     uint32_t idx = data >> ZPCI_MSI_VEC_BITS;
     uint32_t vec = data & ZPCI_MSI_VEC_MASK;
 
-    pbdev = s390_pci_find_dev_by_idx(s390_get_phb(), idx);
-    if (!pbdev) {
-        DPRINTF("add_msi_route no dev\n");
-        return -ENODEV;
-    }
+    if (s390_has_feat(S390_FEAT_ZPCI)) {
+        pbdev = s390_pci_find_dev_by_idx(s390_get_phb(), idx);
+        if (!pbdev) {
+            DPRINTF("add_msi_route no dev\n");
+            return -ENODEV;
+        }
 
-    pbdev->routes.adapter.ind_offset = vec;
+        pbdev->routes.adapter.ind_offset = vec;
 
-    route->type = KVM_IRQ_ROUTING_S390_ADAPTER;
-    route->flags = 0;
-    route->u.adapter.summary_addr = pbdev->routes.adapter.summary_addr;
-    route->u.adapter.ind_addr = pbdev->routes.adapter.ind_addr;
-    route->u.adapter.summary_offset = pbdev->routes.adapter.summary_offset;
-    route->u.adapter.ind_offset = pbdev->routes.adapter.ind_offset;
-    route->u.adapter.adapter_id = pbdev->routes.adapter.adapter_id;
-    return 0;
+        route->type = KVM_IRQ_ROUTING_S390_ADAPTER;
+        route->flags = 0;
+        route->u.adapter.summary_addr = pbdev->routes.adapter.summary_addr;
+        route->u.adapter.ind_addr = pbdev->routes.adapter.ind_addr;
+        route->u.adapter.summary_offset = pbdev->routes.adapter.summary_offset;
+        route->u.adapter.ind_offset = pbdev->routes.adapter.ind_offset;
+        route->u.adapter.adapter_id = pbdev->routes.adapter.adapter_id;
+        return 0;
+    } else {
+        DPRINTF("fixup_msi_route on non-pci machine?!\n");
+        return -ENODEV;
+    }
 }
 
 int kvm_arch_add_msi_route_post(struct kvm_irq_routing_entry *route,
-- 
2.13.3
