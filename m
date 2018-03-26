Received: from eggs.gnu.org ([2001:4830:134:3::10]:45334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f0TEM-0002wV-0i
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:36:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f0TEL-0003tH-9C
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:36:14 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 26 Mar 2018 16:35:46 +0200
Message-Id: <20180326143600.7724-6-kwolf@redhat.com>
In-Reply-To: <20180326143600.7724-1-kwolf@redhat.com>
References: <20180326143600.7724-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 05/19] block/blkreplay: Remove protocol-related
 fields
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

From: Fabiano Rosas <farosas@linux.vnet.ibm.com>

The blkreplay driver is not a protocol so it should implement bdrv_open
instead of bdrv_file_open and not provide a protocol_name.

Attempts to invoke this driver using protocol syntax
(i.e. blkreplay:<filename:options:...>) will now fail gracefully:

  $ qemu-img info blkreplay:foo
  qemu-img: Could not open 'blkreplay:foo': Unknown protocol 'blkreplay'

Signed-off-by: Fabiano Rosas <farosas@linux.vnet.ibm.com>
Reviewed-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/blkreplay.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blkreplay.c b/block/blkreplay.c
index 61e44a1949..fe5a9b4a98 100755
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -129,10 +129,9 @@ static int coroutine_fn blkreplay_co_flush(BlockDriverState *bs)
 
 static BlockDriver bdrv_blkreplay = {
     .format_name            = "blkreplay",
-    .protocol_name          = "blkreplay",
     .instance_size          = 0,
 
-    .bdrv_file_open         = blkreplay_open,
+    .bdrv_open              = blkreplay_open,
     .bdrv_close             = blkreplay_close,
     .bdrv_child_perm        = bdrv_filter_default_perms,
     .bdrv_getlength         = blkreplay_getlength,
-- 
2.13.6
