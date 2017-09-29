Received: from eggs.gnu.org ([2001:4830:134:3::10]:46653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxyY6-0000NK-Nu
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 12:54:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxyY5-0002dI-SA
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 12:54:02 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 29 Sep 2017 18:53:23 +0200
Message-Id: <20170929165347.29658-2-mreitz@redhat.com>
In-Reply-To: <20170929165347.29658-1-mreitz@redhat.com>
References: <20170929165347.29658-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v6 01/25] block/mirror: Small absolute-paths
 simplification
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>
List-ID: <qemu-devel.nongnu.org>

When invoking drive-mirror in absolute-paths mode, the target's backing
BDS is assigned to it in mirror_exit(). The current logic only does so
if the target does not have that backing BDS already; but it actually
cannot have a backing BDS at all (the BDS is opened with O_NO_BACKING in
qmp_drive_mirror()), so just assert that and assign the new backing BDS
unconditionally.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/mirror.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 351b80ca2c..25e9354b4d 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -533,12 +533,12 @@ static void mirror_exit(BlockJob *job, void *opaque)
                             &error_abort);
     if (s->backing_mode == MIRROR_SOURCE_BACKING_CHAIN) {
         BlockDriverState *backing = s->is_none_mode ? src : s->base;
-        if (backing_bs(target_bs) != backing) {
-            bdrv_set_backing_hd(target_bs, backing, &local_err);
-            if (local_err) {
-                error_report_err(local_err);
-                data->ret = -EPERM;
-            }
+
+        assert(!target_bs->backing);
+        bdrv_set_backing_hd(target_bs, backing, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            data->ret = -EPERM;
         }
     }
 
-- 
2.13.6
