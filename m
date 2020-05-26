Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17ECC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C5F820776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HlY7h6u1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C5F820776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdcmz-00081E-A4
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 12:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdcfF-0005Sr-7m
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:42:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23308
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdcfA-0003CW-NZ
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590511367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5+8N0laAh6JXO7upcW6kp1tPX0pIL9vlOO6vRS04kbQ=;
 b=HlY7h6u1oFiJJ3myC8Pj35UJI0TKYqR0GRMMgUs1nz+6AC8owg8SrvTFo1QsUJcnOmldHx
 Yd8CHinmmLzRiBe1ekk5pRL6V/9teJB32sn/oT9e34oaPLRjmYzmdWCQCf1EiWwpTc010J
 /6PskXtUr+QZPoVtDBgHeymK+MRyRq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-7Wmq4wLNPSWhD0T3SAe_fw-1; Tue, 26 May 2020 12:42:41 -0400
X-MC-Unique: 7Wmq4wLNPSWhD0T3SAe_fw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 703911009443;
 Tue, 26 May 2020 16:42:40 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 830A07D975;
 Tue, 26 May 2020 16:42:37 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/11] iotests: Add test 291 to for qemu-img bitmap coverage
Date: Tue, 26 May 2020 11:42:11 -0500
Message-Id: <20200526164211.1569366-12-eblake@redhat.com>
In-Reply-To: <20200526164211.1569366-1-eblake@redhat.com>
References: <20200526164211.1569366-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:14:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a new test covering the 'qemu-img bitmap' subcommand, as well as
'qemu-img convert --bitmaps', both added in recent patches.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200521192137.1120211-6-eblake@redhat.com>
---
 tests/qemu-iotests/291     | 112 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/291.out |  80 ++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 193 insertions(+)
 create mode 100755 tests/qemu-iotests/291
 create mode 100644 tests/qemu-iotests/291.out

