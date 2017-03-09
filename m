Received: from eggs.gnu.org ([2001:4830:134:3::10]:34864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clwPe-0000LR-5W
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:39:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clwPd-0006Yo-0P
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:39:18 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  9 Mar 2017 12:39:00 +0100
Message-Id: <1489059542-14232-5-git-send-email-kwolf@redhat.com>
In-Reply-To: <1489059542-14232-1-git-send-email-kwolf@redhat.com>
References: <1489059542-14232-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 4/6] block: Refresh filename after changing
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
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

In bdrv_open_inherit(), the filename is refreshed after opening the
backing file, but we neglected to do the same when the backing file
changes later.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block.c b/block.c
index 756d607..516cefe 100644
--- a/block.c
+++ b/block.c
@@ -1933,6 +1933,8 @@ void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
         bdrv_unref(backing_hd);
     }
 
+    bdrv_refresh_filename(bs);
+
 out:
     bdrv_refresh_limits(bs, NULL);
 }
-- 
1.8.3.1
