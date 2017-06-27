Received: from eggs.gnu.org ([2001:4830:134:3::10]:49903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dPybP-0008E1-Ll
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 18:04:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dPybK-0000Mv-Oe
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 18:04:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dPybK-0000Mj-IL
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 18:04:50 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Tue, 27 Jun 2017 15:04:41 -0700
Message-Id: <1498601083-11799-1-git-send-email-sstabellini@kernel.org>
In-Reply-To: <alpine.DEB.2.10.1706271456310.24648@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1706271456310.24648@sstabellini-ThinkPad-X260>
Subject: [Qemu-devel] [PULL 1/3] xen/disk: don't leak stack data via
 response ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Jan Beulich <jbeulich@suse.com>

Rather than constructing a local structure instance on the stack, fill
the fields directly on the shared ring, just like other (Linux)
backends do. Build on the fact that all response structure flavors are
actually identical (aside from alignment and padding at the end).

This is XSA-216.

Reported by: Anthony Perard <anthony.perard@citrix.com>
Signed-off-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/block/xen_disk.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
index 3a22805..9200511 100644
--- a/hw/block/xen_disk.c
+++ b/hw/block/xen_disk.c
@@ -769,31 +769,30 @@ static int blk_send_response_one(struct ioreq *ioreq)
     struct XenBlkDev  *blkdev = ioreq->blkdev;
     int               send_notify   = 0;
     int               have_requests = 0;
-    blkif_response_t  resp;
-    void              *dst;
-
-    resp.id        = ioreq->req.id;
-    resp.operation = ioreq->req.operation;
-    resp.status    = ioreq->status;
+    blkif_response_t  *resp;
 
     /* Place on the response ring for the relevant domain. */
     switch (blkdev->protocol) {
     case BLKIF_PROTOCOL_NATIVE:
-        dst = RING_GET_RESPONSE(&blkdev->rings.native, blkdev->rings.native.rsp_prod_pvt);
+        resp = (blkif_response_t *) RING_GET_RESPONSE(&blkdev->rings.native,
+                                 blkdev->rings.native.rsp_prod_pvt);
         break;
     case BLKIF_PROTOCOL_X86_32:
-        dst = RING_GET_RESPONSE(&blkdev->rings.x86_32_part,
-                                blkdev->rings.x86_32_part.rsp_prod_pvt);
+        resp = (blkif_response_t *) RING_GET_RESPONSE(&blkdev->rings.x86_32_part,
+                                 blkdev->rings.x86_32_part.rsp_prod_pvt);
         break;
     case BLKIF_PROTOCOL_X86_64:
-        dst = RING_GET_RESPONSE(&blkdev->rings.x86_64_part,
-                                blkdev->rings.x86_64_part.rsp_prod_pvt);
+        resp = (blkif_response_t *) RING_GET_RESPONSE(&blkdev->rings.x86_64_part,
+                                 blkdev->rings.x86_64_part.rsp_prod_pvt);
         break;
     default:
-        dst = NULL;
         return 0;
     }
-    memcpy(dst, &resp, sizeof(resp));
+
+    resp->id        = ioreq->req.id;
+    resp->operation = ioreq->req.operation;
+    resp->status    = ioreq->status;
+
     blkdev->rings.common.rsp_prod_pvt++;
 
     RING_PUSH_RESPONSES_AND_CHECK_NOTIFY(&blkdev->rings.common, send_notify);
-- 
1.9.1
