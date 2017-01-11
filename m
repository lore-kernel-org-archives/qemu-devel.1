Received: from eggs.gnu.org ([2001:4830:134:3::10]:51420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cRNQ4-00049V-0h
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 13:14:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cRNQ3-0008R7-65
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 13:14:44 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 11 Jan 2017 19:14:08 +0100
Message-Id: <20170111181432.18868-2-mreitz@redhat.com>
In-Reply-To: <20170111181432.18868-1-mreitz@redhat.com>
References: <20170111181432.18868-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 01/25] block/mirror: Small absolute-paths
 simplification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

When invoking drive-mirror in absolute-paths mode, the target's backing
BDS is assigned to it in mirror_complete(). The current logic only does
so if the target does not have that backing BDS already; but it actually
cannot have a backing BDS at all (the BDS is opened with O_NO_BACKING in
qmp_drive_mirror()), so just assert that and assign the new backing BDS
unconditionally.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/mirror.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 301ba9219a..4ece624549 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -888,9 +888,9 @@ static void mirror_complete(BlockJob *job, Error **errp)
 
     if (s->backing_mode == MIRROR_SOURCE_BACKING_CHAIN) {
         BlockDriverState *backing = s->is_none_mode ? src : s->base;
-        if (backing_bs(target) != backing) {
-            bdrv_set_backing_hd(target, backing);
-        }
+
+        assert(!target->backing);
+        bdrv_set_backing_hd(target, backing);
     }
 
     s->should_complete = true;
-- 
2.11.0
