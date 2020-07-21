Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E58EC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 13:56:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A527204EA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 13:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TrfZwHmG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A527204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxsl9-0006xk-Gj
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 09:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jxsk1-0005Zs-RT
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 09:55:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37483
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jxsk0-0007dX-6B
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 09:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595339731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XiRcHwsEu67CK5FfrlnOPel9std7EgSdCj+MvoPyuhM=;
 b=TrfZwHmGf7vcOo5EnPXGx6jw8a1RXuNIczZNgkr3zSkV+kKlun38dVy9sVelm1nCYmwbOo
 ad4zzpNORJyi2xgXJN1Xr9bLyX2bwUQc114Fn/dQGXtCl6UStVhNhqNawquL9szxU1wMnX
 qgtsoJgddtBgHuTWx0JD8unng8fC5Zw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-llCgb1jxN_2y0iWKK8WU6g-1; Tue, 21 Jul 2020 09:55:29 -0400
X-MC-Unique: llCgb1jxN_2y0iWKK8WU6g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB580800688;
 Tue, 21 Jul 2020 13:55:28 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-97.ams2.redhat.com [10.36.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A238459;
 Tue, 21 Jul 2020 13:55:27 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.1 v2 2/2] iotests: Test sparseness for qemu-img convert
 -n
Date: Tue, 21 Jul 2020 15:55:20 +0200
Message-Id: <20200721135520.72355-3-kwolf@redhat.com>
In-Reply-To: <20200721135520.72355-1-kwolf@redhat.com>
References: <20200721135520.72355-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:46:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: kwolf@redhat.com, nsoffer@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/122     | 30 ++++++++++++++++++++++++++++++
 tests/qemu-iotests/122.out | 17 +++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
index dfd1cd05d6..0f3d4ca851 100755
--- a/tests/qemu-iotests/122
+++ b/tests/qemu-iotests/122
@@ -281,6 +281,36 @@ $QEMU_IMG convert -O $IMGFMT -n "$TEST_IMG" "$TEST_IMG".orig
 
 $QEMU_IMG compare "$TEST_IMG" "$TEST_IMG".orig
 
+echo
+echo '=== -n to an empty image ==='
+echo
+
+TEST_IMG="$TEST_IMG".orig _make_test_img 64M
+
+# Convert with -n, which should not result in a fully allocated image, not even
+# with compat=0.10 (because the target doesn't have a backing file)
+for compat in "1.1" "0.10"; do
+    IMGOPTS="compat=$compat" _make_test_img 64M
+    $QEMU_IMG convert -O $IMGFMT -n "$TEST_IMG".orig "$TEST_IMG"
+    $QEMU_IMG map --output=json "$TEST_IMG"
+done
+
+echo
+echo '=== -n to an empty image with a backing file ==='
+echo
+
+TEST_IMG="$TEST_IMG".orig _make_test_img 64M
+TEST_IMG="$TEST_IMG".base _make_test_img 64M
+
+# Convert with -n, which should still not result in a fully allocated image for
+# compat=1.1 (because it can use zero clusters), but it should be fully
+# allocated with compat=0.10
+for compat in "1.1" "0.10"; do
+    IMGOPTS="compat=$compat" _make_test_img -b "$TEST_IMG".base -F $IMGFMT 64M
+    $QEMU_IMG convert -O $IMGFMT -n "$TEST_IMG".orig "$TEST_IMG"
+    $QEMU_IMG map --output=json "$TEST_IMG"
+done
+
 echo
 echo '=== -n -B to an image without a backing file ==='
 echo
diff --git a/tests/qemu-iotests/122.out b/tests/qemu-iotests/122.out
index f1f195ed77..3a3e121d57 100644
--- a/tests/qemu-iotests/122.out
+++ b/tests/qemu-iotests/122.out
@@ -229,6 +229,23 @@ wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Images are identical.
 
+=== -n to an empty image ===
+
+Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=IMGFMT size=67108864
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+[{ "start": 0, "length": 67108864, "depth": 0, "zero": true, "data": false}]
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+[{ "start": 0, "length": 67108864, "depth": 0, "zero": true, "data": false}]
+
+=== -n to an empty image with a backing file ===
+
+Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=IMGFMT size=67108864
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+[{ "start": 0, "length": 67108864, "depth": 0, "zero": true, "data": false}]
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+[{ "start": 0, "length": 67108864, "depth": 0, "zero": false, "data": true, "offset": 327680}]
+
 === -n -B to an image without a backing file ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
-- 
2.25.4


