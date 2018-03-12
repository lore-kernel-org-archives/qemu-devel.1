Received: from eggs.gnu.org ([2001:4830:134:3::10]:33643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1evKWK-0002mt-Qy
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:17:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1evKWG-0006mo-Jx
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:17:32 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Mon, 12 Mar 2018 13:16:55 +0300
Message-Id: <1520849818-6915-7-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1520849818-6915-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1520849818-6915-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v8 6/9] file-posix: support BDRV_REQ_ALLOCATE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

Current write_zeroes implementation is good enough to satisfy this flag too

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/file-posix.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 7f2cc63..2136df9 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -560,7 +560,10 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     }
     if (S_ISREG(st.st_mode)) {
         s->discard_zeroes = true;
+#ifdef CONFIG_FALLOCATE
         s->has_fallocate = true;
+        bs->supported_zero_flags |= BDRV_REQ_ALLOCATE;
+#endif
     }
     if (S_ISBLK(st.st_mode)) {
 #ifdef BLKDISCARDZEROES
@@ -595,10 +598,11 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
 #ifdef CONFIG_XFS
     if (platform_test_xfs_fd(s->fd)) {
         s->is_xfs = true;
+        bs->supported_zero_flags |= BDRV_REQ_ALLOCATE;
     }
 #endif
 
-    bs->supported_zero_flags = s->discard_zeroes ? BDRV_REQ_MAY_UNMAP : 0;
+    bs->supported_zero_flags |= s->discard_zeroes ? BDRV_REQ_MAY_UNMAP : 0;
     ret = 0;
 fail:
     if (filename && (bdrv_flags & BDRV_O_TEMPORARY)) {
@@ -1416,6 +1420,10 @@ static ssize_t handle_aiocb_write_zeroes(RawPosixAIOData *aiocb)
         }
         s->has_fallocate = false;
     }
+
+    if (!s->has_fallocate) {
+        aiocb->bs->supported_zero_flags &= ~BDRV_REQ_ALLOCATE;
+    }
 #endif
 
     return -ENOTSUP;
-- 
2.7.4
