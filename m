Received: from eggs.gnu.org ([2001:4830:134:3::10]:59122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1euvfq-00064K-EG
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 03:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1euvfp-0000Z2-A0
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 03:45:42 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:38484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1euvfp-0000Ym-1H
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 03:45:41 -0400
Received: by mail-pf0-x243.google.com with SMTP id d26so3041790pfn.5
	for <qemu-devel@nongnu.org>; Sat, 10 Mar 2018 23:45:40 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
Date: Sun, 11 Mar 2018 15:44:59 +0800
Message-Id: <1520754314-5969-4-git-send-email-zhangckid@gmail.com>
In-Reply-To: <1520754314-5969-1-git-send-email-zhangckid@gmail.com>
References: <1520754314-5969-1-git-send-email-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V6 02/17] colo-compare: implement the process
 of checkpoint
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

While do checkpoint, we need to flush all the unhandled packets,
By using the filter notifier mechanism, we can easily to notify
every compare object to do this process, which runs inside
of compare threads as a coroutine.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 include/migration/colo.h |  6 ++++
 net/colo-compare.c       | 76 ++++++++++++++++++++++++++++++++++++++++++++++++
 net/colo-compare.h       | 22 ++++++++++++++
 3 files changed, 104 insertions(+)
 create mode 100644 net/colo-compare.h

diff --git a/include/migration/colo.h b/include/migration/colo.h
index 2fe48ad..fefb2fc 100644
--- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -16,6 +16,12 @@
 #include "qemu-common.h"
 #include "qapi/qapi-types-migration.h"
 
+enum colo_event {
+    COLO_EVENT_NONE,
+    COLO_EVENT_CHECKPOINT,
+    COLO_EVENT_FAILOVER,
+};
+
 void colo_info_init(void);
 
 void migrate_start_colo_process(MigrationState *s);
diff --git a/net/colo-compare.c b/net/colo-compare.c
index 23b2d2c..7ff3ae8 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -27,11 +27,16 @@
 #include "qemu/sockets.h"
 #include "net/colo.h"
 #include "sysemu/iothread.h"
+#include "net/colo-compare.h"
+#include "migration/colo.h"
 
 #define TYPE_COLO_COMPARE "colo-compare"
 #define COLO_COMPARE(obj) \
     OBJECT_CHECK(CompareState, (obj), TYPE_COLO_COMPARE)
 
+static QTAILQ_HEAD(, CompareState) net_compares =
+       QTAILQ_HEAD_INITIALIZER(net_compares);
+
 #define COMPARE_READ_LEN_MAX NET_BUFSIZE
 #define MAX_QUEUE_SIZE 1024
 
@@ -41,6 +46,10 @@
 /* TODO: Should be configurable */
 #define REGULAR_PACKET_CHECK_MS 3000
 
+static QemuMutex event_mtx;
+static QemuCond event_complete_cond;
+static int event_unhandled_count;
+
 /*
  *  + CompareState ++
  *  |               |
@@ -87,6 +96,11 @@ typedef struct CompareState {
     IOThread *iothread;
     GMainContext *worker_context;
     QEMUTimer *packet_check_timer;
+
+    QEMUBH *event_bh;
+    enum colo_event event;
+
+    QTAILQ_ENTRY(CompareState) next;
 } CompareState;
 
 typedef struct CompareClass {
@@ -736,6 +750,25 @@ static void check_old_packet_regular(void *opaque)
                 REGULAR_PACKET_CHECK_MS);
 }
 
+/* Public API, Used for COLO frame to notify compare event */
+void colo_notify_compares_event(void *opaque, int event, Error **errp)
+{
+    CompareState *s;
+
+    qemu_mutex_lock(&event_mtx);
+    QTAILQ_FOREACH(s, &net_compares, next) {
+        s->event = event;
+        qemu_bh_schedule(s->event_bh);
+        event_unhandled_count++;
+    }
+    /* Wait all compare threads to finish handling this event */
+    while (event_unhandled_count > 0) {
+        qemu_cond_wait(&event_complete_cond, &event_mtx);
+    }
+
+    qemu_mutex_unlock(&event_mtx);
+}
+
 static void colo_compare_timer_init(CompareState *s)
 {
     AioContext *ctx = iothread_get_aio_context(s->iothread);
@@ -756,6 +789,28 @@ static void colo_compare_timer_del(CompareState *s)
     }
  }
 
