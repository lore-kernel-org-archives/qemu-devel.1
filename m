Received: from eggs.gnu.org ([2001:4830:134:3::10]:58155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dQSY0-0003K0-Vq
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 02:03:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dQSY0-0006Qi-6e
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 02:03:25 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Thu, 29 Jun 2017 09:03:00 +0300
Message-Id: <20170629060300.29869-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH] block: fix bs->file leak in
 bdrv_new_open_driver()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

bdrv_open_driver() is called in two places, bdrv_new_open_driver() and
bdrv_open_common(). In the latter, failure cleanup in is in its caller,
bdrv_open_inherit(), which unrefs the bs->file of the failed driver open
if it exists. Let's check for this in bdrv_new_open_driver() as well.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block.c b/block.c
index 694396281b..aeacd520e0 100644
--- a/block.c
+++ b/block.c
@@ -1165,6 +1165,9 @@ BlockDriverState *bdrv_new_open_driver(BlockDriver *drv, const char *node_name,
 
     ret = bdrv_open_driver(bs, drv, node_name, bs->options, flags, errp);
     if (ret < 0) {
+        if (bs->file != NULL) {
+            bdrv_unref_child(bs, bs->file);
+        }
         QDECREF(bs->explicit_options);
         QDECREF(bs->options);
         bdrv_unref(bs);
-- 
2.11.0
