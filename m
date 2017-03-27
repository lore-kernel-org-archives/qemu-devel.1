Received: from eggs.gnu.org ([2001:4830:134:3::10]:52871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1csVml-0001pF-Kr
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:38:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1csVmg-0002Ve-O5
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:38:19 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:15760 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1csVmg-0002TQ-DM
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:38:14 -0400
From: "Denis V. Lunev" <den@openvz.org>
Date: Mon, 27 Mar 2017 17:38:08 +0300
Message-Id: <1490625488-7980-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [PATCH 1/1] parallels: wrong call to bdrv_truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>

Parallels driver should not call bdrv_truncate if the image was opened
in the read-only mode. Without the patch
    qemu-img check harddisk.hds
asserts with
    bdrv_truncate: Assertion `child->perm & BLK_PERM_RESIZE' failed.

Parameters used on the write path are not needed if the image is opened
in the read-only mode.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reported-by: Edgar Kaziahmedov <edos@virtuozzo.mipt.ru>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/parallels.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/parallels.c b/block/parallels.c
index 6bf9375..4173b3f 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -687,7 +687,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     if (local_err != NULL) {
         goto fail_options;
     }
-    if (!bdrv_has_zero_init(bs->file->bs) ||
+
+    if (!(flags & BDRV_O_RESIZE) || !bdrv_has_zero_init(bs->file->bs) ||
             bdrv_truncate(bs->file, bdrv_getlength(bs->file->bs)) != 0) {
         s->prealloc_mode = PRL_PREALLOC_MODE_FALLOCATE;
     }
-- 
2.7.4
