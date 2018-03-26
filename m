Received: from eggs.gnu.org ([2001:4830:134:3::10]:45261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f0TEJ-0002ua-Pf
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f0TEI-0003mT-T5
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:36:11 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 26 Mar 2018 16:35:44 +0200
Message-Id: <20180326143600.7724-4-kwolf@redhat.com>
In-Reply-To: <20180326143600.7724-1-kwolf@redhat.com>
References: <20180326143600.7724-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 03/19] block/quorum: Remove protocol-related
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

The quorum driver is not a protocol so it should implement bdrv_open
instead of bdrv_file_open and not provide a protocol_name.

Attempts to invoke this driver using protocol syntax
(i.e. quorum:<filename:options:...>) will now fail gracefully:

  $ qemu-img info quorum:foo
  qemu-img: Could not open 'quorum:foo': Unknown protocol 'quorum'

Signed-off-by: Fabiano Rosas <farosas@linux.vnet.ibm.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/quorum.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/quorum.c b/block/quorum.c
index 14333c18aa..cfe484a945 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1098,11 +1098,10 @@ static void quorum_refresh_filename(BlockDriverState *bs, QDict *options)
 
 static BlockDriver bdrv_quorum = {
     .format_name                        = "quorum",
-    .protocol_name                      = "quorum",
 
     .instance_size                      = sizeof(BDRVQuorumState),
 
-    .bdrv_file_open                     = quorum_open,
+    .bdrv_open                          = quorum_open,
     .bdrv_close                         = quorum_close,
     .bdrv_refresh_filename              = quorum_refresh_filename,
 
-- 
2.13.6
