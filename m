Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9B1C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 05:14:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D4292080A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 05:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dTJjtg5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4292080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXHJg-0004dx-6h
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 01:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kXHBg-0003l9-0g
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:06:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43246)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kXHBb-0003e7-NG
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603775177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2YUr/GnO3pi3/hs0Zjz7TWTMTcZodaMQLTF2OHrVYnI=;
 b=dTJjtg5O9IWoYXf5BdUCOOn+lHn/bmNhiXJhPWaiErK3MU6yzra5waRjjWj1DzdKM78ncg
 ZiSex0tGczF2ukmvvKA2LFHLUE5h+EyVl7sw+PrTYGkSicznGrQTyuIWWmT4jLsBgrxLaD
 tysMhMNJMBnfUOcduV8H1QQVUAllKD4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-cEOy1TxBPb2oPB6oNcwEmA-1; Tue, 27 Oct 2020 01:06:14 -0400
X-MC-Unique: cEOy1TxBPb2oPB6oNcwEmA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81F3C100746B;
 Tue, 27 Oct 2020 05:06:13 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-145.phx2.redhat.com [10.3.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C552310013C4;
 Tue, 27 Oct 2020 05:06:12 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 09/11] nbd: Add new qemu:allocation-depth metadata context
Date: Tue, 27 Oct 2020 00:05:54 -0500
Message-Id: <20201027050556.269064-10-eblake@redhat.com>
In-Reply-To: <20201027050556.269064-1-eblake@redhat.com>
References: <20201027050556.269064-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 armbru@redhat.com, rjones@redhat.com, vsementsov@virtuozzo.com,
 stefanha@redhat.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'qemu-img map' provides a way to determine which extents of an image
come from the top layer vs. inherited from a backing chain.  This is
useful information worth exposing over NBD.  There is a proposal to
add a QMP command block-dirty-bitmap-populate which can create a dirty
bitmap that reflects allocation information, at which point the
qemu:dirty-bitmap:NAME metadata context can expose that information
via the creation of a temporary bitmap, but we can shorten the effort
by adding a new qemu:allocation-depth metadata context that does the
same thing without an intermediate bitmap (this patch does not
eliminate the need for that proposal, as it will have other uses as
well).

While documenting things, remember that although the NBD protocol has
NBD_OPT_SET_META_CONTEXT, the rest of its documentation refers to
'metadata context', which is a more apt description of what is
actually being used by NBD_CMD_BLOCK_STATUS: the user is requesting
metadata by passing one or more context names.  So I also touched up
some existing wording to prefer the term 'metadata context' where it
makes sense.

Note that this patch does not actually enable any way to request a
server to enable this context; that will come in the next patch.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 docs/interop/nbd.txt | 23 +++++++++++----
 include/block/nbd.h  |  8 +++--
 nbd/server.c         | 70 +++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 89 insertions(+), 12 deletions(-)

diff --git a/docs/interop/nbd.txt b/docs/interop/nbd.txt
index f3b3cacc9621..10ce098a29bf 100644
--- a/docs/interop/nbd.txt
+++ b/docs/interop/nbd.txt
@@ -17,19 +17,31 @@ namespace "qemu".

 == "qemu" namespace ==

-The "qemu" namespace currently contains only one type of context,
-related to exposing the contents of a dirty bitmap alongside the
-associated disk contents.  That context has the following form:
+The "qemu" namespace currently contains two available metadata context
+types.  The first is related to exposing the contents of a dirty
+bitmap alongside the associated disk contents.  That metadata context
+is named with the following form:

     qemu:dirty-bitmap:<dirty-bitmap-export-name>

 Each dirty-bitmap metadata context defines only one flag for extents
 in reply for NBD_CMD_BLOCK_STATUS:

-    bit 0: NBD_STATE_DIRTY, means that the extent is "dirty"
+    bit 0: NBD_STATE_DIRTY, set when the extent is "dirty"
+
+The second is related to exposing the source of various extents within
+the image, with a single metadata context named:
+
+    qemu:allocation-depth
+
+In the allocation depth context, the entire 32-bit value represents a
+depth of which layer in a thin-provisioned backing chain provided the
+data (0 for unallocated, 1 for the active layer, 2 for the first
+backing layer, and so forth).

 For NBD_OPT_LIST_META_CONTEXT the following queries are supported
