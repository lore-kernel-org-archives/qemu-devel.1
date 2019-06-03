Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4BBC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 12:18:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6435324460
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 12:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6435324460
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34329 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXlvM-0001dX-Kd
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 08:18:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hXlqU-00063n-QW
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 08:13:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hXldf-00025a-7T
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 08:00:34 -0400
Received: from relay.sw.ru ([185.231.240.75]:39508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hXldZ-00012A-M5; Mon, 03 Jun 2019 08:00:27 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hXldG-0002hc-AA; Mon, 03 Jun 2019 15:00:06 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Mon,  3 Jun 2019 15:00:02 +0300
Message-Id: <20190603120005.37394-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190603120005.37394-1-vsementsov@virtuozzo.com>
References: <20190603120005.37394-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 1/4] blockdev: reduce aio_context locked
 sections in bitmap add/remove
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
	armbru@redhat.com, mreitz@redhat.com,
	nshirokovskiy@virtuozzo.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 0a6c86d024c52 returned these locks back to add/remove
functionality, to protect from intersection of persistent bitmap
related IO with other IO. But other bitmap-related functions called
here are unrelated to the problem, and there are no needs to keep these
calls inside critical sections.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 blockdev.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 17c2d801d7..5b3eef0d3e 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2812,7 +2812,6 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
 {
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
-    AioContext *aio_context = NULL;
 
     if (!name || name[0] == '\0') {
         error_setg(errp, "Bitmap name cannot be empty");
@@ -2848,16 +2847,20 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
     }
 
     if (persistent) {
-        aio_context = bdrv_get_aio_context(bs);
+        AioContext *aio_context = bdrv_get_aio_context(bs);
+        bool ok;
+
         aio_context_acquire(aio_context);
-        if (!bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp)) {
-            goto out;
+        ok = bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp);
+        aio_context_release(aio_context);
+        if (!ok) {
+            return;
         }
     }
 
     bitmap = bdrv_create_dirty_bitmap(bs, granularity, name, errp);
     if (bitmap == NULL) {
-        goto out;
+        return;
     }
 
     if (disabled) {
@@ -2865,10 +2868,6 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
     }
 
     bdrv_dirty_bitmap_set_persistence(bitmap, persistent);
- out:
-    if (aio_context) {
-        aio_context_release(aio_context);
-    }
 }
 
 void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
@@ -2876,8 +2875,6 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
 {
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
-    Error *local_err = NULL;
-    AioContext *aio_context = NULL;
 
     bitmap = block_dirty_bitmap_lookup(node, name, &bs, errp);
     if (!bitmap || !bs) {
@@ -2890,20 +2887,19 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
     }
 
     if (bdrv_dirty_bitmap_get_persistence(bitmap)) {
-        aio_context = bdrv_get_aio_context(bs);
+        AioContext *aio_context = bdrv_get_aio_context(bs);
+        Error *local_err = NULL;
+
         aio_context_acquire(aio_context);
         bdrv_remove_persistent_dirty_bitmap(bs, name, &local_err);
+        aio_context_release(aio_context);
         if (local_err != NULL) {
             error_propagate(errp, local_err);
-            goto out;
+            return;
         }
     }
 
     bdrv_release_dirty_bitmap(bs, bitmap);
- out:
-    if (aio_context) {
-        aio_context_release(aio_context);
-    }
 }
 
 /**
-- 
2.18.0


