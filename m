Received: from eggs.gnu.org ([2001:4830:134:3::10]:59897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qNb-0001t2-RH
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:26:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qNa-0000m4-Sx
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:26:55 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3507
	helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qNa-0000jw-9A
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:26:54 -0400
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Sat, 22 Apr 2017 16:25:56 +0800
Message-ID: <1492849558-17540-17-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1492849558-17540-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1492849558-17540-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 16/18] filter: Add handle_event method for
 NetFilterClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, gilbert@redhat.com
Cc: quintela@redhat.com, lizhijian@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Jason Wang <jasowang@redhat.com>

Filter needs to process the event of checkpoint/failover or
other event passed by COLO frame.

Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 include/net/filter.h |  5 +++++
 net/filter.c         | 16 ++++++++++++++++
 net/net.c            | 28 ++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/include/net/filter.h b/include/net/filter.h
index 0c4a2ea..df4510d 100644
--- a/include/net/filter.h
+++ b/include/net/filter.h
@@ -37,6 +37,8 @@ typedef ssize_t (FilterReceiveIOV)(NetFilterState *nc,
 
 typedef void (FilterStatusChanged) (NetFilterState *nf, Error **errp);
 
+typedef void (FilterHandleEvent) (NetFilterState *nf, int event, Error **errp);
+
 typedef struct NetFilterClass {
     ObjectClass parent_class;
 
@@ -44,6 +46,7 @@ typedef struct NetFilterClass {
     FilterSetup *setup;
     FilterCleanup *cleanup;
     FilterStatusChanged *status_changed;
+    FilterHandleEvent *handle_event;
     /* mandatory */
     FilterReceiveIOV *receive_iov;
 } NetFilterClass;
@@ -76,4 +79,6 @@ ssize_t qemu_netfilter_pass_to_next(NetClientState *sender,
                                     int iovcnt,
                                     void *opaque);
 
+void colo_notify_filters_event(int event, Error **errp);
+
 #endif /* QEMU_NET_FILTER_H */
diff --git a/net/filter.c b/net/filter.c
index 1dfd2ca..993b35e 100644
--- a/net/filter.c
+++ b/net/filter.c
@@ -17,6 +17,7 @@
 #include "net/vhost_net.h"
 #include "qom/object_interfaces.h"
 #include "qemu/iov.h"
+#include "net/colo.h"
 
 static inline bool qemu_can_skip_netfilter(NetFilterState *nf)
 {
@@ -245,11 +246,26 @@ static void netfilter_finalize(Object *obj)
     g_free(nf->netdev_id);
 }
 
+static void dummy_handle_event(NetFilterState *nf, int event, Error **errp)
+{
+    switch (event) {
+    case COLO_CHECKPOINT:
+        break;
+    case COLO_FAILOVER:
+        object_property_set_str(OBJECT(nf), "off", "status", errp);
+        break;
+    default:
+        break;
+    }
+}
+
 static void netfilter_class_init(ObjectClass *oc, void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
+    NetFilterClass *nfc = NETFILTER_CLASS(oc);
 
     ucc->complete = netfilter_complete;
+    nfc->handle_event = dummy_handle_event;
 }
 
 static const TypeInfo netfilter_info = {
diff --git a/net/net.c b/net/net.c
index 0ac3b9e..1373f63 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1373,6 +1373,34 @@ void hmp_info_network(Monitor *mon, const QDict *qdict)
     }
 }
 
+void colo_notify_filters_event(int event, Error **errp)
+{
+    NetClientState *nc, *peer;
+    NetClientDriver type;
+    NetFilterState *nf;
+    NetFilterClass *nfc = NULL;
+    Error *local_err = NULL;
+
+    QTAILQ_FOREACH(nc, &net_clients, next) {
+        peer = nc->peer;
+        type = nc->info->type;
+        if (!peer || type != NET_CLIENT_DRIVER_NIC) {
+            continue;
+        }
+        QTAILQ_FOREACH(nf, &nc->filters, next) {
+            nfc =  NETFILTER_GET_CLASS(OBJECT(nf));
+            if (!nfc->handle_event) {
+                continue;
+            }
+            nfc->handle_event(nf, event, &local_err);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                return;
+            }
+        }
+    }
+}
+
 void qmp_set_link(const char *name, bool up, Error **errp)
 {
     NetClientState *ncs[MAX_QUEUE_NUM];
-- 
1.8.3.1
