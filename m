Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C68C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:28:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B84720C01
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B84720C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7kM-00078y-Rg
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 12:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57585)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hw7Y7-0003ho-01
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hw7Y5-0004b5-OE
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:15:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54880)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hw7Y2-0004Z1-TX; Fri, 09 Aug 2019 12:15:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 341D330ADBA6;
 Fri,  9 Aug 2019 16:15:22 +0000 (UTC)
Received: from localhost (unknown [10.40.205.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A9FDE17C4A;
 Fri,  9 Aug 2019 16:15:21 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri,  9 Aug 2019 18:13:55 +0200
Message-Id: <20190809161407.11920-31-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-1-mreitz@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 09 Aug 2019 16:15:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 30/42] qemu-img: Use child access functions
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

This changes iotest 204's output, because blkdebug on top of a COW node
used to make qemu-img map disregard the rest of the backing chain (the
backing chain was broken by the filter).  With this patch, the
allocation in the base image is reported correctly.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c                 | 33 ++++++++++++++++++++-------------
 tests/qemu-iotests/204.out |  1 +
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 79983772de..3b30c5ae70 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1012,7 +1012,7 @@ static int img_commit(int argc, char **argv)
         /* This is different from QMP, which by default uses the deepest=
 file in
          * the backing chain (i.e., the very base); however, the traditi=
onal
          * behavior of qemu-img commit is using the immediate backing fi=
le. */
-        base_bs =3D backing_bs(bs);
+        base_bs =3D bdrv_backing_chain_next(bs);
         if (!base_bs) {
             error_setg(&local_err, "Image does not have a backing file")=
;
             goto done;
@@ -1632,18 +1632,20 @@ static int convert_iteration_sectors(ImgConvertSt=
ate *s, int64_t sector_num)
     if (s->sector_next_status <=3D sector_num) {
         uint64_t offset =3D (sector_num - src_cur_offset) * BDRV_SECTOR_=
SIZE;
         int64_t count;
+        BlockDriverState *src_bs =3D blk_bs(s->src[src_cur]);
+        BlockDriverState *base;
+
+        if (s->target_has_backing) {
+            base =3D bdrv_filtered_cow_bs(bdrv_skip_rw_filters(src_bs));
+        } else {
+            base =3D NULL;
+        }
=20
         do {
             count =3D n * BDRV_SECTOR_SIZE;
=20
-            if (s->target_has_backing) {
-                ret =3D bdrv_block_status(blk_bs(s->src[src_cur]), offse=
t,
-                                        count, &count, NULL, NULL);
-            } else {
-                ret =3D bdrv_block_status_above(blk_bs(s->src[src_cur]),=
 NULL,
-                                              offset, count, &count, NUL=
L,
-                                              NULL);
-            }
+            ret =3D bdrv_block_status_above(src_bs, base, offset, count,=
 &count,
+                                          NULL, NULL);
=20
             if (ret < 0) {
                 if (s->salvage) {
@@ -2490,7 +2492,8 @@ static int img_convert(int argc, char **argv)
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
@@ -2853,6 +2856,7 @@ static int get_block_status(BlockDriverState *bs, i=
nt64_t offset,
=20
     depth =3D 0;
     for (;;) {
+        bs =3D bdrv_skip_rw_filters(bs);
         ret =3D bdrv_block_status(bs, offset, bytes, &bytes, &map, &file=
);
         if (ret < 0) {
             return ret;
@@ -2861,7 +2865,7 @@ static int get_block_status(BlockDriverState *bs, i=
nt64_t offset,
         if (ret & (BDRV_BLOCK_ZERO|BDRV_BLOCK_DATA)) {
             break;
         }
-        bs =3D backing_bs(bs);
+        bs =3D bdrv_filtered_cow_bs(bs);
         if (bs =3D=3D NULL) {
             ret =3D 0;
             break;
@@ -3216,6 +3220,7 @@ static int img_rebase(int argc, char **argv)
     uint8_t *buf_old =3D NULL;
     uint8_t *buf_new =3D NULL;
     BlockDriverState *bs =3D NULL, *prefix_chain_bs =3D NULL;
+    BlockDriverState *unfiltered_bs;
     char *filename;
     const char *fmt, *cache, *src_cache, *out_basefmt, *out_baseimg;
     int c, flags, src_flags, ret;
@@ -3350,6 +3355,8 @@ static int img_rebase(int argc, char **argv)
     }
     bs =3D blk_bs(blk);
=20
+    unfiltered_bs =3D bdrv_skip_rw_filters(bs);
+
     if (out_basefmt !=3D NULL) {
         if (bdrv_find_format(out_basefmt) =3D=3D NULL) {
             error_report("Invalid format name: '%s'", out_basefmt);
@@ -3361,7 +3368,7 @@ static int img_rebase(int argc, char **argv)
     /* For safe rebasing we need to compare old and new backing file */
     if (!unsafe) {
         QDict *options =3D NULL;
-        BlockDriverState *base_bs =3D backing_bs(bs);
+        BlockDriverState *base_bs =3D bdrv_filtered_cow_bs(unfiltered_bs=
);
=20
         if (base_bs) {
             blk_old_backing =3D blk_new(qemu_get_aio_context(),
@@ -3517,7 +3524,7 @@ static int img_rebase(int argc, char **argv)
                  * If cluster wasn't changed since prefix_chain, we don'=
t need
                  * to take action
                  */
-                ret =3D bdrv_is_allocated_above(backing_bs(bs), prefix_c=
hain_bs,
+                ret =3D bdrv_is_allocated_above(unfiltered_bs, prefix_ch=
ain_bs,
                                               false, offset, n, &n);
                 if (ret < 0) {
                     error_report("error while reading image metadata: %s=
",
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
2.21.0


