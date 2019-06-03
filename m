Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A30C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 12:17:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19091280C0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 12:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19091280C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34289 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXltl-0000Kx-B2
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 08:17:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hXlqV-0006EI-6D
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 08:13:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hXldU-0001be-F5
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 08:00:25 -0400
Received: from relay.sw.ru ([185.231.240.75]:39510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hXldR-000128-0x; Mon, 03 Jun 2019 08:00:20 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hXldG-0002hc-HO; Mon, 03 Jun 2019 15:00:06 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Mon,  3 Jun 2019 15:00:03 +0300
Message-Id: <20190603120005.37394-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190603120005.37394-1-vsementsov@virtuozzo.com>
References: <20190603120005.37394-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 2/4] block/dirty-bitmap: add hide/unhide API
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

Add functionality to make bitmap temporary anonymous. It will be used
to implement bitmap remove transaction action. We need hide bitmap
persistence too, as there are should not be unnamed persistent bitmaps.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/dirty-bitmap.h |  2 ++
 block/dirty-bitmap.c         | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 8044ace63e..542e437123 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -116,5 +116,7 @@ bool bdrv_dirty_bitmap_next_dirty_area(BdrvDirtyBitmap *bitmap,
 BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
                                                   BdrvDirtyBitmap *bitmap,
                                                   Error **errp);
+void bdrv_dirty_bitmap_hide(BdrvDirtyBitmap *bitmap);
+void bdrv_dirty_bitmap_unhide(BdrvDirtyBitmap *bitmap);
 
 #endif
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 49646a30e6..592964635e 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -35,6 +35,10 @@ struct BdrvDirtyBitmap {
     bool busy;                  /* Bitmap is busy, it can't be used via QMP */
     BdrvDirtyBitmap *successor; /* Anonymous child, if any. */
     char *name;                 /* Optional non-empty unique ID */
+    char *hidden_name;          /* Backup of @name for removal transaction
+                                   action. Used for hide/unhide API. */
+    bool hidden_persistent;     /* Backup of @persistent for removal transaction
+                                   action. */
     int64_t size;               /* Size of the bitmap, in bytes */
     bool disabled;              /* Bitmap is disabled. It ignores all writes to
                                    the device */
@@ -849,3 +853,25 @@ out:
         qemu_mutex_unlock(src->mutex);
     }
 }
+
+void bdrv_dirty_bitmap_hide(BdrvDirtyBitmap *bitmap)
+{
+    qemu_mutex_lock(bitmap->mutex);
+    assert(!bitmap->hidden_name);
+    bitmap->hidden_name = bitmap->name;
+    bitmap->hidden_persistent = bitmap->persistent;
+    bitmap->name = NULL;
+    bitmap->persistent = false;
+    qemu_mutex_unlock(bitmap->mutex);
+}
+
+void bdrv_dirty_bitmap_unhide(BdrvDirtyBitmap *bitmap)
+{
+    qemu_mutex_lock(bitmap->mutex);
+    assert(!bitmap->name);
+    bitmap->name = bitmap->hidden_name;
+    bitmap->persistent = bitmap->hidden_persistent;
+    bitmap->hidden_name = NULL;
+    bitmap->hidden_persistent = false;
+    qemu_mutex_unlock(bitmap->mutex);
+}
-- 
2.18.0


