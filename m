Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00F7C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 17:56:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B57D620830
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 17:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B57D620830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9vES-0008LH-GQ
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 13:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i9vC9-0006Ys-Eb
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 13:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i9vC3-0004ug-6N
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 13:53:49 -0400
Received: from relay.sw.ru ([185.231.240.75]:36810)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i9vBp-0004nd-Sh; Mon, 16 Sep 2019 13:53:30 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1i9vBm-0004Nc-8v; Mon, 16 Sep 2019 20:53:26 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Mon, 16 Sep 2019 20:53:20 +0300
Message-Id: <20190916175324.18478-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916175324.18478-1-vsementsov@virtuozzo.com>
References: <20190916175324.18478-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v5 1/5] qemu-iotests: ignore leaks on failure
 paths in 026
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Upcoming asynchronous handling of sub-parts of qcow2 requests will
change number of leaked clusters and even make it racy. As a
preparation, ignore leaks on failure parts in 026.

It's not trivial to just grep or substitute qemu-img output for such
thing. Instead do better: 3 is a error code of qemu-img check, if only
leaks are found. Catch this case and print success output.

Suggested-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/026             |  6 +--
 tests/qemu-iotests/026.out         | 80 ++++++++----------------------
 tests/qemu-iotests/026.out.nocache | 80 ++++++++----------------------
 tests/qemu-iotests/common.rc       | 17 +++++++
 4 files changed, 60 insertions(+), 123 deletions(-)

diff --git a/tests/qemu-iotests/026 b/tests/qemu-iotests/026
index ffb18ab6b5..3430029ed6 100755
--- a/tests/qemu-iotests/026
+++ b/tests/qemu-iotests/026
@@ -107,7 +107,7 @@ if [ "$event" == "l2_load" ]; then
     $QEMU_IO -c "read $vmstate 0 128k " "$BLKDBG_TEST_IMG" | _filter_qemu_io
 fi
 
-_check_test_img 2>&1 | grep -v "refcount=1 reference=0"
+_check_test_img_ignore_leaks 2>&1 | grep -v "refcount=1 reference=0"
 
 done
 done
@@ -152,7 +152,7 @@ echo
 echo "Event: $event; errno: $errno; imm: $imm; once: $once; write $vmstate"
 $QEMU_IO -c "write $vmstate 0 64M" "$BLKDBG_TEST_IMG" | _filter_qemu_io
 
-_check_test_img 2>&1 | grep -v "refcount=1 reference=0"
+_check_test_img_ignore_leaks 2>&1 | grep -v "refcount=1 reference=0"
 
 done
 done
@@ -191,7 +191,7 @@ echo
 echo "Event: $event; errno: $errno; imm: $imm; once: $once"
 $QEMU_IO -c "write -b 0 64k" "$BLKDBG_TEST_IMG" | _filter_qemu_io
 
-_check_test_img 2>&1 | grep -v "refcount=1 reference=0"
+_check_test_img_ignore_leaks 2>&1 | grep -v "refcount=1 reference=0"
 
 done
 done
diff --git a/tests/qemu-iotests/026.out b/tests/qemu-iotests/026.out
index fb89b8480c..ff0817b6f2 100644
--- a/tests/qemu-iotests/026.out
+++ b/tests/qemu-iotests/026.out
@@ -17,18 +17,14 @@ Event: l1_update; errno: 5; imm: off; once: off; write
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
-
-1 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 5; imm: off; once: off; write -b
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
-
-1 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 28; imm: off; once: on; write
@@ -45,18 +41,14 @@ Event: l1_update; errno: 28; imm: off; once: off; write
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
-
-1 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 28; imm: off; once: off; write -b
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
-
-1 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_load; errno: 5; imm: off; once: on; write
@@ -137,18 +129,14 @@ Event: l2_update; errno: 5; imm: off; once: off; write
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
-
-127 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_update; errno: 5; imm: off; once: off; write -b
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
-
-127 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_update; errno: 28; imm: off; once: on; write
@@ -165,18 +153,14 @@ Event: l2_update; errno: 28; imm: off; once: off; write
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
-
-127 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_update; errno: 28; imm: off; once: off; write -b
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
-
-127 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_alloc_write; errno: 5; imm: off; once: on; write
@@ -200,9 +184,7 @@ Event: l2_alloc_write; errno: 5; imm: off; once: off; write -b
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
-
-1 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_alloc_write; errno: 28; imm: off; once: on; write
@@ -226,9 +208,7 @@ Event: l2_alloc_write; errno: 28; imm: off; once: off; write -b
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
-
-1 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: write_aio; errno: 5; imm: off; once: on; write
@@ -480,18 +460,14 @@ Event: refblock_alloc_hookup; errno: 28; imm: off; once: off; write
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
-
-55 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_hookup; errno: 28; imm: off; once: off; write -b
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
-
-251 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write; errno: 28; imm: off; once: on; write
@@ -532,18 +508,14 @@ Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; write
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
-
-10 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; write -b
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
-
-23 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: on; write
@@ -560,18 +532,14 @@ Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
-
-10 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write -b
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
-
-23 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: on; write
@@ -588,18 +556,14 @@ Event: refblock_alloc_switch_table; errno: 28; imm: off; once: off; write
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
-
-10 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: off; write -b
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
-
-23 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 
 === L1 growth tests ===
 
