Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E60C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 12:16:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 618242071E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 12:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYOJNsnx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618242071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNb1s-0008HP-EK
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 08:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kNaxG-0003qY-Gc
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 08:11:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56689)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kNaxC-00079g-OA
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 08:11:30 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601467885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yzBnVnQhXrh6FAh3kRktBoBQxXYTb3U9dzXnIe0Yijg=;
 b=JYOJNsnxjjtTAtaLzhwyCsmOoccO12mP7/fz4EXt/RnJLja8EguAXEA4o0WgaLKSNwTbI5
 PUmHjBKxHry7rbbIdpnKvTy4hPvj/HVLKrMYWA/pWZD4pwvWKvlhpFgKI9uoFjjzh4gELX
 3rDJnK4qiHQ2309uMYGPYAIQhyiySPA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-5h7GaHwlMf-fqr6mvxJyOw-1; Wed, 30 Sep 2020 08:11:23 -0400
X-MC-Unique: 5h7GaHwlMf-fqr6mvxJyOw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50D501019632;
 Wed, 30 Sep 2020 12:11:22 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-208.phx2.redhat.com [10.3.112.208])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A8AA960C05;
 Wed, 30 Sep 2020 12:11:21 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/5] nbd: Add new qemu:allocation-depth metacontext
Date: Wed, 30 Sep 2020 07:11:04 -0500
Message-Id: <20200930121105.667049-5-eblake@redhat.com>
In-Reply-To: <20200930121105.667049-1-eblake@redhat.com>
References: <20200930121105.667049-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 rjones@redhat.com, Max Reitz <mreitz@redhat.com>, vsementsov@virtuozzo.com,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'qemu-img map' provides a way to determine which extents of an image
come from the top layer vs. inherited from a backing chain.  This is
useful information worth exposing over NBD.  There is a proposal to
add a QMP command block-dirty-bitmap-populate which can create a dirty
bitmap that reflects allocation information, at which point
qemu:dirty-bitmap:NAME can expose that information via the creation of
a temporary bitmap, but we can shorten the effort by adding a new
qemu:allocation-depth context that does the same thing without an
intermediate bitmap (this patch does not eliminate the need for that
proposal, as it will have other uses as well).

For this patch, I just encoded a tri-state value (unallocated, from
this layer, from any of the backing layers); an obvious extension
would be to provide the actual depth in bits 31-4 while keeping bits
1-0 as a tri-state (leaving bits 3-2 unused, for ease of reading depth
from a hex number).  But this extension would require
bdrv_is_allocated_above to return a depth number.

Note that this patch does not actually enable any way to request a
server to enable this context; that will come in the next patch.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 docs/interop/nbd.txt |  22 +++++++--
 include/block/nbd.h  |   8 +++-
 nbd/server.c         | 105 ++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 125 insertions(+), 10 deletions(-)

diff --git a/docs/interop/nbd.txt b/docs/interop/nbd.txt
index f3b3cacc9621..56efec7aee12 100644
--- a/docs/interop/nbd.txt
+++ b/docs/interop/nbd.txt
@@ -17,9 +17,9 @@ namespace "qemu".

 == "qemu" namespace ==

-The "qemu" namespace currently contains only one type of context,
-related to exposing the contents of a dirty bitmap alongside the
-associated disk contents.  That context has the following form:
+The "qemu" namespace currently contains two types of context.  The
+first is related to exposing the contents of a dirty bitmap alongside
+the associated disk contents.  That context has the following form:

     qemu:dirty-bitmap:<dirty-bitmap-export-name>

@@ -28,8 +28,21 @@ in reply for NBD_CMD_BLOCK_STATUS:

     bit 0: NBD_STATE_DIRTY, means that the extent is "dirty"

+The second is related to exposing the source of various extents within
+the image, with a single context named:
+
+    qemu:allocation-depth
+
+In the allocation depth context, bits 0 and 1 form a tri-state value:
+
+    bits 0-1 clear: NBD_STATE_DEPTH_UNALLOC, means the extent is unallocated
+    bit 0 set: NBD_STATE_DEPTH_LOCAL, the extent is allocated in this image
+    bit 1 set: NBD_STATE_DEPTH_BACKING, the extent is inherited from a
+               backing layer
+
 For NBD_OPT_LIST_META_CONTEXT the following queries are supported
-in addition to "qemu:dirty-bitmap:<dirty-bitmap-export-name>":
+in addition to the specific "qemu:allocation-depth" and
+"qemu:dirty-bitmap:<dirty-bitmap-export-name>":

 * "qemu:" - returns list of all available metadata contexts in the
             namespace.
