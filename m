Received: from eggs.gnu.org ([209.51.188.92]:42724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEKHm-0000jo-Lp
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:57:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEKHl-0008CU-Mj
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:57:34 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 10 Apr 2019 22:57:14 +0200
Message-Id: <20190410205715.2209-6-mreitz@redhat.com>
In-Reply-To: <20190410205715.2209-1-mreitz@redhat.com>
References: <20190410205715.2209-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 5/6] blkdebug: Inject errors on
 .bdrv_co_block_status()
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

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json | 5 ++++-
 block/blkdebug.c     | 8 ++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 717b13f7f5..2aa675a192 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3252,10 +3252,13 @@
 #
 # @flush: .bdrv_co_flush_to_disk()
 #
+# @block-status: .bdrv_co_block_status()
+#
 # Since: 4.1
 ##
 { 'enum': 'BlkdebugIOType',
-  'data': [ 'read', 'write', 'write-zeroes', 'discard', 'flush' ] }
+  'data': [ 'read', 'write', 'write-zeroes', 'discard', 'flush',
+            'block-status' ] }
=20
 ##
 # @BlkdebugInjectErrorOptions:
diff --git a/block/blkdebug.c b/block/blkdebug.c
index 69c608be6f..df9c8b1673 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -670,7 +670,15 @@ static int coroutine_fn blkdebug_co_block_status(Blo=
ckDriverState *bs,
                                                  int64_t *map,
                                                  BlockDriverState **file=
)
 {
+    int err;
+
     assert(QEMU_IS_ALIGNED(offset | bytes, bs->bl.request_alignment));
+
+    err =3D rule_check(bs, offset, bytes, BLKDEBUGIO_TYPE_BLOCK_STATUS);
+    if (err) {
+        return err;
+    }
+
     return bdrv_co_block_status_from_file(bs, want_zero, offset, bytes,
                                           pnum, map, file);
 }
--=20
2.20.1
