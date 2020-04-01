Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141C5C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 14:41:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF9B420719
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 14:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9B420719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJeYm-0001zy-UN
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 10:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jJeUq-0004Bq-Mu
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 10:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jJeUo-0005hD-Ig
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 10:37:36 -0400
Received: from relay.sw.ru ([185.231.240.75]:44966)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jJeUo-0005dg-95; Wed, 01 Apr 2020 10:37:34 -0400
Received: from dptest2.qa.sw.ru ([10.94.4.71])
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jJeUg-0005CS-H3; Wed, 01 Apr 2020 17:37:26 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v16 4/4] iotests: 287: add qcow2 compression type test
Date: Wed,  1 Apr 2020 17:37:19 +0300
Message-Id: <20200401143719.21639-5-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200401143719.21639-1-dplotnikov@virtuozzo.com>
References: <20200401143719.21639-1-dplotnikov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The test checks fulfilling qcow2 requiriements for the compression
type feature and zstd compression type operability.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 tests/qemu-iotests/287     | 162 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/287.out |  70 ++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 233 insertions(+)
 create mode 100755 tests/qemu-iotests/287
 create mode 100644 tests/qemu-iotests/287.out

diff --git a/tests/qemu-iotests/287 b/tests/qemu-iotests/287
new file mode 100755
index 0000000000..699dccd72c
--- /dev/null
+++ b/tests/qemu-iotests/287
@@ -0,0 +1,162 @@
+#!/usr/bin/env bash
+#
+# Test case for an image using zstd compression
+#
+# Copyright (c) 2020 Virtuozzo International GmbH
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+# creator
+owner=dplotnikov@virtuozzo.com
+
+seq="$(basename $0)"
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+
+# standard environment
+. ./common.rc
+. ./common.filter
+
+# This tests qocw2-specific low-level functionality
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+COMPR_IMG=$TEST_IMG.compressed
+RAND_FILE=$TEST_DIR/rand_data
+
+_cleanup()
+{
+	_cleanup_test_img
+	rm -f $COMPR_IMG
+	rm -f $RAND_FILE
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# for all the cases
+CLUSTER_SIZE=65536
+
+# Check if we can run this test.
+if IMGOPTS='compression_type=zstd' _make_test_img 64M |
+    grep "Invalid parameter 'zstd'"; then
+    _notrun "ZSTD is disabled"
+fi
+
+# Test: when compression is zlib the incompatible bit is unset
+echo
+echo "=== Testing compression type incompatible bit setting for zlib ==="
+echo
+
+IMGOPTS='compression_type=zlib' _make_test_img 64M
+$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
+
+# Test: when compression differs from zlib the incompatible bit is set
+echo
+echo "=== Testing compression type incompatible bit setting for zstd ==="
+echo
+
+IMGOPTS='compression_type=zstd' _make_test_img 64M
+$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
+
+# Test: an image can't be opened if compression type is zlib and
+#       incompatible feature compression type is set
+echo
+echo "=== Testing zlib with incompatible bit set ==="
+echo
+
+IMGOPTS='compression_type=zlib' _make_test_img 64M
+$PYTHON qcow2.py "$TEST_IMG" set-feature-bit incompatible 3
+# to make sure the bit was actually set
+$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
+$QEMU_IMG info "$TEST_IMG" 2>1 1>/dev/null
+if (($?==0)); then
+    echo "Error: The image opened successfully. The image must not be opened"
+fi
+
+# Test: an image can't be opened if compression type is NOT zlib and
+#       incompatible feature compression type is UNSET
+echo
+echo "=== Testing zstd with incompatible bit unset ==="
+echo
+
+IMGOPTS='compression_type=zstd' _make_test_img 64M
+$PYTHON qcow2.py "$TEST_IMG" set-header incompatible_features 0
+# to make sure the bit was actually unset
+$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
+$QEMU_IMG info "$TEST_IMG" 2>1 1>/dev/null
+if (($?==0)); then
+    echo "Error: The image opened successfully. The image must not be opened"
+fi
+# Test: check compression type values
+echo
+echo "=== Testing compression type values ==="
+echo
+# zlib=0
+IMGOPTS='compression_type=zlib' _make_test_img 64M
+od -j104 -N1 -An -vtu1 "$TEST_IMG"
+
+# zstd=1
+IMGOPTS='compression_type=zstd' _make_test_img 64M
+od -j104 -N1 -An -vtu1 "$TEST_IMG"
+
+# Test: using zstd compression, write to and read from an image
+echo
+echo "=== Testing simple reading and writing with zstd ==="
+echo
+
+IMGOPTS='compression_type=zstd' _make_test_img 64M
+$QEMU_IO -c "write -c -P 0xAC 65536 64k " "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -P 0xAC 65536 64k " "$TEST_IMG" | _filter_qemu_io
+# read on the cluster boundaries
+$QEMU_IO -c "read -v 131070 8 " "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -v 65534 8" "$TEST_IMG" | _filter_qemu_io
+
+# Test: using zstd compression, write and verify three adjacent
+#       compressed clusters
+echo
+echo "=== Testing adjacent clusters reading and writing with zstd ==="
+echo
+
+IMGOPTS='compression_type=zstd' _make_test_img 64M
+$QEMU_IO -c "write -c -P 0xAB 0 64k " "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "write -c -P 0xAC 65536 64k " "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "write -c -P 0xAD 131072 64k " "$TEST_IMG" | _filter_qemu_io
+
+$QEMU_IO -c "read -P 0xAB 0 64k " "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -P 0xAC 65536 64k " "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -P 0xAD 131072 64k " "$TEST_IMG" | _filter_qemu_io
+
+# Test: create an image, write 1M likely uncompressible data from urandom,
+#       write 1M of compressible data, convert the image with zstd
+#       and compare these two images - their data should be identical
+echo
+echo "=== Testing incompressible cluster processing with zstd ==="
+echo
+
+dd if=/dev/urandom of=$RAND_FILE bs=1M count=1
+
+_make_test_img 64M
+# fill the image with likely incompressible and compressible clusters
+$QEMU_IO -c "write -c -s "$RAND_FILE" 0 1M " "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "write -c -P 0xFA 1M 1M " "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG convert -O $IMGFMT -c -o compression_type=zstd \
+                  "$TEST_IMG" "$COMPR_IMG"
+$QEMU_IMG compare "$TEST_IMG" "$COMPR_IMG"
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/287.out b/tests/qemu-iotests/287.out
new file mode 100644
index 0000000000..3f47528b20
--- /dev/null
+++ b/tests/qemu-iotests/287.out
@@ -0,0 +1,70 @@
+QA output created by 287
+
+=== Testing compression type incompatible bit setting for zlib ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+incompatible_features     []
+
+=== Testing compression type incompatible bit setting for zstd ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+incompatible_features     [3]
+
+=== Testing zlib with incompatible bit set  ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+incompatible_features     [3]
+
+=== Testing zstd with incompatible bit unset  ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+incompatible_features     []
+
+=== Testing compression type values  ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+   0
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+   1
+
+=== Testing simple reading and writing with zstd ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+wrote 65536/65536 bytes at offset 65536
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 65536
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+0001fffe:  ac ac 00 00 00 00 00 00  ........
+read 8/8 bytes at offset 131070
+8 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+0000fffe:  00 00 ac ac ac ac ac ac  ........
+read 8/8 bytes at offset 65534
+8 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== Testing adjacent clusters reading and writing with zstd ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+wrote 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 65536
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 131072
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 65536
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 131072
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== Testing incompressible cluster processing with zstd ===
+
+1+0 records in
+1+0 records out
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Images are identical.
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 79c6dfc85d..dacbcfc12d 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -294,5 +294,6 @@
 283 auto quick
 284 rw
 286 rw quick
+287 auto quick
 288 quick
 289 rw quick
-- 
2.17.0


