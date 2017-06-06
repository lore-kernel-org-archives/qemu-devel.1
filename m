Received: from eggs.gnu.org ([2001:4830:134:3::10]:47549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dIJ5X-00060V-Ga
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:20:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dIJ5T-0007Oa-6J
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:20:19 -0400
Received: from mail-eopbgr30103.outbound.protection.outlook.com
	([40.107.3.103]:45293
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dIJ5S-0007Ny-RA
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:20:15 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue,  6 Jun 2017 21:19:42 +0300
Message-Id: <20170606181948.16238-18-rkagan@virtuozzo.com>
In-Reply-To: <20170606181948.16238-1-rkagan@virtuozzo.com>
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 17/23] hyperv: add synic message delivery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

Add infrastructure to deliver SynIC messages to the guest SynIC message
page.

Note that KVM also may want to deliver (SynIC timer) messages to the
same message slot.

The problem is that the access to a SynIC message slot is controlled by
the value of its .msg_type field which indicates if the slot is being
owned by the hypervisor (zero) or by the guest (non-zero).

This leaves no room for synchronizing multiple concurrent producers.

The simplest way to deal with this for both KVM and QEMU is to only
deliver messages in the vcpu thread.  KVM already does this; this patch
makes it for QEMU, too.

Specifically,

 - add a function for posting messages, which only copies the message
   into the staging buffer if its free, and schedules a work on the
   corresponding vcpu to actually deliver it to the guest slot;

 - instead of a sint ack callback, set up the sint route with a message
   status callback.  This function is called in a bh whenever there are
   updates to the message slot status: either the vcpu made definitive
   progress delivering the message from the staging buffer (succeeded or
   failed) or the guest issued EOM; the status is passed as an argument
   to the callback.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 target/i386/hyperv.h |   7 ++--
 target/i386/hyperv.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 109 insertions(+), 14 deletions(-)

diff --git a/target/i386/hyperv.h b/target/i386/hyperv.h
index 9dd5ca0..fa3e988 100644
--- a/target/i386/hyperv.h
+++ b/target/i386/hyperv.h
@@ -19,13 +19,12 @@
 #include "qemu/event_notifier.h"
 
 typedef struct HvSintRoute HvSintRoute;
-typedef void (*HvSintAckClb)(void *data);
+typedef void (*HvSintMsgCb)(void *data, int status);
 
 int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit);
 
 HvSintRoute *hyperv_sint_route_new(X86CPU *cpu, uint32_t sint,
-                                   HvSintAckClb sint_ack_clb,
-                                   void *sint_ack_clb_data);
+                                   HvSintMsgCb cb, void *cb_data);
 void hyperv_sint_route_ref(HvSintRoute *sint_route);
 void hyperv_sint_route_unref(HvSintRoute *sint_route);
 
@@ -38,4 +37,6 @@ void hyperv_synic_add(X86CPU *cpu);
 void hyperv_synic_reset(X86CPU *cpu);
 void hyperv_synic_update(X86CPU *cpu);
 
+int hyperv_post_msg(HvSintRoute *sint_route, struct hyperv_message *msg);
+
 #endif
diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index 165133a..0a7f9b1 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -44,8 +44,21 @@ struct HvSintRoute {
     int gsi;
     EventNotifier sint_set_notifier;
     EventNotifier sint_ack_notifier;
-    HvSintAckClb sint_ack_clb;
-    void *sint_ack_clb_data;
+
+    HvSintMsgCb msg_cb;
+    void *msg_cb_data;
+    QEMUBH *msg_bh;
+    struct hyperv_message *msg;
+    /*
+     * the state of the message staged in .msg:
+     * 0        - the staging area is not in use (after init or message
+     *            successfully delivered to guest)
+     * -EBUSY   - the staging area is being used in vcpu thread
+     * -EAGAIN  - delivery attempt failed due to slot being busy, retry
+     * -EXXXX   - error
+     */
+    int msg_status;
+
     unsigned refcount;
 };
 
@@ -112,6 +125,69 @@ static void synic_update(SynICState *synic)
     synic_update_evt_page_addr(synic);
 }
 
