Received: from eggs.gnu.org ([2001:4830:134:3::10]:46808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0R7G-0002Mh-6x
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:53:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0R7F-0001uP-F7
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:53:02 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 13 Sep 2018 14:52:09 +0200
Message-Id: <20180913125217.23173-10-kwolf@redhat.com>
In-Reply-To: <20180913125217.23173-1-kwolf@redhat.com>
References: <20180913125217.23173-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 09/17] block-backend: Add .drained_poll
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org

A bdrv_drain operation must ensure that all parents are quiesced, this
includes BlockBackends. Otherwise, callbacks called by requests that are
completed on the BDS layer, but not quite yet on the BlockBackend layer
could still create new requests.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 block/block-backend.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index fa120630be..efa8d8011c 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -121,6 +121,7 @@ static void blk_root_inherit_options(int *child_flags, QDict *child_options,
     abort();
 }
 static void blk_root_drained_begin(BdrvChild *child);
+static bool blk_root_drained_poll(BdrvChild *child);
 static void blk_root_drained_end(BdrvChild *child);
 
 static void blk_root_change_media(BdrvChild *child, bool load);
@@ -294,6 +295,7 @@ static const BdrvChildRole child_root = {
     .get_parent_desc    = blk_root_get_parent_desc,
 
     .drained_begin      = blk_root_drained_begin,
+    .drained_poll       = blk_root_drained_poll,
     .drained_end        = blk_root_drained_end,
 
     .activate           = blk_root_activate,
@@ -2191,6 +2193,13 @@ static void blk_root_drained_begin(BdrvChild *child)
     }
 }
 
+static bool blk_root_drained_poll(BdrvChild *child)
+{
+    BlockBackend *blk = child->opaque;
+    assert(blk->quiesce_counter);
+    return !!blk->in_flight;
+}
+
 static void blk_root_drained_end(BdrvChild *child)
 {
     BlockBackend *blk = child->opaque;
-- 
2.13.6
