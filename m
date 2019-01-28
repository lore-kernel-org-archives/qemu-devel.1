Received: from eggs.gnu.org ([209.51.188.92]:53365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <antonkuchin@yandex-team.ru>) id 1go8dZ-0005Ji-Ac
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:15:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <antonkuchin@yandex-team.ru>) id 1go8dX-0004FZ-CT
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:15:49 -0500
From: Anton Kuchin <antonkuchin@yandex-team.ru>
Date: Mon, 28 Jan 2019 18:15:21 +0300
Message-Id: <20190128151521.13875-1-antonkuchin@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] qmp: Deprecate query-nodes option of
 query-blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, libvir-list@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Evgeny Yakovlev <wrfsh@yandex-team.ru>, Anton Kuchin <antonkuchin@yandex-team.ru>

This option is broken since a6baa60807 in v2.9 and returns mostly
zeroes instead of real stats because actual querring of BlockStats
that resides in blk is missing.

And it makes no sense because with this option BlockDriverState-s
are iterated but BlockAcctStats belong to BlockBackend and not BDS
since 7f0e9da6f13 in v2.5

Signed-off-by: Anton Kuchin <antonkuchin@yandex-team.ru>
---
 block/qapi.c         | 26 +++++++-------------------
 qapi/block-core.json |  8 +-------
 qemu-deprecated.texi |  5 +++++
 3 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index c66f949db8..19d4b4ee42 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -502,8 +502,7 @@ static void bdrv_query_blk_stats(BlockDeviceStats *ds=
, BlockBackend *blk)
                                  &ds->x_flush_latency_histogram);
 }
=20
-static BlockStats *bdrv_query_bds_stats(BlockDriverState *bs,
-                                        bool blk_level)
+static BlockStats *bdrv_query_bds_stats(BlockDriverState *bs)
 {
     BlockStats *s =3D NULL;
=20
@@ -517,7 +516,7 @@ static BlockStats *bdrv_query_bds_stats(BlockDriverSt=
ate *bs,
     /* Skip automatically inserted nodes that the user isn't aware of in
      * a BlockBackend-level command. Stay at the exact node for a node-l=
evel
      * command. */
-    while (blk_level && bs->drv && bs->implicit) {
+    while (bs->drv && bs->implicit) {
         bs =3D backing_bs(bs);
         assert(bs);
     }
@@ -531,12 +530,12 @@ static BlockStats *bdrv_query_bds_stats(BlockDriver=
State *bs,
=20
     if (bs->file) {
         s->has_parent =3D true;
-        s->parent =3D bdrv_query_bds_stats(bs->file->bs, blk_level);
+        s->parent =3D bdrv_query_bds_stats(bs->file->bs);
     }
=20
-    if (blk_level && bs->backing) {
+    if (bs->backing) {
         s->has_backing =3D true;
-        s->backing =3D bdrv_query_bds_stats(bs->backing->bs, blk_level);
+        s->backing =3D bdrv_query_bds_stats(bs->backing->bs);
     }
=20
     return s;
@@ -577,21 +576,10 @@ BlockStatsList *qmp_query_blockstats(bool has_query=
_nodes,
 {
     BlockStatsList *head =3D NULL, **p_next =3D &head;
     BlockBackend *blk;
-    BlockDriverState *bs;
=20
     /* Just to be safe if query_nodes is not always initialized */
     if (has_query_nodes && query_nodes) {
-        for (bs =3D bdrv_next_node(NULL); bs; bs =3D bdrv_next_node(bs))=
 {
-            BlockStatsList *info =3D g_malloc0(sizeof(*info));
-            AioContext *ctx =3D bdrv_get_aio_context(bs);
-
-            aio_context_acquire(ctx);
-            info->value =3D bdrv_query_bds_stats(bs, false);
-            aio_context_release(ctx);
-
-            *p_next =3D info;
-            p_next =3D &info->next;
-        }
+        error_setg(errp, "Option query_nodes is deprecated");
     } else {
         for (blk =3D blk_all_next(NULL); blk; blk =3D blk_all_next(blk))=
 {
             BlockStatsList *info;
@@ -604,7 +592,7 @@ BlockStatsList *qmp_query_blockstats(bool has_query_n=
odes,
             }
=20
             aio_context_acquire(ctx);
-            s =3D bdrv_query_bds_stats(blk_bs(blk), true);
+            s =3D bdrv_query_bds_stats(blk_bs(blk));
             s->has_device =3D true;
             s->device =3D g_strdup(blk_name(blk));
=20
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 91685be6c2..2dd5f6032c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -892,13 +892,7 @@
 #
 # Query the @BlockStats for all virtual block devices.
 #
-# @query-nodes: If true, the command will query all the block nodes
-#               that have a node name, in a list which will include "par=
ent"
-#               information, but not "backing".
-#               If false or omitted, the behavior is as before - query a=
ll the
-#               device backends, recursively including their "parent" an=
d
-#               "backing". Filter nodes that were created implicitly are
-#               skipped over in this mode. (Since 2.3)
+# @query-nodes: deprecated since 3.2
 #
 # Returns: A list of @BlockStats for each virtual block devices.
 #
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 219206a836..e1e04ced7d 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -112,6 +112,11 @@ Use ``device_add'' for hotplugging vCPUs instead of =
``cpu-add''.  See
 documentation of ``query-hotpluggable-cpus'' for additional
 details.
=20
+@subsection query-blockstats (since 3.2)
+
+"query-nodes" parameter is not supported anymore because blockstats
+are not a prorerty of node.
+
 @section Human Monitor Protocol (HMP) commands
=20
 @subsection The hub_id parameter of 'hostfwd_add' / 'hostfwd_remove' (si=
nce 3.1)
--=20
2.19.1
