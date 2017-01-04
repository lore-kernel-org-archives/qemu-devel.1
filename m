Received: from eggs.gnu.org ([2001:4830:134:3::10]:57670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cOgpx-0006xx-2Q
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cOgpt-00007t-U1
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43907)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cOgpt-00007I-K2
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:17 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v048J5gx089316
	for <qemu-devel@nongnu.org>; Wed, 4 Jan 2017 03:22:16 -0500
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27rmq81w55-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 03:22:16 -0500
Received: from localhost
	by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Wed, 4 Jan 2017 08:22:13 -0000
From: Greg Kurz <groug@kaod.org>
Date: Wed,  4 Jan 2017 09:21:37 +0100
In-Reply-To: <1483518107-13218-1-git-send-email-groug@kaod.org>
References: <1483518107-13218-1-git-send-email-groug@kaod.org>
Message-Id: <1483518107-13218-4-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 03/13] 9pfs: call v9fs_init_qiov_from_pdu before
 v9fs_pack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, Stefano Stabellini <sstabellini@kernel.org>

From: Stefano Stabellini <sstabellini@kernel.org>

v9fs_xattr_read should not access VirtQueueElement elems directly.
Move v9fs_init_qiov_from_pdu up in the file and call
v9fs_init_qiov_from_pdu before v9fs_pack. Use v9fs_pack on the new
iovec.

Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c | 59 ++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 3f5647aa5680..f9acd632596f 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1633,14 +1633,39 @@ out_nofid:
     pdu_complete(pdu, err);
 }
 
+/*
+ * Create a QEMUIOVector for a sub-region of PDU iovecs
+ *
+ * @qiov:       uninitialized QEMUIOVector
+ * @skip:       number of bytes to skip from beginning of PDU
+ * @size:       number of bytes to include
+ * @is_write:   true - write, false - read
+ *
+ * The resulting QEMUIOVector has heap-allocated iovecs and must be cleaned up
+ * with qemu_iovec_destroy().
+ */
+static void v9fs_init_qiov_from_pdu(QEMUIOVector *qiov, V9fsPDU *pdu,
+                                    size_t skip, size_t size,
+                                    bool is_write)
+{
+    QEMUIOVector elem;
+    struct iovec *iov;
+    unsigned int niov;
+
+    pdu->s->transport->init_iov_from_pdu(pdu, &iov, &niov, is_write);
+
+    qemu_iovec_init_external(&elem, iov, niov);
+    qemu_iovec_init(qiov, niov);
+    qemu_iovec_concat(qiov, &elem, skip, size);
+}
+
 static int v9fs_xattr_read(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fidp,
                            uint64_t off, uint32_t max_count)
 {
     ssize_t err;
     size_t offset = 7;
     uint64_t read_count;
-    V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
-    VirtQueueElement *elem = v->elems[pdu->idx];
+    QEMUIOVector qiov_full;
 
     if (fidp->fs.xattr.len < off) {
         read_count = 0;
@@ -1656,9 +1681,11 @@ static int v9fs_xattr_read(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fidp,
     }
     offset += err;
 
-    err = v9fs_pack(elem->in_sg, elem->in_num, offset,
+    v9fs_init_qiov_from_pdu(&qiov_full, pdu, 0, read_count, false);
+    err = v9fs_pack(qiov_full.iov, qiov_full.niov, offset,
                     ((char *)fidp->fs.xattr.value) + off,
                     read_count);
+    qemu_iovec_destroy(&qiov_full);
     if (err < 0) {
         return err;
     }
@@ -1732,32 +1759,6 @@ static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
     return count;
 }
 
-/*
- * Create a QEMUIOVector for a sub-region of PDU iovecs
- *
- * @qiov:       uninitialized QEMUIOVector
- * @skip:       number of bytes to skip from beginning of PDU
- * @size:       number of bytes to include
- * @is_write:   true - write, false - read
- *
- * The resulting QEMUIOVector has heap-allocated iovecs and must be cleaned up
- * with qemu_iovec_destroy().
- */
-static void v9fs_init_qiov_from_pdu(QEMUIOVector *qiov, V9fsPDU *pdu,
-                                    size_t skip, size_t size,
-                                    bool is_write)
-{
-    QEMUIOVector elem;
-    struct iovec *iov;
-    unsigned int niov;
-
-    pdu->s->transport->init_iov_from_pdu(pdu, &iov, &niov, is_write);
-
-    qemu_iovec_init_external(&elem, iov, niov);
-    qemu_iovec_init(qiov, niov);
-    qemu_iovec_concat(qiov, &elem, skip, size);
-}
-
 static void coroutine_fn v9fs_read(void *opaque)
 {
     int32_t fid;
-- 
2.7.4
