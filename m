Received: from eggs.gnu.org ([2001:4830:134:3::10]:54244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d16oi-00041c-Dl
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:47:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d16od-0001En-Pj
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:47:52 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3444
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d16od-000153-5Z
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:47:47 -0400
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Thu, 20 Apr 2017 15:46:53 +0800
Message-ID: <1492674416-9408-2-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1492674416-9408-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1492674416-9408-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/3] colo-compare: serialize compare thread's
 initialization with main thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com, zhangchen.fnst@cn.fujitsu.com
Cc: qemu-devel@nongnu.org, weidong.huang@huawei.com, zhanghailiang <zhang.zhanghailiang@huawei.com>

We call qemu_chr_fe_set_handlers() in colo-compare thread, it is used
to detach watched fd from default main context, so it has chance to
handle the same watched fd with main thread concurrently, which will
trigger an error report:
"qemu-char.c:918: io_watch_poll_finalize: Assertion `iwp->src == ((void *)0)' failed."

Fix it by serializing compare thread's initialization with main thread.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 net/colo-compare.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 54e6d40..a6bf419 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -83,6 +83,7 @@ typedef struct CompareState {
     GHashTable *connection_track_table;
     /* compare thread, a thread for each NIC */
     QemuThread thread;
+    QemuSemaphore thread_ready;
 
     GMainContext *worker_context;
     GMainLoop *compare_loop;
@@ -557,6 +558,8 @@ static void *colo_compare_thread(void *opaque)
                           (GSourceFunc)check_old_packet_regular, s, NULL);
     g_source_attach(timeout_source, s->worker_context);
 
+    qemu_sem_post(&s->thread_ready);
+
     g_main_loop_run(s->compare_loop);
 
     g_source_unref(timeout_source);
@@ -707,12 +710,15 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
                                                       connection_key_equal,
                                                       g_free,
                                                       connection_destroy);
+    qemu_sem_init(&s->thread_ready, 0);
 
     sprintf(thread_name, "colo-compare %d", compare_id);
     qemu_thread_create(&s->thread, thread_name,
                        colo_compare_thread, s,
                        QEMU_THREAD_JOINABLE);
     compare_id++;
+    qemu_sem_wait(&s->thread_ready);
+    qemu_sem_destroy(&s->thread_ready);
 
     return;
 }
-- 
1.8.3.1
