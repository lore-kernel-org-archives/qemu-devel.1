Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95752C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:49:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 601CD20771
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFky4Paq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601CD20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxuWC-0006UO-HE
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 11:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jxuTs-0004Wa-Nf
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 11:47:01 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40970
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jxuTn-0001Kc-H9
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 11:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595346414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tpMqYVwIHNV1hPTu7PzOkMnfmYQAMnojlVwxNhz4Fcs=;
 b=YFky4Paq5puwTtZvFUep2Cz3I8uJ8nPx8ae3QhBmovSi+EtWrxI30H7yD7UtJiPG/yhfQG
 H9Db7lIHHLMvZUiLrG5FsDOfz8jze/kcelvNFiua4DwodEZkhxt41YXIoE19vzLKcfHro6
 f8bAeJKCHdKTCGt1nRVnQO5I+rYc0Z4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-aPONNmW1NkCID-OsFsgvwg-1; Tue, 21 Jul 2020 11:46:52 -0400
X-MC-Unique: aPONNmW1NkCID-OsFsgvwg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E56191272;
 Tue, 21 Jul 2020 15:46:51 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-97.ams2.redhat.com [10.36.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3CD8374F45;
 Tue, 21 Jul 2020 15:46:50 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 3/3] iotests: Test sparseness for qemu-img convert -n
Date: Tue, 21 Jul 2020 17:46:37 +0200
Message-Id: <20200721154637.220022-4-kwolf@redhat.com>
In-Reply-To: <20200721154637.220022-1-kwolf@redhat.com>
References: <20200721154637.220022-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 10:17:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200721135520.72355-3-kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
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


