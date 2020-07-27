Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68B5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 21:02:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC0A20729
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 21:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dAqYMS6d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC0A20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0AGl-0006ym-Py
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 17:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0AAd-0005Vn-Vz
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:56:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59247
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0AAZ-0004yh-Qb
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595883382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kQPGEaurRWylMezQbdlsxycojMuLC7uNHt6+OKArsZ0=;
 b=dAqYMS6d+N7R26qUmrgiUj8mMiVei1H6hbkVJUzjHy7ZuJgufE2h1zvxPUqeKF4n3kAKnZ
 giBOGDeXZuwcuxDJdmEIqXKTxVyjLbGx+WX+JKJCf7vfw3MBR0VKPZuQ+zPYhgBEgZxsnU
 E7SzhyDA8zyU54aIIIAH9KQt85Hm+pY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-D64mk4X_MI6TZFIcNH0NIg-1; Mon, 27 Jul 2020 16:56:20 -0400
X-MC-Unique: D64mk4X_MI6TZFIcNH0NIg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40CD51005510;
 Mon, 27 Jul 2020 20:56:19 +0000 (UTC)
Received: from blue.redhat.com (ovpn-118-248.rdu2.redhat.com [10.10.118.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD34919724;
 Mon, 27 Jul 2020 20:56:17 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/24] migration/block-dirty-bitmap: keep bitmap state for all
 bitmaps
Date: Mon, 27 Jul 2020 15:55:34 -0500
Message-Id: <20200727205543.206624-16-eblake@redhat.com>
In-Reply-To: <20200727205543.206624-1-eblake@redhat.com>
References: <20200727205543.206624-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Dirty Bitmaps" <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Keep bitmap state for disabled bitmaps too. Keep the state until the
end of the process. It's needed for the following commit to implement
bitmap postcopy canceling.

To clean-up the new list the following logic is used:
We need two events to consider bitmap migration finished:
1. chunk with DIRTY_BITMAP_MIG_FLAG_COMPLETE flag should be received
2. dirty_bitmap_mig_before_vm_start should be called
These two events may come in any order, so we understand which one is
last, and on the last of them we remove bitmap migration state from the
list.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-Id: <20200727194236.19551-15-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 migration/block-dirty-bitmap.c | 64 +++++++++++++++++++++++-----------
 1 file changed, 43 insertions(+), 21 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 405a259296d9..eb4ffeac4d1b 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -132,6 +132,7 @@ typedef struct LoadBitmapState {
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
     bool migrated;
+    bool enabled;
 } LoadBitmapState;

 /* State of the dirty bitmap migration (DBM) during load process */
@@ -142,8 +143,10 @@ typedef struct DBMLoadState {
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;

-    GSList *enabled_bitmaps;
-    QemuMutex lock; /* protect enabled_bitmaps */
+    bool before_vm_start_handled; /* set in dirty_bitmap_mig_before_vm_start */
+
+    GSList *bitmaps;
+    QemuMutex lock; /* protect bitmaps */
 } DBMLoadState;

 typedef struct DBMState {
@@ -526,6 +529,7 @@ static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
     Error *local_err = NULL;
     uint32_t granularity = qemu_get_be32(f);
     uint8_t flags = qemu_get_byte(f);
+    LoadBitmapState *b;

     if (s->bitmap) {
         error_report("Bitmap with the same name ('%s') already exists on "
@@ -552,45 +556,59 @@ static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)

     bdrv_disable_dirty_bitmap(s->bitmap);
     if (flags & DIRTY_BITMAP_MIG_START_FLAG_ENABLED) {
-        LoadBitmapState *b;
-
         bdrv_dirty_bitmap_create_successor(s->bitmap, &local_err);
         if (local_err) {
             error_report_err(local_err);
             return -EINVAL;
         }
-
-        b = g_new(LoadBitmapState, 1);
-        b->bs = s->bs;
-        b->bitmap = s->bitmap;
-        b->migrated = false;
-        s->enabled_bitmaps = g_slist_prepend(s->enabled_bitmaps, b);
     }

+    b = g_new(LoadBitmapState, 1);
+    b->bs = s->bs;
+    b->bitmap = s->bitmap;
+    b->migrated = false;
+    b->enabled = flags & DIRTY_BITMAP_MIG_START_FLAG_ENABLED;
+
+    s->bitmaps = g_slist_prepend(s->bitmaps, b);
+
     return 0;
 }

-void dirty_bitmap_mig_before_vm_start(void)
+/*
+ * before_vm_start_handle_item
+ *
+ * g_slist_foreach helper
+ *
+ * item is LoadBitmapState*
+ * opaque is DBMLoadState*
+ */
+static void before_vm_start_handle_item(void *item, void *opaque)
 {
-    DBMLoadState *s = &dbm_state.load;
-    GSList *item;
-
-    qemu_mutex_lock(&s->lock);
-
-    for (item = s->enabled_bitmaps; item; item = g_slist_next(item)) {
-        LoadBitmapState *b = item->data;
+    DBMLoadState *s = opaque;
+    LoadBitmapState *b = item;

+    if (b->enabled) {
         if (b->migrated) {
             bdrv_enable_dirty_bitmap(b->bitmap);
         } else {
             bdrv_dirty_bitmap_enable_successor(b->bitmap);
         }
+    }

+    if (b->migrated) {
+        s->bitmaps = g_slist_remove(s->bitmaps, b);
         g_free(b);
     }
+}

-    g_slist_free(s->enabled_bitmaps);
-    s->enabled_bitmaps = NULL;
+void dirty_bitmap_mig_before_vm_start(void)
+{
+    DBMLoadState *s = &dbm_state.load;
+    qemu_mutex_lock(&s->lock);
+
+    assert(!s->before_vm_start_handled);
+    g_slist_foreach(s->bitmaps, before_vm_start_handle_item, s);
+    s->before_vm_start_handled = true;

     qemu_mutex_unlock(&s->lock);
 }
@@ -607,11 +625,15 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
         bdrv_reclaim_dirty_bitmap(s->bitmap, &error_abort);
     }

-    for (item = s->enabled_bitmaps; item; item = g_slist_next(item)) {
+    for (item = s->bitmaps; item; item = g_slist_next(item)) {
         LoadBitmapState *b = item->data;

         if (b->bitmap == s->bitmap) {
             b->migrated = true;
+            if (s->before_vm_start_handled) {
+                s->bitmaps = g_slist_remove(s->bitmaps, b);
+                g_free(b);
+            }
             break;
         }
     }
-- 
2.27.0


