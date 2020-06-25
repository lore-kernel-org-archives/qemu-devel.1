Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6ABC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB51D2089D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUaRXi+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB51D2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joUBf-00005i-5c
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTjX-0007F0-Bk
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:24:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42211
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTjT-0001dh-41
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593098645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gOsCU0ZB3WqmX998CoRcC04iyDuhkn2FLcrzX97G6yI=;
 b=CUaRXi+5EVNpOiII+pmSw9bSzxtkxpRbJZUhSHDFuw0gdrYUR23u2xnLNGGm85qmenE24e
 CP0QUVannLS5KRxu/IU1hqpp8ZLLHHXxvpYuL74jAOv1LZm7EziYtELEsr7/oxTThZpxFp
 jhOMfbExTId+K0Z+2IbEAAYhj9dqh3E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-LxlPylEuOlyp3Qgif0HbtQ-1; Thu, 25 Jun 2020 11:24:01 -0400
X-MC-Unique: LxlPylEuOlyp3Qgif0HbtQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B198F804002;
 Thu, 25 Jun 2020 15:24:00 +0000 (UTC)
Received: from localhost (ovpn-113-182.ams2.redhat.com [10.36.113.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 543C21A913;
 Thu, 25 Jun 2020 15:24:00 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 46/47] iotests: Add test for commit in sub directory
Date: Thu, 25 Jun 2020 17:22:14 +0200
Message-Id: <20200625152215.941773-47-mreitz@redhat.com>
In-Reply-To: <20200625152215.941773-1-mreitz@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 01:47:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
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
index 20f8f185d0..d5b5d34058 100755
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
 
@@ -134,6 +139,45 @@ $QEMU_IO -c 'writev 0 64k' "$TEST_IMG" | _filter_qemu_io
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
+TEST_IMG="subdir/t.$IMGFMT.mid" _make_test_img -b "t.$IMGFMT.base"
+TEST_IMG="subdir/t.$IMGFMT" _make_test_img -b "t.$IMGFMT.mid"
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
index 4b722b2dd0..228c37dded 100644
--- a/tests/qemu-iotests/020.out
+++ b/tests/qemu-iotests/020.out
@@ -1094,4 +1094,14 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=json:{'driv
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qemu-img: Block job failed: No space left on device
+
+Testing commit in sub-directory with relative filenames
+
+Formatting 'subdir/t.IMGFMT.base', fmt=IMGFMT size=1048576
+Formatting 'subdir/t.IMGFMT.mid', fmt=IMGFMT size=1048576 backing_file=t.IMGFMT.base
+Formatting 'subdir/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=t.IMGFMT.mid
+Image committed.
+qemu-img: Did not find 'subdir/t.IMGFMT.mid' in the backing chain of 'subdir/t.IMGFMT'
+Image committed.
+Image committed.
 *** done
-- 
2.26.2


