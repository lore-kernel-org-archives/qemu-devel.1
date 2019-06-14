Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EE4C31E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:09:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 032B421537
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032B421537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51866 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbmtb-0007bk-9K
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 10:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46984)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbmSt-00027R-Mj
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:42:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbmSr-0006dv-Lh
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:41:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40828)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbmSU-0006GF-Bv; Fri, 14 Jun 2019 09:41:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6F7C8C04D318;
 Fri, 14 Jun 2019 13:41:15 +0000 (UTC)
Received: from localhost (unknown [10.40.205.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC9145D9C3;
 Fri, 14 Jun 2019 13:41:14 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 14 Jun 2019 15:40:20 +0200
Message-Id: <20190614134021.32486-20-mreitz@redhat.com>
In-Reply-To: <20190614134021.32486-1-mreitz@redhat.com>
References: <20190614134021.32486-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 14 Jun 2019 13:41:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 19/20] iotests: Test qemu-img convert --salvage
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

This test converts a simple image to another, but blkdebug injects
block_status and read faults at some offsets.  The resulting image
should be the same as the input image, except that sectors that could
not be read have to be 0.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190507203508.18026-7-mreitz@redhat.com
Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
[mreitz: Dropped superfluous printf from _filter_offsets, as suggested
         by Vladimir; disable test for VDI and IMGOPTSSYNTAX]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/251     | 170 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/251.out |  43 ++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 214 insertions(+)
 create mode 100755 tests/qemu-iotests/251
 create mode 100644 tests/qemu-iotests/251.out

diff --git a/tests/qemu-iotests/251 b/tests/qemu-iotests/251
new file mode 100755
index 0000000000..13f85de9cd
--- /dev/null
+++ b/tests/qemu-iotests/251
@@ -0,0 +1,170 @@
+#!/usr/bin/env bash
+#
+# Test qemu-img convert --salvage
+#
+# Copyright (C) 2019 Red Hat, Inc.
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
+owner=3Dmreitz@redhat.com
+
+seq=3D$(basename $0)
+echo "QA output created by $seq"
+
+status=3D1	# failure is the default!
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
+. ./common.qemu
+
+_supported_fmt generic
+_supported_proto file
+_supported_os Linux
+
+if [ "$IMGOPTSSYNTAX" =3D "true" ]; then
+    # We use json:{} filenames here, so we cannot work with additional o=
ptions.
+    _unsupported_fmt $IMGFMT
+else
+    # With VDI, the output is ordered differently.  Just disable it.
+    _unsupported_fmt vdi
+fi
+
+
+TEST_IMG=3D"$TEST_IMG.orig" _make_test_img 64M
+
+$QEMU_IO -c 'write -P 42 0 64M' "$TEST_IMG.orig" | _filter_qemu_io
+
+
+sector_size=3D512
+
+# Offsets on which to fail block-status.  Keep in ascending order so
+# the indexing done by _filter_offsets will appear in ascending order
+# in the output as well.
+status_fail_offsets=3D"$((16 * 1024 * 1024 + 8192))
+                     $((33 * 1024 * 1024 + 512))"
+
+# Offsets on which to fail reads.  Keep in ascending order for the
+# same reason.
+# The second element is shared with $status_fail_offsets on purpose.
+# Starting with the third element, we test what happens when a
+# continuous range of sectors is inaccessible.
+read_fail_offsets=3D"$((32 * 1024 * 1024 - 65536))
+                   $((33 * 1024 * 1024 + 512))
+                   $(seq $((34 * 1024 * 1024)) $sector_size \
+                         $((34 * 1024 * 1024 + 4096 - $sector_size)))"
+
+
+# blkdebug must be above the format layer so it can intercept all
+# block-status events
+source_img=3D"json:{'driver': 'blkdebug',
+                  'image': {
+                      'driver': '$IMGFMT',
+                      'file': {
+                          'driver': 'file',
+                          'filename': '$TEST_IMG.orig'
+                      }
+                  },
+                  'inject-error': ["
+
+for ofs in $status_fail_offsets
+do
+    source_img+=3D"{ 'event': 'none',
+                   'iotype': 'block-status',
+                   'errno': 5,
+                   'sector': $((ofs / sector_size)) },"
+done
+
+for ofs in $read_fail_offsets
+do
+    source_img+=3D"{ 'event': 'none',
+                   'iotype': 'read',
+                   'errno': 5,
+                   'sector': $((ofs / sector_size)) },"
+done
+
+# Remove the trailing comma and terminate @inject-error and json:{}
+source_img=3D"${source_img%,} ] }"
+
+
+echo
+
+
+_filter_offsets() {
+    filters=3D
+
+    index=3D0
+    for ofs in $1
+    do
+        filters+=3D" -e s/$ofs/status_fail_offset_$index/"
+        index=3D$((index + 1))
+    done
+
+    index=3D0
+    for ofs in $2
+    do
+        filters+=3D" -e s/$ofs/read_fail_offset_$index/"
+        index=3D$((index + 1))
+    done
+
+    sed $filters
+}
+
+# While determining the number of allocated sectors in the input
+# image, we should see one block status warning per element of
+# $status_fail_offsets.
+#
+# Then, the image is read.  Since the block status is queried in
+# basically the same way, the same warnings as in the previous step
+# should reappear.  Interleaved with those we should see a read
+# warning per element of $read_fail_offsets.
+# Note that $read_fail_offsets and $status_fail_offsets share an
+# element (read_fail_offset_1 =3D=3D status_fail_offset_1), so
+# "status_fail_offset_1" in the output is the same as
+# "read_fail_offset_1".
+$QEMU_IMG convert --salvage "$source_img" "$TEST_IMG" 2>&1 \
+    | _filter_offsets "$status_fail_offsets" "$read_fail_offsets"
+
+echo
+
+# The offsets where the block status could not be determined should
+# have been treated as containing data and thus should be correct in
+# the output image.
+# The offsets where reading failed altogether should be 0.  Make them
+# 0 in the input image, too, so we can compare both images.
+for ofs in $read_fail_offsets
+do
+    $QEMU_IO -c "write -z $ofs $sector_size" "$TEST_IMG.orig" \
+        | _filter_qemu_io \
+        | _filter_offsets '' "$read_fail_offsets"
+done
+
+echo
+
+# These should be equal now.
+$QEMU_IMG compare "$TEST_IMG.orig" "$TEST_IMG"
+
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/251.out b/tests/qemu-iotests/251.out
new file mode 100644
index 0000000000..75b8796aad
--- /dev/null
+++ b/tests/qemu-iotests/251.out
@@ -0,0 +1,43 @@
+QA output created by 251
+Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=3DIMGFMT size=3D67108864
+wrote 67108864/67108864 bytes at offset 0
+64 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+qemu-img: warning: error while reading block status at offset status_fai=
l_offset_0: Input/output error
+qemu-img: warning: error while reading block status at offset status_fai=
l_offset_1: Input/output error
+qemu-img: warning: error while reading block status at offset status_fai=
l_offset_0: Input/output error
+qemu-img: warning: error while reading offset read_fail_offset_0: Input/=
output error
+qemu-img: warning: error while reading block status at offset status_fai=
l_offset_1: Input/output error
+qemu-img: warning: error while reading offset status_fail_offset_1: Inpu=
t/output error
+qemu-img: warning: error while reading offset read_fail_offset_2: Input/=
output error
+qemu-img: warning: error while reading offset read_fail_offset_3: Input/=
output error
+qemu-img: warning: error while reading offset read_fail_offset_4: Input/=
output error
+qemu-img: warning: error while reading offset read_fail_offset_5: Input/=
output error
+qemu-img: warning: error while reading offset read_fail_offset_6: Input/=
output error
+qemu-img: warning: error while reading offset read_fail_offset_7: Input/=
output error
+qemu-img: warning: error while reading offset read_fail_offset_8: Input/=
output error
+qemu-img: warning: error while reading offset read_fail_offset_9: Input/=
output error
+
+wrote 512/512 bytes at offset read_fail_offset_0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset read_fail_offset_1
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset read_fail_offset_2
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset read_fail_offset_3
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset read_fail_offset_4
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset read_fail_offset_5
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset read_fail_offset_6
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset read_fail_offset_7
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset read_fail_offset_8
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset read_fail_offset_9
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+Images are identical.
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 0842167b7b..b34c8e3c0c 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -263,6 +263,7 @@
 248 rw quick
 249 rw auto quick
 250 rw auto quick
+251 rw auto quick
 252 rw auto backing quick
 253 rw auto quick
 254 rw auto backing quick
--=20
2.21.0


