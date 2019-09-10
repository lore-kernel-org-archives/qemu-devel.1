Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84DDC49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:29:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACC7E20872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC7E20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7j1R-0006mS-Pj
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 12:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i7izL-0004qr-FE
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:27:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i7izK-0003UC-3w
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:27:31 -0400
Received: from relay.sw.ru ([185.231.240.75]:44320)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i7izH-0003Q6-C1; Tue, 10 Sep 2019 12:27:27 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1i7izE-0001NT-9d; Tue, 10 Sep 2019 19:27:24 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Tue, 10 Sep 2019 19:27:22 +0300
Message-Id: <20190910162724.79574-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190910162724.79574-1-vsementsov@virtuozzo.com>
References: <20190910162724.79574-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 1/3] block: move
 bdrv_can_store_new_dirty_bitmap to block/dirty-bitmap.c
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

block/dirty-bitmap.c seems to be more appropriate for it and
bdrv_remove_persistent_dirty_bitmap already in it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block.c              | 22 ----------------------
 block/dirty-bitmap.c | 22 ++++++++++++++++++++++
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/block.c b/block.c
index 5944124845..bea03cfcc9 100644
--- a/block.c
+++ b/block.c
@@ -6555,25 +6555,3 @@ void bdrv_del_child(BlockDriverState *parent_bs, BdrvChild *child, Error **errp)
 
     parent_bs->drv->bdrv_del_child(parent_bs, child, errp);
 }
-
-bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
-                                     uint32_t granularity, Error **errp)
-{
-    BlockDriver *drv = bs->drv;
-
-    if (!drv) {
-        error_setg_errno(errp, ENOMEDIUM,
-                         "Can't store persistent bitmaps to %s",
-                         bdrv_get_device_or_node_name(bs));
-        return false;
-    }
-
-    if (!drv->bdrv_can_store_new_dirty_bitmap) {
-        error_setg_errno(errp, ENOTSUP,
-                         "Can't store persistent bitmaps to %s",
-                         bdrv_get_device_or_node_name(bs));
-        return false;
-    }
-
-    return drv->bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp);
-}
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 134e0c9a0c..8f42015db9 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -464,6 +464,28 @@ void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
     }
 }
 
+bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
+                                     uint32_t granularity, Error **errp)
+{
+    BlockDriver *drv = bs->drv;
+
+    if (!drv) {
+        error_setg_errno(errp, ENOMEDIUM,
+                         "Can't store persistent bitmaps to %s",
+                         bdrv_get_device_or_node_name(bs));
+        return false;
+    }
+
+    if (!drv->bdrv_can_store_new_dirty_bitmap) {
+        error_setg_errno(errp, ENOTSUP,
+                         "Can't store persistent bitmaps to %s",
+                         bdrv_get_device_or_node_name(bs));
+        return false;
+    }
+
+    return drv->bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp);
+}
+
 void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
 {
     bdrv_dirty_bitmap_lock(bitmap);
-- 
2.18.0


