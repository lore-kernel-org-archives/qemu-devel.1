Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E876C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:43:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AEF52176B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UblzAjPo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AEF52176B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7V0-0006XH-9G
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kD7Ms-0006zP-Gx
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:34:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21109
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kD7Mp-000736-ED
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598970873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cKQlddx1iwXuCQ3iGPWLvy2xVEGWarYimbu8WyeYHtg=;
 b=UblzAjPoroLchwEk9iAq1zmpucE612HBIVFj5G2B8yvW2AgKmbCyaoZ9TuX8H+L5yMRBJN
 e8TRWvrhSAUZlKEAjyfeZwrVUVS8miBO4tnBFcqbuNf7u6a2UoeqKP/FZCQANjJiRvbRhV
 /MuIfV+IerPQT7vvbrJ9q0iwBHs2bQc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-lGipOUyDMG6yGCWYVvwoFg-1; Tue, 01 Sep 2020 10:34:30 -0400
X-MC-Unique: lGipOUyDMG6yGCWYVvwoFg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FA4E839A48;
 Tue,  1 Sep 2020 14:34:29 +0000 (UTC)
Received: from localhost (ovpn-113-83.ams2.redhat.com [10.36.113.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0142B61177;
 Tue,  1 Sep 2020 14:34:28 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v8 01/43] block: Add child access functions
Date: Tue,  1 Sep 2020 16:33:42 +0200
Message-Id: <20200901143424.884735-2-mreitz@redhat.com>
In-Reply-To: <20200901143424.884735-1-mreitz@redhat.com>
References: <20200901143424.884735-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:16:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are BDS children that the general block layer code can access,
namely bs->file and bs->backing.  Since the introduction of filters and
external data files, their meaning is not quite clear.  bs->backing can
be a COW source, or it can be a filtered child; bs->file can be a
filtered child, it can be data and metadata storage, or it can be just
metadata storage.

This overloading really is not helpful.  This patch adds functions that
retrieve the correct child for each exact purpose.  Later patches in
this series will make use of them.  Doing so will allow us to handle
filter nodes in a meaningful way.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block_int.h | 44 +++++++++++++++++--
 block.c                   | 91 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+), 3 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 9da7a42927..f280a95b26 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -92,9 +92,17 @@ struct BlockDriver {
     int instance_size;
 
     /* set to true if the BlockDriver is a block filter. Block filters pass
-     * certain callbacks that refer to data (see block.c) to their bs->file if
-     * the driver doesn't implement them. Drivers that do not wish to forward
-     * must implement them and return -ENOTSUP.
+     * certain callbacks that refer to data (see block.c) to their bs->file
+     * or bs->backing (whichever one exists) if the driver doesn't implement
+     * them. Drivers that do not wish to forward must implement them and return
+     * -ENOTSUP.
+     * Note that filters are not allowed to modify data.
+     *
+     * Filters generally cannot have more than a single filtered child,
+     * because the data they present must at all times be the same as
+     * that on their filtered child.  That would be impossible to
+     * achieve for multiple filtered children.
+     * (And this filtered child must then be bs->file or bs->backing.)
      */
     bool is_filter;
     /*
@@ -1382,4 +1390,34 @@ BdrvDirtyBitmap *block_dirty_bitmap_remove(const char *node, const char *name,
                                            BlockDriverState **bitmap_bs,
                                            Error **errp);
 
+BdrvChild *bdrv_cow_child(BlockDriverState *bs);
+BdrvChild *bdrv_filter_child(BlockDriverState *bs);
+BdrvChild *bdrv_filter_or_cow_child(BlockDriverState *bs);
+BdrvChild *bdrv_primary_child(BlockDriverState *bs);
+
+static inline BlockDriverState *child_bs(BdrvChild *child)
+{
+    return child ? child->bs : NULL;
+}
+
+static inline BlockDriverState *bdrv_cow_bs(BlockDriverState *bs)
+{
+    return child_bs(bdrv_cow_child(bs));
+}
+
+static inline BlockDriverState *bdrv_filter_bs(BlockDriverState *bs)
+{
+    return child_bs(bdrv_filter_child(bs));
+}
+
+static inline BlockDriverState *bdrv_filter_or_cow_bs(BlockDriverState *bs)
+{
+    return child_bs(bdrv_filter_or_cow_child(bs));
+}
+
+static inline BlockDriverState *bdrv_primary_bs(BlockDriverState *bs)
+{
+    return child_bs(bdrv_primary_child(bs));
+}
+
 #endif /* BLOCK_INT_H */
diff --git a/block.c b/block.c
index b204b93a2e..9f866e8676 100644
--- a/block.c
+++ b/block.c
@@ -6943,3 +6943,94 @@ int bdrv_make_empty(BdrvChild *c, Error **errp)
 
     return 0;
 }
+
+/*
+ * Return the child that @bs acts as an overlay for, and from which data may be
+ * copied in COW or COR operations.  Usually this is the backing file.
+ */
+BdrvChild *bdrv_cow_child(BlockDriverState *bs)
+{
+    if (!bs || !bs->drv) {
+        return NULL;
+    }
+
+    if (bs->drv->is_filter) {
+        return NULL;
+    }
+
+    if (!bs->backing) {
+        return NULL;
+    }
+
+    assert(bs->backing->role & BDRV_CHILD_COW);
+    return bs->backing;
+}
+
+/*
+ * If @bs acts as a filter for exactly one of its children, return
+ * that child.
+ */
+BdrvChild *bdrv_filter_child(BlockDriverState *bs)
+{
+    BdrvChild *c;
+
+    if (!bs || !bs->drv) {
+        return NULL;
+    }
+
+    if (!bs->drv->is_filter) {
+        return NULL;
+    }
+
+    /* Only one of @backing or @file may be used */
+    assert(!(bs->backing && bs->file));
+
+    c = bs->backing ?: bs->file;
+    if (!c) {
+        return NULL;
+    }
+
+    assert(c->role & BDRV_CHILD_FILTERED);
+    return c;
+}
+
+/*
+ * Return either the result of bdrv_cow_child() or bdrv_filter_child(),
+ * whichever is non-NULL.
+ *
+ * Return NULL if both are NULL.
+ */
+BdrvChild *bdrv_filter_or_cow_child(BlockDriverState *bs)
+{
+    BdrvChild *cow_child = bdrv_cow_child(bs);
+    BdrvChild *filter_child = bdrv_filter_child(bs);
+
+    /* Filter nodes cannot have COW backing files */
+    assert(!(cow_child && filter_child));
+
+    return cow_child ?: filter_child;
+}
+
+/*
+ * Return the primary child of this node: For filters, that is the
+ * filtered child.  For other nodes, that is usually the child storing
+ * metadata.
+ * (A generally more helpful description is that this is (usually) the
+ * child that has the same filename as @bs.)
+ *
+ * Drivers do not necessarily have a primary child; for example quorum
+ * does not.
+ */
+BdrvChild *bdrv_primary_child(BlockDriverState *bs)
+{
+    BdrvChild *c, *found = NULL;
+
+    QLIST_FOREACH(c, &bs->children, next) {
+        if (c->role & BDRV_CHILD_PRIMARY) {
+            assert(!found);
+            found = c;
+        }
+    }
+
+    return found;
+}
-- 
2.26.2


