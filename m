Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DDBC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 20:28:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB03520830
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 20:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB03520830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37431 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEJpj-0005e1-Se
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 16:28:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEJib-00078i-Mp
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEJiW-0004Uq-N4
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:21:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hEJi8-0004FI-Ca; Wed, 10 Apr 2019 16:20:46 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5DCAE30B9318;
	Wed, 10 Apr 2019 20:20:43 +0000 (UTC)
Received: from localhost (unknown [10.40.205.69])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 465B419C65;
	Wed, 10 Apr 2019 20:20:40 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 10 Apr 2019 22:20:24 +0200
Message-Id: <20190410202033.28617-3-mreitz@redhat.com>
In-Reply-To: <20190410202033.28617-1-mreitz@redhat.com>
References: <20190410202033.28617-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Wed, 10 Apr 2019 20:20:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 02/11] block: Filtered children access
 functions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190410202024.5Ea3vFyNg-skyuzqVOTRiTHNgDl-DEZ4uhEmRuenXwo@z>

What bs->file and bs->backing mean depends on the node.  For filter
nodes, both signify a node that will eventually receive all R/W
accesses.  For format nodes, bs->file contains metadata and data, and
bs->backing will not receive writes -- instead, writes are COWed to
bs->file.  Usually.

In any case, it is not trivial to guess what a child means exactly with
our currently limited form of expression.  It is better to introduce
some functions that actually guarantee a meaning:

