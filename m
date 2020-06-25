Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB42C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:28:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 078E52080C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSdu1vHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078E52080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joTnQ-0003Kt-BQ
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTiF-0005bD-NY
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:22:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23557
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTiD-0000kq-21
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593098568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RLFNTP6hPrIGk+fLU8DhCedPvZOQsvKQ/8DHyYcy8dc=;
 b=fSdu1vHmpTFcJskS/jqNd/3V5ElwiO+VmlirotTBJVqz9kKAyoOOBuWKWbn/UU+baaGTwm
 KYY4TsI26PxD80doe5+lPPUM8kNJso2uBN4ji7L9wdiUxskGTz9G3bddyAR3eujmHG+KP6
 lKX+y2WueDHWbfMVubiCre/xMnvvL/I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-_zaTl9X3PGedNEoCucYrxA-1; Thu, 25 Jun 2020 11:22:46 -0400
X-MC-Unique: _zaTl9X3PGedNEoCucYrxA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD3601005512;
 Thu, 25 Jun 2020 15:22:45 +0000 (UTC)
Received: from localhost (ovpn-113-182.ams2.redhat.com [10.36.113.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BDA45C296;
 Thu, 25 Jun 2020 15:22:45 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 12/47] block: Use bdrv_filter_(bs|child) where obvious
Date: Thu, 25 Jun 2020 17:21:40 +0200
Message-Id: <20200625152215.941773-13-mreitz@redhat.com>
In-Reply-To: <20200625152215.941773-1-mreitz@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
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
---
 block.c                        | 31 ++++++++++++++++++++-----------
 block/io.c                     |  7 +++++--
 migration/block-dirty-bitmap.c |  8 +-------
 3 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/block.c b/block.c
index 6449f3a11d..a44af9c3c1 100644
--- a/block.c
+++ b/block.c
@@ -710,11 +710,12 @@ int coroutine_fn bdrv_co_delete_file(BlockDriverState *bs, Error **errp)
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
@@ -729,11 +730,12 @@ int bdrv_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz)
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
@@ -5421,6 +5423,8 @@ int bdrv_has_zero_init_1(BlockDriverState *bs)
 
 int bdrv_has_zero_init(BlockDriverState *bs)
 {
+    BlockDriverState *filtered;
+
     if (!bs->drv) {
         return 0;
     }
@@ -5433,8 +5437,10 @@ int bdrv_has_zero_init(BlockDriverState *bs)
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
@@ -5479,8 +5485,9 @@ int bdrv_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
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
@@ -6546,6 +6553,8 @@ int bdrv_amend_options(BlockDriverState *bs, QemuOpts *opts,
 bool bdrv_recurse_can_replace(BlockDriverState *bs,
                               BlockDriverState *to_replace)
 {
+    BlockDriverState *filtered;
+
     if (!bs || !bs->drv) {
         return false;
     }
@@ -6560,9 +6569,9 @@ bool bdrv_recurse_can_replace(BlockDriverState *bs,
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
index df8f2a98d4..385176b331 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3307,6 +3307,7 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
                                   Error **errp)
 {
     BlockDriverState *bs = child->bs;
+    BdrvChild *filtered;
     BlockDriver *drv = bs->drv;
     BdrvTrackedRequest req;
     int64_t old_size, new_bytes;
@@ -3358,6 +3359,8 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
         goto out;
     }
 
+    filtered = bdrv_filter_child(bs);
+
     /*
      * If the image has a backing file that is large enough that it would
      * provide data for the new area, we cannot leave it unallocated because
@@ -3390,8 +3393,8 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
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
index 47bc0f650c..dec656c074 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -356,13 +356,7 @@ static int init_dirty_bitmap_migration(void)
         while (bs && bs->drv && bs->drv->is_filter &&
                !bdrv_has_named_bitmaps(bs))
         {
-            if (bs->backing) {
-                bs = bs->backing->bs;
-            } else if (bs->file) {
-                bs = bs->file->bs;
-            } else {
-                bs = NULL;
-            }
+            bs = bdrv_filter_bs(bs);
         }
 
         if (bs && bs->drv && !bs->drv->is_filter) {
-- 
2.26.2


