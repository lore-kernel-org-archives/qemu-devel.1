Received: from eggs.gnu.org ([2001:4830:134:3::10]:36715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eWyb9-0003U2-6v
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eWyb7-0003vt-TU
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:01:51 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:41969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1eWyb7-0003vV-LV
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:01:49 -0500
Received: by mail-pg0-x242.google.com with SMTP id 77so337307pgd.8
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 22:01:49 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu,  4 Jan 2018 14:01:01 +0800
Message-Id: <1515045675-6993-3-git-send-email-zhangckid@gmail.com>
In-Reply-To: <1515045675-6993-1-git-send-email-zhangckid@gmail.com>
References: <1515045675-6993-1-git-send-email-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH RESEND V3 02/16] colo-compare: implement the
 process of checkpoint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>
Cc: Zhang Chen <zhangckid@gmail.com>, Jason Wang <jasowang@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>

While do checkpoint, we need to flush all the unhandled packets,
By using the filter notifier mechanism, we can easily to notify
every compare object to do this process, which runs inside
of compare threads as a coroutine.

Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 include/migration/colo.h |  6 ++++
 net/colo-compare.c       | 71 ++++++++++++++++++++++++++++++++++++++++++++++++
 net/colo-compare.h       | 22 +++++++++++++++
 3 files changed, 99 insertions(+)
 create mode 100644 net/colo-compare.h

diff --git a/include/migration/colo.h b/include/migration/colo.h
index ff9874e..6adf3a5 100644
--- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -15,6 +15,12 @@
 
 #include "qemu-common.h"
 
+enum colo_event {
+    COLO_EVENT_NONE,
+    COLO_EVENT_CHECKPOINT,
+    COLO_EVENT_FAILOVER,
+};
+
 void colo_info_init(void);
 
 void migrate_start_colo_process(MigrationState *s);
diff --git a/net/colo-compare.c b/net/colo-compare.c
index 0ebdec9..e9cfca2 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -29,17 +29,28 @@
 #include "qapi-visit.h"
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
 
 /* TODO: Should be configurable */
 #define REGULAR_PACKET_CHECK_MS 3000
 
+static QemuMutex event_mtx = { .lock = PTHREAD_MUTEX_INITIALIZER,
+                               .initialized = true };
+static QemuCond event_complete_cond = { .cond = PTHREAD_COND_INITIALIZER,
+                                        .initialized = true};
+static int event_unhandled_count;
+
 /*
  *  + CompareState ++
  *  |               |
@@ -86,6 +97,11 @@ typedef struct CompareState {
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
@@ -631,6 +647,25 @@ static void check_old_packet_regular(void *opaque)
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
@@ -651,6 +686,28 @@ static void colo_compare_timer_del(CompareState *s)
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
@@ -664,6 +721,7 @@ static void colo_compare_iothread(CompareState *s)
                              s, s->worker_context, true);
 
     colo_compare_timer_init(s);
+    s->event_bh = qemu_bh_new(colo_compare_handle_event, s);
 }
 
 static char *compare_get_pri_indev(Object *obj, Error **errp)
@@ -821,6 +879,8 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
     net_socket_rs_init(&s->pri_rs, compare_pri_rs_finalize, s->vnet_hdr);
     net_socket_rs_init(&s->sec_rs, compare_sec_rs_finalize, s->vnet_hdr);
 
+    QTAILQ_INSERT_TAIL(&net_compares, s, next);
+
     g_queue_init(&s->conn_list);
 
     s->connection_track_table = g_hash_table_new_full(connection_key_hash,
@@ -885,6 +945,7 @@ static void colo_compare_init(Object *obj)
 static void colo_compare_finalize(Object *obj)
 {
     CompareState *s = COLO_COMPARE(obj);
+    CompareState *tmp = NULL;
 
     qemu_chr_fe_deinit(&s->chr_pri_in, false);
     qemu_chr_fe_deinit(&s->chr_sec_in, false);
@@ -892,6 +953,16 @@ static void colo_compare_finalize(Object *obj)
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
