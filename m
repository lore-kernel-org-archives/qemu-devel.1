Received: from eggs.gnu.org ([2001:4830:134:3::10]:35290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnRNk-0005pQ-Uv
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:55:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnRNk-0002yO-5w
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:55:33 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Mar 2017 15:55:06 +0100
Message-Id: <1489416908-3771-11-git-send-email-kwolf@redhat.com>
In-Reply-To: <1489416908-3771-1-git-send-email-kwolf@redhat.com>
References: <1489416908-3771-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 10/12] block: Refresh filename after changing
 backing file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

In bdrv_open_inherit(), the filename is refreshed after opening the
backing file, but we neglected to do the same when the backing file
changes later.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block.c b/block.c
index dd38e71..cb57370 100644
--- a/block.c
+++ b/block.c
@@ -1938,6 +1938,8 @@ void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
         bdrv_unref(backing_hd);
     }
 
+    bdrv_refresh_filename(bs);
+
 out:
     bdrv_refresh_limits(bs, NULL);
 }
-- 
1.8.3.1
