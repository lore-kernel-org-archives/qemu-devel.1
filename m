Received: from eggs.gnu.org ([2001:4830:134:3::10]:59482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fa2AQ-0007xP-NI
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fa2AO-00049W-Rr
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:59:10 -0400
Received: from mail-db5eur01on070c.outbound.protection.outlook.com
	([2a01:111:f400:fe02::70c]:55516
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1fa2AO-00048w-I7
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:59:08 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Mon,  2 Jul 2018 19:58:42 +0300
Message-Id: <20180702165842.11423-7-rkagan@virtuozzo.com>
In-Reply-To: <20180702165842.11423-1-rkagan@virtuozzo.com>
References: <20180702165842.11423-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 6/6] hyperv: make HvSintRoute reference-counted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Liran Alon <liran.alon@oracle.com>, Si-Wei Liu <si-wei.liu@oracle.com>, Karl Heubaum <karl.heubaum@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>, Liam Merwick <liam.merwick@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>

Multiple entities (e.g. VMBus devices) can use the same SINT route.  To
make their lives easier in maintaining SINT route ownership, make it
reference-counted.  Adjust the respective API names accordingly.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 target/i386/hyperv.h     | 10 +++++-----
 hw/misc/hyperv_testdev.c |  4 ++--
 target/i386/hyperv.c     | 25 +++++++++++++++++++++----
 3 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/target/i386/hyperv.h b/target/i386/hyperv.h
index 93f7300dd6..af5fc05ea4 100644
--- a/target/i386/hyperv.h
+++ b/target/i386/hyperv.h
@@ -23,11 +23,11 @@ typedef void (*HvSintAckClb)(void *data);
 
 int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit);
 
-HvSintRoute *kvm_hv_sint_route_create(uint32_t vp_index, uint32_t sint,
-                                      HvSintAckClb sint_ack_clb,
-                                      void *sint_ack_clb_data);
-
-void kvm_hv_sint_route_destroy(HvSintRoute *sint_route);
+HvSintRoute *hyperv_sint_route_new(uint32_t vp_index, uint32_t sint,
+                                   HvSintAckClb sint_ack_clb,
+                                   void *sint_ack_clb_data);
+void hyperv_sint_route_ref(HvSintRoute *sint_route);
+void hyperv_sint_route_unref(HvSintRoute *sint_route);
 
 int kvm_hv_sint_route_set_sint(HvSintRoute *sint_route);
 
diff --git a/hw/misc/hyperv_testdev.c b/hw/misc/hyperv_testdev.c
index 50dfa6af64..d29201b5ee 100644
--- a/hw/misc/hyperv_testdev.c
+++ b/hw/misc/hyperv_testdev.c
@@ -56,7 +56,7 @@ static void sint_route_create(HypervTestDev *dev,
     sint_route->vp_index = vp_index;
     sint_route->sint = sint;
 
-    sint_route->sint_route = kvm_hv_sint_route_create(vp_index, sint, NULL, NULL);
+    sint_route->sint_route = hyperv_sint_route_new(vp_index, sint, NULL, NULL);
     assert(sint_route->sint_route);
 
     QLIST_INSERT_HEAD(&dev->sint_routes, sint_route, le);
@@ -83,7 +83,7 @@ static void sint_route_destroy(HypervTestDev *dev,
 
     sint_route = sint_route_find(dev, vp_index, sint);
     QLIST_REMOVE(sint_route, le);
-    kvm_hv_sint_route_destroy(sint_route->sint_route);
+    hyperv_sint_route_unref(sint_route->sint_route);
     g_free(sint_route);
 }
 
diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index 0ce8a7aa2f..4d8ef6f2da 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -24,6 +24,7 @@ struct HvSintRoute {
     EventNotifier sint_ack_notifier;
     HvSintAckClb sint_ack_clb;
     void *sint_ack_clb_data;
+    unsigned refcount;
 };
 
 uint32_t hyperv_vp_index(X86CPU *cpu)
@@ -90,9 +91,9 @@ static void kvm_hv_sint_ack_handler(EventNotifier *notifier)
     sint_route->sint_ack_clb(sint_route->sint_ack_clb_data);
 }
 
-HvSintRoute *kvm_hv_sint_route_create(uint32_t vp_index, uint32_t sint,
-                                      HvSintAckClb sint_ack_clb,
-                                      void *sint_ack_clb_data)
+HvSintRoute *hyperv_sint_route_new(uint32_t vp_index, uint32_t sint,
+                                   HvSintAckClb sint_ack_clb,
+                                   void *sint_ack_clb_data)
 {
     HvSintRoute *sint_route;
     EventNotifier *ack_notifier;
@@ -136,6 +137,7 @@ HvSintRoute *kvm_hv_sint_route_create(uint32_t vp_index, uint32_t sint,
     sint_route->sint_ack_clb_data = sint_ack_clb_data;
     sint_route->cpu = cpu;
     sint_route->sint = sint;
+    sint_route->refcount = 1;
 
     return sint_route;
 
@@ -154,8 +156,23 @@ err:
     return NULL;
 }
 
-void kvm_hv_sint_route_destroy(HvSintRoute *sint_route)
+void hyperv_sint_route_ref(HvSintRoute *sint_route)
 {
+    sint_route->refcount++;
+}
+
+void hyperv_sint_route_unref(HvSintRoute *sint_route)
+{
+    if (!sint_route) {
+        return;
+    }
+
+    assert(sint_route->refcount > 0);
+
+    if (--sint_route->refcount) {
+        return;
+    }
+
     kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state,
                                           &sint_route->sint_set_notifier,
                                           sint_route->gsi);
-- 
2.17.1