@@ -55,3 +68,4 @@ the operation of that feature.
 NBD_CMD_BLOCK_STATUS for "qemu:dirty-bitmap:", NBD_CMD_CACHE
 * 4.2: NBD_FLAG_CAN_MULTI_CONN for shareable read-only exports,
 NBD_CMD_FLAG_FAST_ZERO
+* 5.2: NBD_CMD_BLOCK_STATUS for "qemu:allocation-depth"
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 3dd9a04546ec..06208bc25027 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -1,5 +1,5 @@
 /*
- *  Copyright (C) 2016-2019 Red Hat, Inc.
+ *  Copyright (C) 2016-2020 Red Hat, Inc.
  *  Copyright (C) 2005  Anthony Liguori <anthony@codemonkey.ws>
  *
  *  Network Block Device
@@ -259,6 +259,12 @@ enum {
 /* Extent flags for qemu:dirty-bitmap in NBD_REPLY_TYPE_BLOCK_STATUS */
 #define NBD_STATE_DIRTY (1 << 0)

+/* Extent flags for qemu:allocation-depth in NBD_REPLY_TYPE_BLOCK_STATUS */
+#define NBD_STATE_DEPTH_UNALLOC (0 << 0)
+#define NBD_STATE_DEPTH_LOCAL   (1 << 0)
+#define NBD_STATE_DEPTH_BACKING (2 << 0)
+#define NBD_STATE_DEPTH_MASK    (0x3)
+
 static inline bool nbd_reply_type_is_error(int type)
 {
     return type & (1 << 15);
diff --git a/nbd/server.c b/nbd/server.c
index 7271a09b5c2b..830b21000be3 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -27,7 +27,8 @@
 #include "qemu/units.h"

 #define NBD_META_ID_BASE_ALLOCATION 0
-#define NBD_META_ID_DIRTY_BITMAP 1
+#define NBD_META_ID_ALLOCATION_DEPTH 1
+#define NBD_META_ID_DIRTY_BITMAP 2

 /*
  * NBD_MAX_BLOCK_STATUS_EXTENTS: 1 MiB of extents data. An empirical
@@ -94,6 +95,7 @@ struct NBDExport {
     BlockBackend *eject_notifier_blk;
     Notifier eject_notifier;

+    bool alloc_context;
     BdrvDirtyBitmap *export_bitmap;
     char *export_bitmap_context;
 };
@@ -108,6 +110,7 @@ typedef struct NBDExportMetaContexts {
     bool valid; /* means that negotiation of the option finished without
                    errors */
     bool base_allocation; /* export base:allocation context (block status) */
+    bool allocation_depth; /* export qemu:allocation-depth */
     bool bitmap; /* export qemu:dirty-bitmap:<export bitmap name> */
 } NBDExportMetaContexts;

