Received: from eggs.gnu.org ([2001:4830:134:3::10]:55185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d16tj-0006ys-OA
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d16ti-0003IS-L3
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:53:03 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 20 Apr 2017 15:52:20 +0800
Message-Id: <20170420075237.18219-4-famz@redhat.com>
In-Reply-To: <20170420075237.18219-1-famz@redhat.com>
References: <20170420075237.18219-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v13 03/20] block: Don't require
 BLK_PERM_CONSISTENT_READ when unsafe open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index f5182d8..ac0527a 100644
--- a/block.c
+++ b/block.c
@@ -2372,7 +2372,9 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
             goto fail;
         }
         if (file_bs != NULL) {
-            file = blk_new(BLK_PERM_CONSISTENT_READ, BLK_PERM_ALL);
+            file = blk_new(flags & BDRV_O_UNSAFE_READ ?
+                               0 : BLK_PERM_CONSISTENT_READ,
+                           BLK_PERM_ALL);
             blk_insert_bs(file, file_bs, &local_err);
             bdrv_unref(file_bs);
             if (local_err) {
-- 
2.9.3
