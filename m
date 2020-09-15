Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD332C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A609206DC
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6KVKm2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A609206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI8ew-0008QG-6X
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 06:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8UE-0000Vw-6G
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:46:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44851
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8U9-0004YH-7H
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600166811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uRc6w0dl/Uj4FKyh7RSAnGqYP+kLY3pq8JEWMrJQ+c0=;
 b=B6KVKm2Pqnr+WyYH6z1YKCiO1k6T8DoSh2lpe6p2ZAEld/yfF0dJz1FrREf9LGfqYvZmD3
 bRSUdoUjCWAHpPTYRnH21WX3ITryDPRd/ZRnPRaaYUar3b+KUgjJMSFFxagioRBqn1Auqp
 w/vdomVtyZyWrWNMtu3DiXswhlggPVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-QiucSzkkOAm7xKKfurwc0A-1; Tue, 15 Sep 2020 06:46:48 -0400
X-MC-Unique: QiucSzkkOAm7xKKfurwc0A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A393D64086;
 Tue, 15 Sep 2020 10:46:47 +0000 (UTC)
Received: from localhost (ovpn-113-7.ams2.redhat.com [10.36.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E24395F9C1;
 Tue, 15 Sep 2020 10:46:46 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 08/22] qcow2: Use macros for the L1,
 refcount and bitmap table entry sizes
Date: Tue, 15 Sep 2020 12:46:13 +0200
Message-Id: <20200915104627.699552-9-mreitz@redhat.com>
In-Reply-To: <20200915104627.699552-1-mreitz@redhat.com>
References: <20200915104627.699552-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:29:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

This patch replaces instances of sizeof(uint64_t) in the qcow2 driver
with macros that indicate what those sizes are actually referring to.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-Id: <20200828110828.13833-1-berto@igalia.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h          |  6 +++
 block/qcow2-bitmap.c   | 11 ++++--
 block/qcow2-cluster.c  | 24 ++++++------
 block/qcow2-refcount.c | 89 ++++++++++++++++++++++--------------------
 block/qcow2-snapshot.c | 20 +++++-----
 block/qcow2.c          | 27 ++++++-------
 6 files changed, 94 insertions(+), 83 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 065ec3df0b..83cfa0c391 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -99,6 +99,12 @@
 #define L2E_SIZE_NORMAL   (sizeof(uint64_t))
 #define L2E_SIZE_EXTENDED (sizeof(uint64_t) * 2)
 
+/* Size of L1 table entries */
+#define L1E_SIZE (sizeof(uint64_t))
+
+/* Size of reftable entries */
+#define REFTABLE_ENTRY_SIZE (sizeof(uint64_t))
+
 #define MIN_CLUSTER_BITS 9
 #define MAX_CLUSTER_BITS 21
 
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 8c34b2aef7..d7a31a8ddc 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -42,6 +42,9 @@
 #define BME_MIN_GRANULARITY_BITS 9
 #define BME_MAX_NAME_SIZE 1023
 
+/* Size of bitmap table entries */
+#define BME_TABLE_ENTRY_SIZE (sizeof(uint64_t))
+
 QEMU_BUILD_BUG_ON(BME_MAX_NAME_SIZE != BDRV_BITMAP_MAX_NAME_SIZE);
 
 #if BME_MAX_TABLE_SIZE * 8ULL > INT_MAX
@@ -232,7 +235,7 @@ static int bitmap_table_load(BlockDriverState *bs, Qcow2BitmapTable *tb,
 
     assert(tb->size <= BME_MAX_TABLE_SIZE);
     ret = bdrv_pread(bs->file, tb->offset,
-                     table, tb->size * sizeof(uint64_t));
+                     table, tb->size * BME_TABLE_ENTRY_SIZE);
     if (ret < 0) {
         goto fail;
     }
@@ -265,7 +268,7 @@ static int free_bitmap_clusters(BlockDriverState *bs, Qcow2BitmapTable *tb)
     }
 
     clear_bitmap_table(bs, bitmap_table, tb->size);
-    qcow2_free_clusters(bs, tb->offset, tb->size * sizeof(uint64_t),
+    qcow2_free_clusters(bs, tb->offset, tb->size * BME_TABLE_ENTRY_SIZE,
                         QCOW2_DISCARD_OTHER);
     g_free(bitmap_table);
 
@@ -690,7 +693,7 @@ int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
         ret = qcow2_inc_refcounts_imrt(bs, res,
                                        refcount_table, refcount_table_size,
                                        bm->table.offset,
-                                       bm->table.size * sizeof(uint64_t));
+                                       bm->table.size * BME_TABLE_ENTRY_SIZE);
         if (ret < 0) {
             goto out;
         }
