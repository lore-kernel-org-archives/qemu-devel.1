Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4F8C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:42:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5C4D20714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Oxuo4lVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C4D20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEHAa-0006Ek-T6
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49107)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jEGn4-0003j5-Gy
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jEGmv-00009z-A8
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:18:10 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:58021)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jEGmu-0005yT-4H; Tue, 17 Mar 2020 14:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=RPN/yHP4znLKszxyOoU+Ptsu4yTPY7OKYSkTrSXwvTY=; 
 b=Oxuo4lVXUoOvsLlBJXN24+Zq1WO5QU8AnYp3gJ6aTn8icz+kebFV6nG3niAVhQkyRw6V7ewU0pKp5WEVDj8+XlDFcWWuMUE17ZbqQW0Zianp5WuFjCwakK5j9qwPZczUgvvKzgSQYUQD2vjmeys4W99pfJp/VwxtJqv/oTc/41afsM6fyFYrOc15kW23wQDXN6p/LltYHt7UTAD0PElH7Pg/vajt5AGoEEkWu3iMO3TbpC+j3bvCLNRON5T1K4w+JiwtqU38zpbW4dcc5Wu6fRpbeC6gvfyx8XMD1cv+1k9O1eHtkaYqfaNzqpKH+opetXowOF2XdVq/9WXuTl2tGQ==;
Received: from [81.0.35.138] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jEGmD-00015R-0h; Tue, 17 Mar 2020 19:17:17 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jEGlx-0006P1-2D; Tue, 17 Mar 2020 19:17:01 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 30/30] iotests: Add tests for qcow2 images with extended L2
 entries
Date: Tue, 17 Mar 2020 19:16:27 +0100
Message-Id: <420b76fbe25d5e2eeda53490a1c646935dab61c4.1584468724.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1584468723.git.berto@igalia.com>
References: <cover.1584468723.git.berto@igalia.com>
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
 tests/qemu-iotests/271     | 359 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/271.out | 244 +++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 604 insertions(+)
 create mode 100755 tests/qemu-iotests/271
 create mode 100644 tests/qemu-iotests/271.out

