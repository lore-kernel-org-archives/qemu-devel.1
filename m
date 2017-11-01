Received: from eggs.gnu.org ([2001:4830:134:3::10]:60534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1e9vCB-00087t-KF
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1e9vC7-0006dm-Bv
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:44:47 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Wed,  1 Nov 2017 18:43:58 +0300
Message-Id: <1509551048-129830-6-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1509551048-129830-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1509551048-129830-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 05/15] file-posix: support BDRV_REQ_ALLOCATE
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
---
 block/file-posix.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 36ee89e..c36e156 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -558,7 +558,10 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
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
@@ -593,6 +596,7 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
 #ifdef CONFIG_XFS
     if (platform_test_xfs_fd(s->fd)) {
         s->is_xfs = true;
+        bs->supported_zero_flags |= BDRV_REQ_ALLOCATE;
     }
 #endif
 
@@ -1413,6 +1417,10 @@ static ssize_t handle_aiocb_write_zeroes(RawPosixAIOData *aiocb)
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
