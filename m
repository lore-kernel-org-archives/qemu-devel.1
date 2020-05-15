Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C23C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:54:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A976720759
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HkiO9jDS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A976720759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZZqt-0000YB-Qg
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 08:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZip-0002Xc-Vx
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:45:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53011
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZim-00029J-FU
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589546747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gLP1vSf5gjXtk+qahPllKtJXXNWmS0u8AqefUbRbHVY=;
 b=HkiO9jDSzUeH7YK1eXexSbCGst6Qb+dl6k47YOoapblJGUj2GiB6tDRkvUPknk08KYmiEd
 54K23/IwDMbiJKPr6mzGYPmjsafIQSd5zCsSvFfR4/E5B2sKFekaa2twFO6FqeQC5wU+c3
 l7wIOeQxpS70kR2Sx7bHp/8H5ptD21w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-9SQ6hxL7N0qNk5AK1D8naA-1; Fri, 15 May 2020 08:45:43 -0400
X-MC-Unique: 9SQ6hxL7N0qNk5AK1D8naA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADD8019200C2;
 Fri, 15 May 2020 12:45:42 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-110.ams2.redhat.com
 [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B2CBB2E16F;
 Fri, 15 May 2020 12:45:41 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 10/51] block: Use blk_make_empty() after commits
Date: Fri, 15 May 2020 14:44:40 +0200
Message-Id: <20200515124521.335403-11-kwolf@redhat.com>
In-Reply-To: <20200515124521.335403-1-kwolf@redhat.com>
References: <20200515124521.335403-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

bdrv_commit() already has a BlockBackend pointing to the BDS that we
want to empty, it just has the wrong permissions.

qemu-img commit has no BlockBackend pointing to the old backing file
yet, but introducing one is simple.

After this commit, bdrv_make_empty() is the only remaining caller of
BlockDriver.bdrv_make_empty().

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200429141126.85159-5-mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[kwolf: Fixed up reference output for 098]
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/commit.c             | 16 +++++++++-------
 qemu-img.c                 | 19 ++++++++++++++-----
 tests/qemu-iotests/098.out |  8 ++++----
 3 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 87f6096d90..ba60fb7955 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -414,7 +414,9 @@ int bdrv_commit(BlockDriverState *bs)
     }
 
     ctx = bdrv_get_aio_context(bs);
-    src = blk_new(ctx, BLK_PERM_CONSISTENT_READ, BLK_PERM_ALL);
+    /* WRITE_UNCHANGED is required for bdrv_make_empty() */
+    src = blk_new(ctx, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED,
+                  BLK_PERM_ALL);
     backing = blk_new(ctx, BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
 
     ret = blk_insert_bs(src, bs, &local_err);
@@ -492,14 +494,14 @@ int bdrv_commit(BlockDriverState *bs)
         }
     }
 
-    if (drv->bdrv_make_empty) {
-        ret = drv->bdrv_make_empty(bs);
-        if (ret < 0) {
-            goto ro_cleanup;
-        }
-        blk_flush(src);
+    ret = blk_make_empty(src, NULL);
+    /* Ignore -ENOTSUP */
+    if (ret < 0 && ret != -ENOTSUP) {
+        goto ro_cleanup;
     }
 
+    blk_flush(src);
+
     /*
      * Make sure all data we wrote to the backing device is actually
      * stable on disk.
diff --git a/qemu-img.c b/qemu-img.c
index 6a4327aaba..f1795c788c 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1104,11 +1104,20 @@ static int img_commit(int argc, char **argv)
         goto unref_backing;
     }
 
-    if (!drop && bs->drv->bdrv_make_empty) {
-        ret = bs->drv->bdrv_make_empty(bs);
-        if (ret) {
-            error_setg_errno(&local_err, -ret, "Could not empty %s",
-                             filename);
+    if (!drop) {
+        BlockBackend *old_backing_blk;
+
+        old_backing_blk = blk_new_with_bs(bs, BLK_PERM_WRITE, BLK_PERM_ALL,
+                                          &local_err);
+        if (!old_backing_blk) {
+            goto unref_backing;
+        }
+        ret = blk_make_empty(old_backing_blk, &local_err);
+        blk_unref(old_backing_blk);
+        if (ret == -ENOTSUP) {
+            error_free(local_err);
+            local_err = NULL;
+        } else if (ret < 0) {
             goto unref_backing;
         }
     }
diff --git a/tests/qemu-iotests/098.out b/tests/qemu-iotests/098.out
index 7634d0e8b0..23cf371f53 100644
--- a/tests/qemu-iotests/098.out
+++ b/tests/qemu-iotests/098.out
@@ -6,7 +6,7 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-img: Could not empty blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFMT: Input/output error
+qemu-img: Failed to empty blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFMT: Input/output error
 No errors were found on the image.
 
 === empty_image_prepare ===
@@ -15,7 +15,7 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-img: Could not empty blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFMT: Input/output error
+qemu-img: Failed to empty blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFMT: Input/output error
 Leaked cluster 4 refcount=1 reference=0
 Leaked cluster 5 refcount=1 reference=0
 Repairing cluster 4 refcount=1 reference=0
@@ -28,7 +28,7 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-img: Could not empty blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFMT: Input/output error
+qemu-img: Failed to empty blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFMT: Input/output error
 ERROR cluster 0 refcount=0 reference=1
 ERROR cluster 1 refcount=0 reference=1
 ERROR cluster 3 refcount=0 reference=1
@@ -42,7 +42,7 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-img: Could not empty blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFMT: Input/output error
+qemu-img: Failed to empty blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFMT: Input/output error
 ERROR cluster 0 refcount=0 reference=1
 ERROR cluster 1 refcount=0 reference=1
 ERROR cluster 3 refcount=0 reference=1
-- 
2.25.4


