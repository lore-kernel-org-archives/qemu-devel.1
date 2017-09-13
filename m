Received: from eggs.gnu.org ([2001:4830:134:3::10]:37549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dsCI1-0000pK-N4
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:21:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dsCI0-00069F-R8
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:21:33 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 13 Sep 2017 20:19:05 +0200
Message-Id: <20170913181910.29688-14-mreitz@redhat.com>
In-Reply-To: <20170913181910.29688-1-mreitz@redhat.com>
References: <20170913181910.29688-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 13/18] block/mirror: Keep write perm for
 pending writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

The owner of the mirror BDS might retire its write permission; but there
may still be pending mirror operations so the mirror BDS cannot
necessarily retire its write permission for its child then.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 05410c94ca..612fab660e 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1236,6 +1236,7 @@ static void bdrv_mirror_top_child_perm(BlockDriverState *bs, BdrvChild *c,
                                        uint64_t *nperm, uint64_t *nshared)
 {
     MirrorBDSOpaque *s = bs->opaque;
+    bool ops_in_flight = s->job && !QTAILQ_EMPTY(&s->job->ops_in_flight);
 
     if (s->job && s->job->exiting) {
         *nperm = 0;
@@ -1243,9 +1244,10 @@ static void bdrv_mirror_top_child_perm(BlockDriverState *bs, BdrvChild *c,
         return;
     }
 
-    /* Must be able to forward guest writes to the real image */
+    /* Must be able to forward both new and pending guest writes to
+     * the real image */
     *nperm = 0;
-    if (perm & BLK_PERM_WRITE) {
+    if ((perm & BLK_PERM_WRITE) || ops_in_flight) {
         *nperm |= BLK_PERM_WRITE;
     }
 
-- 
2.13.5
