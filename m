Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3616C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F962086A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F962086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7ZQ-0006rb-IL
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 12:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56774)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hw7X8-0000Xs-Ha
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:14:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hw7X7-0003xi-Eu
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:14:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58156)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hw7X4-0003tH-HV; Fri, 09 Aug 2019 12:14:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0B0B18E90E;
 Fri,  9 Aug 2019 16:14:21 +0000 (UTC)
Received: from localhost (unknown [10.40.205.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BD7919C70;
 Fri,  9 Aug 2019 16:14:20 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri,  9 Aug 2019 18:13:30 +0200
Message-Id: <20190809161407.11920-6-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-1-mreitz@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 09 Aug 2019 16:14:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 05/42] block: Add chain helper functions
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

Add some helper functions for skipping filters in a chain of block
nodes.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block_int.h |  3 +++
 block.c                   | 55 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 6c60abc4c3..5bec3361fd 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1291,6 +1291,9 @@ BdrvChild *bdrv_filtered_child(BlockDriverState *bs=
);
 BdrvChild *bdrv_metadata_child(BlockDriverState *bs);
 BdrvChild *bdrv_storage_child(BlockDriverState *bs);
 BdrvChild *bdrv_primary_child(BlockDriverState *bs);
+BlockDriverState *bdrv_skip_implicit_filters(BlockDriverState *bs);
+BlockDriverState *bdrv_skip_rw_filters(BlockDriverState *bs);
+BlockDriverState *bdrv_backing_chain_next(BlockDriverState *bs);
=20
 static inline BlockDriverState *child_bs(BdrvChild *child)
 {
diff --git a/block.c b/block.c
index f6c5f8c3eb..bfa5e27850 100644
--- a/block.c
+++ b/block.c
@@ -6655,3 +6655,58 @@ BdrvChild *bdrv_primary_child(BlockDriverState *bs=
)
 {
     return bdrv_filtered_rw_child(bs) ?: bs->file;
 }
+
+static BlockDriverState *bdrv_skip_filters(BlockDriverState *bs,
+                                           bool stop_on_explicit_filter)
+{
+    BdrvChild *filtered;
+
+    if (!bs) {
+        return NULL;
+    }
+
+    while (!(stop_on_explicit_filter && !bs->implicit)) {
+        filtered =3D bdrv_filtered_rw_child(bs);
+        if (!filtered) {
+            break;
+        }
+        bs =3D filtered->bs;
+    }
+    /*
+     * Note that this treats nodes with bs->drv =3D=3D NULL as not being
+     * R/W filters (bs->drv =3D=3D NULL should be replaced by something
+     * else anyway).
+     * The advantage of this behavior is that this function will thus
+     * always return a non-NULL value (given a non-NULL @bs).
+     */
+
+    return bs;
+}
+
+/*
+ * Return the first BDS that has not been added implicitly or that
+ * does not have an RW-filtered child down the chain starting from @bs
+ * (including @bs itself).
+ */
+BlockDriverState *bdrv_skip_implicit_filters(BlockDriverState *bs)
+{
+    return bdrv_skip_filters(bs, true);
+}
+
+/*
+ * Return the first BDS that does not have an RW-filtered child down
+ * the chain starting from @bs (including @bs itself).
+ */
+BlockDriverState *bdrv_skip_rw_filters(BlockDriverState *bs)
+{
+    return bdrv_skip_filters(bs, false);
+}
+
+/*
+ * For a backing chain, return the first non-filter backing image of
+ * the first non-filter image.
+ */
+BlockDriverState *bdrv_backing_chain_next(BlockDriverState *bs)
+{
+    return bdrv_skip_rw_filters(bdrv_filtered_cow_bs(bdrv_skip_rw_filter=
s(bs)));
+}
--=20
2.21.0


