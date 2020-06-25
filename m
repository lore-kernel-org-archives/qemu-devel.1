Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC8DC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:45:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAAEC2080C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4lv+4lY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAAEC2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joU3s-0004aG-1t
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTj9-0006hO-2I
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:23:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23412
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTj7-0001Pa-62
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593098624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h/Yl/2jRZhZlPGJGP9AJRvFe0734mYF3oEnNfao89Xs=;
 b=f4lv+4lYqU7NiAzB5UgVk03PIhg5TbIdFiLOQZGidYkhyPq1MayOCl4/l8w3B/4/tvaL+p
 BU+T5jm1EOYy+47dE9ktIsz4Tta3G+l7Q6gv7cw76pEmbeHi+tvei2DovT0CS9yFszYOAF
 mipyMd64OX6TjDsk850Z7LMnH2zsNfQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-egdhuAkLONOMRPTUYL5e8w-1; Thu, 25 Jun 2020 11:23:41 -0400
X-MC-Unique: egdhuAkLONOMRPTUYL5e8w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99F3D100960F;
 Thu, 25 Jun 2020 15:23:40 +0000 (UTC)
Received: from localhost (ovpn-113-182.ams2.redhat.com [10.36.113.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3AAC21944D;
 Thu, 25 Jun 2020 15:23:40 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 37/47] qemu-img: Use child access functions
Date: Thu, 25 Jun 2020 17:22:05 +0200
Message-Id: <20200625152215.941773-38-mreitz@redhat.com>
In-Reply-To: <20200625152215.941773-1-mreitz@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 qemu-img.c                 | 36 ++++++++++++++++++++++--------------
 tests/qemu-iotests/204.out |  1 +
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 381271a74e..947be6ffac 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1089,7 +1089,7 @@ static int img_commit(int argc, char **argv)
         /* This is different from QMP, which by default uses the deepest file in
          * the backing chain (i.e., the very base); however, the traditional
          * behavior of qemu-img commit is using the immediate backing file. */
-        base_bs = backing_bs(bs);
+        base_bs = bdrv_backing_chain_next(bs);
         if (!base_bs) {
             error_setg(&local_err, "Image does not have a backing file");
             goto done;
@@ -1737,18 +1737,20 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
     if (s->sector_next_status <= sector_num) {
         uint64_t offset = (sector_num - src_cur_offset) * BDRV_SECTOR_SIZE;
         int64_t count;
+        BlockDriverState *src_bs = blk_bs(s->src[src_cur]);
+        BlockDriverState *base;
+
+        if (s->target_has_backing) {
+            base = bdrv_cow_bs(bdrv_skip_filters(src_bs));
+        } else {
+            base = NULL;
+        }
 
         do {
             count = n * BDRV_SECTOR_SIZE;
 
-            if (s->target_has_backing) {
-                ret = bdrv_block_status(blk_bs(s->src[src_cur]), offset,
-                                        count, &count, NULL, NULL);
-            } else {
-                ret = bdrv_block_status_above(blk_bs(s->src[src_cur]), NULL,
-                                              offset, count, &count, NULL,
-                                              NULL);
-            }
+            ret = bdrv_block_status_above(src_bs, base, offset, count, &count,
+                                          NULL, NULL);
 
             if (ret < 0) {
                 if (s->salvage) {
@@ -2673,7 +2675,8 @@ static int img_convert(int argc, char **argv)
          * s.target_backing_sectors has to be negative, which it will
          * be automatically).  The backing file length is used only
          * for optimizations, so such a case is not fatal. */
-        s.target_backing_sectors = bdrv_nb_sectors(out_bs->backing->bs);
+        s.target_backing_sectors =
+            bdrv_nb_sectors(bdrv_backing_chain_next(out_bs));
     } else {
         s.target_backing_sectors = -1;
     }
@@ -3044,6 +3047,7 @@ static int get_block_status(BlockDriverState *bs, int64_t offset,
 
     depth = 0;
     for (;;) {
+        bs = bdrv_skip_filters(bs);
         ret = bdrv_block_status(bs, offset, bytes, &bytes, &map, &file);
         if (ret < 0) {
             return ret;
@@ -3052,7 +3056,7 @@ static int get_block_status(BlockDriverState *bs, int64_t offset,
         if (ret & (BDRV_BLOCK_ZERO|BDRV_BLOCK_DATA)) {
             break;
         }
-        bs = backing_bs(bs);
+        bs = bdrv_cow_bs(bs);
         if (bs == NULL) {
             ret = 0;
             break;
@@ -3437,6 +3441,7 @@ static int img_rebase(int argc, char **argv)
     uint8_t *buf_old = NULL;
     uint8_t *buf_new = NULL;
     BlockDriverState *bs = NULL, *prefix_chain_bs = NULL;
+    BlockDriverState *unfiltered_bs;
     char *filename;
     const char *fmt, *cache, *src_cache, *out_basefmt, *out_baseimg;
     int c, flags, src_flags, ret;
@@ -3571,6 +3576,8 @@ static int img_rebase(int argc, char **argv)
     }
     bs = blk_bs(blk);
 
+    unfiltered_bs = bdrv_skip_filters(bs);
+
     if (out_basefmt != NULL) {
         if (bdrv_find_format(out_basefmt) == NULL) {
             error_report("Invalid format name: '%s'", out_basefmt);
@@ -3582,7 +3589,7 @@ static int img_rebase(int argc, char **argv)
     /* For safe rebasing we need to compare old and new backing file */
     if (!unsafe) {
         QDict *options = NULL;
-        BlockDriverState *base_bs = backing_bs(bs);
+        BlockDriverState *base_bs = bdrv_cow_bs(unfiltered_bs);
 
         if (base_bs) {
             blk_old_backing = blk_new(qemu_get_aio_context(),
@@ -3738,8 +3745,9 @@ static int img_rebase(int argc, char **argv)
                  * If cluster wasn't changed since prefix_chain, we don't need
                  * to take action
                  */
-                ret = bdrv_is_allocated_above(backing_bs(bs), prefix_chain_bs,
-                                              false, offset, n, &n);
+                ret = bdrv_is_allocated_above(bdrv_cow_bs(unfiltered_bs),
+                                              prefix_chain_bs, false,
+                                              offset, n, &n);
                 if (ret < 0) {
                     error_report("error while reading image metadata: %s",
                                  strerror(-ret));
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
-- 
2.26.2


