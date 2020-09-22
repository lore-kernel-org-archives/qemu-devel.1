Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB8DC4727F
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:08:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF243208A9
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AOO/W5PV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF243208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKg9m-0003Ty-Qb
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 07:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kKfsZ-00011G-PO
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:50:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55458)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kKfsX-0000kq-5p
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600771832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dCRydtgaPvrptI+7Vg+MSDxHu+Qo9x3X8lvCx49A8Ww=;
 b=AOO/W5PViBNiEjovVhaIl/BwFWO+iOm5N2UGaWsYMn9P8Hge/FqhWWvgFzoQx8AJahYP14
 orwoa9XBe+Zgl/zXXV5uzEo/TGFtpDP4G6bOBraQAorUxwhHY3+1IUBy0HPrhS87gpF7b6
 fMdiVEwX4Qd5toW6yK1TyjEjdB4uhk8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-xxBw6ATPN6KtTXJOepAJNw-1; Tue, 22 Sep 2020 06:50:30 -0400
X-MC-Unique: xxBw6ATPN6KtTXJOepAJNw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A2E41007382;
 Tue, 22 Sep 2020 10:50:29 +0000 (UTC)
Received: from localhost (ovpn-114-26.ams2.redhat.com [10.36.114.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F8697881A;
 Tue, 22 Sep 2020 10:50:26 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 11/20] iotests: Derive image names from $TEST_IMG
Date: Tue, 22 Sep 2020 12:49:23 +0200
Message-Id: <20200922104932.46384-12-mreitz@redhat.com>
In-Reply-To: <20200922104932.46384-1-mreitz@redhat.com>
References: <20200922104932.46384-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avoid creating images with custom filenames in $TEST_DIR, because
non-file protocols may want to keep $TEST_IMG (and all other test
images) in some other directory.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/200     | 3 +--
 tests/qemu-iotests/200.out | 4 ++--
 tests/qemu-iotests/229     | 3 +--
 tests/qemu-iotests/229.out | 6 +++---
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/tests/qemu-iotests/200 b/tests/qemu-iotests/200
index 59f7854b9f..a7aabbd032 100755
--- a/tests/qemu-iotests/200
+++ b/tests/qemu-iotests/200
@@ -44,8 +44,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2 qed
 _supported_proto file
 
-BACKING_IMG="${TEST_DIR}/backing.img"
-TEST_IMG="${TEST_DIR}/test.img"
+BACKING_IMG="$TEST_IMG.base"
 
 TEST_IMG="$BACKING_IMG" _make_test_img 512M
 _make_test_img -F $IMGFMT -b "$BACKING_IMG" 512M
diff --git a/tests/qemu-iotests/200.out b/tests/qemu-iotests/200.out
index a6776070e4..5883f16ac3 100644
--- a/tests/qemu-iotests/200.out
+++ b/tests/qemu-iotests/200.out
@@ -1,6 +1,6 @@
 QA output created by 200
-Formatting 'TEST_DIR/backing.img', fmt=IMGFMT size=536870912
-Formatting 'TEST_DIR/test.img', fmt=IMGFMT size=536870912 backing_file=TEST_DIR/backing.img backing_fmt=IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=536870912
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=536870912 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 314572800/314572800 bytes at offset 512
 300 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
diff --git a/tests/qemu-iotests/229 b/tests/qemu-iotests/229
index 89a5359f32..5f759fa587 100755
--- a/tests/qemu-iotests/229
+++ b/tests/qemu-iotests/229
@@ -51,8 +51,7 @@ _supported_os Linux
 _unsupported_imgopts data_file
 
 
-DEST_IMG="$TEST_DIR/d.$IMGFMT"
-TEST_IMG="$TEST_DIR/b.$IMGFMT"
+DEST_IMG="$TEST_IMG.dest"
 BLKDEBUG_CONF="$TEST_DIR/blkdebug.conf"
 
 _make_test_img 2M
diff --git a/tests/qemu-iotests/229.out b/tests/qemu-iotests/229.out
index 4de6dfaa28..7eed393013 100644
--- a/tests/qemu-iotests/229.out
+++ b/tests/qemu-iotests/229.out
@@ -1,6 +1,6 @@
 QA output created by 229
-Formatting 'TEST_DIR/b.IMGFMT', fmt=IMGFMT size=2097152
-Formatting 'TEST_DIR/d.IMGFMT', fmt=IMGFMT size=2097152
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2097152
+Formatting 'TEST_DIR/t.IMGFMT.dest', fmt=IMGFMT size=2097152
 wrote 2097152/2097152 bytes at offset 0
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {'execute': 'qmp_capabilities'}
@@ -8,7 +8,7 @@ wrote 2097152/2097152 bytes at offset 0
 
 === Starting drive-mirror, causing error & stop  ===
 
-{'execute': 'drive-mirror', 'arguments': {'device': 'testdisk', 'format': 'IMGFMT', 'target': 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/d.IMGFMT', 'sync': 'full', 'mode': 'existing', 'on-source-error': 'stop', 'on-target-error': 'stop' }}
+{'execute': 'drive-mirror', 'arguments': {'device': 'testdisk', 'format': 'IMGFMT', 'target': 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFMT.dest', 'sync': 'full', 'mode': 'existing', 'on-source-error': 'stop', 'on-target-error': 'stop' }}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "testdisk"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "testdisk"}}
 {"return": {}}
-- 
2.26.2


