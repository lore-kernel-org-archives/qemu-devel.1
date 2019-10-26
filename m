Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6504CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 21:48:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40119206DD
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 21:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jvhtPTIN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40119206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOTv7-0006JV-J5
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 17:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iOTa3-0000d5-KZ
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:26:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iOTZz-0005Vj-Px
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:26:39 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:42565)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iOTZy-0005Hv-T1; Sat, 26 Oct 2019 17:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=NvKAwDAki7lAO2OPBD1vkvPgf0RmaEWQFVItKFVW0xw=; 
 b=jvhtPTIN/2TEo44pBGSx/qHPx0B7oo7pdunEtz4PgxeBB3BpiY0ylpbLEb2W44QIrOc+FgtV4JJcSZanGdH2SZQLNQkm2UmV3HRQN2zAX6C/l3k/pXaI9NMaqLPvQau7kQ9Jdi3jRSXzi7b+4M+4Mj7UHDPR8RJOvFPJ5LObDm1CxEQJINukODxyZgTtWNaUTSP9076o95sn+MQ/c3Z1JA75DMR2ws4EbBzSRO9p5oCBJ4qmJDEI/O/X7Kybo/MFAtwBsF7qh9HVSyDkJD8qf9XmFbBKggAi0p3WaKWPqZfy1izX8vrn68KjWrVtsUlHSeIINQL/wvTX4bM2slXBFA==;
Received: from 87-100-137-117.bb.dnainternet.fi ([87.100.137.117]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1iOTZJ-00046E-DC; Sat, 26 Oct 2019 23:25:53 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1iOTZ1-0001Pr-7j; Sun, 27 Oct 2019 00:25:35 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 26/26] iotests: Add tests for qcow2 images with
 extended L2 entries
Date: Sun, 27 Oct 2019 00:25:28 +0300
Message-Id: <bed503e1c1b0067a5c9c98f3834315f8be161312.1572125022.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1572125022.git.berto@igalia.com>
References: <cover.1572125022.git.berto@igalia.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 tests/qemu-iotests/271     | 235 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/271.out | 183 +++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 419 insertions(+)
 create mode 100755 tests/qemu-iotests/271
 create mode 100644 tests/qemu-iotests/271.out

