Received: from eggs.gnu.org ([2001:4830:134:3::10]:48430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffRZB-00054k-Md
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffRZA-0007CI-IA
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54078 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ffRZA-0007C3-B0
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:04 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Jul 2018 17:06:45 +0200
Message-Id: <1531840015-28804-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1531840015-28804-1-git-send-email-pbonzini@redhat.com>
References: <1531840015-28804-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 03/13] hyperv: rename vcpu_id to vp_index
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

In Hyper-V-related code, vCPUs are identified by their VP (virtual
processor) index.  Since it's customary for "vcpu_id" in QEMU to mean
APIC id, rename the respective variables to "vp_index" to make the
distinction clear.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20180702134156.13404-2-rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/misc/hyperv_testdev.c | 16 ++++++++--------
 target/i386/hyperv.c     |  6 +++---
 target/i386/hyperv.h     |  4 ++--
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/misc/hyperv_testdev.c b/hw/misc/hyperv_testdev.c
index dbd7cdd..bf6bbfa 100644
--- a/hw/misc/hyperv_testdev.c
+++ b/hw/misc/hyperv_testdev.c
@@ -57,7 +57,7 @@ static void free_sint_route_index(HypervTestDev *dev, int i)
     dev->sint_route[i] = NULL;
 }
 
-static int find_sint_route_index(HypervTestDev *dev, uint32_t vcpu_id,
+static int find_sint_route_index(HypervTestDev *dev, uint32_t vp_index,
                                  uint32_t sint)
 {
     HvSintRoute *sint_route;
@@ -65,7 +65,7 @@ static int find_sint_route_index(HypervTestDev *dev, uint32_t vcpu_id,
 
     for (i = 0; i < ARRAY_SIZE(dev->sint_route); i++) {
         sint_route = dev->sint_route[i];
-        if (sint_route && sint_route->vcpu_id == vcpu_id &&
+        if (sint_route && sint_route->vp_index == vp_index &&
             sint_route->sint == sint) {
             return i;
         }
@@ -74,7 +74,7 @@ static int find_sint_route_index(HypervTestDev *dev, uint32_t vcpu_id,
 }
 
 static void hv_synic_test_dev_control(HypervTestDev *dev, uint32_t ctl,
-                                      uint32_t vcpu_id, uint32_t sint)
+                                      uint32_t vp_index, uint32_t sint)
 {
     int i;
     HvSintRoute *sint_route;
@@ -83,19 +83,19 @@ static void hv_synic_test_dev_control(HypervTestDev *dev, uint32_t ctl,
     case HV_TEST_DEV_SINT_ROUTE_CREATE:
         i = alloc_sint_route_index(dev);
         assert(i >= 0);
-        sint_route = kvm_hv_sint_route_create(vcpu_id, sint, NULL);
+        sint_route = kvm_hv_sint_route_create(vp_index, sint, NULL);
         assert(sint_route);
         dev->sint_route[i] = sint_route;
         break;
     case HV_TEST_DEV_SINT_ROUTE_DESTROY:
-        i = find_sint_route_index(dev, vcpu_id, sint);
+        i = find_sint_route_index(dev, vp_index, sint);
         assert(i >= 0);
         sint_route = dev->sint_route[i];
         kvm_hv_sint_route_destroy(sint_route);
         free_sint_route_index(dev, i);
         break;
     case HV_TEST_DEV_SINT_ROUTE_SET_SINT:
-        i = find_sint_route_index(dev, vcpu_id, sint);
+        i = find_sint_route_index(dev, vp_index, sint);
         assert(i >= 0);
         sint_route = dev->sint_route[i];
         kvm_hv_sint_route_set_sint(sint_route);
@@ -117,8 +117,8 @@ static void hv_test_dev_control(void *opaque, hwaddr addr, uint64_t data,
     case HV_TEST_DEV_SINT_ROUTE_DESTROY:
     case HV_TEST_DEV_SINT_ROUTE_SET_SINT: {
         uint8_t sint = data & 0xFF;
-        uint8_t vcpu_id = (data >> 8ULL) & 0xFF;
-        hv_synic_test_dev_control(dev, ctl, vcpu_id, sint);
+        uint8_t vp_index = (data >> 8ULL) & 0xFF;
+        hv_synic_test_dev_control(dev, ctl, vp_index, sint);
         break;
     }
     default:
diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index a050c9d..7cc0fbb 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -72,7 +72,7 @@ static void kvm_hv_sint_ack_handler(EventNotifier *notifier)
     }
 }
 
-HvSintRoute *kvm_hv_sint_route_create(uint32_t vcpu_id, uint32_t sint,
+HvSintRoute *kvm_hv_sint_route_create(uint32_t vp_index, uint32_t sint,
                                       HvSintAckClb sint_ack_clb)
 {
     HvSintRoute *sint_route;
@@ -92,7 +92,7 @@ HvSintRoute *kvm_hv_sint_route_create(uint32_t vcpu_id, uint32_t sint,
     event_notifier_set_handler(&sint_route->sint_ack_notifier,
                                kvm_hv_sint_ack_handler);
 
-    gsi = kvm_irqchip_add_hv_sint_route(kvm_state, vcpu_id, sint);
+    gsi = kvm_irqchip_add_hv_sint_route(kvm_state, vp_index, sint);
     if (gsi < 0) {
         goto err_gsi;
     }
@@ -105,7 +105,7 @@ HvSintRoute *kvm_hv_sint_route_create(uint32_t vcpu_id, uint32_t sint,
     }
     sint_route->gsi = gsi;
     sint_route->sint_ack_clb = sint_ack_clb;
-    sint_route->vcpu_id = vcpu_id;
+    sint_route->vp_index = vp_index;
     sint_route->sint = sint;
 
     return sint_route;
diff --git a/target/i386/hyperv.h b/target/i386/hyperv.h
index 0c3b562..eaf3df3 100644
--- a/target/i386/hyperv.h
+++ b/target/i386/hyperv.h
@@ -23,7 +23,7 @@ typedef void (*HvSintAckClb)(HvSintRoute *sint_route);
 
 struct HvSintRoute {
     uint32_t sint;
-    uint32_t vcpu_id;
+    uint32_t vp_index;
     int gsi;
     EventNotifier sint_set_notifier;
     EventNotifier sint_ack_notifier;
@@ -32,7 +32,7 @@ struct HvSintRoute {
 
 int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit);
 
-HvSintRoute *kvm_hv_sint_route_create(uint32_t vcpu_id, uint32_t sint,
+HvSintRoute *kvm_hv_sint_route_create(uint32_t vp_index, uint32_t sint,
                                       HvSintAckClb sint_ack_clb);
 
 void kvm_hv_sint_route_destroy(HvSintRoute *sint_route);
-- 
1.8.3.1
