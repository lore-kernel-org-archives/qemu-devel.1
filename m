Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB981C4332E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 19:45:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B659B2070A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 19:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="k0waLvH9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B659B2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGT1J-0000s0-UZ
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 15:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jGT0G-0008FH-He
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 15:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jGT0D-00032h-GH
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 15:44:51 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:57829)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jGT0C-00030M-Qo; Mon, 23 Mar 2020 15:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
 bh=Fvd2Yeca7+eLaerH3b0g1IeaFvn1PlHDtSwgvTxdWC4=; 
 b=k0waLvH9QcMooC6/DgJ+IaRgE9uccdWgXs21iBrtF+mHjZ2ozf7ViP8xLGi9NJlE0KMbb98VDpbWFrL/JhoxyCe3EXRI8PAk8pl5jQ6soaqN51nyDlbMtSkIi7i3F4/TtAEd/CupjIHZXrnc+EdkYOEh3oMvd+zqhh1Fb4j0rnceiIiTTH5Qb7YZVnsFO3RtU/IzPpelFmkAwlq63Aunx3d+LcoUJ3cAr4mxIzUzl2MDZWZ0A0GcjQ+4AMrz9nVM1+8/KEy+t6/a+l1bWGEjcvJgLbOc5tlnyNmBsHHQpdli+pXoYxj/SG9qMzTjOVu4o7Ke9psRbM49h8pyn00OuQ==;