-in addition to "qemu:dirty-bitmap:<dirty-bitmap-export-name>":
+in addition to the specific "qemu:allocation-depth" and
+"qemu:dirty-bitmap:<dirty-bitmap-export-name>":

 * "qemu:" - returns list of all available metadata contexts in the
             namespace.
@@ -55,3 +67,4 @@ the operation of that feature.
 NBD_CMD_BLOCK_STATUS for "qemu:dirty-bitmap:", NBD_CMD_CACHE
 * 4.2: NBD_FLAG_CAN_MULTI_CONN for shareable read-only exports,
 NBD_CMD_FLAG_FAST_ZERO
+* 5.2: NBD_CMD_BLOCK_STATUS for "qemu:allocation-depth"
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 3dd9a04546ec..4a52a43ef598 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -1,5 +1,5 @@
 /*
- *  Copyright (C) 2016-2019 Red Hat, Inc.
+ *  Copyright (C) 2016-2020 Red Hat, Inc.
  *  Copyright (C) 2005  Anthony Liguori <anthony@codemonkey.ws>
  *
  *  Network Block Device
@@ -47,7 +47,7 @@ typedef struct NBDOptionReply NBDOptionReply;
 typedef struct NBDOptionReplyMetaContext {
     NBDOptionReply h; /* h.type = NBD_REP_META_CONTEXT, h.length > 4 */
     uint32_t context_id;
-    /* meta context name follows */
+    /* metadata context name follows */
 } QEMU_PACKED NBDOptionReplyMetaContext;

 /* Transmission phase structs
@@ -229,7 +229,7 @@ enum {
 #define NBD_MAX_BUFFER_SIZE (32 * 1024 * 1024)

 /*
- * Maximum size of a protocol string (export name, meta context name,
+ * Maximum size of a protocol string (export name, metadata context name,
  * etc.).  Use malloc rather than stack allocation for storage of a
  * string.
  */
@@ -259,6 +259,8 @@ enum {
 /* Extent flags for qemu:dirty-bitmap in NBD_REPLY_TYPE_BLOCK_STATUS */
 #define NBD_STATE_DIRTY (1 << 0)

+/* No flags needed for qemu:allocation-depth in NBD_REPLY_TYPE_BLOCK_STATUS */
+
 static inline bool nbd_reply_type_is_error(int type)
 {
     return type & (1 << 15);
diff --git a/nbd/server.c b/nbd/server.c
index b6841e455414..ebbefcb6d3ec 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -27,8 +27,9 @@
 #include "qemu/units.h"

 #define NBD_META_ID_BASE_ALLOCATION 0
+#define NBD_META_ID_ALLOCATION_DEPTH 1
 /* Dirty bitmaps use 'NBD_META_ID_DIRTY_BITMAP + i', so keep this id last. */
-#define NBD_META_ID_DIRTY_BITMAP 1
+#define NBD_META_ID_DIRTY_BITMAP 2

 /*
  * NBD_MAX_BLOCK_STATUS_EXTENTS: 1 MiB of extents data. An empirical
@@ -95,6 +96,7 @@ struct NBDExport {
     BlockBackend *eject_notifier_blk;
     Notifier eject_notifier;

+    bool allocation_depth;
     BdrvDirtyBitmap **export_bitmaps;
     size_t nr_export_bitmaps;
 };
@@ -108,6 +110,7 @@ typedef struct NBDExportMetaContexts {
     NBDExport *exp;
     size_t count; /* number of negotiated contexts */
     bool base_allocation; /* export base:allocation context (block status) */
+    bool allocation_depth; /* export qemu:allocation-depth */
     bool *bitmaps; /*
                     * export qemu:dirty-bitmap:<export bitmap name>,
                     * sized by exp->nr_export_bitmaps
@@ -857,7 +860,8 @@ static bool nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
 /* nbd_meta_qemu_query
  *
  * Handle queries to 'qemu' namespace. For now, only the qemu:dirty-bitmap:
- * context is available.  Return true if @query has been handled.
+ * and qemu:allocation-depth contexts are available.  Return true if @query
+ * has been handled.
  */
 static bool nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,
                                 const char *query)
@@ -871,12 +875,19 @@ static bool nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,

     if (!*query) {
         if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
+            meta->allocation_depth = meta->exp->allocation_depth;
             memset(meta->bitmaps, 1, meta->exp->nr_export_bitmaps);
         }
         trace_nbd_negotiate_meta_query_parse("empty");
         return true;
     }