@@ -658,9 +622,7 @@ Event: l1_grow_activate_table; errno: 5; imm: off; once: off
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
-
-96 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_activate_table; errno: 28; imm: off; once: on
@@ -672,9 +634,7 @@ Event: l1_grow_activate_table; errno: 28; imm: off; once: off
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
-
-96 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 
 === Avoid cluster leaks after temporary failure ===
 
diff --git a/tests/qemu-iotests/026.out.nocache b/tests/qemu-iotests/026.out.nocache
index 6dda95dfb4..495d013007 100644
--- a/tests/qemu-iotests/026.out.nocache
+++ b/tests/qemu-iotests/026.out.nocache
@@ -17,18 +17,14 @@ Event: l1_update; errno: 5; imm: off; once: off; write
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
-
-1 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l1_update; errno: 5; imm: off; once: off; write -b
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
-
-1 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l1_update; errno: 28; imm: off; once: on; write 
@@ -45,18 +41,14 @@ Event: l1_update; errno: 28; imm: off; once: off; write
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
-
-1 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l1_update; errno: 28; imm: off; once: off; write -b
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
-
-1 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l2_load; errno: 5; imm: off; once: on; write 
@@ -140,9 +132,7 @@ qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-
-127 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l2_update; errno: 5; imm: off; once: off; write -b
@@ -150,9 +140,7 @@ qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-
-127 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l2_update; errno: 28; imm: off; once: on; write 
@@ -172,9 +160,7 @@ qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-
-127 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l2_update; errno: 28; imm: off; once: off; write -b
@@ -182,9 +168,7 @@ qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-
-127 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l2_alloc_write; errno: 5; imm: off; once: on; write 
@@ -208,9 +192,7 @@ Event: l2_alloc_write; errno: 5; imm: off; once: off; write -b
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
-
-1 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l2_alloc_write; errno: 28; imm: off; once: on; write 
@@ -234,9 +216,7 @@ Event: l2_alloc_write; errno: 28; imm: off; once: off; write -b
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
-
-1 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: write_aio; errno: 5; imm: off; once: on; write 
@@ -488,18 +468,14 @@ Event: refblock_alloc_hookup; errno: 28; imm: off; once: off; write
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
-
-55 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_hookup; errno: 28; imm: off; once: off; write -b
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
-
-251 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_write; errno: 28; imm: off; once: on; write 
@@ -540,18 +516,14 @@ Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; write
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
-
-10 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; write -b
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
-
-23 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: on; write 
@@ -568,18 +540,14 @@ Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
-
-10 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write -b
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
-
-23 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: on; write 
@@ -596,18 +564,14 @@ Event: refblock_alloc_switch_table; errno: 28; imm: off; once: off; write
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
-
-10 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: off; write -b
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
-
-23 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 
 === L1 growth tests ===
 
@@ -666,9 +630,7 @@ Event: l1_grow_activate_table; errno: 5; imm: off; once: off
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
-
-96 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l1_grow_activate_table; errno: 28; imm: off; once: on
@@ -680,9 +642,7 @@ Event: l1_grow_activate_table; errno: 28; imm: off; once: off
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
-
-96 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 
 === Avoid cluster leaks after temporary failure ===
 
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index e45cdfa66b..12b4751848 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -405,6 +405,23 @@ _check_test_img()
             $QEMU_IMG check "$@" -f $IMGFMT "$TEST_IMG" 2>&1
         fi
     ) | _filter_testdir | _filter_qemu_img_check
+
+    # return real qemu_img check status, to analyze in
+    # _check_test_img_ignore_leaks
+    return ${PIPESTATUS[0]}
+}
+
+_check_test_img_ignore_leaks()
+{
+    out=$(_check_test_img "$@")
+    status=$?
+    if [ $status = 3 ]; then
+        # This must correspond to success output in dump_human_image_check()
+        echo "No errors were found on the image."
+        return 0
+    fi
+    echo "$out"
+    return $status
 }
 
 _img_info()
-- 
2.21.0


