Received: from eggs.gnu.org ([209.51.188.92]:49812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1goUqN-0006Fb-1m
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:58:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1goUXr-00007e-OV
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:39:29 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 29 Jan 2019 17:37:59 +0300
Message-Id: <20190129143800.88563-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190129143800.88563-1-vsementsov@virtuozzo.com>
References: <20190129143800.88563-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 1/2] block: enhance QEMUIOVector structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, fam@euphon.net, stefanha@redhat.com, vsementsov@virtuozzo.com

Add a possibility of embedded iovec, for cases when we need only one
local iov.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/qemu/iov.h | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/include/qemu/iov.h b/include/qemu/iov.h
index 5f433c7768..f739cff97d 100644
--- a/include/qemu/iov.h
+++ b/include/qemu/iov.h
@@ -134,9 +134,48 @@ typedef struct QEMUIOVector {
     struct iovec *iov;
     int niov;
     int nalloc;
-    size_t size;
+
+    /*
+     * For external @iov (qemu_iovec_init_external()) or allocated @iov
+     * (qemu_iovec_init()) @size is the cumulative size of iovecs and
+     * @local_iov is invalid and unused.
+     *
+     * For embedded @iov (QEMU_IOVEC_INIT_BUF() or qemu_iovec_init_buf()),
+     * @iov is equal to &@local_iov, and @size is valid, as it has same
+     * offset and type as @local_iov.iov_len, which is guaranteed by
+     * static assertions below.
+     */
+    union {
+        struct {
+            void *__unused_iov_base;
+            size_t size;
+        };
+        struct iovec local_iov;
+    };
 } QEMUIOVector;
 
+G_STATIC_ASSERT(offsetof(QEMUIOVector, size) ==
+                offsetof(QEMUIOVector, local_iov.iov_len));
+G_STATIC_ASSERT(sizeof(((QEMUIOVector *)NULL)->size) ==
+                sizeof(((QEMUIOVector *)NULL)->local_iov.iov_len));
+
+#define QEMU_IOVEC_INIT_BUF(self, buf, len) \
+{                                           \
+    .iov = &(self).local_iov,               \
+    .niov = 1,                              \
+    .nalloc = -1,                           \
+    .local_iov = {                          \
+        .iov_base = (void *)(buf),          \
+        .iov_len = len                      \
+    }                                       \
+}
+
+static inline void qemu_iovec_init_buf(QEMUIOVector *qiov,
+                                       void *buf, size_t len)
+{
+    *qiov = (QEMUIOVector) QEMU_IOVEC_INIT_BUF(*qiov, buf, len);
+}
+
 void qemu_iovec_init(QEMUIOVector *qiov, int alloc_hint);
 void qemu_iovec_init_external(QEMUIOVector *qiov, struct iovec *iov, int niov);
 void qemu_iovec_add(QEMUIOVector *qiov, void *base, size_t len);
-- 
2.18.0
