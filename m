Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A052C3A5A3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:51:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC0D721874
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZdBx1Oc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC0D721874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Fap-0002T8-Jf
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 15:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51959)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1319249da=dmitry.fomichev@wdc.com>)
 id 1i1FZ4-0000Md-MV
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1319249da=dmitry.fomichev@wdc.com>)
 id 1i1FZ3-0000Yy-1p
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:49:38 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:47023)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1319249da=dmitry.fomichev@wdc.com>)
 id 1i1FYz-0000VF-Ot; Fri, 23 Aug 2019 15:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566589773; x=1598125773;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wDuJg/PXjCdmnfQAHj6RMyp+qTSDniP3cOnxGOeYBNk=;
 b=ZdBx1Oc31O2p3EKfsP1mrbbvP00UeNfeBX4wS14zVgs9i4bcpUNj13PM
 PVgFXKTtwkvSFIQP/i1105F90o506/O/280bd3HGtPboc1U+1FIdUHa9p
 duphs02L0t3M/ZEvGa8nqPYbIC5TNrkH3XPVFZdFn+1rLwSpWHslcihSt
 y1t0AXMi1/7A5xPlyfrWIbUyx0JtyTtwnu5Kfts3YME5QhJxDEYgfes15
 hD0NxI82pkmyu2ppfG6UN6aiSOlzocgfJUJVBf6OUic41HEnmwoxmG8sA
 2b/UWTXxnmWJRpL7eCp5AlZl2rqb1nXI0le+PI/NXkRmU53dXTaHOnJrv w==;
IronPort-SDR: BkLd43PsiEyLo3YtORPUd+trE32xhYz7CPl+yZsW4rctQkkurPhJzwuhGC+twkEKOT5fDcv27i
 qOM1lV4Mj2JuR14EpmQyROTqM06MWIceY9pnf1HI3cJpRxZD+zzUdSBWzAAw4xTdYgBpb57RZX
 BrtDjZDmX6z3uk1oOs7hAkhO2SFdahxoBN/KqtdbDBXEzDChJVFmbUsoiKw+vkvKolrGuPiK7H
 DslOllVyssq7r+4TJpOj0pMPpqqt1VrqwqtMpsBQqCIEe63X3lyl2H4ZPqvrlkLPKJ/5XjSUqJ
 lcc=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="223162541"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 03:49:30 +0800
IronPort-SDR: J2WD8F5Xn2K/+kvKZjgoSimlYh3VTOJ7rBZw7wPc35M5XwQxy5bXiRxsRKyJkXrNFOgqRhgSgc
 Zo5y2UWR06xSa5iArXaDK8b893rjizFb2Zyy1xXWNrobt2aej7tIt285lWv8gec8ZcGhsZnNuu
 VYX/uJ2au8uHR4TcDmrF9VGFDjPHPf8W2u4eHLP7dGHG9zKOBEW83gAyF7T+8Rphmcz4mqBhKb
 X9hDsikyB7+0dwrM+GyNAgkisQ27uidguVLK783vfUJczcn2jWHoMTufw1YKS42MQDy27TJAnQ
 nG1wYFeJKmu2J2giMp8BIc4l
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 12:46:47 -0700
IronPort-SDR: vBJ9GDBcUKCJ43pvweSm+35EnA3o/bF8Jnl6zCZxQYOqPFDuqfzIo4eNWx4X1/lWRf0Rl8bP6K
 anjdzADvqGrGsiM9wSoRIR6g030S7Bwi/2eEDeM2XN0y+8FhK87P1BhzhNglLUlzpL8JjplDDD
 3uKiNIMlq+PdWJXR07NGJ3C4vdVn2QsRlwR1rJVTgLBFIvMoxsrASxkL89UQisXVnbFr+Rqlq+
 r7fEuBA9YNTr9iX+m8QwsWdVRHM0Q5v5P76tBUDBoFa9H3YEl4N46n6sf+VJP3VxFgHKmUH901
 HMk=
WDCIronportException: Internal
Received: from dhcp-10-88-173-43.hgst.com ([10.88.173.43])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 12:49:29 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Date: Fri, 23 Aug 2019 15:49:24 -0400
Message-Id: <20190823194927.23278-2-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190823194927.23278-1-dmitry.fomichev@wdc.com>
References: <20190823194927.23278-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.141.245
Subject: [Qemu-devel] [PATCH v5 1/4] block: Add zoned device model property
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
Cc: Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit adds Zoned Device Model (as defined in T10 ZBC and
T13 ZAC standards) as a block driver property, along with some
useful access functions.

