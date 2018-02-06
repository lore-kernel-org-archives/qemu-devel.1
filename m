Received: from eggs.gnu.org ([2001:4830:134:3::10]:44736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9tu-0000qw-8p
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9tr-00038x-Gx
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:34 -0500
Received: from mail-eopbgr00096.outbound.protection.outlook.com
	([40.107.0.96]:29741
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1ej9tr-00037n-4A
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:31 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue,  6 Feb 2018 23:30:27 +0300
Message-Id: <20180206203048.11096-14-rkagan@virtuozzo.com>
In-Reply-To: <20180206203048.11096-1-rkagan@virtuozzo.com>
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH 13/34] hyperv: process SIGNAL_EVENT
 hypercall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>, Ben Warren <ben@skyportsystems.com>, si-wei liu <si-wei.liu@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, Vadim Rozenfeld <vrozenfe@redhat.com>

Add handling of SIGNAL_EVENT hypercall.  For that, provide an interface
to associate an EventNotifier with an event connection number, so that
it's signaled when the SIGNAL_EVENT hypercall with the matching
parameters is called by the guest.

TODO: we should be able to move this to KVM and avoid expensive user
exit just to look up an eventfd by connection number and signal it.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 target/i386/hyperv.h |   2 +
 target/i386/hyperv.c | 113 +++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 111 insertions(+), 4 deletions(-)

diff --git a/target/i386/hyperv.h b/target/i386/hyperv.h
index 3d942e5524..4ce41fe314 100644
--- a/target/i386/hyperv.h
+++ b/target/i386/hyperv.h
@@ -43,4 +43,6 @@ int hyperv_post_msg(HvSintRoute *sint_route, struct hyperv_message *msg);
 
 int hyperv_set_evt_flag(HvSintRoute *sint_route, unsigned evtno);
 
+int hyperv_set_evt_notifier(uint32_t conn_id, EventNotifier *notifier);
+
 #endif
diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index b557cd5d5d..9cf1225385 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -19,6 +19,9 @@
 #include "exec/address-spaces.h"
 #include "sysemu/cpus.h"
 #include "qemu/bitops.h"
+#include "qemu/queue.h"
+#include "qemu/rcu.h"
+#include "qemu/rcu_queue.h"
 #include "migration/vmstate.h"
 #include "hyperv.h"
 #include "hyperv-proto.h"
@@ -249,6 +252,106 @@ static void async_synic_update(CPUState *cs, run_on_cpu_data data)
     qemu_mutex_unlock_iothread();
 }
 
+typedef struct EvtHandler {
+    struct rcu_head rcu;
+    QLIST_ENTRY(EvtHandler) le;
+    uint32_t conn_id;
+    EventNotifier *notifier;
+} EvtHandler;
+
+static QLIST_HEAD(, EvtHandler) evt_handlers;
+static QemuMutex handlers_mutex;
+
+static void __attribute__((constructor)) hv_init(void)
+{
+    QLIST_INIT(&evt_handlers);
+    qemu_mutex_init(&handlers_mutex);
+}
+
+int hyperv_set_evt_notifier(uint32_t conn_id, EventNotifier *notifier)
+{
+    int ret;
+    EvtHandler *eh;
+
+    qemu_mutex_lock(&handlers_mutex);
+    QLIST_FOREACH(eh, &evt_handlers, le) {
+        if (eh->conn_id == conn_id) {
+            if (notifier) {
+                ret = -EEXIST;
+            } else {
+                QLIST_REMOVE_RCU(eh, le);
+                g_free_rcu(eh, rcu);
+                ret = 0;
+            }
+            goto unlock;
+        }
+    }
+
+    if (notifier) {
+        eh = g_new(EvtHandler, 1);
+        eh->conn_id = conn_id;
+        eh->notifier = notifier;
+        QLIST_INSERT_HEAD_RCU(&evt_handlers, eh, le);
+        ret = 0;
+    } else {
+        ret = -ENOENT;
+    }
+unlock:
+    qemu_mutex_unlock(&handlers_mutex);
+    return ret;
+}
+
+static uint64_t sigevent_params(hwaddr addr, uint32_t *conn_id)
+{
+    uint64_t ret;
+    hwaddr len;
+    struct hyperv_signal_event_input *msg;
+
+    if (addr & (__alignof__(*msg) - 1)) {
+        return HV_STATUS_INVALID_ALIGNMENT;
+    }
+
+    len = sizeof(*msg);
+    msg = cpu_physical_memory_map(addr, &len, 0);
+    if (len < sizeof(*msg)) {
+        ret = HV_STATUS_INSUFFICIENT_MEMORY;
+    } else {
+        *conn_id = (msg->connection_id & HV_CONNECTION_ID_MASK) +
+            msg->flag_number;
+        ret = 0;
+    }
+    cpu_physical_memory_unmap(msg, len, 0, 0);
+    return ret;
+}
+
+static uint64_t hvcall_signal_event(uint64_t param, bool fast)
+{
+    uint64_t ret;
+    uint32_t conn_id;
+    EvtHandler *eh;
+
+    if (likely(fast)) {
+        conn_id = (param & 0xffffffff) + ((param >> 32) & 0xffff);
+    } else {
+        ret = sigevent_params(param, &conn_id);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    ret = HV_STATUS_INVALID_CONNECTION_ID;
+    rcu_read_lock();
+    QLIST_FOREACH_RCU(eh, &evt_handlers, le) {
+        if (eh->conn_id == conn_id) {
+            event_notifier_set(eh->notifier);
+            ret = 0;
+            break;
+        }
+    }
+    rcu_read_unlock();
+    return ret;
+}
+
 int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
 {
     CPUX86State *env = &cpu->env;
@@ -281,16 +384,18 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
                               RUN_ON_CPU_HOST_PTR(get_synic(cpu)));
         return 0;
     case KVM_EXIT_HYPERV_HCALL: {
-        uint16_t code;
+        uint16_t code = exit->u.hcall.input & 0xffff;
+        bool fast = exit->u.hcall.input & HV_HYPERCALL_FAST;
+        uint64_t param = exit->u.hcall.params[0];
 
-        code  = exit->u.hcall.input & 0xffff;
         switch (code) {
-        case HV_POST_MESSAGE:
         case HV_SIGNAL_EVENT:
+            exit->u.hcall.result = hvcall_signal_event(param, fast);
+            break;
         default:
             exit->u.hcall.result = HV_STATUS_INVALID_HYPERCALL_CODE;
-            return 0;
         }
+        return 0;
     }
     default:
         return -1;
-- 
2.14.3
