Received: from eggs.gnu.org ([2001:4830:134:3::10]:53140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cb5nx-0005XT-9p
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:27:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cb5nw-0007ol-I4
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:27:33 -0500
From: Fam Zheng <famz@redhat.com>
Date: Tue,  7 Feb 2017 21:27:22 +0800
Message-Id: <20170207132723.13934-2-famz@redhat.com>
In-Reply-To: <20170207132723.13934-1-famz@redhat.com>
References: <20170207132723.13934-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] virtio-blk: Remove useless condition
 around g_free()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

Laszlo spotted and studied this wasteful "if". He pointed out:

The original virtio_blk_free_request needed an "if" as it accesses one
field, since 671ec3f05655 ("virtio-blk: Convert VirtIOBlockReq.elem to
pointer", 2014-06-11); later on in f897bf751fbd ("virtio-blk: embed
VirtQueueElement in VirtIOBlockReq", 2014-07-09) the field became
embedded, so the "if" became unnecessary (at which point we were using
g_slice_free(), but it is the same.

Now drop it.

Reported-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/block/virtio-blk.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 702eda8..2858c31 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -42,9 +42,7 @@ static void virtio_blk_init_request(VirtIOBlock *s, VirtQueue *vq,
 
 static void virtio_blk_free_request(VirtIOBlockReq *req)
 {
-    if (req) {
-        g_free(req);
-    }
+    g_free(req);
 }
 
 static void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status)
-- 
2.9.3
