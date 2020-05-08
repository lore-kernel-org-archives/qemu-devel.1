Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7903C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:07:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FDF12184D
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjnS6dim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FDF12184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX7P1-0006XU-Hp
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 14:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jX7Lo-0000Db-DF
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:03:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50430
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jX7Ln-0007RI-Fq
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588961034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QFsU1fnG+OxiO3NOXekzCY6P7K+iTcnWsAzh/BfR9i0=;
 b=cjnS6dim8Yvppq3LQMTHUtTR1b1ZAZf7pFoxgOsskk3ZtQrrhZro02uPe7ql5B7B6mna7M
 50M76n7qZatAE23zmhsvWCZaWe/H1jotrj6yBZA6vZQV6rMqIi12eCj/24xzW9A9Ixe+c5
 P8vpEuUWGuYgKSd/YRlDY4ANaxW3p+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-yTev0zgyNjaHPdQTrAMd5g-1; Fri, 08 May 2020 14:03:48 -0400
X-MC-Unique: yTev0zgyNjaHPdQTrAMd5g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C551107ACCA;
 Fri,  8 May 2020 18:03:47 +0000 (UTC)
Received: from blue.redhat.com (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC38F6199C;
 Fri,  8 May 2020 18:03:46 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/9] block: Make it easier to learn which BDS support
 bitmaps
Date: Fri,  8 May 2020 13:03:34 -0500
Message-Id: <20200508180340.675712-4-eblake@redhat.com>
In-Reply-To: <20200508180340.675712-1-eblake@redhat.com>
References: <20200508180340.675712-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 08:00:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Upcoming patches will enhance bitmap support in qemu-img, but in doing
so, it turns out to be nice to suppress output when bitmaps make no
sense (such as on a qcow2 v2 image).  Add a hook to make this easier
to query.

In the future, when we improve the ability to look up bitmaps through
a filter, we will probably also want to teach the block layer to
automatically let filters pass this request on through.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2.h                | 1 +
 include/block/block_int.h    | 1 +
 include/block/dirty-bitmap.h | 1 +
 block/dirty-bitmap.c         | 9 +++++++++
 block/qcow2-bitmap.c         | 7 +++++++
 block/qcow2.c                | 1 +
 6 files changed, 20 insertions(+)

diff --git a/block/qcow2.h b/block/qcow2.h
index f4de0a27d5c3..fb2b2b5a7b4d 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -764,6 +764,7 @@ bool qcow2_co_can_store_new_dirty_bitmap(BlockDriverState *bs,
 int qcow2_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
                                             const char *name,
                                             Error **errp);
+bool qcow2_dirty_bitmap_supported(BlockDriverState *bs);

 ssize_t coroutine_fn
 qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index df6d0273d679..cb1082da4c43 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -560,6 +560,7 @@ struct BlockDriver {
                              uint64_t parent_perm, uint64_t parent_shared,
                              uint64_t *nperm, uint64_t *nshared);

+    bool (*bdrv_dirty_bitmap_supported)(BlockDriverState *bs);
     bool (*bdrv_co_can_store_new_dirty_bitmap)(BlockDriverState *bs,
                                                const char *name,
                                                uint32_t granularity,
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 8a1002941892..6d2e1707639f 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -16,6 +16,7 @@ typedef enum BitmapCheckFlags {

 #define BDRV_BITMAP_MAX_NAME_SIZE 1023

+bool bdrv_dirty_bitmap_supported(BlockDriverState *bs);
 BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
                                           uint32_t granularity,
                                           const char *name,
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 063793e31606..89869c483c44 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -478,6 +478,15 @@ int bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs, const char *name,
     }
 }

+bool
+bdrv_dirty_bitmap_supported(BlockDriverState *bs)
+{
+    if (bs->drv && bs->drv->bdrv_dirty_bitmap_supported) {
+        return bs->drv->bdrv_dirty_bitmap_supported(bs);
+    }
+    return false;
+}
+
 static bool coroutine_fn
 bdrv_co_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
                                    uint32_t granularity, Error **errp)
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index cb06954b4a5a..b9889c2144cd 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1748,3 +1748,10 @@ fail:
                   name, bdrv_get_device_or_node_name(bs));
     return false;
 }
+
+bool qcow2_dirty_bitmap_supported(BlockDriverState *bs)
+{
+    BDRVQcow2State *s = bs->opaque;
+
+    return s->qcow_version >= 3;
+}
diff --git a/block/qcow2.c b/block/qcow2.c
index 1ad95ff04851..838d810ca5ec 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5663,6 +5663,7 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_detach_aio_context  = qcow2_detach_aio_context,
     .bdrv_attach_aio_context  = qcow2_attach_aio_context,

+    .bdrv_dirty_bitmap_supported = qcow2_dirty_bitmap_supported,
     .bdrv_co_can_store_new_dirty_bitmap = qcow2_co_can_store_new_dirty_bitmap,
     .bdrv_co_remove_persistent_dirty_bitmap =
             qcow2_co_remove_persistent_dirty_bitmap,
-- 
2.26.2


