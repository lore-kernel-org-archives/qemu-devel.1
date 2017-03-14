Received: from eggs.gnu.org ([2001:4830:134:3::10]:53287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cncNE-0002OY-9p
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 22:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cncND-0008Aw-HE
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 22:39:44 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 14 Mar 2017 10:39:31 +0800
Message-Id: <20170314023933.12118-2-famz@redhat.com>
In-Reply-To: <20170314023933.12118-1-famz@redhat.com>
References: <20170314023933.12118-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 1/3] block: Introduce BDRV_O_UNSAFE_READ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

This flag clears out the "consistent read" permission that blk_new_open
requests.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/block-backend.c | 2 +-
 include/block/block.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 5742c09..99428ee 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -197,7 +197,7 @@ BlockBackend *blk_new_open(const char *filename, const char *reference,
      * caller of blk_new_open() doesn't make use of the permissions, but they
      * shouldn't hurt either. We can still share everything here because the
      * guest devices will add their own blockers if they can't share. */
-    perm = BLK_PERM_CONSISTENT_READ;
+    perm = flags & BDRV_O_UNSAFE_READ ? 0 : BLK_PERM_CONSISTENT_READ;
     if (flags & BDRV_O_RDWR) {
         perm |= BLK_PERM_WRITE;
     }
diff --git a/include/block/block.h b/include/block/block.h
index 5149260..d43b563 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -98,6 +98,7 @@ typedef struct HDGeometry {
                                       select an appropriate protocol driver,
                                       ignoring the format layer */
 #define BDRV_O_NO_IO       0x10000 /* don't initialize for I/O */
+#define BDRV_O_UNSAFE_READ 0x20000 /* don't require consistent read */
 
 #define BDRV_O_CACHE_MASK  (BDRV_O_NOCACHE | BDRV_O_NO_FLUSH)
 
-- 
2.9.3
