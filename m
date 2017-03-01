Received: from eggs.gnu.org ([2001:4830:134:3::10]:58455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cizPm-0001pD-Tz
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 03:15:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cizPm-0003mv-07
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 03:15:14 -0500
From: Fam Zheng <famz@redhat.com>
Date: Wed,  1 Mar 2017 16:15:04 +0800
Message-Id: <20170301081504.23595-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC] block: Tolerate existing writers on read
 only BdrvChild
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

In an ideal world, read-write access to an image is inherently
exclusive, because we cannot guarantee other readers and writers a
consistency view of the whole image at all point. That's what the
current permission system does, and it is okay as long as it is entirely
internal. But that would change with the coming image locking. In
practice, both end users and our test cases use tools like qemu-img and
qemu-io to peek at images while guest is running.

Relax a bit and accept other writers in this case.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block.c b/block.c
index f293ccb..9bdd77c 100644
--- a/block.c
+++ b/block.c
@@ -1685,12 +1685,12 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
         /* Format drivers may touch metadata even if the guest doesn't write */
         if (!bdrv_is_read_only(bs)) {
             perm |= BLK_PERM_WRITE | BLK_PERM_RESIZE;
+            shared &= ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
         }
 
         /* bs->file always needs to be consistent because of the metadata. We
          * can never allow other users to resize or write to it. */
         perm |= BLK_PERM_CONSISTENT_READ;
-        shared &= ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
     } else {
         /* We want consistent read from backing files if the parent needs it.
          * No other operations are performed on backing files. */
-- 
2.9.3
