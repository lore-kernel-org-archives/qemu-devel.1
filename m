Received: from eggs.gnu.org ([2001:4830:134:3::10]:55114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d16tc-0006tb-Oy
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d16tb-0003Fx-T1
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:52:56 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 20 Apr 2017 15:52:19 +0800
Message-Id: <20170420075237.18219-3-famz@redhat.com>
In-Reply-To: <20170420075237.18219-1-famz@redhat.com>
References: <20170420075237.18219-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v13 02/20] block: Drop consistent read perm if
 opened unsafe
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
 block.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index 1fbbb8d..f5182d8 100644
--- a/block.c
+++ b/block.c
@@ -1722,9 +1722,15 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
         }
 
         /* bs->file always needs to be consistent because of the metadata. We
-         * can never allow other users to resize or write to it. */
-        perm |= BLK_PERM_CONSISTENT_READ;
-        shared &= ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
+         * cannot allow other users to resize or write to it unless the caller
+         * explicitly expects unsafe readings. */
+        if (!(bdrv_get_flags(bs) & BDRV_O_UNSAFE_READ)) {
+            perm |= BLK_PERM_CONSISTENT_READ;
+            shared &= ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
+        } else {
+            perm &= ~BLK_PERM_CONSISTENT_READ;
+            shared |= BLK_PERM_WRITE | BLK_PERM_RESIZE;
+        }
     } else {
         /* We want consistent read from backing files if the parent needs it.
          * No other operations are performed on backing files. */
-- 
2.9.3
