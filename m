Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EA4C43461
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 11:25:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF87A206CA
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 11:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HR8IXTUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF87A206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEWKA-0003w8-M4
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 07:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kEWJV-0003DC-Ft
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 07:24:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52231
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kEWJS-0000Kk-VV
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 07:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599305093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=YoasaRoAW7Kuq6/XSm2snSPr+QoTJYt1Z+83f2jrctw=;
 b=HR8IXTUDk8m12SRxMwdy3CjVbONonqM96ZGEGTK5sxLiAl0zplBNWDtU90pO/dp4LWiNe3
 Vd/apB8vduMHh1wKvATOQLqxJGGw0bO8Qn3kCz7beAb20MfV9/HN9Pt0ocXdWehjl4KuYL
 Yz+qmUSBCF9GcHfMoWFuyDqQH7DNui4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-amoLHULAM5qprqwGY3e33g-1; Sat, 05 Sep 2020 07:24:50 -0400
X-MC-Unique: amoLHULAM5qprqwGY3e33g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 615DB1DDEA;
 Sat,  5 Sep 2020 11:24:49 +0000 (UTC)
Received: from thuth.com (ovpn-112-27.ams2.redhat.com [10.36.112.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 13BD3614F6;
 Sat,  5 Sep 2020 11:24:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH] iotests: Skip test_stream_parallel in test 030 when doing
 "make check"
Date: Sat,  5 Sep 2020 13:24:45 +0200
Message-Id: <20200905112445.718881-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/05 07:24:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The test_stream_parallel test still occasionally fails in the CI.
Thus let's disable it during "make check" for now so that it does
not cause trouble during merge tests. We can enable it again once
the problem has been resolved.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 See e.g. these URLs for the failure:
  https://cirrus-ci.com/task/5449330930745344?command=main#L6482
  https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00136.html

 tests/check-block.sh   | 3 +++
 tests/qemu-iotests/030 | 4 ++++
 2 files changed, 7 insertions(+)

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
index 31c028306b..8c3af2f658 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -231,6 +231,10 @@ class TestParallelOps(iotests.QMPTestCase):
     def test_stream_parallel(self):
         self.assert_no_active_block_jobs()
 
+        # The test occasionally failed in the CI, so disable it for "make check":
+        if os.environ.get('QEMU_CHECK_BLOCK_AUTO'):
+            return
+
         # Check that the maps don't match before the streaming operations
         for i in range(2, self.num_imgs, 2):
             self.assertNotEqual(qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'map', self.imgs[i]),
-- 
2.18.2


