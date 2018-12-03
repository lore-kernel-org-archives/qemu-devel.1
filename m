Received: from eggs.gnu.org ([2001:4830:134:3::10]:45049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gTsOd-0006NM-1G
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:52:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gTsOa-0007T5-Fl
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:52:38 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  3 Dec 2018 18:52:09 +0100
Message-Id: <20181203175211.8230-5-mreitz@redhat.com>
In-Reply-To: <20181203175211.8230-1-mreitz@redhat.com>
References: <20181203175211.8230-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-next 4/6] blkdebug: Add "none" event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

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
index 469d889753..045206196b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3004,6 +3004,8 @@
 #
 # @cor_write: a write due to copy-on-read (since 2.11)
 #
+# @none: triggers once at creation of the blkdebug node (since 4.0)
+#
 # Since: 2.9
 ##
 { 'enum': 'BlkdebugEvent', 'prefix': 'BLKDBG',
@@ -3022,7 +3024,7 @@
             'pwritev_rmw_tail', 'pwritev_rmw_after_tail', 'pwritev',
             'pwritev_zero', 'pwritev_done', 'empty_image_prepare',
             'l1_shrink_write_table', 'l1_shrink_free_l2_clusters',
-            'cor_write'] }
+            'cor_write', 'none' ] }
=20
 ##
 # @BlkdebugIOType:
diff --git a/block/blkdebug.c b/block/blkdebug.c
index d15b6c5fef..51f07648ba 100644
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
2.19.2
