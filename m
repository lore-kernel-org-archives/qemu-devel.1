Received: from eggs.gnu.org ([2001:4830:134:3::10]:48562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyr-0008DM-RD
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyi-0006hQ-2a
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:12 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:56236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEyh-0006gt-RG
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:07 -0400
Received: by mail-wm1-x32d.google.com with SMTP id 206-v6so1558217wmb.5
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:33:07 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:32:12 +0200
Message-Id: <1539894735-14232-46-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 45/48] hyperv: process POST_MESSAGE hypercall
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

Add handling of POST_MESSAGE hypercall.  For that, add an interface to
regsiter a handler for the messages arrived from the guest on a
particular connection id (IOW set up a message connection in Hyper-V
speak).

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20180921082217.29481-10-rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/hyperv/hyperv.c         | 84 ++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/hyperv/hyperv.h | 18 ++++++++++
 target/i386/hyperv.c       |  3 ++
 3 files changed, 105 insertions(+)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 7a1c1bb..a28e724 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -455,6 +455,14 @@ int hyperv_sint_route_set_sint(HvSintRoute *sint_route)
     return event_notifier_set(&sint_route->sint_set_notifier);
 }
 
+typedef struct MsgHandler {
+    struct rcu_head rcu;
+    QLIST_ENTRY(MsgHandler) link;
+    uint32_t conn_id;
+    HvMsgHandler handler;
+    void *data;
+} MsgHandler;
+
 typedef struct EventFlagHandler {
     struct rcu_head rcu;
     QLIST_ENTRY(EventFlagHandler) link;
@@ -462,15 +470,91 @@ typedef struct EventFlagHandler {
     EventNotifier *notifier;
 } EventFlagHandler;
 
+static QLIST_HEAD(, MsgHandler) msg_handlers;
 static QLIST_HEAD(, EventFlagHandler) event_flag_handlers;
 static QemuMutex handlers_mutex;
 
 static void __attribute__((constructor)) hv_init(void)
 {
+    QLIST_INIT(&msg_handlers);
     QLIST_INIT(&event_flag_handlers);
     qemu_mutex_init(&handlers_mutex);
 }
 
+int hyperv_set_msg_handler(uint32_t conn_id, HvMsgHandler handler, void *data)
+{
+    int ret;
+    MsgHandler *mh;
+
+    qemu_mutex_lock(&handlers_mutex);
+    QLIST_FOREACH(mh, &msg_handlers, link) {
+        if (mh->conn_id == conn_id) {
+            if (handler) {
+                ret = -EEXIST;
+            } else {
+                QLIST_REMOVE_RCU(mh, link);
+                g_free_rcu(mh, rcu);
+                ret = 0;
+            }
+            goto unlock;
+        }
+    }
+
+    if (handler) {
+        mh = g_new(MsgHandler, 1);
+        mh->conn_id = conn_id;
+        mh->handler = handler;
+        mh->data = data;
+        QLIST_INSERT_HEAD_RCU(&msg_handlers, mh, link);
+        ret = 0;
+    } else {
+        ret = -ENOENT;
+    }
+unlock:
+    qemu_mutex_unlock(&handlers_mutex);
+    return ret;
+}
+
+uint16_t hyperv_hcall_post_message(uint64_t param, bool fast)
+{
+    uint16_t ret;
+    hwaddr len;
+    struct hyperv_post_message_input *msg;
+    MsgHandler *mh;
+
+    if (fast) {
+        return HV_STATUS_INVALID_HYPERCALL_CODE;
+    }
+    if (param & (__alignof__(*msg) - 1)) {
+        return HV_STATUS_INVALID_ALIGNMENT;
+    }
+
+    len = sizeof(*msg);
+    msg = cpu_physical_memory_map(param, &len, 0);
+    if (len < sizeof(*msg)) {
+        ret = HV_STATUS_INSUFFICIENT_MEMORY;
+        goto unmap;
+    }
+    if (msg->payload_size > sizeof(msg->payload)) {
+        ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
+        goto unmap;
+    }
+
+    ret = HV_STATUS_INVALID_CONNECTION_ID;
+    rcu_read_lock();
+    QLIST_FOREACH_RCU(mh, &msg_handlers, link) {
+        if (mh->conn_id == (msg->connection_id & HV_CONNECTION_ID_MASK)) {
+            ret = mh->handler(msg, mh->data);
+            break;
+        }
+    }
+    rcu_read_unlock();
+
+unmap:
+    cpu_physical_memory_unmap(msg, len, 0, 0);
+    return ret;
+}
+
 static int set_event_flag_handler(uint32_t conn_id, EventNotifier *notifier)
 {
     int ret;
diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
index df92ed7..597381c 100644
--- a/include/hw/hyperv/hyperv.h
+++ b/include/hw/hyperv/hyperv.h
@@ -40,6 +40,18 @@ int hyperv_post_msg(HvSintRoute *sint_route, struct hyperv_message *msg);
 int hyperv_set_event_flag(HvSintRoute *sint_route, unsigned eventno);
 
 /*
+ * Handler for messages arriving from the guest via HV_POST_MESSAGE hypercall.
+ * Executed in vcpu context.
+ */
+typedef uint16_t (*HvMsgHandler)(const struct hyperv_post_message_input *msg,
+                                 void *data);
+/*
+ * Associate @handler with the message connection @conn_id, such that @handler
+ * is called with @data when the guest executes HV_POST_MESSAGE hypercall on
+ * @conn_id.  If @handler is NULL clear the association.
+ */
+int hyperv_set_msg_handler(uint32_t conn_id, HvMsgHandler handler, void *data);
+/*
  * Associate @notifier with the event connection @conn_id, such that @notifier
  * is signaled when the guest executes HV_SIGNAL_EVENT hypercall on @conn_id.
  * If @notifier is NULL clear the association.
@@ -47,6 +59,12 @@ int hyperv_set_event_flag(HvSintRoute *sint_route, unsigned eventno);
 int hyperv_set_event_flag_handler(uint32_t conn_id, EventNotifier *notifier);
 
 /*
+ * Process HV_POST_MESSAGE hypercall: parse the data in the guest memory as
+ * specified in @param, and call the HvMsgHandler associated with the
+ * connection on the message contained therein.
+ */
+uint16_t hyperv_hcall_post_message(uint64_t param, bool fast);
+/*
  * Process HV_SIGNAL_EVENT hypercall: signal the EventNotifier associated with
  * the connection as specified in @param.
  */
diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index 96b3b5a..b264a28 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -84,6 +84,9 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
         uint64_t param = exit->u.hcall.params[0];
 
         switch (code) {
+        case HV_POST_MESSAGE:
+            exit->u.hcall.result = hyperv_hcall_post_message(param, fast);
+            break;
         case HV_SIGNAL_EVENT:
             exit->u.hcall.result = hyperv_hcall_signal_event(param, fast);
             break;
-- 
1.8.3.1
