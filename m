Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536C3C2BB54
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 12:39:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10C0C20719
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 12:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cluc/4mC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C0C20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLnVV-0000oO-6N
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 08:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jLnUA-0007We-1u
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jLnU4-0006gS-8n
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:37:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51776
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jLnU4-0006fz-5L
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586263059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kPwJwHZ3z+OCT5TCFv67flN31A3zPAPnGveuGE9sJE4=;
 b=cluc/4mCRLulvvC1FfBgH6OteuhdznnEga9NI5da2xvY5q0bfv2aXdROzjdPvrUg7omGQZ
 IDBNwtoZuslfkjae7Y4e7wuyR+5CzkMR4tBjHLLVcvfn20cTPkVJ8bftapEmCKqIgYjMYV
 qS1/lmvdnhmtqnsbjCCHQEmT9bgJccE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-XcERFCZgO0SkKMFjTCHTag-1; Tue, 07 Apr 2020 08:37:34 -0400
X-MC-Unique: XcERFCZgO0SkKMFjTCHTag-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 330588017F6;
 Tue,  7 Apr 2020 12:37:33 +0000 (UTC)
Received: from localhost (ovpn-114-84.ams2.redhat.com [10.36.114.84])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 24FB75DA7C;
 Tue,  7 Apr 2020 12:37:31 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 1/5] qcow2: Forbid discard in qcow2 v2 images with backing files
Date: Tue,  7 Apr 2020 14:37:23 +0200
Message-Id: <20200407123727.829933-2-mreitz@redhat.com>
In-Reply-To: <20200407123727.829933-1-mreitz@redhat.com>
References: <20200407123727.829933-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

From: Alberto Garcia <berto@igalia.com>

A discard request deallocates the selected clusters so they read back
as zeroes. This is done by clearing the cluster offset field and
setting QCOW_OFLAG_ZERO in the L2 entry.

This flag is however only supported when qcow_version >=3D 3. In older
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
Message-Id: <20200331114345.29993-1-berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c              |  6 +++
 tests/qemu-iotests/046     | 10 ++--
 tests/qemu-iotests/046.out | 12 +++--
 tests/qemu-iotests/060     | 12 ++---
 tests/qemu-iotests/060.out |  2 -
 tests/qemu-iotests/177     |  5 +-
 tests/qemu-iotests/290     | 97 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/290.out | 61 ++++++++++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 9 files changed, 187 insertions(+), 19 deletions(-)
 create mode 100755 tests/qemu-iotests/290
 create mode 100644 tests/qemu-iotests/290.out

