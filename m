Received: from eggs.gnu.org ([209.51.188.92]:37930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBV8-0002EI-Rg
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:08:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBV6-0001kL-3e
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:08:29 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 22 Feb 2019 14:07:30 +0000
Message-Id: <20190222140756.29834-2-stefanha@redhat.com>
In-Reply-To: <20190222140756.29834-1-stefanha@redhat.com>
References: <20190222140756.29834-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/27] block: enhance QEMUIOVector structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Add a possibility of embedded iovec, for cases when we need only one
local iov.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20190218140926.333779-2-vsementsov@virtuozzo.com
Message-Id: <20190218140926.333779-2-vsementsov@virtuozzo.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/qemu/iov.h | 64 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/include/qemu/iov.h b/include/qemu/iov.h
index 5f433c7768..48b45987b7 100644
--- a/include/qemu/iov.h
+++ b/include/qemu/iov.h
@@ -133,10 +133,70 @@ size_t iov_discard_back(struct iovec *iov, unsigned=
 int *iov_cnt,
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
+     * For embedded @iov (QEMU_IOVEC_INIT_BUF() or qemu_iovec_init_buf()=
),
+     * @iov is equal to &@local_iov, and @size is valid, as it has same
+     * offset and type as @local_iov.iov_len, which is guaranteed by
+     * static assertion below.
+     *
+     * @nalloc is always valid and is -1 both for embedded and external
+     * cases. It is included in the union only to ensure the padding pri=
or
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
=20
+QEMU_BUILD_BUG_ON(offsetof(QEMUIOVector, size) !=3D
+                  offsetof(QEMUIOVector, local_iov.iov_len));
+
+#define QEMU_IOVEC_INIT_BUF(self, buf, len)              \
+{                                                        \
+    .iov =3D &(self).local_iov,                            \
+    .niov =3D 1,                                           \
+    .nalloc =3D -1,                                        \
+    .local_iov =3D {                                       \
+        .iov_base =3D (void *)(buf), /* cast away const */ \
+        .iov_len =3D (len),                                \
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
+ * cast away by QEMU_IOVEC_INIT_BUF().
+ */
+static inline void qemu_iovec_init_buf(QEMUIOVector *qiov,
+                                       const void *buf, size_t len)
+{
+    *qiov =3D (QEMUIOVector) QEMU_IOVEC_INIT_BUF(*qiov, buf, len);
+}
+
+static inline void *qemu_iovec_buf(QEMUIOVector *qiov)
+{
+    /* Only supports embedded iov */
+    assert(qiov->nalloc =3D=3D -1 && qiov->iov =3D=3D &qiov->local_iov);
+
+    return qiov->local_iov.iov_base;
+}
+
 void qemu_iovec_init(QEMUIOVector *qiov, int alloc_hint);
 void qemu_iovec_init_external(QEMUIOVector *qiov, struct iovec *iov, int=
 niov);
 void qemu_iovec_add(QEMUIOVector *qiov, void *base, size_t len);
--=20
2.20.1
