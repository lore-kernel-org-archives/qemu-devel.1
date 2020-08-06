Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934A6C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 21:16:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6855C20855
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 21:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXWw8PfZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6855C20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3nFu-0003Wb-Hk
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 17:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1k3nE8-00026v-HI
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 17:15:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47008
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1k3nE7-00052F-0r
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 17:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596748502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P97p5DO2IFA43H25ddSY/klC8xQ1zHEY2cJ7gCKtwmA=;
 b=eXWw8PfZ8mQsAthe/z5qo4r2/ih4ajheywTVMmZdfQcijHGzi7HzT2dxmRlGnUQR14TyGu
 i0niy/xI9XXkvSg0Sd64UUgyYppQRJbfLLXnuDcwo8jmdO8x/63V11XE2cAovrhnNpXylO
 r0L1uyZVcvXau1AKzOKyMLY92vg4+s0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-44TPaOS8Pmu3EACBmPlhSg-1; Thu, 06 Aug 2020 17:13:55 -0400
X-MC-Unique: 44TPaOS8Pmu3EACBmPlhSg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 236101902EA0;
 Thu,  6 Aug 2020 21:13:54 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com
 (ovpn-117-179.rdu2.redhat.com [10.10.117.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8D0979CE3;
 Thu,  6 Aug 2020 21:13:52 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] block/qcow: remove runtime opts
Date: Thu,  6 Aug 2020 17:13:45 -0400
Message-Id: <20200806211345.2925343-3-jsnow@redhat.com>
In-Reply-To: <20200806211345.2925343-1-jsnow@redhat.com>
References: <20200806211345.2925343-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 03:10:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Jason Dillaman <dillaman@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduced by d85f4222b468,
These were seemingly never used at all.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qcow.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/block/qcow.c b/block/qcow.c
index e514a86fe5e..f8919a44d19 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -105,15 +105,6 @@ static int qcow_probe(const uint8_t *buf, int buf_size, const char *filename)
         return 0;
 }
 
-static QemuOptsList qcow_runtime_opts = {
-    .name = "qcow",
-    .head = QTAILQ_HEAD_INITIALIZER(qcow_runtime_opts.head),
-    .desc = {
-        BLOCK_CRYPTO_OPT_DEF_QCOW_KEY_SECRET("encrypt."),
-        { /* end of list */ }
-    },
-};
-
 static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
                      Error **errp)
 {
-- 
2.26.2


