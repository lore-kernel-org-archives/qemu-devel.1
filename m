Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23750CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:13:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F03E82184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03E82184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMtyM-0005jw-5I
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iMtkW-0006zz-Pb
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 08:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iMtkV-0006Sw-H8
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 08:58:56 -0400
Received: from relay.sw.ru ([185.231.240.75]:55212)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iMtkM-0006KJ-Kp; Tue, 22 Oct 2019 08:58:47 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iMtkI-0003xx-KY; Tue, 22 Oct 2019 15:58:42 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 09/10] nbd/server: use bdrv_dirty_bitmap_next_dirty_area
Date: Tue, 22 Oct 2019 15:58:38 +0300
Message-Id: <20191022125839.12633-10-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191022125839.12633-1-vsementsov@virtuozzo.com>
References: <20191022125839.12633-1-vsementsov@virtuozzo.com>
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use bdrv_dirty_bitmap_next_dirty_area for bitmap_to_extents. Since
bdrv_dirty_bitmap_next_dirty_area is very accurate in its interface,
we'll never exceed requested region with last chunk. So, we don't need
dont_fragment, and bitmap_to_extents() interface becomes clean enough
to not require any comment.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 59 +++++++++++++++++-----------------------------------
 1 file changed, 19 insertions(+), 40 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 650eebcfff..5a6aa6376a 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2044,57 +2044,36 @@ static int nbd_co_send_block_status(NBDClient *client, uint64_t handle,
     return nbd_co_send_extents(client, handle, ea, last, context_id, errp);
 }
 
-/*
- * Populate @ea from a dirty bitmap. Unless @dont_fragment, the
- * final extent may exceed the original @length.
- */
+/* Populate @ea from a dirty bitmap. */
 static void bitmap_to_extents(BdrvDirtyBitmap *bitmap,
                               uint64_t offset, uint64_t length,
-                              NBDExtentArray *ea, bool dont_fragment)
+                              NBDExtentArray *es)
 {
-    uint64_t begin = offset, end = offset;
-    uint64_t overall_end = offset + length;
-    BdrvDirtyBitmapIter *it;
-    bool dirty;
+    int64_t start, dirty_start, dirty_count;
+    int64_t end = offset + length;
+    bool full = false;
 
     bdrv_dirty_bitmap_lock(bitmap);
 
-    it = bdrv_dirty_iter_new(bitmap);
-    dirty = bdrv_dirty_bitmap_get_locked(bitmap, offset);
-
-    while (begin < overall_end) {
-        bool next_dirty = !dirty;
-
-        if (dirty) {
-            end = bdrv_dirty_bitmap_next_zero(bitmap, begin, INT64_MAX);
-        } else {
-            bdrv_set_dirty_iter(it, begin);
-            end = bdrv_dirty_iter_next(it);
-        }
-        if (end == -1 || end - begin > UINT32_MAX) {
-            /* Cap to an aligned value < 4G beyond begin. */
-            end = MIN(bdrv_dirty_bitmap_size(bitmap),
-                      begin + UINT32_MAX + 1 -
-                      bdrv_dirty_bitmap_granularity(bitmap));
-            next_dirty = dirty;
-        }
-        if (dont_fragment && end > overall_end) {
-            end = overall_end;
-        }
-
-        if (nbd_extent_array_add(ea, end - begin,
-                                 dirty ? NBD_STATE_DIRTY : 0) < 0) {
+    for (start = offset;
+         bdrv_dirty_bitmap_next_dirty_area(bitmap, start, end, INT32_MAX,
+                                           &dirty_start, &dirty_count);
+         start = dirty_start + dirty_count)
+    {
+        if ((nbd_extent_array_add(es, dirty_start - start, 0) < 0) ||
+            (nbd_extent_array_add(es, dirty_count, NBD_STATE_DIRTY) < 0))
+        {
+            full = true;
             break;
         }
-        begin = end;
-        dirty = next_dirty;
     }
 
-    bdrv_dirty_iter_free(it);
+    if (!full) {
+        /* last non dirty extent */
+        nbd_extent_array_add(es, end - start, 0);
+    }
 
     bdrv_dirty_bitmap_unlock(bitmap);
-
-    assert(offset < end);
 }
 
 static int nbd_co_send_bitmap(NBDClient *client, uint64_t handle,
@@ -2105,7 +2084,7 @@ static int nbd_co_send_bitmap(NBDClient *client, uint64_t handle,
     unsigned int nb_extents = dont_fragment ? 1 : NBD_MAX_BLOCK_STATUS_EXTENTS;
     g_autoptr(NBDExtentArray) ea = nbd_extent_array_new(nb_extents);
 
-    bitmap_to_extents(bitmap, offset, length, ea, dont_fragment);
+    bitmap_to_extents(bitmap, offset, length, ea);
 
     return nbd_co_send_extents(client, handle, ea, last, context_id, errp);
 }
-- 
2.21.0


