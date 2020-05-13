Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED51ACA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 14:17:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99C44204EF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 14:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AMPi8FmF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C44204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYsCO-0006no-Sr
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 10:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYsB8-00055F-8j
 for qemu-devel@nongnu.org; Wed, 13 May 2020 10:16:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48944
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYsB7-0006LD-1e
 for qemu-devel@nongnu.org; Wed, 13 May 2020 10:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589379368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IdK3t+bL2uMBW48PwZYVxA7gEVvps4c5LofsxlAX9lA=;
 b=AMPi8FmFIgLkJtrSnhTREaopYyyrLKuuKa8hKeO4GBZ1ZXj2skqiRaj6G3ri/Goly23wiA
 S+LXfTX3sm81BZB8LJNWeXd8WkAKbNGg13ZD7dqLeOtAysCtEZa11QF57qZiWyZbXJHaeU
 ZxlCe0yYpbT/6id5iQzyv5SVufBmuN4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-N8pe_DEgMZ6z9VWtnxqeGA-1; Wed, 13 May 2020 10:16:01 -0400
X-MC-Unique: N8pe_DEgMZ6z9VWtnxqeGA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4708818FF660;
 Wed, 13 May 2020 14:16:00 +0000 (UTC)
Received: from localhost (unknown [10.40.193.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BCB365C1D2;
 Wed, 13 May 2020 14:15:57 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 4/5] iotests: 287: add qcow2 compression type test
Date: Wed, 13 May 2020 16:15:43 +0200
Message-Id: <20200513141544.1459069-5-mreitz@redhat.com>
In-Reply-To: <20200513141544.1459069-1-mreitz@redhat.com>
References: <20200513141544.1459069-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 03:05:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Denis Plotnikov <dplotnikov@virtuozzo.com>

The test checks fulfilling qcow2 requirements for the compression
type feature and zstd compression type operability.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200507082521.29210-5-dplotnikov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/287     | 152 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/287.out |  67 ++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 220 insertions(+)
 create mode 100755 tests/qemu-iotests/287
 create mode 100644 tests/qemu-iotests/287.out

diff --git a/tests/qemu-iotests/287 b/tests/qemu-iotests/287
new file mode 100755
index 0000000000..f98a4cadc1
--- /dev/null
+++ b/tests/qemu-iotests/287
@@ -0,0 +1,152 @@
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
+_unsupported_imgopts 'compat=0.10' data_file
+
+COMPR_IMG="$TEST_IMG.compressed"
+RAND_FILE="$TEST_DIR/rand_data"
+
+_cleanup()
+{
+    _cleanup_test_img
+    _rm_test_img "$COMPR_IMG"
+    rm -f "$RAND_FILE"
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
+echo
+echo "=== Testing compression type incompatible bit setting for zlib ==="
+echo
+_make_test_img -o compression_type=zlib 64M
+$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
+
+echo
+echo "=== Testing compression type incompatible bit setting for zstd ==="
+echo
+_make_test_img -o compression_type=zstd 64M
+$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
+
+echo
+echo "=== Testing zlib with incompatible bit set ==="
+echo
+_make_test_img -o compression_type=zlib 64M
+$PYTHON qcow2.py "$TEST_IMG" set-feature-bit incompatible 3
+# to make sure the bit was actually set
+$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
+
+if $QEMU_IMG info "$TEST_IMG" >/dev/null 2>&1 ; then
+    echo "Error: The image opened successfully. The image must not be opened."
+fi
+
+echo
+echo "=== Testing zstd with incompatible bit unset ==="
+echo
+_make_test_img -o compression_type=zstd 64M
+$PYTHON qcow2.py "$TEST_IMG" set-header incompatible_features 0
+# to make sure the bit was actually unset
+$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
+
+if $QEMU_IMG info "$TEST_IMG" >/dev/null 2>&1 ; then
+    echo "Error: The image opened successfully. The image must not be opened."
+fi
+
+echo
+echo "=== Testing compression type values ==="
+echo
+# zlib=0
+_make_test_img -o compression_type=zlib 64M
+peek_file_be "$TEST_IMG" 104 1
+echo
+
+# zstd=1
+_make_test_img -o compression_type=zstd 64M
+peek_file_be "$TEST_IMG" 104 1
+echo
+
+echo
+echo "=== Testing simple reading and writing with zstd ==="
+echo
+_make_test_img -o compression_type=zstd 64M
+$QEMU_IO -c "write -c -P 0xAC 64K 64K " "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -P 0xAC 64K 64K " "$TEST_IMG" | _filter_qemu_io
+# read on the cluster boundaries
+$QEMU_IO -c "read -v 131070 8 " "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -v 65534 8" "$TEST_IMG" | _filter_qemu_io
+
+echo
+echo "=== Testing adjacent clusters reading and writing with zstd ==="
+echo
+_make_test_img -o compression_type=zstd 64M
+$QEMU_IO -c "write -c -P 0xAB 0 64K " "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "write -c -P 0xAC 64K 64K " "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "write -c -P 0xAD 128K 64K " "$TEST_IMG" | _filter_qemu_io
+
+$QEMU_IO -c "read -P 0xAB 0 64k " "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -P 0xAC 64K 64k " "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -P 0xAD 128K 64k " "$TEST_IMG" | _filter_qemu_io
+
+echo
+echo "=== Testing incompressible cluster processing with zstd ==="
+echo
+# create a 2M image and fill it with 1M likely incompressible data
+# and 1M compressible data
+dd if=/dev/urandom of="$RAND_FILE" bs=1M count=1 seek=1
+QEMU_IO_OPTIONS="$QEMU_IO_OPTIONS_NO_FMT" \
+$QEMU_IO -f raw -c "write -P 0xFA 0 1M" "$RAND_FILE" | _filter_qemu_io
+
+$QEMU_IMG convert -f raw -O $IMGFMT -c \
+-o "$(_optstr_add "$IMGOPTS" "compression_type=zlib")" "$RAND_FILE" \
+"$TEST_IMG" | _filter_qemu_io
+
+$QEMU_IMG convert -O $IMGFMT -c \
+-o "$(_optstr_add "$IMGOPTS" "compression_type=zstd")" "$TEST_IMG" \
+"$COMPR_IMG" | _filter_qemu_io
+
+$QEMU_IMG compare "$TEST_IMG" "$COMPR_IMG"
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/287.out b/tests/qemu-iotests/287.out
new file mode 100644
index 0000000000..6b9dfb4af0
--- /dev/null
+++ b/tests/qemu-iotests/287.out
@@ -0,0 +1,67 @@
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
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Images are identical.
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index fe649c5b73..34175fd437 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -295,6 +295,7 @@
 283 auto quick
 284 rw
 286 rw quick
+287 auto quick
 288 quick
 289 rw quick
 290 rw auto quick
-- 
2.26.2


