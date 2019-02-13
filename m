Received: from eggs.gnu.org ([209.51.188.92]:37764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gu3Pn-0004k0-Ny
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 17:54:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gu3PH-0006C8-Ja
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 17:53:32 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 13 Feb 2019 23:53:05 +0100
Message-Id: <20190213225311.17876-7-mreitz@redhat.com>
In-Reply-To: <20190213225311.17876-1-mreitz@redhat.com>
References: <20190213225311.17876-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 06/12] block: Fix check_to_replace_node()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

Currently, check_to_replace_node() only allows mirror to replace a node
in the chain of the source node, and only if it is the first non-filter
node below the source.  Well, technically, the idea is that you can
exactly replace a quorum child by mirroring from quorum.

This has (probably) two reasons:
(1) We do not want to create loops.
(2) @replaces and @device should have exactly the same content so
    replacing them does not cause visible data to change.

This has two issues:
(1) It is overly restrictive.  It is completely fine for @replaces to be
    a filter.
(2) It is not restrictive enough.  You can create loops with this as
    follows:

$ qemu-img create -f qcow2 /tmp/source.qcow2 64M
$ qemu-system-x86_64 -qmp stdio
{"execute": "qmp_capabilities"}
{"execute": "object-add",
 "arguments": {"qom-type": "throttle-group", "id": "tg0"}}
{"execute": "blockdev-add",
 "arguments": {
     "node-name": "source",
     "driver": "throttle",
     "throttle-group": "tg0",
     "file": {
         "node-name": "filtered",
         "driver": "qcow2",
         "file": {
             "driver": "file",
             "filename": "/tmp/source.qcow2"
         } } } }
{"execute": "drive-mirror",
 "arguments": {
     "job-id": "mirror",
     "device": "source",
     "target": "/tmp/target.qcow2",
     "format": "qcow2",
     "node-name": "target",
     "sync" :"none",
     "replaces": "filtered"
 } }
{"execute": "block-job-complete", "arguments": {"device": "mirror"}}

And qemu crashes because of a stack overflow due to the loop being
created (target's backing file is source, so when it replaces filtered,
it points to itself through source).

(blockdev-mirror can be broken similarly.)

So let us make the checks for the two conditions above explicit, which
makes the whole function exactly as restrictive as it needs to be.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h |  1 +
 block.c               | 83 +++++++++++++++++++++++++++++++++++++++----
 blockdev.c            | 34 ++++++++++++++++--
 3 files changed, 110 insertions(+), 8 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index c97b330e10..3b831f244a 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -388,6 +388,7 @@ bool bdrv_is_first_non_filter(BlockDriverState *candi=
date);
=20
 /* check if a named node can be replaced when doing drive-mirror */
 BlockDriverState *check_to_replace_node(BlockDriverState *parent_bs,
+                                        BlockDriverState *backing_bs,
                                         const char *node_name, Error **e=
rrp);
=20
 /* async block I/O */
diff --git a/block.c b/block.c
index 2bdef60370..bf7cc4705e 100644
--- a/block.c
+++ b/block.c
@@ -5478,7 +5478,59 @@ bool bdrv_is_first_non_filter(BlockDriverState *ca=
ndidate)
     return false;
 }
