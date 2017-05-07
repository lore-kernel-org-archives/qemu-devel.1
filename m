Received: from eggs.gnu.org ([2001:4830:134:3::10]:54394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d7GKy-0006ev-QV
	for qemu-devel@nongnu.org; Sun, 07 May 2017 03:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d7GKv-0000i1-Pd
	for qemu-devel@nongnu.org; Sun, 07 May 2017 03:10:36 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun,  7 May 2017 10:02:17 +0300
Message-Id: <ed836aa2cb4ad78e00f07e13aabd73af71a7d4a2.1494140528.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 14/23] virtio-blk: Remove useless condition
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
Cc: Fam Zheng <famz@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Fam Zheng <famz@redhat.com>

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
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/block/virtio-blk.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 98c16a7a9a..604d37dfc8 100644
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
2.11.0
