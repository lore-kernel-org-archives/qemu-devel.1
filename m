Received: from eggs.gnu.org ([2001:4830:134:3::10]:60252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cso26-0004Cy-W5
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:07:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cso23-0002xP-UJ
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:07:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cso23-0002x7-Oo
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:07:19 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 28 Mar 2017 11:07:13 +0100
Message-Id: <20170328100713.28785-2-stefanha@redhat.com>
In-Reply-To: <20170328100713.28785-1-stefanha@redhat.com>
References: <20170328100713.28785-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 1/1] parallels: wrong call to
 bdrv_truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Denis V. Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>

From: "Denis V. Lunev" <den@openvz.org>

Parallels driver should not call bdrv_truncate if the image was opened
in the read-only mode. Without the patch
    qemu-img check harddisk.hds
asserts with
    bdrv_truncate: Assertion `child->perm & BLK_PERM_RESIZE' failed.

Parameters used on the write path are not needed if the image is opened
in the read-only mode.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reported-by: Edgar Kaziahmedov <edos@virtuozzo.mipt.ru>
Message-id: 1490625488-7980-1-git-send-email-den@openvz.org
CC: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
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
2.9.3
