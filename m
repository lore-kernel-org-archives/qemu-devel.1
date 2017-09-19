Received: from eggs.gnu.org ([2001:4830:134:3::10]:38453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLd2-0005gd-Ec
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:44:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLcz-0002Ri-Kj
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:44:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duLcz-0002RU-Ew
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:44:05 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Sep 2017 18:43:03 +0200
Message-Id: <20170919164337.18555-5-cohuck@redhat.com>
In-Reply-To: <20170919164337.18555-1-cohuck@redhat.com>
References: <20170919164337.18555-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL v2 04/38] s390x/pci: fixup ind_offset of msix
 routing entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>

The guest uses the mpcifc instruction to register the aibvo of a zpci
device, which is the starting offset of indicators in the indicator
area and thus remains constant. Each msix vector is an offset from the
aibvo. When we map a msix route to an adapter route, we should not
modify the starting offset, but instead add the vector to the starting
offset to get the absolute offset in the specific route.

Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Message-Id: <1504606380-49341-3-git-send-email-zyimin@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/kvm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 1130a391d4..375369fd1c 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2436,14 +2436,12 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
         return -ENODEV;
     }
 
-    pbdev->routes.adapter.ind_offset = vec;
-
     route->type = KVM_IRQ_ROUTING_S390_ADAPTER;
     route->flags = 0;
     route->u.adapter.summary_addr = pbdev->routes.adapter.summary_addr;
     route->u.adapter.ind_addr = pbdev->routes.adapter.ind_addr;
     route->u.adapter.summary_offset = pbdev->routes.adapter.summary_offset;
-    route->u.adapter.ind_offset = pbdev->routes.adapter.ind_offset;
+    route->u.adapter.ind_offset = pbdev->routes.adapter.ind_offset + vec;
     route->u.adapter.adapter_id = pbdev->routes.adapter.adapter_id;
     return 0;
 }
-- 
2.13.5