+    if (strcmp(query, "allocation-depth") == 0) {
+        trace_nbd_negotiate_meta_query_parse("allocation-depth");
+        meta->allocation_depth = meta->exp->allocation_depth;
+        return true;
+    }
+
     if (nbd_strshift(&query, "dirty-bitmap:")) {
         trace_nbd_negotiate_meta_query_parse("dirty-bitmap:");
         if (!*query) {
@@ -901,7 +912,7 @@ static bool nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,
         return true;
     }

-    trace_nbd_negotiate_meta_query_skip("not dirty-bitmap");
+    trace_nbd_negotiate_meta_query_skip("unknown qemu context");
     return true;
 }

@@ -1008,6 +1019,7 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
     if (client->opt == NBD_OPT_LIST_META_CONTEXT && !nb_queries) {
         /* enable all known contexts */
         meta->base_allocation = true;
+        meta->allocation_depth = meta->exp->allocation_depth;
         memset(meta->bitmaps, 1, meta->exp->nr_export_bitmaps);
     } else {
         for (i = 0; i < nb_queries; ++i) {
@@ -1028,6 +1040,16 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
         count++;
     }

+    if (meta->allocation_depth) {
+        ret = nbd_negotiate_send_meta_context(client, "qemu:allocation-depth",
+                                              NBD_META_ID_ALLOCATION_DEPTH,
+                                              errp);
+        if (ret < 0) {
+            return ret;
+        }
+        count++;
+    }
+
     for (i = 0; i < meta->exp->nr_export_bitmaps; i++) {
         const char *bm_name;
         g_autofree char *context = NULL;
@@ -2005,6 +2027,29 @@ static int blockstatus_to_extents(BlockDriverState *bs, uint64_t offset,
     return 0;
 }

+static int blockalloc_to_extents(BlockDriverState *bs, uint64_t offset,
+                                 uint64_t bytes, NBDExtentArray *ea)
+{
+    while (bytes) {
+        int64_t num;
+        int ret = bdrv_is_allocated_above(bs, NULL, false, offset, bytes,
+                                          &num);
+
+        if (ret < 0) {
+            return ret;
+        }
+
+        if (nbd_extent_array_add(ea, num, ret) < 0) {
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
@@ -2044,7 +2089,11 @@ static int nbd_co_send_block_status(NBDClient *client, uint64_t handle,
     unsigned int nb_extents = dont_fragment ? 1 : NBD_MAX_BLOCK_STATUS_EXTENTS;
     g_autoptr(NBDExtentArray) ea = nbd_extent_array_new(nb_extents);

-    ret = blockstatus_to_extents(bs, offset, length, ea);
+    if (context_id == NBD_META_ID_BASE_ALLOCATION) {
+        ret = blockstatus_to_extents(bs, offset, length, ea);
+    } else {
+        ret = blockalloc_to_extents(bs, offset, length, ea);
+    }
     if (ret < 0) {
         return nbd_co_send_structured_error(
                 client, handle, -ret, "can't get block status", errp);
@@ -2395,6 +2444,19 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
                 }
             }

+            if (client->export_meta.allocation_depth) {
+                ret = nbd_co_send_block_status(client, request->handle,
+                                               blk_bs(exp->common.blk),
+                                               request->from, request->len,
+                                               dont_fragment,
+                                               !--contexts_remaining,
+                                               NBD_META_ID_ALLOCATION_DEPTH,
+                                               errp);
+                if (ret < 0) {
+                    return ret;
+                }
+            }
+
             for (i = 0; i < client->exp->nr_export_bitmaps; i++) {
                 if (!client->export_meta.bitmaps[i]) {
                     continue;
-- 
2.29.0


