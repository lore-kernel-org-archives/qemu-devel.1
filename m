Received: from eggs.gnu.org ([2001:4830:134:3::10]:41484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cifLz-00007M-Jv
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:50:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cifLw-0004lc-1s
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:49:59 -0500
Received: from [59.151.112.132] (port=36439 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cifLv-0004kD-KA
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:49:55 -0500
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Tue, 28 Feb 2017 18:48:21 +0800
Message-ID: <1488278902-11223-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1488278902-11223-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1488278902-11223-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/3] COLO-compare: Add Xen notify chardev
 socket handler frame
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

Add chardev handler to get Xen colo-frame's notify.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo-compare.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 57d336b..947a9e2 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -72,8 +72,10 @@ typedef struct CompareState {
     CharBackend chr_pri_in;
     CharBackend chr_sec_in;
     CharBackend chr_out;
+    CharBackend chr_notify_dev;
     SocketReadState pri_rs;
     SocketReadState sec_rs;
+    SocketReadState notify_rs;
 
     /* connection list: the connections belonged to this NIC could be found
      * in this list.
@@ -513,6 +515,19 @@ static gboolean check_old_packet_regular(void *opaque)
     return TRUE;
 }
 
+static void compare_notify_chr(void *opaque, const uint8_t *buf, int size)
+{
+    CompareState *s = COLO_COMPARE(opaque);
+    int ret;
+
+    ret = net_fill_rstate(&s->notify_rs, buf, size);
+    if (ret == -1) {
+        qemu_chr_fe_set_handlers(&s->chr_notify_dev, NULL, NULL, NULL,
+                                 NULL, NULL, true);
+        error_report("colo-compare notify_dev error");
+    }
+}
+
 static void *colo_compare_thread(void *opaque)
 {
     CompareState *s = opaque;
@@ -524,6 +539,8 @@ static void *colo_compare_thread(void *opaque)
                           compare_pri_chr_in, NULL, s, s->worker_context, true);
     qemu_chr_fe_set_handlers(&s->chr_sec_in, compare_chr_can_read,
                           compare_sec_chr_in, NULL, s, s->worker_context, true);
+    qemu_chr_fe_set_handlers(&s->chr_notify_dev, compare_chr_can_read,
+                             compare_notify_chr, NULL, s, s->worker_context, true);
 
     s->compare_loop = g_main_loop_new(s->worker_context, FALSE);
 
@@ -626,6 +643,10 @@ static void compare_sec_rs_finalize(SocketReadState *sec_rs)
     }
 }
 
+static void compare_notify_rs_finalize(SocketReadState *notify_rs)
+{
+    /* Get Xen colo-frame's notify and handle the message */
+}
 
 /*
  * Return 0 is success.
@@ -689,8 +710,14 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
         return;
     }
 
+    if (find_and_check_chardev(&chr, s->notify_dev, errp) ||
+        !qemu_chr_fe_init(&s->chr_notify_dev, chr, errp)) {
+        return;
+    }
+
     net_socket_rs_init(&s->pri_rs, compare_pri_rs_finalize);
     net_socket_rs_init(&s->sec_rs, compare_sec_rs_finalize);
+    net_socket_rs_init(&s->notify_rs, compare_notify_rs_finalize);
 
     g_queue_init(&s->conn_list);
 
@@ -757,6 +784,7 @@ static void colo_compare_finalize(Object *obj)
     qemu_chr_fe_set_handlers(&s->chr_sec_in, NULL, NULL, NULL, NULL,
                              s->worker_context, true);
     qemu_chr_fe_deinit(&s->chr_out);
+    qemu_chr_fe_deinit(&s->chr_notify_dev);
 
     g_main_loop_quit(s->compare_loop);
     qemu_thread_join(&s->thread);
-- 
2.7.4