@@ -1797,7 +1800,7 @@ uint64_t qcow2_get_persistent_dirty_bitmap_size(BlockDriverState *in_bs,
             /* Assume the entire bitmap is allocated */
             bitmaps_size += bmclusters * cluster_size;
             /* Also reserve space for the bitmap table entries */
-            bitmaps_size += ROUND_UP(bmclusters * sizeof(uint64_t),
+            bitmaps_size += ROUND_UP(bmclusters * BME_TABLE_ENTRY_SIZE,
                                      cluster_size);
             /* And space for contribution to bitmap directory size */
             bitmap_dir_size += calc_dir_entry_size(strlen(name), 0);
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index fcdf7af8e6..4530e5e471 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -47,8 +47,8 @@ int qcow2_shrink_l1_table(BlockDriverState *bs, uint64_t exact_size)
 
     BLKDBG_EVENT(bs->file, BLKDBG_L1_SHRINK_WRITE_TABLE);
     ret = bdrv_pwrite_zeroes(bs->file, s->l1_table_offset +
-                                       new_l1_size * sizeof(uint64_t),
-                             (s->l1_size - new_l1_size) * sizeof(uint64_t), 0);
+                                       new_l1_size * L1E_SIZE,
+                             (s->l1_size - new_l1_size) * L1E_SIZE, 0);
     if (ret < 0) {
         goto fail;
     }
@@ -76,7 +76,7 @@ fail:
      * l1_table in memory to avoid possible image corruption.
      */
     memset(s->l1_table + new_l1_size, 0,
-           (s->l1_size - new_l1_size) * sizeof(uint64_t));
+           (s->l1_size - new_l1_size) * L1E_SIZE);
     return ret;
 }
 
@@ -96,7 +96,7 @@ int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
     /* Do a sanity check on min_size before trying to calculate new_l1_size
      * (this prevents overflows during the while loop for the calculation of
      * new_l1_size) */
-    if (min_size > INT_MAX / sizeof(uint64_t)) {
+    if (min_size > INT_MAX / L1E_SIZE) {
         return -EFBIG;
     }
 
@@ -114,7 +114,7 @@ int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
     }
 
     QEMU_BUILD_BUG_ON(QCOW_MAX_L1_SIZE > INT_MAX);
-    if (new_l1_size > QCOW_MAX_L1_SIZE / sizeof(uint64_t)) {
+    if (new_l1_size > QCOW_MAX_L1_SIZE / L1E_SIZE) {
         return -EFBIG;
     }
 
@@ -123,7 +123,7 @@ int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
             s->l1_size, new_l1_size);
 #endif
 
