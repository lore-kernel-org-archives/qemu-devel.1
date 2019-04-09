Received: from eggs.gnu.org ([209.51.188.92]:43918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDprU-0002ZX-6P
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 08:28:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDprT-00056Q-6F
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 08:28:24 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  9 Apr 2019 14:28:23 +0200
Message-Id: <20190409122823.12416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 for-4.0?] aio-posix: ensure poll mode is
 left when aio_notify is called
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Sergio Lopez <slp@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

With aio=thread, adaptive polling makes latency worse rather than
better, because it delays the execution of the ThreadPool's
completion bottom half.

event_notifier_poll() does run while polling, detecting that
a bottom half was scheduled by a worker thread, but because
ctx->notifier is explicitly ignored in run_poll_handlers_once(),
scheduling the BH does not count as making progress and
run_poll_handlers() keeps running.  Fix this by recomputing
the deadline after *timeout could have changed.

With this change, ThreadPool still cannot participate in polling
but at least it does not suffer from extra latency.

Reported-by: Sergio Lopez <slp@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1553692145-86728-1-git-send-email-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
        v1->v2: use qemu_soonest_timeout to handle timeout == -1
 util/aio-posix.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 6fbfa7924f..db11021287 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -519,6 +519,10 @@ static bool run_poll_handlers_once(AioContext *ctx, int64_t *timeout)
         if (!node->deleted && node->io_poll &&
             aio_node_check(ctx, node->is_external) &&
             node->io_poll(node->opaque)) {
+            /*
+             * Polling was successful, exit try_poll_mode immediately
+             * to adjust the next polling time.
+             */
             *timeout = 0;
             if (node->opaque != &ctx->notifier) {
                 progress = true;
@@ -558,8 +562,9 @@ static bool run_poll_handlers(AioContext *ctx, int64_t max_ns, int64_t *timeout)
     do {
         progress = run_poll_handlers_once(ctx, timeout);
         elapsed_time = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - start_time;
-    } while (!progress && elapsed_time < max_ns
-             && !atomic_read(&ctx->poll_disable_cnt));
+        max_ns = qemu_soonest_timeout(*timeout, max_ns);
+        assert(!(max_ns && progress));
+    } while (elapsed_time < max_ns && !atomic_read(&ctx->poll_disable_cnt));
 
     /* If time has passed with no successful polling, adjust *timeout to
      * keep the same ending time.
@@ -585,8 +590,7 @@ static bool run_poll_handlers(AioContext *ctx, int64_t max_ns, int64_t *timeout)
  */
 static bool try_poll_mode(AioContext *ctx, int64_t *timeout)
 {
-    /* See qemu_soonest_timeout() uint64_t hack */
-    int64_t max_ns = MIN((uint64_t)*timeout, (uint64_t)ctx->poll_ns);
+    int64_t max_ns = qemu_soonest_timeout(*timeout, ctx->poll_ns);
 
     if (max_ns && !atomic_read(&ctx->poll_disable_cnt)) {
         poll_set_started(ctx, true);
-- 
2.21.0
