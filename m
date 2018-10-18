Received: from eggs.gnu.org ([2001:4830:134:3::10]:48498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyf-0007qG-EN
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEye-0006eV-4P
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:05 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:45776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEyd-0006dl-PQ
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:04 -0400
Received: by mail-wr1-x433.google.com with SMTP id f17-v6so3347571wrs.12
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:33:03 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:32:08 +0200
Message-Id: <1539894735-14232-42-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 41/48] hyperv: add synic message delivery
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

Add infrastructure to deliver SynIC messages to the SynIC message page.

Note that KVM may also want to deliver (SynIC timer) messages to the
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
Message-Id: <20180921082217.29481-6-rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/hyperv/hyperv.c         | 162 ++++++++++++++++++++++++++++++++++++++++++---
 include/hw/hyperv/hyperv.h |  18 ++++-
 2 files changed, 166 insertions(+), 14 deletions(-)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 70cf129..654ca4f 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -148,14 +148,51 @@ static void synic_register_types(void)
 
 type_init(synic_register_types)
 
+/*
+ * KVM has its own message producers (SynIC timers).  To guarantee
+ * serialization with both KVM vcpu and the guest cpu, the messages are first
+ * staged in an intermediate area and then posted to the SynIC message page in
+ * the vcpu thread.
+ */
+typedef struct HvSintStagedMessage {
+    /* message content staged by hyperv_post_msg */
+    struct hyperv_message msg;
+    /* callback + data (r/o) to complete the processing in a BH */
+    HvSintMsgCb cb;
+    void *cb_data;
+    /* message posting status filled by cpu_post_msg */
+    int status;
+    /* passing the buck: */
+    enum {
+        /* initial state */
+        HV_STAGED_MSG_FREE,
+        /*
+         * hyperv_post_msg (e.g. in main loop) grabs the staged area (FREE ->
+         * BUSY), copies msg, and schedules cpu_post_msg on the assigned cpu
+         */
+        HV_STAGED_MSG_BUSY,
+        /*
+         * cpu_post_msg (vcpu thread) tries to copy staged msg to msg slot,
+         * notify the guest, records the status, marks the posting done (BUSY
+         * -> POSTED), and schedules sint_msg_bh BH
+         */
+        HV_STAGED_MSG_POSTED,
+        /*
+         * sint_msg_bh (BH) verifies that the posting is done, runs the
+         * callback, and starts over (POSTED -> FREE)
+         */
+    } state;
+} HvSintStagedMessage;
+
 struct HvSintRoute {
     uint32_t sint;
     SynICState *synic;
     int gsi;
     EventNotifier sint_set_notifier;
     EventNotifier sint_ack_notifier;
-    HvSintAckClb sint_ack_clb;
-    void *sint_ack_clb_data;
+
+    HvSintStagedMessage *staged_msg;
+
     unsigned refcount;
 };
 
@@ -166,17 +203,115 @@ static CPUState *hyperv_find_vcpu(uint32_t vp_index)
     return cs;
 }
 
