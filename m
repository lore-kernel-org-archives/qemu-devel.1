Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FD8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:27:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05B6F2089D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M60m5VkU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B6F2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joTmz-0002yb-7O
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTi0-0005FI-2U
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:22:36 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41442
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joThy-0000Z5-Di
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593098553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mDZYcGkrIBwQAlRDjG/1NZpJAK8n1D5wtER9Jcis1fE=;
 b=M60m5VkUlvJcEqgXo/2ofZ2b2nTOxLQqEJwulW6AvQ7ZzgJ8GEX7b2UBm0AHIQCZs1xg+m
 +dvkNxI+xmRkO9aX+B/2D9El/vhlXhg4fFhh5ZYbPtdpp5MaxOxxghwuJfC6i5UYS26Mjp
 yoFe0mJWalco4EfXfeHtSZRUj+bDBjg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-dICCJNrEPBmnCVunF66OFQ-1; Thu, 25 Jun 2020 11:22:31 -0400
X-MC-Unique: dICCJNrEPBmnCVunF66OFQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A99828015F8;
 Thu, 25 Jun 2020 15:22:30 +0000 (UTC)
Received: from localhost (ovpn-113-182.ams2.redhat.com [10.36.113.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CB1E17DCE;
 Thu, 25 Jun 2020 15:22:30 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 06/47] block: Drop bdrv_is_encrypted()
Date: Thu, 25 Jun 2020 17:21:34 +0200
Message-Id: <20200625152215.941773-7-mreitz@redhat.com>
In-Reply-To: <20200625152215.941773-1-mreitz@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The original purpose of bdrv_is_encrypted() was to inquire whether a BDS
can be used without the user entering a password or not.  It has not
been used for that purpose for quite some time.

Actually, it is not even fit for that purpose, because to answer that
question, it would have recursively query all of the given node's
children.

So now we have to decide in which direction we want to fix
bdrv_is_encrypted(): Recursively query all children, or drop it and just
use bs->encrypted to get the current node's status?

Nowadays, its only purpose is to report through bdrv_query_image_info()
whether the given image is encrypted or not.  For this purpose, it is
probably more interesting to see whether a given node itself is
encrypted or not (otherwise, a management application cannot discern for
certain which nodes are really encrypted and which just have encrypted
children).

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h | 1 -
 block.c               | 8 --------
 block/qapi.c          | 2 +-
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 86f9728f00..0080fe1311 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -538,7 +538,6 @@ BlockDriverState *bdrv_next(BdrvNextIterator *it);
 void bdrv_next_cleanup(BdrvNextIterator *it);
 
 BlockDriverState *bdrv_next_monitor_owned(BlockDriverState *bs);
-bool bdrv_is_encrypted(BlockDriverState *bs);
 void bdrv_iterate_format(void (*it)(void *opaque, const char *name),
                          void *opaque, bool read_only);
 const char *bdrv_get_node_name(const BlockDriverState *bs);
diff --git a/block.c b/block.c
index b59bd776cd..76277ea4e0 100644
--- a/block.c
+++ b/block.c
@@ -5044,14 +5044,6 @@ bool bdrv_is_sg(BlockDriverState *bs)
     return bs->sg;
 }
 
-bool bdrv_is_encrypted(BlockDriverState *bs)
-{
-    if (bs->backing && bs->backing->bs->encrypted) {
-        return true;
-    }
-    return bs->encrypted;
-}
-
 const char *bdrv_get_format_name(BlockDriverState *bs)
 {
     return bs->drv ? bs->drv->format_name : NULL;
diff --git a/block/qapi.c b/block/qapi.c
index afd9f3b4a7..4807a2b344 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -288,7 +288,7 @@ void bdrv_query_image_info(BlockDriverState *bs,
     info->virtual_size    = size;
     info->actual_size     = bdrv_get_allocated_file_size(bs);
     info->has_actual_size = info->actual_size >= 0;
-    if (bdrv_is_encrypted(bs)) {
+    if (bs->encrypted) {
         info->encrypted = true;
         info->has_encrypted = true;
     }
-- 
2.26.2


