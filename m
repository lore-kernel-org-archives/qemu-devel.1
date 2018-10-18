Received: from eggs.gnu.org ([2001:4830:134:3::10]:48312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyU-0007Y6-NN
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyP-0006TF-7Q
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:54 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:38253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEyO-0006Qn-VM
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:49 -0400
Received: by mail-wr1-x431.google.com with SMTP id a13-v6so35115883wrt.5
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:32:48 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:31:54 +0200
Message-Id: <1539894735-14232-28-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 27/48] hyperv: synic: only setup ack notifier if
 there's a callback
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

There's no point setting up an sint ack notifier if no callback is
specified.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20180921081836.29230-5-rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hyperv.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index 47368b7..acdb0ca 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -77,15 +77,14 @@ static void kvm_hv_sint_ack_handler(EventNotifier *notifier)
     HvSintRoute *sint_route = container_of(notifier, HvSintRoute,
                                            sint_ack_notifier);
     event_notifier_test_and_clear(notifier);
-    if (sint_route->sint_ack_clb) {
-        sint_route->sint_ack_clb(sint_route);
-    }
+    sint_route->sint_ack_clb(sint_route);
 }
 
 HvSintRoute *kvm_hv_sint_route_create(uint32_t vp_index, uint32_t sint,
                                       HvSintAckClb sint_ack_clb)
 {
     HvSintRoute *sint_route;
+    EventNotifier *ack_notifier;
     int r, gsi;
 
     sint_route = g_new0(HvSintRoute, 1);
@@ -94,13 +93,15 @@ HvSintRoute *kvm_hv_sint_route_create(uint32_t vp_index, uint32_t sint,
         goto err;
     }
 
-    r = event_notifier_init(&sint_route->sint_ack_notifier, false);
-    if (r) {
-        goto err_sint_set_notifier;
-    }
+    ack_notifier = sint_ack_clb ? &sint_route->sint_ack_notifier : NULL;
+    if (ack_notifier) {
+        r = event_notifier_init(ack_notifier, false);
+        if (r) {
+            goto err_sint_set_notifier;
+        }
 
-    event_notifier_set_handler(&sint_route->sint_ack_notifier,
-                               kvm_hv_sint_ack_handler);
+        event_notifier_set_handler(ack_notifier, kvm_hv_sint_ack_handler);
+    }
 
     gsi = kvm_irqchip_add_hv_sint_route(kvm_state, vp_index, sint);
     if (gsi < 0) {
@@ -109,7 +110,7 @@ HvSintRoute *kvm_hv_sint_route_create(uint32_t vp_index, uint32_t sint,
 
     r = kvm_irqchip_add_irqfd_notifier_gsi(kvm_state,
                                            &sint_route->sint_set_notifier,
-                                           &sint_route->sint_ack_notifier, gsi);
+                                           ack_notifier, gsi);
     if (r) {
         goto err_irqfd;
     }
@@ -123,8 +124,10 @@ HvSintRoute *kvm_hv_sint_route_create(uint32_t vp_index, uint32_t sint,
 err_irqfd:
     kvm_irqchip_release_virq(kvm_state, gsi);
 err_gsi:
-    event_notifier_set_handler(&sint_route->sint_ack_notifier, NULL);
-    event_notifier_cleanup(&sint_route->sint_ack_notifier);
+    if (ack_notifier) {
+        event_notifier_set_handler(ack_notifier, NULL);
+        event_notifier_cleanup(ack_notifier);
+    }
 err_sint_set_notifier:
     event_notifier_cleanup(&sint_route->sint_set_notifier);
 err:
@@ -139,8 +142,10 @@ void kvm_hv_sint_route_destroy(HvSintRoute *sint_route)
                                           &sint_route->sint_set_notifier,
                                           sint_route->gsi);
     kvm_irqchip_release_virq(kvm_state, sint_route->gsi);
-    event_notifier_set_handler(&sint_route->sint_ack_notifier, NULL);
-    event_notifier_cleanup(&sint_route->sint_ack_notifier);
+    if (sint_route->sint_ack_clb) {
+        event_notifier_set_handler(&sint_route->sint_ack_notifier, NULL);
+        event_notifier_cleanup(&sint_route->sint_ack_notifier);
+    }
     event_notifier_cleanup(&sint_route->sint_set_notifier);
     g_free(sint_route);
 }
-- 
1.8.3.1
