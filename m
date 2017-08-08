Received: from eggs.gnu.org ([2001:4830:134:3::10]:42529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df52S-0000MQ-3H
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df52M-0002DU-VO
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:59:16 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  8 Aug 2017 15:58:32 +0200
Message-Id: <20170808135838.11525-13-kwolf@redhat.com>
In-Reply-To: <20170808135838.11525-1-kwolf@redhat.com>
References: <20170808135838.11525-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 12/18] parallels: drop check that
 bdrv_truncate() is working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

From: "Denis V. Lunev" <den@openvz.org>

This would be actually strange and error prone. If truncate() nowadays
will fail, there is something fatally wrong. Let's check for that during
the actual work.

The only fallback case is when the file is not zero initialized. In this
case we should switch to preallocation via fallocate().

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Markus Armbruster <armbru@redhat.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/parallels.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 6794e53c0b..e1e06d23cc 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -703,9 +703,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail_options;
     }
 
-    if (!(flags & BDRV_O_RESIZE) || !bdrv_has_zero_init(bs->file->bs) ||
-            bdrv_truncate(bs->file, bdrv_getlength(bs->file->bs),
-                          PREALLOC_MODE_OFF, NULL) != 0) {
+    if (!bdrv_has_zero_init(bs->file->bs)) {
         s->prealloc_mode = PRL_PREALLOC_MODE_FALLOCATE;
     }
 
-- 
2.13.4
