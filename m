Received: from eggs.gnu.org ([2001:4830:134:3::10]:47803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fG44g-0000E2-HT
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:58:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fG44c-0001Ud-DZ
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:58:42 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue,  8 May 2018 17:58:08 +0300
Message-Id: <1525791496-125188-2-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1525791496-125188-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1525791496-125188-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v9 1/9] mirror: inherit supported write/zero
 flags
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

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/mirror.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block/mirror.c b/block/mirror.c
index 820f512..a22ddef 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1098,6 +1098,15 @@ static BlockDriver bdrv_mirror_top = {
     .bdrv_child_perm            = bdrv_mirror_top_child_perm,
 };
 
+static void mirror_top_set_supported_flags(BlockDriverState *bs)
+{
+    bs->supported_write_flags = BDRV_REQ_FUA &
+        bs->backing->bs->supported_write_flags;
+    bs->supported_zero_flags =
+        (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
+        bs->backing->bs->supported_zero_flags;
+}
+
 static void mirror_start_job(const char *job_id, BlockDriverState *bs,
                              int creation_flags, BlockDriverState *target,
                              const char *replaces, int64_t speed,
@@ -1163,6 +1172,8 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
         return;
     }
 
+    mirror_top_set_supported_flags(mirror_top_bs);
+
     /* Make sure that the source is not resized while the job is running */
     s = block_job_create(job_id, driver, NULL, mirror_top_bs,
                          BLK_PERM_CONSISTENT_READ,
-- 
2.7.4
