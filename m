Received: from eggs.gnu.org ([2001:4830:134:3::10]:58352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cW1lz-00068g-OV
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:08:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cW1lx-0005pB-2B
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:08:35 -0500
Received: from szxga01-in.huawei.com ([58.251.152.64]:24094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cW1lw-0005gQ-AT
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:08:33 -0500
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Tue, 24 Jan 2017 22:05:47 +0800
Message-ID: <1485266748-15340-3-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1485266748-15340-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1485266748-15340-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/3] colo-compare: add API to flush all queued
 packets while do checkpoint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jasowang@redhat.com
Cc: zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>

From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

While COLO does checkpoint, we need to flush all queued packets of
COLO proxy, use a new API to do these things, and export it which
will be used by COLO frame.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 net/colo-compare.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 net/colo-compare.h | 20 ++++++++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100644 net/colo-compare.h

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 9bea62a..2ad577b 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -29,11 +29,15 @@
 #include "qemu/sockets.h"
 #include "qapi-visit.h"
 #include "net/colo.h"
+#include "net/colo-compare.h"
 
 #define TYPE_COLO_COMPARE "colo-compare"
 #define COLO_COMPARE(obj) \
     OBJECT_CHECK(CompareState, (obj), TYPE_COLO_COMPARE)
 
+static QTAILQ_HEAD(, CompareState) net_compares =
+       QTAILQ_HEAD_INITIALIZER(net_compares);
+
 #define COMPARE_READ_LEN_MAX NET_BUFSIZE
 #define MAX_QUEUE_SIZE 1024
 
@@ -88,6 +92,8 @@ typedef struct CompareState {
 
     /* Timer used on the primary to find packets that are never matched */
     QEMUTimer *timer;
+
+    QTAILQ_ENTRY(CompareState) next;
 } CompareState;
 
 typedef struct CompareClass {
@@ -181,6 +187,39 @@ static int packet_enqueue(CompareState *s, int mode)
     return 0;
 }
 
+static void colo_flush_connection(void *opaque, void *user_data)
+{
+    CompareState *s = user_data;
+    Connection *conn = opaque;
+    Packet *pkt = NULL;
+
+    qemu_mutex_lock(&conn->conn_lock);
+    while (!g_queue_is_empty(&conn->primary_list)) {
+        pkt = g_queue_pop_head(&conn->primary_list);
+        compare_chr_send(&s->chr_out, pkt->data, pkt->size);
+        packet_destroy(pkt, NULL);
+    }
+    while (!g_queue_is_empty(&conn->secondary_list)) {
+        pkt = g_queue_pop_head(&conn->secondary_list);
+        packet_destroy(pkt, NULL);
+    }
+    qemu_mutex_unlock(&conn->conn_lock);
+}
+
+/* Fix Me: better to use notifier way */
+void colo_compare_do_checkpoint(void)
+{
+    CompareState *s;
+
+    trace_colo_compare_main("colo_compare_do_checkpoint");
+
+    QTAILQ_FOREACH(s, &net_compares, next) {
+        qemu_mutex_lock(&s->conn_list_lock);
+        g_queue_foreach(&s->conn_list, colo_flush_connection, s);
+        qemu_mutex_unlock(&s->conn_list_lock);
+    }
+}
+
 /*
  * The IP packets sent by primary and secondary
  * will be compared in here
@@ -387,6 +426,11 @@ static void colo_compare_connection(void *opaque, void *user_data)
     while (!g_queue_is_empty(&conn->primary_list) &&
            !g_queue_is_empty(&conn->secondary_list)) {
         pkt = g_queue_pop_tail(&conn->primary_list);
+        if (!pkt) {
+            error_report("colo-compare pop pkt failed");
+            return;
+        }
+
         switch (conn->ip_proto) {
         case IPPROTO_TCP:
             result = g_queue_find_custom(&conn->secondary_list,
@@ -726,6 +770,10 @@ static void colo_compare_finalize(Object *obj)
     qemu_chr_fe_deinit(&s->chr_sec_in);
     qemu_chr_fe_deinit(&s->chr_out);
 
+    if (!QTAILQ_EMPTY(&net_compares)) {
+        QTAILQ_REMOVE(&net_compares, s, next);
+    }
+
     g_queue_free(&s->conn_list);
 
     if (qemu_thread_is_self(&s->thread)) {
diff --git a/net/colo-compare.h b/net/colo-compare.h
new file mode 100644
index 0000000..44f9014
--- /dev/null
+++ b/net/colo-compare.h
@@ -0,0 +1,20 @@
+/*
+ * COarse-grain LOck-stepping Virtual Machines for Non-stop Service (COLO)
+ * (a.k.a. Fault Tolerance or Continuous Replication)
+ *
+ * Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
+ * Copyright (c) 2016 FUJITSU LIMITED
+ * Copyright (c) 2016 Intel Corporation
+ *
+ * Author: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_COLO_COMPARE_H
+#define QEMU_COLO_COMPARE_H
+
+void colo_compare_do_checkpoint(void);
+
+#endif /* QEMU_COLO_COMPARE_H */
-- 
1.8.3.1
