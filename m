Received: from eggs.gnu.org ([2001:4830:134:3::10]:55470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1gWkUh-0008Vk-TZ
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:02:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1gWkUc-0007eG-W7
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:02:47 -0500
From: Olaf Hering <olaf@aepfle.de>
Date: Tue, 11 Dec 2018 17:02:24 +0100
Message-Id: <20181211160224.22181-1-olaf@aepfle.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1] xen_disk: fix memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Olaf Hering <olaf@aepfle.de>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>, "open list:Block layer core" <qemu-block@nongnu.org>

There are some code paths that clobber ioreq->buf, which leads to a huge
memory leak after a few hours of runtime. One code path is
qemu_aio_complete, which might be called recursive. Another one is
ioreq_reset, which might clobber ioreq->buf as well.

Add wrappers to free ioreq->buf before reassignment.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 hw/block/xen_disk.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
index 36eff94f84..e15eefe625 100644
--- a/hw/block/xen_disk.c
+++ b/hw/block/xen_disk.c
@@ -103,12 +103,24 @@ struct XenBlkDev {
 
 /* ------------------------------------------------------------- */
 
+static void ioreq_buf_alloc(struct ioreq *ioreq, size_t alignment)
+{
+    if (ioreq->buf)
+        qemu_vfree(ioreq->buf);
+    ioreq->buf = qemu_memalign(XC_PAGE_SIZE, ioreq->size);
+}
+static void ioreq_buf_free(struct ioreq *ioreq)
+{
+    if (ioreq->buf)
+        qemu_vfree(ioreq->buf);
+    ioreq->buf = NULL;
+}
 static void ioreq_reset(struct ioreq *ioreq)
 {
+    ioreq_buf_free(ioreq);
     memset(&ioreq->req, 0, sizeof(ioreq->req));
     ioreq->status = 0;
     ioreq->start = 0;
-    ioreq->buf = NULL;
     ioreq->size = 0;
     ioreq->presync = 0;
 
@@ -315,14 +327,14 @@ static void qemu_aio_complete(void *opaque, int ret)
         if (ret == 0) {
             ioreq_grant_copy(ioreq);
         }
-        qemu_vfree(ioreq->buf);
+        ioreq_buf_free(ioreq);
         break;
     case BLKIF_OP_WRITE:
     case BLKIF_OP_FLUSH_DISKCACHE:
         if (!ioreq->req.nr_segments) {
             break;
         }
-        qemu_vfree(ioreq->buf);
+        ioreq_buf_free(ioreq);
         break;
     default:
         break;
@@ -390,12 +402,12 @@ static int ioreq_runio_qemu_aio(struct ioreq *ioreq)
 {
     struct XenBlkDev *blkdev = ioreq->blkdev;
 
-    ioreq->buf = qemu_memalign(XC_PAGE_SIZE, ioreq->size);
+    ioreq_buf_alloc(ioreq, XC_PAGE_SIZE);
     if (ioreq->req.nr_segments &&
         (ioreq->req.operation == BLKIF_OP_WRITE ||
          ioreq->req.operation == BLKIF_OP_FLUSH_DISKCACHE) &&
         ioreq_grant_copy(ioreq)) {
-        qemu_vfree(ioreq->buf);
+        ioreq_buf_free(ioreq);
         goto err;
     }
 
