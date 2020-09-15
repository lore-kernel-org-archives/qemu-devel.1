Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C569C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:58:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6C91206DC
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aai7d3Ft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C91206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI8fC-0000l5-Op
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 06:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8UL-0000nS-My
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:47:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8UI-0004cH-Ke
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600166821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MBds4CXxGE46H6Itn3fmDY2ijfb8SIWiB0usBs4CUhE=;
 b=Aai7d3FtzmUSN4MWMZjFRJnQcUZO8BJaGIKo9FjwcfSsyvSa9fm0wq966cWReps32xjP/2
 QY50A0uFnjc3FRILI2KSipBeHLDGbfRIgkaSlJ0PG7RjX20CNIN3W05E/60f3sTR/BY2DM
 uB1JE00jjwhDSfaPWA+BTteTik7dUYE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-NbXYX8woNGmUD7-8WhxZkw-1; Tue, 15 Sep 2020 06:46:59 -0400
X-MC-Unique: NbXYX8woNGmUD7-8WhxZkw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1AF264089;
 Tue, 15 Sep 2020 10:46:58 +0000 (UTC)
Received: from localhost (ovpn-113-7.ams2.redhat.com [10.36.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5136A7B7B7;
 Tue, 15 Sep 2020 10:46:58 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 13/22] iotests: Skip test_stream_parallel in test 030 when
 doing "make check"
Date: Tue, 15 Sep 2020 12:46:18 +0200
Message-Id: <20200915104627.699552-14-mreitz@redhat.com>
In-Reply-To: <20200915104627.699552-1-mreitz@redhat.com>
References: <20200915104627.699552-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:23:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The test_stream_parallel test still occasionally fails in the CI.
Thus let's disable it during "make check" for now so that it does
not cause trouble during merge tests. We can enable it again once
the problem has been resolved.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200907113824.134788-1-thuth@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/check-block.sh   | 3 +++
 tests/qemu-iotests/030 | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/tests/check-block.sh b/tests/check-block.sh
index 8e29c868e5..a5a69060e1 100755
--- a/tests/check-block.sh
+++ b/tests/check-block.sh
@@ -55,6 +55,9 @@ fi
 
 cd tests/qemu-iotests
 
+# QEMU_CHECK_BLOCK_AUTO is used to disable some unstable sub-tests
+export QEMU_CHECK_BLOCK_AUTO=1
+
 ret=0
 for fmt in $format_list ; do
     ./check -makecheck -$fmt $group || ret=1
diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 31c028306b..dcb4b5d6a6 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -21,6 +21,7 @@
 import time
 import os
 import iotests
+import unittest
 from iotests import qemu_img, qemu_io
 
 backing_img = os.path.join(iotests.test_dir, 'backing.img')
@@ -228,6 +229,7 @@ class TestParallelOps(iotests.QMPTestCase):
 
     # Test that it's possible to run several block-stream operations
     # in parallel in the same snapshot chain
+    @unittest.skipIf(os.environ.get('QEMU_CHECK_BLOCK_AUTO'), 'disabled in CI')
     def test_stream_parallel(self):
         self.assert_no_active_block_jobs()
 
-- 
2.26.2