diff --git a/tests/qemu-iotests/271 b/tests/qemu-iotests/271
new file mode 100755
index 0000000000..48f4d8d8ce
--- /dev/null
+++ b/tests/qemu-iotests/271
@@ -0,0 +1,359 @@
+#!/bin/bash
+#
+# Test qcow2 images with extended L2 entries
+#
+# Copyright (C) 2019-2020 Igalia, S.L.
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
+# Compare the bitmap of an extended L2 entry against an expected value
+_verify_l2_bitmap()
+{
+    entry_no="$1"        # L2 entry number, starting from 0
+    expected_alloc="$2"  # Space-separated list of allocated subcluster indexes
+    expected_zero="$3"   # Space-separated list of zero subcluster indexes
+
+    offset=$(($l2_offset + $entry_no * 16))
+    entry=`peek_file_be "$TEST_IMG" $offset 8`
+    offset=$(($offset + 8))
+    bitmap=`peek_file_be "$TEST_IMG" $offset 8`
+
+    expected_bitmap=0
+    for bit in $expected_alloc; do
+        expected_bitmap=$(($expected_bitmap | (1 << $bit)))
+    done
+    for bit in $expected_zero; do
+        expected_bitmap=$(($expected_bitmap | (1 << (32 + $bit))))
+    done
+    expected_bitmap=`printf "%llu" $expected_bitmap`
+
+    printf "L2 entry #%d: 0x%016lx %016lx\n" "$entry_no" "$entry" "$bitmap"
+    if [ "$bitmap" != "$expected_bitmap" ]; then
+        printf "ERROR: expecting bitmap       0x%016lx\n" "$expected_bitmap"
+    fi
+}
+
+_test_write()
+{
+    cmd="$1"
+    alloc_bitmap="$2"
+    zero_bitmap="$3"
+    l2_entry_idx="$4"
+    [ -n "$l2_entry_idx" ] || l2_entry_idx=0
+    raw_cmd=`echo $cmd | sed s/-c//` # Raw images don't support -c
+    echo "$cmd"
+    $QEMU_IO -c "$cmd" "$TEST_IMG" | _filter_qemu_io
+    $QEMU_IO -c "$raw_cmd" -f raw "$TEST_IMG.raw" | _filter_qemu_io
+    _verify_img
+    _verify_l2_bitmap "$l2_entry_idx" "$alloc_bitmap" "$zero_bitmap"
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
+    alloc="0"; zero=""
+    _test_write 'write -q -P 1 0 1k' "$alloc" "$zero"
+
+    ### Write subcluster #1 (middle of subcluster) ###
+    alloc="0 1"; zero=""
+    _test_write 'write -q -P 2 3k 512' "$alloc" "$zero"
+
+    ### Write subcluster #2 (end of subcluster) ###
+    alloc="0 1 2"; zero=""
+    _test_write 'write -q -P 3 5k 1k' "$alloc" "$zero"
+
+    ### Write subcluster #3 (full subcluster) ###
+    alloc="0 1 2 3"; zero=""
+    _test_write 'write -q -P 4 6k 2k' "$alloc" "$zero"
+
+    ### Write subclusters #4-6 (full subclusters) ###
+    alloc="`seq 0 6`"; zero=""
+    _test_write 'write -q -P 5 8k 6k' "$alloc" "$zero"
+
+    ### Write subclusters #7-9 (partial subclusters) ###
+    alloc="`seq 0 9`"; zero=""
+    _test_write 'write -q -P 6 15k 4k' "$alloc" "$zero"
+
+    ### Write subcluster #16 (partial subcluster) ###
+    alloc="`seq 0 9` 16"; zero=""
+    _test_write 'write -q -P 7 32k 1k' "$alloc" "$zero"
+
+    ### Write subcluster #31-#34 (cluster overlap) ###
+    alloc="`seq 0 9` 16 31"; zero=""
+    _test_write 'write -q -P 8 63k 4k' "$alloc" "$zero"
+    alloc="0 1" ; zero=""
+    _verify_l2_bitmap 1 "$alloc" "$zero"
+
+    ### Zero subcluster #1 (TODO: use the "all zeros" bit)
+    alloc="`seq 0 9` 16 31"; zero=""
+    _test_write 'write -q -z 2k 2k' "$alloc" "$zero"
+
+    ### Zero cluster #0
+    alloc=""; zero="`seq 0 31`"
+    _test_write 'write -q -z 0 64k' "$alloc" "$zero"
+
+    ### Fill cluster #0 with data
+    alloc="`seq 0 31`"; zero=""
+    _test_write 'write -q -P 9 0 64k' "$alloc" "$zero"
+
+    ### Zero and unmap half of cluster #0 (this won't unmap it)
+    alloc="`seq 0 31`"; zero=""
+    _test_write 'write -q -z -u 0 32k' "$alloc" "$zero"
+
+    ### Zero and unmap cluster #0
+    alloc=""; zero="`seq 0 31`"
+    _test_write 'write -q -z -u 0 64k' "$alloc" "$zero"
+
+    ### Write subcluster #1 (middle of subcluster)
+    alloc="1"; zero="0 `seq 2 31`"
+    _test_write 'write -q -P 10 3k 512' "$alloc" "$zero"
+
+    ### Fill cluster #0 with data
+    alloc="`seq 0 31`"; zero=""
+    _test_write 'write -q -P 11 0 64k' "$alloc" "$zero"
+
+    ### Discard cluster #0
+    alloc=""; zero="`seq 0 31`"
+    _test_write 'discard -q 0 64k' "$alloc" "$zero"
+
+    ### Write compressed data to cluster #0
+    alloc=""; zero=""
+    _test_write 'write -q -c -P 12 0 64k' "$alloc" "$zero"
+
+    ### Write subcluster #2 (middle of subcluster)
+    alloc="`seq 0 31`"; zero=""
+    _test_write 'write -q -P 13 3k 512' "$alloc" "$zero"
+
+    ### Zeroize an unallocated cluster (#2)
+    alloc=""; zero="`seq 0 31`"
+    _test_write 'write -q -z 128k 64k' "$alloc" "$zero" 2
+
+    ### Partially zeroize an unallocated cluster (#3)
+    if [ "$use_backing_file" = "yes" ]; then
+        alloc="`seq 0 15`"; zero=""
+    else
+        alloc=""; zero="`seq 0 31`"
+    fi
+    _test_write 'write -q -z 192k 32k' "$alloc" "$zero" 3
+done
+
+for use_backing_file in yes no; do
+    echo
+    echo "### Discarding clusters with non-zero bitmaps (backing file: $use_backing_file) ###"
+    echo
+    if [ "$use_backing_file" = "yes" ]; then
+        _make_test_img -b "$TEST_IMG.backing" 1M
+    else
+        _make_test_img 1M
+    fi
+    # Write clusters #0-#2 and then discard them
+    $QEMU_IO -c 'write -q 0 128k' "$TEST_IMG"
+    $QEMU_IO -c 'discard -q 0 128k' "$TEST_IMG"
+    # 'qemu-io discard' doesn't do a full discard, it zeroizes the
+    # cluster, so both clusters have all zero bits set now
+    alloc=""; zero="`seq 0 31`"
+    _verify_l2_bitmap 0 "$alloc" "$zero"
+    _verify_l2_bitmap 1 "$alloc" "$zero"
+    # Now deallocate half of the subclusters of the first cluster
+    poke_file "$TEST_IMG" $(($l2_offset+8)) "\x00\x00"
+    # Discard cluster #0 again to see how the zero bits have changed
+    $QEMU_IO -c 'discard -q 0 64k' "$TEST_IMG"
+    # And do a full discard of cluster #1 by shrinking and growing the image
+    $QEMU_IMG resize --shrink "$TEST_IMG" 64k
+    $QEMU_IMG resize "$TEST_IMG" 1M
+    # A normal discard sets all 'zero' bits only if the image has a
+    # backing file, otherwise it won't touch them.
+    if [ "$use_backing_file" = "yes" ]; then
+        alloc=""; zero="`seq 0 31`"
+    else
+        alloc=""; zero="`seq 0 15`"
+    fi
+    _verify_l2_bitmap 0 "$alloc" "$zero"
+    # A full discard should clear the L2 entry completely
+    alloc=""; zero=""
+    _verify_l2_bitmap 1 "$alloc" "$zero"
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
+    alloc="0"; zero=""
+    _verify_l2_bitmap 0 "$alloc" "$zero"
+    $QEMU_IO -c "$corruption_test_cmd 0 1k" "$TEST_IMG"
+
+    echo
+    echo "# Both 'subcluster is zero' and 'subcluster is allocated' bits set"
+    echo
+    _make_test_img 1M
+    $QEMU_IO -c 'write -q 0 2k' "$TEST_IMG"
+    poke_file "$TEST_IMG" $(($l2_offset+11)) "\x01"
+    alloc="0"; zero="0"
+    _verify_l2_bitmap 0 "$alloc" "$zero"
+    $QEMU_IO -c "$corruption_test_cmd 0 1k" "$TEST_IMG"
+
+    echo
+    echo "### Corrupted L2 entries - $corruption_test_cmd test (unallocated) ###"
+    echo
+    echo "# 'cluster is zero' bit set on the standard cluster descriptor"
+    echo
+    _make_test_img 1M
+    # We want to corrupt the (empty) L2 entry from cluster #0,
+    # but we write to #4 in order to initialize the L2 table first
+    $QEMU_IO -c 'write -q 256k 1k' "$TEST_IMG"
+    poke_file "$TEST_IMG" $(($l2_offset+7)) "\x01"
+    alloc=""; zero=""
+    _verify_l2_bitmap 0 "$alloc" "$zero"
+    $QEMU_IO -c "$corruption_test_cmd 0 1k" "$TEST_IMG"
+
+    echo
+    echo "# 'subcluster is allocated' bit set"
+    echo
+    _make_test_img 1M
+    # We want to corrupt the (empty) L2 entry from cluster #0,
+    # but we write to #4 in order to initialize the L2 table first
+    $QEMU_IO -c 'write -q 256k 1k' "$TEST_IMG"
+    poke_file "$TEST_IMG" $(($l2_offset+15)) "\x01"
+    alloc="0"; zero=""
+    _verify_l2_bitmap 0 "$alloc" "$zero"
+    $QEMU_IO -c "$corruption_test_cmd 0 1k" "$TEST_IMG"
+
+    echo
+    echo "# Both 'subcluster is zero' and 'subcluster is allocated' bits set"
+    echo
+    _make_test_img 1M
+    # We want to corrupt the (empty) L2 entry from cluster #0,
+    # but we write to #4 in order to initialize the L2 table first
+    $QEMU_IO -c 'write -q 256k 1k' "$TEST_IMG"
+    poke_file "$TEST_IMG" $(($l2_offset+8)) "\x00\x00\x00\x01\x00\x00\x00\x01"
+    alloc="0"; zero="0"
+    _verify_l2_bitmap 0 "$alloc" "$zero"
+    $QEMU_IO -c "$corruption_test_cmd 0 1k" "$TEST_IMG"
+
+    echo
+    echo "### Compressed cluster with subcluster bitmap != 0 - $corruption_test_cmd test ###"
+    echo
+    # We actually don't consider this a corrupted image.
+    # The bitmap in compressed clusters is unused so QEMU should just ignore it.
+    _make_test_img 1M
+    $QEMU_IO -c 'write -q -P 11 -c 0 64k' "$TEST_IMG"
+    poke_file "$TEST_IMG" $(($l2_offset+11)) "\x01\x01"
+    alloc="24"; zero="0"
+    _verify_l2_bitmap 0 "$alloc" "$zero"
+    $QEMU_IO -c "$corruption_test_cmd -P 11 0 64k" "$TEST_IMG" | _filter_qemu_io
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
+echo
+echo "### qemu-img measure ###"
+echo
+echo "# 512MB, extended_l2=off" # This needs one L2 table
+$QEMU_IMG measure --size 512M -O qcow2 -o extended_l2=off
+echo "# 512MB, extended_l2=on"  # This needs two L2 tables
+$QEMU_IMG measure --size 512M -O qcow2 -o extended_l2=on
+
+echo "# 16K clusters, 64GB, extended_l2=off" # This needs one L1 table
+$QEMU_IMG measure --size 64G -O qcow2 -o cluster_size=16k,extended_l2=off
+echo "# 16K clusters, 64GB, extended_l2=on"  # This needs two L2 tables
+$QEMU_IMG measure --size 64G -O qcow2 -o cluster_size=16k,extended_l2=on
+
+echo "# 8k clusters" # This should fail
+$QEMU_IMG measure --size 1M -O qcow2 -o cluster_size=8k,extended_l2=on
+
+echo "# 1024 TB" # Maximum allowed size with extended_l2=on and 64K clusters
+$QEMU_IMG measure --size 1024T -O qcow2 -o extended_l2=on
+echo "# 1025 TB" # This should fail
+$QEMU_IMG measure --size 1025T -O qcow2 -o extended_l2=on
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
+
diff --git a/tests/qemu-iotests/271.out b/tests/qemu-iotests/271.out
new file mode 100644
index 0000000000..c36dcaafc4
--- /dev/null
+++ b/tests/qemu-iotests/271.out
@@ -0,0 +1,244 @@
+QA output created by 271
+
+### Standard write tests (backing file: yes) ###
+
+Formatting 'TEST_DIR/t.IMGFMT.raw', fmt=raw size=1048576
+Formatting 'TEST_DIR/t.IMGFMT.backing', fmt=raw size=1048576
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.backing
+write -q -P 1 0 1k
+L2 entry #0: 0x8000000000050000 0000000000000001
+write -q -P 2 3k 512
+L2 entry #0: 0x8000000000050000 0000000000000003
+write -q -P 3 5k 1k
+L2 entry #0: 0x8000000000050000 0000000000000007
+write -q -P 4 6k 2k
+L2 entry #0: 0x8000000000050000 000000000000000f
+write -q -P 5 8k 6k
+L2 entry #0: 0x8000000000050000 000000000000007f
+write -q -P 6 15k 4k
+L2 entry #0: 0x8000000000050000 00000000000003ff
+write -q -P 7 32k 1k
+L2 entry #0: 0x8000000000050000 00000000000103ff
+write -q -P 8 63k 4k
+L2 entry #0: 0x8000000000050000 00000000800103ff
+L2 entry #1: 0x8000000000060000 0000000000000003
+write -q -z 2k 2k
+L2 entry #0: 0x8000000000050000 00000000800103ff
+write -q -z 0 64k
+L2 entry #0: 0x8000000000050000 ffffffff00000000
+write -q -P 9 0 64k
+L2 entry #0: 0x8000000000050000 00000000ffffffff
+write -q -z -u 0 32k
+L2 entry #0: 0x8000000000050000 00000000ffffffff
+write -q -z -u 0 64k
+L2 entry #0: 0x0000000000000000 ffffffff00000000
+write -q -P 10 3k 512
+L2 entry #0: 0x8000000000050000 fffffffd00000002
+write -q -P 11 0 64k
+L2 entry #0: 0x8000000000050000 00000000ffffffff
+discard -q 0 64k
+L2 entry #0: 0x0000000000000000 ffffffff00000000
+write -q -c -P 12 0 64k
+L2 entry #0: 0x4000000000050000 0000000000000000
+write -q -P 13 3k 512
+L2 entry #0: 0x8000000000070000 00000000ffffffff
+write -q -z 128k 64k
+L2 entry #2: 0x0000000000000000 ffffffff00000000
+write -q -z 192k 32k
+L2 entry #3: 0x8000000000050000 000000000000ffff
+
+### Standard write tests (backing file: no) ###
+
+Formatting 'TEST_DIR/t.IMGFMT.raw', fmt=raw size=1048576
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+write -q -P 1 0 1k
+L2 entry #0: 0x8000000000050000 0000000000000001
+write -q -P 2 3k 512
+L2 entry #0: 0x8000000000050000 0000000000000003
+write -q -P 3 5k 1k
+L2 entry #0: 0x8000000000050000 0000000000000007
+write -q -P 4 6k 2k
+L2 entry #0: 0x8000000000050000 000000000000000f
+write -q -P 5 8k 6k
+L2 entry #0: 0x8000000000050000 000000000000007f
+write -q -P 6 15k 4k
+L2 entry #0: 0x8000000000050000 00000000000003ff
+write -q -P 7 32k 1k
+L2 entry #0: 0x8000000000050000 00000000000103ff
+write -q -P 8 63k 4k
+L2 entry #0: 0x8000000000050000 00000000800103ff
+L2 entry #1: 0x8000000000060000 0000000000000003
+write -q -z 2k 2k
+L2 entry #0: 0x8000000000050000 00000000800103ff
+write -q -z 0 64k
+L2 entry #0: 0x8000000000050000 ffffffff00000000
+write -q -P 9 0 64k
+L2 entry #0: 0x8000000000050000 00000000ffffffff
+write -q -z -u 0 32k
+L2 entry #0: 0x8000000000050000 00000000ffffffff
+write -q -z -u 0 64k
+L2 entry #0: 0x0000000000000000 ffffffff00000000
+write -q -P 10 3k 512
+L2 entry #0: 0x8000000000050000 fffffffd00000002
+write -q -P 11 0 64k
+L2 entry #0: 0x8000000000050000 00000000ffffffff
+discard -q 0 64k
+L2 entry #0: 0x0000000000000000 ffffffff00000000
+write -q -c -P 12 0 64k
+L2 entry #0: 0x4000000000050000 0000000000000000
+write -q -P 13 3k 512
+L2 entry #0: 0x8000000000070000 00000000ffffffff
+write -q -z 128k 64k
+L2 entry #2: 0x0000000000000000 ffffffff00000000
+write -q -z 192k 32k
+L2 entry #3: 0x0000000000000000 ffffffff00000000
+
+### Discarding clusters with non-zero bitmaps (backing file: yes) ###
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.backing
+L2 entry #0: 0x0000000000000000 ffffffff00000000
+L2 entry #1: 0x0000000000000000 ffffffff00000000
+Image resized.
+Image resized.
+L2 entry #0: 0x0000000000000000 ffffffff00000000
+L2 entry #1: 0x0000000000000000 0000000000000000
+
+### Discarding clusters with non-zero bitmaps (backing file: no) ###
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+L2 entry #0: 0x0000000000000000 ffffffff00000000
+L2 entry #1: 0x0000000000000000 ffffffff00000000
+Image resized.
+Image resized.
+L2 entry #0: 0x0000000000000000 0000ffff00000000
+L2 entry #1: 0x0000000000000000 0000000000000000
+
+### Corrupted L2 entries - read test (allocated) ###
+
+# 'cluster is zero' bit set on the standard cluster descriptor
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+L2 entry #0: 0x8000000000050001 0000000000000001
+qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
+read failed: Input/output error
+
+# Both 'subcluster is zero' and 'subcluster is allocated' bits set
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+L2 entry #0: 0x8000000000050000 0000000100000001
+qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
+read failed: Input/output error
+
+### Corrupted L2 entries - read test (unallocated) ###
+
+# 'cluster is zero' bit set on the standard cluster descriptor
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+L2 entry #0: 0x0000000000000001 0000000000000000
+qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
+read failed: Input/output error
+
+# 'subcluster is allocated' bit set
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+L2 entry #0: 0x0000000000000000 0000000000000001
+qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
+read failed: Input/output error
+
+# Both 'subcluster is zero' and 'subcluster is allocated' bits set
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+L2 entry #0: 0x0000000000000000 0000000100000001
+qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
+read failed: Input/output error
+
+### Compressed cluster with subcluster bitmap != 0 - read test ###
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+L2 entry #0: 0x4000000000050000 0000000101000000
+read 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+### Corrupted L2 entries - write test (allocated) ###
+
+# 'cluster is zero' bit set on the standard cluster descriptor
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+L2 entry #0: 0x8000000000050001 0000000000000001
+qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
+write failed: Input/output error
+
+# Both 'subcluster is zero' and 'subcluster is allocated' bits set
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+L2 entry #0: 0x8000000000050000 0000000100000001
+qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
+write failed: Input/output error
+
+### Corrupted L2 entries - write test (unallocated) ###
+
+# 'cluster is zero' bit set on the standard cluster descriptor
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+L2 entry #0: 0x0000000000000001 0000000000000000
+qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
+write failed: Input/output error
+
+# 'subcluster is allocated' bit set
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+L2 entry #0: 0x0000000000000000 0000000000000001
+qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
+write failed: Input/output error
+
+# Both 'subcluster is zero' and 'subcluster is allocated' bits set
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+L2 entry #0: 0x0000000000000000 0000000100000001
+qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
+write failed: Input/output error
+
+### Compressed cluster with subcluster bitmap != 0 - write test ###
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+L2 entry #0: 0x4000000000050000 0000000101000000
+wrote 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+### Image creation options ###
+
+# cluster_size < 16k
+qemu-img: TEST_DIR/t.IMGFMT: Extended L2 entries are only supported with cluster sizes of at least 16384 bytes
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+# backing file and preallocation=metadata
+qemu-img: TEST_DIR/t.IMGFMT: Backing file and preallocation cannot be used at the same time
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.backing preallocation=metadata
+# backing file and preallocation=falloc
+qemu-img: TEST_DIR/t.IMGFMT: Backing file and preallocation cannot be used at the same time
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.backing preallocation=falloc
+# backing file and preallocation=full
+qemu-img: TEST_DIR/t.IMGFMT: Backing file and preallocation cannot be used at the same time
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.backing preallocation=full
+
+### qemu-img measure ###
+
+# 512MB, extended_l2=off
+required size: 327680
+fully allocated size: 537198592
+# 512MB, extended_l2=on
+required size: 393216
+fully allocated size: 537264128
+# 16K clusters, 64GB, extended_l2=off
+required size: 42008576
+fully allocated size: 68761485312
+# 16K clusters, 64GB, extended_l2=on
+required size: 75579392
+fully allocated size: 68795056128
+# 8k clusters
+qemu-img: Extended L2 entries are only supported with cluster sizes of at least 16384 bytes
+# 1024 TB
+required size: 309285027840
+fully allocated size: 1126209191870464
+# 1025 TB
+qemu-img: The image size is too large (try using a larger cluster size)
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index ec2b2302e5..d7b0e03737 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -284,6 +284,7 @@
 267 rw auto quick snapshot
 268 rw auto quick
 270 rw backing quick
+271 rw auto
 272 rw
 273 backing quick
 277 rw quick
-- 
2.20.1


