Received: from eggs.gnu.org ([2001:4830:134:3::10]:48634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eulxc-00033b-B0
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 16:23:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eulxb-0003Rf-B5
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 16:23:24 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:45434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1eulxb-0003Ra-5P
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 16:23:23 -0500
Received: by mail-pl0-x244.google.com with SMTP id v9-v6so7151935plp.12
	for <qemu-devel@nongnu.org>; Sat, 10 Mar 2018 13:23:23 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
Date: Sun, 11 Mar 2018 05:22:04 +0800
Message-Id: <1520716927-17068-15-git-send-email-zhangckid@gmail.com>
In-Reply-To: <1520716927-17068-1-git-send-email-zhangckid@gmail.com>
References: <1520716927-17068-1-git-send-email-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V5 14/17] filter: Add handle_event method for
 NetFilterClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

Filter needs to process the event of checkpoint/failover or
other event passed by COLO frame.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 include/net/filter.h |  5 +++++
 net/filter.c         | 17 +++++++++++++++++
 net/net.c            | 28 ++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/include/net/filter.h b/include/net/filter.h
index 435acd6..49da666 100644
--- a/include/net/filter.h
+++ b/include/net/filter.h
@@ -38,6 +38,8 @@ typedef ssize_t (FilterReceiveIOV)(NetFilterState *nc,
 
 typedef void (FilterStatusChanged) (NetFilterState *nf, Error **errp);
 
+typedef void (FilterHandleEvent) (NetFilterState *nf, int event, Error **errp);
+
 typedef struct NetFilterClass {
     ObjectClass parent_class;
 
@@ -45,6 +47,7 @@ typedef struct NetFilterClass {
     FilterSetup *setup;
     FilterCleanup *cleanup;
     FilterStatusChanged *status_changed;
+    FilterHandleEvent *handle_event;
     /* mandatory */
     FilterReceiveIOV *receive_iov;
 } NetFilterClass;
@@ -77,4 +80,6 @@ ssize_t qemu_netfilter_pass_to_next(NetClientState *sender,
                                     int iovcnt,
                                     void *opaque);
 
+void colo_notify_filters_event(int event, Error **errp);
+
 #endif /* QEMU_NET_FILTER_H */
diff --git a/net/filter.c b/net/filter.c
index 2fd7d7d..0f17eba 100644
--- a/net/filter.c
+++ b/net/filter.c
@@ -17,6 +17,8 @@
 #include "net/vhost_net.h"
 #include "qom/object_interfaces.h"
 #include "qemu/iov.h"
+#include "net/colo.h"
+#include "migration/colo.h"
 
 static inline bool qemu_can_skip_netfilter(NetFilterState *nf)
 {
@@ -245,11 +247,26 @@ static void netfilter_finalize(Object *obj)
     g_free(nf->netdev_id);
 }
 
+static void dummy_handle_event(NetFilterState *nf, int event, Error **errp)
+{
+    switch (event) {
+    case COLO_EVENT_CHECKPOINT:
+        break;
+    case COLO_EVENT_FAILOVER:
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
index 5222e45..5bdbd6a 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1336,6 +1336,34 @@ void hmp_info_network(Monitor *mon, const QDict *qdict)
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
+        if (!peer || type != NET_CLIENT_DRIVER_TAP) {
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
2.7.4