-    new_l1_size2 = sizeof(uint64_t) * new_l1_size;
+    new_l1_size2 = L1E_SIZE * new_l1_size;
     new_l1_table = qemu_try_blockalign(bs->file->bs, new_l1_size2);
     if (new_l1_table == NULL) {
         return -ENOMEM;
@@ -131,7 +131,7 @@ int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
     memset(new_l1_table, 0, new_l1_size2);
 
     if (s->l1_size) {
-        memcpy(new_l1_table, s->l1_table, s->l1_size * sizeof(uint64_t));
+        memcpy(new_l1_table, s->l1_table, s->l1_size * L1E_SIZE);
     }
 
     /* write new table (align to cluster) */
@@ -180,7 +180,7 @@ int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
     s->l1_table = new_l1_table;
     old_l1_size = s->l1_size;
     s->l1_size = new_l1_size;
-    qcow2_free_clusters(bs, old_l1_table_offset, old_l1_size * sizeof(uint64_t),
+    qcow2_free_clusters(bs, old_l1_table_offset, old_l1_size * L1E_SIZE,
                         QCOW2_DISCARD_OTHER);
     return 0;
  fail:
@@ -225,9 +225,9 @@ int qcow2_write_l1_entry(BlockDriverState *bs, int l1_index)
     BDRVQcow2State *s = bs->opaque;
     int l1_start_index;
     int i, ret;
-    int bufsize = MAX(sizeof(uint64_t),
+    int bufsize = MAX(L1E_SIZE,
                       MIN(bs->file->bs->bl.request_alignment, s->cluster_size));
-    int nentries = bufsize / sizeof(uint64_t);
+    int nentries = bufsize / L1E_SIZE;
     g_autofree uint64_t *buf = g_try_new0(uint64_t, nentries);
 
     if (buf == NULL) {
@@ -2410,7 +2410,7 @@ int qcow2_expand_zero_clusters(BlockDriverState *bs,
         Error *local_err = NULL;
 
         ret = qcow2_validate_table(bs, s->snapshots[i].l1_table_offset,
-                                   s->snapshots[i].l1_size, sizeof(uint64_t),
+                                   s->snapshots[i].l1_size, L1E_SIZE,
                                    QCOW_MAX_L1_SIZE, "Snapshot L1 table",
                                    &local_err);
         if (ret < 0) {
@@ -2418,7 +2418,7 @@ int qcow2_expand_zero_clusters(BlockDriverState *bs,
             goto fail;
         }
 
-        l1_size2 = s->snapshots[i].l1_size * sizeof(uint64_t);
+        l1_size2 = s->snapshots[i].l1_size * L1E_SIZE;
         new_l1_table = g_try_realloc(l1_table, l1_size2);
 
         if (!new_l1_table) {
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index aae52607eb..51e9778ed8 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -105,8 +105,8 @@ int qcow2_refcount_init(BlockDriverState *bs)
     s->get_refcount = get_refcount_funcs[s->refcount_order];
     s->set_refcount = set_refcount_funcs[s->refcount_order];
 
-    assert(s->refcount_table_size <= INT_MAX / sizeof(uint64_t));
-    refcount_table_size2 = s->refcount_table_size * sizeof(uint64_t);
+    assert(s->refcount_table_size <= INT_MAX / REFTABLE_ENTRY_SIZE);
+    refcount_table_size2 = s->refcount_table_size * REFTABLE_ENTRY_SIZE;
     s->refcount_table = g_try_malloc(refcount_table_size2);
 
     if (s->refcount_table_size > 0) {
@@ -434,8 +434,8 @@ static int alloc_refcount_block(BlockDriverState *bs,
     if (refcount_table_index < s->refcount_table_size) {
         uint64_t data64 = cpu_to_be64(new_block);
         BLKDBG_EVENT(bs->file, BLKDBG_REFBLOCK_ALLOC_HOOKUP);
-        ret = bdrv_pwrite_sync(bs->file,
-            s->refcount_table_offset + refcount_table_index * sizeof(uint64_t),
+        ret = bdrv_pwrite_sync(bs->file, s->refcount_table_offset +
+                               refcount_table_index * REFTABLE_ENTRY_SIZE,
             &data64, sizeof(data64));
         if (ret < 0) {
             goto fail;
@@ -562,8 +562,8 @@ int64_t qcow2_refcount_area(BlockDriverState *bs, uint64_t start_offset,
                      DIV_ROUND_UP(total_refblock_count, 2);
     }
     /* The qcow2 file can only store the reftable size in number of clusters */
-    table_size = ROUND_UP(table_size, s->cluster_size / sizeof(uint64_t));
-    table_clusters = (table_size * sizeof(uint64_t)) / s->cluster_size;
+    table_size = ROUND_UP(table_size, s->cluster_size / REFTABLE_ENTRY_SIZE);
+    table_clusters = (table_size * REFTABLE_ENTRY_SIZE) / s->cluster_size;
 
     if (table_size > QCOW_MAX_REFTABLE_SIZE) {
         return -EFBIG;
@@ -581,13 +581,13 @@ int64_t qcow2_refcount_area(BlockDriverState *bs, uint64_t start_offset,
     if (table_size > s->max_refcount_table_index) {
         /* We're actually growing the reftable */
         memcpy(new_table, s->refcount_table,
-               (s->max_refcount_table_index + 1) * sizeof(uint64_t));
+               (s->max_refcount_table_index + 1) * REFTABLE_ENTRY_SIZE);
     } else {
         /* Improbable case: We're shrinking the reftable. However, the caller
          * has assured us that there is only empty space beyond @start_offset,
          * so we can simply drop all of the refblocks that won't fit into the
          * new reftable. */
-        memcpy(new_table, s->refcount_table, table_size * sizeof(uint64_t));
+        memcpy(new_table, s->refcount_table, table_size * REFTABLE_ENTRY_SIZE);
     }
 
     if (new_refblock_offset) {
@@ -682,7 +682,7 @@ int64_t qcow2_refcount_area(BlockDriverState *bs, uint64_t start_offset,
 
     BLKDBG_EVENT(bs->file, BLKDBG_REFBLOCK_ALLOC_WRITE_TABLE);
     ret = bdrv_pwrite_sync(bs->file, table_offset, new_table,
-        table_size * sizeof(uint64_t));
+        table_size * REFTABLE_ENTRY_SIZE);
     if (ret < 0) {
         goto fail;
     }
@@ -717,7 +717,8 @@ int64_t qcow2_refcount_area(BlockDriverState *bs, uint64_t start_offset,
     update_max_refcount_table_index(s);
 
     /* Free old table. */
-    qcow2_free_clusters(bs, old_table_offset, old_table_size * sizeof(uint64_t),
+    qcow2_free_clusters(bs, old_table_offset,
+                        old_table_size * REFTABLE_ENTRY_SIZE,
                         QCOW2_DISCARD_OTHER);
 
     return end_offset;
@@ -1253,7 +1254,7 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
 
     l2_slice = NULL;
     l1_table = NULL;
-    l1_size2 = l1_size * sizeof(uint64_t);
+    l1_size2 = l1_size * L1E_SIZE;
     slice_size2 = s->l2_slice_size * l2_entry_size(s);
     n_slices = s->cluster_size / slice_size2;
 
@@ -1784,7 +1785,7 @@ static int check_refcounts_l1(BlockDriverState *bs,
     uint64_t *l1_table = NULL, l2_offset, l1_size2;
     int i, ret;
 
-    l1_size2 = l1_size * sizeof(uint64_t);
+    l1_size2 = l1_size * L1E_SIZE;
 
     /* Mark L1 table as used */
     ret = qcow2_inc_refcounts_imrt(bs, res, refcount_table, refcount_table_size,
@@ -2146,7 +2147,7 @@ static int calculate_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
             res->corruptions++;
             continue;
         }
-        if (sn->l1_size > QCOW_MAX_L1_SIZE / sizeof(uint64_t)) {
+        if (sn->l1_size > QCOW_MAX_L1_SIZE / L1E_SIZE) {
             fprintf(stderr, "ERROR snapshot %s (%s) l1_size=%#" PRIx32 ": "
                     "L1 table is too large; snapshot table entry corrupted\n",
                     sn->id_str, sn->name, sn->l1_size);
@@ -2169,7 +2170,8 @@ static int calculate_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
     /* refcount data */
     ret = qcow2_inc_refcounts_imrt(bs, res, refcount_table, nb_clusters,
                                    s->refcount_table_offset,
-                                   s->refcount_table_size * sizeof(uint64_t));
+                                   s->refcount_table_size *
+                                   REFTABLE_ENTRY_SIZE);
     if (ret < 0) {
         return ret;
     }
@@ -2390,11 +2392,11 @@ write_refblocks:
             uint32_t old_reftable_size = reftable_size;
             uint64_t *new_on_disk_reftable;
 
-            reftable_size = ROUND_UP((refblock_index + 1) * sizeof(uint64_t),
-                                     s->cluster_size) / sizeof(uint64_t);
+            reftable_size = ROUND_UP((refblock_index + 1) * REFTABLE_ENTRY_SIZE,
+                                     s->cluster_size) / REFTABLE_ENTRY_SIZE;
             new_on_disk_reftable = g_try_realloc(on_disk_reftable,
                                                  reftable_size *
-                                                 sizeof(uint64_t));
+                                                 REFTABLE_ENTRY_SIZE);
             if (!new_on_disk_reftable) {
                 res->check_errors++;
                 ret = -ENOMEM;
@@ -2403,7 +2405,7 @@ write_refblocks:
             on_disk_reftable = new_on_disk_reftable;
 
             memset(on_disk_reftable + old_reftable_size, 0,
-                   (reftable_size - old_reftable_size) * sizeof(uint64_t));
+                   (reftable_size - old_reftable_size) * REFTABLE_ENTRY_SIZE);
 
             /* The offset we have for the reftable is now no longer valid;
              * this will leak that range, but we can easily fix that by running
@@ -2420,7 +2422,7 @@ write_refblocks:
             reftable_offset < 0)
         {
             uint64_t reftable_clusters = size_to_clusters(s, reftable_size *
-                                                          sizeof(uint64_t));
+                                                          REFTABLE_ENTRY_SIZE);
             reftable_offset = alloc_clusters_imrt(bs, reftable_clusters,
                                                   refcount_table, nb_clusters,
                                                   &first_free_cluster);
@@ -2460,8 +2462,8 @@ write_refblocks:
         uint64_t post_refblock_start, reftable_clusters;
 
         post_refblock_start = ROUND_UP(*nb_clusters, s->refcount_block_size);
-        reftable_clusters = size_to_clusters(s,
-                                             reftable_size * sizeof(uint64_t));
+        reftable_clusters =
+            size_to_clusters(s, reftable_size * REFTABLE_ENTRY_SIZE);
         /* Not pretty but simple */
         if (first_free_cluster < post_refblock_start) {
             first_free_cluster = post_refblock_start;
@@ -2485,16 +2487,16 @@ write_refblocks:
     }
 
     ret = qcow2_pre_write_overlap_check(bs, 0, reftable_offset,
-                                        reftable_size * sizeof(uint64_t),
+                                        reftable_size * REFTABLE_ENTRY_SIZE,
                                         false);
     if (ret < 0) {
         fprintf(stderr, "ERROR writing reftable: %s\n", strerror(-ret));
         goto fail;
     }
 
-    assert(reftable_size < INT_MAX / sizeof(uint64_t));
+    assert(reftable_size < INT_MAX / REFTABLE_ENTRY_SIZE);
     ret = bdrv_pwrite(bs->file, reftable_offset, on_disk_reftable,
-                      reftable_size * sizeof(uint64_t));
+                      reftable_size * REFTABLE_ENTRY_SIZE);
     if (ret < 0) {
         fprintf(stderr, "ERROR writing reftable: %s\n", strerror(-ret));
         goto fail;
@@ -2503,7 +2505,7 @@ write_refblocks:
     /* Enter new reftable into the image header */
     reftable_offset_and_clusters.reftable_offset = cpu_to_be64(reftable_offset);
     reftable_offset_and_clusters.reftable_clusters =
-        cpu_to_be32(size_to_clusters(s, reftable_size * sizeof(uint64_t)));
+        cpu_to_be32(size_to_clusters(s, reftable_size * REFTABLE_ENTRY_SIZE));
     ret = bdrv_pwrite_sync(bs->file,
                            offsetof(QCowHeader, refcount_table_offset),
                            &reftable_offset_and_clusters,
@@ -2693,14 +2695,14 @@ int qcow2_check_metadata_overlap(BlockDriverState *bs, int ign, int64_t offset,
     offset = start_of_cluster(s, offset);
 
     if ((chk & QCOW2_OL_ACTIVE_L1) && s->l1_size) {
-        if (overlaps_with(s->l1_table_offset, s->l1_size * sizeof(uint64_t))) {
+        if (overlaps_with(s->l1_table_offset, s->l1_size * L1E_SIZE)) {
             return QCOW2_OL_ACTIVE_L1;
         }
     }
 
     if ((chk & QCOW2_OL_REFCOUNT_TABLE) && s->refcount_table_size) {
         if (overlaps_with(s->refcount_table_offset,
-            s->refcount_table_size * sizeof(uint64_t))) {
+            s->refcount_table_size * REFTABLE_ENTRY_SIZE)) {
             return QCOW2_OL_REFCOUNT_TABLE;
         }
     }
@@ -2715,7 +2717,7 @@ int qcow2_check_metadata_overlap(BlockDriverState *bs, int ign, int64_t offset,
         for (i = 0; i < s->nb_snapshots; i++) {
             if (s->snapshots[i].l1_size &&
                 overlaps_with(s->snapshots[i].l1_table_offset,
-                s->snapshots[i].l1_size * sizeof(uint64_t))) {
+                s->snapshots[i].l1_size * L1E_SIZE)) {
                 return QCOW2_OL_INACTIVE_L1;
             }
         }
@@ -2749,11 +2751,11 @@ int qcow2_check_metadata_overlap(BlockDriverState *bs, int ign, int64_t offset,
         for (i = 0; i < s->nb_snapshots; i++) {
             uint64_t l1_ofs = s->snapshots[i].l1_table_offset;
             uint32_t l1_sz  = s->snapshots[i].l1_size;
-            uint64_t l1_sz2 = l1_sz * sizeof(uint64_t);
+            uint64_t l1_sz2 = l1_sz * L1E_SIZE;
             uint64_t *l1;
             int ret;
 
-            ret = qcow2_validate_table(bs, l1_ofs, l1_sz, sizeof(uint64_t),
+            ret = qcow2_validate_table(bs, l1_ofs, l1_sz, L1E_SIZE,
                                        QCOW_MAX_L1_SIZE, "", NULL);
             if (ret < 0) {
                 return ret;
@@ -2877,8 +2879,8 @@ static int alloc_refblock(BlockDriverState *bs, uint64_t **reftable,
         uint64_t new_reftable_size;
 
         new_reftable_size = ROUND_UP(reftable_index + 1,
-                                     s->cluster_size / sizeof(uint64_t));
-        if (new_reftable_size > QCOW_MAX_REFTABLE_SIZE / sizeof(uint64_t)) {
+                                     s->cluster_size / REFTABLE_ENTRY_SIZE);
+        if (new_reftable_size > QCOW_MAX_REFTABLE_SIZE / REFTABLE_ENTRY_SIZE) {
             error_setg(errp,
                        "This operation would make the refcount table grow "
                        "beyond the maximum size supported by QEMU, aborting");
@@ -2886,14 +2888,14 @@ static int alloc_refblock(BlockDriverState *bs, uint64_t **reftable,
         }
 
         new_reftable = g_try_realloc(*reftable, new_reftable_size *
-                                                sizeof(uint64_t));
+                                                REFTABLE_ENTRY_SIZE);
         if (!new_reftable) {
             error_setg(errp, "Failed to increase reftable buffer size");
             return -ENOMEM;
         }
 
         memset(new_reftable + *reftable_size, 0,
-               (new_reftable_size - *reftable_size) * sizeof(uint64_t));
+               (new_reftable_size - *reftable_size) * REFTABLE_ENTRY_SIZE);
 
         *reftable      = new_reftable;
         *reftable_size = new_reftable_size;
@@ -3164,13 +3166,14 @@ int qcow2_change_refcount_order(BlockDriverState *bs, int refcount_order,
 
         if (new_allocation) {
             if (new_reftable_offset) {
-                qcow2_free_clusters(bs, new_reftable_offset,
-                                    allocated_reftable_size * sizeof(uint64_t),
-                                    QCOW2_DISCARD_NEVER);
+                qcow2_free_clusters(
+                    bs, new_reftable_offset,
+                    allocated_reftable_size * REFTABLE_ENTRY_SIZE,
+                    QCOW2_DISCARD_NEVER);
             }
 
             new_reftable_offset = qcow2_alloc_clusters(bs, new_reftable_size *
-                                                           sizeof(uint64_t));
+                                                           REFTABLE_ENTRY_SIZE);
             if (new_reftable_offset < 0) {
                 error_setg_errno(errp, -new_reftable_offset,
                                  "Failed to allocate the new reftable");
@@ -3196,7 +3199,7 @@ int qcow2_change_refcount_order(BlockDriverState *bs, int refcount_order,
 
     /* Write the new reftable */
     ret = qcow2_pre_write_overlap_check(bs, 0, new_reftable_offset,
-                                        new_reftable_size * sizeof(uint64_t),
+                                        new_reftable_size * REFTABLE_ENTRY_SIZE,
                                         false);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Overlap check failed");
@@ -3208,7 +3211,7 @@ int qcow2_change_refcount_order(BlockDriverState *bs, int refcount_order,
     }
 
     ret = bdrv_pwrite(bs->file, new_reftable_offset, new_reftable,
-                      new_reftable_size * sizeof(uint64_t));
+                      new_reftable_size * REFTABLE_ENTRY_SIZE);
 
     for (i = 0; i < new_reftable_size; i++) {
         be64_to_cpus(&new_reftable[i]);
@@ -3285,7 +3288,7 @@ done:
 
         if (new_reftable_offset > 0) {
             qcow2_free_clusters(bs, new_reftable_offset,
-                                new_reftable_size * sizeof(uint64_t),
+                                new_reftable_size * REFTABLE_ENTRY_SIZE,
                                 QCOW2_DISCARD_OTHER);
         }
     }
@@ -3374,7 +3377,7 @@ int qcow2_shrink_reftable(BlockDriverState *bs)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t *reftable_tmp =
-        g_malloc(s->refcount_table_size * sizeof(uint64_t));
+        g_malloc(s->refcount_table_size * REFTABLE_ENTRY_SIZE);
     int i, ret;
 
     for (i = 0; i < s->refcount_table_size; i++) {
@@ -3412,7 +3415,7 @@ int qcow2_shrink_reftable(BlockDriverState *bs)
     }
 
     ret = bdrv_pwrite_sync(bs->file, s->refcount_table_offset, reftable_tmp,
-                           s->refcount_table_size * sizeof(uint64_t));
+                           s->refcount_table_size * REFTABLE_ENTRY_SIZE);
     /*
      * If the write in the reftable failed the image may contain a partially
      * overwritten reftable. In this case it would be better to clear the
diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index 2756b37d24..9b68690f56 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -659,7 +659,7 @@ int qcow2_snapshot_create(BlockDriverState *bs, QEMUSnapshotInfo *sn_info)
     sn->extra_data_size = sizeof(QCowSnapshotExtraData);
 
     /* Allocate the L1 table of the snapshot and copy the current one there. */
-    l1_table_offset = qcow2_alloc_clusters(bs, s->l1_size * sizeof(uint64_t));
+    l1_table_offset = qcow2_alloc_clusters(bs, s->l1_size * L1E_SIZE);
     if (l1_table_offset < 0) {
         ret = l1_table_offset;
         goto fail;
@@ -679,13 +679,13 @@ int qcow2_snapshot_create(BlockDriverState *bs, QEMUSnapshotInfo *sn_info)
     }
 
     ret = qcow2_pre_write_overlap_check(bs, 0, sn->l1_table_offset,
-                                        s->l1_size * sizeof(uint64_t), false);
+                                        s->l1_size * L1E_SIZE, false);
     if (ret < 0) {
         goto fail;
     }
 
     ret = bdrv_pwrite(bs->file, sn->l1_table_offset, l1_table,
-                      s->l1_size * sizeof(uint64_t));
+                      s->l1_size * L1E_SIZE);
     if (ret < 0) {
         goto fail;
     }
@@ -768,7 +768,7 @@ int qcow2_snapshot_goto(BlockDriverState *bs, const char *snapshot_id)
     sn = &s->snapshots[snapshot_index];
 
     ret = qcow2_validate_table(bs, sn->l1_table_offset, sn->l1_size,
-                               sizeof(uint64_t), QCOW_MAX_L1_SIZE,
+                               L1E_SIZE, QCOW_MAX_L1_SIZE,
                                "Snapshot L1 table", &local_err);
     if (ret < 0) {
         error_report_err(local_err);
@@ -803,8 +803,8 @@ int qcow2_snapshot_goto(BlockDriverState *bs, const char *snapshot_id)
         goto fail;
     }
 
-    cur_l1_bytes = s->l1_size * sizeof(uint64_t);
-    sn_l1_bytes = sn->l1_size * sizeof(uint64_t);
+    cur_l1_bytes = s->l1_size * L1E_SIZE;
+    sn_l1_bytes = sn->l1_size * L1E_SIZE;
 
     /*
      * Copy the snapshot L1 table to the current L1 table.
@@ -917,7 +917,7 @@ int qcow2_snapshot_delete(BlockDriverState *bs,
     sn = s->snapshots[snapshot_index];
 
     ret = qcow2_validate_table(bs, sn.l1_table_offset, sn.l1_size,
-                               sizeof(uint64_t), QCOW_MAX_L1_SIZE,
+                               L1E_SIZE, QCOW_MAX_L1_SIZE,
                                "Snapshot L1 table", errp);
     if (ret < 0) {
         return ret;
@@ -953,7 +953,7 @@ int qcow2_snapshot_delete(BlockDriverState *bs,
         error_setg_errno(errp, -ret, "Failed to free the cluster and L1 table");
         return ret;
     }
-    qcow2_free_clusters(bs, sn.l1_table_offset, sn.l1_size * sizeof(uint64_t),
+    qcow2_free_clusters(bs, sn.l1_table_offset, sn.l1_size * L1E_SIZE,
                         QCOW2_DISCARD_SNAPSHOT);
 
     /* must update the copied flag on the current cluster offsets */
@@ -1030,12 +1030,12 @@ int qcow2_snapshot_load_tmp(BlockDriverState *bs,
 
     /* Allocate and read in the snapshot's L1 table */
     ret = qcow2_validate_table(bs, sn->l1_table_offset, sn->l1_size,
-                               sizeof(uint64_t), QCOW_MAX_L1_SIZE,
+                               L1E_SIZE, QCOW_MAX_L1_SIZE,
                                "Snapshot L1 table", errp);
     if (ret < 0) {
         return ret;
     }
-    new_l1_bytes = sn->l1_size * sizeof(uint64_t);
+    new_l1_bytes = sn->l1_size * L1E_SIZE;
     new_l1_table = qemu_try_blockalign(bs->file->bs, new_l1_bytes);
     if (new_l1_table == NULL) {
         return -ENOMEM;
diff --git a/block/qcow2.c b/block/qcow2.c
index da56b1a4df..ef9a45e82f 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1543,7 +1543,7 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
 
     /* read the level 1 table */
     ret = qcow2_validate_table(bs, header.l1_table_offset,
-                               header.l1_size, sizeof(uint64_t),
+                               header.l1_size, L1E_SIZE,
                                QCOW_MAX_L1_SIZE, "Active L1 table", errp);
     if (ret < 0) {
         goto fail;
@@ -1568,15 +1568,14 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
     }
 
     if (s->l1_size > 0) {
-        s->l1_table = qemu_try_blockalign(bs->file->bs,
-                                          s->l1_size * sizeof(uint64_t));
+        s->l1_table = qemu_try_blockalign(bs->file->bs, s->l1_size * L1E_SIZE);
         if (s->l1_table == NULL) {
             error_setg(errp, "Could not allocate L1 table");
             ret = -ENOMEM;
             goto fail;
         }
         ret = bdrv_pread(bs->file, s->l1_table_offset, s->l1_table,
-                         s->l1_size * sizeof(uint64_t));
+                         s->l1_size * L1E_SIZE);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Could not read L1 table");
             goto fail;
@@ -3213,7 +3212,7 @@ int64_t qcow2_refcount_metadata_size(int64_t clusters, size_t cluster_size,
      * where no further refcount blocks or table clusters are required to
      * reference count every cluster.
      */
-    int64_t blocks_per_table_cluster = cluster_size / sizeof(uint64_t);
+    int64_t blocks_per_table_cluster = cluster_size / REFTABLE_ENTRY_SIZE;
     int64_t refcounts_per_block = cluster_size * 8 / (1 << refcount_order);
     int64_t table = 0;  /* number of refcount table clusters */
     int64_t blocks = 0; /* number of refcount block clusters */
@@ -3270,8 +3269,8 @@ static int64_t qcow2_calc_prealloc_size(int64_t total_size,
 
     /* total size of L1 tables */
     nl1e = nl2e * l2e_size / cluster_size;
-    nl1e = ROUND_UP(nl1e, cluster_size / sizeof(uint64_t));
-    meta_size += nl1e * sizeof(uint64_t);
+    nl1e = ROUND_UP(nl1e, cluster_size / L1E_SIZE);
+    meta_size += nl1e * L1E_SIZE;
 
     /* total size of refcount table and blocks */
     meta_size += qcow2_refcount_metadata_size(
@@ -4460,7 +4459,7 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
     /* write updated header.size */
     offset = cpu_to_be64(offset);
     ret = bdrv_pwrite_sync(bs->file, offsetof(QCowHeader, size),
-                           &offset, sizeof(uint64_t));
+                           &offset, sizeof(offset));
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Failed to update the image size");
         goto fail;
@@ -4700,8 +4699,8 @@ static int make_completely_empty(BlockDriverState *bs)
 
     BLKDBG_EVENT(bs->file, BLKDBG_L1_UPDATE);
 
-    l1_clusters = DIV_ROUND_UP(s->l1_size, s->cluster_size / sizeof(uint64_t));
-    l1_size2 = (uint64_t)s->l1_size * sizeof(uint64_t);
+    l1_clusters = DIV_ROUND_UP(s->l1_size, s->cluster_size / L1E_SIZE);
+    l1_size2 = (uint64_t)s->l1_size * L1E_SIZE;
 
     /* After this call, neither the in-memory nor the on-disk refcount
      * information accurately describe the actual references */
@@ -4747,14 +4746,14 @@ static int make_completely_empty(BlockDriverState *bs)
 
     s->l1_table_offset = 3 * s->cluster_size;
 
-    new_reftable = g_try_new0(uint64_t, s->cluster_size / sizeof(uint64_t));
+    new_reftable = g_try_new0(uint64_t, s->cluster_size / REFTABLE_ENTRY_SIZE);
     if (!new_reftable) {
         ret = -ENOMEM;
         goto fail_broken_refcounts;
     }
 
     s->refcount_table_offset = s->cluster_size;
-    s->refcount_table_size   = s->cluster_size / sizeof(uint64_t);
+    s->refcount_table_size   = s->cluster_size / REFTABLE_ENTRY_SIZE;
     s->max_refcount_table_index = 0;
 
     g_free(s->refcount_table);
@@ -4826,7 +4825,7 @@ static int qcow2_make_empty(BlockDriverState *bs)
     int step = QEMU_ALIGN_DOWN(INT_MAX, s->cluster_size);
     int l1_clusters, ret = 0;
 
-    l1_clusters = DIV_ROUND_UP(s->l1_size, s->cluster_size / sizeof(uint64_t));
+    l1_clusters = DIV_ROUND_UP(s->l1_size, s->cluster_size / L1E_SIZE);
 
     if (s->qcow_version >= 3 && !s->snapshots && !s->nb_bitmaps &&
         3 + l1_clusters <= s->refcount_block_size &&
@@ -4957,7 +4956,7 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
     l2e_size = extended_l2 ? L2E_SIZE_EXTENDED : L2E_SIZE_NORMAL;
     l2_tables = DIV_ROUND_UP(virtual_size / cluster_size,
                              cluster_size / l2e_size);
-    if (l2_tables * sizeof(uint64_t) > QCOW_MAX_L1_SIZE) {
+    if (l2_tables * L1E_SIZE > QCOW_MAX_L1_SIZE) {
         error_setg(&local_err, "The image size is too large "
                                "(try using a larger cluster size)");
         goto err;
-- 
2.26.2


