Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9949AC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:49:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 332D620C09
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="io1ivUAS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 332D620C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFFeY-0003vB-Ax
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 07:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFFTu-0004HX-6w
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:38:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26768
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFFTr-00032z-Kh
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599478717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=P4cEEx4rjXIgUPkJOLxDxjtVqF7/DjyIplVtYf6IDXQ=;
 b=io1ivUASWecPJkH8Uhwd13yvMN75looS2kviPBAhOX9bxdrCSnNSYLZavJsYkkB288HAqE
 Af/BA76o7R5I5Py7BV3CV+fK2NMEeWMQjKpX0b05Xosd4rDW9yQP7s8K5qWq12q8FjyQh5
 H83iT3YaqsqWyjd/+joJv6GVkB/m3Uo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-3CXf8WJgOquHrokofKZD_Q-1; Mon, 07 Sep 2020 07:38:28 -0400
X-MC-Unique: 3CXf8WJgOquHrokofKZD_Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD686802B49;
 Mon,  7 Sep 2020 11:38:27 +0000 (UTC)
Received: from thuth.com (ovpn-112-193.ams2.redhat.com [10.36.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A0BB227CB7;
 Mon,  7 Sep 2020 11:38:26 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2] iotests: Skip test_stream_parallel in test 030 when doing
 "make check"
Date: Mon,  7 Sep 2020 13:38:24 +0200
Message-Id: <20200907113824.134788-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:05:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The test_stream_parallel test still occasionally fails in the CI.
Thus let's disable it during "make check" for now so that it does
not cause trouble during merge tests. We can enable it again once
the problem has been resolved.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Use @unittest.skipIf() decorator

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
2.18.2


