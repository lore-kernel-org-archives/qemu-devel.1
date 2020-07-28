Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9775BC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:51:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6631C206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VfTEnY6s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6631C206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Q1M-0004gP-Ml
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 09:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k0PyQ-0008Cx-7V
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 09:48:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49689
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k0PyO-0003tR-Kr
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 09:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595944131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YBehD8Sh7kAqTspoSET6GnAY59GUzI6vERZ/x0WwPyI=;
 b=VfTEnY6sTsX67MKVOBYqLFPuHVYjMKCKMIjU1FdNzQ5eLTSzY0tJ5ebCgRD+ckp0/mtEah
 S8oYkWfTaeL/NYi3ZnadMcBPPsGpuPg/Lcg/H/2DTI+jtkkLFCkgJRG8viRQaHOKDv2tv+
 y+BeeyFxG5RYCwDO6cs2aA9rwI/IOac=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-e077iFJLMWGI0M3LjgVv3Q-1; Tue, 28 Jul 2020 09:48:47 -0400
X-MC-Unique: e077iFJLMWGI0M3LjgVv3Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85E00101C8A9;
 Tue, 28 Jul 2020 13:48:46 +0000 (UTC)
Received: from localhost (ovpn-112-145.ams2.redhat.com [10.36.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F81619C4F;
 Tue, 28 Jul 2020 13:48:45 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 2/3] iotests/028: Add test for cross-base-EOF reads
Date: Tue, 28 Jul 2020 15:48:39 +0200
Message-Id: <20200728134840.1557546-3-mreitz@redhat.com>
In-Reply-To: <20200728134840.1557546-1-mreitz@redhat.com>
References: <20200728134840.1557546-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 00:06:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200728120806.265916-3-mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Tested-by: Claudio Fontana <cfontana@suse.de>
---
 tests/qemu-iotests/028     | 19 +++++++++++++++++++
 tests/qemu-iotests/028.out | 11 +++++++++++
 2 files changed, 30 insertions(+)

diff --git a/tests/qemu-iotests/028 b/tests/qemu-iotests/028
index 5d043cef92..6dd3ae09a3 100755
--- a/tests/qemu-iotests/028
+++ b/tests/qemu-iotests/028
@@ -142,6 +142,25 @@ TEST_IMG="${TEST_IMG}.copy" io_zero readv $(( offset + 32 * 1024 )) 512 1024 32
 
 _check_test_img
 
+echo
+echo '=== Reading across backing EOF in one operation ==='
+echo
+
+# Use a cluster boundary as the base end here
+base_size=$((3 * 1024 * 1024 * 1024))
+
+TEST_IMG="$TEST_IMG.base" _make_test_img $base_size
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $image_size
+
+# Write 16 times 42 at the end of the base image
+$QEMU_IO -c "write -P 42 $((base_size - 16)) 16" "$TEST_IMG.base" \
+    | _filter_qemu_io
+
+# Read 32 bytes across the base EOF from the top;
+# should be 16 times 0x2a, then 16 times 0x00
+$QEMU_IO -c "read -v $((base_size - 16)) 32" "$TEST_IMG" \
+    | _filter_qemu_io
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/028.out b/tests/qemu-iotests/028.out
index 12f82c6a6c..5a68de5c46 100644
--- a/tests/qemu-iotests/028.out
+++ b/tests/qemu-iotests/028.out
@@ -730,4 +730,15 @@ read 512/512 bytes at offset 3221257728
 read 512/512 bytes at offset 3221258752
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
+
+=== Reading across backing EOF in one operation ===
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=3221225472
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4294968832 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+wrote 16/16 bytes at offset 3221225456
+16 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+bffffff0:  2a 2a 2a 2a 2a 2a 2a 2a 2a 2a 2a 2a 2a 2a 2a 2a  ................
+c0000000:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+read 32/32 bytes at offset 3221225456
+32 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 *** done
-- 
2.26.2


