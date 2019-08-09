Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24184C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:33:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF76720C01
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF76720C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32917 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7pC-0008KJ-2N
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 12:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57751)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hw7YR-00044O-RN
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hw7YP-0004jH-PR
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:15:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37280)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hw7YE-0004f6-Hn; Fri, 09 Aug 2019 12:15:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D4DBE20ABB;
 Fri,  9 Aug 2019 16:15:33 +0000 (UTC)
Received: from localhost (unknown [10.40.205.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 404345D6A0;
 Fri,  9 Aug 2019 16:15:33 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri,  9 Aug 2019 18:14:00 +0200
Message-Id: <20190809161407.11920-36-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-1-mreitz@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 09 Aug 2019 16:15:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 35/42] block: Fix check_to_replace_node()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
index 6ba853fb90..8da706cd89 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -404,6 +404,7 @@ bool bdrv_is_first_non_filter(BlockDriverState *candi=
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
index 915b80153c..4858d3e718 100644
--- a/block.c
+++ b/block.c
@@ -6290,7 +6290,59 @@ bool bdrv_is_first_non_filter(BlockDriverState *ca=
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
@@ -6309,13 +6361,32 @@ BlockDriverState *check_to_replace_node(BlockDriv=
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
index 4e72f6f701..758e0b5431 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3887,7 +3887,7 @@ static void blockdev_mirror_common(const char *job_=
id, BlockDriverState *bs,
     }
=20
     if (has_replaces) {
-        BlockDriverState *to_replace_bs;
+        BlockDriverState *to_replace_bs, *backing_bs;
         AioContext *replace_aio_context;
         int64_t bs_size, replace_size;
=20
@@ -3897,7 +3897,37 @@ static void blockdev_mirror_common(const char *job=
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
2.21.0


