Received: from eggs.gnu.org ([2001:4830:134:3::10]:58412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cklAD-000807-Ks
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cklAB-0001AT-ML
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cklAB-0001AI-Dj
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:27 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Mon,  6 Mar 2017 13:25:45 +0800
Message-Id: <1488777954-4578-11-git-send-email-jasowang@redhat.com>
In-Reply-To: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
References: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL RESEND 10/19] colo-compare: Fix removing fds
 been watched incorrectly in finalization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Jason Wang <jasowang@redhat.com>

From: zhanghailiang <zhang.zhanghailiang@huawei.com>

We will catch the bellow error report while try to delete compare object
by qmp command:
chardev/char-io.c:91: io_watch_poll_finalize: Assertion `iwp->src == ((void *)0)' failed.

This is caused by failing to remove the right fd been watched while
call qemu_chr_fe_set_handlers();

Fix it by pass the worker_context parameter to qemu_chr_fe_set_handlers().

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Reviewed-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/colo-compare.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 37ce75c..a6fc2ff 100644
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
2.7.4
