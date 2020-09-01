Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E4CC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:47:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8877321D6C
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7ZjDXRZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8877321D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7Zl-0007PG-JT
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kD7N4-0007XQ-QC
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:34:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59081
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kD7N3-00075r-8C
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598970888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uGT2H1B3v+YCtkqRJAcAHLz8etTo3786vvW9axkTkRM=;
 b=I7ZjDXRZAbvlDU8kGsW7cigK/IhwaeqprbMuKhQZjsN+2lhCNHUpfWB43yb0IGNtz3zvLu
 j5XxKERmtDksN2tU1UjW8NQmQ73mEJkxklwRwzm4CntZsczrl+MxVReDd17lbJXpefU52I
 w3Xn069nNH+ns3R/7UCTaM2mZYEvMH4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-alENj0z_N2a5boLPfIVE0g-1; Tue, 01 Sep 2020 10:34:46 -0400
X-MC-Unique: alENj0z_N2a5boLPfIVE0g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28EF664084;
 Tue,  1 Sep 2020 14:34:45 +0000 (UTC)
Received: from localhost (ovpn-113-83.ams2.redhat.com [10.36.113.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C46137EB87;
 Tue,  1 Sep 2020 14:34:44 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v8 08/43] throttle: Support compressed writes
Date: Tue,  1 Sep 2020 16:33:49 +0200
Message-Id: <20200901143424.884735-9-mreitz@redhat.com>
In-Reply-To: <20200901143424.884735-1-mreitz@redhat.com>
References: <20200901143424.884735-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block/throttle.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/throttle.c b/block/throttle.c
index 1c1ac57bee..b21ee42d98 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -151,6 +151,15 @@ static int coroutine_fn throttle_co_pdiscard(BlockDriverState *bs,
     return bdrv_co_pdiscard(bs->file, offset, bytes);
 }
 
+static int coroutine_fn throttle_co_pwritev_compressed(BlockDriverState *bs,
+                                                       uint64_t offset,
+                                                       uint64_t bytes,
+                                                       QEMUIOVector *qiov)
+{
+    return throttle_co_pwritev(bs, offset, bytes, qiov,
+                               BDRV_REQ_WRITE_COMPRESSED);
+}
+
 static int throttle_co_flush(BlockDriverState *bs)
 {
     return bdrv_co_flush(bs->file->bs);
@@ -243,6 +252,7 @@ static BlockDriver bdrv_throttle = {
 
     .bdrv_co_pwrite_zeroes              =   throttle_co_pwrite_zeroes,
     .bdrv_co_pdiscard                   =   throttle_co_pdiscard,
+    .bdrv_co_pwritev_compressed         =   throttle_co_pwritev_compressed,
 
     .bdrv_attach_aio_context            =   throttle_attach_aio_context,
     .bdrv_detach_aio_context            =   throttle_detach_aio_context,
-- 
2.26.2