+/*
+ * Worker to transfer the message from the staging area into the guest-owned
+ * message page in vcpu context, which guarantees serialization with both KVM
+ * vcpu and the guest cpu.
+ */
+static void cpu_post_msg(CPUState *cs, run_on_cpu_data data)
+{
+    int ret;
+    HvSintRoute *sint_route = data.host_ptr;
+    SynICState *synic = sint_route->synic;
+    struct hyperv_message *dst_msg;
+
+    if (!synic->enabled || !synic->msg_page_addr) {
+        ret = -ENXIO;
+        goto notify;
+    }
+
+    dst_msg = &synic->msg_page->slot[sint_route->sint];
+
+    if (dst_msg->header.message_type != HV_MESSAGE_NONE) {
+        dst_msg->header.message_flags |= HV_MESSAGE_FLAG_PENDING;
+        ret = -EAGAIN;
+    } else {
+        memcpy(dst_msg, sint_route->msg, sizeof(*dst_msg));
+        ret = kvm_hv_sint_route_set_sint(sint_route);
+    }
+
+    memory_region_set_dirty(&synic->msg_page_mr, 0, sizeof(*synic->msg_page));
+
+notify:
+    sint_route->msg_status = ret;
+    /* notify the msg originator of the progress made; if the slot was busy we
+     * set msg_pending flag in it so it will be the guest who will do EOM and
+     * trigger the notification from KVM via sint_ack_notifier */
+    if (ret != -EAGAIN) {
+        qemu_bh_schedule(sint_route->msg_bh);
+    }
+}
+
+/*
+ * Post a Hyper-V message to the staging area, for delivery to guest in the
+ * vcpu thread.
+ */
+int hyperv_post_msg(HvSintRoute *sint_route, struct hyperv_message *src_msg)
+{
+    int ret = sint_route->msg_status;
+
+    assert(sint_route->msg_cb);
+
+    if (ret == -EBUSY) {
+        return -EAGAIN;
+    }
+    if (ret) {
+        return ret;
+    }
+
+    sint_route->msg_status = -EBUSY;
+    memcpy(sint_route->msg, src_msg, sizeof(*src_msg));
+
+    async_run_on_cpu(CPU(sint_route->synic->cpu), cpu_post_msg,
+                     RUN_ON_CPU_HOST_PTR(sint_route));
+    return 0;
+}
 
 static void async_synic_update(CPUState *cs, run_on_cpu_data data)
 {
@@ -164,17 +240,27 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
     }
 }
 
-static void kvm_hv_sint_ack_handler(EventNotifier *notifier)
+static void sint_ack_handler(EventNotifier *notifier)
 {
     HvSintRoute *sint_route = container_of(notifier, HvSintRoute,
                                            sint_ack_notifier);
     event_notifier_test_and_clear(notifier);
-    sint_route->sint_ack_clb(sint_route->sint_ack_clb_data);
+
+    if (sint_route->msg_status == -EAGAIN) {
+        qemu_bh_schedule(sint_route->msg_bh);
+    }
+}
+
+static void sint_msg_bh(void *opaque)
+{
+    HvSintRoute *sint_route = opaque;
+    int status = sint_route->msg_status;
+    sint_route->msg_status = 0;
+    sint_route->msg_cb(sint_route->msg_cb_data, status);
 }
 
 HvSintRoute *hyperv_sint_route_new(X86CPU *cpu, uint32_t sint,
-                                   HvSintAckClb sint_ack_clb,
-                                   void *sint_ack_clb_data)
+                                   HvSintMsgCb cb, void *cb_data)
 {
     SynICState *synic;
     HvSintRoute *sint_route;
@@ -189,14 +275,18 @@ HvSintRoute *hyperv_sint_route_new(X86CPU *cpu, uint32_t sint,
         goto err;
     }
 
-    ack_notifier = sint_ack_clb ? &sint_route->sint_ack_notifier : NULL;
+    ack_notifier = cb ? &sint_route->sint_ack_notifier : NULL;
     if (ack_notifier) {
+        sint_route->msg = g_new(struct hyperv_message, 1);
+
         r = event_notifier_init(ack_notifier, false);
         if (r) {
             goto err_sint_set_notifier;
         }
 
-        event_notifier_set_handler(ack_notifier, kvm_hv_sint_ack_handler);
+        event_notifier_set_handler(ack_notifier, sint_ack_handler);
+
+        sint_route->msg_bh = qemu_bh_new(sint_msg_bh, sint_route);
     }
 
     gsi = kvm_irqchip_add_hv_sint_route(kvm_state, hyperv_vp_index(cpu), sint);
@@ -211,8 +301,8 @@ HvSintRoute *hyperv_sint_route_new(X86CPU *cpu, uint32_t sint,
         goto err_irqfd;
     }
     sint_route->gsi = gsi;
-    sint_route->sint_ack_clb = sint_ack_clb;
-    sint_route->sint_ack_clb_data = sint_ack_clb_data;
+    sint_route->msg_cb = cb;
+    sint_route->msg_cb_data = cb_data;
     sint_route->synic = synic;
     sint_route->sint = sint;
     sint_route->refcount = 1;
@@ -223,8 +313,10 @@ err_irqfd:
     kvm_irqchip_release_virq(kvm_state, gsi);
 err_gsi:
     if (ack_notifier) {
+        qemu_bh_delete(sint_route->msg_bh);
         event_notifier_set_handler(ack_notifier, NULL);
         event_notifier_cleanup(ack_notifier);
+        g_free(sint_route->msg);
     }
 err_sint_set_notifier:
     event_notifier_cleanup(&sint_route->sint_set_notifier);
@@ -255,9 +347,11 @@ void hyperv_sint_route_unref(HvSintRoute *sint_route)
                                           &sint_route->sint_set_notifier,
                                           sint_route->gsi);
     kvm_irqchip_release_virq(kvm_state, sint_route->gsi);
-    if (sint_route->sint_ack_clb) {
+    if (sint_route->msg_cb) {
+        qemu_bh_delete(sint_route->msg_bh);
         event_notifier_set_handler(&sint_route->sint_ack_notifier, NULL);
         event_notifier_cleanup(&sint_route->sint_ack_notifier);
+        g_free(sint_route->msg);
     }
     event_notifier_cleanup(&sint_route->sint_set_notifier);
     g_free(sint_route);
-- 
2.9.4