- bdrv_filtered_cow_child() will return the child that receives requests
  filtered through COW.  That is, reads may or may not be forwarded
  (depending on the overlay's allocation status), but writes never go to
  this child.

- bdrv_filtered_rw_child() will return the child that receives requests
  filtered through some very plain process.  Reads and writes issued to
  the parent will go to the child as well (although timing, etc. may be
  modified).

- All drivers but quorum (but quorum is pretty opaque to the general
  block layer anyway) always only have one of these children: All read
  requests must be served from the filtered_rw_child (if it exists), so
  if there was a filtered_cow_child in addition, it would not receive
  any requests at all.
  (The closest here is mirror, where all requests are passed on to the
  source, but with write-blocking, write requests are "COWed" to the
  target.  But that just means that the target is a special child that
  cannot be introspected by the generic block layer functions, and that
  source is a filtered_rw_child.)
  Therefore, we can also add bdrv_filtered_child() which returns that
  one child (or NULL, if there is no filtered child).

Also, many places in the current block layer should be skipping filters
(all filters or just the ones added implicitly, it depends) when going
through a block node chain.  They do not do that currently, but this
patch makes them.

One example for this is qemu-img map, which should skip filters and only
look at the COW elements in the graph.  The change to iotest 204's
reference output shows how using blkdebug on top of a COW node used to
make qemu-img map disregard the rest of the backing chain, but with this
patch, the allocation in the base image is reported correctly.

Furthermore, a note should be made that sometimes we do want to access
bs->backing directly.  This is whenever the operation in question is not
about accessing the COW child, but the "backing" child, be it COW or
not.  This is the case in functions such as bdrv_open_backing_file() or
whenever we have to deal with the special behavior of @backing as a
blockdev option, which is that it does not default to null like all
other child references do.

Finally, the query functions (query-block and query-named-block-nodes)
are modified to return any filtered child under "backing", not just
bs->backing or COW children.  This is so that filters do not interrupt
the reported backing chain.  This changes the output of iotest 184, as
the throttled node now appears as a backing child.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json           |   4 +
 include/block/block.h          |   1 +
 include/block/block_int.h      |  40 +++++--
 block.c                        | 210 +++++++++++++++++++++++++++------
 block/backup.c                 |   8 +-
 block/block-backend.c          |  16 ++-
 block/commit.c                 |  33 +++---
 block/io.c                     |  45 ++++---
 block/mirror.c                 |  21 ++--
 block/qapi.c                   |  30 +++--
 block/stream.c                 |  13 +-
 blockdev.c                     |  88 +++++++++++---
 migration/block-dirty-bitmap.c |   4 +-
 nbd/server.c                   |   6 +-
 qemu-img.c                     |  29 ++---
 tests/qemu-iotests/184.out     |   7 +-
 tests/qemu-iotests/204.out     |   1 +
 17 files changed, 411 insertions(+), 145 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7ccbfff9d0..dbd9286e4a 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2502,6 +2502,10 @@
 # On successful completion the image file is updated to drop the backing=
 file
 # and the BLOCK_JOB_COMPLETED event is emitted.
 #
+# In case @device is a filter node, block-stream modifies the first non-=
filter
+# overlay node below it to point to base's backing node (or NULL if @bas=
e was
+# not specified) instead of modifying @device itself.
+#
 # @job-id: identifier for the newly-created block job. If
 #          omitted, the device name will be used. (Since 2.7)
 #
diff --git a/include/block/block.h b/include/block/block.h
index c7a26199aa..2005664f14 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -467,6 +467,7 @@ BlockDriverState *bdrv_lookup_bs(const char *device,
                                  const char *node_name,
                                  Error **errp);
 bool bdrv_chain_contains(BlockDriverState *top, BlockDriverState *base);
+bool bdrv_legacy_chain_contains(BlockDriverState *top, BlockDriverState =
*base);
 BlockDriverState *bdrv_next_node(BlockDriverState *bs);
 BlockDriverState *bdrv_next_all_states(BlockDriverState *bs);
=20
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 01e855a066..b22b1164f8 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -90,9 +90,11 @@ struct BlockDriver {
     int instance_size;
=20
     /* set to true if the BlockDriver is a block filter. Block filters p=
ass
-     * certain callbacks that refer to data (see block.c) to their bs->f=
ile if
-     * the driver doesn't implement them. Drivers that do not wish to fo=
rward
-     * must implement them and return -ENOTSUP.
+     * certain callbacks that refer to data (see block.c) to their bs->f=
ile
+     * or bs->backing (whichever one exists) if the driver doesn't imple=
ment
+     * them. Drivers that do not wish to forward must implement them and=
 return
+     * -ENOTSUP.
+     * Note that filters are not allowed to modify data.
      */
     bool is_filter;
     /* for snapshots block filter like Quorum can implement the
@@ -906,11 +908,6 @@ typedef enum BlockMirrorBackingMode {
     MIRROR_LEAVE_BACKING_CHAIN,
 } BlockMirrorBackingMode;
=20
-static inline BlockDriverState *backing_bs(BlockDriverState *bs)
-{
-    return bs->backing ? bs->backing->bs : NULL;
-}
-
=20
 /* Essential block drivers which must always be statically linked into q=
emu, and
  * which therefore can be accessed without using bdrv_find_format() */
@@ -1243,4 +1240,31 @@ int coroutine_fn bdrv_co_copy_range_to(BdrvChild *=
src, uint64_t src_offset,
=20
 int refresh_total_sectors(BlockDriverState *bs, int64_t hint);
=20
+BdrvChild *bdrv_filtered_cow_child(BlockDriverState *bs);
+BdrvChild *bdrv_filtered_rw_child(BlockDriverState *bs);
+BdrvChild *bdrv_filtered_child(BlockDriverState *bs);
+BlockDriverState *bdrv_skip_implicit_filters(BlockDriverState *bs);
+BlockDriverState *bdrv_skip_rw_filters(BlockDriverState *bs);
+BlockDriverState *bdrv_backing_chain_next(BlockDriverState *bs);
+
+static inline BlockDriverState *child_bs(BdrvChild *child)
+{
+    return child ? child->bs : NULL;
+}
+
+static inline BlockDriverState *bdrv_filtered_cow_bs(BlockDriverState *b=
s)
+{
+    return child_bs(bdrv_filtered_cow_child(bs));
+}
+
+static inline BlockDriverState *bdrv_filtered_rw_bs(BlockDriverState *bs=
)
+{
+    return child_bs(bdrv_filtered_rw_child(bs));
+}
+
+static inline BlockDriverState *bdrv_filtered_bs(BlockDriverState *bs)
+{
+    return child_bs(bdrv_filtered_child(bs));
+}
+
 #endif /* BLOCK_INT_H */
diff --git a/block.c b/block.c
index 16615bc876..e8f6febda0 100644
--- a/block.c
+++ b/block.c
@@ -556,11 +556,12 @@ int bdrv_create_file(const char *filename, QemuOpts=
 *opts, Error **errp)
 int bdrv_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz)
 {
     BlockDriver *drv =3D bs->drv;
+    BlockDriverState *filtered =3D bdrv_filtered_rw_bs(bs);
=20
     if (drv && drv->bdrv_probe_blocksizes) {
         return drv->bdrv_probe_blocksizes(bs, bsz);
-    } else if (drv && drv->is_filter && bs->file) {
-        return bdrv_probe_blocksizes(bs->file->bs, bsz);
+    } else if (filtered) {
+        return bdrv_probe_blocksizes(filtered, bsz);
     }
=20
     return -ENOTSUP;
@@ -575,11 +576,12 @@ int bdrv_probe_blocksizes(BlockDriverState *bs, Blo=
ckSizes *bsz)
 int bdrv_probe_geometry(BlockDriverState *bs, HDGeometry *geo)
 {
     BlockDriver *drv =3D bs->drv;
+    BlockDriverState *filtered =3D bdrv_filtered_rw_bs(bs);
=20
     if (drv && drv->bdrv_probe_geometry) {
         return drv->bdrv_probe_geometry(bs, geo);
-    } else if (drv && drv->is_filter && bs->file) {
-        return bdrv_probe_geometry(bs->file->bs, geo);
+    } else if (filtered) {
+        return bdrv_probe_geometry(filtered, geo);
     }
=20
     return -ENOTSUP;
@@ -2336,7 +2338,7 @@ static bool bdrv_inherits_from_recursive(BlockDrive=
rState *child,
 }
=20
 /*
- * Sets the backing file link of a BDS. A new reference is created; call=
ers
+ * Sets the bs->backing link of a BDS. A new reference is created; calle=
rs
  * which don't need their own reference any more must call bdrv_unref().
  */
 void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing=
_hd,
@@ -2345,7 +2347,7 @@ void bdrv_set_backing_hd(BlockDriverState *bs, Bloc=
kDriverState *backing_hd,
     bool update_inherits_from =3D bdrv_chain_contains(bs, backing_hd) &&
         bdrv_inherits_from_recursive(backing_hd, bs);
=20
-    if (bdrv_is_backing_chain_frozen(bs, backing_bs(bs), errp)) {
+    if (bdrv_is_backing_chain_frozen(bs, child_bs(bs->backing), errp)) {
         return;
     }
=20
@@ -3467,14 +3469,17 @@ static int bdrv_reopen_parse_backing(BDRVReopenSt=
ate *reopen_state,
     /*
      * Find the "actual" backing file by skipping all links that point
      * to an implicit node, if any (e.g. a commit filter node).
+     * We cannot use any of the bdrv_skip_*() functions here because
+     * those return the first explicit node, while we are looking for
+     * its overlay here.
      */
     overlay_bs =3D bs;
-    while (backing_bs(overlay_bs) && backing_bs(overlay_bs)->implicit) {
-        overlay_bs =3D backing_bs(overlay_bs);
+    while (overlay_bs->backing && bdrv_filtered_bs(overlay_bs)->implicit=
) {
+        overlay_bs =3D bdrv_filtered_bs(overlay_bs);
     }
=20
     /* If we want to replace the backing file we need some extra checks =
*/
-    if (new_backing_bs !=3D backing_bs(overlay_bs)) {
+    if (new_backing_bs !=3D child_bs(overlay_bs->backing)) {
         /* Check for implicit nodes between bs and its backing file */
         if (bs !=3D overlay_bs) {
             error_setg(errp, "Cannot change backing link if '%s' has "
@@ -3482,8 +3487,8 @@ static int bdrv_reopen_parse_backing(BDRVReopenStat=
e *reopen_state,
             return -EPERM;
         }
         /* Check if the backing link that we want to replace is frozen *=
/
-        if (bdrv_is_backing_chain_frozen(overlay_bs, backing_bs(overlay_=
bs),
-                                         errp)) {
+        if (bdrv_is_backing_chain_frozen(overlay_bs,
+                                         child_bs(overlay_bs->backing), =
errp)) {
             return -EPERM;
         }
         reopen_state->replace_backing_bs =3D true;
@@ -3634,7 +3639,7 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_sta=
te, BlockReopenQueue *queue,
      * its metadata. Otherwise the 'backing' option can be omitted.
      */
     if (drv->supports_backing && reopen_state->backing_missing &&
-        (backing_bs(reopen_state->bs) || reopen_state->bs->backing_file[=
0])) {
+        (reopen_state->bs->backing || reopen_state->bs->backing_file[0])=
) {
         error_setg(errp, "backing is missing for '%s'",
                    reopen_state->bs->node_name);
         ret =3D -EINVAL;
@@ -3779,7 +3784,7 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_sta=
te)
      * from bdrv_set_backing_hd()) has the new values.
      */
     if (reopen_state->replace_backing_bs) {
-        BlockDriverState *old_backing_bs =3D backing_bs(bs);
+        BlockDriverState *old_backing_bs =3D child_bs(bs->backing);
         assert(!old_backing_bs || !old_backing_bs->implicit);
         /* Abort the permission update on the backing bs we're detaching=
 */
         if (old_backing_bs) {
@@ -4203,8 +4208,8 @@ int bdrv_change_backing_file(BlockDriverState *bs,
 BlockDriverState *bdrv_find_overlay(BlockDriverState *active,
                                     BlockDriverState *bs)
 {
-    while (active && bs !=3D backing_bs(active)) {
-        active =3D backing_bs(active);
+    while (active && bs !=3D bdrv_filtered_bs(active)) {
+        active =3D bdrv_filtered_bs(active);
     }
=20
     return active;
@@ -4226,11 +4231,11 @@ bool bdrv_is_backing_chain_frozen(BlockDriverStat=
e *bs, BlockDriverState *base,
 {
     BlockDriverState *i;
=20
-    for (i =3D bs; i !=3D base; i =3D backing_bs(i)) {
+    for (i =3D bs; i !=3D base; i =3D child_bs(i->backing)) {
         if (i->backing && i->backing->frozen) {
             error_setg(errp, "Cannot change '%s' link from '%s' to '%s'"=
,
                        i->backing->name, i->node_name,
-                       backing_bs(i)->node_name);
+                       i->backing->bs->node_name);
             return true;
         }
     }
@@ -4254,7 +4259,7 @@ int bdrv_freeze_backing_chain(BlockDriverState *bs,=
 BlockDriverState *base,
         return -EPERM;
     }
=20
-    for (i =3D bs; i !=3D base; i =3D backing_bs(i)) {
+    for (i =3D bs; i !=3D base; i =3D child_bs(i->backing)) {
         if (i->backing) {
             i->backing->frozen =3D true;
         }
@@ -4272,7 +4277,7 @@ void bdrv_unfreeze_backing_chain(BlockDriverState *=
bs, BlockDriverState *base)
 {
     BlockDriverState *i;
=20
-    for (i =3D bs; i !=3D base; i =3D backing_bs(i)) {
+    for (i =3D bs; i !=3D base; i =3D child_bs(i->backing)) {
         if (i->backing) {
             assert(i->backing->frozen);
             i->backing->frozen =3D false;
@@ -4342,9 +4347,7 @@ int bdrv_drop_intermediate(BlockDriverState *top, B=
lockDriverState *base,
      * other intermediate nodes have been dropped.
      * If 'top' is an implicit node (e.g. "commit_top") we should skip
      * it because no one inherits from it. We use explicit_top for that.=
 */
-    while (explicit_top && explicit_top->implicit) {
-        explicit_top =3D backing_bs(explicit_top);
-    }
+    explicit_top =3D bdrv_skip_implicit_filters(explicit_top);
     update_inherits_from =3D bdrv_inherits_from_recursive(base, explicit=
_top);
=20
     /* success - we can delete the intermediate states, and link top->ba=
se */
@@ -4494,10 +4497,14 @@ bool bdrv_is_sg(BlockDriverState *bs)
=20
 bool bdrv_is_encrypted(BlockDriverState *bs)
 {
-    if (bs->backing && bs->backing->bs->encrypted) {
+    BlockDriverState *filtered =3D bdrv_filtered_bs(bs);
+    if (bs->encrypted) {
+        return true;
+    }
+    if (filtered && bdrv_is_encrypted(filtered)) {
         return true;
     }
-    return bs->encrypted;
+    return false;
 }
=20
 const char *bdrv_get_format_name(BlockDriverState *bs)
@@ -4794,7 +4801,21 @@ BlockDriverState *bdrv_lookup_bs(const char *devic=
e,
 bool bdrv_chain_contains(BlockDriverState *top, BlockDriverState *base)
 {
     while (top && top !=3D base) {
-        top =3D backing_bs(top);
+        top =3D bdrv_filtered_bs(top);
+    }
+
+    return top !=3D NULL;
+}
+
+/*
+ * Same as bdrv_chain_contains(), but skip implicitly added R/W filter
+ * nodes and do not move past explicitly added R/W filters.
+ */
+bool bdrv_legacy_chain_contains(BlockDriverState *top, BlockDriverState =
*base)
+{
+    top =3D bdrv_skip_implicit_filters(top);
+    while (top && top !=3D base) {
+        top =3D bdrv_skip_implicit_filters(bdrv_filtered_cow_bs(top));
     }
=20
     return top !=3D NULL;
@@ -4866,20 +4887,24 @@ int bdrv_has_zero_init_1(BlockDriverState *bs)
=20
 int bdrv_has_zero_init(BlockDriverState *bs)
 {
+    BlockDriverState *filtered;
+
     if (!bs->drv) {
         return 0;
     }
=20
     /* If BS is a copy on write image, it is initialized to
        the contents of the base image, which may not be zeroes.  */
-    if (bs->backing) {
+    if (bdrv_filtered_cow_child(bs)) {
         return 0;
     }
     if (bs->drv->bdrv_has_zero_init) {
         return bs->drv->bdrv_has_zero_init(bs);
     }
-    if (bs->file && bs->drv->is_filter) {
-        return bdrv_has_zero_init(bs->file->bs);
+
+    filtered =3D bdrv_filtered_rw_bs(bs);
+    if (filtered) {
+        return bdrv_has_zero_init(filtered);
     }
=20
     /* safe default */
@@ -4890,7 +4915,7 @@ bool bdrv_unallocated_blocks_are_zero(BlockDriverSt=
ate *bs)
 {
     BlockDriverInfo bdi;
=20
-    if (bs->backing) {
+    if (bdrv_filtered_cow_child(bs)) {
         return false;
     }
=20
@@ -4924,8 +4949,9 @@ int bdrv_get_info(BlockDriverState *bs, BlockDriver=
Info *bdi)
         return -ENOMEDIUM;
     }
     if (!drv->bdrv_get_info) {
-        if (bs->file && drv->is_filter) {
-            return bdrv_get_info(bs->file->bs, bdi);
+        BlockDriverState *filtered =3D bdrv_filtered_rw_bs(bs);
+        if (filtered) {
+            return bdrv_get_info(filtered, bdi);
         }
         return -ENOTSUP;
     }
@@ -5028,7 +5054,17 @@ BlockDriverState *bdrv_find_backing_image(BlockDri=
verState *bs,
=20
     is_protocol =3D path_has_protocol(backing_file);
=20
-    for (curr_bs =3D bs; curr_bs->backing; curr_bs =3D curr_bs->backing-=
>bs) {
+    /*
+     * Being largely a legacy function, skip any filters here
+     * (because filters do not have normal filenames, so they cannot
+     * match anyway; and allowing json:{} filenames is a bit out of
+     * scope).
+     */
+    for (curr_bs =3D bdrv_skip_rw_filters(bs);
+         bdrv_filtered_cow_child(curr_bs) !=3D NULL;
+         curr_bs =3D bdrv_backing_chain_next(curr_bs))
+    {
+        BlockDriverState *bs_below =3D bdrv_backing_chain_next(curr_bs);
=20
         /* If either of the filename paths is actually a protocol, then
          * compare unmodified paths; otherwise make paths relative */
@@ -5036,7 +5072,7 @@ BlockDriverState *bdrv_find_backing_image(BlockDriv=
erState *bs,
             char *backing_file_full_ret;
=20
             if (strcmp(backing_file, curr_bs->backing_file) =3D=3D 0) {
-                retval =3D curr_bs->backing->bs;
+                retval =3D bs_below;
                 break;
             }
             /* Also check against the full backing filename for the imag=
e */
@@ -5046,7 +5082,7 @@ BlockDriverState *bdrv_find_backing_image(BlockDriv=
erState *bs,
                 bool equal =3D strcmp(backing_file, backing_file_full_re=
t) =3D=3D 0;
                 g_free(backing_file_full_ret);
                 if (equal) {
-                    retval =3D curr_bs->backing->bs;
+                    retval =3D bs_below;
                     break;
                 }
             }
@@ -5072,7 +5108,7 @@ BlockDriverState *bdrv_find_backing_image(BlockDriv=
erState *bs,
             g_free(filename_tmp);
=20
             if (strcmp(backing_file_full, filename_full) =3D=3D 0) {
-                retval =3D curr_bs->backing->bs;
+                retval =3D bs_below;
                 break;
             }
         }
@@ -6237,3 +6273,107 @@ bool bdrv_can_store_new_dirty_bitmap(BlockDriverS=
tate *bs, const char *name,
=20
     return drv->bdrv_can_store_new_dirty_bitmap(bs, name, granularity, e=
rrp);
 }
+
+/*
+ * Return the child that @bs acts as an overlay for, and from which data=
 may be
+ * copied in COW or COR operations.  Usually this is the backing file.
+ */
+BdrvChild *bdrv_filtered_cow_child(BlockDriverState *bs)
+{
+    if (!bs || !bs->drv) {
+        return NULL;
+    }
+
+    if (bs->drv->is_filter) {
+        return NULL;
+    }
+
+    return bs->backing;
+}
+
+/*
+ * If @bs acts as a pass-through filter for one of its children,
+ * return that child.  "Pass-through" means that write operations to
+ * @bs are forwarded to that child instead of triggering COW.
+ */
+BdrvChild *bdrv_filtered_rw_child(BlockDriverState *bs)
+{
+    if (!bs || !bs->drv) {
+        return NULL;
+    }
+
+    if (!bs->drv->is_filter) {
+        return NULL;
+    }
+
+    return bs->backing ?: bs->file;
+}
+
+/*
+ * Return any filtered child, independently of how it reacts to write
+ * accesses and whether data is copied onto this BDS through COR.
+ */
+BdrvChild *bdrv_filtered_child(BlockDriverState *bs)
+{
+    BdrvChild *cow_child =3D bdrv_filtered_cow_child(bs);
+    BdrvChild *rw_child =3D bdrv_filtered_rw_child(bs);
+
+    /* There can only be one filtered child at a time */
+    assert(!(cow_child && rw_child));
+
+    return cow_child ?: rw_child;
+}
+
+static BlockDriverState *bdrv_skip_filters(BlockDriverState *bs,
+                                           bool stop_on_explicit_filter)
+{
+    BdrvChild *filtered;
+
+    if (!bs) {
+        return NULL;
+    }
+
+    while (!(stop_on_explicit_filter && !bs->implicit)) {
+        filtered =3D bdrv_filtered_rw_child(bs);
+        if (!filtered) {
+            break;
+        }
+        bs =3D filtered->bs;
+    }
+    /*
+     * Note that this treats nodes with bs->drv =3D=3D NULL as not being
+     * R/W filters (bs->drv =3D=3D NULL should be replaced by something
+     * else anyway).
+     * The advantage of this behavior is that this function will thus
+     * always return a non-NULL value (given a non-NULL @bs).
+     */
+
+    return bs;
+}
+
+/*
+ * Return the first BDS that has not been added implicitly or that
+ * does not have an RW-filtered child down the chain starting from @bs
+ * (including @bs itself).
+ */
+BlockDriverState *bdrv_skip_implicit_filters(BlockDriverState *bs)
+{
+    return bdrv_skip_filters(bs, true);
+}
+
+/*
+ * Return the first BDS that does not have an RW-filtered child down
+ * the chain starting from @bs (including @bs itself).
+ */
+BlockDriverState *bdrv_skip_rw_filters(BlockDriverState *bs)
+{
+    return bdrv_skip_filters(bs, false);
+}
+
+/*
+ * For a backing chain, return the first non-filter backing image.
+ */
+BlockDriverState *bdrv_backing_chain_next(BlockDriverState *bs)
+{
+    return bdrv_skip_rw_filters(bdrv_filtered_cow_bs(bdrv_skip_rw_filter=
s(bs)));
+}
diff --git a/block/backup.c b/block/backup.c
index 9988753249..9c08353b23 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -577,6 +577,7 @@ BlockJob *backup_job_create(const char *job_id, Block=
DriverState *bs,
     int64_t len;
     BlockDriverInfo bdi;
     BackupBlockJob *job =3D NULL;
+    bool target_does_cow;
     int ret;
=20
     assert(bs);
@@ -671,8 +672,9 @@ BlockJob *backup_job_create(const char *job_id, Block=
DriverState *bs,
     /* If there is no backing file on the target, we cannot rely on COW =
if our
      * backup cluster size is smaller than the target cluster size. Even=
 for
      * targets with a backing file, try to avoid COW if possible. */
+    target_does_cow =3D bdrv_filtered_cow_child(target);
     ret =3D bdrv_get_info(target, &bdi);
-    if (ret =3D=3D -ENOTSUP && !target->backing) {
+    if (ret =3D=3D -ENOTSUP && !target_does_cow) {
         /* Cluster size is not defined */
         warn_report("The target block device doesn't provide "
                     "information about the block size and it doesn't hav=
e a "
@@ -681,14 +683,14 @@ BlockJob *backup_job_create(const char *job_id, Blo=
ckDriverState *bs,
                     "this default, the backup may be unusable",
                     BACKUP_CLUSTER_SIZE_DEFAULT);
         job->cluster_size =3D BACKUP_CLUSTER_SIZE_DEFAULT;
-    } else if (ret < 0 && !target->backing) {
+    } else if (ret < 0 && !target_does_cow) {
         error_setg_errno(errp, -ret,
             "Couldn't determine the cluster size of the target image, "
             "which has no backing file");
         error_append_hint(errp,
             "Aborting, since this may create an unusable destination ima=
ge\n");
         goto error;
-    } else if (ret < 0 && target->backing) {
+    } else if (ret < 0 && target_does_cow) {
         /* Not fatal; just trudge on ahead. */
         job->cluster_size =3D BACKUP_CLUSTER_SIZE_DEFAULT;
     } else {
diff --git a/block/block-backend.c b/block/block-backend.c
index f78e82a707..aa9a1d84a6 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2089,11 +2089,17 @@ int blk_commit_all(void)
         AioContext *aio_context =3D blk_get_aio_context(blk);
=20
         aio_context_acquire(aio_context);
-        if (blk_is_inserted(blk) && blk->root->bs->backing) {
-            int ret =3D bdrv_commit(blk->root->bs);
-            if (ret < 0) {
-                aio_context_release(aio_context);
-                return ret;
+        if (blk_is_inserted(blk)) {
+            BlockDriverState *non_filter;
+
+            /* Legacy function, so skip implicit filters */
+            non_filter =3D bdrv_skip_implicit_filters(blk->root->bs);
+            if (bdrv_filtered_cow_child(non_filter)) {
+                int ret =3D bdrv_commit(non_filter);
+                if (ret < 0) {
+                    aio_context_release(aio_context);
+                    return ret;
+                }
             }
         }
         aio_context_release(aio_context);
diff --git a/block/commit.c b/block/commit.c
index 02eab34925..252007fd57 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -113,7 +113,7 @@ static void commit_abort(Job *job)
      * something to base, the intermediate images aren't valid any more.=
 */
     bdrv_child_try_set_perm(s->commit_top_bs->backing, 0, BLK_PERM_ALL,
                             &error_abort);
-    bdrv_replace_node(s->commit_top_bs, backing_bs(s->commit_top_bs),
+    bdrv_replace_node(s->commit_top_bs, s->commit_top_bs->backing->bs,
                       &error_abort);
=20
     bdrv_unref(s->commit_top_bs);
@@ -324,10 +324,16 @@ void commit_start(const char *job_id, BlockDriverSt=
ate *bs,
     s->commit_top_bs =3D commit_top_bs;
     bdrv_unref(commit_top_bs);
=20
-    /* Block all nodes between top and base, because they will
-     * disappear from the chain after this operation. */
+    /*
+     * Block all nodes between top and base, because they will
+     * disappear from the chain after this operation.
+     * Note that this assumes that the user is fine with removing all
+     * nodes (including R/W filters) between top and base.  Assuring
+     * this is the responsibility of the interface (i.e. whoever calls
+     * commit_start()).
+     */
     assert(bdrv_chain_contains(top, base));
-    for (iter =3D top; iter !=3D base; iter =3D backing_bs(iter)) {
+    for (iter =3D top; iter !=3D base; iter =3D bdrv_filtered_bs(iter)) =
{
         /* XXX BLK_PERM_WRITE needs to be allowed so we don't block ours=
elves
          * at s->base (if writes are blocked for a node, they are also b=
locked
          * for its backing file). The other options would be a second fi=
lter
@@ -414,19 +420,22 @@ int bdrv_commit(BlockDriverState *bs)
     if (!drv)
         return -ENOMEDIUM;
=20
-    if (!bs->backing) {
+    backing_file_bs =3D bdrv_filtered_cow_bs(bs);
+
+    if (!backing_file_bs) {
         return -ENOTSUP;
     }
=20
     if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_COMMIT_SOURCE, NULL) ||
-        bdrv_op_is_blocked(bs->backing->bs, BLOCK_OP_TYPE_COMMIT_TARGET,=
 NULL)) {
+        bdrv_op_is_blocked(backing_file_bs, BLOCK_OP_TYPE_COMMIT_TARGET,=
 NULL))
+    {
         return -EBUSY;
     }
=20
-    ro =3D bs->backing->bs->read_only;
+    ro =3D backing_file_bs->read_only;
=20
     if (ro) {
-        if (bdrv_reopen_set_read_only(bs->backing->bs, false, NULL)) {
+        if (bdrv_reopen_set_read_only(backing_file_bs, false, NULL)) {
             return -EACCES;
         }
     }
@@ -441,8 +450,6 @@ int bdrv_commit(BlockDriverState *bs)
     }
=20
     /* Insert commit_top block node above backing, so we can write to it=
 */
-    backing_file_bs =3D backing_bs(bs);
-
     commit_top_bs =3D bdrv_new_open_driver(&bdrv_commit_top, NULL, BDRV_=
O_RDWR,
                                          &local_err);
     if (commit_top_bs =3D=3D NULL) {
@@ -528,15 +535,13 @@ ro_cleanup:
     qemu_vfree(buf);
=20
     blk_unref(backing);
-    if (backing_file_bs) {
-        bdrv_set_backing_hd(bs, backing_file_bs, &error_abort);
-    }
+    bdrv_set_backing_hd(bs, backing_file_bs, &error_abort);
     bdrv_unref(commit_top_bs);
     blk_unref(src);
=20
     if (ro) {
         /* ignoring error return here */
-        bdrv_reopen_set_read_only(bs->backing->bs, true, NULL);
+        bdrv_reopen_set_read_only(backing_file_bs, true, NULL);
     }
=20
     return ret;
diff --git a/block/io.c b/block/io.c
index dfc153b8d8..83c2b6b46a 100644
--- a/block/io.c
+++ b/block/io.c
@@ -118,8 +118,17 @@ static void bdrv_merge_limits(BlockLimits *dst, cons=
t BlockLimits *src)
 void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     BlockDriver *drv =3D bs->drv;
+    BlockDriverState *storage_bs;
+    BlockDriverState *cow_bs =3D bdrv_filtered_cow_bs(bs);
     Error *local_err =3D NULL;
=20
+    /*
+     * FIXME: There should be a function for this, and in fact there
+     * will be as of a follow-up patch.
+     */
+    storage_bs =3D
+        child_bs(bs->file) ?: bdrv_filtered_rw_bs(bs);
+
     memset(&bs->bl, 0, sizeof(bs->bl));
=20
     if (!drv) {
@@ -131,13 +140,13 @@ void bdrv_refresh_limits(BlockDriverState *bs, Erro=
r **errp)
                                 drv->bdrv_aio_preadv) ? 1 : 512;
=20
     /* Take some limits from the children as a default */
-    if (bs->file) {
-        bdrv_refresh_limits(bs->file->bs, &local_err);
+    if (storage_bs) {
+        bdrv_refresh_limits(storage_bs, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             return;
         }
-        bdrv_merge_limits(&bs->bl, &bs->file->bs->bl);
+        bdrv_merge_limits(&bs->bl, &storage_bs->bl);
     } else {
         bs->bl.min_mem_alignment =3D 512;
         bs->bl.opt_mem_alignment =3D getpagesize();
@@ -146,13 +155,13 @@ void bdrv_refresh_limits(BlockDriverState *bs, Erro=
r **errp)
         bs->bl.max_iov =3D IOV_MAX;
     }
=20
-    if (bs->backing) {
-        bdrv_refresh_limits(bs->backing->bs, &local_err);
+    if (cow_bs) {
+        bdrv_refresh_limits(cow_bs, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             return;
         }
-        bdrv_merge_limits(&bs->bl, &bs->backing->bs->bl);
+        bdrv_merge_limits(&bs->bl, &cow_bs->bl);
     }
=20
     /* Then let the driver override it */
@@ -2139,11 +2148,12 @@ static int coroutine_fn bdrv_co_block_status(Bloc=
kDriverState *bs,
     if (ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO)) {
         ret |=3D BDRV_BLOCK_ALLOCATED;
     } else if (want_zero) {
+        BlockDriverState *cow_bs =3D bdrv_filtered_cow_bs(bs);
+
         if (bdrv_unallocated_blocks_are_zero(bs)) {
             ret |=3D BDRV_BLOCK_ZERO;
-        } else if (bs->backing) {
-            BlockDriverState *bs2 =3D bs->backing->bs;
-            int64_t size2 =3D bdrv_getlength(bs2);
+        } else if (cow_bs) {
+            int64_t size2 =3D bdrv_getlength(cow_bs);
=20
             if (size2 >=3D 0 && offset >=3D size2) {
                 ret |=3D BDRV_BLOCK_ZERO;
@@ -2208,7 +2218,7 @@ static int coroutine_fn bdrv_co_block_status_above(=
BlockDriverState *bs,
     bool first =3D true;
=20
     assert(bs !=3D base);
-    for (p =3D bs; p !=3D base; p =3D backing_bs(p)) {
+    for (p =3D bs; p !=3D base; p =3D bdrv_filtered_bs(p)) {
         ret =3D bdrv_co_block_status(p, want_zero, offset, bytes, pnum, =
map,
                                    file);
         if (ret < 0) {
@@ -2294,7 +2304,7 @@ int bdrv_block_status_above(BlockDriverState *bs, B=
lockDriverState *base,
 int bdrv_block_status(BlockDriverState *bs, int64_t offset, int64_t byte=
s,
                       int64_t *pnum, int64_t *map, BlockDriverState **fi=
le)
 {
-    return bdrv_block_status_above(bs, backing_bs(bs),
+    return bdrv_block_status_above(bs, bdrv_filtered_bs(bs),
                                    offset, bytes, pnum, map, file);
 }
=20
@@ -2304,9 +2314,9 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState=
 *bs, int64_t offset,
     int ret;
     int64_t dummy;
=20
-    ret =3D bdrv_common_block_status_above(bs, backing_bs(bs), false, of=
fset,
-                                         bytes, pnum ? pnum : &dummy, NU=
LL,
-                                         NULL);
+    ret =3D bdrv_common_block_status_above(bs, bdrv_filtered_bs(bs), fal=
se,
+                                         offset, bytes, pnum ? pnum : &d=
ummy,
+                                         NULL, NULL);
     if (ret < 0) {
         return ret;
     }
@@ -2360,7 +2370,7 @@ int bdrv_is_allocated_above(BlockDriverState *top,
             n =3D pnum_inter;
         }
=20
-        intermediate =3D backing_bs(intermediate);
+        intermediate =3D bdrv_filtered_bs(intermediate);
     }
=20
     *pnum =3D n;
@@ -3135,8 +3145,9 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child,=
 int64_t offset,
     }
=20
     if (!drv->bdrv_co_truncate) {
-        if (bs->file && drv->is_filter) {
-            ret =3D bdrv_co_truncate(bs->file, offset, prealloc, errp);
+        BdrvChild *filtered =3D bdrv_filtered_rw_child(bs);
+        if (filtered) {
+            ret =3D bdrv_co_truncate(filtered, offset, prealloc, errp);
             goto out;
         }
         error_setg(errp, "Image format driver does not support resize");
diff --git a/block/mirror.c b/block/mirror.c
index 8b2404051f..80cef587f0 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -660,8 +660,9 @@ static int mirror_exit_common(Job *job)
                             &error_abort);
     if (!abort && s->backing_mode =3D=3D MIRROR_SOURCE_BACKING_CHAIN) {
         BlockDriverState *backing =3D s->is_none_mode ? src : s->base;
-        if (backing_bs(target_bs) !=3D backing) {
-            bdrv_set_backing_hd(target_bs, backing, &local_err);
+        if (bdrv_backing_chain_next(target_bs) !=3D backing) {
+            bdrv_set_backing_hd(bdrv_skip_rw_filters(target_bs), backing=
,
+                                &local_err);
             if (local_err) {
                 error_report_err(local_err);
                 ret =3D -EPERM;
@@ -711,7 +712,7 @@ static int mirror_exit_common(Job *job)
     block_job_remove_all_bdrv(bjob);
     bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,
                             &error_abort);
-    bdrv_replace_node(mirror_top_bs, backing_bs(mirror_top_bs), &error_a=
bort);
+    bdrv_replace_node(mirror_top_bs, mirror_top_bs->backing->bs, &error_=
abort);
=20
     /* We just changed the BDS the job BB refers to (with either or both=
 of the
      * bdrv_replace_node() calls), so switch the BB back so the cleanup =
does
@@ -903,7 +904,7 @@ static int coroutine_fn mirror_run(Job *job, Error **=
errp)
     } else {
         s->target_cluster_size =3D BDRV_SECTOR_SIZE;
     }
-    if (backing_filename[0] && !target_bs->backing &&
+    if (backing_filename[0] && !bdrv_filtered_cow_child(target_bs) &&
         s->granularity < s->target_cluster_size) {
         s->buf_size =3D MAX(s->buf_size, s->target_cluster_size);
         s->cow_bitmap =3D bitmap_new(length);
@@ -1083,7 +1084,7 @@ static void mirror_complete(Job *job, Error **errp)
     if (s->backing_mode =3D=3D MIRROR_OPEN_BACKING_CHAIN) {
         int ret;
=20
-        assert(!target->backing);
+        assert(!bdrv_filtered_cow_child(target));
         ret =3D bdrv_open_backing_file(target, NULL, "backing", errp);
         if (ret < 0) {
             return;
@@ -1650,7 +1651,9 @@ static void mirror_start_job(const char *job_id, Bl=
ockDriverState *bs,
      * any jobs in them must be blocked */
     if (target_is_backing) {
         BlockDriverState *iter;
-        for (iter =3D backing_bs(bs); iter !=3D target; iter =3D backing=
_bs(iter)) {
+        for (iter =3D bdrv_filtered_bs(bs); iter !=3D target;
+             iter =3D bdrv_filtered_bs(iter))
+        {
             /* XXX BLK_PERM_WRITE needs to be allowed so we don't block
              * ourselves at s->base (if writes are blocked for a node, t=
hey are
              * also blocked for its backing file). The other options wou=
ld be a
@@ -1691,7 +1694,7 @@ fail:
=20
     bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,
                             &error_abort);
-    bdrv_replace_node(mirror_top_bs, backing_bs(mirror_top_bs), &error_a=
bort);
+    bdrv_replace_node(mirror_top_bs, mirror_top_bs->backing->bs, &error_=
abort);
=20
     bdrv_unref(mirror_top_bs);
 }
@@ -1707,14 +1710,14 @@ void mirror_start(const char *job_id, BlockDriver=
State *bs,
                   MirrorCopyMode copy_mode, Error **errp)
 {
     bool is_none_mode;
-    BlockDriverState *base;
+    BlockDriverState *base =3D NULL;
=20
     if (mode =3D=3D MIRROR_SYNC_MODE_INCREMENTAL) {
         error_setg(errp, "Sync mode 'incremental' not supported");
         return;
     }
     is_none_mode =3D mode =3D=3D MIRROR_SYNC_MODE_NONE;
-    base =3D mode =3D=3D MIRROR_SYNC_MODE_TOP ? backing_bs(bs) : NULL;
+    base =3D mode =3D=3D MIRROR_SYNC_MODE_TOP ? bdrv_backing_chain_next(=
bs) : NULL;
     mirror_start_job(job_id, bs, creation_flags, target, replaces,
                      speed, granularity, buf_size, backing_mode,
                      on_source_error, on_target_error, unmap, NULL, NULL=
,
diff --git a/block/qapi.c b/block/qapi.c
index 110d05dc57..478c6f5e0d 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -149,9 +149,13 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend=
 *blk,
             return NULL;
         }
=20
-        if (bs0->drv && bs0->backing) {
+        if (bs0->drv && bdrv_filtered_child(bs0)) {
+            /*
+             * Put any filtered child here (for backwards compatibility =
to when
+             * we put bs0->backing here, which might be any filtered chi=
ld).
+             */
             info->backing_file_depth++;
-            bs0 =3D bs0->backing->bs;
+            bs0 =3D bdrv_filtered_bs(bs0);
             (*p_image_info)->has_backing_image =3D true;
             p_image_info =3D &((*p_image_info)->backing_image);
         } else {
@@ -160,9 +164,8 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend =
*blk,
=20
         /* Skip automatically inserted nodes that the user isn't aware o=
f for
          * query-block (blk !=3D NULL), but not for query-named-block-no=
des */
-        while (blk && bs0->drv && bs0->implicit) {
-            bs0 =3D backing_bs(bs0);
-            assert(bs0);
+        if (blk) {
+            bs0 =3D bdrv_skip_implicit_filters(bs0);
         }
     }
=20
@@ -347,9 +350,9 @@ static void bdrv_query_info(BlockBackend *blk, BlockI=
nfo **p_info,
     BlockDriverState *bs =3D blk_bs(blk);
     char *qdev;
=20
-    /* Skip automatically inserted nodes that the user isn't aware of */
-    while (bs && bs->drv && bs->implicit) {
-        bs =3D backing_bs(bs);
+    if (bs) {
+        /* Skip automatically inserted nodes that the user isn't aware o=
f */
+        bs =3D bdrv_skip_implicit_filters(bs);
     }
=20
     info->device =3D g_strdup(blk_name(blk));
@@ -506,6 +509,7 @@ static void bdrv_query_blk_stats(BlockDeviceStats *ds=
, BlockBackend *blk)
 static BlockStats *bdrv_query_bds_stats(BlockDriverState *bs,
                                         bool blk_level)
 {
+    BlockDriverState *cow_bs;
     BlockStats *s =3D NULL;
=20
     s =3D g_malloc0(sizeof(*s));
@@ -518,9 +522,8 @@ static BlockStats *bdrv_query_bds_stats(BlockDriverSt=
ate *bs,
     /* Skip automatically inserted nodes that the user isn't aware of in
      * a BlockBackend-level command. Stay at the exact node for a node-l=
evel
      * command. */
-    while (blk_level && bs->drv && bs->implicit) {
-        bs =3D backing_bs(bs);
-        assert(bs);
+    if (blk_level) {
+        bs =3D bdrv_skip_implicit_filters(bs);
     }
=20
     if (bdrv_get_node_name(bs)[0]) {
@@ -535,9 +538,10 @@ static BlockStats *bdrv_query_bds_stats(BlockDriverS=
tate *bs,
         s->parent =3D bdrv_query_bds_stats(bs->file->bs, blk_level);
     }
=20
-    if (blk_level && bs->backing) {
+    cow_bs =3D bdrv_filtered_cow_bs(bs);
+    if (blk_level && cow_bs) {
         s->has_backing =3D true;
-        s->backing =3D bdrv_query_bds_stats(bs->backing->bs, blk_level);
+        s->backing =3D bdrv_query_bds_stats(cow_bs, blk_level);
     }
=20
     return s;
diff --git a/block/stream.c b/block/stream.c
index bfaebb861a..23d5c890e0 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -65,6 +65,7 @@ static int stream_prepare(Job *job)
     StreamBlockJob *s =3D container_of(job, StreamBlockJob, common.job);
     BlockJob *bjob =3D &s->common;
     BlockDriverState *bs =3D blk_bs(bjob->blk);
+    BlockDriverState *unfiltered =3D bdrv_skip_rw_filters(bs);
     BlockDriverState *base =3D s->base;
     Error *local_err =3D NULL;
     int ret =3D 0;
@@ -72,7 +73,7 @@ static int stream_prepare(Job *job)
     bdrv_unfreeze_backing_chain(bs, base);
     s->chain_frozen =3D false;
=20
-    if (bs->backing) {
+    if (bdrv_filtered_cow_child(unfiltered)) {
         const char *base_id =3D NULL, *base_fmt =3D NULL;
         if (base) {
             base_id =3D s->backing_file_str;
@@ -80,7 +81,7 @@ static int stream_prepare(Job *job)
                 base_fmt =3D base->drv->format_name;
             }
         }
-        ret =3D bdrv_change_backing_file(bs, base_id, base_fmt);
+        ret =3D bdrv_change_backing_file(unfiltered, base_id, base_fmt);
         bdrv_set_backing_hd(bs, base, &local_err);
         if (local_err) {
             error_report_err(local_err);
@@ -121,7 +122,7 @@ static int coroutine_fn stream_run(Job *job, Error **=
errp)
     int64_t n =3D 0; /* bytes */
     void *buf;
=20
-    if (!bs->backing) {
+    if (!bdrv_filtered_child(bs)) {
         goto out;
     }
=20
@@ -162,7 +163,7 @@ static int coroutine_fn stream_run(Job *job, Error **=
errp)
         } else if (ret >=3D 0) {
             /* Copy if allocated in the intermediate images.  Limit to t=
he
              * known-unallocated area [offset, offset+n*BDRV_SECTOR_SIZE=
).  */
-            ret =3D bdrv_is_allocated_above(backing_bs(bs), base,
+            ret =3D bdrv_is_allocated_above(bdrv_filtered_bs(bs), base,
                                           offset, n, &n);
=20
             /* Finish early if end of backing file has been reached */
@@ -268,7 +269,9 @@ void stream_start(const char *job_id, BlockDriverStat=
e *bs,
      * disappear from the chain after this operation. The streaming job =
reads
      * every block only once, assuming that it doesn't change, so block =
writes
      * and resizes. */
-    for (iter =3D backing_bs(bs); iter && iter !=3D base; iter =3D backi=
ng_bs(iter)) {
+    for (iter =3D bdrv_filtered_bs(bs); iter && iter !=3D base;
+         iter =3D bdrv_filtered_bs(iter))
+    {
         block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
                            BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNC=
HANGED,
                            &error_abort);
diff --git a/blockdev.c b/blockdev.c
index 4775a07d93..bb71b8368d 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1094,7 +1094,7 @@ void hmp_commit(Monitor *mon, const QDict *qdict)
             return;
         }
=20
-        bs =3D blk_bs(blk);
+        bs =3D bdrv_skip_implicit_filters(blk_bs(blk));
         aio_context =3D bdrv_get_aio_context(bs);
         aio_context_acquire(aio_context);
=20
@@ -1663,7 +1663,7 @@ static void external_snapshot_prepare(BlkActionStat=
e *common,
         goto out;
     }
=20
-    if (state->new_bs->backing !=3D NULL) {
+    if (bdrv_filtered_cow_child(state->new_bs)) {
         error_setg(errp, "The snapshot already has a backing image");
         goto out;
     }
@@ -3202,6 +3202,13 @@ void qmp_block_stream(bool has_job_id, const char =
*job_id, const char *device,
         if (!base_bs) {
             goto out;
         }
+        /*
+         * Streaming copies data through COR, so all of the filters
+         * between the target and the base are considered.  Therefore,
+         * we can use bdrv_chain_contains() and do not have to use
+         * bdrv_legacy_chain_contains() (which does not go past
+         * explicitly added filters).
+         */
         if (bs =3D=3D base_bs || !bdrv_chain_contains(bs, base_bs)) {
             error_setg(errp, "Node '%s' is not a backing image of '%s'",
                        base_node, device);
@@ -3213,7 +3220,7 @@ void qmp_block_stream(bool has_job_id, const char *=
job_id, const char *device,
     }
=20
     /* Check for op blockers in the whole chain between bs and base */
-    for (iter =3D bs; iter && iter !=3D base_bs; iter =3D backing_bs(ite=
r)) {
+    for (iter =3D bs; iter && iter !=3D base_bs; iter =3D bdrv_filtered_=
bs(iter)) {
         if (bdrv_op_is_blocked(iter, BLOCK_OP_TYPE_STREAM, errp)) {
             goto out;
         }
@@ -3370,7 +3377,9 @@ void qmp_block_commit(bool has_job_id, const char *=
job_id, const char *device,
=20
     assert(bdrv_get_aio_context(base_bs) =3D=3D aio_context);
=20
-    for (iter =3D top_bs; iter !=3D backing_bs(base_bs); iter =3D backin=
g_bs(iter)) {
+    for (iter =3D top_bs; iter !=3D bdrv_filtered_bs(base_bs);
+         iter =3D bdrv_filtered_bs(iter))
+    {
         if (bdrv_op_is_blocked(iter, BLOCK_OP_TYPE_COMMIT_TARGET, errp))=
 {
             goto out;
         }
@@ -3381,6 +3390,11 @@ void qmp_block_commit(bool has_job_id, const char =
*job_id, const char *device,
         error_setg(errp, "cannot commit an image into itself");
         goto out;
     }
+    if (!bdrv_legacy_chain_contains(top_bs, base_bs)) {
+        /* We have to disallow this until the user can give explicit con=
sent */
+        error_setg(errp, "Cannot commit through explicit filter nodes");
+        goto out;
+    }
=20
     if (top_bs =3D=3D bs) {
         if (has_backing_file) {
@@ -3472,7 +3486,13 @@ static BlockJob *do_drive_backup(DriveBackup *back=
up, JobTxn *txn,
     /* See if we have a backing HD we can use to create our new image
      * on top of. */
     if (backup->sync =3D=3D MIRROR_SYNC_MODE_TOP) {
-        source =3D backing_bs(bs);
+        /*
+         * Backup will not replace the source by the target, so none
+         * of the filters skipped here will be removed (in contrast to
+         * mirror).  Therefore, we can skip all of them when looking
+         * for the first COW relationship.
+         */
+        source =3D bdrv_filtered_cow_bs(bdrv_skip_rw_filters(bs));
         if (!source) {
             backup->sync =3D MIRROR_SYNC_MODE_FULL;
         }
@@ -3492,9 +3512,14 @@ static BlockJob *do_drive_backup(DriveBackup *back=
up, JobTxn *txn,
     if (backup->mode !=3D NEW_IMAGE_MODE_EXISTING) {
         assert(backup->format);
         if (source) {
-            bdrv_refresh_filename(source);
-            bdrv_img_create(backup->target, backup->format, source->file=
name,
-                            source->drv->format_name, NULL,
+            /* Implicit filters should not appear in the filename */
+            BlockDriverState *explicit_backing =3D
+                bdrv_skip_implicit_filters(source);
+
+            bdrv_refresh_filename(explicit_backing);
+            bdrv_img_create(backup->target, backup->format,
+                            explicit_backing->filename,
+                            explicit_backing->drv->format_name, NULL,
                             size, flags, false, &local_err);
         } else {
             bdrv_img_create(backup->target, backup->format, NULL, NULL, =
NULL,
@@ -3752,7 +3777,7 @@ static void blockdev_mirror_common(const char *job_=
id, BlockDriverState *bs,
         return;
     }
=20
-    if (!bs->backing && sync =3D=3D MIRROR_SYNC_MODE_TOP) {
+    if (!bdrv_backing_chain_next(bs) && sync =3D=3D MIRROR_SYNC_MODE_TOP=
) {
         sync =3D MIRROR_SYNC_MODE_FULL;
     }
=20
@@ -3801,7 +3826,7 @@ static void blockdev_mirror_common(const char *job_=
id, BlockDriverState *bs,
=20
 void qmp_drive_mirror(DriveMirror *arg, Error **errp)
 {
-    BlockDriverState *bs;
+    BlockDriverState *bs, *unfiltered_bs;
     BlockDriverState *source, *target_bs;
     AioContext *aio_context;
     BlockMirrorBackingMode backing_mode;
@@ -3810,6 +3835,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **err=
p)
     int flags;
     int64_t size;
     const char *format =3D arg->format;
+    const char *replaces_node_name =3D NULL;
=20
     bs =3D qmp_get_root_bs(arg->device, errp);
     if (!bs) {
@@ -3821,6 +3847,16 @@ void qmp_drive_mirror(DriveMirror *arg, Error **er=
rp)
         return;
     }
=20
+    /*
+     * If the user has not instructed us otherwise, we should let the
+     * block job run from @bs (thus taking into account all filters on
+     * it) but replace @unfiltered_bs when it finishes (thus not
+     * removing those filters).
+     * (And if there are any explicit filters, we should assume the
+     *  user knows how to use the @replaces option.)
+     */
+    unfiltered_bs =3D bdrv_skip_implicit_filters(bs);
+
     aio_context =3D bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
=20
@@ -3834,8 +3870,14 @@ void qmp_drive_mirror(DriveMirror *arg, Error **er=
rp)
     }
=20
     flags =3D bs->open_flags | BDRV_O_RDWR;
-    source =3D backing_bs(bs);
+    source =3D bdrv_filtered_cow_bs(unfiltered_bs);
     if (!source && arg->sync =3D=3D MIRROR_SYNC_MODE_TOP) {
+        if (bdrv_filtered_bs(unfiltered_bs)) {
+            /* @unfiltered_bs is an explicit filter */
+            error_setg(errp, "Cannot perform sync=3Dtop mirror through a=
n "
+                       "explicitly added filter node on the source");
+            goto out;
+        }
         arg->sync =3D MIRROR_SYNC_MODE_FULL;
     }
     if (arg->sync =3D=3D MIRROR_SYNC_MODE_NONE) {
@@ -3854,6 +3896,9 @@ void qmp_drive_mirror(DriveMirror *arg, Error **err=
p)
                              " named node of the graph");
             goto out;
         }
+        replaces_node_name =3D arg->replaces;
+    } else if (unfiltered_bs !=3D bs) {
+        replaces_node_name =3D unfiltered_bs->node_name;
     }
=20
     if (arg->mode =3D=3D NEW_IMAGE_MODE_ABSOLUTE_PATHS) {
@@ -3873,6 +3918,9 @@ void qmp_drive_mirror(DriveMirror *arg, Error **err=
p)
         bdrv_img_create(arg->target, format,
                         NULL, NULL, NULL, size, flags, false, &local_err=
);
     } else {
+        /* Implicit filters should not appear in the filename */
+        BlockDriverState *explicit_backing =3D bdrv_skip_implicit_filter=
s(source);
+
         switch (arg->mode) {
         case NEW_IMAGE_MODE_EXISTING:
             break;
@@ -3880,8 +3928,8 @@ void qmp_drive_mirror(DriveMirror *arg, Error **err=
p)
             /* create new image with backing file */
             bdrv_refresh_filename(source);
             bdrv_img_create(arg->target, format,
-                            source->filename,
-                            source->drv->format_name,
+                            explicit_backing->filename,
+                            explicit_backing->drv->format_name,
                             NULL, size, flags, false, &local_err);
             break;
         default:
@@ -3913,7 +3961,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **err=
p)
     bdrv_set_aio_context(target_bs, aio_context);
=20
     blockdev_mirror_common(arg->has_job_id ? arg->job_id : NULL, bs, tar=
get_bs,
-                           arg->has_replaces, arg->replaces, arg->sync,
+                           !!replaces_node_name, replaces_node_name, arg=
->sync,
                            backing_mode, arg->has_speed, arg->speed,
                            arg->has_granularity, arg->granularity,
                            arg->has_buf_size, arg->buf_size,
@@ -3949,7 +3997,7 @@ void qmp_blockdev_mirror(bool has_job_id, const cha=
r *job_id,
                          bool has_auto_dismiss, bool auto_dismiss,
                          Error **errp)
 {
-    BlockDriverState *bs;
+    BlockDriverState *bs, *unfiltered_bs;
     BlockDriverState *target_bs;
     AioContext *aio_context;
     BlockMirrorBackingMode backing_mode =3D MIRROR_LEAVE_BACKING_CHAIN;
@@ -3960,6 +4008,16 @@ void qmp_blockdev_mirror(bool has_job_id, const ch=
ar *job_id,
         return;
     }
=20
+    /*
+     * Same as in qmp_drive_mirror(): We want to run the job from @bs,
+     * but we want to replace @unfiltered_bs on completion.
+     */
+    unfiltered_bs =3D bdrv_skip_implicit_filters(bs);
+    if (!has_replaces && unfiltered_bs !=3D bs) {
+        replaces =3D unfiltered_bs->node_name;
+        has_replaces =3D true;
+    }
+
     target_bs =3D bdrv_lookup_bs(target, target, errp);
     if (!target_bs) {
         return;
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitma=
p.c
index d1bb863cb6..f99f753fba 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -285,9 +285,7 @@ static int init_dirty_bitmap_migration(void)
         const char *drive_name =3D bdrv_get_device_or_node_name(bs);
=20
         /* skip automatically inserted nodes */
-        while (bs && bs->drv && bs->implicit) {
-            bs =3D backing_bs(bs);
-        }
+        bs =3D bdrv_skip_implicit_filters(bs);
=20
         for (bitmap =3D bdrv_dirty_bitmap_next(bs, NULL); bitmap;
              bitmap =3D bdrv_dirty_bitmap_next(bs, bitmap))
diff --git a/nbd/server.c b/nbd/server.c
index e21bd501dc..e41ae89dbe 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1506,13 +1506,13 @@ NBDExport *nbd_export_new(BlockDriverState *bs, u=
int64_t dev_offset,
     if (bitmap) {
         BdrvDirtyBitmap *bm =3D NULL;
=20
-        while (true) {
+        while (bs) {
             bm =3D bdrv_find_dirty_bitmap(bs, bitmap);
-            if (bm !=3D NULL || bs->backing =3D=3D NULL) {
+            if (bm !=3D NULL) {
                 break;
             }
=20
-            bs =3D bs->backing->bs;
+            bs =3D bdrv_filtered_bs(bs);
         }
=20
         if (bm =3D=3D NULL) {
diff --git a/qemu-img.c b/qemu-img.c
index aa6f81f1ea..bcfbb743fc 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -982,7 +982,7 @@ static int img_commit(int argc, char **argv)
     if (!blk) {
         return 1;
     }
-    bs =3D blk_bs(blk);
+    bs =3D bdrv_skip_implicit_filters(blk_bs(blk));
=20
     qemu_progress_init(progress, 1.f);
     qemu_progress_print(0.f, 100);
@@ -999,7 +999,7 @@ static int img_commit(int argc, char **argv)
         /* This is different from QMP, which by default uses the deepest=
 file in
          * the backing chain (i.e., the very base); however, the traditi=
onal
          * behavior of qemu-img commit is using the immediate backing fi=
le. */
-        base_bs =3D backing_bs(bs);
+        base_bs =3D bdrv_filtered_cow_bs(bs);
         if (!base_bs) {
             error_setg(&local_err, "Image does not have a backing file")=
;
             goto done;
@@ -1616,19 +1616,18 @@ static int convert_iteration_sectors(ImgConvertSt=
ate *s, int64_t sector_num)
=20
     if (s->sector_next_status <=3D sector_num) {
         int64_t count =3D n * BDRV_SECTOR_SIZE;
+        BlockDriverState *src_bs =3D blk_bs(s->src[src_cur]);
+        BlockDriverState *base;
=20
         if (s->target_has_backing) {
-
-            ret =3D bdrv_block_status(blk_bs(s->src[src_cur]),
-                                    (sector_num - src_cur_offset) *
-                                    BDRV_SECTOR_SIZE,
-                                    count, &count, NULL, NULL);
+            base =3D bdrv_backing_chain_next(src_bs);
         } else {
-            ret =3D bdrv_block_status_above(blk_bs(s->src[src_cur]), NUL=
L,
-                                          (sector_num - src_cur_offset) =
*
-                                          BDRV_SECTOR_SIZE,
-                                          count, &count, NULL, NULL);
+            base =3D NULL;
         }
+        ret =3D bdrv_block_status_above(src_bs, base,
+                                      (sector_num - src_cur_offset) *
+                                      BDRV_SECTOR_SIZE,
+                                      count, &count, NULL, NULL);
         if (ret < 0) {
             error_report("error while reading block status of sector %" =
PRId64
                          ": %s", sector_num, strerror(-ret));
@@ -2434,7 +2433,8 @@ static int img_convert(int argc, char **argv)
          * s.target_backing_sectors has to be negative, which it will
          * be automatically).  The backing file length is used only
          * for optimizations, so such a case is not fatal. */
-        s.target_backing_sectors =3D bdrv_nb_sectors(out_bs->backing->bs=
);
+        s.target_backing_sectors =3D
+            bdrv_nb_sectors(bdrv_filtered_cow_bs(out_bs));
     } else {
         s.target_backing_sectors =3D -1;
     }
@@ -2797,6 +2797,7 @@ static int get_block_status(BlockDriverState *bs, i=
nt64_t offset,
=20
     depth =3D 0;
     for (;;) {
+        bs =3D bdrv_skip_rw_filters(bs);
         ret =3D bdrv_block_status(bs, offset, bytes, &bytes, &map, &file=
);
         if (ret < 0) {
             return ret;
@@ -2805,7 +2806,7 @@ static int get_block_status(BlockDriverState *bs, i=
nt64_t offset,
         if (ret & (BDRV_BLOCK_ZERO|BDRV_BLOCK_DATA)) {
             break;
         }
-        bs =3D backing_bs(bs);
+        bs =3D bdrv_filtered_cow_bs(bs);
         if (bs =3D=3D NULL) {
             ret =3D 0;
             break;
@@ -2944,7 +2945,7 @@ static int img_map(int argc, char **argv)
     if (!blk) {
         return 1;
     }
-    bs =3D blk_bs(blk);
+    bs =3D bdrv_skip_implicit_filters(blk_bs(blk));
=20
     if (output_format =3D=3D OFORMAT_HUMAN) {
         printf("%-16s%-16s%-16s%s\n", "Offset", "Length", "Mapped to", "=
File");
diff --git a/tests/qemu-iotests/184.out b/tests/qemu-iotests/184.out
index 3deb3cfb94..1d61f7e224 100644
--- a/tests/qemu-iotests/184.out
+++ b/tests/qemu-iotests/184.out
@@ -27,6 +27,11 @@ Testing:
             "iops_rd": 0,
             "detect_zeroes": "off",
             "image": {
+                "backing-image": {
+                    "virtual-size": 1073741824,
+                    "filename": "null-co://",
+                    "format": "null-co"
+                },
                 "virtual-size": 1073741824,
                 "filename": "json:{\"throttle-group\": \"group0\", \"dri=
ver\": \"throttle\", \"file\": {\"driver\": \"null-co\"}}",
                 "format": "throttle"
@@ -34,7 +39,7 @@ Testing:
             "iops_wr": 0,
             "ro": false,
             "node-name": "throttle0",
-            "backing_file_depth": 0,
+            "backing_file_depth": 1,
             "drv": "throttle",
             "iops": 0,
             "bps_wr": 0,
diff --git a/tests/qemu-iotests/204.out b/tests/qemu-iotests/204.out
index f3a10fbe90..684774d763 100644
--- a/tests/qemu-iotests/204.out
+++ b/tests/qemu-iotests/204.out
@@ -59,5 +59,6 @@ Offset          Length          File
 0x900000        0x2400000       TEST_DIR/t.IMGFMT
 0x3c00000       0x1100000       TEST_DIR/t.IMGFMT
 0x6a00000       0x400000        TEST_DIR/t.IMGFMT
+0x6e00000       0x1200000       TEST_DIR/t.IMGFMT.base
 No errors were found on the image.
 *** done
--=20
2.20.1


