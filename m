Received: from eggs.gnu.org ([2001:4830:134:3::10]:47808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fG44g-0000EF-T0
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:58:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fG44c-0001Uv-Pd
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:58:42 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue,  8 May 2018 17:58:09 +0300
Message-Id: <1525791496-125188-3-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1525791496-125188-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1525791496-125188-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v9 2/9] blkverify: set supported write/zero
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
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/blkverify.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/blkverify.c b/block/blkverify.c
index 754cc9e..496ae09 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -141,6 +141,15 @@ static int blkverify_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
+    bs->supported_write_flags = BDRV_REQ_FUA &
+        bs->file->bs->supported_write_flags &
+        s->test_file->bs->supported_write_flags;
+
+    bs->supported_zero_flags =
+        (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
+        bs->file->bs->supported_zero_flags &
+        s->test_file->bs->supported_zero_flags;
+
     ret = 0;
 fail:
     qemu_opts_del(opts);
-- 
2.7.4
