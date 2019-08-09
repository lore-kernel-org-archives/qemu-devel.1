Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FC2C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:22:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A5B220C01
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5B220C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7f4-0003MH-Gy
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 12:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56991)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hw7XM-00013h-Cd
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:14:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hw7XL-00046J-7p
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:14:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52036)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hw7XI-000424-J7; Fri, 09 Aug 2019 12:14:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C190059451;
 Fri,  9 Aug 2019 16:14:34 +0000 (UTC)
Received: from localhost (unknown [10.40.205.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B3C95C8BA;
 Fri,  9 Aug 2019 16:14:34 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri,  9 Aug 2019 18:13:36 +0200
Message-Id: <20190809161407.11920-12-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-1-mreitz@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 09 Aug 2019 16:14:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 11/42] block: Add
 bdrv_supports_compressed_writes()
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

Filters cannot compress data themselves but they have to implement
.bdrv_co_pwritev_compressed() still (or they cannot forward compressed
writes).  Therefore, checking whether
bs->drv->bdrv_co_pwritev_compressed is non-NULL is not sufficient to
know whether the node can actually handle compressed writes.  This
function looks down the filter chain to see whether there is a
non-filter that can actually convert the compressed writes into
compressed data (and thus normal writes).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block.h |  1 +
 block.c               | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/block/block.h b/include/block/block.h
index 9cfe77abaf..6ba853fb90 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -487,6 +487,7 @@ BlockDriverState *bdrv_next(BdrvNextIterator *it);
 void bdrv_next_cleanup(BdrvNextIterator *it);
=20
 BlockDriverState *bdrv_next_monitor_owned(BlockDriverState *bs);
+bool bdrv_supports_compressed_writes(BlockDriverState *bs);
 void bdrv_iterate_format(void (*it)(void *opaque, const char *name),
                          void *opaque, bool read_only);
 const char *bdrv_get_node_name(const BlockDriverState *bs);
diff --git a/block.c b/block.c
index 415c555bf5..029c809a8e 100644
--- a/block.c
+++ b/block.c
@@ -4696,6 +4696,28 @@ bool bdrv_is_sg(BlockDriverState *bs)
     return bs->sg;
 }
=20
+/**
+ * Return whether the given node supports compressed writes.
+ */
+bool bdrv_supports_compressed_writes(BlockDriverState *bs)
+{
+    BlockDriverState *filtered =3D bdrv_filtered_rw_bs(bs);
+
+    if (!bs->drv || !bs->drv->bdrv_co_pwritev_compressed) {
+        return false;
+    }
+
+    if (filtered) {
+        /*
+         * Filters can only forward compressed writes, so we have to
+         * check the child.
+         */
+        return bdrv_supports_compressed_writes(filtered);
+    }
+
+    return true;
+}
+
 const char *bdrv_get_format_name(BlockDriverState *bs)
 {
     return bs->drv ? bs->drv->format_name : NULL;
--=20
2.21.0


