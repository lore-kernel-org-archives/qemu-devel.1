Received: from eggs.gnu.org ([2001:4830:134:3::10]:55611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ebQvK-0002ck-LQ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:05:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ebQvE-0006S7-TX
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:05:06 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 16 Jan 2018 16:04:22 +0300
Message-Id: <1516107870-8110-2-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1516107870-8110-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1516107870-8110-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 1/9] mirror: inherit supported write/zero
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
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/mirror.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/mirror.c b/block/mirror.c
index c9badc1..d18ec65 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1064,6 +1064,11 @@ static void bdrv_mirror_top_refresh_filename(BlockDriverState *bs, QDict *opts)
     bdrv_refresh_filename(bs->backing->bs);
     pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
             bs->backing->bs->filename);
+    bs->supported_write_flags = BDRV_REQ_FUA &
+        bs->backing->bs->supported_write_flags;
+    bs->supported_zero_flags =
+        (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
+        bs->backing->bs->supported_zero_flags;
 }
 
 static void bdrv_mirror_top_close(BlockDriverState *bs)
-- 
2.7.4
