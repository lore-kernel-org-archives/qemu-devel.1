Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A3EC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8DE22054F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpR1kQpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8DE22054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFFMK-0003Zx-NV
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 07:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFF31-0003on-7O
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:10:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26259)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFF2x-0008F2-Ov
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599477050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CPPCjm4JyV7krEx1VqRUHZ9wfHPiTqjW8iAraUV9qLI=;
 b=cpR1kQpUXn7aoBnyCzWITKCFGAvy9ztQLw8Y5q43WlG5e4nwG98kqTltuHZCwV8Ovaosds
 hsQfOniZ4kRdMoVUgAZrpOup59XwJGQJv+0lOCcHb4Czcqk6gkx655hP5iGNHKc7Rz788u
 qq1SGT4q+xl5QgLYJeP0M2YgQExFOXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-IZUF_06wNQiOpEqeFOwbEA-1; Mon, 07 Sep 2020 07:10:49 -0400
X-MC-Unique: IZUF_06wNQiOpEqeFOwbEA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0176A1007461;
 Mon,  7 Sep 2020 11:10:48 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-154.ams2.redhat.com
 [10.36.114.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EDFBF9CBA;
 Mon,  7 Sep 2020 11:10:46 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 49/64] qemu-img: Use child access functions
Date: Mon,  7 Sep 2020 13:09:21 +0200
Message-Id: <20200907110936.261684-50-kwolf@redhat.com>
In-Reply-To: <20200907110936.261684-1-kwolf@redhat.com>
References: <20200907110936.261684-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:52:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

This changes iotest 204's output, because blkdebug on top of a COW node
used to make qemu-img map disregard the rest of the backing chain (the
backing chain was broken by the filter).  With this patch, the
allocation in the base image is reported correctly.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c                 | 43 +++++++++++++++++++++++---------------
 tests/qemu-iotests/204.out |  1 +
 2 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index eb2fc1f862..d0b1c97562 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1085,7 +1085,7 @@ static int img_commit(int argc, char **argv)
         /* This is different from QMP, which by default uses the deepest file in
          * the backing chain (i.e., the very base); however, the traditional
          * behavior of qemu-img commit is using the immediate backing file. */
-        base_bs = backing_bs(bs);
+        base_bs = bdrv_backing_chain_next(bs);
         if (!base_bs) {
             error_setg(&local_err, "Image does not have a backing file");
             goto done;
@@ -1732,18 +1732,20 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
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
@@ -2665,7 +2667,8 @@ static int img_convert(int argc, char **argv)
          * s.target_backing_sectors has to be negative, which it will
          * be automatically).  The backing file length is used only
          * for optimizations, so such a case is not fatal. */
-        s.target_backing_sectors = bdrv_nb_sectors(out_bs->backing->bs);
+        s.target_backing_sectors =
+            bdrv_nb_sectors(bdrv_backing_chain_next(out_bs));
     } else {
         s.target_backing_sectors = -1;
     }
@@ -3035,6 +3038,7 @@ static int get_block_status(BlockDriverState *bs, int64_t offset,
 
     depth = 0;
     for (;;) {
+        bs = bdrv_skip_filters(bs);
         ret = bdrv_block_status(bs, offset, bytes, &bytes, &map, &file);
         if (ret < 0) {
             return ret;
@@ -3043,7 +3047,7 @@ static int get_block_status(BlockDriverState *bs, int64_t offset,
         if (ret & (BDRV_BLOCK_ZERO|BDRV_BLOCK_DATA)) {
             break;
         }
-        bs = backing_bs(bs);
+        bs = bdrv_cow_bs(bs);
         if (bs == NULL) {
             ret = 0;
             break;
@@ -3425,6 +3429,7 @@ static int img_rebase(int argc, char **argv)
     uint8_t *buf_old = NULL;
     uint8_t *buf_new = NULL;
     BlockDriverState *bs = NULL, *prefix_chain_bs = NULL;
+    BlockDriverState *unfiltered_bs;
     char *filename;
     const char *fmt, *cache, *src_cache, *out_basefmt, *out_baseimg;
     int c, flags, src_flags, ret;
@@ -3559,6 +3564,8 @@ static int img_rebase(int argc, char **argv)
     }
     bs = blk_bs(blk);
 
+    unfiltered_bs = bdrv_skip_filters(bs);
+
     if (out_basefmt != NULL) {
         if (bdrv_find_format(out_basefmt) == NULL) {
             error_report("Invalid format name: '%s'", out_basefmt);
@@ -3570,7 +3577,7 @@ static int img_rebase(int argc, char **argv)
     /* For safe rebasing we need to compare old and new backing file */
     if (!unsafe) {
         QDict *options = NULL;
-        BlockDriverState *base_bs = backing_bs(bs);
+        BlockDriverState *base_bs = bdrv_cow_bs(unfiltered_bs);
 
         if (base_bs) {
             blk_old_backing = blk_new(qemu_get_aio_context(),
@@ -3711,7 +3718,7 @@ static int img_rebase(int argc, char **argv)
             n = MIN(IO_BUF_SIZE, size - offset);
 
             /* If the cluster is allocated, we don't need to take action */
-            ret = bdrv_is_allocated(bs, offset, n, &n);
+            ret = bdrv_is_allocated(unfiltered_bs, offset, n, &n);
             if (ret < 0) {
                 error_report("error while reading image metadata: %s",
                              strerror(-ret));
@@ -3726,8 +3733,9 @@ static int img_rebase(int argc, char **argv)
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
@@ -3805,9 +3813,10 @@ static int img_rebase(int argc, char **argv)
      * doesn't change when we switch the backing file.
      */
     if (out_baseimg && *out_baseimg) {
-        ret = bdrv_change_backing_file(bs, out_baseimg, out_basefmt, true);
+        ret = bdrv_change_backing_file(unfiltered_bs, out_baseimg, out_basefmt,
+                                       true);
     } else {
-        ret = bdrv_change_backing_file(bs, NULL, NULL, false);
+        ret = bdrv_change_backing_file(unfiltered_bs, NULL, NULL, false);
     }
 
     if (ret == -ENOSPC) {
diff --git a/tests/qemu-iotests/204.out b/tests/qemu-iotests/204.out
index 457f72df8f..4d903d20ea 100644
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
2.25.4