=20
+static bool is_child_of(BlockDriverState *child, BlockDriverState *paren=
t)
+{
+    BdrvChild *c;
+
+    if (!parent) {
+        return false;
+    }
+
+    QLIST_FOREACH(c, &parent->children, next) {
+        if (c->bs =3D=3D child || is_child_of(child, c->bs)) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
+/*
+ * Return true if there are only filters in [@top, @base).  Note that
+ * this may include quorum (which bdrv_chain_contains() cannot
+ * handle).
+ */
+static bool is_filtered_child(BlockDriverState *top, BlockDriverState *b=
ase)
+{
+    BdrvChild *c;
+
+    if (!top) {
+        return false;
+    }
+
+    if (top =3D=3D base) {
+        return true;
+    }
+
+    if (!top->drv->is_filter) {
+        return false;
+    }
+
+    QLIST_FOREACH(c, &top->children, next) {
+        if (is_filtered_child(c->bs, base)) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
+/*
+ * @parent_bs is mirror's source BDS, @backing_bs is the BDS which
+ * will be attached to the target when mirror completes.
+ */
 BlockDriverState *check_to_replace_node(BlockDriverState *parent_bs,
+                                        BlockDriverState *backing_bs,
                                         const char *node_name, Error **e=
rrp)
 {
     BlockDriverState *to_replace_bs =3D bdrv_find_node(node_name);
@@ -5497,13 +5549,32 @@ BlockDriverState *check_to_replace_node(BlockDriv=
erState *parent_bs,
         goto out;
     }
=20
-    /* We don't want arbitrary node of the BDS chain to be replaced only=
 the top
-     * most non filter in order to prevent data corruption.
-     * Another benefit is that this tests exclude backing files which ar=
e
-     * blocked by the backing blockers.
+    /*
+     * If to_replace_bs is (recursively) a child of backing_bs,
+     * replacing it may create a loop.  We cannot allow that.
      */
-    if (!bdrv_recurse_is_first_non_filter(parent_bs, to_replace_bs)) {
-        error_setg(errp, "Only top most non filter can be replaced");
+    if (to_replace_bs =3D=3D backing_bs || is_child_of(to_replace_bs, ba=
cking_bs)) {
+        error_setg(errp, "Replacing this node would result in a loop");
+        to_replace_bs =3D NULL;
+        goto out;
+    }
+
+    /*
+     * Mirror is designed in such a way that when it completes, the
+     * source BDS is seamlessly replaced.  It is therefore not allowed
+     * to replace a BDS where this condition would be violated, as that
+     * would defeat the purpose of mirror and could lead to data
+     * corruption.
+     * Therefore, between parent_bs and to_replace_bs there may be
+     * only filters (and the one on top must be a filter, too), so
+     * their data always stays in sync and mirror can complete and
+     * replace to_replace_bs without any possible corruptions.
+     */
+    if (!is_filtered_child(parent_bs, to_replace_bs) &&
+        !is_filtered_child(to_replace_bs, parent_bs))
+    {
+        error_setg(errp, "The node to be replaced must be connected to t=
he "
+                   "source through filter nodes only");
         to_replace_bs =3D NULL;
         goto out;
     }
diff --git a/blockdev.c b/blockdev.c
index cd7b536519..e620ea814b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3797,7 +3797,7 @@ static void blockdev_mirror_common(const char *job_=
id, BlockDriverState *bs,
     }
=20
     if (has_replaces) {
-        BlockDriverState *to_replace_bs;
+        BlockDriverState *to_replace_bs, *backing_bs;
         AioContext *replace_aio_context;
         int64_t bs_size, replace_size;
=20
@@ -3807,7 +3807,37 @@ static void blockdev_mirror_common(const char *job=
_id, BlockDriverState *bs,
             return;
         }
=20
-        to_replace_bs =3D check_to_replace_node(bs, replaces, errp);
+        if (backing_mode =3D=3D MIRROR_SOURCE_BACKING_CHAIN ||
+            backing_mode =3D=3D MIRROR_OPEN_BACKING_CHAIN)
+        {
+            /*
+             * While we do not quite know what OPEN_BACKING_CHAIN
+             * (used for mode=3Dexisting) will yield, it is probably
+             * best to restrict it exactly like SOURCE_BACKING_CHAIN,
+             * because that is our best guess.
+             */
+            switch (sync) {
+            case MIRROR_SYNC_MODE_FULL:
+                backing_bs =3D NULL;
+                break;
+
+            case MIRROR_SYNC_MODE_TOP:
+                backing_bs =3D bdrv_filtered_cow_bs(bdrv_skip_rw_filters=
(bs));
+                break;
+
+            case MIRROR_SYNC_MODE_NONE:
+                backing_bs =3D bs;
+                break;
+
+            default:
+                abort();
+            }
+        } else {
+            assert(backing_mode =3D=3D MIRROR_LEAVE_BACKING_CHAIN);
+            backing_bs =3D bdrv_filtered_cow_bs(bdrv_skip_rw_filters(tar=
get));
+        }
+
+        to_replace_bs =3D check_to_replace_node(bs, backing_bs, replaces=
, errp);
         if (!to_replace_bs) {
             return;
         }
--=20
2.20.1
