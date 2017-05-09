Received: from eggs.gnu.org ([2001:4830:134:3::10]:35348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d7wlO-00037A-Gg
	for qemu-devel@nongnu.org; Tue, 09 May 2017 00:28:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d7wlN-00022I-IL
	for qemu-devel@nongnu.org; Tue, 09 May 2017 00:28:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d7wlN-00021z-C2
	for qemu-devel@nongnu.org; Tue, 09 May 2017 00:28:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5D0B080F97
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 04:28:40 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue,  9 May 2017 12:28:26 +0800
Message-Id: <1494304108-9805-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1494304108-9805-1-git-send-email-peterx@redhat.com>
References: <1494304108-9805-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] kvm: irqchip: trace changes on msi
 add/remove
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

It'll be nice to know which virq belongs to which device/vector when
adding msi routes, so adding two more parameters for the add trace.

Meanwhile, releasing virq has no tracing before. Add one for it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 kvm-all.c    | 4 +++-
 trace-events | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/kvm-all.c b/kvm-all.c
index 90b8573..2598b1f 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -1144,6 +1144,7 @@ void kvm_irqchip_release_virq(KVMState *s, int virq)
     }
     clear_gsi(s, virq);
     kvm_arch_release_virq_post(virq);
+    trace_kvm_irqchip_release_virq(virq);
 }
 
 static unsigned int kvm_hash_msi(uint32_t data)
@@ -1287,7 +1288,8 @@ int kvm_irqchip_add_msi_route(KVMState *s, int vector, PCIDevice *dev)
         return -EINVAL;
     }
 
-    trace_kvm_irqchip_add_msi_route(virq);
+    trace_kvm_irqchip_add_msi_route(dev ? dev->name : (char *)"N/A",
+                                    vector, virq);
 
     kvm_add_routing_entry(s, &kroute);
     kvm_arch_add_msi_route_post(&kroute, vector, dev);
diff --git a/trace-events b/trace-events
index e582d63..f01ec05 100644
--- a/trace-events
+++ b/trace-events
@@ -69,8 +69,9 @@ kvm_device_ioctl(int fd, int type, void *arg) "dev fd %d, type 0x%x, arg %p"
 kvm_failed_reg_get(uint64_t id, const char *msg) "Warning: Unable to retrieve ONEREG %" PRIu64 " from KVM: %s"
 kvm_failed_reg_set(uint64_t id, const char *msg) "Warning: Unable to set ONEREG %" PRIu64 " to KVM: %s"
 kvm_irqchip_commit_routes(void) ""
-kvm_irqchip_add_msi_route(int virq) "Adding MSI route virq=%d"
+kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s vector %d virq %d"
 kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
+kvm_irqchip_release_virq(int virq) "virq %d"
 
 # TCG related tracing (mostly disabled by default)
 # cpu-exec.c
-- 
2.7.4
