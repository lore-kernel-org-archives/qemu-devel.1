Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E98C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:52:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA20920759
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OSWhddbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA20920759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZZp5-0005c4-T5
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 08:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZid-0002AJ-3u
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:45:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49150
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZiZ-00025b-CA
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589546734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EXPHia+QY6PWIiHlRICaayf4bn1MBVx2ww07ykyxOSM=;
 b=OSWhddbfI2Ty4JAlkdR3vAC75bwqx65QGJL0SEZCJweoK7Um86Q7Rnlj132fFF+LIuqki6
 8zf+DzEuhMQMBSYLY9NE64oU2iroeY5fN3slsF++GgZ2iQ8tSG3eOYDO4iAyXKRNZUsp5e
 Fj/oilVgw5nLLHKRSdsCbwSXvitQ+0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-V9et0d0FNU6yIqU36aZEVQ-1; Fri, 15 May 2020 08:45:32 -0400
X-MC-Unique: V9et0d0FNU6yIqU36aZEVQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CBD1835B42;
 Fri, 15 May 2020 12:45:31 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-110.ams2.redhat.com
 [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C8F92E16F;
 Fri, 15 May 2020 12:45:29 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 01/51] iotests/109: Don't mirror with mismatched size
Date: Fri, 15 May 2020 14:44:31 +0200
Message-Id: <20200515124521.335403-2-kwolf@redhat.com>
In-Reply-To: <20200515124521.335403-1-kwolf@redhat.com>
References: <20200515124521.335403-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

This patch makes the raw image the same size as the file in a different
format that is mirrored as raw to it to avoid errors when mirror starts
to enforce that source and target are the same size.

We check only that the first 512 bytes are zeroed (instead of 64k)
because some image formats create image files that are smaller than 64k,
so trying to read 64k would result in I/O errors. Apart from this, 512
is more appropriate anyway because the raw format driver protects
specifically the first 512 bytes.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200511135825.219437-2-kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/109           | 10 ++---
 tests/qemu-iotests/109.out       | 74 +++++++++++++-------------------
 tests/qemu-iotests/common.filter |  5 +++
 3 files changed, 41 insertions(+), 48 deletions(-)

diff --git a/tests/qemu-iotests/109 b/tests/qemu-iotests/109
index 5bc2e9b001..3ffeaf3c55 100755
--- a/tests/qemu-iotests/109
+++ b/tests/qemu-iotests/109
@@ -77,14 +77,14 @@ for fmt in qcow qcow2 qed vdi vmdk vpc; do
     echo "=== Writing a $fmt header into raw ==="
     echo
 
-    _make_test_img 64M
     TEST_IMG="$TEST_IMG.src" IMGFMT=$fmt _make_test_img 64M
+    _make_test_img $(du -b "$TEST_IMG.src" | cut -f1) | _filter_img_create_size
 
     # This first test should fail: The image format was probed, we may not
     # write an image header at the start of the image
     run_qemu "$TEST_IMG" "$TEST_IMG.src" "" "BLOCK_JOB_ERROR" |
         _filter_block_job_len
-    $QEMU_IO -c 'read -P 0 0 64k' "$TEST_IMG" | _filter_qemu_io
+    $QEMU_IO -c 'read -P 0 0 512' "$TEST_IMG" | _filter_qemu_io
 
 
     # When raw was explicitly specified, the same must succeed
@@ -103,12 +103,12 @@ for sample_img in empty.bochs iotest-dirtylog-10G-4M.vhdx parallels-v1 \
 
     # Can't use _use_sample_img because that isn't designed to be used multiple
     # times and it overwrites $TEST_IMG (both breaks cleanup)
-    _make_test_img 64M
     bzcat "$SAMPLE_IMG_DIR/$sample_img.bz2" > "$TEST_IMG.src"
+    _make_test_img $(du -b "$TEST_IMG.src" | cut -f1) | _filter_img_create_size
 
     run_qemu "$TEST_IMG" "$TEST_IMG.src" "" "BLOCK_JOB_ERROR" |
         _filter_block_job_offset | _filter_block_job_len
-    $QEMU_IO -c 'read -P 0 0 64k' "$TEST_IMG" | _filter_qemu_io
+    $QEMU_IO -c 'read -P 0 0 512' "$TEST_IMG" | _filter_qemu_io
 
     run_qemu "$TEST_IMG" "$TEST_IMG.src" "'format': 'raw'," "BLOCK_JOB_READY"
     $QEMU_IMG compare -f raw -F raw "$TEST_IMG" "$TEST_IMG.src"
@@ -119,8 +119,8 @@ echo "=== Write legitimate MBR into raw ==="
 echo
 
 for sample_img in grub_mbr.raw; do
-    _make_test_img 64M
     bzcat "$SAMPLE_IMG_DIR/$sample_img.bz2" > "$TEST_IMG.src"
+    _make_test_img $(du -b "$TEST_IMG.src" | cut -f1) | _filter_img_create_size
 
     run_qemu "$TEST_IMG" "$TEST_IMG.src" "" "BLOCK_JOB_READY"
     $QEMU_IMG compare -f raw -F raw "$TEST_IMG" "$TEST_IMG.src"
