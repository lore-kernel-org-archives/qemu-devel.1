Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92F7C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:11:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57C7820756
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQwaqiSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C7820756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXUNW-0006W5-8d
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 15:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kXUJ0-00011a-VM
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 15:06:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29287)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kXUIx-0001LD-Vf
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 15:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603825604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jDZKuHJydRomkoAVOtpqPDOUGms0k0orhFkWgGOE37E=;
 b=MQwaqiSPXb9eI5Jn4bOKmq/nzuR+xVAgS4ZLBH03oiPH4G+GTo7CeHG3UHkAc1sIKwxzdL
 hfsjt50sp/EZt+OyBZIuEb6svf8TKa4cMmbmziVqpWflBTEkYtUseK+ON/hQvnIHrmsLxL
 ysWuhwnEV14201iP0Yrp3hLlkrZByxw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-C53poKY7Oje6jpYKUxFgoA-1; Tue, 27 Oct 2020 15:06:42 -0400
X-MC-Unique: C53poKY7Oje6jpYKUxFgoA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A644A809DDA;
 Tue, 27 Oct 2020 19:06:41 +0000 (UTC)
Received: from localhost (unknown [10.40.193.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1859710016DA;
 Tue, 27 Oct 2020 19:06:37 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-6.0 v3 07/20] iotests: Do not needlessly filter
 _make_test_img
Date: Tue, 27 Oct 2020 20:05:47 +0100
Message-Id: <20201027190600.192171-8-mreitz@redhat.com>
In-Reply-To: <20201027190600.192171-1-mreitz@redhat.com>
References: <20201027190600.192171-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In most cases, _make_test_img does not need a _filter_imgfmt on top.  It
does that by itself.

(The exception is when IMGFMT has been overwritten but TEST_IMG has not.
In such cases, we do need a _filter_imgfmt on top to filter the test's
original IMGFMT from TEST_IMG.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/161 | 12 ++++++------
 tests/qemu-iotests/175 |  6 +++---
 tests/qemu-iotests/249 |  6 +++---
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tests/qemu-iotests/161 b/tests/qemu-iotests/161
index e270976d87..bbf7dbbc5c 100755
--- a/tests/qemu-iotests/161
+++ b/tests/qemu-iotests/161
@@ -48,9 +48,9 @@ _supported_os Linux
 IMG_SIZE=1M
 
 # Create the images
-TEST_IMG="$TEST_IMG.base" _make_test_img $IMG_SIZE | _filter_imgfmt
-TEST_IMG="$TEST_IMG.int" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT | _filter_imgfmt
-_make_test_img -b "$TEST_IMG.int" -F $IMGFMT -F $IMGFMT | _filter_imgfmt
+TEST_IMG="$TEST_IMG.base" _make_test_img $IMG_SIZE
+TEST_IMG="$TEST_IMG.int" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT
+_make_test_img -b "$TEST_IMG.int" -F $IMGFMT -F $IMGFMT
 
 # First test: reopen $TEST.IMG changing the detect-zeroes option on
 # its backing file ($TEST_IMG.int).
@@ -105,9 +105,9 @@ echo
 echo "*** Commit and then change an option on the backing file"
 echo
 # Create the images again
-TEST_IMG="$TEST_IMG.base" _make_test_img $IMG_SIZE | _filter_imgfmt
-TEST_IMG="$TEST_IMG.int" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT| _filter_imgfmt
-_make_test_img -b "$TEST_IMG.int" -F $IMGFMT | _filter_imgfmt
+TEST_IMG="$TEST_IMG.base" _make_test_img $IMG_SIZE
+TEST_IMG="$TEST_IMG.int" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT
+_make_test_img -b "$TEST_IMG.int" -F $IMGFMT
 
 _launch_qemu -drive if=none,file="${TEST_IMG}"
 _send_qemu_cmd $QEMU_HANDLE \
diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
index 00a626aa63..c3c2aed653 100755
--- a/tests/qemu-iotests/175
+++ b/tests/qemu-iotests/175
@@ -89,20 +89,20 @@ min_blocks=$(stat -c '%b' "$TEST_DIR/empty")
 
 echo
 echo "== creating image with default preallocation =="
-_make_test_img -o extent_size_hint=0 $size | _filter_imgfmt
+_make_test_img -o extent_size_hint=0 $size
 stat -c "size=%s, blocks=%b" $TEST_IMG | _filter_blocks $extra_blocks $min_blocks $size
 
 for mode in off full falloc; do
     echo
     echo "== creating image with preallocation $mode =="
-    _make_test_img -o preallocation=$mode,extent_size_hint=0 $size | _filter_imgfmt
+    _make_test_img -o preallocation=$mode,extent_size_hint=0 $size
     stat -c "size=%s, blocks=%b" $TEST_IMG | _filter_blocks $extra_blocks $min_blocks $size
 done
 
 for new_size in 4096 1048576; do
     echo
     echo "== resize empty image with block_resize =="
-    _make_test_img -o extent_size_hint=0 0 | _filter_imgfmt
+    _make_test_img -o extent_size_hint=0 0
     _block_resize $TEST_IMG $new_size >/dev/null
     stat -c "size=%s, blocks=%b" $TEST_IMG | _filter_blocks $extra_blocks $min_blocks $new_size
 done
diff --git a/tests/qemu-iotests/249 b/tests/qemu-iotests/249
index 68f13ed328..a9aa9303eb 100755
--- a/tests/qemu-iotests/249
+++ b/tests/qemu-iotests/249
@@ -48,9 +48,9 @@ _supported_os Linux
 IMG_SIZE=1M
 
 # Create the images: base <- int <- active
-TEST_IMG="$TEST_IMG.base" _make_test_img $IMG_SIZE | _filter_imgfmt
-TEST_IMG="$TEST_IMG.int" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT | _filter_imgfmt
-_make_test_img -b "$TEST_IMG.int" -F $IMGFMT | _filter_imgfmt
+TEST_IMG="$TEST_IMG.base" _make_test_img $IMG_SIZE
+TEST_IMG="$TEST_IMG.int" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT
+_make_test_img -b "$TEST_IMG.int" -F $IMGFMT
 
 # Launch QEMU with these two drives:
 # none0: base (read-only)
-- 
2.26.2


