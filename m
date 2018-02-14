Received: from eggs.gnu.org ([2001:4830:134:3::10]:44272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1elzcu-0004A4-9N
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:09:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1elzcr-0008JV-6U
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:09:44 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Wed, 14 Feb 2018 19:09:20 +0300
Message-Id: <1518624560-38060-3-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1518624560-38060-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1518624560-38060-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 2/2] block: fix write with zero flag set and
 iovector provided
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, famz@redhat.com, eblake@redhat.com, berto@igalia.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

The normal bdrv_co_pwritev() use is either
  - BDRV_REQ_ZERO_WRITE clear and iovector provided
  - BDRV_REQ_ZERO_WRITE set and iovector == NULL

while
  - the flag clear and iovector == NULL is an assertion failure
    in bdrv_co_do_zero_pwritev()
  - the flag set and iovector provided is in fact allowed
    (the flag prevails and zeroes are written)

However the alignment logic does not support the latter case so the padding
areas get overwritten with zeroes.

Currently, general functions like bdrv_rw_co() do provide iovector
regardless of flags. So, keep it supported and use bdrv_co_do_zero_pwritev()
alignment for it which also makes the code a bit more obvious anyway.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index 89d0745..40df3be 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1701,7 +1701,7 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
      */
     tracked_request_begin(&req, bs, offset, bytes, BDRV_TRACKED_WRITE);
 
-    if (!qiov) {
+    if (flags & BDRV_REQ_ZERO_WRITE) {
         ret = bdrv_co_do_zero_pwritev(child, offset, bytes, flags, &req);
         goto out;
     }
-- 
2.7.4
