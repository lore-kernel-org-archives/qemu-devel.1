Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C28C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:50:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DB3B20739
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bR4mqtZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB3B20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlVdm-00006x-F6
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 06:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jlVcP-0006KE-Jw
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:48:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31002
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jlVcN-0002s4-P4
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592390911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3c3MEF0HSfORbgwGCKGVKJhRQmvedBIl39vI3C3f5oM=;
 b=bR4mqtZW6FDKNFTf21fY99mVEEE+CEjutHrkqThL8GFF1GANvnT98pCRzMjCDWZqb4ijqp
 c8zr8QdoRPE51bsKSyjMJ8rznTqE97pIPuCgazphLFJPRxjrO6larQY6iRgF8r4qkIyMVy
 KsCHnvXqIMKkMjB8MNG4HsGNzteq2qA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-VlAC-e75O2-gdt3HtM98hw-1; Wed, 17 Jun 2020 06:48:29 -0400
X-MC-Unique: VlAC-e75O2-gdt3HtM98hw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86C0480F5D8;
 Wed, 17 Jun 2020 10:48:28 +0000 (UTC)
Received: from localhost (ovpn-113-111.ams2.redhat.com [10.36.113.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B0E85C1C3;
 Wed, 17 Jun 2020 10:48:28 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/5] iotests/041: Skip test_small_target for qed
Date: Wed, 17 Jun 2020 12:48:19 +0200
Message-Id: <20200617104822.27525-3-mreitz@redhat.com>
In-Reply-To: <20200617104822.27525-1-mreitz@redhat.com>
References: <20200617104822.27525-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qed does not support shrinking images, so the test_small_target method
should be skipped to keep 041 passing.

Fixes: 16cea4ee1c8e5a69a058e76f426b2e17974d8d7d
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/041 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 601c756117..b843f88a66 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -277,6 +277,8 @@ class TestSingleBlockdev(TestSingleDrive):
         result = self.vm.run_job('job0')
         self.assertEqual(result, 'Source and target image have different sizes')
 
+    # qed does not support shrinking
+    @iotests.skip_for_formats(('qed'))
     def test_small_target(self):
         self.do_test_target_size(self.image_len // 2)
 
-- 
2.26.2


