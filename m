Received: from eggs.gnu.org ([2001:4830:134:3::10]:48288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fob0V-0005Rw-NW
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 17:01:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fob0S-0001ap-Ma
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 17:01:07 -0400
Received: from mail-pl0-x234.google.com ([2607:f8b0:400e:c01::234]:40187)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fob0S-0001aY-GL
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 17:01:04 -0400
Received: by mail-pl0-x234.google.com with SMTP id s17-v6so5377864plp.7
	for <qemu-devel@nongnu.org>; Sat, 11 Aug 2018 14:01:04 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
Date: Sun, 12 Aug 2018 04:59:20 +0800
Message-Id: <20180811205924.4113-17-zhangckid@gmail.com>
In-Reply-To: <20180811205924.4113-1-zhangckid@gmail.com>
References: <20180811205924.4113-1-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V11 16/20] filter: Add handle_event method for
 NetFilterClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

Filter needs to process the event of checkpoint/failover or
other event passed by COLO frame.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 include/net/filter.h |  5 +++++
 net/filter.c         | 17 +++++++++++++++++
 net/net.c            | 28 ++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/include/net/filter.h b/include/net/filter.h
index 435acd6f82..49da666ac0 100644
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
index 2fd7d7d663..0f17eba143 100644
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
index a77ea88fff..b4f6a2efb2 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1331,6 +1331,34 @@ void hmp_info_network(Monitor *mon, const QDict *qdict)
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
2.17.GIT
