Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EA6C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:40:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9EAA20B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9EAA20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35606 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbBvJ-0002Ff-0X
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 18:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46001)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbBSg-00088P-PY
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:11:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbBSc-00082G-VW
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:11:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36736)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbBSX-0007xz-Jk; Wed, 12 Jun 2019 18:11:09 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B91AE30860B9;
 Wed, 12 Jun 2019 22:11:08 +0000 (UTC)
Received: from localhost (unknown [10.40.205.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 47F5160185;
 Wed, 12 Jun 2019 22:11:08 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 13 Jun 2019 00:09:46 +0200
Message-Id: <20190612221004.2317-25-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-1-mreitz@redhat.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 12 Jun 2019 22:11:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 24/42] block: Use child access functions for
 QAPI queries
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

query-block and query-named-block-nodes now return any filtered child
under "backing", not just bs->backing or COW children.  This is so that
filters do not interrupt the reported backing chain.  This changes the
output for iotest 184, as the throttled node now appears as a backing
child.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qapi.c               | 35 ++++++++++++++++++++---------------
 tests/qemu-iotests/184.out |  7 ++++++-
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index 0c13c86f4e..1fd2937abc 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -150,9 +150,13 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend=
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
@@ -161,9 +165,8 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend =
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
@@ -348,9 +351,9 @@ static void bdrv_query_info(BlockBackend *blk, BlockI=
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
@@ -507,6 +510,7 @@ static void bdrv_query_blk_stats(BlockDeviceStats *ds=
, BlockBackend *blk)
 static BlockStats *bdrv_query_bds_stats(BlockDriverState *bs,
                                         bool blk_level)
 {
+    BlockDriverState *storage_bs, *cow_bs;
     BlockStats *s =3D NULL;
=20
     s =3D g_malloc0(sizeof(*s));
@@ -519,9 +523,8 @@ static BlockStats *bdrv_query_bds_stats(BlockDriverSt=
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
@@ -531,14 +534,16 @@ static BlockStats *bdrv_query_bds_stats(BlockDriver=
State *bs,
=20
     s->stats->wr_highest_offset =3D stat64_get(&bs->wr_highest_offset);
=20
-    if (bs->file) {
+    storage_bs =3D bdrv_storage_bs(bs);
+    if (storage_bs) {
         s->has_parent =3D true;
-        s->parent =3D bdrv_query_bds_stats(bs->file->bs, blk_level);
+        s->parent =3D bdrv_query_bds_stats(storage_bs, blk_level);
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
--=20
2.21.0


