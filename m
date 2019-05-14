Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B327C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 21:45:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A257F20879
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 21:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A257F20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55116 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQfEw-0001pa-Vf
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 17:45:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hQfCC-0008NC-0x
	for qemu-devel@nongnu.org; Tue, 14 May 2019 17:42:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hQfC9-00075S-Sr
	for qemu-devel@nongnu.org; Tue, 14 May 2019 17:42:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hQfC3-0006kg-8R; Tue, 14 May 2019 17:42:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5BDE43082129;
	Tue, 14 May 2019 21:42:38 +0000 (UTC)
Received: from localhost (unknown [10.40.205.236])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E3CF05D6A6;
	Tue, 14 May 2019 21:42:37 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 14 May 2019 23:42:30 +0200
Message-Id: <20190514214230.22601-3-mreitz@redhat.com>
In-Reply-To: <20190514214230.22601-1-mreitz@redhat.com>
References: <20190514214230.22601-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Tue, 14 May 2019 21:42:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/2] iotests: Test unaligned raw images with
 O_DIRECT
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already have 221 for accesses through the page cache, but it is
better to create a new file for O_DIRECT instead of integrating those
test cases into 221.  This way, we can make use of
_supported_cache_modes (and _default_cache_mode) so the test is
automatically skipped on filesystems that do not support O_DIRECT.

As part of the split, add _supported_cache_modes to 221.  With that, it
no longer fails when run with -c none or -c directsync.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/221     |  4 ++
 tests/qemu-iotests/253     | 84 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/253.out | 14 +++++++
 tests/qemu-iotests/group   |  1 +
 4 files changed, 103 insertions(+)
 create mode 100755 tests/qemu-iotests/253
 create mode 100644 tests/qemu-iotests/253.out

diff --git a/tests/qemu-iotests/221 b/tests/qemu-iotests/221
index 25dd47bcfe..0e9096fec7 100755
--- a/tests/qemu-iotests/221
+++ b/tests/qemu-iotests/221
@@ -1,6 +1,7 @@
 #!/usr/bin/env bash
 #
 # Test qemu-img vs. unaligned images
+# (See also 253, which is the O_DIRECT version)
 #
 # Copyright (C) 2018-2019 Red Hat, Inc.
 #
@@ -37,6 +38,9 @@ _supported_fmt raw
 _supported_proto file
 _supported_os Linux
=20
+_default_cache_mode writeback
+_supported_cache_modes writeback writethrough unsafe
+
 echo
 echo "=3D=3D=3D Check mapping of unaligned raw image =3D=3D=3D"
 echo
diff --git a/tests/qemu-iotests/253 b/tests/qemu-iotests/253
new file mode 100755
index 0000000000..d88d5afa45
--- /dev/null
+++ b/tests/qemu-iotests/253
@@ -0,0 +1,84 @@
+#!/usr/bin/env bash
+#
+# Test qemu-img vs. unaligned images; O_DIRECT version
+# (Originates from 221)
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
+seq=3D"$(basename $0)"
+echo "QA output created by $seq"
+
+status=3D1 # failure is the default!
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
+_supported_fmt raw
+_supported_proto file
+_supported_os Linux
+
+_default_cache_mode none
+_supported_cache_modes none directsync
+
+echo
+echo "=3D=3D=3D Check mapping of unaligned raw image =3D=3D=3D"
+echo
+
+# We do not know how large a physical sector is, but it is certainly
+# going to be a factor of 1 MB
+size=3D$((1 * 1024 * 1024 - 1))
+
+# qemu-img create rounds size up to BDRV_SECTOR_SIZE
+_make_test_img $size
+$QEMU_IMG map --output=3Djson --image-opts \
+    "driver=3D$IMGFMT,file.driver=3Dfile,file.filename=3D$TEST_IMG,cache=
.direct=3Don" \
+    | _filter_qemu_img_map
+
+# so we resize it and check again
+truncate --size=3D$size "$TEST_IMG"
+$QEMU_IMG map --output=3Djson --image-opts \
+    "driver=3D$IMGFMT,file.driver=3Dfile,file.filename=3D$TEST_IMG,cache=
.direct=3Don" \
+    | _filter_qemu_img_map
+
+# qemu-io with O_DIRECT always writes whole physical sectors.  Again,
+# we do not know how large a physical sector is, so we just start
+# writing from a 64 kB boundary, which should always be aligned.
+offset=3D$((1 * 1024 * 1024 - 64 * 1024))
+$QEMU_IO -c "w $offset $((size - offset))" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG map --output=3Djson --image-opts \
+    "driver=3D$IMGFMT,file.driver=3Dfile,file.filename=3D$TEST_IMG,cache=
.direct=3Don" \
+    | _filter_qemu_img_map
+
+# Resize it and check again -- contrary to 221, we may not get partial
+# sectors here, so there should be only two areas (one zero, one
+# data).
+truncate --size=3D$size "$TEST_IMG"
+$QEMU_IMG map --output=3Djson --image-opts \
+    "driver=3D$IMGFMT,file.driver=3Dfile,file.filename=3D$TEST_IMG,cache=
.direct=3Don" \
+    | _filter_qemu_img_map
+
+# success, all done
+echo '*** done'
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/253.out b/tests/qemu-iotests/253.out
new file mode 100644
index 0000000000..607c0baa0b
--- /dev/null
+++ b/tests/qemu-iotests/253.out
@@ -0,0 +1,14 @@
+QA output created by 253
+
+=3D=3D=3D Check mapping of unaligned raw image =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048575
+[{ "start": 0, "length": 1048576, "depth": 0, "zero": true, "data": fals=
e, "offset": OFFSET}]
+[{ "start": 0, "length": 1048576, "depth": 0, "zero": true, "data": fals=
e, "offset": OFFSET}]
+wrote 65535/65535 bytes at offset 983040
+63.999 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[{ "start": 0, "length": 983040, "depth": 0, "zero": true, "data": false=
, "offset": OFFSET},
+{ "start": 983040, "length": 65536, "depth": 0, "zero": false, "data": t=
rue, "offset": OFFSET}]
+[{ "start": 0, "length": 983040, "depth": 0, "zero": true, "data": false=
, "offset": OFFSET},
+{ "start": 983040, "length": 65536, "depth": 0, "zero": false, "data": t=
rue, "offset": OFFSET}]
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 00e474ab0a..52b7c16e15 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -250,3 +250,4 @@
 248 rw auto quick
 249 rw auto quick
 252 rw auto backing quick
+253 rw auto quick
--=20
2.21.0