diff --git a/tests/qemu-iotests/109.out b/tests/qemu-iotests/109.out
index 884f65f18d..ad739df46c 100644
--- a/tests/qemu-iotests/109.out
+++ b/tests/qemu-iotests/109.out
@@ -2,8 +2,8 @@ QA output created by 109
 
 === Writing a qcow header into raw ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.raw.src', fmt=IMGFMT size=67108864
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=SIZE
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 'mode': 'existing', 'sync': 'full'}}
@@ -23,8 +23,8 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
-read 65536/65536 bytes at offset 0
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 'format': 'IMGFMT', 'mode': 'existing', 'sync': 'full'}}
@@ -43,13 +43,12 @@ read 65536/65536 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 1024, "offset": 1024, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
-Warning: Image size mismatch!
 Images are identical.
 
 === Writing a qcow2 header into raw ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.raw.src', fmt=IMGFMT size=67108864
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=SIZE
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 'mode': 'existing', 'sync': 'full'}}
@@ -69,8 +68,8 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
-read 65536/65536 bytes at offset 0
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 'format': 'IMGFMT', 'mode': 'existing', 'sync': 'full'}}
@@ -89,13 +88,12 @@ read 65536/65536 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 197120, "offset": 197120, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
-Warning: Image size mismatch!
 Images are identical.
 
 === Writing a qed header into raw ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.raw.src', fmt=IMGFMT size=67108864
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=SIZE
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 'mode': 'existing', 'sync': 'full'}}
@@ -115,8 +113,8 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
-read 65536/65536 bytes at offset 0
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 'format': 'IMGFMT', 'mode': 'existing', 'sync': 'full'}}
@@ -135,13 +133,12 @@ read 65536/65536 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 327680, "offset": 327680, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
-Warning: Image size mismatch!
 Images are identical.
 
 === Writing a vdi header into raw ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.raw.src', fmt=IMGFMT size=67108864
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=SIZE
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 'mode': 'existing', 'sync': 'full'}}
@@ -161,8 +158,8 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
-read 65536/65536 bytes at offset 0
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 'format': 'IMGFMT', 'mode': 'existing', 'sync': 'full'}}
@@ -181,13 +178,12 @@ read 65536/65536 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 1024, "offset": 1024, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
-Warning: Image size mismatch!
 Images are identical.
 
 === Writing a vmdk header into raw ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.raw.src', fmt=IMGFMT size=67108864
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=SIZE
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 'mode': 'existing', 'sync': 'full'}}
@@ -207,8 +203,8 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
-read 65536/65536 bytes at offset 0
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 'format': 'IMGFMT', 'mode': 'existing', 'sync': 'full'}}
@@ -227,13 +223,12 @@ read 65536/65536 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 65536, "offset": 65536, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
-Warning: Image size mismatch!
 Images are identical.
 
 === Writing a vpc header into raw ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.raw.src', fmt=IMGFMT size=67108864
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=SIZE
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 'mode': 'existing', 'sync': 'full'}}
@@ -253,8 +248,8 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
-read 65536/65536 bytes at offset 0
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 'format': 'IMGFMT', 'mode': 'existing', 'sync': 'full'}}
@@ -273,12 +268,11 @@ read 65536/65536 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 2560, "offset": 2560, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
-Warning: Image size mismatch!
 Images are identical.
 
 === Copying sample image empty.bochs into raw ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=SIZE
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 'mode': 'existing', 'sync': 'full'}}
@@ -298,8 +292,8 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
-read 65536/65536 bytes at offset 0
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 'format': 'IMGFMT', 'mode': 'existing', 'sync': 'full'}}
@@ -318,12 +312,11 @@ read 65536/65536 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 2560, "offset": 2560, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
-Warning: Image size mismatch!
 Images are identical.
 
 === Copying sample image iotest-dirtylog-10G-4M.vhdx into raw ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=SIZE
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 'mode': 'existing', 'sync': 'full'}}
@@ -343,8 +336,8 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
-read 65536/65536 bytes at offset 0
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 'format': 'IMGFMT', 'mode': 'existing', 'sync': 'full'}}
@@ -363,12 +356,11 @@ read 65536/65536 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 31457280, "offset": 31457280, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
-Warning: Image size mismatch!
 Images are identical.
 
 === Copying sample image parallels-v1 into raw ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=SIZE
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 'mode': 'existing', 'sync': 'full'}}
@@ -388,8 +380,8 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
-read 65536/65536 bytes at offset 0
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 'format': 'IMGFMT', 'mode': 'existing', 'sync': 'full'}}
@@ -408,12 +400,11 @@ read 65536/65536 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 327680, "offset": 327680, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
-Warning: Image size mismatch!
 Images are identical.
 
 === Copying sample image simple-pattern.cloop into raw ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=SIZE
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 'mode': 'existing', 'sync': 'full'}}
@@ -433,8 +424,8 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
-read 65536/65536 bytes at offset 0
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 'format': 'IMGFMT', 'mode': 'existing', 'sync': 'full'}}
@@ -453,12 +444,11 @@ read 65536/65536 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 2048, "offset": 2048, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
-Warning: Image size mismatch!
 Images are identical.
 
 === Write legitimate MBR into raw ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=SIZE
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 'mode': 'existing', 'sync': 'full'}}
@@ -480,7 +470,6 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 512, "offset": 512, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
-Warning: Image size mismatch!
 Images are identical.
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
@@ -500,6 +489,5 @@ Images are identical.
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 512, "offset": 512, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
-Warning: Image size mismatch!
 Images are identical.
 *** done
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index 279e0bbb0d..03e4f71808 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -156,6 +156,11 @@ _filter_img_create()
         -e "s# compression_type=[a-zA-Z0-9]\\+##g"
 }
 
+_filter_img_create_size()
+{
+    $SED -e "s# size=[0-9]\\+# size=SIZE#g"
+}
+
 _filter_img_info()
 {
     if [[ "$1" == "--format-specific" ]]; then
-- 
2.25.4


