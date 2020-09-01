Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4466C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:52:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AAF6206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwuOzSln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AAF6206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7eI-0000Vz-Gc
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kD7NP-000059-Sc
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:35:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37476
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kD7NO-00079P-4w
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598970909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rAhktimVFCszyYC4+nx01hoqbRzDBH/DRe69/BnxAq8=;
 b=TwuOzSlnD9vnRSAvBTIsYqquXagnUl79Z2qgnmc8pBaI+8e0+7Fr2bIlEK/vUpgCFXM5W8
 6Aiv6Rp4obaJAaY0aFLUTIVApbI+WVdGrYOaISC6lpRGAmHEwUMtfytIIOvXuc00+IXR9t
 2NAP9I4IUJYBCo3PnIyaorZaBpCVzDA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-p6QPn0_HMyaPysIKtIAT1g-1; Tue, 01 Sep 2020 10:35:08 -0400
X-MC-Unique: p6QPn0_HMyaPysIKtIAT1g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DC98801AB4;
 Tue,  1 Sep 2020 14:35:06 +0000 (UTC)
Received: from localhost (ovpn-113-83.ams2.redhat.com [10.36.113.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DEFE1002D59;
 Tue,  1 Sep 2020 14:35:06 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v8 17/43] vmdk: Drop vmdk_co_flush()
Date: Tue,  1 Sep 2020 16:33:58 +0200
Message-Id: <20200901143424.884735-18-mreitz@redhat.com>
In-Reply-To: <20200901143424.884735-1-mreitz@redhat.com>
References: <20200901143424.884735-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 00:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
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
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vmdk.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index bf9df5ce92..393365b5c2 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2806,21 +2806,6 @@ static void vmdk_close(BlockDriverState *bs)
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
@@ -3084,7 +3069,6 @@ static BlockDriver bdrv_vmdk = {
     .bdrv_close                   = vmdk_close,
     .bdrv_co_create_opts          = vmdk_co_create_opts,
     .bdrv_co_create               = vmdk_co_create,
-    .bdrv_co_flush_to_disk        = vmdk_co_flush,
     .bdrv_co_block_status         = vmdk_co_block_status,
     .bdrv_get_allocated_file_size = vmdk_get_allocated_file_size,
     .bdrv_has_zero_init           = vmdk_has_zero_init,
-- 
2.26.2


