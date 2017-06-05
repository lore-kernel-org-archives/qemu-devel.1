Received: from eggs.gnu.org ([2001:4830:134:3::10]:45932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dHpWN-0003lB-EU
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dHpWK-0003z3-3r
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:46:03 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:60914)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dHpWH-0003uU-UL
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:46:00 -0400
From: Yong Wang <wang.yong155@zte.com.cn>
Date: Mon, 5 Jun 2017 18:44:50 +0800
Message-Id: <1496659493-1105-2-git-send-email-wang.yong155@zte.com.cn>
In-Reply-To: <1496659493-1105-1-git-send-email-wang.yong155@zte.com.cn>
References: <1496659493-1105-1-git-send-email-wang.yong155@zte.com.cn>
Subject: [Qemu-devel] [PATCHv2 01/04] colo-compare: Use IOThread context
 timer to Check old packet regularly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhang.zhanghailiang@huawei.com, jasowang@redhat.com, zhangchen.fnst@cn.fujitsu.com
Cc: lizhijian@cn.fujitsu.com, qemu-devel@nongnu.org, wang.yong155@zte.com.cn, wang.guang55@zte.com.cn

From: Wang Yong <wang.yong155@zte.com.cn>

Remove the task which check old packet in the comparing thread,
then use IOthread context timer to handle it.

Signed-off-by: Wang Yong<wang.yong155@zte.com.cn>
Signed-off-by: Wang Guang<wang.guang55@zte.com.cn>
---
 net/colo-compare.c | 62 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 12 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 2639c7f..b0942a4 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -29,6 +29,7 @@
 #include "qemu/sockets.h"
 #include "qapi-visit.h"
 #include "net/colo.h"
+#include "sysemu/iothread.h"
 
 #define TYPE_COLO_COMPARE "colo-compare"
 #define COLO_COMPARE(obj) \
@@ -86,6 +87,12 @@ typedef struct CompareState {
 
     GMainContext *worker_context;
     GMainLoop *compare_loop;
+
+    /*compare iothread*/
+    IOThread *iothread;
+    /*iothread context*/
+    AioContext *ctx;
+    QEMUTimer *packet_check_timer;
 } CompareState;
 
 typedef struct CompareClass {
@@ -570,20 +577,37 @@ static void compare_sec_chr_in(void *opaque, const uint8_t *buf, int size)
  * Check old packet regularly so it can watch for any packets
  * that the secondary hasn't produced equivalents of.
  */
-static gboolean check_old_packet_regular(void *opaque)
+static void check_old_packet_regular(void *opaque)
 {
     CompareState *s = opaque;
 
     /* if have old packet we will notify checkpoint */
     colo_old_packet_check(s);
+    timer_mod(s->packet_check_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
+              REGULAR_PACKET_CHECK_MS);
+}
 
-    return TRUE;
+static void colo_compare_timer_init(CompareState *s)
+{
+    s->packet_check_timer = aio_timer_new(s->ctx, QEMU_CLOCK_VIRTUAL,
+                                        SCALE_MS, check_old_packet_regular,
+                                        s);
+    timer_mod(s->packet_check_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
+              REGULAR_PACKET_CHECK_MS);
+}
+
+static void colo_compare_timer_del(CompareState *s)
+{
+    if (s->packet_check_timer) {
+        timer_del(s->packet_check_timer);
+        timer_free(s->packet_check_timer);
+        s->packet_check_timer = NULL;
+    }
 }
 
 static void *colo_compare_thread(void *opaque)
 {
     CompareState *s = opaque;
-    GSource *timeout_source;
 
     s->worker_context = g_main_context_new();
 
@@ -594,20 +618,21 @@ static void *colo_compare_thread(void *opaque)
 
     s->compare_loop = g_main_loop_new(s->worker_context, FALSE);
 
-    /* To kick any packets that the secondary doesn't match */
-    timeout_source = g_timeout_source_new(REGULAR_PACKET_CHECK_MS);
-    g_source_set_callback(timeout_source,
-                          (GSourceFunc)check_old_packet_regular, s, NULL);
-    g_source_attach(timeout_source, s->worker_context);
-
     g_main_loop_run(s->compare_loop);
 
-    g_source_unref(timeout_source);
     g_main_loop_unref(s->compare_loop);
     g_main_context_unref(s->worker_context);
     return NULL;
 }
 
+static void colo_compare_iothread(CompareState *s)
+{
+    object_ref(OBJECT(s->iothread));
+    s->ctx = iothread_get_aio_context(s->iothread);
+
+    colo_compare_timer_init(s);
+}
+
 static char *compare_get_pri_indev(Object *obj, Error **errp)
 {
     CompareState *s = COLO_COMPARE(obj);
@@ -714,9 +739,9 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
     char thread_name[64];
     static int compare_id;
 
-    if (!s->pri_indev || !s->sec_indev || !s->outdev) {
+    if (!s->pri_indev || !s->sec_indev || !s->outdev || !s->iothread) {
         error_setg(errp, "colo compare needs 'primary_in' ,"
-                   "'secondary_in','outdev' property set");
+                   "'secondary_in','outdev','iothread' property set");
         return;
     } else if (!strcmp(s->pri_indev, s->outdev) ||
                !strcmp(s->sec_indev, s->outdev) ||
@@ -757,6 +782,8 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
                        QEMU_THREAD_JOINABLE);
     compare_id++;
 
+    colo_compare_iothread(s);
+
     return;
 }
 
@@ -786,6 +813,8 @@ static void colo_compare_class_init(ObjectClass *oc, void *data)
 
 static void colo_compare_init(Object *obj)
 {
+    CompareState *s = COLO_COMPARE(obj);
+
     object_property_add_str(obj, "primary_in",
                             compare_get_pri_indev, compare_set_pri_indev,
                             NULL);
@@ -795,6 +824,10 @@ static void colo_compare_init(Object *obj)
     object_property_add_str(obj, "outdev",
                             compare_get_outdev, compare_set_outdev,
                             NULL);
+    object_property_add_link(obj, "iothread", TYPE_IOTHREAD,
+                            (Object **)&s->iothread,
+                            object_property_allow_set_link,
+                            OBJ_PROP_LINK_UNREF_ON_RELEASE, NULL);
 }
 
 static void colo_compare_finalize(Object *obj)
@@ -806,6 +839,7 @@ static void colo_compare_finalize(Object *obj)
     qemu_chr_fe_set_handlers(&s->chr_sec_in, NULL, NULL, NULL, NULL,
                              s->worker_context, true);
     qemu_chr_fe_deinit(&s->chr_out);
+    colo_compare_timer_del(s);
 
     g_main_loop_quit(s->compare_loop);
     qemu_thread_join(&s->thread);
@@ -816,6 +850,10 @@ static void colo_compare_finalize(Object *obj)
     g_queue_clear(&s->conn_list);
 
     g_hash_table_destroy(s->connection_track_table);
+
+    if (s->iothread) {
+        object_unref(OBJECT(s->iothread));
+    }
     g_free(s->pri_indev);
     g_free(s->sec_indev);
     g_free(s->outdev);
-- 
1.8.3.1
