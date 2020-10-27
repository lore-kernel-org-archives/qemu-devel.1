Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F391C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:08:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA83D20756
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iil5XfPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA83D20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXUKd-00037c-FW
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 15:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kXUJ4-000183-5i
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 15:06:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59370)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kXUJ2-0001M4-3P
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 15:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603825611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MDw0BYCAXmSDAMu0JAcKLqQ2Zq/J1XKZUQg4Jzl/DbA=;
 b=iil5XfPpOo/3Rr8iaLhmmovgnIghgVVIjZpsuTEmo/1pE2VZBPxVCcP+wMMOWDw3hXknx/
 QMYFT2h2iuXibqw9trkHIzRsbe9V0fM10X62pCdoj0uJ4qbl1X2YQSKkizXifXhojehIvE
 IwOJiFjV8TNDavq6NAyezsdoJl3fx+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-zEulYWJONN2DfR09X294vQ-1; Tue, 27 Oct 2020 15:06:48 -0400
X-MC-Unique: zEulYWJONN2DfR09X294vQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C56F5F9CB;
 Tue, 27 Oct 2020 19:06:47 +0000 (UTC)
Received: from localhost (unknown [10.40.193.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E3E435B4AD;
 Tue, 27 Oct 2020 19:06:43 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-6.0 v3 08/20] iotests: Do not pipe _make_test_img
Date: Tue, 27 Oct 2020 20:05:48 +0100
Message-Id: <20201027190600.192171-9-mreitz@redhat.com>
In-Reply-To: <20201027190600.192171-1-mreitz@redhat.com>
References: <20201027190600.192171-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

Executing _make_test_img as part of a pipe will undo all variable
changes it has done.  As such, this could not work with FUSE (because
we want to remember all of our exports and their qemu instances).

Replace the pipe by a temporary file in 071 and 174 (the two tests that
can run on FUSE).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/071 | 19 +++++++++++++++----
 tests/qemu-iotests/174 | 10 +++++++++-
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
index 88faebcc1d..18fe9054b0 100755
--- a/tests/qemu-iotests/071
+++ b/tests/qemu-iotests/071
@@ -61,8 +61,17 @@ echo
 echo "=== Testing blkverify through filename ==="
 echo
 
-TEST_IMG="$TEST_IMG.base" IMGFMT="raw" _make_test_img --no-opts $IMG_SIZE |\
-    _filter_imgfmt
+# _make_test_img may set variables that we need to retain.  Everything
+# in a pipe is executed in a subshell, so doing so would throw away
+# all changes.  Therefore, we have to store the output in some temp
+# file and filter that.
+scratch_out="$TEST_DIR/img-create.out"
+
+TEST_IMG="$TEST_IMG.base" IMGFMT="raw" _make_test_img --no-opts $IMG_SIZE \
+    >"$scratch_out"
+_filter_imgfmt <"$scratch_out"
+rm -f "$scratch_out"
+
 _make_test_img $IMG_SIZE
 $QEMU_IO -c "open -o driver=raw,file.driver=blkverify,file.raw.filename=$TEST_IMG.base $TEST_IMG" \
          -c 'read 0 512' -c 'write -P 42 0x38000 512' -c 'read -P 42 0x38000 512' | _filter_qemu_io
@@ -76,8 +85,10 @@ echo
 echo "=== Testing blkverify through file blockref ==="
 echo
 
-TEST_IMG="$TEST_IMG.base" IMGFMT="raw" _make_test_img --no-opts $IMG_SIZE |\
-    _filter_imgfmt
+TEST_IMG="$TEST_IMG.base" IMGFMT="raw" _make_test_img --no-opts $IMG_SIZE \
+    >"$scratch_out"
+_filter_imgfmt <"$scratch_out"
+
 _make_test_img $IMG_SIZE
 $QEMU_IO -c "open -o driver=raw,file.driver=blkverify,file.raw.filename=$TEST_IMG.base,file.test.driver=$IMGFMT,file.test.file.filename=$TEST_IMG" \
          -c 'read 0 512' -c 'write -P 42 0x38000 512' -c 'read -P 42 0x38000 512' | _filter_qemu_io
diff --git a/tests/qemu-iotests/174 b/tests/qemu-iotests/174
index e2f14a38c6..1b0dd2e8b7 100755
--- a/tests/qemu-iotests/174
+++ b/tests/qemu-iotests/174
@@ -40,7 +40,15 @@ _unsupported_fmt raw
 
 
 size=256K
-IMGFMT=raw IMGKEYSECRET= _make_test_img --no-opts $size | _filter_imgfmt
+
+# _make_test_img may set variables that we need to retain.  Everything
+# in a pipe is executed in a subshell, so doing so would throw away
+# all changes.  Therefore, we have to store the output in some temp
+# file and filter that.
+scratch_out="$TEST_DIR/img-create.out"
+IMGFMT=raw IMGKEYSECRET= _make_test_img --no-opts $size >"$scratch_out"
+_filter_imgfmt <"$scratch_out"
+rm -f "$scratch_out"
 
 echo
 echo "== reading wrong format should fail =="
-- 
2.26.2


