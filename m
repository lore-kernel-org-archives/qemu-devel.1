Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BCEC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:18:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88E202086A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E202086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7ao-0001Dm-Q2
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 12:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56789)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hw7X9-0000ZD-5L
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:14:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hw7X7-0003xv-Mz
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:14:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32792)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hw7X3-0003sN-1C; Fri, 09 Aug 2019 12:14:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C0007307D989;
 Fri,  9 Aug 2019 16:14:18 +0000 (UTC)
Received: from localhost (unknown [10.40.205.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C418600CD;
 Fri,  9 Aug 2019 16:14:17 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri,  9 Aug 2019 18:13:29 +0200
Message-Id: <20190809161407.11920-5-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-1-mreitz@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 09 Aug 2019 16:14:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 04/42] block: Add child access functions
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are BDS children that the general block layer code can access,
namely bs->file and bs->backing.  Since the introduction of filters and
external data files, their meaning is not quite clear.  bs->backing can
be a COW source, or it can be an R/W-filtered child; bs->file can be an
R/W-filtered child, it can be data and metadata storage, or it can be
just metadata storage.

This overloading really is not helpful.  This patch adds function that
retrieve the correct child for each exact purpose.  Later patches in
this series will make use of them.  Doing so will allow us to handle
filter nodes and external data files in a meaningful way.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block_int.h | 57 ++++++++++++++++++++--
 block.c                   | 99 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 153 insertions(+), 3 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 60d9261f8e..6c60abc4c3 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -90,9 +90,11 @@ struct BlockDriver {
     int instance_size;
=20
     /* set to true if the BlockDriver is a block filter. Block filters p=
ass
-     * certain callbacks that refer to data (see block.c) to their bs->f=
ile if
-     * the driver doesn't implement them. Drivers that do not wish to fo=
rward
-     * must implement them and return -ENOTSUP.
+     * certain callbacks that refer to data (see block.c) to their bs->f=
ile
+     * or bs->backing (whichever one exists) if the driver doesn't imple=
ment
+     * them. Drivers that do not wish to forward must implement them and=
 return
+     * -ENOTSUP.
+     * Note that filters are not allowed to modify data.
      */
     bool is_filter;
     /* for snapshots block filter like Quorum can implement the
@@ -562,6 +564,13 @@ struct BlockDriver {
      * If this pointer is NULL, the array is considered empty.
      * "filename" and "driver" are always considered strong. */
     const char *const *strong_runtime_opts;
+
+    /**
+     * Return the data storage child, if there is exactly one.  If
+     * this function is not implemented, the block layer will assume
+     * bs->file to be this child.
+     */
+    BdrvChild *(*bdrv_storage_child)(BlockDriverState *bs);
 };
=20
 typedef struct BlockLimits {
@@ -1276,4 +1285,46 @@ int coroutine_fn bdrv_co_copy_range_to(BdrvChild *=
src, uint64_t src_offset,
=20
 int refresh_total_sectors(BlockDriverState *bs, int64_t hint);
=20
+BdrvChild *bdrv_filtered_cow_child(BlockDriverState *bs);
+BdrvChild *bdrv_filtered_rw_child(BlockDriverState *bs);
+BdrvChild *bdrv_filtered_child(BlockDriverState *bs);
+BdrvChild *bdrv_metadata_child(BlockDriverState *bs);
+BdrvChild *bdrv_storage_child(BlockDriverState *bs);
+BdrvChild *bdrv_primary_child(BlockDriverState *bs);
+
+static inline BlockDriverState *child_bs(BdrvChild *child)
+{
+    return child ? child->bs : NULL;
+}
+
+static inline BlockDriverState *bdrv_filtered_cow_bs(BlockDriverState *b=
s)
+{
+    return child_bs(bdrv_filtered_cow_child(bs));
+}
+
+static inline BlockDriverState *bdrv_filtered_rw_bs(BlockDriverState *bs=
)
+{
+    return child_bs(bdrv_filtered_rw_child(bs));
+}
+
+static inline BlockDriverState *bdrv_filtered_bs(BlockDriverState *bs)
+{
+    return child_bs(bdrv_filtered_child(bs));
+}
+
+static inline BlockDriverState *bdrv_metadata_bs(BlockDriverState *bs)
+{
+    return child_bs(bdrv_metadata_child(bs));
+}
+
+static inline BlockDriverState *bdrv_storage_bs(BlockDriverState *bs)
+{
+    return child_bs(bdrv_storage_child(bs));
+}
+
+static inline BlockDriverState *bdrv_primary_bs(BlockDriverState *bs)
+{
+    return child_bs(bdrv_primary_child(bs));
+}
+
 #endif /* BLOCK_INT_H */
diff --git a/block.c b/block.c
index aae3417dd5..f6c5f8c3eb 100644
--- a/block.c
+++ b/block.c
@@ -6556,3 +6556,102 @@ bool bdrv_can_store_new_dirty_bitmap(BlockDriverS=
tate *bs, const char *name,
=20
     return drv->bdrv_can_store_new_dirty_bitmap(bs, name, granularity, e=
rrp);
 }
+
+/*
+ * Return the child that @bs acts as an overlay for, and from which data=
 may be
+ * copied in COW or COR operations.  Usually this is the backing file.
+ */
+BdrvChild *bdrv_filtered_cow_child(BlockDriverState *bs)
+{
+    if (!bs || !bs->drv) {
+        return NULL;
+    }
+
+    if (bs->drv->is_filter) {
+        return NULL;
+    }
+
+    return bs->backing;
+}
+
+/*
+ * If @bs acts as a pass-through filter for one of its children,
+ * return that child.  "Pass-through" means that write operations to
+ * @bs are forwarded to that child instead of triggering COW.
+ */
+BdrvChild *bdrv_filtered_rw_child(BlockDriverState *bs)
+{
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
+    return bs->backing ?: bs->file;
+}
+
+/*
+ * Return any filtered child, independently of how it reacts to write
+ * accesses and whether data is copied onto this BDS through COR.
+ */
+BdrvChild *bdrv_filtered_child(BlockDriverState *bs)
+{
+    BdrvChild *cow_child =3D bdrv_filtered_cow_child(bs);
+    BdrvChild *rw_child =3D bdrv_filtered_rw_child(bs);
+
+    /* There can only be one filtered child at a time */
+    assert(!(cow_child && rw_child));
+
+    return cow_child ?: rw_child;
+}
+
+/*
+ * Return the child that stores the metadata for this node.
+ */
+BdrvChild *bdrv_metadata_child(BlockDriverState *bs)
+{
+    if (!bs || !bs->drv) {
+        return NULL;
+    }
+
+    /* Filters do not have metadata */
+    if (bs->drv->is_filter) {
+        return NULL;
+    }
+
+    return bs->file;
+}
+
+/*
+ * Return the child that stores the data that is allocated on this
+ * node.  This may or may not include metadata.
+ */
+BdrvChild *bdrv_storage_child(BlockDriverState *bs)
+{
+    if (!bs || !bs->drv) {
+        return NULL;
+    }
+
+    if (bs->drv->bdrv_storage_child) {
+        return bs->drv->bdrv_storage_child(bs);
+    }
+
+    return bdrv_filtered_rw_child(bs) ?: bs->file;
+}
+
+/*
+ * Return the primary child of this node: For filters, that is the
+ * filtered child.  For other nodes, that is usually the child storing
+ * metadata.
+ * (A generally more helpful description is that this is (usually) the
+ * child that has the same filename as @bs.)
+ */
+BdrvChild *bdrv_primary_child(BlockDriverState *bs)
+{
+    return bdrv_filtered_rw_child(bs) ?: bs->file;
+}
--=20
2.21.0


