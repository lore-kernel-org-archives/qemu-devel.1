Received: from eggs.gnu.org ([2001:4830:134:3::10]:38092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cdv3C-0008F4-Ve
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 03:35:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cdv38-0007a8-7u
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 03:34:59 -0500
Received: from szxga01-in.huawei.com ([58.251.152.64]:38294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cdv37-0007Wz-Fn
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 03:34:54 -0500
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Wed, 15 Feb 2017 16:34:17 +0800
Message-ID: <1487147657-166092-6-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1487147657-166092-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1487147657-166092-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 5/5] colo-compare: Fix removing fds been
 watched incorrectly in finalization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com, zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com
Cc: qemu-devel@nongnu.org, xuquan8@huawei.com, pss.wulizhen@huawei.com, zhanghailiang <zhang.zhanghailiang@huawei.com>

We will catch the bellow error report while try to delete compare object
by qmp command:
chardev/char-io.c:91: io_watch_poll_finalize: Assertion `iwp->src == ((void *)0)' failed.

This is caused by failing to remove the right fd been watched while
call qemu_chr_fe_set_handlers();

Fix it by pass the worker_context parameter to qemu_chr_fe_set_handlers().

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 net/colo-compare.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 809bad3..4c74b02 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -84,6 +84,7 @@ typedef struct CompareState {
     /* compare thread, a thread for each NIC */
     QemuThread thread;
 
+    GMainContext *worker_context;
     GMainLoop *compare_loop;
 } CompareState;
 
@@ -497,30 +498,29 @@ static gboolean check_old_packet_regular(void *opaque)
 
 static void *colo_compare_thread(void *opaque)
 {
-    GMainContext *worker_context;
     CompareState *s = opaque;
     GSource *timeout_source;
 
-    worker_context = g_main_context_new();
+    s->worker_context = g_main_context_new();
 
     qemu_chr_fe_set_handlers(&s->chr_pri_in, compare_chr_can_read,
-                             compare_pri_chr_in, NULL, s, worker_context, true);
+                          compare_pri_chr_in, NULL, s, s->worker_context, true);
     qemu_chr_fe_set_handlers(&s->chr_sec_in, compare_chr_can_read,
-                             compare_sec_chr_in, NULL, s, worker_context, true);
+                          compare_sec_chr_in, NULL, s, s->worker_context, true);
 
-    s->compare_loop = g_main_loop_new(worker_context, FALSE);
+    s->compare_loop = g_main_loop_new(s->worker_context, FALSE);
 
     /* To kick any packets that the secondary doesn't match */
     timeout_source = g_timeout_source_new(REGULAR_PACKET_CHECK_MS);
     g_source_set_callback(timeout_source,
                           (GSourceFunc)check_old_packet_regular, s, NULL);
-    g_source_attach(timeout_source, worker_context);
+    g_source_attach(timeout_source, s->worker_context);
 
     g_main_loop_run(s->compare_loop);
 
     g_source_unref(timeout_source);
     g_main_loop_unref(s->compare_loop);
-    g_main_context_unref(worker_context);
+    g_main_context_unref(s->worker_context);
     return NULL;
 }
 
@@ -717,8 +717,10 @@ static void colo_compare_finalize(Object *obj)
 {
     CompareState *s = COLO_COMPARE(obj);
 
-    qemu_chr_fe_deinit(&s->chr_pri_in);
-    qemu_chr_fe_deinit(&s->chr_sec_in);
+    qemu_chr_fe_set_handlers(&s->chr_pri_in, NULL, NULL, NULL, NULL,
+                             s->worker_context, true);
+    qemu_chr_fe_set_handlers(&s->chr_sec_in, NULL, NULL, NULL, NULL,
+                             s->worker_context, true);
     qemu_chr_fe_deinit(&s->chr_out);
 
     g_main_loop_quit(s->compare_loop);
-- 
1.8.3.1
