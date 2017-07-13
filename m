Received: from eggs.gnu.org ([2001:4830:134:3::10]:54688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVgMT-00079F-Jx
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:49:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVgMS-0006Yj-Tq
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:49:05 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 13 Jul 2017 10:47:10 -0500
Message-Id: <20170713154711.32374-23-eblake@redhat.com>
In-Reply-To: <20170713154711.32374-1-eblake@redhat.com>
References: <20170713154711.32374-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 22/23] block: Relax bdrv_aligned_preadv()
 assertion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

Now that bdrv_is_allocated accepts non-aligned inputs, we can
remove the TODO added in commit d6a644bb.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v3: new patch [Kevin]
---
 block/io.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/block/io.c b/block/io.c
index df692d2..0e4a3e6 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1031,18 +1031,14 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
     }

     if (flags & BDRV_REQ_COPY_ON_READ) {
-        /* TODO: Simplify further once bdrv_is_allocated no longer
-         * requires sector alignment */
-        int64_t start = QEMU_ALIGN_DOWN(offset, BDRV_SECTOR_SIZE);
-        int64_t end = QEMU_ALIGN_UP(offset + bytes, BDRV_SECTOR_SIZE);
         int64_t pnum;

-        ret = bdrv_is_allocated(bs, start, end - start, &pnum);
+        ret = bdrv_is_allocated(bs, offset, bytes, &pnum);
         if (ret < 0) {
             goto out;
         }

-        if (!ret || pnum != end - start) {
+        if (!ret || pnum != bytes) {
             ret = bdrv_co_do_copy_on_readv(child, offset, bytes, qiov);
             goto out;
         }
-- 
2.9.4
