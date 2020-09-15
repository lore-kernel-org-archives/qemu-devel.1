Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4FFC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:53:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D78D206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MNYND29Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D78D206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI8a7-0000qp-6w
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 06:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8UN-0000rO-94
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:47:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54755
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8UL-0004ck-0u
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600166824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HQvHNhVhnCk7Lx3ZLs/jlIsfMx16dmhaV5cJAS4ylNw=;
 b=MNYND29QqbM17ybdki8CkkYs/i/RIQY5t5pQ9I0QAnI6XRsYG1RlBaU6FOR/C22+stBxkF
 vJL5Hv3ARZVBsdL6EZrJTbdyjDEVGwfble0iZnWghsHRXiwZgem6UY6wMHwTH807NYs4fW
 2IJ4vXl/j8DzYlskBvJn3SJBRvP63VM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-DFUVZkRpNmGP84x8iMZy9A-1; Tue, 15 Sep 2020 06:47:02 -0400
X-MC-Unique: DFUVZkRpNmGP84x8iMZy9A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA0381084D62;
 Tue, 15 Sep 2020 10:47:00 +0000 (UTC)
Received: from localhost (ovpn-113-7.ams2.redhat.com [10.36.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CD2160BE2;
 Tue, 15 Sep 2020 10:47:00 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 14/22] block/vhdx: Support vhdx image only with 512 bytes
 logical sector size
Date: Tue, 15 Sep 2020 12:46:19 +0200
Message-Id: <20200915104627.699552-15-mreitz@redhat.com>
In-Reply-To: <20200915104627.699552-1-mreitz@redhat.com>
References: <20200915104627.699552-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 05:35:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Swapnil Ingle <swapnil.ingle@nutanix.com>

block/vhdx uses qemu block layer where sector size is always 512 bytes.
This may have issues  with 4K logical sector sized vhdx image.

For e.g qemu-img convert on such images fails with following assert:

$qemu-img convert -f vhdx -O raw 4KTest1.vhdx test.raw
qemu-img: util/iov.c:388: qiov_slice: Assertion `offset + len <=
qiov->size' failed.
Aborted

This patch adds an check to return ENOTSUP for vhdx images which
have logical sector size other than 512 bytes.

Signed-off-by: Swapnil Ingle <swapnil.ingle@nutanix.com>
Message-Id: <1596794594-44531-1-git-send-email-swapnil.ingle@nutanix.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/vhdx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/vhdx.c b/block/vhdx.c
index 791eb90263..356ec4c455 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -816,9 +816,9 @@ static int vhdx_parse_metadata(BlockDriverState *bs, BDRVVHDXState *s)
         goto exit;
     }
 
-    /* only 2 supported sector sizes */
-    if (s->logical_sector_size != 512 && s->logical_sector_size != 4096) {
-        ret = -EINVAL;
+    /* Currently we only support 512 */
+    if (s->logical_sector_size != 512) {
+        ret = -ENOTSUP;
         goto exit;
     }
 
-- 
2.26.2


