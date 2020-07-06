Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E5DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:16:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A21B22075B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQzgYuH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21B22075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsOAp-00082C-QC
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 06:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jsO0G-0004Cv-9C
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:05:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22906
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jsO0D-0004BC-IT
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594029932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dBcMJ46Jn3ReNscVGlgV/9oO1tSfI2BymR9OJQzxv04=;
 b=CQzgYuH7tM28x1WZN4tHRtlUD0PnkchBftuH4f3pdf20SS9ku5MLQnJA+RxRuCy9Eh9Fm1
 2IdzbnKLtEq5IgGuxrCKWR4zd4j9L3dWWEmW7lwxiV9itkKUiIJOlLj5Xdjor+aWGJjHDK
 go/P0zYJrRqYoB7sDt3+zpoK/MyZZtk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-Ikn9zxpsPau0sKu8jMvKwg-1; Mon, 06 Jul 2020 06:05:30 -0400
X-MC-Unique: Ikn9zxpsPau0sKu8jMvKwg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44EBFA0BD7;
 Mon,  6 Jul 2020 10:05:29 +0000 (UTC)
Received: from localhost (ovpn-112-176.ams2.redhat.com [10.36.112.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E022A5DD61;
 Mon,  6 Jul 2020 10:05:28 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 23/31] block: inline bdrv_unallocated_blocks_are_zero()
Date: Mon,  6 Jul 2020 12:04:24 +0200
Message-Id: <20200706100432.2301919-24-mreitz@redhat.com>
In-Reply-To: <20200706100432.2301919-1-mreitz@redhat.com>
References: <20200706100432.2301919-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:59:39
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

The function has only one user: bdrv_co_block_status(). Inline it to
simplify reviewing of the following patches, which will finally drop
unallocated_blocks_are_zero field too.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200528094405.145708-3-vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h |  1 -
 block.c               | 15 ---------------
 block/io.c            | 11 ++++++++---
 3 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index a2414a58c5..e7934e07f2 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -489,7 +489,6 @@ int bdrv_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
 int bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
 int bdrv_has_zero_init_1(BlockDriverState *bs);
 int bdrv_has_zero_init(BlockDriverState *bs);
-bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs);
 bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs);
 int bdrv_block_status(BlockDriverState *bs, int64_t offset,
                       int64_t bytes, int64_t *pnum, int64_t *map,
diff --git a/block.c b/block.c
index 144f52e413..62e40db2f1 100644
--- a/block.c
+++ b/block.c
@@ -5408,21 +5408,6 @@ int bdrv_has_zero_init(BlockDriverState *bs)
     return 0;
 }
 
-bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs)
-{
-    BlockDriverInfo bdi;
-
-    if (bs->backing) {
-        return false;
-    }
-
-    if (bdrv_get_info(bs, &bdi) == 0) {
-        return bdi.unallocated_blocks_are_zero;
-    }
-
-    return false;
-}
-
 bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs)
 {
     if (!(bs->open_flags & BDRV_O_UNMAP)) {
diff --git a/block/io.c b/block/io.c
index df8f2a98d4..36d4d562a6 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2407,15 +2407,20 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
     if (ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO)) {
         ret |= BDRV_BLOCK_ALLOCATED;
     } else if (want_zero) {
-        if (bdrv_unallocated_blocks_are_zero(bs)) {
-            ret |= BDRV_BLOCK_ZERO;
-        } else if (bs->backing) {
+        if (bs->backing) {
             BlockDriverState *bs2 = bs->backing->bs;
             int64_t size2 = bdrv_getlength(bs2);
 
             if (size2 >= 0 && offset >= size2) {
                 ret |= BDRV_BLOCK_ZERO;
             }
+        } else {
+            BlockDriverInfo bdi;
+            int ret2 = bdrv_get_info(bs, &bdi);
+
+            if (ret2 == 0 && bdi.unallocated_blocks_are_zero) {
+                ret |= BDRV_BLOCK_ZERO;
+            }
         }
     }
 
-- 
2.26.2


