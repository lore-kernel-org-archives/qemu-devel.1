Received: from eggs.gnu.org ([2001:4830:134:3::10]:39354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dcDSj-0004nq-BT
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dcDSh-0005Ob-MB
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:22:33 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Mon, 31 Jul 2017 19:21:55 +0300
Message-Id: <1501518125-29851-4-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1501518125-29851-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1501518125-29851-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 03/13] file-posix: support BDRV_REQ_ALLOCATE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

Current write_zeroes implementation is good enough to satisfy this flag too

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 block/file-posix.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index cfbb236..bd52b31 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -527,7 +527,6 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
 
     s->has_discard = true;
     s->has_write_zeroes = true;
-    bs->supported_zero_flags = BDRV_REQ_MAY_UNMAP;
     if ((bs->open_flags & BDRV_O_NOCACHE) != 0) {
         s->needs_alignment = true;
     }
@@ -577,6 +576,11 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     }
 #endif
 
+    bs->supported_zero_flags = BDRV_REQ_MAY_UNMAP;
+    if (s->has_write_zeroes || s->has_fallocate) {
+        bs->supported_zero_flags |= BDRV_REQ_ALLOCATE;
+    }
+
     ret = 0;
 fail:
     if (filename && (bdrv_flags & BDRV_O_TEMPORARY)) {
@@ -1390,6 +1394,9 @@ static ssize_t handle_aiocb_write_zeroes(RawPosixAIOData *aiocb)
     }
 #endif
 
+    if (!s->has_fallocate) {
+        aiocb->bs->supported_zero_flags &= ~BDRV_REQ_ALLOCATE;
+    }
     return -ENOTSUP;
 }
 
-- 
2.7.4
