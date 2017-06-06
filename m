Received: from eggs.gnu.org ([2001:4830:134:3::10]:47604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dIJ5c-00064I-7j
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dIJ5X-0007Ps-Cf
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:20:24 -0400
Received: from mail-eopbgr30118.outbound.protection.outlook.com
	([40.107.3.118]:59885
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dIJ5X-0007Pa-1Q
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:20:19 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue,  6 Jun 2017 21:19:45 +0300
Message-Id: <20170606181948.16238-21-rkagan@virtuozzo.com>
In-Reply-To: <20170606181948.16238-1-rkagan@virtuozzo.com>
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 20/23] hyperv: process POST_MESSAGE hypercall
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

Add handling of POST_MESSAGE hypercall.  For that, add an interface to
regsiter a handler for the messages arrived from the guest on a
particular connection id (IOW set up a message connection in Hyper-V
speak).

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 target/i386/hyperv.h |  5 +++
 target/i386/hyperv.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/target/i386/hyperv.h b/target/i386/hyperv.h
index d2630ac..f82c770 100644
--- a/target/i386/hyperv.h
+++ b/target/i386/hyperv.h
@@ -41,6 +41,11 @@ int hyperv_post_msg(HvSintRoute *sint_route, struct hyperv_message *msg);
 
 int hyperv_set_evt_flag(HvSintRoute *sint_route, unsigned evtno);
 
+struct hyperv_post_message_input;
+typedef uint64_t (*HvMsgHandler)(const struct hyperv_post_message_input *msg,
+                                 void *data);
+int hyperv_set_msg_handler(uint32_t conn_id, HvMsgHandler handler, void *data);
+
 int hyperv_set_evt_notifier(uint32_t conn_id, EventNotifier *notifier);
 
 #endif
diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index 030184e..50386a2 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -232,6 +232,17 @@ static void async_synic_update(CPUState *cs, run_on_cpu_data data)
     qemu_mutex_unlock_iothread();
 }
 
+typedef struct MsgHandler {
+    struct rcu_head rcu;
+    QLIST_ENTRY(MsgHandler) le;
+    uint32_t conn_id;
+    HvMsgHandler handler;
+    void *data;
+} MsgHandler;
+
+static QLIST_HEAD(, MsgHandler) msg_handlers;
+static QemuMutex msg_handlers_mutex;
+
 typedef struct EvtHandler {
     struct rcu_head rcu;
     QLIST_ENTRY(EvtHandler) le;
@@ -244,10 +255,46 @@ static QemuMutex evt_handlers_mutex;
 
 static void __attribute__((constructor)) hv_init(void)
 {
+    QLIST_INIT(&msg_handlers);
+    qemu_mutex_init(&msg_handlers_mutex);
     QLIST_INIT(&evt_handlers);
     qemu_mutex_init(&evt_handlers_mutex);
 }
 
+int hyperv_set_msg_handler(uint32_t conn_id, HvMsgHandler handler, void *data)
+{
+    int ret;
+    MsgHandler *mh;
+
+    qemu_mutex_lock(&msg_handlers_mutex);
+    QLIST_FOREACH(mh, &msg_handlers, le) {
+        if (mh->conn_id == conn_id) {
+            if (handler) {
+                ret = -EEXIST;
+            } else {
+                QLIST_REMOVE_RCU(mh, le);
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
+        QLIST_INSERT_HEAD_RCU(&msg_handlers, mh, le);
+        ret = 0;
+    } else {
+        ret = -ENOENT;
+    }
+unlock:
+    qemu_mutex_unlock(&msg_handlers_mutex);
+    return ret;
+}
+
 int hyperv_set_evt_notifier(uint32_t conn_id, EventNotifier *notifier)
 {
     int ret;
@@ -281,6 +328,46 @@ unlock:
     return ret;
 }
 
+static uint64_t hvcall_post_message(uint64_t param, bool fast)
+{
+    uint64_t ret;
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
+    QLIST_FOREACH_RCU(mh, &msg_handlers, le) {
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
 static uint64_t sigevent_params(hwaddr addr, uint32_t *conn_id)
 {
     uint64_t ret;
@@ -364,6 +451,9 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
         uint64_t param = exit->u.hcall.params[0];
 
         switch (code) {
+        case HV_POST_MESSAGE:
+            exit->u.hcall.result = hvcall_post_message(param, fast);
+            break;
         case HV_SIGNAL_EVENT:
             exit->u.hcall.result = hvcall_signal_event(param, fast);
             break;
-- 
2.9.4
