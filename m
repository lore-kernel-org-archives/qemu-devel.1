Received: from eggs.gnu.org ([2001:4830:134:3::10]:48311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyU-0007Y5-NM
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyR-0006VC-PO
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:54 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:34195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEyR-0006UL-Hr
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:51 -0400
Received: by mail-wr1-x431.google.com with SMTP id l6-v6so34705513wrt.1
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:32:51 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:31:57 +0200
Message-Id: <1539894735-14232-31-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 30/48] hyperv: make HvSintRoute reference-counted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Roman Kagan <rkagan@virtuozzo.com>

From: Roman Kagan <rkagan@virtuozzo.com>

Multiple entities (e.g. VMBus devices) can use the same SINT route.  To
make their lives easier in maintaining SINT route ownership, make it
reference-counted.  Adjust the respective API names accordingly.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20180921081836.29230-8-rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/misc/hyperv_testdev.c |  4 ++--
 target/i386/hyperv.c     | 25 +++++++++++++++++++++----
 target/i386/hyperv.h     | 10 +++++-----
 3 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/hw/misc/hyperv_testdev.c b/hw/misc/hyperv_testdev.c
index 1f32d3c..dbf4e7e 100644
--- a/hw/misc/hyperv_testdev.c
+++ b/hw/misc/hyperv_testdev.c
@@ -52,7 +52,7 @@ static void sint_route_create(HypervTestDev *dev,
     sint_route->vp_index = vp_index;
     sint_route->sint = sint;
 
-    sint_route->sint_route = kvm_hv_sint_route_create(vp_index, sint, NULL, NULL);
+    sint_route->sint_route = hyperv_sint_route_new(vp_index, sint, NULL, NULL);
     assert(sint_route->sint_route);
 
     QLIST_INSERT_HEAD(&dev->sint_routes, sint_route, le);
@@ -79,7 +79,7 @@ static void sint_route_destroy(HypervTestDev *dev,
 
     sint_route = sint_route_find(dev, vp_index, sint);
     QLIST_REMOVE(sint_route, le);
-    kvm_hv_sint_route_destroy(sint_route->sint_route);
+    hyperv_sint_route_unref(sint_route->sint_route);
     g_free(sint_route);
 }
 
diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index 0ce8a7a..4d8ef6f 100644
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
diff --git a/target/i386/hyperv.h b/target/i386/hyperv.h
index ab99047..cdf44a7 100644
--- a/target/i386/hyperv.h
+++ b/target/i386/hyperv.h
@@ -22,11 +22,11 @@ typedef void (*HvSintAckClb)(void *data);
 
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
 
-- 
1.8.3.1