@@ -806,7 +809,7 @@ static bool nbd_meta_empty_or_pattern(NBDClient *client, const char *pattern,
 {
     if (!*query) {
         trace_nbd_negotiate_meta_query_parse("empty");
-        return client->opt == NBD_OPT_LIST_META_CONTEXT;
+        return !*pattern || client->opt == NBD_OPT_LIST_META_CONTEXT;
     }
     if (strcmp(query, pattern) == 0) {
         trace_nbd_negotiate_meta_query_parse(pattern);
@@ -864,12 +867,21 @@ static bool nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,

     if (!*query) {
         if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
+            meta->allocation_depth = meta->exp->alloc_context;
             meta->bitmap = !!meta->exp->export_bitmap;
         }
         trace_nbd_negotiate_meta_query_parse("empty");
         return true;
     }

+    if (nbd_strshift(&query, "allocation-depth")) {
+        trace_nbd_negotiate_meta_query_parse("allocation-depth");
+        if (nbd_meta_empty_or_pattern(client, "", query)) {
+            meta->allocation_depth = meta->exp->alloc_context;
+        }
+        return true;
+    }
+
     if (nbd_strshift(&query, "dirty-bitmap:")) {
         trace_nbd_negotiate_meta_query_parse("dirty-bitmap:");
         if (!meta->exp->export_bitmap) {
@@ -984,6 +996,7 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
     if (client->opt == NBD_OPT_LIST_META_CONTEXT && !nb_queries) {
         /* enable all known contexts */
         meta->base_allocation = true;
+        meta->allocation_depth = meta->exp->alloc_context;
         meta->bitmap = !!meta->exp->export_bitmap;
     } else {
         for (i = 0; i < nb_queries; ++i) {
@@ -1003,6 +1016,15 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
         }
     }

+    if (meta->allocation_depth) {
+        ret = nbd_negotiate_send_meta_context(client, "qemu:allocation-depth",
+                                              NBD_META_ID_ALLOCATION_DEPTH,
+                                              errp);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
     if (meta->bitmap) {
         ret = nbd_negotiate_send_meta_context(client,
                                               meta->exp->export_bitmap_context,
@@ -1961,6 +1983,40 @@ static int blockstatus_to_extents(BlockDriverState *bs, uint64_t offset,
     return 0;
 }

+static int blockalloc_to_extents(BlockDriverState *bs, uint64_t offset,
+                                 uint64_t bytes, NBDExtentArray *ea)
+{
+    while (bytes) {
+        uint32_t flags;
+        int64_t num;
+        int ret = bdrv_is_allocated(bs, offset, bytes, &num);
+
+        if (ret < 0) {
+            return ret;
+        }
+
+        if (ret == 1) {
+            flags = NBD_STATE_DEPTH_LOCAL;
+        } else {
+            ret = bdrv_is_allocated_above(bs, NULL, false, offset, num,
+                                          &num);
+            if (ret < 0) {
+                return ret;
+            }
+            flags = ret ? NBD_STATE_DEPTH_BACKING : NBD_STATE_DEPTH_UNALLOC;
+        }
+
+        if (nbd_extent_array_add(ea, num, flags) < 0) {
+            return 0;
+        }
+
+        offset += num;
+        bytes -= num;
+    }
+
+    return 0;
+}
+
 /*
  * nbd_co_send_extents
  *
@@ -2009,6 +2065,26 @@ static int nbd_co_send_block_status(NBDClient *client, uint64_t handle,
     return nbd_co_send_extents(client, handle, ea, last, context_id, errp);
 }

+/* Get allocation depth from the exported device and send it to the client */
+static int nbd_co_send_block_alloc(NBDClient *client, uint64_t handle,
+                                   BlockDriverState *bs, uint64_t offset,
+                                   uint32_t length, bool dont_fragment,
+                                   bool last, uint32_t context_id,
+                                   Error **errp)
+{
+    int ret;
+    unsigned int nb_extents = dont_fragment ? 1 : NBD_MAX_BLOCK_STATUS_EXTENTS;
+    g_autoptr(NBDExtentArray) ea = nbd_extent_array_new(nb_extents);
+
+    ret = blockalloc_to_extents(bs, offset, length, ea);
+    if (ret < 0) {
+        return nbd_co_send_structured_error(
+                client, handle, -ret, "can't get block status", errp);
+    }
+
+    return nbd_co_send_extents(client, handle, ea, last, context_id, errp);
+}
+
 /* Populate @ea from a dirty bitmap. */
 static void bitmap_to_extents(BdrvDirtyBitmap *bitmap,
                               uint64_t offset, uint64_t length,
@@ -2335,16 +2411,20 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
         }
         if (client->export_meta.valid &&
             (client->export_meta.base_allocation ||
+             client->export_meta.allocation_depth ||
              client->export_meta.bitmap))
         {
             bool dont_fragment = request->flags & NBD_CMD_FLAG_REQ_ONE;
+            int contexts_remaining = client->export_meta.base_allocation +
+                client->export_meta.allocation_depth +
+                client->export_meta.bitmap;

             if (client->export_meta.base_allocation) {
                 ret = nbd_co_send_block_status(client, request->handle,
                                                blk_bs(exp->common.blk),
                                                request->from,
                                                request->len, dont_fragment,
-                                               !client->export_meta.bitmap,
+                                               !--contexts_remaining,
                                                NBD_META_ID_BASE_ALLOCATION,
                                                errp);
                 if (ret < 0) {
@@ -2352,17 +2432,32 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
                 }
             }

+            if (client->export_meta.allocation_depth) {
+                ret = nbd_co_send_block_alloc(client, request->handle,
+                                              blk_bs(exp->common.blk),
+                                              request->from, request->len,
+                                              dont_fragment,
+                                              !--contexts_remaining,
+                                              NBD_META_ID_ALLOCATION_DEPTH,
+                                              errp);
+                if (ret < 0) {
+                    return ret;
+                }
+            }
+
             if (client->export_meta.bitmap) {
                 ret = nbd_co_send_bitmap(client, request->handle,
                                          client->exp->export_bitmap,
                                          request->from, request->len,
-                                         dont_fragment,
-                                         true, NBD_META_ID_DIRTY_BITMAP, errp);
+                                         dont_fragment, !--contexts_remaining,
+                                         NBD_META_ID_DIRTY_BITMAP, errp);
                 if (ret < 0) {
                     return ret;
                 }
             }

+            assert(!contexts_remaining);
+
             return 0;
         } else {
             return nbd_send_generic_reply(client, request->handle, -EINVAL,
-- 
2.28.0


