Received: from eggs.gnu.org ([2001:4830:134:3::10]:52265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ecEJg-0004Mf-Gd
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:49:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ecEJc-0004Fe-EO
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:49:32 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Thu, 18 Jan 2018 20:49:00 +0300
Message-Id: <1516297747-107232-3-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v7 2/9] blkverify: set supported write/zero
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
 block/blkverify.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/blkverify.c b/block/blkverify.c
index 06369f9..9ba65d0 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -140,6 +140,15 @@ static int blkverify_open(BlockDriverState *bs, QDict *options, int flags,
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
