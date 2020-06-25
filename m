Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD81DC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B08D207D8
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="REEk348E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B08D207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joTuV-0005iQ-Pv
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTiU-0005nV-Fd
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:23:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47476
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTiS-0000zQ-MM
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593098584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rlozvh1JefoYwHhG98f7k+4WjYRuc6ZDe5vc/mVckIQ=;
 b=REEk348EZ65plUlW6n3ZXXCiFhEaoJ/c1Zk1z+aTtPCY/2BSlXRc93e966QKUNcW9W7ize
 mO9d3o43PsoxBWsP9ae3qRj9+7R4jcc+3eHwqLb/UL9fJxud6LlEEps+bWozqDFNo9WUvp
 uKurTclkfn4rQKedgeU0LF2iNv7PHHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-ZQbqtHwVOsqeR4XIABQghg-1; Thu, 25 Jun 2020 11:23:02 -0400
X-MC-Unique: ZQbqtHwVOsqeR4XIABQghg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C3B7800C60;
 Thu, 25 Jun 2020 15:23:01 +0000 (UTC)
Received: from localhost (ovpn-113-182.ams2.redhat.com [10.36.113.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A78365DAA0;
 Thu, 25 Jun 2020 15:23:00 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 19/47] vmdk: Drop vmdk_co_flush()
Date: Thu, 25 Jun 2020 17:21:47 +0200
Message-Id: <20200625152215.941773-20-mreitz@redhat.com>
In-Reply-To: <20200625152215.941773-1-mreitz@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
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

Before HEAD^, we needed this because bdrv_co_flush() by itself would
only flush bs->file.  With HEAD^, bdrv_co_flush() will flush all
children on which a WRITE or WRITE_UNCHANGED permission has been taken.
Thus, vmdk no longer needs to do it itself.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/vmdk.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 62da465126..a23890e6ec 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2802,21 +2802,6 @@ static void vmdk_close(BlockDriverState *bs)
     error_free(s->migration_blocker);
 }
 
-static coroutine_fn int vmdk_co_flush(BlockDriverState *bs)
-{
-    BDRVVmdkState *s = bs->opaque;
-    int i, err;
-    int ret = 0;
-
-    for (i = 0; i < s->num_extents; i++) {
-        err = bdrv_co_flush(s->extents[i].file->bs);
-        if (err < 0) {
-            ret = err;
-        }
-    }
-    return ret;
-}
-
 static int64_t vmdk_get_allocated_file_size(BlockDriverState *bs)
 {
     int i;
@@ -3075,7 +3060,6 @@ static BlockDriver bdrv_vmdk = {
     .bdrv_close                   = vmdk_close,
     .bdrv_co_create_opts          = vmdk_co_create_opts,
     .bdrv_co_create               = vmdk_co_create,
-    .bdrv_co_flush_to_disk        = vmdk_co_flush,
     .bdrv_co_block_status         = vmdk_co_block_status,
     .bdrv_get_allocated_file_size = vmdk_get_allocated_file_size,
     .bdrv_has_zero_init           = vmdk_has_zero_init,
-- 
2.26.2


