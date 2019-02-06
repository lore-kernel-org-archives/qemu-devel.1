Received: from eggs.gnu.org ([209.51.188.92]:48345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grQSL-00010I-97
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:53:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grQSK-00027r-8O
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:53:49 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed,  6 Feb 2019 19:53:41 +0300
Message-Id: <20190206165342.219192-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190206165342.219192-1-vsementsov@virtuozzo.com>
References: <20190206165342.219192-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 1/2] block: enhance QEMUIOVector structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, fam@euphon.net, stefanha@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com

Add a possibility of embedded iovec, for cases when we need only one
local iov.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/qemu/iov.h | 47 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/include/qemu/iov.h b/include/qemu/iov.h
index 5f433c7768..3753b63558 100644
--- a/include/qemu/iov.h
+++ b/include/qemu/iov.h
@@ -133,10 +133,53 @@ size_t iov_discard_back(struct iovec *iov, unsigned int *iov_cnt,
 typedef struct QEMUIOVector {
     struct iovec *iov;
     int niov;
-    int nalloc;
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
+     *
+     * @nalloc is valid always and is -1 both for embedded and external
+     * cases. It included into union only to make appropriate padding for
+     * @size field avoiding creation of 0-length array in the worst case.
+     */
+    union {
+        struct {
+            int nalloc;
+            struct iovec local_iov;
+        };
+        struct {
+            char __pad[sizeof(int) + offsetof(struct iovec, iov_len)];
+            size_t size;
+        };
+    };
 } QEMUIOVector;
 
+QEMU_BUILD_BUG_ON(offsetof(QEMUIOVector, size) !=
+                  offsetof(QEMUIOVector, local_iov.iov_len));
+
+#define QEMU_IOVEC_INIT_BUF(self, buf, len)              \
+{                                                        \
+    .iov = &(self).local_iov,                            \
+    .niov = 1,                                           \
+    .nalloc = -1,                                        \
+    .local_iov = {                                       \
+        .iov_base = (void *)(buf), /* cast away const */ \
+        .iov_len = (len),                                \
+    },                                                   \
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
