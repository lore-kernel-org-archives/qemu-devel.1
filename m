Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21990C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:30:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 982BB206D4
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SGLxe3ji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982BB206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFFLU-0001jH-Oj
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 07:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFF44-00063U-3W
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:12:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28723
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFF41-0008Tj-HQ
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599477117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TaK0DczwpaRjpP1BrXTC9rD5vslCsr5O0k2nE8zWsAU=;
 b=SGLxe3ji+ethZ4SZ2lK7eFKXxUfThcRxZGYMieWa1t0B4jPnLadHJehhGuYb1gaO7bNb1C
 aIV8Q2wMNRu4o4RtsVDNDb0i6H5zXf9t3YVrY5BLkgnGYBwduKwhZiK8iNgVcAptPh5bb0
 Q579ydGBfahpGoAnYkqso8vF2ovrP78=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265--ZdnJ8mUNlyA0fBfqhGT7A-1; Mon, 07 Sep 2020 07:10:33 -0400
X-MC-Unique: -ZdnJ8mUNlyA0fBfqhGT7A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6A361DDEC;
 Mon,  7 Sep 2020 11:10:32 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-154.ams2.redhat.com
 [10.36.114.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E2E729CBA;
 Mon,  7 Sep 2020 11:10:31 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 37/64] block/snapshot: Fix fallback
Date: Mon,  7 Sep 2020 13:09:09 +0200
Message-Id: <20200907110936.261684-38-kwolf@redhat.com>
In-Reply-To: <20200907110936.261684-1-kwolf@redhat.com>
References: <20200907110936.261684-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 02:54:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

If the top node's driver does not provide snapshot functionality and we
want to fall back to a node down the chain, we need to snapshot all
non-COW children.  For simplicity's sake, just do not fall back if there
is more than one such child.  Furthermore, we really only can fall back
to bs->file and bs->backing, because bdrv_snapshot_goto() has to modify
the child link (notably, set it to NULL).

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block/snapshot.c | 104 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 83 insertions(+), 21 deletions(-)

diff --git a/block/snapshot.c b/block/snapshot.c
index bd9fb01817..a2bf3a54eb 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -147,6 +147,56 @@ bool bdrv_snapshot_find_by_id_and_name(BlockDriverState *bs,
     return ret;
 }
 
