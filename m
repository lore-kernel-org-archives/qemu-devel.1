Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AE9C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 10:10:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 576ED208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 10:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576ED208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIVOw-0005NV-CC
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 06:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41106)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIVNg-00042k-R1
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 06:09:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIVNf-0006BG-5l
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 06:09:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60730)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIVNb-00069u-KL; Thu, 10 Oct 2019 06:09:07 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DAD2C30BCBA0;
 Thu, 10 Oct 2019 10:09:06 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 60C1319D70;
 Thu, 10 Oct 2019 10:09:06 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/2] iotests: Test large write request to qcow2 file
Date: Thu, 10 Oct 2019 12:08:58 +0200
Message-Id: <20191010100858.1261-3-mreitz@redhat.com>
In-Reply-To: <20191010100858.1261-1-mreitz@redhat.com>
References: <20191010100858.1261-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 10 Oct 2019 10:09:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Without HEAD^, the following happens when you attempt a large write
request to a qcow2 file such that the number of bytes covered by all
clusters involved in a single allocation will exceed INT_MAX:

(A) handle_alloc_space() decides to fill the whole area with zeroes and
    fails because bdrv_co_pwrite_zeroes() fails (the request is too
    large).

(B) If handle_alloc_space() does not do anything, but merge_cow()
    decides that the requests can be merged, it will create a too long
    IOV that later cannot be written.

(C) Otherwise, all parts will be written separately, so those requests
    will work.

In either B or C, though, qcow2_alloc_cluster_link_l2() will have an
overflow: We use an int (i) to iterate over nb_clusters, and then
calculate the L2 entry based on "i << s->cluster_bits" -- which will
overflow if the range covers more than INT_MAX bytes.  This then leads
to image corruption because the L2 entry will be wrong (it will be
recognized as a compressed cluster).

Even if that were not the case, the .cow_end area would be empty
(because handle_alloc() will cap avail_bytes and nb_bytes at INT_MAX, so
their difference (which is the .cow_end size) will be 0).

So this test checks that on such large requests, the image will not be
corrupted.  Unfortunately, we cannot check whether COW will be handled
correctly, because that data is discarded when it is written to null-co
(but we have to use null-co, because writing 2 GB of data in a test is
not quite reasonable).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/268     | 83 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/268.out |  9 +++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 93 insertions(+)
 create mode 100755 tests/qemu-iotests/268
 create mode 100644 tests/qemu-iotests/268.out

diff --git a/tests/qemu-iotests/268 b/tests/qemu-iotests/268
new file mode 100755
index 0000000000..b9a12b908c
--- /dev/null
+++ b/tests/qemu-iotests/268
@@ -0,0 +1,83 @@
+#!/usr/bin/env bash
+#
+# Test large write to a qcow2 image
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
+seq=3D$(basename "$0")
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
+
+# This is a qcow2 regression test
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+# We use our own external data file and our own cluster size, and we
+# require v3 images
+_unsupported_imgopts data_file cluster_size 'compat=3D0.10'
+
+
+# We need a backing file so that handle_alloc_space() will not do
+# anything.  (If it were to do anything, it would simply fail its
+# write-zeroes request because the request range is too large.)
+TEST_IMG=3D"$TEST_IMG.base" _make_test_img 4G
+$QEMU_IO -c 'write 0 512' "$TEST_IMG.base" | _filter_qemu_io
+
+# (Use .orig because _cleanup_test_img will remove that file)
+# We need a large cluster size, see below for why (above the $QEMU_IO
+# invocation)
+_make_test_img -o cluster_size=3D2M,data_file=3D"$TEST_IMG.orig" \
+    -b "$TEST_IMG.base" 4G
+
+# We want a null-co as the data file, because it allows us to quickly
+# "write" 2G of data without using any space.
+# (qemu-img create does not like it, though, because null-co does not
+# support image creation.)
+$QEMU_IMG amend -o data_file=3D"json:{'driver':'null-co',,'size':'429496=
7296'}" \
+    "$TEST_IMG"
+
+# This gives us a range of:
+#   2^31 - 512 + 768 - 1 =3D 2^31 + 255 > 2^31
+# until the beginning of the end COW block.  (The total allocation
+# size depends on the cluster size, but all that is important is that
+# it exceeds INT_MAX.)
+#
+# 2^31 - 512 is the maximum request size.  We want this to result in a
+# single allocation, and because the qcow2 driver splits allocations
+# on L2 boundaries, we need large L2 tables; hence the cluster size of
+# 2 MB.  (Anything from 256 kB should work, though, because then one L2
+# table covers 8 GB.)
+$QEMU_IO -c "write 768 $((2 ** 31 - 512))" "$TEST_IMG" | _filter_qemu_io
+
+_check_test_img
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/268.out b/tests/qemu-iotests/268.out
new file mode 100644
index 0000000000..35d4f9e3e9
--- /dev/null
+++ b/tests/qemu-iotests/268.out
@@ -0,0 +1,9 @@
+QA output created by 268
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D4294967296
+wrote 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D4294967296 backing_f=
ile=3DTEST_DIR/t.IMGFMT.base data_file=3DTEST_DIR/t.IMGFMT.orig
+wrote 2147483136/2147483136 bytes at offset 768
+2 GiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+No errors were found on the image.
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 5805a79d9e..4c37b8acec 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -278,3 +278,4 @@
 265 rw auto quick
 266 rw quick
 267 rw auto quick snapshot
+268 rw backing quick
--=20
2.21.0


