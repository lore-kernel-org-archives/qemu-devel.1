Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA31BC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:54:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80DBD2085A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80DBD2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58808 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOnFf-0003qa-O7
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:54:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hOnDx-0002pS-IM
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:52:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hOnDw-0006GF-3G
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:52:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hOnDs-0006Dy-MU; Thu, 09 May 2019 13:52:48 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 06CAAC066455;
	Thu,  9 May 2019 17:52:48 +0000 (UTC)
Received: from localhost (ovpn-204-168.brq.redhat.com [10.40.204.168])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 05A3960CC0;
	Thu,  9 May 2019 17:52:45 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu,  9 May 2019 19:52:37 +0200
Message-Id: <20190509175237.19363-4-mreitz@redhat.com>
In-Reply-To: <20190509175237.19363-1-mreitz@redhat.com>
References: <20190509175237.19363-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Thu, 09 May 2019 17:52:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 3/3] iotests: Add test for rebase without
 input base
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds a test for rebasing an image that currently does not
have a backing file.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/252     | 124 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/252.out |  39 ++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 164 insertions(+)
 create mode 100755 tests/qemu-iotests/252
 create mode 100644 tests/qemu-iotests/252.out

diff --git a/tests/qemu-iotests/252 b/tests/qemu-iotests/252
new file mode 100755
index 0000000000..f6c8f71444
--- /dev/null
+++ b/tests/qemu-iotests/252
@@ -0,0 +1,124 @@
+#!/usr/bin/env bash
+#
+# Tests for rebasing COW images that require zero cluster support
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
+    rm -f "$TEST_IMG.base_new"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+. ./common.pattern
+
+# Currently only qcow2 and qed support rebasing, and only qcow2 v3 has
+# zero cluster support
+_supported_fmt qcow2
+_unsupported_imgopts 'compat=3D0.10'
+_supported_proto file
+_supported_os Linux
+
+CLUSTER_SIZE=3D65536
+
+echo
+echo "=3D=3D=3D Test rebase without input base =3D=3D=3D"
+echo
+
+# Cluster allocations to be tested:
+#
+# Backing (new) 11 -- 11 -- 11 --
+# COW image     22 22 11 11 -- --
+#
+# Expected result:
+#
+# COW image     22 22 11 11 00 --
+#
+# (Cluster 2 might be "--" after the rebase, too, but rebase just
+#  compares the new backing file to the old one and disregards the
+#  overlay.  Therefore, it will never discard overlay clusters.)
+
+_make_test_img $((6 * CLUSTER_SIZE))
+TEST_IMG=3D"$TEST_IMG.base_new" _make_test_img $((6 * CLUSTER_SIZE))
+
+echo
+
+$QEMU_IO "$TEST_IMG" \
+    -c "write -P 0x22 $((0 * CLUSTER_SIZE)) $((2 * CLUSTER_SIZE))" \
+    -c "write -P 0x11 $((2 * CLUSTER_SIZE)) $((2 * CLUSTER_SIZE))" \
+    | _filter_qemu_io
+
+$QEMU_IO "$TEST_IMG.base_new" \
+    -c "write -P 0x11 $((0 * CLUSTER_SIZE)) $CLUSTER_SIZE" \
+    -c "write -P 0x11 $((2 * CLUSTER_SIZE)) $CLUSTER_SIZE" \
+    -c "write -P 0x11 $((4 * CLUSTER_SIZE)) $CLUSTER_SIZE" \
+    | _filter_qemu_io
+
+echo
+
+# This should be a no-op
+$QEMU_IMG rebase -b "" "$TEST_IMG"
+
+# Verify the data is correct
+$QEMU_IO "$TEST_IMG" \
+    -c "read -P 0x22 $((0 * CLUSTER_SIZE)) $((2 * CLUSTER_SIZE))" \
+    -c "read -P 0x11 $((2 * CLUSTER_SIZE)) $((2 * CLUSTER_SIZE))" \
+    -c "read -P 0x00 $((4 * CLUSTER_SIZE)) $((2 * CLUSTER_SIZE))" \
+    | _filter_qemu_io
+
+echo
+
+# Verify the allocation status (first four cluster should be allocated
+# in TEST_IMG, clusters 4 and 5 should be unallocated (marked as zero
+# clusters here because there is no backing file))
+$QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
+
+echo
+
+$QEMU_IMG rebase -b "$TEST_IMG.base_new" "$TEST_IMG"
+
+# Verify the data is correct
+$QEMU_IO "$TEST_IMG" \
+    -c "read -P 0x22 $((0 * CLUSTER_SIZE)) $((2 * CLUSTER_SIZE))" \
+    -c "read -P 0x11 $((2 * CLUSTER_SIZE)) $((2 * CLUSTER_SIZE))" \
+    -c "read -P 0x00 $((4 * CLUSTER_SIZE)) $((2 * CLUSTER_SIZE))" \
+    | _filter_qemu_io
+
+echo
+
+# Verify the allocation status (first four cluster should be allocated
+# in TEST_IMG, cluster 4 should be zero, and cluster 5 should be
+# unallocated (signified by '"depth": 1'))
+$QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
+
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/252.out b/tests/qemu-iotests/252.out
new file mode 100644
index 0000000000..12dce889f8
--- /dev/null
+++ b/tests/qemu-iotests/252.out
@@ -0,0 +1,39 @@
+QA output created by 252
+
+=3D=3D=3D Test rebase without input base =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D393216
+Formatting 'TEST_DIR/t.IMGFMT.base_new', fmt=3DIMGFMT size=3D393216
+
+wrote 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 131072
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 131072
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 262144
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+read 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 131072/131072 bytes at offset 131072
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 131072/131072 bytes at offset 262144
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+[{ "start": 0, "length": 262144, "depth": 0, "zero": false, "data": true=
, "offset": OFFSET},
+{ "start": 262144, "length": 131072, "depth": 0, "zero": true, "data": f=
alse}]
+
+read 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 131072/131072 bytes at offset 131072
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 131072/131072 bytes at offset 262144
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+[{ "start": 0, "length": 262144, "depth": 0, "zero": false, "data": true=
, "offset": OFFSET},
+{ "start": 262144, "length": 65536, "depth": 0, "zero": true, "data": fa=
lse},
+{ "start": 327680, "length": 65536, "depth": 1, "zero": true, "data": fa=
lse}]
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 7ac9a5ea4a..00e474ab0a 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -249,3 +249,4 @@
 247 rw auto quick
 248 rw auto quick
 249 rw auto quick
+252 rw auto backing quick
--=20
2.21.0


