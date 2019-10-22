Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DBDCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:09:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 775DE2184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775DE2184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMtuL-0000MB-1N
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iMtkX-00070G-VB
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 08:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iMtkV-0006TJ-I2
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 08:58:57 -0400
Received: from relay.sw.ru ([185.231.240.75]:55210)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iMtkN-0006KH-By; Tue, 22 Oct 2019 08:58:48 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iMtkI-0003xx-G6; Tue, 22 Oct 2019 15:58:42 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 08/10] nbd/server: introduce NBDExtentArray
Date: Tue, 22 Oct 2019 15:58:37 +0300
Message-Id: <20191022125839.12633-9-vsementsov@virtuozzo.com>
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

Introduce NBDExtentArray class, to handle extents list creation in more
controlled way and with less OUT parameters in functions.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 201 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 109 insertions(+), 92 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index cc0069c15b..650eebcfff 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1894,27 +1894,89 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
     return ret;
 }
 
+typedef struct NBDExtentArray {
+    NBDExtent *extents;
+    unsigned int nb_alloc;
+    unsigned int count;
+    uint64_t total_length;
+    bool converted; /* extents are converted to BE, no more changes allowed */
+} NBDExtentArray;
+
+static NBDExtentArray *nbd_extent_array_new(unsigned int nb_alloc)
+{
+    NBDExtentArray *ea = g_new0(NBDExtentArray, 1);
+
+    ea->nb_alloc = nb_alloc;
+    ea->extents = g_new(NBDExtent, nb_alloc);
+
+    return ea;
+}
+
+static void nbd_extent_array_free(NBDExtentArray *ea)
+{
+    g_free(ea->extents);
+    g_free(ea);
+}
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(NBDExtentArray, nbd_extent_array_free);
+
+/* Further modifications of the array after conversion are abandoned */
+static void nbd_extent_array_convert_to_be(NBDExtentArray *ea)
+{
+    int i;
+
+    if (ea->converted) {
+        return;
+    }
+    ea->converted = true;
+
+    for (i = 0; i < ea->count; i++) {
+        ea->extents[i].flags = cpu_to_be32(ea->extents[i].flags);
+        ea->extents[i].length = cpu_to_be32(ea->extents[i].length);
+    }
+}
+
 /*
- * Populate @extents from block status. Update @bytes to be the actual
- * length encoded (which may be smaller than the original), and update
- * @nb_extents to the number of extents used.
- *
- * Returns zero on success and -errno on bdrv_block_status_above failure.
+ * Add extent to NBDExtentArray. If extent can't be added (no available space),
+ * return -1.
+ * For safety, when returning -1 for the first time, the array is converted
+ * to BE and further modifications are abandoned.
  */