diff --git a/block/qcow2.c b/block/qcow2.c
index 2bb536b014..e8cbcc1ec1 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3784,6 +3784,12 @@ static coroutine_fn int qcow2_co_pdiscard(BlockDrive=
rState *bs,
     int ret;
     BDRVQcow2State *s =3D bs->opaque;
=20
+    /* If the image does not support QCOW_OFLAG_ZERO then discarding
+     * clusters could expose stale data from the backing file. */
+    if (s->qcow_version < 3 && bs->backing) {
+        return -ENOTSUP;
+    }
+
     if (!QEMU_IS_ALIGNED(offset | bytes, s->cluster_size)) {
         assert(bytes < s->cluster_size);
         /* Ignore partial clusters, except for the special case of the
diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
index a066eec605..ecbe5fc0f4 100755
--- a/tests/qemu-iotests/046
+++ b/tests/qemu-iotests/046
@@ -193,8 +193,8 @@ echo "=3D=3D Verify image content =3D=3D"
 verify_io()
 {
     if ($QEMU_IMG info -U -f "$IMGFMT" "$TEST_IMG" | grep "compat: 0.10" >=
 /dev/null); then
-        # For v2 images, discarded clusters are read from the backing file
-        # Keep the variable empty so that the backing file value can be us=
ed as
+        # In v2 images clusters are not discarded when there is a backing =
file.
+        # Keep the variable empty so that the previous value can be used a=
s
         # the default below
         discarded=3D
     else
@@ -230,14 +230,16 @@ verify_io()
     echo read -P 70 0x78000 0x6000
     echo read -P 7  0x7e000 0x2000
=20
-    echo read -P ${discarded:-8} 0x80000 0x6000
+    echo read -P ${discarded:-89} 0x80000 0x1000
+    echo read -P ${discarded:-8} 0x81000 0x5000
     echo read -P 80 0x86000 0x2000
     echo read -P ${discarded:-8} 0x88000 0x2000
     echo read -P 81 0x8a000 0xe000
     echo read -P 90 0x98000 0x6000
     echo read -P 9  0x9e000 0x2000
=20
-    echo read -P ${discarded:-10} 0xa0000 0x6000
+    echo read -P ${discarded:-109} 0xa0000 0x1000
+    echo read -P ${discarded:-10} 0xa1000 0x5000
     echo read -P 100 0xa6000 0x2000
     echo read -P ${discarded:-10} 0xa8000 0x2000
     echo read -P 101 0xaa000 0xe000
diff --git a/tests/qemu-iotests/046.out b/tests/qemu-iotests/046.out
index ca2c7404a9..70783041e2 100644
--- a/tests/qemu-iotests/046.out
+++ b/tests/qemu-iotests/046.out
@@ -187,8 +187,10 @@ read 24576/24576 bytes at offset 491520
 24 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 8192/8192 bytes at offset 516096
 8 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 24576/24576 bytes at offset 524288
-24 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4096/4096 bytes at offset 524288
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 20480/20480 bytes at offset 528384
+20 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 8192/8192 bytes at offset 548864
 8 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 8192/8192 bytes at offset 557056
@@ -199,8 +201,10 @@ read 24576/24576 bytes at offset 622592
 24 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 8192/8192 bytes at offset 647168
 8 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 24576/24576 bytes at offset 655360
-24 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4096/4096 bytes at offset 655360
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 20480/20480 bytes at offset 659456
+20 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 8192/8192 bytes at offset 679936
 8 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 8192/8192 bytes at offset 688128
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index 043f12904a..32c0ecce9e 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -160,18 +160,16 @@ TEST_IMG=3D$BACKING_IMG _make_test_img 1G
=20
 $QEMU_IO -c 'write 0k 64k' "$BACKING_IMG" | _filter_qemu_io
=20
-# compat=3D0.10 is required in order to make the following discard actuall=
y
-# unallocate the sector rather than make it a zero sector - we want COW, a=
fter
-# all.
-_make_test_img -o 'compat=3D0.10' -b "$BACKING_IMG" 1G
+_make_test_img -b "$BACKING_IMG" 1G
 # Write two clusters, the second one enforces creation of an L2 table afte=
r
 # the first data cluster.
 $QEMU_IO -c 'write 0k 64k' -c 'write 512M 64k' "$TEST_IMG" | _filter_qemu_=
io
-# Discard the first cluster. This cluster will soon enough be reallocated =
and
+# Free the first cluster. This cluster will soon enough be reallocated and
 # used for COW.
-$QEMU_IO -c 'discard 0k 64k' "$TEST_IMG" | _filter_qemu_io
+poke_file "$TEST_IMG" "$l2_offset" "\x00\x00\x00\x00\x00\x00\x00\x00"
+poke_file "$TEST_IMG" "$(($rb_offset+10))" "\x00\x00"
 # Now, corrupt the image by marking the second L2 table cluster as free.
-poke_file "$TEST_IMG" '131084' "\x00\x00" # 0x2000c
+poke_file "$TEST_IMG" "$(($rb_offset+12))" "\x00\x00"
 # Start a write operation requiring COW on the image stopping it right bef=
ore
 # doing the read; then, trigger the corruption prevention by writing anyth=
ing to
 # any unallocated cluster, leading to an attempt to overwrite the second L=
2
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
 qcow2: Marking image as corrupt: Preventing invalid write on metadata (ove=
rlaps with active L2 table); further corruption events will be suppressed
 blkdebug: Suspended request '0'
 write failed: Input/output error
diff --git a/tests/qemu-iotests/177 b/tests/qemu-iotests/177
index 752d29f8ad..eadc2c7ef6 100755
--- a/tests/qemu-iotests/177
+++ b/tests/qemu-iotests/177
@@ -89,8 +89,9 @@ verify_io()
 {
     if ($QEMU_IMG info -f "$IMGFMT" "$TEST_IMG" |
 =09    grep "compat: 0.10" > /dev/null); then
-        # For v2 images, discarded clusters are read from the backing file
-        discarded=3D11
+        # In v2 images clusters are not discarded when there is a backing =
file
+        # so the previous value is read
+        discarded=3D22
     else
         # Discarded clusters are zeroed for v3 or later
         discarded=3D0
diff --git a/tests/qemu-iotests/290 b/tests/qemu-iotests/290
new file mode 100755
index 0000000000..776b65e915
--- /dev/null
+++ b/tests/qemu-iotests/290
@@ -0,0 +1,97 @@
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
+owner=3Dberto@igalia.com
+
+seq=3D`basename $0`
+echo "QA output created by $seq"
+
+status=3D1    # failure is the default!
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
+_unsupported_imgopts 'compat=3D0.10' refcount_bits data_file
+
+echo
+echo "### Test 'qemu-io -c discard' on a QCOW2 image without a backing fil=
e"
+echo
+for qcow2_compat in 0.10 1.1; do
+    echo "# Create an image with compat=3D$qcow2_compat without a backing =
file"
+    _make_test_img -o "compat=3D$qcow2_compat" 128k
+
+    echo "# Fill all clusters with data and then discard them"
+    $QEMU_IO -c 'write -P 0x01 0 128k' "$TEST_IMG" | _filter_qemu_io
+    $QEMU_IO -c 'discard 0 128k' "$TEST_IMG" | _filter_qemu_io
+
+    echo "# Read the data from the discarded clusters"
+    $QEMU_IO -c 'read -P 0x00 0 128k' "$TEST_IMG" | _filter_qemu_io
+
+    echo "# Output of qemu-img map"
+    $QEMU_IMG map "$TEST_IMG" | _filter_testdir
+done
+
+echo
+echo "### Test 'qemu-io -c discard' on a QCOW2 image with a backing file"
+echo
+
+echo "# Create a backing image and fill it with data"
+BACKING_IMG=3D"$TEST_IMG.base"
+TEST_IMG=3D"$BACKING_IMG" _make_test_img 128k
+$QEMU_IO -c 'write -P 0xff 0 128k' "$BACKING_IMG" | _filter_qemu_io
+
+for qcow2_compat in 0.10 1.1; do
+    echo "# Create an image with compat=3D$qcow2_compat and a backing file=
"
+    _make_test_img -o "compat=3D$qcow2_compat" -b "$BACKING_IMG"
+
+    echo "# Fill all clusters with data and then discard them"
+    $QEMU_IO -c 'write -P 0x01 0 128k' "$TEST_IMG" | _filter_qemu_io
+    $QEMU_IO -c 'discard 0 128k' "$TEST_IMG" | _filter_qemu_io
+
+    echo "# Read the data from the discarded clusters"
+    if [ "$qcow2_compat" =3D "1.1" ]; then
+        # In qcow2 v3 clusters are zeroed (with QCOW_OFLAG_ZERO)
+        $QEMU_IO -c 'read -P 0x00 0 128k' "$TEST_IMG" | _filter_qemu_io
+    else
+        # In qcow2 v2 if there's a backing image we cannot zero the cluste=
rs
+        # without exposing the backing file data so discard does nothing
+        $QEMU_IO -c 'read -P 0x01 0 128k' "$TEST_IMG" | _filter_qemu_io
+    fi
+
+    echo "# Output of qemu-img map"
+    $QEMU_IMG map "$TEST_IMG" | _filter_testdir
+done
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/290.out b/tests/qemu-iotests/290.out
new file mode 100644
index 0000000000..d2259c823b
--- /dev/null
+++ b/tests/qemu-iotests/290.out
@@ -0,0 +1,61 @@
+QA output created by 290
+
+### Test 'qemu-io -c discard' on a QCOW2 image without a backing file
+
+# Create an image with compat=3D0.10 without a backing file
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D131072
+# Fill all clusters with data and then discard them
+wrote 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+discard 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+# Read the data from the discarded clusters
+read 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+# Output of qemu-img map
+Offset          Length          Mapped to       File
+# Create an image with compat=3D1.1 without a backing file
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D131072
+# Fill all clusters with data and then discard them
+wrote 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+discard 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+# Read the data from the discarded clusters
+read 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+# Output of qemu-img map
+Offset          Length          Mapped to       File
+
+### Test 'qemu-io -c discard' on a QCOW2 image with a backing file
+
+# Create a backing image and fill it with data
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D131072
+wrote 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+# Create an image with compat=3D0.10 and a backing file
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D131072 backing_file=3D=
TEST_DIR/t.IMGFMT.base
+# Fill all clusters with data and then discard them
+wrote 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+discard 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+# Read the data from the discarded clusters
+read 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+# Output of qemu-img map
+Offset          Length          Mapped to       File
+0               0x20000         0x50000         TEST_DIR/t.qcow2
+# Create an image with compat=3D1.1 and a backing file
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D131072 backing_file=3D=
TEST_DIR/t.IMGFMT.base
+# Fill all clusters with data and then discard them
+wrote 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+discard 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+# Read the data from the discarded clusters
+read 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+# Output of qemu-img map
+Offset          Length          Mapped to       File
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 79c6dfc85d..435dccd5af 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -296,3 +296,4 @@
 286 rw quick
 288 quick
 289 rw quick
+290 rw auto quick
--=20
2.25.1


