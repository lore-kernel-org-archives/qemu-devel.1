Received: from eggs.gnu.org ([2001:4830:134:3::10]:45471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f0TES-00033Y-96
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:36:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f0TER-00043z-AM
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:36:20 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 26 Mar 2018 16:35:45 +0200
Message-Id: <20180326143600.7724-5-kwolf@redhat.com>
In-Reply-To: <20180326143600.7724-1-kwolf@redhat.com>
References: <20180326143600.7724-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 04/19] block/throttle: Remove protocol-related
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

The throttle driver is not a protocol so it should implement bdrv_open
instead of bdrv_file_open and not provide a protocol_name.

Attempts to invoke this driver using protocol syntax
(i.e. throttle:<filename:options:...>) will now fail gracefully:

  $ qemu-img info throttle:foo
  qemu-img: Could not open 'throttle:foo': Unknown protocol 'throttle'

Signed-off-by: Fabiano Rosas <farosas@linux.vnet.ibm.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/throttle.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/throttle.c b/block/throttle.c
index 5f4d43d0fc..95ed06acd8 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -215,10 +215,9 @@ static void coroutine_fn throttle_co_drain_end(BlockDriverState *bs)
 
 static BlockDriver bdrv_throttle = {
     .format_name                        =   "throttle",
-    .protocol_name                      =   "throttle",
     .instance_size                      =   sizeof(ThrottleGroupMember),
 
-    .bdrv_file_open                     =   throttle_open,
+    .bdrv_open                          =   throttle_open,
     .bdrv_close                         =   throttle_close,
     .bdrv_co_flush                      =   throttle_co_flush,
 
-- 
2.13.6
