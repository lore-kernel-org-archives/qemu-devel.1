Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B652C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:33:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35AB62082F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tu9zr+OG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35AB62082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joTsV-0001mP-B7
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTi6-0005US-F1
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:22:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34546
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTi4-0000hC-SZ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593098560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Srr0ng/3UPLUq5FntmQzOQlZqCsCkFYTEO9BVUzzTW8=;
 b=Tu9zr+OG4Vu1Yc1VI39jTAX4drxsbzrXjdcbQIIu8IInoozSVXzLd4Zv8fWvRtqONRr/0z
 qRXdNUu+4+va30uR45cYAnK4a6M2R3S+4sG1E3ExD7y1odZC/2pAmkWLXj/FtwLFa6YjoB
 vnCxd+VkYLX9YBG66uCEssicR8YILZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-ppkSEOHANju3fH7UEPih1w-1; Thu, 25 Jun 2020 11:22:38 -0400
X-MC-Unique: ppkSEOHANju3fH7UEPih1w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1221D18A0731;
 Thu, 25 Jun 2020 15:22:37 +0000 (UTC)
Received: from localhost (ovpn-113-182.ams2.redhat.com [10.36.113.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7D7F2DE60;
 Thu, 25 Jun 2020 15:22:36 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 08/47] throttle: Support compressed writes
Date: Thu, 25 Jun 2020 17:21:36 +0200
Message-Id: <20200625152215.941773-9-mreitz@redhat.com>
In-Reply-To: <20200625152215.941773-1-mreitz@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 01:47:53
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

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/throttle.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/throttle.c b/block/throttle.c
index 0ebbad0743..f6e619aca2 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -154,6 +154,15 @@ static int coroutine_fn throttle_co_pdiscard(BlockDriverState *bs,
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
@@ -246,6 +255,7 @@ static BlockDriver bdrv_throttle = {
 
     .bdrv_co_pwrite_zeroes              =   throttle_co_pwrite_zeroes,
     .bdrv_co_pdiscard                   =   throttle_co_pdiscard,
+    .bdrv_co_pwritev_compressed         =   throttle_co_pwritev_compressed,
 
     .bdrv_attach_aio_context            =   throttle_attach_aio_context,
     .bdrv_detach_aio_context            =   throttle_detach_aio_context,
-- 
2.26.2


