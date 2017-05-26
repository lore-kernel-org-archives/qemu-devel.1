Received: from eggs.gnu.org ([2001:4830:134:3::10]:43776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dEDK2-0006G9-Mg
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:22:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dEDJz-0006Ng-GT
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:22:22 -0400
Received: from [59.151.112.132] (port=52326 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dEDJy-0006Mq-Jl
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:22:19 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Fri, 26 May 2017 19:22:06 +0800
Message-ID: <1495797727-16695-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1495797727-16695-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1495797727-16695-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V2 2/3] COLO-compare: Add remote checkpoint
 notify chardev socket handler frame
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>

Add chardev handler to get remote colo-frame's notify, Xen colo is the first user.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo-compare.c | 41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 6f8c439..c968597 100644
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
@@ -567,6 +569,19 @@ static void compare_sec_chr_in(void *opaque, const uint8_t *buf, int size)
     }
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
 /*
  * Check old packet regularly so it can watch for any packets
  * that the secondary hasn't produced equivalents of.
@@ -589,9 +604,11 @@ static void *colo_compare_thread(void *opaque)
     s->worker_context = g_main_context_new();
 
     qemu_chr_fe_set_handlers(&s->chr_pri_in, compare_chr_can_read,
-                          compare_pri_chr_in, NULL, s, s->worker_context, true);
+                             compare_pri_chr_in, NULL, s, s->worker_context, true);
     qemu_chr_fe_set_handlers(&s->chr_sec_in, compare_chr_can_read,
-                          compare_sec_chr_in, NULL, s, s->worker_context, true);
+                             compare_sec_chr_in, NULL, s, s->worker_context, true);
+    qemu_chr_fe_set_handlers(&s->chr_notify_dev, compare_chr_can_read,
+                             compare_notify_chr, NULL, s, s->worker_context, true);
 
     s->compare_loop = g_main_loop_new(s->worker_context, FALSE);
 
@@ -694,6 +711,10 @@ static void compare_sec_rs_finalize(SocketReadState *sec_rs)
     }
 }
 
+static void compare_notify_rs_finalize(SocketReadState *notify_rs)
+{
+    /* Get remote colo-frame's notify and handle the message */
+}
 
 /*
  * Return 0 is success.
@@ -757,6 +778,15 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
         return;
     }
 
+    /* This parameter is Optional, Remote checkpoint notify need it */
+    if (s->notify_dev) {
+        if (find_and_check_chardev(&chr, s->notify_dev, errp) ||
+            !qemu_chr_fe_init(&s->chr_notify_dev, chr, errp)) {
+            return;
+        }
+        net_socket_rs_init(&s->notify_dev, compare_notify_rs_finalize);
+    }
+
     net_socket_rs_init(&s->pri_rs, compare_pri_rs_finalize);
     net_socket_rs_init(&s->sec_rs, compare_sec_rs_finalize);
 
@@ -825,6 +855,7 @@ static void colo_compare_finalize(Object *obj)
     qemu_chr_fe_set_handlers(&s->chr_sec_in, NULL, NULL, NULL, NULL,
                              s->worker_context, true);
     qemu_chr_fe_deinit(&s->chr_out);
+    qemu_chr_fe_deinit(&s->chr_notify_dev);
 
     g_main_loop_quit(s->compare_loop);
     qemu_thread_join(&s->thread);
@@ -838,7 +869,11 @@ static void colo_compare_finalize(Object *obj)
     g_free(s->pri_indev);
     g_free(s->sec_indev);
     g_free(s->outdev);
-    g_free(s->notify_dev);
+
+    /* This parameter is Optional */
+    if (s->notify_dev) {
+        g_free(s->notify_dev);
+    }
 }
 
 static const TypeInfo colo_compare_info = {
-- 
2.7.4