diff --git a/tests/qemu-iotests/271 b/tests/qemu-iotests/271
new file mode 100755
index 0000000000..c49433cdc9
--- /dev/null
+++ b/tests/qemu-iotests/271
@@ -0,0 +1,235 @@
+#!/bin/bash
+#
+# Test qcow2 images with extended L2 entries
+#
+# Copyright (C) 2019 Igalia, S.L.
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
+seq="$(basename $0)"
+echo "QA output created by $seq"
+
+here="$PWD"
+status=1	# failure is the default!
+
+_cleanup()
+{
+	_cleanup_test_img
+        rm -f "$TEST_IMG.raw"
+        rm -f "$TEST_IMG.backing"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt qcow2
+_supported_proto file nfs
+_supported_os Linux
+
+IMGOPTS="extended_l2=on"
+l2_offset=262144 # 0x40000
+
+_verify_img()
+{
+    $QEMU_IMG compare "$TEST_IMG" "$TEST_IMG.raw" | grep -v 'Images are identical'
+    $QEMU_IMG check "$TEST_IMG" | _filter_qemu_img_check | \
+        grep -v 'No errors were found on the image'
+}
+
+_read_l2_entry()
+{
+    entry_no=$1
+    nentries=$2
+    offset=$(($l2_offset + $entry_no * 16))
+    length=$((nentries * 16))
+    $QEMU_IO -f raw -c "read -v $offset $length" "$TEST_IMG" | _filter_qemu_io | head -n -2
+}
+
+_test_write()
+{
+    cmd="$1"
+    l2_entry_idx="$2"
+    l2_entry_num="$3"
+    raw_cmd=`echo $1 | sed s/-c//` # Raw images don't support -c
+    echo "$cmd"
+    $QEMU_IO -c "$cmd" "$TEST_IMG" | _filter_qemu_io
+    $QEMU_IO -c "$raw_cmd" -f raw "$TEST_IMG.raw" | _filter_qemu_io
+    _verify_img
+    if [ -n "$l2_entry_idx" ]; then
+        _read_l2_entry "$l2_entry_idx" "$l2_entry_num"
+    fi
+}
+
+_reset_img()
+{
+    $QEMU_IMG create -f raw "$TEST_IMG.raw" 1M | _filter_img_create
+    if [ "$use_backing_file" = "yes" ]; then
+        $QEMU_IMG create -f raw "$TEST_IMG.backing" 1M | _filter_img_create
+        $QEMU_IO -c 'write -q -P 0xFF 0 1M' -f raw "$TEST_IMG.backing" | _filter_qemu_io
+        $QEMU_IO -c 'write -q -P 0xFF 0 1M' -f raw "$TEST_IMG.raw" | _filter_qemu_io
+        _make_test_img -b "$TEST_IMG.backing" 1M
+    else
+        _make_test_img 1M
+    fi
+}
+
+# Test that writing to an image with subclusters produces the expected
+# results, in images with and without backing files
+for use_backing_file in yes no; do
+    echo
+    echo "### Standard write tests (backing file: $use_backing_file) ###"
+    echo
+    _reset_img
+    ### Write subcluster #0 (beginning of subcluster) ###
+    _test_write 'write -q -P 1 0 1k' 0 1
+
+    ### Write subcluster #1 (middle of subcluster) ###
+    _test_write 'write -q -P 2 3k 512' 0 1
+
+    ### Write subcluster #2 (end of subcluster) ###
+    _test_write 'write -q -P 3 5k 1k' 0 1
+
+    ### Write subcluster #3 (full subcluster) ###
+    _test_write 'write -q -P 4 6k 2k' 0 1
+
+    ### Write subclusters #4-6 (full subclusters) ###
+    _test_write 'write -q -P 5 8k 6k' 0 1
+
+    ### Write subclusters #7-9 (partial subclusters) ###
+    _test_write 'write -q -P 6 15k 4k' 0 1
+
+    ### Write subcluster #16 (partial subcluster) ###
+    _test_write 'write -q -P 7 32k 1k' 0 2
+
+    ### Write subcluster #31-#34 (cluster overlap) ###
+    _test_write 'write -q -P 8 63k 4k' 0 2
+
+    ### Zero subcluster #1 (TODO: use the "all zeros" bit)
+    _test_write 'write -q -z 2k 2k' 0 1
+
+    ### Zero cluster #0
+    _test_write 'write -q -z 0 64k' 0 1
+
+    ### Fill cluster #0 with data
+    _test_write 'write -q -P 9 0 64k' 0 1
+
+    ### Zero and unmap half of cluster #0 (this won't unmap it)
+    _test_write 'write -q -z -u 0 32k' 0 1
+
+    ### Zero and unmap cluster #0
+    _test_write 'write -q -z -u 0 64k' 0 1
+
+    ### Write subcluster #2 (middle of subcluster)
+    _test_write 'write -q -P 10 3k 512' 0 1
+
+    ### Fill cluster #0 with data
+    _test_write 'write -q -P 11 0 64k' 0 1
+
+    ### Discard cluster #0
+    _test_write 'discard -q 0 64k' 0 1
+
+    ### Write compressed data to cluster #0
+    _test_write 'write -q -c -P 12 0 64k' 0 1
+
+    ### Write subcluster #2 (middle of subcluster)
+    _test_write 'write -q -P 13 3k 512' 0 1
+done
+
+# Test that corrupted L2 entries are detected in both read and write
+# operations
+for corruption_test_cmd in read write; do
+    echo
+    echo "### Corrupted L2 entries - $corruption_test_cmd test (allocated) ###"
+    echo
+    echo "# 'cluster is zero' bit set on the standard cluster descriptor"
+    echo
+    _make_test_img 1M
+    $QEMU_IO -c 'write -q 0 2k' "$TEST_IMG"
+    poke_file "$TEST_IMG" $(($l2_offset+7)) "\x01"
+    $QEMU_IO -c "$corruption_test_cmd 0 1k" "$TEST_IMG"
+
+    echo
+    echo "# Both 'subcluster is zero' and 'subcluster is allocated' bits set"
+    echo
+    _make_test_img 1M
+    $QEMU_IO -c 'write -q 0 2k' "$TEST_IMG"
+    poke_file "$TEST_IMG" $(($l2_offset+8)) "\x80"
+    $QEMU_IO -c "$corruption_test_cmd 0 1k" "$TEST_IMG"
+
+    echo
+    echo "### Corrupted L2 entries - $corruption_test_cmd test (unallocated) ###"
+    echo
+    echo "# 'cluster is zero' bit set on the standard cluster descriptor"
+    echo
+    _make_test_img 1M
+    # Write to cluster #4 in order to initialize the L2 table
+    $QEMU_IO -c 'write -q 256k 1k' "$TEST_IMG"
+    poke_file "$TEST_IMG" $(($l2_offset+7)) "\x01"
+    $QEMU_IO -c "$corruption_test_cmd 0 1k" "$TEST_IMG"
+
+    echo
+    echo "# 'subcluster is allocated' bit set"
+    echo
+    _make_test_img 1M
+    # Write to cluster #4 in order to initialize the L2 table
+    $QEMU_IO -c 'write -q 256k 1k' "$TEST_IMG"
+    poke_file "$TEST_IMG" $(($l2_offset+12)) "\x80"
+    _read_l2_entry 0 1
+    $QEMU_IO -c "$corruption_test_cmd 0 1k" "$TEST_IMG"
+
+    echo
+    echo "# Both 'subcluster is zero' and 'subcluster is allocated' bits set"
+    echo
+    _make_test_img 1M
+    # Write to cluster #4 in order to initialize the L2 table
+    $QEMU_IO -c 'write -q 256k 1k' "$TEST_IMG"
+    poke_file "$TEST_IMG" $(($l2_offset+8)) "\x80\x00\x00\x00\x80"
+    $QEMU_IO -c "$corruption_test_cmd 0 1k" "$TEST_IMG"
+
+    echo
+    echo "### Compressed cluster with subcluster bitmap != 0 - $corruption_test_cmd test ###"
+    echo
+    _make_test_img 1M
+    $QEMU_IO -c 'write -q -c 0 64k' "$TEST_IMG"
+    poke_file "$TEST_IMG" $(($l2_offset+8)) "\x01"
+    $QEMU_IO -c "$corruption_test_cmd 0 1k" "$TEST_IMG"
+done
+
+echo
+echo "### Image creation options ###"
+echo
+echo "# cluster_size < 16k"
+IMGOPTS="extended_l2=on,cluster_size=8k" _make_test_img 1M
+
+echo "# backing file and preallocation=metadata"
+IMGOPTS="extended_l2=on,preallocation=metadata" _make_test_img -b "$TEST_IMG.backing" 1M
+
+echo "# backing file and preallocation=falloc"
+IMGOPTS="extended_l2=on,preallocation=falloc" _make_test_img -b "$TEST_IMG.backing" 1M
+
+echo "# backing file and preallocation=full"
+IMGOPTS="extended_l2=on,preallocation=full" _make_test_img -b "$TEST_IMG.backing" 1M
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
+
diff --git a/tests/qemu-iotests/271.out b/tests/qemu-iotests/271.out
new file mode 100644
index 0000000000..fa4da573e0
--- /dev/null
+++ b/tests/qemu-iotests/271.out
@@ -0,0 +1,183 @@
+QA output created by 271
+
+### Standard write tests (backing file: yes) ###
+
+Formatting 'TEST_DIR/t.IMGFMT.raw', fmt=raw size=1048576
+Formatting 'TEST_DIR/t.IMGFMT.backing', fmt=raw size=1048576
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.backing
+write -q -P 1 0 1k
+00040000:  80 00 00 00 00 05 00 00 00 00 00 00 80 00 00 00  ................
+write -q -P 2 3k 512
+00040000:  80 00 00 00 00 05 00 00 00 00 00 00 c0 00 00 00  ................
+write -q -P 3 5k 1k
+00040000:  80 00 00 00 00 05 00 00 00 00 00 00 e0 00 00 00  ................
+write -q -P 4 6k 2k
+00040000:  80 00 00 00 00 05 00 00 00 00 00 00 f0 00 00 00  ................
+write -q -P 5 8k 6k
+00040000:  80 00 00 00 00 05 00 00 00 00 00 00 fe 00 00 00  ................
+write -q -P 6 15k 4k
+00040000:  80 00 00 00 00 05 00 00 00 00 00 00 ff c0 00 00  ................
+write -q -P 7 32k 1k
+00040000:  80 00 00 00 00 05 00 00 00 00 00 00 ff c0 80 00  ................
+00040010:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+write -q -P 8 63k 4k
+00040000:  80 00 00 00 00 05 00 00 00 00 00 00 ff c0 80 01  ................
+00040010:  80 00 00 00 00 06 00 00 00 00 00 00 c0 00 00 00  ................
+write -q -z 2k 2k
+00040000:  80 00 00 00 00 05 00 00 00 00 00 00 ff c0 80 01  ................
+write -q -z 0 64k
+00040000:  80 00 00 00 00 05 00 00 ff ff ff ff 00 00 00 00  ................
+write -q -P 9 0 64k
+00040000:  80 00 00 00 00 05 00 00 00 00 00 00 ff ff ff ff  ................
+write -q -z -u 0 32k
+00040000:  80 00 00 00 00 05 00 00 00 00 00 00 ff ff ff ff  ................
+write -q -z -u 0 64k
+00040000:  00 00 00 00 00 00 00 00 ff ff ff ff 00 00 00 00  ................
+write -q -P 10 3k 512
+00040000:  80 00 00 00 00 05 00 00 bf ff ff ff 40 00 00 00  ................
+write -q -P 11 0 64k
+00040000:  80 00 00 00 00 05 00 00 00 00 00 00 ff ff ff ff  ................
+discard -q 0 64k
+00040000:  00 00 00 00 00 00 00 00 ff ff ff ff 00 00 00 00  ................
+write -q -c -P 12 0 64k
+00040000:  40 00 00 00 00 05 00 00 00 00 00 00 00 00 00 00  ................
+write -q -P 13 3k 512
+00040000:  80 00 00 00 00 07 00 00 00 00 00 00 ff ff ff ff  ................
+
+### Standard write tests (backing file: no) ###
+
+Formatting 'TEST_DIR/t.IMGFMT.raw', fmt=raw size=1048576
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+write -q -P 1 0 1k
+00040000:  80 00 00 00 00 05 00 00 00 00 00 00 80 00 00 00  ................
+write -q -P 2 3k 512
+00040000:  80 00 00 00 00 05 00 00 00 00 00 00 c0 00 00 00  ................
+write -q -P 3 5k 1k
+00040000:  80 00 00 00 00 05 00 00 00 00 00 00 e0 00 00 00  ................
+write -q -P 4 6k 2k
+00040000:  80 00 00 00 00 05 00 00 00 00 00 00 f0 00 00 00  ................
+write -q -P 5 8k 6k
+00040000:  80 00 00 00 00 05 00 00 00 00 00 00 fe 00 00 00  ................
+write -q -P 6 15k 4k
+00040000:  80 00 00 00 00 05 00 00 00 00 00 00 ff c0 00 00  ................
+write -q -P 7 32k 1k
+00040000:  80 00 00 00 00 05 00 00 00 00 00 00 ff c0 80 00  ................
+00040010:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
+write -q -P 8 63k 4k
+00040000:  80 00 00 00 00 05 00 00 00 00 00 00 ff c0 80 01  ................
+00040010:  80 00 00 00 00 06 00 00 00 00 00 00 c0 00 00 00  ................
+write -q -z 2k 2k
+00040000:  80 00 00 00 00 05 00 00 00 00 00 00 ff c0 80 01  ................
+write -q -z 0 64k
+00040000:  80 00 00 00 00 05 00 00 ff ff ff ff 00 00 00 00  ................
+write -q -P 9 0 64k
+00040000:  80 00 00 00 00 05 00 00 00 00 00 00 ff ff ff ff  ................
+write -q -z -u 0 32k
+00040000:  80 00 00 00 00 05 00 00 00 00 00 00 ff ff ff ff  ................
+write -q -z -u 0 64k
+00040000:  00 00 00 00 00 00 00 00 ff ff ff ff 00 00 00 00  ................
+write -q -P 10 3k 512
+00040000:  80 00 00 00 00 05 00 00 bf ff ff ff 40 00 00 00  ................
+write -q -P 11 0 64k
+00040000:  80 00 00 00 00 05 00 00 00 00 00 00 ff ff ff ff  ................
+discard -q 0 64k
+00040000:  00 00 00 00 00 00 00 00 ff ff ff ff 00 00 00 00  ................
+write -q -c -P 12 0 64k
+00040000:  40 00 00 00 00 05 00 00 00 00 00 00 00 00 00 00  ................
+write -q -P 13 3k 512
+00040000:  80 00 00 00 00 07 00 00 00 00 00 00 ff ff ff ff  ................
+
+### Corrupted L2 entries - read test (allocated) ###
+
+# 'cluster is zero' bit set on the standard cluster descriptor
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
+read failed: Input/output error
+
+# Both 'subcluster is zero' and 'subcluster is allocated' bits set
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
+read failed: Input/output error
+
+### Corrupted L2 entries - read test (unallocated) ###
+
+# 'cluster is zero' bit set on the standard cluster descriptor
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
+read failed: Input/output error
+
+# 'subcluster is allocated' bit set
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+00040000:  00 00 00 00 00 00 00 00 00 00 00 00 80 00 00 00  ................
+qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
+read failed: Input/output error
+
+# Both 'subcluster is zero' and 'subcluster is allocated' bits set
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
+read failed: Input/output error
+
+### Compressed cluster with subcluster bitmap != 0 - read test ###
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
+read failed: Input/output error
+
+### Corrupted L2 entries - write test (allocated) ###
+
+# 'cluster is zero' bit set on the standard cluster descriptor
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
+write failed: Input/output error
+
+# Both 'subcluster is zero' and 'subcluster is allocated' bits set
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
+write failed: Input/output error
+
+### Corrupted L2 entries - write test (unallocated) ###
+
+# 'cluster is zero' bit set on the standard cluster descriptor
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
+write failed: Input/output error
+
+# 'subcluster is allocated' bit set
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+00040000:  00 00 00 00 00 00 00 00 00 00 00 00 80 00 00 00  ................
+qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
+write failed: Input/output error
+
+# Both 'subcluster is zero' and 'subcluster is allocated' bits set
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
+write failed: Input/output error
+
+### Compressed cluster with subcluster bitmap != 0 - write test ###
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
+write failed: Input/output error
+
+### Image creation options ###
+
+# cluster_size < 16k
+qemu-img: TEST_DIR/t.IMGFMT: Extended L2 entries are only supported with cluster sizes of at least 16384 bytes
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+# backing file and preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.backing preallocation=metadata
+# backing file and preallocation=falloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.backing preallocation=falloc
+# backing file and preallocation=full
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.backing preallocation=full
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index af322af756..945e6d68cc 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -282,3 +282,4 @@
 267 rw auto quick snapshot
 268 rw auto quick
 270 rw backing quick
+271 rw auto
-- 
2.20.1