+/**
+ * Return a pointer to the child BDS pointer to which we can fall
+ * back if the given BDS does not support snapshots.
+ * Return NULL if there is no BDS to (safely) fall back to.
+ *
+ * We need to return an indirect pointer because bdrv_snapshot_goto()
+ * has to modify the BdrvChild pointer.
+ */
+static BdrvChild **bdrv_snapshot_fallback_ptr(BlockDriverState *bs)
+{
+    BdrvChild **fallback;
+    BdrvChild *child;
+
+    /*
+     * The only BdrvChild pointers that are safe to modify (and which
+     * we can thus return a reference to) are bs->file and
+     * bs->backing.
+     */
+    fallback = &bs->file;
+    if (!*fallback && bs->drv && bs->drv->is_filter) {
+        fallback = &bs->backing;
+    }
+
+    if (!*fallback) {
+        return NULL;
+    }
+
+    /*
+     * Check that there are no other children that would need to be
+     * snapshotted.  If there are, it is not safe to fall back to
+     * *fallback.
+     */
+    QLIST_FOREACH(child, &bs->children, next) {
+        if (child->role & (BDRV_CHILD_DATA | BDRV_CHILD_METADATA |
+                           BDRV_CHILD_FILTERED) &&
+            child != *fallback)
+        {
+            return NULL;
+        }
+    }
+
+    return fallback;
+}
+
+static BlockDriverState *bdrv_snapshot_fallback(BlockDriverState *bs)
+{
+    BdrvChild **child_ptr = bdrv_snapshot_fallback_ptr(bs);
+    return child_ptr ? (*child_ptr)->bs : NULL;
+}
+
 int bdrv_can_snapshot(BlockDriverState *bs)
 {
     BlockDriver *drv = bs->drv;
@@ -155,8 +205,9 @@ int bdrv_can_snapshot(BlockDriverState *bs)
     }
 
     if (!drv->bdrv_snapshot_create) {
-        if (bs->file != NULL) {
-            return bdrv_can_snapshot(bs->file->bs);
+        BlockDriverState *fallback_bs = bdrv_snapshot_fallback(bs);
+        if (fallback_bs) {
+            return bdrv_can_snapshot(fallback_bs);
         }
         return 0;
     }
@@ -168,14 +219,15 @@ int bdrv_snapshot_create(BlockDriverState *bs,
                          QEMUSnapshotInfo *sn_info)
 {
     BlockDriver *drv = bs->drv;
+    BlockDriverState *fallback_bs = bdrv_snapshot_fallback(bs);
     if (!drv) {
         return -ENOMEDIUM;
     }
     if (drv->bdrv_snapshot_create) {
         return drv->bdrv_snapshot_create(bs, sn_info);
     }
-    if (bs->file) {
-        return bdrv_snapshot_create(bs->file->bs, sn_info);
+    if (fallback_bs) {
+        return bdrv_snapshot_create(fallback_bs, sn_info);
     }
     return -ENOTSUP;
 }
@@ -185,6 +237,7 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
                        Error **errp)
 {
     BlockDriver *drv = bs->drv;
+    BdrvChild **fallback_ptr;
     int ret, open_ret;
 
     if (!drv) {
@@ -205,39 +258,46 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
         return ret;
     }
 
-    if (bs->file) {
-        BlockDriverState *file;
-        QDict *options = qdict_clone_shallow(bs->options);
+    fallback_ptr = bdrv_snapshot_fallback_ptr(bs);
+    if (fallback_ptr) {
+        QDict *options;
         QDict *file_options;
         Error *local_err = NULL;
+        BlockDriverState *fallback_bs = (*fallback_ptr)->bs;
+        char *subqdict_prefix = g_strdup_printf("%s.", (*fallback_ptr)->name);
+
+        options = qdict_clone_shallow(bs->options);
 
-        file = bs->file->bs;
         /* Prevent it from getting deleted when detached from bs */
-        bdrv_ref(file);
+        bdrv_ref(fallback_bs);
 
-        qdict_extract_subqdict(options, &file_options, "file.");
+        qdict_extract_subqdict(options, &file_options, subqdict_prefix);
         qobject_unref(file_options);
-        qdict_put_str(options, "file", bdrv_get_node_name(file));
+        g_free(subqdict_prefix);
+
+        qdict_put_str(options, (*fallback_ptr)->name,
+                      bdrv_get_node_name(fallback_bs));
 
         if (drv->bdrv_close) {
             drv->bdrv_close(bs);
         }
-        bdrv_unref_child(bs, bs->file);
-        bs->file = NULL;
 
-        ret = bdrv_snapshot_goto(file, snapshot_id, errp);
+        bdrv_unref_child(bs, *fallback_ptr);
+        *fallback_ptr = NULL;
+
+        ret = bdrv_snapshot_goto(fallback_bs, snapshot_id, errp);
         open_ret = drv->bdrv_open(bs, options, bs->open_flags, &local_err);
         qobject_unref(options);
         if (open_ret < 0) {
-            bdrv_unref(file);
+            bdrv_unref(fallback_bs);
             bs->drv = NULL;
             /* A bdrv_snapshot_goto() error takes precedence */
             error_propagate(errp, local_err);
             return ret < 0 ? ret : open_ret;
         }
 
-        assert(bs->file->bs == file);
-        bdrv_unref(file);
+        assert(fallback_bs == (*fallback_ptr)->bs);
+        bdrv_unref(fallback_bs);
         return ret;
     }
 
@@ -273,6 +333,7 @@ int bdrv_snapshot_delete(BlockDriverState *bs,
                          Error **errp)
 {
     BlockDriver *drv = bs->drv;
+    BlockDriverState *fallback_bs = bdrv_snapshot_fallback(bs);
     int ret;
 
     if (!drv) {
@@ -289,8 +350,8 @@ int bdrv_snapshot_delete(BlockDriverState *bs,
 
     if (drv->bdrv_snapshot_delete) {
         ret = drv->bdrv_snapshot_delete(bs, snapshot_id, name, errp);
-    } else if (bs->file) {
-        ret = bdrv_snapshot_delete(bs->file->bs, snapshot_id, name, errp);
+    } else if (fallback_bs) {
+        ret = bdrv_snapshot_delete(fallback_bs, snapshot_id, name, errp);
     } else {
         error_setg(errp, "Block format '%s' used by device '%s' "
                    "does not support internal snapshot deletion",
@@ -306,14 +367,15 @@ int bdrv_snapshot_list(BlockDriverState *bs,
                        QEMUSnapshotInfo **psn_info)
 {
     BlockDriver *drv = bs->drv;
+    BlockDriverState *fallback_bs = bdrv_snapshot_fallback(bs);
     if (!drv) {
         return -ENOMEDIUM;
     }
     if (drv->bdrv_snapshot_list) {
         return drv->bdrv_snapshot_list(bs, psn_info);
     }
-    if (bs->file) {
-        return bdrv_snapshot_list(bs->file->bs, psn_info);
+    if (fallback_bs) {
+        return bdrv_snapshot_list(fallback_bs, psn_info);
     }
     return -ENOTSUP;
 }
-- 
2.25.4


