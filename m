Received: from eggs.gnu.org ([2001:4830:134:3::10]:48306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyU-0007Y3-Lx
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyP-0006TZ-KJ
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:54 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEyP-0006Sa-DN
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:49 -0400
Received: by mail-wm1-x344.google.com with SMTP id y144-v6so1607814wmd.4
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:32:49 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:31:55 +0200
Message-Id: <1539894735-14232-29-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 28/48] hyperv: allow passing arbitrary data to
 sint ack callback
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

Make sint ack callback accept an opaque pointer, that is stored on
sint_route at creation time.

This allows for more convenient interaction with the callback.

Besides, nothing outside hyperv.c should need to know the layout of
HvSintRoute fields any more so its declaration can be removed from the
header.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20180921081836.29230-6-rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/misc/hyperv_testdev.c |  2 +-
 target/i386/hyperv.c     | 16 ++++++++++++++--
 target/i386/hyperv.h     | 15 +++------------
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/hw/misc/hyperv_testdev.c b/hw/misc/hyperv_testdev.c
index 7291fb1..1f32d3c 100644
--- a/hw/misc/hyperv_testdev.c
+++ b/hw/misc/hyperv_testdev.c
@@ -52,7 +52,7 @@ static void sint_route_create(HypervTestDev *dev,
     sint_route->vp_index = vp_index;
     sint_route->sint = sint;
 
-    sint_route->sint_route = kvm_hv_sint_route_create(vp_index, sint, NULL);
+    sint_route->sint_route = kvm_hv_sint_route_create(vp_index, sint, NULL, NULL);
     assert(sint_route->sint_route);
 
     QLIST_INSERT_HEAD(&dev->sint_routes, sint_route, le);
diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index acdb0ca..11fd1ad 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -16,6 +16,16 @@
 #include "hyperv.h"
 #include "hyperv-proto.h"
 
+struct HvSintRoute {
+    uint32_t sint;
+    uint32_t vp_index;
+    int gsi;
+    EventNotifier sint_set_notifier;
+    EventNotifier sint_ack_notifier;
+    HvSintAckClb sint_ack_clb;
+    void *sint_ack_clb_data;
+};
+
 uint32_t hyperv_vp_index(X86CPU *cpu)
 {
     return CPU(cpu)->cpu_index;
@@ -77,11 +87,12 @@ static void kvm_hv_sint_ack_handler(EventNotifier *notifier)
     HvSintRoute *sint_route = container_of(notifier, HvSintRoute,
                                            sint_ack_notifier);
     event_notifier_test_and_clear(notifier);
-    sint_route->sint_ack_clb(sint_route);
+    sint_route->sint_ack_clb(sint_route->sint_ack_clb_data);
 }
 
 HvSintRoute *kvm_hv_sint_route_create(uint32_t vp_index, uint32_t sint,
-                                      HvSintAckClb sint_ack_clb)
+                                      HvSintAckClb sint_ack_clb,
+                                      void *sint_ack_clb_data)
 {
     HvSintRoute *sint_route;
     EventNotifier *ack_notifier;
@@ -116,6 +127,7 @@ HvSintRoute *kvm_hv_sint_route_create(uint32_t vp_index, uint32_t sint,
     }
     sint_route->gsi = gsi;
     sint_route->sint_ack_clb = sint_ack_clb;
+    sint_route->sint_ack_clb_data = sint_ack_clb_data;
     sint_route->vp_index = vp_index;
     sint_route->sint = sint;
 
diff --git a/target/i386/hyperv.h b/target/i386/hyperv.h
index 00c9b45..ab99047 100644
--- a/target/i386/hyperv.h
+++ b/target/i386/hyperv.h
@@ -16,24 +16,15 @@
 
 #include "cpu.h"
 #include "sysemu/kvm.h"
-#include "qemu/event_notifier.h"
 
 typedef struct HvSintRoute HvSintRoute;
-typedef void (*HvSintAckClb)(HvSintRoute *sint_route);
-
-struct HvSintRoute {
-    uint32_t sint;
-    uint32_t vp_index;
-    int gsi;
-    EventNotifier sint_set_notifier;
-    EventNotifier sint_ack_notifier;
-    HvSintAckClb sint_ack_clb;
-};
+typedef void (*HvSintAckClb)(void *data);
 
 int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit);
 
 HvSintRoute *kvm_hv_sint_route_create(uint32_t vp_index, uint32_t sint,
-                                      HvSintAckClb sint_ack_clb);
+                                      HvSintAckClb sint_ack_clb,
+                                      void *sint_ack_clb_data);
 
 void kvm_hv_sint_route_destroy(HvSintRoute *sint_route);
 
-- 
1.8.3.1
