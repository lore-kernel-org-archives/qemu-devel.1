Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACECC34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:10:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 708792070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708792070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3i26-0000da-JF
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 10:10:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39271)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j3hvk-0004ye-VT
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:03:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j3hvj-0007aR-37
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:03:28 -0500
Received: from relay.sw.ru ([185.231.240.75]:47544)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j3hvi-0007Rc-Pu; Mon, 17 Feb 2020 10:03:26 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1j3hvE-0007Zt-JO; Mon, 17 Feb 2020 18:02:56 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/22] migration/block-dirty-bitmap: relax error handling
 in incoming part
Date: Mon, 17 Feb 2020 18:02:33 +0300
Message-Id: <20200217150246.29180-10-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200217150246.29180-1-vsementsov@virtuozzo.com>
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 quintela@redhat.com, dgilbert@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, andrey.shinkevich@virtuozzo.com,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Bitmaps data is not critical, and we should not fail the migration (or
use postcopy recovering) because of dirty-bitmaps migration failure.
Instead we should just lose unfinished bitmaps.

Still we have to report io stream violation errors, as they affect the
whole migration stream.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 migration/block-dirty-bitmap.c | 148 +++++++++++++++++++++++++--------
 1 file changed, 113 insertions(+), 35 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 1329db8d7d..aea5326804 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -145,6 +145,15 @@ typedef struct DBMLoadState {
 
     bool before_vm_start_handled; /* set in dirty_bitmap_mig_before_vm_start */
 
+    /*
+     * cancelled
+     * Incoming migration is cancelled for some reason. That means that we
+     * still should read our chunks from migration stream, to not affect other
+     * migration objects (like RAM), but just ignore them and do not touch any
+     * bitmaps or nodes.
+     */
+    bool cancelled;
+
     GSList *bitmaps;
     QemuMutex lock; /* protect bitmaps */
 } DBMLoadState;
@@ -545,13 +554,47 @@ void dirty_bitmap_mig_before_vm_start(void)
     qemu_mutex_unlock(&s->lock);
 }
 
+static void cancel_incoming_locked(DBMLoadState *s)
+{
+    GSList *item;
+
+    if (s->cancelled) {
+        return;
+    }
+
+    s->cancelled = true;
+    s->bs = NULL;
+    s->bitmap = NULL;
+
+    /* Drop all unfinished bitmaps */
+    for (item = s->bitmaps; item; item = g_slist_next(item)) {
+        LoadBitmapState *b = item->data;
+
+        /*
+         * Bitmap must be unfinished, as finished bitmaps should already be
+         * removed from the list.
+         */
+        assert(!s->before_vm_start_handled || !b->migrated);
+        if (bdrv_dirty_bitmap_has_successor(b->bitmap)) {
+            bdrv_reclaim_dirty_bitmap(b->bitmap, &error_abort);
+        }
+        bdrv_release_dirty_bitmap(b->bitmap);
+    }
+
+    g_slist_free_full(s->bitmaps, g_free);
+    s->bitmaps = NULL;
+}
+
 static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
 {
     GSList *item;
     trace_dirty_bitmap_load_complete();
-    bdrv_dirty_bitmap_deserialize_finish(s->bitmap);
 
-    qemu_mutex_lock(&s->lock);
+    if (s->cancelled) {
+        return;
+    }
+
+    bdrv_dirty_bitmap_deserialize_finish(s->bitmap);
 
     if (bdrv_dirty_bitmap_has_successor(s->bitmap)) {
         bdrv_reclaim_dirty_bitmap(s->bitmap, &error_abort);
@@ -569,8 +612,6 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
             break;
         }
     }
-
-    qemu_mutex_unlock(&s->lock);
 }
 
 static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
