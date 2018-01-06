Received: from eggs.gnu.org ([2001:4830:134:3::10]:56720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eXcy4-0007DM-NR
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 20:08:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eXcy1-0006H4-FS
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 20:08:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eXcy0-0006Fa-Nr
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 20:08:09 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	w0614Ywf007529
	for <qemu-devel@nongnu.org>; Fri, 5 Jan 2018 20:08:08 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fam0egw88-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 20:08:07 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Sat, 6 Jan 2018 01:08:05 -0000
From: Greg Kurz <groug@kaod.org>
Date: Sat,  6 Jan 2018 02:07:36 +0100
In-Reply-To: <20180106010739.18201-1-groug@kaod.org>
References: <20180106010739.18201-1-groug@kaod.org>
Message-Id: <20180106010739.18201-10-groug@kaod.org>
Subject: [Qemu-devel] [PULL 09/12] tests: virtio-9p: fix ISR dependence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

Like other virtio tests, use the used ring APIs instead of assuming ISR
being set means the request has completed.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/virtio-9p-test.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index ad33d963876f..ebd24b20f657 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -18,6 +18,8 @@
 #include "standard-headers/linux/virtio_pci.h"
 #include "hw/9pfs/9p.h"
 
+#define QVIRTIO_9P_TIMEOUT_US (10 * 1000 * 1000)
+
 static const char mount_tag[] = "qtest";
 
 typedef struct {
@@ -111,6 +113,7 @@ typedef struct {
     /* No r_size, it is hardcoded to P9_MAX_SIZE */
     size_t t_off;
     size_t r_off;
+    uint32_t free_head;
 } P9Req;
 
 static void v9fs_memwrite(P9Req *req, const void *addr, size_t len)
@@ -124,11 +127,6 @@ static void v9fs_memskip(P9Req *req, size_t len)
     req->r_off += len;
 }
 
-static void v9fs_memrewind(P9Req *req, size_t len)
-{
-    req->r_off -= len;
-}
-
 static void v9fs_memread(P9Req *req, void *addr, size_t len)
 {
     memread(req->r_msg + req->r_off, addr, len);
@@ -227,12 +225,12 @@ static P9Req *v9fs_req_init(QVirtIO9P *v9p, uint32_t size, uint8_t id,
 static void v9fs_req_send(P9Req *req)
 {
     QVirtIO9P *v9p = req->v9p;
-    uint32_t free_head;
 
     req->r_msg = guest_alloc(v9p->qs->alloc, P9_MAX_SIZE);
-    free_head = qvirtqueue_add(v9p->vq, req->t_msg, req->t_size, false, true);
+    req->free_head = qvirtqueue_add(v9p->vq, req->t_msg, req->t_size, false,
+                                    true);
     qvirtqueue_add(v9p->vq, req->r_msg, P9_MAX_SIZE, true, false);
-    qvirtqueue_kick(v9p->dev, v9p->vq, free_head);
+    qvirtqueue_kick(v9p->dev, v9p->vq, req->free_head);
     req->t_off = 0;
 }
 
@@ -250,19 +248,13 @@ static void v9fs_req_recv(P9Req *req, uint8_t id)
 {
     QVirtIO9P *v9p = req->v9p;
     P9Hdr hdr;
-    int i;
 
-    for (i = 0; i < 10; i++) {
-        qvirtio_wait_queue_isr(v9p->dev, v9p->vq, 1000 * 1000);
+    qvirtio_wait_used_elem(v9p->dev, v9p->vq, req->free_head,
+                           QVIRTIO_9P_TIMEOUT_US);
 
-        v9fs_memread(req, &hdr, 7);
-        hdr.size = ldl_le_p(&hdr.size);
-        hdr.tag = lduw_le_p(&hdr.tag);
-        if (hdr.size >= 7) {
-            break;
-        }
-        v9fs_memrewind(req, 7);
-    }
+    v9fs_memread(req, &hdr, 7);
+    hdr.size = ldl_le_p(&hdr.size);
+    hdr.tag = lduw_le_p(&hdr.tag);
 
     g_assert_cmpint(hdr.size, >=, 7);
     g_assert_cmpint(hdr.size, <=, P9_MAX_SIZE);
-- 
2.13.6