-static void kvm_hv_sint_ack_handler(EventNotifier *notifier)
+/*
+ * BH to complete the processing of a staged message.
+ */
+static void sint_msg_bh(void *opaque)
+{
+    HvSintRoute *sint_route = opaque;
+    HvSintStagedMessage *staged_msg = sint_route->staged_msg;
+
+    if (atomic_read(&staged_msg->state) != HV_STAGED_MSG_POSTED) {
+        /* status nor ready yet (spurious ack from guest?), ignore */
+        return;
+    }
+
+    staged_msg->cb(staged_msg->cb_data, staged_msg->status);
+    staged_msg->status = 0;
+
+    /* staged message processing finished, ready to start over */
+    atomic_set(&staged_msg->state, HV_STAGED_MSG_FREE);
+    /* drop the reference taken in hyperv_post_msg */
+    hyperv_sint_route_unref(sint_route);
+}
+
+/*
+ * Worker to transfer the message from the staging area into the SynIC message
+ * page in vcpu context.
+ */
+static void cpu_post_msg(CPUState *cs, run_on_cpu_data data)
+{
+    HvSintRoute *sint_route = data.host_ptr;
+    HvSintStagedMessage *staged_msg = sint_route->staged_msg;
+    SynICState *synic = sint_route->synic;
+    struct hyperv_message *dst_msg;
+    bool wait_for_sint_ack = false;
+
+    assert(staged_msg->state == HV_STAGED_MSG_BUSY);
+
+    if (!synic->enabled || !synic->msg_page_addr) {
+        staged_msg->status = -ENXIO;
+        goto posted;
+    }
+
+    dst_msg = &synic->msg_page->slot[sint_route->sint];
+
+    if (dst_msg->header.message_type != HV_MESSAGE_NONE) {
+        dst_msg->header.message_flags |= HV_MESSAGE_FLAG_PENDING;
+        staged_msg->status = -EAGAIN;
+        wait_for_sint_ack = true;
+    } else {
+        memcpy(dst_msg, &staged_msg->msg, sizeof(*dst_msg));
+        staged_msg->status = hyperv_sint_route_set_sint(sint_route);
+    }
+
+    memory_region_set_dirty(&synic->msg_page_mr, 0, sizeof(*synic->msg_page));
+
+posted:
+    atomic_set(&staged_msg->state, HV_STAGED_MSG_POSTED);
+    /*
+     * Notify the msg originator of the progress made; if the slot was busy we
+     * set msg_pending flag in it so it will be the guest who will do EOM and
+     * trigger the notification from KVM via sint_ack_notifier
+     */
+    if (!wait_for_sint_ack) {
+        aio_bh_schedule_oneshot(qemu_get_aio_context(), sint_msg_bh,
+                                sint_route);
+    }
+}
+
+/*
+ * Post a Hyper-V message to the staging area, for delivery to guest in the
+ * vcpu thread.
+ */
+int hyperv_post_msg(HvSintRoute *sint_route, struct hyperv_message *src_msg)
+{
+    HvSintStagedMessage *staged_msg = sint_route->staged_msg;
+
+    assert(staged_msg);
+
+    /* grab the staging area */
+    if (atomic_cmpxchg(&staged_msg->state, HV_STAGED_MSG_FREE,
+                       HV_STAGED_MSG_BUSY) != HV_STAGED_MSG_FREE) {
+        return -EAGAIN;
+    }
+
+    memcpy(&staged_msg->msg, src_msg, sizeof(*src_msg));
+
+    /* hold a reference on sint_route until the callback is finished */
+    hyperv_sint_route_ref(sint_route);
+
+    /* schedule message posting attempt in vcpu thread */
+    async_run_on_cpu(sint_route->synic->cs, cpu_post_msg,
+                     RUN_ON_CPU_HOST_PTR(sint_route));
+    return 0;
+}
+
+static void sint_ack_handler(EventNotifier *notifier)
 {
     HvSintRoute *sint_route = container_of(notifier, HvSintRoute,
                                            sint_ack_notifier);
     event_notifier_test_and_clear(notifier);
-    sint_route->sint_ack_clb(sint_route->sint_ack_clb_data);
+
+    /*
+     * the guest consumed the previous message so complete the current one with
+     * -EAGAIN and let the msg originator retry
+     */
+    aio_bh_schedule_oneshot(qemu_get_aio_context(), sint_msg_bh, sint_route);
 }
 
 HvSintRoute *hyperv_sint_route_new(uint32_t vp_index, uint32_t sint,
-                                   HvSintAckClb sint_ack_clb,
-                                   void *sint_ack_clb_data)
+                                   HvSintMsgCb cb, void *cb_data)
 {
     HvSintRoute *sint_route;
     EventNotifier *ack_notifier;
@@ -200,14 +335,19 @@ HvSintRoute *hyperv_sint_route_new(uint32_t vp_index, uint32_t sint,
         goto err;
     }
 
-    ack_notifier = sint_ack_clb ? &sint_route->sint_ack_notifier : NULL;
+
+    ack_notifier = cb ? &sint_route->sint_ack_notifier : NULL;
     if (ack_notifier) {
+        sint_route->staged_msg = g_new0(HvSintStagedMessage, 1);
+        sint_route->staged_msg->cb = cb;
+        sint_route->staged_msg->cb_data = cb_data;
+
         r = event_notifier_init(ack_notifier, false);
         if (r) {
             goto err_sint_set_notifier;
         }
 
-        event_notifier_set_handler(ack_notifier, kvm_hv_sint_ack_handler);
+        event_notifier_set_handler(ack_notifier, sint_ack_handler);
     }
 
     gsi = kvm_irqchip_add_hv_sint_route(kvm_state, vp_index, sint);
@@ -222,8 +362,6 @@ HvSintRoute *hyperv_sint_route_new(uint32_t vp_index, uint32_t sint,
         goto err_irqfd;
     }
     sint_route->gsi = gsi;
-    sint_route->sint_ack_clb = sint_ack_clb;
-    sint_route->sint_ack_clb_data = sint_ack_clb_data;
     sint_route->synic = synic;
     sint_route->sint = sint;
     sint_route->refcount = 1;
@@ -236,6 +374,7 @@ err_gsi:
     if (ack_notifier) {
         event_notifier_set_handler(ack_notifier, NULL);
         event_notifier_cleanup(ack_notifier);
+        g_free(sint_route->staged_msg);
     }
 err_sint_set_notifier:
     event_notifier_cleanup(&sint_route->sint_set_notifier);
@@ -266,9 +405,10 @@ void hyperv_sint_route_unref(HvSintRoute *sint_route)
                                           &sint_route->sint_set_notifier,
                                           sint_route->gsi);
     kvm_irqchip_release_virq(kvm_state, sint_route->gsi);
