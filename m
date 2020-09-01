Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57202C433E7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:59:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FE5E206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KE7B7Q7B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE5E206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7kV-0007MS-99
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kD7OT-00022o-UA
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:36:17 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55416
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kD7OQ-0007W1-U4
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598970974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SfRbSD7CvrY7rU++lJ4+89wpJRu6V2Zzk8T5NDMc+/o=;
 b=KE7B7Q7Btstw+xZm2DsB3pnV+ubqMoXnzgxImxF8WW4BGOuzg6nezr2wVx/tnG5Mm00QMf
 Hnql6evanHJUpSEI6+xXFd4QlXUK1Wzk1rm8IdSiYffOomjufYZqz5buKUagL/lfqgi7DO
 ats306T+QQPemS/+XtFH8lew9EKnvjg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-IhGyAPRNNeSJ6UraqSoJHg-1; Tue, 01 Sep 2020 10:36:10 -0400
X-MC-Unique: IhGyAPRNNeSJ6UraqSoJHg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15B1810ABDA8;
 Tue,  1 Sep 2020 14:36:09 +0000 (UTC)
Received: from localhost (ovpn-113-83.ams2.redhat.com [10.36.113.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ABF2F7EB94;
 Tue,  1 Sep 2020 14:36:08 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v8 42/43] iotests: Add test for commit in sub directory
Date: Tue,  1 Sep 2020 16:34:23 +0200
Message-Id: <20200901143424.884735-43-mreitz@redhat.com>
In-Reply-To: <20200901143424.884735-1-mreitz@redhat.com>
References: <20200901143424.884735-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:16:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a test for committing an overlay in a sub directory to one of the
images in its backing chain, using both relative and absolute filenames.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/020     | 44 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/020.out | 10 +++++++++
 2 files changed, 54 insertions(+)

diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
index a0782937b0..596505be2d 100755
--- a/tests/qemu-iotests/020
+++ b/tests/qemu-iotests/020
@@ -31,6 +31,11 @@ _cleanup()
     _cleanup_test_img
     _rm_test_img "$TEST_IMG.base"
     _rm_test_img "$TEST_IMG.orig"
+
+    _rm_test_img "$TEST_DIR/subdir/t.$IMGFMT.base"
+    _rm_test_img "$TEST_DIR/subdir/t.$IMGFMT.mid"
+    _rm_test_img "$TEST_DIR/subdir/t.$IMGFMT"
+    rmdir "$TEST_DIR/subdir" &> /dev/null
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
@@ -139,6 +144,45 @@ $QEMU_IO -c 'writev 0 64k' "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG commit "$TEST_IMG"
 _cleanup
 
+
+echo
+echo 'Testing commit in sub-directory with relative filenames'
+echo
+
+pushd "$TEST_DIR" > /dev/null
+
+mkdir subdir
+
+TEST_IMG="subdir/t.$IMGFMT.base" _make_test_img 1M
+TEST_IMG="subdir/t.$IMGFMT.mid" _make_test_img -b "t.$IMGFMT.base" -F $IMGFMT
+TEST_IMG="subdir/t.$IMGFMT" _make_test_img -b "t.$IMGFMT.mid" -F $IMGFMT
+
+# Should work
+$QEMU_IMG commit -b "t.$IMGFMT.mid" "subdir/t.$IMGFMT"
+
+# Might theoretically work, but does not in practice (we have to
+# decide between this and the above; and since we always represent
+# backing file names as relative to the overlay, we go for the above)
+$QEMU_IMG commit -b "subdir/t.$IMGFMT.mid" "subdir/t.$IMGFMT" 2>&1 | \
+    _filter_imgfmt
+
+# This should work as well
+$QEMU_IMG commit -b "$TEST_DIR/subdir/t.$IMGFMT.mid" "subdir/t.$IMGFMT"
+
+popd > /dev/null
+
+# Now let's try with just absolute filenames
+# (This will not work with external data files, though, because when
+# using relative paths for those, qemu will always resolve them
+# relative to its CWD.  Therefore, it cannot find those data files now
+# that we left $TEST_DIR.)
+if _get_data_file '' > /dev/null; then
+    echo 'Image committed.' # Skip test
+else
+    $QEMU_IMG commit -b "$TEST_DIR/subdir/t.$IMGFMT.mid" \
+        "$TEST_DIR/subdir/t.$IMGFMT"
+fi
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/020.out b/tests/qemu-iotests/020.out
index 5936bc1cae..a5db1962ad 100644
--- a/tests/qemu-iotests/020.out
+++ b/tests/qemu-iotests/020.out
@@ -1083,4 +1083,14 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=json:{'driv
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qemu-img: Block job failed: No space left on device
+
+Testing commit in sub-directory with relative filenames
+
+Formatting 'subdir/t.IMGFMT.base', fmt=IMGFMT size=1048576
+Formatting 'subdir/t.IMGFMT.mid', fmt=IMGFMT size=1048576 backing_file=t.IMGFMT.base backing_fmt=IMGFMT
+Formatting 'subdir/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=t.IMGFMT.mid backing_fmt=IMGFMT
+Image committed.
+qemu-img: Did not find 'subdir/t.IMGFMT.mid' in the backing chain of 'subdir/t.IMGFMT'
+Image committed.
+Image committed.
 *** done
-- 
2.26.2


