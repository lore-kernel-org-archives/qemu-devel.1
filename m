Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AB4C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 10:41:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 050EC207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 10:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W8wbn9lU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050EC207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmESP-0000Tb-76
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 06:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jmERd-0008E5-Fv
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 06:40:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58061
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jmERa-0000vx-Ma
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 06:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592563222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tn26SWpQZvPrUnPWcaacLiB+xjnFQetZ2himE/eWy6I=;
 b=W8wbn9lU7BLQxuv1IwPx2/hgUX3reP37VmQh59iovJWRrEgHRrllgqveit7TM/0dKepTUL
 MdnGrCwasleY16l2bnObVuSPkR7/MEJna6AmktPsn1KGVLACn1rt23LJgo5mTkrgCPrPVd
 qsp/O3NnOc0+7qNbJOuKcaKLMs5u6cw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-3Ldqw--2PTeYeOMAxlCTaA-1; Fri, 19 Jun 2020 06:40:20 -0400
X-MC-Unique: 3Ldqw--2PTeYeOMAxlCTaA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5108C8035CF;
 Fri, 19 Jun 2020 10:40:19 +0000 (UTC)
Received: from localhost (ovpn-113-28.ams2.redhat.com [10.36.113.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C3FC25C1D0;
 Fri, 19 Jun 2020 10:40:18 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/2] iotests/244: Test preallocation for data-file-raw
Date: Fri, 19 Jun 2020 12:40:12 +0200
Message-Id: <20200619104012.235977-3-mreitz@redhat.com>
In-Reply-To: <20200619104012.235977-1-mreitz@redhat.com>
References: <20200619104012.235977-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 05:19:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/244     | 65 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/244.out | 23 ++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/tests/qemu-iotests/244 b/tests/qemu-iotests/244
index efe3c0428b..c2fdeab0c7 100755
--- a/tests/qemu-iotests/244
+++ b/tests/qemu-iotests/244
@@ -217,6 +217,71 @@ $QEMU_IMG amend -f $IMGFMT -o "data_file=blkdebug::$TEST_IMG.data" "$TEST_IMG"
 $QEMU_IMG convert -f $IMGFMT -O $IMGFMT -n -C "$TEST_IMG.src" "$TEST_IMG"
 $QEMU_IMG compare -f $IMGFMT -F $IMGFMT "$TEST_IMG.src" "$TEST_IMG"
 
+echo
+echo '=== Preallocation with data-file-raw ==='
+
+echo
+echo '--- Using a non-zeroed data file ---'
+
+# Using data-file-raw must enforce at least metadata preallocation so
+# that it does not matter whether one reads the raw file or the qcow2
+# file
+
+# The real test we would like to do here is to use an existing block
+# device with some random data on it as the external data file.
+# When creating the qcow2 file, it would not be overwritten and its
+# data would stay as it is.  However, using an existing block device
+# is a bit cumbersome in a test, so we are going to cheat by using a
+# normal regular file.
+
+# Unfortunately, this will O_CREAT | O_TRUNC that regular file, so
+# there is no point in creating it beforehand and filling it with
+# random data:
+_make_test_img -o "data_file=$TEST_IMG.data,data_file_raw=on" 1M
+
+# So now comes the cheating: We write directly into the data file.
+# That is actually unsupported, but it works for this test.
+# (As written above, the actual case would be to use a block device
+# as the external data file.  Such a device would not be emptied when
+# the qcow2 file is created, so its data would persist that step.)
+$QEMU_IO -f raw -c 'write -P 42 0 1M' "$TEST_IMG.data" | _filter_qemu_io
+
+echo
+echo 'Comparing pattern:'
+
+# Reading from either the qcow2 file or the data file should return
+# the same result:
+$QEMU_IO -f raw -c 'read -P 42 0 1M' "$TEST_IMG.data" | _filter_qemu_io
+$QEMU_IO -f $IMGFMT -c 'read -P 42 0 1M' "$TEST_IMG" | _filter_qemu_io
+
+# For good measure
+$QEMU_IMG compare -f raw "$TEST_IMG.data" "$TEST_IMG"
+
+echo
+echo '--- Giving a backing file at runtime ---'
+
+# qcow2 files with data-file-raw cannot have backing files given by
+# their image header, but qemu will allow you to set a backing node at
+# runtime -- it should not have any effect, though (because reading
+# from the qcow2 node should return the same data as reading from the
+# raw node).
+
+_make_test_img -o "data_file=$TEST_IMG.data,data_file_raw=on" 1M
+TEST_IMG="$TEST_IMG.base" _make_test_img 1M
+
+# Write something that is not zero into the base image
+$QEMU_IO -c 'write -P 42 0 1M' "$TEST_IMG.base" | _filter_qemu_io
+
+echo
+echo 'Comparing qcow2 image and raw data file:'
+
+# $TEST_IMG and $TEST_IMG.data must show the same data at all times;
+# that is, the qcow2 node must not fall through to the backing image
+# at any point
+$QEMU_IMG compare --image-opts \
+    "driver=raw,file.filename=$TEST_IMG.data"  \
+    "file.filename=$TEST_IMG,backing.file.filename=$TEST_IMG.base"
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/244.out b/tests/qemu-iotests/244.out
index 24f02363dd..34d6b0e626 100644
--- a/tests/qemu-iotests/244.out
+++ b/tests/qemu-iotests/244.out
@@ -130,4 +130,27 @@ Offset          Length          Mapped to       File
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 data_file=TEST_DIR/t.IMGFMT.data
 Images are identical.
 Images are identical.
+
+=== Preallocation with data-file-raw ===
+
+--- Using a non-zeroed data file ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 data_file=TEST_DIR/t.IMGFMT.data data_file_raw=on
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+Comparing pattern:
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Images are identical.
+
+--- Giving a backing file at runtime ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 data_file=TEST_DIR/t.IMGFMT.data data_file_raw=on
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=1048576
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+Comparing qcow2 image and raw data file:
+Images are identical.
 *** done
-- 
2.26.2


