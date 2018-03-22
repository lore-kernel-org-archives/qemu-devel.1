Received: from eggs.gnu.org ([2001:4830:134:3::10]:59178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ez299-0000Ml-2P
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 11:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ez297-0008Cf-Vn
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 11:28:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 22 Mar 2018 15:28:34 +0000
Message-Id: <20180322152834.12656-4-stefanha@redhat.com>
In-Reply-To: <20180322152834.12656-1-stefanha@redhat.com>
References: <20180322152834.12656-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] coroutine: add test-aio coroutine queue
 chaining test case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

Check that two coroutines can queue each other repeatedly without
hitting stack exhaustion.

Switch to qemu_init_main_loop() in main() because coroutines use
qemu_get_aio_context() - they don't know about test-aio's ctx variable.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/test-aio.c | 65 ++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 13 deletions(-)

diff --git a/tests/test-aio.c b/tests/test-aio.c
index 54e20d6ab1..86fb73b3d5 100644
--- a/tests/test-aio.c
+++ b/tests/test-aio.c
@@ -16,6 +16,8 @@
 #include "qemu/timer.h"
 #include "qemu/sockets.h"
 #include "qemu/error-report.h"
+#include "qemu/coroutine.h"
+#include "qemu/main-loop.h"
 
 static AioContext *ctx;
 
@@ -827,24 +829,59 @@ static void test_source_timer_schedule(void)
     timer_del(&data.timer);
 }
 
+/*
+ * Check that aio_co_enter() can chain many times
+ *
+ * Two coroutines should be able to invoke each other via aio_co_enter() many
+ * times without hitting a limit like stack exhaustion.  In other words, the
+ * calls should be chained instead of nested.
+ */
+
+typedef struct {
+    Coroutine *other;
+    unsigned i;
+    unsigned max;
+} ChainData;
+
+static void coroutine_fn chain(void *opaque)
+{
+    ChainData *data = opaque;
+
+    for (data->i = 0; data->i < data->max; data->i++) {
+        /* Queue up the other coroutine... */
+        aio_co_enter(ctx, data->other);
+
+        /* ...and give control to it */
+        qemu_coroutine_yield();
+    }
+}
+
+static void test_queue_chaining(void)
+{
+    /* This number of iterations hit stack exhaustion in the past: */
+    ChainData data_a = { .max = 25000 };
+    ChainData data_b = { .max = 25000 };
+
+    data_b.other = qemu_coroutine_create(chain, &data_a);
+    data_a.other = qemu_coroutine_create(chain, &data_b);
+
+    qemu_coroutine_enter(data_b.other);
+
+    g_assert_cmpint(data_a.i, ==, data_a.max);
+    g_assert_cmpint(data_b.i, ==, data_b.max - 1);
+
+    /* Allow the second coroutine to terminate */
+    qemu_coroutine_enter(data_a.other);
+
+    g_assert_cmpint(data_b.i, ==, data_b.max);
+}
 
 /* End of tests.  */
 
 int main(int argc, char **argv)
 {
-    Error *local_error = NULL;
-    GSource *src;
-
-    init_clocks(NULL);
-
-    ctx = aio_context_new(&local_error);
-    if (!ctx) {
-        error_reportf_err(local_error, "Failed to create AIO Context: ");
-        exit(1);
-    }
-    src = aio_get_g_source(ctx);
-    g_source_attach(src, NULL);
-    g_source_unref(src);
+    qemu_init_main_loop(&error_fatal);
+    ctx = qemu_get_aio_context();
 
     while (g_main_context_iteration(NULL, false));
 
@@ -864,6 +901,8 @@ int main(int argc, char **argv)
     g_test_add_func("/aio/external-client",         test_aio_external_client);
     g_test_add_func("/aio/timer/schedule",          test_timer_schedule);
 
+    g_test_add_func("/aio/coroutine/queue-chaining", test_queue_chaining);
+
     g_test_add_func("/aio-gsource/flush",                   test_source_flush);
     g_test_add_func("/aio-gsource/bh/schedule",             test_source_bh_schedule);
     g_test_add_func("/aio-gsource/bh/schedule10",           test_source_bh_schedule10);
-- 
2.14.3
