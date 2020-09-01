Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EE0C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:01:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F3AA206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOx6liXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F3AA206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7n5-0003pD-4F
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kD7O9-0001Xw-1V
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:35:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58100)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kD7O6-0007RH-It
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598970953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DmcCofWBkRFsNkjz0Qop49nemZ+O2q0OpEE/elnIQlg=;
 b=DOx6liXAwO9WNblJ5MJozdZLHIJsZ06ABftZidtVwvEAq6hmClfzUNXiwBUTGHxAyWajqP
 J1iCOmKBjojtBq86ma6fpGdqN5W2R7bH+e8OKWnPytCxoMYDoZ5N/XEVffZAnmqurvIP6l
 /t+60R0+0JmPSO0u3pQ+zRmXSXRloQo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-UnJkMmViPPKWNQL8yDDCgg-1; Tue, 01 Sep 2020 10:35:48 -0400
X-MC-Unique: UnJkMmViPPKWNQL8yDDCgg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5430B801AEC;
 Tue,  1 Sep 2020 14:35:47 +0000 (UTC)
Received: from localhost (ovpn-113-83.ams2.redhat.com [10.36.113.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E37B85D9DC;
 Tue,  1 Sep 2020 14:35:46 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v8 33/43] qemu-img: Use child access functions
Date: Tue,  1 Sep 2020 16:34:14 +0200
Message-Id: <20200901143424.884735-34-mreitz@redhat.com>
In-Reply-To: <20200901143424.884735-1-mreitz@redhat.com>
References: <20200901143424.884735-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 23:17:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
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
 qemu-img.c                 | 43 +++++++++++++++++++++++---------------
 tests/qemu-iotests/204.out |  1 +
 2 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 5308773811..f3602dbfff 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1084,7 +1084,7 @@ static int img_commit(int argc, char **argv)
         /* This is different from QMP, which by default uses the deepest file in
          * the backing chain (i.e., the very base); however, the traditional
          * behavior of qemu-img commit is using the immediate backing file. */
-        base_bs = backing_bs(bs);
+        base_bs = bdrv_backing_chain_next(bs);
         if (!base_bs) {
             error_setg(&local_err, "Image does not have a backing file");
             goto done;
@@ -1731,18 +1731,20 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
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
@@ -2664,7 +2666,8 @@ static int img_convert(int argc, char **argv)
          * s.target_backing_sectors has to be negative, which it will
          * be automatically).  The backing file length is used only
          * for optimizations, so such a case is not fatal. */
-        s.target_backing_sectors = bdrv_nb_sectors(out_bs->backing->bs);
+        s.target_backing_sectors =
+            bdrv_nb_sectors(bdrv_backing_chain_next(out_bs));
     } else {
         s.target_backing_sectors = -1;
     }
@@ -3034,6 +3037,7 @@ static int get_block_status(BlockDriverState *bs, int64_t offset,
 
     depth = 0;
     for (;;) {
+        bs = bdrv_skip_filters(bs);
         ret = bdrv_block_status(bs, offset, bytes, &bytes, &map, &file);
         if (ret < 0) {
             return ret;
@@ -3042,7 +3046,7 @@ static int get_block_status(BlockDriverState *bs, int64_t offset,
         if (ret & (BDRV_BLOCK_ZERO|BDRV_BLOCK_DATA)) {
             break;
         }
-        bs = backing_bs(bs);
+        bs = bdrv_cow_bs(bs);
         if (bs == NULL) {
             ret = 0;
             break;
@@ -3424,6 +3428,7 @@ static int img_rebase(int argc, char **argv)
     uint8_t *buf_old = NULL;
     uint8_t *buf_new = NULL;
     BlockDriverState *bs = NULL, *prefix_chain_bs = NULL;
+    BlockDriverState *unfiltered_bs;
     char *filename;
     const char *fmt, *cache, *src_cache, *out_basefmt, *out_baseimg;
     int c, flags, src_flags, ret;
@@ -3558,6 +3563,8 @@ static int img_rebase(int argc, char **argv)
     }
     bs = blk_bs(blk);
 
+    unfiltered_bs = bdrv_skip_filters(bs);
+
     if (out_basefmt != NULL) {
         if (bdrv_find_format(out_basefmt) == NULL) {
             error_report("Invalid format name: '%s'", out_basefmt);
@@ -3569,7 +3576,7 @@ static int img_rebase(int argc, char **argv)
     /* For safe rebasing we need to compare old and new backing file */
     if (!unsafe) {
         QDict *options = NULL;
-        BlockDriverState *base_bs = backing_bs(bs);
+        BlockDriverState *base_bs = bdrv_cow_bs(unfiltered_bs);
 
         if (base_bs) {
             blk_old_backing = blk_new(qemu_get_aio_context(),
@@ -3710,7 +3717,7 @@ static int img_rebase(int argc, char **argv)
             n = MIN(IO_BUF_SIZE, size - offset);
 
             /* If the cluster is allocated, we don't need to take action */
-            ret = bdrv_is_allocated(bs, offset, n, &n);
+            ret = bdrv_is_allocated(unfiltered_bs, offset, n, &n);
             if (ret < 0) {
                 error_report("error while reading image metadata: %s",
                              strerror(-ret));
@@ -3725,8 +3732,9 @@ static int img_rebase(int argc, char **argv)
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
@@ -3804,9 +3812,10 @@ static int img_rebase(int argc, char **argv)
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
2.26.2


