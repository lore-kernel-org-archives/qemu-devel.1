Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FDAC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 12:48:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF15624958
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 12:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LJ7etlbz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF15624958
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX2QT-0001qW-UJ
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 08:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jX2KT-0000BY-33
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:42:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56419
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jX2KJ-000811-R8
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588941722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VU35HL7Kt/PANqyfGEQrVVdvjFyxS/KVnRk+45l3dHI=;
 b=LJ7etlbzAAwLVMGsubf56PGqqz/GaYVhyNjUotNF1pZGpR+0NlhQTDLNizGWHfk3qa4yOi
 qHz4tTHq8IhmnZ8nmI+bItnY90sw/GNu1lK31DyqX5TThq3wYlXu6wj5H32tOxSFUTypRb
 Koxde1Vud9cH/Ntjq6htzkfY4U++l7M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-HGYlrAGeO9KAZ3GKQBoAxQ-1; Fri, 08 May 2020 08:41:55 -0400
X-MC-Unique: HGYlrAGeO9KAZ3GKQBoAxQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C8FE46B;
 Fri,  8 May 2020 12:41:54 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-190.ams2.redhat.com
 [10.36.113.190])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2BBFD19167;
 Fri,  8 May 2020 12:41:53 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 09/30] qcow2: Avoid integer wraparound in qcow2_co_truncate()
Date: Fri,  8 May 2020 14:41:14 +0200
Message-Id: <20200508124135.252565-10-kwolf@redhat.com>
In-Reply-To: <20200508124135.252565-1-kwolf@redhat.com>
References: <20200508124135.252565-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 08:00:48
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

From: Alberto Garcia <berto@igalia.com>

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
Message-Id: <20200504155217.10325-1-berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c              | 12 ++++---
 tests/qemu-iotests/292     | 73 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/292.out | 24 +++++++++++++
 tests/qemu-iotests/group   |  1 +
 4 files changed, 105 insertions(+), 5 deletions(-)
 create mode 100755 tests/qemu-iotests/292
 create mode 100644 tests/qemu-iotests/292.out

diff --git a/block/qcow2.c b/block/qcow2.c
index ad934109a8..fc7d4b185e 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4242,15 +4242,17 @@ static int coroutine_fn qcow2_co_truncate(BlockDriv=
erState *bs, int64_t offset,
          * requires a cluster-aligned start. The end may be unaligned if i=
t is
          * at the end of the image (which it is here).
          */
-        ret =3D qcow2_cluster_zeroize(bs, zero_start, offset - zero_start,=
 0);
-        if (ret < 0) {
-            error_setg_errno(errp, -ret, "Failed to zero out new clusters"=
);
-            goto fail;
+        if (offset > zero_start) {
+            ret =3D qcow2_cluster_zeroize(bs, zero_start, offset - zero_st=
art, 0);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "Failed to zero out new clust=
ers");
+                goto fail;
+            }
         }
=20
         /* Write explicit zeros for the unaligned head */
         if (zero_start > old_length) {
-            uint64_t len =3D zero_start - old_length;
+            uint64_t len =3D MIN(zero_start, offset) - old_length;
             uint8_t *buf =3D qemu_blockalign0(bs, len);
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
+
+echo '### Create the backing image'
+BACKING_IMG=3D"$TEST_IMG.base"
+TEST_IMG=3D"$BACKING_IMG" _make_test_img 1M
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
+status=3D0
diff --git a/tests/qemu-iotests/292.out b/tests/qemu-iotests/292.out
new file mode 100644
index 0000000000..807e0530c3
--- /dev/null
+++ b/tests/qemu-iotests/292.out
@@ -0,0 +1,24 @@
+QA output created by 292
+### Create the backing image
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D1048576
+### Fill the backing image with data (0x11)
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+### Create the top image
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
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
--=20
2.25.3


