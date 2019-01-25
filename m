Received: from eggs.gnu.org ([209.51.188.92]:55562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gn4cL-00063l-GU
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 11:46:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gn4cJ-0007Zu-Fn
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 11:46:09 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 25 Jan 2019 19:46:01 +0300
Message-Id: <20190125164601.130556-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [RFC PATCH] block: local qiov helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, fam@euphon.net, stefanha@redhat.com

Hi all.

What about such a simple helper for a very often patter around
qemu_iovec_init_external ?

If we like it, I'll update other callers of qemu_iovec_init_external.

Possible interface change would be
LOCAL_QIOV(lc, buf, len);
instead of 
LocalQiov lc = LOCAL_QIOV(lc, buf, len);

or, may be, someone has a better idea?

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/qemu/iov.h | 19 +++++++++++++++++++
 block/io.c         |  9 ++-------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/qemu/iov.h b/include/qemu/iov.h
index 5f433c7768..e0963d8ebe 100644
--- a/include/qemu/iov.h
+++ b/include/qemu/iov.h
@@ -137,6 +137,25 @@ typedef struct QEMUIOVector {
     size_t size;
 } QEMUIOVector;
 
+typedef struct LocalQiov {
+    QEMUIOVector qiov;
+    struct iovec iov;
+} LocalQiov;
+
+#define LOCAL_QIOV(self, buf, len)    \
+{                                     \
+    .qiov = {                         \
+        .iov = &self.iov,             \
+        .size = len,                  \
+        .niov = 1,                    \
+        .nalloc = -1                  \
+    },                                \
+    .iov = {                          \
+        .iov_base = (void *)(buf),    \
+        .iov_len = len                \
+    }                                 \
+}
+
 void qemu_iovec_init(QEMUIOVector *qiov, int alloc_hint);
 void qemu_iovec_init_external(QEMUIOVector *qiov, struct iovec *iov, int niov);
 void qemu_iovec_add(QEMUIOVector *qiov, void *base, size_t len);
diff --git a/block/io.c b/block/io.c
index bd9d688f8b..c7d7b199c1 100644
--- a/block/io.c
+++ b/block/io.c
@@ -949,18 +949,13 @@ int bdrv_preadv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
 
 int bdrv_pread(BdrvChild *child, int64_t offset, void *buf, int bytes)
 {
-    QEMUIOVector qiov;
-    struct iovec iov = {
-        .iov_base = (void *)buf,
-        .iov_len = bytes,
-    };
+    LocalQiov lq = LOCAL_QIOV(lq, buf, bytes);
 
     if (bytes < 0) {
         return -EINVAL;
     }
 
-    qemu_iovec_init_external(&qiov, &iov, 1);
-    return bdrv_preadv(child, offset, &qiov);
+    return bdrv_preadv(child, offset, &lq.qiov);
 }
 
 int bdrv_pwritev(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
-- 
2.18.0