-static int blockstatus_to_extents(BlockDriverState *bs, uint64_t offset,
-                                  uint64_t *bytes, NBDExtent *extents,
-                                  unsigned int *nb_extents)
+static int nbd_extent_array_add(NBDExtentArray *ea,
+                                uint32_t length, uint32_t flags)
 {
-    uint64_t remaining_bytes = *bytes;
-    NBDExtent *extent = extents, *extents_end = extents + *nb_extents;
-    bool first_extent = true;
+    assert(!ea->converted);
+
+    if (!length) {
+        return 0;
+    }
+
+    /* Extend previous extent if flags are the same */
+    if (ea->count > 0 && flags == ea->extents[ea->count - 1].flags) {
+        ea->extents[ea->count - 1].length += length;
+        ea->total_length += length;
+        return 0;
+    }
+
+    if (ea->count >= ea->nb_alloc) {
+        nbd_extent_array_convert_to_be(ea);
+        return -1;
+    }
+
+    ea->total_length += length;
+    ea->extents[ea->count] = (NBDExtent) {.length = length, .flags = flags};
+    ea->count++;
 
-    assert(*nb_extents);
-    while (remaining_bytes) {
+    return 0;
+}
+
+static int blockstatus_to_extents(BlockDriverState *bs, uint64_t offset,
+                                  uint64_t bytes, NBDExtentArray *ea)
+{
+    while (bytes) {
         uint32_t flags;
         int64_t num;
-        int ret = bdrv_block_status_above(bs, NULL, offset, remaining_bytes,
-                                          &num, NULL, NULL);
+        int ret = bdrv_block_status_above(bs, NULL, offset, bytes, &num,
+                                          NULL, NULL);
 
         if (ret < 0) {
             return ret;
@@ -1923,60 +1985,37 @@ static int blockstatus_to_extents(BlockDriverState *bs, uint64_t offset,
         flags = (ret & BDRV_BLOCK_ALLOCATED ? 0 : NBD_STATE_HOLE) |
                 (ret & BDRV_BLOCK_ZERO      ? NBD_STATE_ZERO : 0);
 
-        if (first_extent) {
-            extent->flags = flags;
-            extent->length = num;
-            first_extent = false;
-        } else if (flags == extent->flags) {
-            /* extend current extent */
-            extent->length += num;
-        } else {
-            if (extent + 1 == extents_end) {
-                break;
-            }
-
-            /* start new extent */
-            extent++;
-            extent->flags = flags;
-            extent->length = num;
+        if (nbd_extent_array_add(ea, num, flags) < 0) {
+            return 0;
         }
-        offset += num;
-        remaining_bytes -= num;
-    }
-
-    extents_end = extent + 1;
 
-    for (extent = extents; extent < extents_end; extent++) {
-        extent->flags = cpu_to_be32(extent->flags);
-        extent->length = cpu_to_be32(extent->length);
+        offset += num;
+        bytes -= num;
     }
 
-    *bytes -= remaining_bytes;
-    *nb_extents = extents_end - extents;
-
     return 0;
 }
 
-/* nbd_co_send_extents
+/*
+ * nbd_co_send_extents
  *
- * @length is only for tracing purposes (and may be smaller or larger
- * than the client's original request). @last controls whether
- * NBD_REPLY_FLAG_DONE is sent. @extents should already be in
- * big-endian format.
+ * @ea is converted to BE by the function
+ * @last controls whether NBD_REPLY_FLAG_DONE is sent.
  */
 static int nbd_co_send_extents(NBDClient *client, uint64_t handle,
-                               NBDExtent *extents, unsigned int nb_extents,
-                               uint64_t length, bool last,
-                               uint32_t context_id, Error **errp)
+                               NBDExtentArray *ea,
+                               bool last, uint32_t context_id, Error **errp)
 {
     NBDStructuredMeta chunk;
-
     struct iovec iov[] = {
         {.iov_base = &chunk, .iov_len = sizeof(chunk)},
-        {.iov_base = extents, .iov_len = nb_extents * sizeof(extents[0])}
+        {.iov_base = ea->extents, .iov_len = ea->count * sizeof(ea->extents[0])}
     };
 
-    trace_nbd_co_send_extents(handle, nb_extents, context_id, length, last);
+    nbd_extent_array_convert_to_be(ea);
+
+    trace_nbd_co_send_extents(handle, ea->count, context_id, ea->total_length,
+                              last);
     set_be_chunk(&chunk.h, last ? NBD_REPLY_FLAG_DONE : 0,
                  NBD_REPLY_TYPE_BLOCK_STATUS,
                  handle, sizeof(chunk) - sizeof(chunk.h) + iov[1].iov_len);
@@ -1994,39 +2033,27 @@ static int nbd_co_send_block_status(NBDClient *client, uint64_t handle,
 {
     int ret;
     unsigned int nb_extents = dont_fragment ? 1 : NBD_MAX_BLOCK_STATUS_EXTENTS;
-    NBDExtent *extents = g_new(NBDExtent, nb_extents);
-    uint64_t final_length = length;
+    g_autoptr(NBDExtentArray) ea = nbd_extent_array_new(nb_extents);
 
-    ret = blockstatus_to_extents(bs, offset, &final_length, extents,
-                                 &nb_extents);
+    ret = blockstatus_to_extents(bs, offset, length, ea);
     if (ret < 0) {
-        g_free(extents);
         return nbd_co_send_structured_error(
                 client, handle, -ret, "can't get block status", errp);
     }
 
-    ret = nbd_co_send_extents(client, handle, extents, nb_extents,
-                              final_length, last, context_id, errp);
-
-    g_free(extents);
-
-    return ret;
+    return nbd_co_send_extents(client, handle, ea, last, context_id, errp);
 }
 
 /*
- * Populate @extents from a dirty bitmap. Unless @dont_fragment, the
- * final extent may exceed the original @length. Store in @length the
- * byte length encoded (which may be smaller or larger than the
- * original), and return the number of extents used.
+ * Populate @ea from a dirty bitmap. Unless @dont_fragment, the
+ * final extent may exceed the original @length.
  */
-static unsigned int bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
-                                      uint64_t *length, NBDExtent *extents,
-                                      unsigned int nb_extents,
-                                      bool dont_fragment)
+static void bitmap_to_extents(BdrvDirtyBitmap *bitmap,
+                              uint64_t offset, uint64_t length,
+                              NBDExtentArray *ea, bool dont_fragment)
 {
     uint64_t begin = offset, end = offset;
-    uint64_t overall_end = offset + *length;
-    unsigned int i = 0;
+    uint64_t overall_end = offset + length;
     BdrvDirtyBitmapIter *it;
     bool dirty;
 
@@ -2035,8 +2062,7 @@ static unsigned int bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
     it = bdrv_dirty_iter_new(bitmap);
     dirty = bdrv_dirty_bitmap_get_locked(bitmap, offset);
 
-    assert(begin < overall_end && nb_extents);
-    while (begin < overall_end && i < nb_extents) {
+    while (begin < overall_end) {
         bool next_dirty = !dirty;
 
         if (dirty) {
@@ -2056,9 +2082,10 @@ static unsigned int bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
             end = overall_end;
         }
 
-        extents[i].length = cpu_to_be32(end - begin);
-        extents[i].flags = cpu_to_be32(dirty ? NBD_STATE_DIRTY : 0);
-        i++;
+        if (nbd_extent_array_add(ea, end - begin,
+                                 dirty ? NBD_STATE_DIRTY : 0) < 0) {
+            break;
+        }
         begin = end;
         dirty = next_dirty;
     }
@@ -2068,8 +2095,6 @@ static unsigned int bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
     bdrv_dirty_bitmap_unlock(bitmap);
 
     assert(offset < end);
-    *length = end - offset;
-    return i;
 }
 
 static int nbd_co_send_bitmap(NBDClient *client, uint64_t handle,
@@ -2077,20 +2102,12 @@ static int nbd_co_send_bitmap(NBDClient *client, uint64_t handle,
                               uint32_t length, bool dont_fragment, bool last,
                               uint32_t context_id, Error **errp)
 {
-    int ret;
     unsigned int nb_extents = dont_fragment ? 1 : NBD_MAX_BLOCK_STATUS_EXTENTS;
-    NBDExtent *extents = g_new(NBDExtent, nb_extents);
-    uint64_t final_length = length;
+    g_autoptr(NBDExtentArray) ea = nbd_extent_array_new(nb_extents);
 
-    nb_extents = bitmap_to_extents(bitmap, offset, &final_length, extents,
-                                   nb_extents, dont_fragment);
+    bitmap_to_extents(bitmap, offset, length, ea, dont_fragment);
 
-    ret = nbd_co_send_extents(client, handle, extents, nb_extents,
-                              final_length, last, context_id, errp);
-
-    g_free(extents);
-
-    return ret;
+    return nbd_co_send_extents(client, handle, ea, last, context_id, errp);
 }
 
 /* nbd_co_receive_request
-- 
2.21.0


