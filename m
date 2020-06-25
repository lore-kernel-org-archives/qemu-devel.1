Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B156BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:33:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D7FA2082F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EkZlaPE9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D7FA2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joTsg-0002AH-NJ
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTiG-0005cn-Hk
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:22:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57807
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTiD-0000kj-0r
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593098568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MqHimW4Fh8To193wjifBj5GjECNEmUokN+yiC3fNTyE=;
 b=EkZlaPE9c/q8q/ucSJ+eX/kYfjdBF7u5mBecSMrpFlSK3fdnUSL9Gw/OuhdtpxR94bUeph
 4+JjuG4XkHQcGWQflPmRz5tuOBjrZXTfDkPctbwVRNkzIOw9eJ0PwMO2RXkdm+5ybXXaX4
 EjORkKhvpsFU05dSzbltBzaXN6GJNgY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-R0OP0uE4OzyvVJrHVAm1fg-1; Thu, 25 Jun 2020 11:22:42 -0400
X-MC-Unique: R0OP0uE4OzyvVJrHVAm1fg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43F6B64AD9;
 Thu, 25 Jun 2020 15:22:41 +0000 (UTC)
Received: from localhost (ovpn-113-182.ams2.redhat.com [10.36.113.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE8EB1DC;
 Thu, 25 Jun 2020 15:22:40 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 10/47] mirror-top: Support compressed writes
Date: Thu, 25 Jun 2020 17:21:38 +0200
Message-Id: <20200625152215.941773-11-mreitz@redhat.com>
In-Reply-To: <20200625152215.941773-1-mreitz@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/mirror.c b/block/mirror.c
index e8e8844afc..469acf4600 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1480,6 +1480,15 @@ static int coroutine_fn bdrv_mirror_top_pdiscard(BlockDriverState *bs,
                                     NULL, 0);
 }
 
+static int coroutine_fn bdrv_mirror_top_pwritev_compressed(BlockDriverState *bs,
+                                                           uint64_t offset,
+                                                           uint64_t bytes,
+                                                           QEMUIOVector *qiov)
+{
+    return bdrv_mirror_top_pwritev(bs, offset, bytes, qiov,
+                                   BDRV_REQ_WRITE_COMPRESSED);
+}
+
 static void bdrv_mirror_top_refresh_filename(BlockDriverState *bs)
 {
     if (bs->backing == NULL) {
@@ -1526,6 +1535,7 @@ static BlockDriver bdrv_mirror_top = {
     .bdrv_co_pwritev            = bdrv_mirror_top_pwritev,
     .bdrv_co_pwrite_zeroes      = bdrv_mirror_top_pwrite_zeroes,
     .bdrv_co_pdiscard           = bdrv_mirror_top_pdiscard,
+    .bdrv_co_pwritev_compressed = bdrv_mirror_top_pwritev_compressed,
     .bdrv_co_flush              = bdrv_mirror_top_flush,
     .bdrv_co_block_status       = bdrv_co_block_status_from_backing,
     .bdrv_refresh_filename      = bdrv_mirror_top_refresh_filename,
-- 
2.26.2


