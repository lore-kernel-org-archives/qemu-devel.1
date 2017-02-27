Received: from eggs.gnu.org ([2001:4830:134:3::10]:57859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ciRe4-0000rP-Jy
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 15:11:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ciRe3-0003ut-PK
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 15:11:44 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 27 Feb 2017 21:09:41 +0100
Message-Id: <1488226184-9044-41-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488226184-9044-1-git-send-email-kwolf@redhat.com>
References: <1488226184-9044-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 40/43] block: Assertions for write
 permissions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This adds assertions that ensure that the necessary write permissions
have been granted before someone attempts to write to a node.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/io.c b/block/io.c
index 2592ca1..4c79745 100644
--- a/block/io.c
+++ b/block/io.c
@@ -945,6 +945,8 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
     size_t skip_bytes;
     int ret;
 
+    assert(child->perm & (BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE));
+
     /* Cover entire cluster so no additional backing file I/O is required when
      * allocating cluster in the image file.
      */
@@ -1336,6 +1338,7 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     assert(!waited || !req->serialising);
     assert(req->overlap_offset <= offset);
     assert(offset + bytes <= req->overlap_offset + req->overlap_bytes);
+    assert(child->perm & BLK_PERM_WRITE);
 
     ret = notifier_with_return_list_notify(&bs->before_write_notifiers, req);
 
-- 
1.8.3.1