-    if (sint_route->sint_ack_clb) {
+    if (sint_route->staged_msg) {
         event_notifier_set_handler(&sint_route->sint_ack_notifier, NULL);
         event_notifier_cleanup(&sint_route->sint_ack_notifier);
+        g_free(sint_route->staged_msg);
     }
     event_notifier_cleanup(&sint_route->sint_set_notifier);
     g_free(sint_route);
diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
index 6fba476..82d561f 100644
--- a/include/hw/hyperv/hyperv.h
+++ b/include/hw/hyperv/hyperv.h
@@ -11,18 +11,30 @@
 #define HW_HYPERV_HYPERV_H
 
 #include "cpu-qom.h"
+#include "hw/hyperv/hyperv-proto.h"
 
 typedef struct HvSintRoute HvSintRoute;
-typedef void (*HvSintAckClb)(void *data);
+
+/*
+ * Callback executed in a bottom-half when the status of posting the message
+ * becomes known, before unblocking the connection for further messages
+ */
+typedef void (*HvSintMsgCb)(void *data, int status);
 
 HvSintRoute *hyperv_sint_route_new(uint32_t vp_index, uint32_t sint,
-                                   HvSintAckClb sint_ack_clb,
-                                   void *sint_ack_clb_data);
+                                   HvSintMsgCb cb, void *cb_data);
 void hyperv_sint_route_ref(HvSintRoute *sint_route);
 void hyperv_sint_route_unref(HvSintRoute *sint_route);
 
 int hyperv_sint_route_set_sint(HvSintRoute *sint_route);
 
+/*
+ * Submit a message to be posted in vcpu context.  If the submission succeeds,
+ * the status of posting the message is reported via the callback associated
+ * with the @sint_route; until then no more messages are accepted.
+ */
+int hyperv_post_msg(HvSintRoute *sint_route, struct hyperv_message *msg);
+
 static inline uint32_t hyperv_vp_index(CPUState *cs)
 {
     return cs->cpu_index;
-- 
1.8.3.1
