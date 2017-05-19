Received: from eggs.gnu.org ([2001:4830:134:3::10]:49367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dBfyH-0004Is-8d
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:21:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dBfyG-0000vO-Df
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:21:25 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33971)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dBfyG-0000v8-7L
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:21:24 -0400
Received: by mail-wm0-x242.google.com with SMTP id d127so17622354wmf.1
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 04:21:24 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 19 May 2017 13:20:58 +0200
Message-Id: <1495192872-27667-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1495192872-27667-1-git-send-email-pbonzini@redhat.com>
References: <1495192872-27667-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/20] kvm: irqchip: trace changes on msi
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
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

It'll be nice to know which virq belongs to which device/vector when
adding msi routes, so adding two more parameters for the add trace.

Meanwhile, releasing virq has no tracing before. Add one for it.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1494309644-18743-2-git-send-email-peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
1.8.3.1
