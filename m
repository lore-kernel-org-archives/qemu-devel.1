Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D59C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:29:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C90D221929
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C90D221929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS6OJ-0004wA-9R
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 16:29:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58810)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5pZ-0001HU-TK
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:53:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5pX-0002Qo-Or
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:53:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32568)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iS5pX-00026e-Jj; Tue, 05 Nov 2019 15:53:35 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 xA5KpbUQ076892; Tue, 5 Nov 2019 15:53:15 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w3csx6x49-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:53:14 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xA5Kphkv077137;
 Tue, 5 Nov 2019 15:53:13 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w3csx6x40-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:53:13 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xA5KnujL017448;
 Tue, 5 Nov 2019 20:53:13 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma05wdc.us.ibm.com with ESMTP id 2w11e7186v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 20:53:13 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xA5KrCCD12846006
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Nov 2019 20:53:12 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D3F4124058;
 Tue,  5 Nov 2019 20:53:12 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59CA012405C;
 Tue,  5 Nov 2019 20:53:12 +0000 (GMT)
Received: from localhost (unknown [9.53.179.218])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  5 Nov 2019 20:53:12 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 44/55] iotests: Test large write request to qcow2 file
Date: Tue,  5 Nov 2019 14:52:32 -0600
Message-Id: <20191105205243.3766-45-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
References: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-05_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911050170
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

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
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit a1406a9262a087d9ec9627b88da13c4590b61dae)
 Conflicts:
	tests/qemu-iotests/group
*drop context dep. on tests not in 4.1
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/qemu-iotests/270     | 83 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/270.out |  9 +++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 93 insertions(+)
 create mode 100755 tests/qemu-iotests/270
 create mode 100644 tests/qemu-iotests/270.out

diff --git a/tests/qemu-iotests/270 b/tests/qemu-iotests/270
new file mode 100755
index 0000000000..b9a12b908c
--- /dev/null
+++ b/tests/qemu-iotests/270
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
+seq=$(basename "$0")
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
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
+_unsupported_imgopts data_file cluster_size 'compat=0.10'
+
+
+# We need a backing file so that handle_alloc_space() will not do
+# anything.  (If it were to do anything, it would simply fail its
+# write-zeroes request because the request range is too large.)
+TEST_IMG="$TEST_IMG.base" _make_test_img 4G
+$QEMU_IO -c 'write 0 512' "$TEST_IMG.base" | _filter_qemu_io
+
+# (Use .orig because _cleanup_test_img will remove that file)
+# We need a large cluster size, see below for why (above the $QEMU_IO
+# invocation)
+_make_test_img -o cluster_size=2M,data_file="$TEST_IMG.orig" \
+    -b "$TEST_IMG.base" 4G
+
+# We want a null-co as the data file, because it allows us to quickly
+# "write" 2G of data without using any space.
+# (qemu-img create does not like it, though, because null-co does not
+# support image creation.)
+$QEMU_IMG amend -o data_file="json:{'driver':'null-co',,'size':'4294967296'}" \
+    "$TEST_IMG"
+
+# This gives us a range of:
+#   2^31 - 512 + 768 - 1 = 2^31 + 255 > 2^31
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
+status=0
diff --git a/tests/qemu-iotests/270.out b/tests/qemu-iotests/270.out
new file mode 100644
index 0000000000..c7be111014
--- /dev/null
+++ b/tests/qemu-iotests/270.out
@@ -0,0 +1,9 @@
+QA output created by 270
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=4294967296
+wrote 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4294967296 backing_file=TEST_DIR/t.IMGFMT.base data_file=TEST_DIR/t.IMGFMT.orig
+wrote 2147483136/2147483136 bytes at offset 768
+2 GiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+No errors were found on the image.
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 8bc2f3857d..7629e8ea17 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -274,3 +274,4 @@
 265 rw auto quick
 266 rw quick
 267 rw auto quick snapshot
+270 rw backing quick
-- 
2.17.1


