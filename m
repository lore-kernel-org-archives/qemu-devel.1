Received: from eggs.gnu.org ([2001:4830:134:3::10]:60413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1e9vC6-00083F-Uq
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:44:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1e9vC2-0006bT-Bv
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:44:43 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Wed,  1 Nov 2017 18:43:54 +0300
Message-Id: <1509551048-129830-2-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1509551048-129830-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1509551048-129830-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 01/15] mirror: inherit supported write/zero
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
---
 block/mirror.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/mirror.c b/block/mirror.c
index 307b639..19c8987 100644
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
