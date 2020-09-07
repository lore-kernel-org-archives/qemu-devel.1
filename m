Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8996AC2BB84
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:22:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2168721473
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cGPNOv1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2168721473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFFEc-0001i1-2T
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 07:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFF2X-00030d-F7
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:10:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41142)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFF2V-00081z-57
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599477022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BwmTZxuNg9jnQJRhy28y7+k4VEptEp1j8w86bfCi1ac=;
 b=cGPNOv1BpPMuOvFaGgdHLvujxLgfm3886TUDnGZGsADcgKf0rMBRyex7g7YZyk07tujD9H
 4jUmmqnyAQodSjJD6nDdDmgrdkGyc0tUM9LDhZfnK1Q53yzUM1/aLB7tU+2Zy1lRGTpaWc
 yIeEbp4/y5MthtdhjjtcdfZpCp79um4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-2dmuvn23OYm7CL8q4a-SqQ-1; Mon, 07 Sep 2020 07:10:20 -0400
X-MC-Unique: 2dmuvn23OYm7CL8q4a-SqQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 050F11DDEF;
 Mon,  7 Sep 2020 11:10:19 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-154.ams2.redhat.com
 [10.36.114.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 12C8C9CBA;
 Mon,  7 Sep 2020 11:10:17 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 26/64] block: Use bdrv_filter_(bs|child) where obvious
Date: Mon,  7 Sep 2020 13:08:58 +0200
Message-Id: <20200907110936.261684-27-kwolf@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 05:27:53
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

Places that use patterns like

    if (bs->drv->is_filter && bs->file) {
        ... something about bs->file->bs ...
    }

should be

    BlockDriverState *filtered = bdrv_filter_bs(bs);
    if (filtered) {
        ... something about @filtered ...
    }

instead.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c                        | 31 ++++++++++++++++++++-----------
 block/io.c                     |  7 +++++--
 migration/block-dirty-bitmap.c |  8 +-------
 3 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/block.c b/block.c
index c09a766f54..887c125400 100644
--- a/block.c
+++ b/block.c
@@ -712,11 +712,12 @@ int coroutine_fn bdrv_co_delete_file(BlockDriverState *bs, Error **errp)
 int bdrv_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz)
 {
     BlockDriver *drv = bs->drv;
+    BlockDriverState *filtered = bdrv_filter_bs(bs);
 
     if (drv && drv->bdrv_probe_blocksizes) {
         return drv->bdrv_probe_blocksizes(bs, bsz);
-    } else if (drv && drv->is_filter && bs->file) {
-        return bdrv_probe_blocksizes(bs->file->bs, bsz);
+    } else if (filtered) {
+        return bdrv_probe_blocksizes(filtered, bsz);
     }
 
     return -ENOTSUP;
@@ -731,11 +732,12 @@ int bdrv_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz)
 int bdrv_probe_geometry(BlockDriverState *bs, HDGeometry *geo)
 {
     BlockDriver *drv = bs->drv;
+    BlockDriverState *filtered = bdrv_filter_bs(bs);
 
     if (drv && drv->bdrv_probe_geometry) {
         return drv->bdrv_probe_geometry(bs, geo);
-    } else if (drv && drv->is_filter && bs->file) {
-        return bdrv_probe_geometry(bs->file->bs, geo);
+    } else if (filtered) {
+        return bdrv_probe_geometry(filtered, geo);
     }
 
     return -ENOTSUP;
@@ -5442,6 +5444,8 @@ int bdrv_has_zero_init_1(BlockDriverState *bs)
 
 int bdrv_has_zero_init(BlockDriverState *bs)
 {
+    BlockDriverState *filtered;
+
     if (!bs->drv) {
         return 0;
     }
@@ -5454,8 +5458,10 @@ int bdrv_has_zero_init(BlockDriverState *bs)
     if (bs->drv->bdrv_has_zero_init) {
         return bs->drv->bdrv_has_zero_init(bs);
     }
-    if (bs->file && bs->drv->is_filter) {
-        return bdrv_has_zero_init(bs->file->bs);
+
+    filtered = bdrv_filter_bs(bs);
+    if (filtered) {
+        return bdrv_has_zero_init(filtered);
     }
 
     /* safe default */
@@ -5485,8 +5491,9 @@ int bdrv_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
         return -ENOMEDIUM;
     }
     if (!drv->bdrv_get_info) {
-        if (bs->file && drv->is_filter) {
-            return bdrv_get_info(bs->file->bs, bdi);
+        BlockDriverState *filtered = bdrv_filter_bs(bs);
+        if (filtered) {
+            return bdrv_get_info(filtered, bdi);
         }
         return -ENOTSUP;
     }
@@ -6571,6 +6578,8 @@ int bdrv_amend_options(BlockDriverState *bs, QemuOpts *opts,
 bool bdrv_recurse_can_replace(BlockDriverState *bs,
                               BlockDriverState *to_replace)
 {
+    BlockDriverState *filtered;
+
     if (!bs || !bs->drv) {
         return false;
     }
@@ -6585,9 +6594,9 @@ bool bdrv_recurse_can_replace(BlockDriverState *bs,
     }
 
     /* For filters without an own implementation, we can recurse on our own */
-    if (bs->drv->is_filter) {
-        BdrvChild *child = bs->file ?: bs->backing;
-        return bdrv_recurse_can_replace(child->bs, to_replace);
+    filtered = bdrv_filter_bs(bs);
+    if (filtered) {
+        return bdrv_recurse_can_replace(filtered, to_replace);
     }
 
     /* Safe default */
diff --git a/block/io.c b/block/io.c
index ad3a51ed53..01e3477a77 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3309,6 +3309,7 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
                                   Error **errp)
 {
     BlockDriverState *bs = child->bs;
+    BdrvChild *filtered;
     BlockDriver *drv = bs->drv;
     BdrvTrackedRequest req;
     int64_t old_size, new_bytes;
@@ -3360,6 +3361,8 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
         goto out;
     }
 
+    filtered = bdrv_filter_child(bs);
+
     /*
      * If the image has a backing file that is large enough that it would
      * provide data for the new area, we cannot leave it unallocated because
@@ -3392,8 +3395,8 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
             goto out;
         }
         ret = drv->bdrv_co_truncate(bs, offset, exact, prealloc, flags, errp);
-    } else if (bs->file && drv->is_filter) {
-        ret = bdrv_co_truncate(bs->file, offset, exact, prealloc, flags, errp);
+    } else if (filtered) {
+        ret = bdrv_co_truncate(filtered, offset, exact, prealloc, flags, errp);
     } else {
         error_setg(errp, "Image format driver does not support resize");
         ret = -ENOTSUP;
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 549e14daba..5bef793ac0 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -615,13 +615,7 @@ static int init_dirty_bitmap_migration(DBMSaveState *s)
             while (bs && bs->drv && bs->drv->is_filter &&
                    !bdrv_has_named_bitmaps(bs))
             {
-                if (bs->backing) {
-                    bs = bs->backing->bs;
-                } else if (bs->file) {
-                    bs = bs->file->bs;
-                } else {
-                    bs = NULL;
-                }
+                bs = bdrv_filter_bs(bs);
             }
 
             if (bs && bs->drv && !bs->drv->is_filter) {
-- 
2.25.4


