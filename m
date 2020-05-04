Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5145C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:53:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9016120705
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ANZrKjhq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9016120705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdPP-0003UI-M9
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 11:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jVdOc-0002Y2-FW; Mon, 04 May 2020 11:52:42 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:34722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jVdOa-00038C-Df; Mon, 04 May 2020 11:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
 bh=xEbQg4tsuP8r89dvsQ+YpU1zIs7QVaXaDYSsN8k9tTw=; 
 b=ANZrKjhqq8cN2G3QYsTAwfblOU5vb9gvtEh9hXn2tJjZjhotD2i/ZPQ96ff5t/QU9TIzid3lvdZBKKUVrPEp4UHTwIMJSmRMKoyEpVeqmMmOLucKdN6J0mQ0j2yTKln+5wxIX6xqwpTLNcAz+4RpKCAUlOtJq4jTU48sSidLQ5XYCgn7TfVxYKQvkiUdHTkI6m0cpVRg7wOHbX1ZlNzxpsJwxEivzW31wGWx1L5k0N8PodHB0Aga8fFjgcq1yf5tPARJJrRL5p1iTWjqc0krxxyyyWbeFGxiPR0ccYRENZ9GxQIcWVW/qF7OoLPL/YGTpNFQuZ1flRORQaFgxngc1A==;
Received: from [81.0.43.160] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jVdOU-00085H-C1; Mon, 04 May 2020 17:52:34 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jVdOH-0002hM-Ci; Mon, 04 May 2020 17:52:21 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org,
	Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v3] qcow2: Avoid integer wraparound in qcow2_co_truncate()
Date: Mon,  4 May 2020 17:52:17 +0200
Message-Id: <20200504155217.10325-1-berto@igalia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 09:47:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
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
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After commit f01643fb8b47e8a70c04bbf45e0f12a9e5bc54de when an image is
extended and BDRV_REQ_ZERO_WRITE is set then the new clusters are
zeroized.

The code however does not detect correctly situations when the old and
the new end of the image are within the same cluster. The problem can
be reproduced with these steps:

   qemu-img create -f qcow2 backing.qcow2 1M
   qemu-img create -f qcow2 -F qcow2 -b backing.qcow2 top.qcow2
   qemu-img resize --shrink top.qcow2 520k
   qemu-img resize top.qcow2 567k

In the last step offset - zero_start causes an integer wraparound.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
v3:
- Add test case [Kevin]
- Move MIN(zero_start, offset) to the block that writes zeroes [Kevin]

v2:
- Don't call qcow2_cluster_zeroize() if offset == zero_start

 block/qcow2.c              | 12 ++++---
 tests/qemu-iotests/292     | 73 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/292.out | 24 +++++++++++++
 tests/qemu-iotests/group   |  1 +
 4 files changed, 105 insertions(+), 5 deletions(-)
 create mode 100755 tests/qemu-iotests/292
 create mode 100644 tests/qemu-iotests/292.out

diff --git a/block/qcow2.c b/block/qcow2.c
index 2ba0b17c39..8c97b06783 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4239,15 +4239,17 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
          * requires a cluster-aligned start. The end may be unaligned if it is
          * at the end of the image (which it is here).
          */
-        ret = qcow2_cluster_zeroize(bs, zero_start, offset - zero_start, 0);
-        if (ret < 0) {
-            error_setg_errno(errp, -ret, "Failed to zero out new clusters");
-            goto fail;
+        if (offset > zero_start) {
+            ret = qcow2_cluster_zeroize(bs, zero_start, offset - zero_start, 0);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "Failed to zero out new clusters");
+                goto fail;
+            }
         }
 
         /* Write explicit zeros for the unaligned head */
         if (zero_start > old_length) {
-            uint64_t len = zero_start - old_length;
+            uint64_t len = MIN(zero_start, offset) - old_length;
             uint8_t *buf = qemu_blockalign0(bs, len);
             QEMUIOVector qiov;
             qemu_iovec_init_buf(&qiov, buf, len);
diff --git a/tests/qemu-iotests/292 b/tests/qemu-iotests/292
new file mode 100755
index 0000000000..a2de27cca4
--- /dev/null
+++ b/tests/qemu-iotests/292
@@ -0,0 +1,73 @@
+#!/usr/bin/env bash
+#
+# Test resizing a qcow2 image with a backing file
+#
+# Copyright (C) 2020 Igalia, S.L.
+# Author: Alberto Garcia <berto@igalia.com>
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
+owner=berto@igalia.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1    # failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+echo '### Create the backing image'
+BACKING_IMG="$TEST_IMG.base"
+TEST_IMG="$BACKING_IMG" _make_test_img 1M
+
+echo '### Fill the backing image with data (0x11)'
+$QEMU_IO -c 'write -P 0x11 0 1M' "$BACKING_IMG" | _filter_qemu_io
+
+echo '### Create the top image'
+_make_test_img -F "$IMGFMT" -b "$BACKING_IMG"
+
+echo '### Fill the top image with data (0x22)'
+$QEMU_IO -c 'write -P 0x22 0 1M' "$TEST_IMG" | _filter_qemu_io
+
+# Both offsets are part of the same cluster.
+echo '### Shrink the image to 520k'
+$QEMU_IMG resize --shrink "$TEST_IMG" 520k
+echo '### Grow the image to 567k'
+$QEMU_IMG resize "$TEST_IMG" 567k
+
+echo '### Check that the tail of the image reads as zeroes'
+$QEMU_IO -c 'read -P 0x22    0 520k' "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c 'read -P 0x00 520k  47k' "$TEST_IMG" | _filter_qemu_io
+
+echo '### Show output of qemu-img map'
+$QEMU_IMG map "$TEST_IMG" | _filter_testdir
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/292.out b/tests/qemu-iotests/292.out
new file mode 100644
index 0000000000..807e0530c3
--- /dev/null
+++ b/tests/qemu-iotests/292.out
@@ -0,0 +1,24 @@
+QA output created by 292
+### Create the backing image
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=1048576
+### Fill the backing image with data (0x11)
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+### Create the top image
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+### Fill the top image with data (0x22)
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+### Shrink the image to 520k
+Image resized.
+### Grow the image to 567k
+Image resized.
+### Check that the tail of the image reads as zeroes
+read 532480/532480 bytes at offset 0
+520 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 48128/48128 bytes at offset 532480
+47 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+### Show output of qemu-img map
+Offset          Length          Mapped to       File
+0               0x8dc00         0x50000         TEST_DIR/t.qcow2
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 1710470e70..fe649c5b73 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -298,3 +298,4 @@
 288 quick
 289 rw quick
 290 rw auto quick
+292 rw auto quick
-- 
2.20.1