@@ -582,15 +623,32 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
 
     if (s->flags & DIRTY_BITMAP_MIG_FLAG_ZEROES) {
         trace_dirty_bitmap_load_bits_zeroes();
-        bdrv_dirty_bitmap_deserialize_zeroes(s->bitmap, first_byte, nr_bytes,
-                                             false);
+        if (!s->cancelled) {
+            bdrv_dirty_bitmap_deserialize_zeroes(s->bitmap, first_byte,
+                                                 nr_bytes, false);
+        }
     } else {
         size_t ret;
         uint8_t *buf;
         uint64_t buf_size = qemu_get_be64(f);
-        uint64_t needed_size =
-            bdrv_dirty_bitmap_serialization_size(s->bitmap,
-                                                 first_byte, nr_bytes);
+        uint64_t needed_size;
+
+        buf = g_malloc(buf_size);
+        ret = qemu_get_buffer(f, buf, buf_size);
+        if (ret != buf_size) {
+            error_report("Failed to read bitmap bits");
+            g_free(buf);
+            return -EIO;
+        }
+
+        if (s->cancelled) {
+            g_free(buf);
+            return 0;
+        }
+
+        needed_size = bdrv_dirty_bitmap_serialization_size(s->bitmap,
+                                                           first_byte,
+                                                           nr_bytes);
 
         if (needed_size > buf_size ||
             buf_size > QEMU_ALIGN_UP(needed_size, 4 * sizeof(long))
@@ -599,15 +657,8 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
             error_report("Migrated bitmap granularity doesn't "
                          "match the destination bitmap '%s' granularity",
                          bdrv_dirty_bitmap_name(s->bitmap));
-            return -EINVAL;
-        }
-
-        buf = g_malloc(buf_size);
-        ret = qemu_get_buffer(f, buf, buf_size);
-        if (ret != buf_size) {
-            error_report("Failed to read bitmap bits");
-            g_free(buf);
-            return -EIO;
+            cancel_incoming_locked(s);
+            return 0;
         }
 
         bdrv_dirty_bitmap_deserialize_part(s->bitmap, buf, first_byte, nr_bytes,
@@ -632,14 +683,16 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s)
             error_report("Unable to read node name string");
             return -EINVAL;
         }
-        s->bs = bdrv_lookup_bs(s->node_name, s->node_name, &local_err);
-        if (!s->bs) {
-            error_report_err(local_err);
-            return -EINVAL;
+        if (!s->cancelled) {
+            s->bs = bdrv_lookup_bs(s->node_name, s->node_name, &local_err);
+            if (!s->bs) {
+                error_report_err(local_err);
+                cancel_incoming_locked(s);
+            }
         }
-    } else if (!s->bs && !nothing) {
+    } else if (!s->bs && !nothing && !s->cancelled) {
         error_report("Error: block device name is not set");
-        return -EINVAL;
+        cancel_incoming_locked(s);
     }
 
     if (s->flags & DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME) {
@@ -647,24 +700,38 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s)
             error_report("Unable to read bitmap name string");
             return -EINVAL;
         }
-        s->bitmap = bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);
-
-        /* bitmap may be NULL here, it wouldn't be an error if it is the
-         * first occurrence of the bitmap */
-        if (!s->bitmap && !(s->flags & DIRTY_BITMAP_MIG_FLAG_START)) {
-            error_report("Error: unknown dirty bitmap "
-                         "'%s' for block device '%s'",
-                         s->bitmap_name, s->node_name);
-            return -EINVAL;
+        if (!s->cancelled) {
+            s->bitmap = bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);
+
+            /*
+             * bitmap may be NULL here, it wouldn't be an error if it is the
+             * first occurrence of the bitmap
+             */
+            if (!s->bitmap && !(s->flags & DIRTY_BITMAP_MIG_FLAG_START)) {
+                error_report("Error: unknown dirty bitmap "
+                             "'%s' for block device '%s'",
+                             s->bitmap_name, s->node_name);
+                cancel_incoming_locked(s);
+            }
         }
-    } else if (!s->bitmap && !nothing) {
+    } else if (!s->bitmap && !nothing && !s->cancelled) {
         error_report("Error: block device name is not set");
-        return -EINVAL;
+        cancel_incoming_locked(s);
     }
 
     return 0;
 }
 
+/*
+ * dirty_bitmap_load
+ *
+ * Load sequence of dirty bitmap chunks. Return error only on fatal io stream
+ * violations. On other errors just cancel bitmaps incoming migration and return
+ * 0.
+ *
+ * Note, than when incoming bitmap migration is canceled, we still must read all
+ * our chunks (and just ignore them), to not affect other migration objects.
+ */
 static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
 {
     DBMLoadState *s = &((DBMState *)opaque)->load;
@@ -673,12 +740,19 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
     trace_dirty_bitmap_load_enter();
 
     if (version_id != 1) {
+        qemu_mutex_lock(&s->lock);
+        cancel_incoming_locked(s);
+        qemu_mutex_unlock(&s->lock);
         return -EINVAL;
     }
 
     do {
+        qemu_mutex_lock(&s->lock);
+
         ret = dirty_bitmap_load_header(f, s);
         if (ret < 0) {
+            cancel_incoming_locked(s);
+            qemu_mutex_unlock(&s->lock);
             return ret;
         }
 
@@ -695,8 +769,12 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
         }
 
         if (ret) {
+            cancel_incoming_locked(s);
+            qemu_mutex_unlock(&s->lock);
             return ret;
         }
+
+        qemu_mutex_unlock(&s->lock);
     } while (!(s->flags & DIRTY_BITMAP_MIG_FLAG_EOS));
 
     trace_dirty_bitmap_load_success();
-- 
2.21.0


