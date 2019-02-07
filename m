Received: from eggs.gnu.org ([209.51.188.92]:37037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grgru-0002z6-Ko
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:25:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grgrt-00025M-O3
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:25:18 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  7 Feb 2019 13:24:29 +0300
Message-Id: <20190207102445.71998-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190207102445.71998-1-vsementsov@virtuozzo.com>
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 01/17] block: enhance QEMUIOVector structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, jsnow@redhat.com, den@openvz.org, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, vsementsov@virtuozzo.com

Add a possibility of embedded iovec, for cases when we need only one
local iov.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/qemu/iov.h | 64 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/include/qemu/iov.h b/include/qemu/iov.h
index 5f433c7768..034b9ae080 100644
--- a/include/qemu/iov.h
+++ b/include/qemu/iov.h
@@ -133,10 +133,70 @@ size_t iov_discard_back(struct iovec *iov, unsigned int *iov_cnt,
 typedef struct QEMUIOVector {
     struct iovec *iov;
     int niov;
-    int nalloc;
-    size_t size;
+
+    /*
+     * For external @iov (qemu_iovec_init_external()) or allocated @iov
+     * (qemu_iovec_init()), @size is the cumulative size of iovecs and
+     * @local_iov is invalid and unused.
+     *
+     * For embedded @iov (QEMU_IOVEC_INIT_BUF() or qemu_iovec_init_buf()),
+     * @iov is equal to &@local_iov, and @size is valid, as it has same
+     * offset and type as @local_iov.iov_len, which is guaranteed by
+     * static assertion below.
+     *
+     * @nalloc is always valid and is -1 both for embedded and external
+     * cases. It is included in the union only to ensure the padding prior
+     * to the @size field will not result in a 0-length array.
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
+/*
+ * qemu_iovec_init_buf
+ *
+ * Initialize embedded QEMUIOVector.
+ *
+ * Note: "const" is used over @buf pointer to make it simple to pass
+ * const pointers, appearing in read functions. Then this "const" is
+ * casted away by QEMU_IOVEC_INIT_BUF().
+ */
+static inline void qemu_iovec_init_buf(QEMUIOVector *qiov,
+                                       const void *buf, size_t len)
+{
+    *qiov = (QEMUIOVector) QEMU_IOVEC_INIT_BUF(*qiov, buf, len);
+}
+
+static inline void *qemu_iovec_get_buf(QEMUIOVector *qiov)
+{
+    /* Only supports embedded iov */
+    assert(qiov->niov == -1 && qiov->iov == &(qiov->local_iov));
+
+    return qiov->local_iov.iov_base;
+}
+
 void qemu_iovec_init(QEMUIOVector *qiov, int alloc_hint);
 void qemu_iovec_init_external(QEMUIOVector *qiov, struct iovec *iov, int niov);
 void qemu_iovec_add(QEMUIOVector *qiov, void *base, size_t len);
-- 
2.18.0
