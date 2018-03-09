Received: from eggs.gnu.org ([2001:4830:134:3::10]:45403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1euHwU-00019F-5s
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:20:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1euHwT-0007Vt-7a
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:20:14 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  9 Mar 2018 13:19:46 +0000
Message-Id: <20180309131949.18640-5-stefanha@redhat.com>
In-Reply-To: <20180309131949.18640-1-stefanha@redhat.com>
References: <20180309131949.18640-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 4/7] block: add aio_wait_bh_oneshot()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>, Richard Henderson <rth@twiddle.net>

Sometimes it's necessary for the main loop thread to run a BH in an
IOThread and wait for its completion.  This primitive is useful during
startup/shutdown to synchronize and avoid race conditions.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20180307144205.20619-2-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/aio-wait.h | 13 +++++++++++++
 util/aio-wait.c          | 31 +++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/block/aio-wait.h b/include/block/aio-wait.h
index a48c744fa8..f7a3972200 100644
--- a/include/block/aio-wait.h
+++ b/include/block/aio-wait.h
@@ -113,4 +113,17 @@ typedef struct {
  */
 void aio_wait_kick(AioWait *wait);
 
+/**
+ * aio_wait_bh_oneshot:
+ * @ctx: the aio context
+ * @cb: the BH callback function
+ * @opaque: user data for the BH callback function
+ *
+ * Run a BH in @ctx and wait for it to complete.
+ *
+ * Must be called from the main loop thread with @ctx acquired exactly once.
+ * Note that main loop event processing may occur.
+ */
+void aio_wait_bh_oneshot(AioContext *ctx, QEMUBHFunc *cb, void *opaque);
+
 #endif /* QEMU_AIO_WAIT */
diff --git a/util/aio-wait.c b/util/aio-wait.c
index a487cdb852..975afddf4c 100644
--- a/util/aio-wait.c
+++ b/util/aio-wait.c
@@ -38,3 +38,34 @@ void aio_wait_kick(AioWait *wait)
         aio_bh_schedule_oneshot(qemu_get_aio_context(), dummy_bh_cb, NULL);
     }
 }
+
+typedef struct {
+    AioWait wait;
+    bool done;
+    QEMUBHFunc *cb;
+    void *opaque;
+} AioWaitBHData;
+
+/* Context: BH in IOThread */
+static void aio_wait_bh(void *opaque)
+{
+    AioWaitBHData *data = opaque;
+
+    data->cb(data->opaque);
+
+    data->done = true;
+    aio_wait_kick(&data->wait);
+}
+
+void aio_wait_bh_oneshot(AioContext *ctx, QEMUBHFunc *cb, void *opaque)
+{
+    AioWaitBHData data = {
+        .cb = cb,
+        .opaque = opaque,
+    };
+
+    assert(qemu_get_current_aio_context() == qemu_get_aio_context());
+
+    aio_bh_schedule_oneshot(ctx, aio_wait_bh, &data);
+    AIO_WAIT_WHILE(&data.wait, ctx, !data.done);
+}
-- 
2.14.3
