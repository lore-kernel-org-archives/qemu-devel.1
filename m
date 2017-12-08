Received: from eggs.gnu.org ([2001:4830:134:3::10]:43340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eNJbf-0006aG-OC
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:26:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eNJbb-0002pL-RD
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:26:27 -0500
Received: from 3.mo173.mail-out.ovh.net ([46.105.34.1]:35100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eNJbb-0002oP-Jb
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:26:23 -0500
Received: from player739.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 7B3AC92E0F
	for <qemu-devel@nongnu.org>; Fri,  8 Dec 2017 15:26:17 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 08 Dec 2017 15:26:13 +0100
Message-ID: <151274317380.5376.485467933490492379.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] tests: virtio-9p: fix ISR dependence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>

Like other virtio tests, use the used ring APIs instead of assuming ISR
being set means the request has completed.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 tests/virtio-9p-test.c |   30 +++++++++++-------------------
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
