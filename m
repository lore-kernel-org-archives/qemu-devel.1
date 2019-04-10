Received: from eggs.gnu.org ([209.51.188.92]:42697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEKHk-0000hS-Dk
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:57:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEKHj-0008Ap-Hh
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:57:32 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 10 Apr 2019 22:57:13 +0200
Message-Id: <20190410205715.2209-5-mreitz@redhat.com>
In-Reply-To: <20190410205715.2209-1-mreitz@redhat.com>
References: <20190410205715.2209-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 4/6] blkdebug: Add "none" event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Together with @iotypes and @sector, this can be used to trap e.g. the
first read or write access to a certain sector without having to know
what happens internally in the block layer, i.e. which "real" events
happen right before such an access.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json | 4 +++-
 block/blkdebug.c     | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5141e91172..717b13f7f5 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3215,6 +3215,8 @@
 #
 # @cor_write: a write due to copy-on-read (since 2.11)
 #
+# @none: triggers once at creation of the blkdebug node (since 4.1)
+#
 # Since: 2.9
 ##
 { 'enum': 'BlkdebugEvent', 'prefix': 'BLKDBG',
@@ -3233,7 +3235,7 @@
             'pwritev_rmw_tail', 'pwritev_rmw_after_tail', 'pwritev',
             'pwritev_zero', 'pwritev_done', 'empty_image_prepare',
             'l1_shrink_write_table', 'l1_shrink_free_l2_clusters',
-            'cor_write'] }
+            'cor_write', 'none' ] }
=20
 ##
 # @BlkdebugIOType:
diff --git a/block/blkdebug.c b/block/blkdebug.c
index ca84b12e32..69c608be6f 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -491,6 +491,8 @@ static int blkdebug_open(BlockDriverState *bs, QDict =
*options, int flags,
         goto out;
     }
=20
+    bdrv_debug_event(bs, BLKDBG_NONE);
+
     ret =3D 0;
 out:
     if (ret < 0) {
--=20
2.20.1