Received: from static.113.35.0.81.ibercom.com ([81.0.35.113]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jGT08-0002le-6M; Mon, 23 Mar 2020 20:44:44 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jGSzv-0000ST-9W; Mon, 23 Mar 2020 20:44:31 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qcow2: Forbid discard in qcow2 v2 images with backing files
Date: Mon, 23 Mar 2020 20:44:29 +0100
Message-Id: <20200323194429.1717-1-berto@igalia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A discard request deallocates the selected clusters so they read back
as zeroes. This is done by clearing the cluster offset field and
setting QCOW_OFLAG_ZERO in the L2 entry.

This flag is however only supported when qcow_version >= 3. In older
images the cluster is simply deallocated, exposing any possible stale
data from the backing file.

Since discard is an advisory operation it's safer to simply forbid it
in this scenario.

Note that we are adding this check to qcow2_co_pdiscard() and not to
qcow2_cluster_discard() or discard_in_l2_slice() because the last
two are also used by qcow2_snapshot_create() to discard the clusters
used by the VM state. In this case there's no risk of exposing stale
data to the guest and we really want that the clusters are always
discarded.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c              |  6 +++
 tests/qemu-iotests/060     |  5 ++-
 tests/qemu-iotests/060.out |  2 -
 tests/qemu-iotests/289     | 90 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/289.out | 52 ++++++++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 6 files changed, 152 insertions(+), 4 deletions(-)
 create mode 100755 tests/qemu-iotests/289
 create mode 100644 tests/qemu-iotests/289.out

diff --git a/block/qcow2.c b/block/qcow2.c
index d44b45633d..7bb7e392e1 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3763,6 +3763,12 @@ static coroutine_fn int qcow2_co_pdiscard(BlockDriverState *bs,
     int ret;
     BDRVQcow2State *s = bs->opaque;
 
+    /* If the image does not support QCOW_OFLAG_ZERO then discarding
+     * clusters could expose stale data from the backing file. */
+    if (s->qcow_version < 3 && bs->backing) {
+        return -ENOTSUP;
+    }
+
     if (!QEMU_IS_ALIGNED(offset | bytes, s->cluster_size)) {
         assert(bytes < s->cluster_size);
         /* Ignore partial clusters, except for the special case of the
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index 043f12904a..4a4fdfb1e1 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -167,9 +167,10 @@ _make_test_img -o 'compat=0.10' -b "$BACKING_IMG" 1G
 # Write two clusters, the second one enforces creation of an L2 table after
 # the first data cluster.
 $QEMU_IO -c 'write 0k 64k' -c 'write 512M 64k' "$TEST_IMG" | _filter_qemu_io
-# Discard the first cluster. This cluster will soon enough be reallocated and
+# Free the first cluster. This cluster will soon enough be reallocated and
 # used for COW.
-$QEMU_IO -c 'discard 0k 64k' "$TEST_IMG" | _filter_qemu_io
+poke_file "$TEST_IMG" '262144' "\x00\x00\x00\x00\x00\x00\x00\x00" # 0x40000 - L2 entry
+poke_file "$TEST_IMG" '131082' "\x00\x00" # 0x2000a - Refcount entry
 # Now, corrupt the image by marking the second L2 table cluster as free.
 poke_file "$TEST_IMG" '131084' "\x00\x00" # 0x2000c
 # Start a write operation requiring COW on the image stopping it right before
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index d27692a33c..09caaea865 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -105,8 +105,6 @@ wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 536870912
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-discard 65536/65536 bytes at offset 0
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2: Marking image as corrupt: Preventing invalid write on metadata (overlaps with active L2 table); further corruption events will be suppressed
 blkdebug: Suspended request '0'
 write failed: Input/output error
diff --git a/tests/qemu-iotests/289 b/tests/qemu-iotests/289
new file mode 100755
index 0000000000..13b4984721
--- /dev/null
+++ b/tests/qemu-iotests/289
@@ -0,0 +1,90 @@
+#!/usr/bin/env bash
+#
+# Test how 'qemu-io -c discard' behaves on v2 and v3 qcow2 images
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
+    rm -f "$TEST_IMG.backing"
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
+echo
+echo "### Test 'qemu-io -c discard' on a QCOW2 image without a backing file"
+echo
+for qcow2_compat in 0.10 1.1; do
+    echo "# Create an image with compat=$qcow2_compat without a backing file"
+    _make_test_img -o "compat=$qcow2_compat" 128k
+
+    echo "# Fill all clusters with data and then discard them"
+    $QEMU_IO -c 'write -P 0x01 0 128k' "$TEST_IMG" | _filter_qemu_io
+    $QEMU_IO -c 'discard 0 128k' "$TEST_IMG" | _filter_qemu_io
+
+    echo "# Read the data from the discarded clusters"
+    $QEMU_IO -c 'read -P 0x00 0 128k' "$TEST_IMG" | _filter_qemu_io
+done
+
+echo
+echo "### Test 'qemu-io -c discard' on a QCOW2 image with a backing file"
+echo
+
+echo "# Create a backing image and fill it with data"
+TEST_IMG="$TEST_IMG.backing" _make_test_img 128k
+$QEMU_IO -c 'write -P 0xff 0 128k' "$TEST_IMG.backing" | _filter_qemu_io
+
+for qcow2_compat in 0.10 1.1; do
+    echo "# Create an image with compat=$qcow2_compat and a backing file"
+    _make_test_img -o "compat=$qcow2_compat" -b "$TEST_IMG.backing"
+
+    echo "# Fill all clusters with data and then discard them"
+    $QEMU_IO -c 'write -P 0x01 0 128k' "$TEST_IMG" | _filter_qemu_io
+    $QEMU_IO -c 'discard 0 128k' "$TEST_IMG" | _filter_qemu_io
+
+    echo "# Read the data from the discarded clusters"
+    if [ "$qcow2_compat" = "1.1" ]; then
+        # In qcow2 v3 clusters are zeroed (with QCOW_OFLAG_ZERO)
+        $QEMU_IO -c 'read -P 0x00 0 128k' "$TEST_IMG" | _filter_qemu_io
+    else
+        # In qcow2 v2 if there's a backing image we cannot zero the clusters
+        # without exposing the backing file data so discard does nothing
+        $QEMU_IO -c 'read -P 0x01 0 128k' "$TEST_IMG" | _filter_qemu_io
+    fi
+done
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/289.out b/tests/qemu-iotests/289.out
new file mode 100644
index 0000000000..dcd82c6d07
--- /dev/null
+++ b/tests/qemu-iotests/289.out
@@ -0,0 +1,52 @@
+QA output created by 289
+
+### Test 'qemu-io -c discard' on a QCOW2 image without a backing file
+
+# Create an image with compat=0.10 without a backing file
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072
+# Fill all clusters with data and then discard them
+wrote 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+discard 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+# Read the data from the discarded clusters
+read 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+# Create an image with compat=1.1 without a backing file
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072
+# Fill all clusters with data and then discard them
+wrote 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+discard 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+# Read the data from the discarded clusters
+read 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+### Test 'qemu-io -c discard' on a QCOW2 image with a backing file
+
+# Create a backing image and fill it with data
+Formatting 'TEST_DIR/t.IMGFMT.backing', fmt=IMGFMT size=131072
+wrote 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+# Create an image with compat=0.10 and a backing file
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072 backing_file=TEST_DIR/t.IMGFMT.backing
+# Fill all clusters with data and then discard them
+wrote 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+discard 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+# Read the data from the discarded clusters
+read 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+# Create an image with compat=1.1 and a backing file
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072 backing_file=TEST_DIR/t.IMGFMT.backing
+# Fill all clusters with data and then discard them
+wrote 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+discard 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+# Read the data from the discarded clusters
+read 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index ec2b2302e5..891b3ce858 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -295,3 +295,4 @@
 284 rw
 286 rw quick
 288 quick
+289 rw auto quick
-- 
2.20.1