diff --git a/tests/qemu-iotests/291 b/tests/qemu-iotests/291
new file mode 100755
index 000000000000..3ca83b9cd1f7
--- /dev/null
+++ b/tests/qemu-iotests/291
@@ -0,0 +1,112 @@
+#!/usr/bin/env bash
+#
+# Test qemu-img bitmap handling
+#
+# Copyright (C) 2018-2020 Red Hat, Inc.
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
+seq="$(basename $0)"
+echo "QA output created by $seq"
+
+status=1 # failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+    nbd_server_stop
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+. ./common.nbd
+
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+_require_command QEMU_NBD
+
+echo
+echo "=== Initial image setup ==="
+echo
+
+# Create backing image with one bitmap
+TEST_IMG="$TEST_IMG.base" _make_test_img 10M
+$QEMU_IMG bitmap --add -f $IMGFMT "$TEST_IMG.base" b0
+$QEMU_IO -c 'w 3M 1M' -f $IMGFMT "$TEST_IMG.base" | _filter_qemu_io
+
+# Create initial image and populate two bitmaps: one active, one inactive.
+ORIG_IMG=$TEST_IMG
+TEST_IMG=$TEST_IMG.orig
+_make_test_img -b "$ORIG_IMG.base" -F $IMGFMT 10M
+$QEMU_IO -c 'w 0 1M' -f $IMGFMT "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG bitmap --add -g 512k -f $IMGFMT "$TEST_IMG" b1
+$QEMU_IMG bitmap --add --disable -f $IMGFMT "$TEST_IMG" b2
+$QEMU_IO -c 'w 3M 1M' -f $IMGFMT "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG bitmap --clear -f $IMGFMT "$TEST_IMG" b1
+$QEMU_IO -c 'w 1M 1M' -f $IMGFMT "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG bitmap --disable -f $IMGFMT "$TEST_IMG" b1
+$QEMU_IMG bitmap --enable -f $IMGFMT "$TEST_IMG" b2
+$QEMU_IO -c 'w 2M 1M' -f $IMGFMT "$TEST_IMG" | _filter_qemu_io
+
+echo
+echo "=== Bitmap preservation not possible to non-qcow2 ==="
+echo
+
+TEST_IMG=$ORIG_IMG
+$QEMU_IMG convert --bitmaps -O raw "$TEST_IMG.orig" "$TEST_IMG" &&
+    echo "unexpected success"
+
+echo
+echo "=== Convert with bitmap preservation ==="
+echo
+
+# Only bitmaps from the active layer are copied
+$QEMU_IMG convert --bitmaps -O qcow2 "$TEST_IMG.orig" "$TEST_IMG"
+$QEMU_IMG info "$TEST_IMG" | _filter_img_info --format-specific
+# But we can also merge in bitmaps from other layers.  This test is a bit
+# contrived to cover more code paths, in reality, you could merge directly
+# into b0 without going through tmp
+$QEMU_IMG bitmap --add --disable -f $IMGFMT "$TEST_IMG" b0
+$QEMU_IMG bitmap --add --merge b0 -b "$TEST_IMG.base" -F $IMGFMT \
+     -f $IMGFMT "$TEST_IMG" tmp
+$QEMU_IMG bitmap --merge tmp -f $IMGFMT "$TEST_IMG" b0
+$QEMU_IMG bitmap --remove --image-opts \
+    driver=$IMGFMT,file.driver=file,file.filename="$TEST_IMG" tmp
+$QEMU_IMG info "$TEST_IMG" | _filter_img_info --format-specific
+
+echo
+echo "=== Check bitmap contents ==="
+echo
+
+# x-dirty-bitmap is a hack for reading bitmaps; it abuses block status to
+# report "data":false for portions of the bitmap which are set
+IMG="driver=nbd,server.type=unix,server.path=$nbd_unix_socket"
+nbd_server_start_unix_socket -r -f qcow2 -B b0 "$TEST_IMG"
+$QEMU_IMG map --output=json --image-opts \
+    "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:b0" | _filter_qemu_img_map
+nbd_server_start_unix_socket -r -f qcow2 -B b1 "$TEST_IMG"
+$QEMU_IMG map --output=json --image-opts \
+    "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:b1" | _filter_qemu_img_map
+nbd_server_start_unix_socket -r -f qcow2 -B b2 "$TEST_IMG"
+$QEMU_IMG map --output=json --image-opts \
+    "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:b2" | _filter_qemu_img_map
+
+# success, all done
+echo '*** done'
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/291.out b/tests/qemu-iotests/291.out
new file mode 100644
index 000000000000..8c62017567e9
--- /dev/null
+++ b/tests/qemu-iotests/291.out
@@ -0,0 +1,80 @@
+QA output created by 291
+
+=== Initial image setup ===
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=10485760
+wrote 1048576/1048576 bytes at offset 3145728
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=IMGFMT size=10485760 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 3145728
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 2097152
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== Bitmap preservation not possible to non-qcow2 ===
+
+qemu-img: Format driver 'raw' does not support bitmaps
+
+=== Convert with bitmap preservation ===
+
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 10 MiB (10485760 bytes)
+disk size: 4.39 MiB
+Format specific information:
+    compat: 1.1
+    compression type: zlib
+    lazy refcounts: false
+    bitmaps:
+        [0]:
+            flags:
+            name: b1
+            granularity: 524288
+        [1]:
+            flags:
+                [0]: auto
+            name: b2
+            granularity: 65536
+    refcount bits: 16
+    corrupt: false
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 10 MiB (10485760 bytes)
+disk size: 4.48 MiB
+Format specific information:
+    compat: 1.1
+    compression type: zlib
+    lazy refcounts: false
+    bitmaps:
+        [0]:
+            flags:
+            name: b1
+            granularity: 524288
+        [1]:
+            flags:
+                [0]: auto
+            name: b2
+            granularity: 65536
+        [2]:
+            flags:
+            name: b0
+            granularity: 65536
+    refcount bits: 16
+    corrupt: false
+
+=== Check bitmap contents ===
+
+[{ "start": 0, "length": 3145728, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 3145728, "length": 1048576, "depth": 0, "zero": false, "data": false},
+{ "start": 4194304, "length": 6291456, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
+[{ "start": 0, "length": 1048576, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 1048576, "length": 1048576, "depth": 0, "zero": false, "data": false},
+{ "start": 2097152, "length": 8388608, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
+[{ "start": 0, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 2097152, "length": 1048576, "depth": 0, "zero": false, "data": false},
+{ "start": 3145728, "length": 7340032, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 445c26f8d2e2..d886fa0cb355 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -299,5 +299,6 @@
 288 quick
 289 rw quick
 290 rw auto quick
+291 rw quick
 292 rw auto quick
 297 meta
-- 
2.26.2