+static void colo_flush_packets(void *opaque, void *user_data);
+
+static void colo_compare_handle_event(void *opaque)
+{
+    CompareState *s = opaque;
+
+    switch (s->event) {
+    case COLO_EVENT_CHECKPOINT:
+        g_queue_foreach(&s->conn_list, colo_flush_packets, s);
+        break;
+    case COLO_EVENT_FAILOVER:
+        break;
+    default:
+        break;
+    }
+    qemu_mutex_lock(&event_mtx);
+    assert(event_unhandled_count > 0);
+    event_unhandled_count--;
+    qemu_cond_broadcast(&event_complete_cond);
+    qemu_mutex_unlock(&event_mtx);
+}
+
 static void colo_compare_iothread(CompareState *s)
 {
     object_ref(OBJECT(s->iothread));
@@ -769,6 +824,7 @@ static void colo_compare_iothread(CompareState *s)
                              s, s->worker_context, true);
 
     colo_compare_timer_init(s);
+    s->event_bh = qemu_bh_new(colo_compare_handle_event, s);
 }
 
 static char *compare_get_pri_indev(Object *obj, Error **errp)
@@ -926,8 +982,13 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
     net_socket_rs_init(&s->pri_rs, compare_pri_rs_finalize, s->vnet_hdr);
     net_socket_rs_init(&s->sec_rs, compare_sec_rs_finalize, s->vnet_hdr);
 
+    QTAILQ_INSERT_TAIL(&net_compares, s, next);
+
     g_queue_init(&s->conn_list);
 
+    qemu_mutex_init(&event_mtx);
+    qemu_cond_init(&event_complete_cond);
+
     s->connection_track_table = g_hash_table_new_full(connection_key_hash,
                                                       connection_key_equal,
                                                       g_free,
@@ -990,6 +1051,7 @@ static void colo_compare_init(Object *obj)
 static void colo_compare_finalize(Object *obj)
 {
     CompareState *s = COLO_COMPARE(obj);
+    CompareState *tmp = NULL;
 
     qemu_chr_fe_deinit(&s->chr_pri_in, false);
     qemu_chr_fe_deinit(&s->chr_sec_in, false);
@@ -997,6 +1059,16 @@ static void colo_compare_finalize(Object *obj)
     if (s->iothread) {
         colo_compare_timer_del(s);
     }
+
+    qemu_bh_delete(s->event_bh);
+
+    QTAILQ_FOREACH(tmp, &net_compares, next) {
+        if (!strcmp(tmp->outdev, s->outdev)) {
+            QTAILQ_REMOVE(&net_compares, s, next);
+            break;
+        }
+    }
+
     /* Release all unhandled packets after compare thead exited */
     g_queue_foreach(&s->conn_list, colo_flush_packets, s);
 
@@ -1009,6 +1081,10 @@ static void colo_compare_finalize(Object *obj)
     if (s->iothread) {
         object_unref(OBJECT(s->iothread));
     }
+
+    qemu_mutex_destroy(&event_mtx);
+    qemu_cond_destroy(&event_complete_cond);
+
     g_free(s->pri_indev);
     g_free(s->sec_indev);
     g_free(s->outdev);
diff --git a/net/colo-compare.h b/net/colo-compare.h
new file mode 100644
index 0000000..1b1ce76
--- /dev/null
+++ b/net/colo-compare.h
@@ -0,0 +1,22 @@
+/*
+ * COarse-grain LOck-stepping Virtual Machines for Non-stop Service (COLO)
+ * (a.k.a. Fault Tolerance or Continuous Replication)
+ *
+ * Copyright (c) 2017 HUAWEI TECHNOLOGIES CO., LTD.
+ * Copyright (c) 2017 FUJITSU LIMITED
+ * Copyright (c) 2017 Intel Corporation
+ *
+ * Authors:
+ *    zhanghailiang <zhang.zhanghailiang@huawei.com>
+ *    Zhang Chen <zhangckid@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_COLO_COMPARE_H
+#define QEMU_COLO_COMPARE_H
+
+void colo_notify_compares_event(void *opaque, int event, Error **errp);
+
+#endif /* QEMU_COLO_COMPARE_H */
-- 
2.7.4
