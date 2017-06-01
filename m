Received: from eggs.gnu.org ([2001:4830:134:3::10]:51518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dGRoW-000080-Bj
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:15:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dGRoU-0004e9-7L
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:15:04 -0400
Received: from mail-eopbgr40133.outbound.protection.outlook.com
	([40.107.4.133]:34349
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dGRoT-0004d9-W7
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:15:02 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Thu, 1 Jun 2017 18:14:20 +0300
Message-ID: <1496330073-51338-3-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1496330073-51338-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1496330073-51338-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 02/15] file-posix: support BDRV_REQ_ALLOCATE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

Current write_zeroes implementation is good enough to satisfy this flag too

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 block/file-posix.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index de2d3a2..117bbee 100644
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