A new backend driver permission, BLK_PERM_SUPPORT_ZONED, is also
introduced. Only the drivers having this permission will be allowed
to open zoned block devices.

No code is added yet to initialize or check the value of this new
property, therefore this commit doesn't change any functionality.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 block.c                   | 19 +++++++++++++++++++
 include/block/block.h     | 21 ++++++++++++++++++++-
 include/block/block_int.h |  4 ++++
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 874a29a983..6dd4cecded 100644
--- a/block.c
+++ b/block.c
@@ -4679,6 +4679,25 @@ void bdrv_get_geometry(BlockDriverState *bs, uint64_t *nb_sectors_ptr)
     *nb_sectors_ptr = nb_sectors < 0 ? 0 : nb_sectors;
 }
 
+uint8_t bdrv_get_zoned_model(BlockDriverState *bs)
+{
+    if (bs->drv->bdrv_get_zoned_info) {
+        bs->drv->bdrv_get_zoned_info(bs);
+    }
+
+    return bs->bl.zoned_model;
+}
+
+uint8_t bdrv_is_zoned(BlockDriverState *bs)
+{
+    /*
+     * Host Aware zone devices are supposed to be able to work
+     * just like regular block devices. Thus, we only consider
+     * Host Managed devices to be zoned here.
+     */
+    return bdrv_get_zoned_model(bs) == BLK_ZONED_MODEL_HM;
+}
+
 bool bdrv_is_sg(BlockDriverState *bs)
 {
     return bs->sg;
diff --git a/include/block/block.h b/include/block/block.h
index 124ad40809..238c0f5ed7 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -271,18 +271,35 @@ enum {
      */
     BLK_PERM_GRAPH_MOD          = 0x10,
 
+    /** This permission is required to open zoned block devices. */
+    BLK_PERM_SUPPORT_ZONED      = 0x20,
+
     BLK_PERM_ALL                = 0x1f,
 
     DEFAULT_PERM_PASSTHROUGH    = BLK_PERM_CONSISTENT_READ
                                  | BLK_PERM_WRITE
                                  | BLK_PERM_WRITE_UNCHANGED
-                                 | BLK_PERM_RESIZE,
+                                 | BLK_PERM_RESIZE
+                                 | BLK_PERM_SUPPORT_ZONED,
 
     DEFAULT_PERM_UNCHANGED      = BLK_PERM_ALL & ~DEFAULT_PERM_PASSTHROUGH,
 };
 
 char *bdrv_perm_names(uint64_t perm);
 
+/*
+ * Known zoned device models.
+ *
+ * TODO For a Linux host, it could be preferrable to include
+ * /usr/include/linux/blkzoned.h instead of defining ZBD-specific
+ * values here.
+ */
+enum blk_zoned_model {
+    BLK_ZONED_MODEL_NONE, /* Regular block device */
+    BLK_ZONED_MODEL_HA,   /* Host-aware zoned block device */
+    BLK_ZONED_MODEL_HM,   /* Host-managed zoned block device */
+};
+
 /* disk I/O throttling */
 void bdrv_init(void);
 void bdrv_init_with_whitelist(void);
@@ -359,6 +376,8 @@ int64_t bdrv_get_allocated_file_size(BlockDriverState *bs);
 BlockMeasureInfo *bdrv_measure(BlockDriver *drv, QemuOpts *opts,
                                BlockDriverState *in_bs, Error **errp);
 void bdrv_get_geometry(BlockDriverState *bs, uint64_t *nb_sectors_ptr);
+uint8_t bdrv_get_zoned_model(BlockDriverState *bs);
+uint8_t bdrv_is_zoned(BlockDriverState *bs);
 void bdrv_refresh_limits(BlockDriverState *bs, Error **errp);
 int bdrv_commit(BlockDriverState *bs);
 int bdrv_change_backing_file(BlockDriverState *bs,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index ceec8c2f56..91496e8149 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -415,6 +415,7 @@ struct BlockDriver {
     bool (*bdrv_debug_is_suspended)(BlockDriverState *bs, const char *tag);
 
     void (*bdrv_refresh_limits)(BlockDriverState *bs, Error **errp);
+    void (*bdrv_get_zoned_info)(BlockDriverState *bs);
 
     /*
      * Returns 1 if newly created images are guaranteed to contain only
@@ -620,6 +621,9 @@ typedef struct BlockLimits {
 
     /* maximum number of iovec elements */
     int max_iov;
+
+    /* Zoned device model. Zero value indicates a regular block device */
+    uint8_t zoned_model;
 } BlockLimits;
 
 typedef struct BdrvOpBlocker BdrvOpBlocker;
-- 
2.21.0


