Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6035BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 18:30:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0610B20671
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 18:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="qWTA1wu+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0610B20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdHrv-0005Ab-8I
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 14:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jdHXz-0004Fu-Oh; Mon, 25 May 2020 14:09:59 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:51101)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jdHXp-0007qB-Jd; Mon, 25 May 2020 14:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=2GTZxdPC1KRB/CooM/8Z/rox7iMvqhdJWjaOaGyDg/M=; 
 b=qWTA1wu+nQTqqQ0qh6UTIxqVMG4cHT9eiZUNH94M018aDjXfMlwj20QlWmgxE1/+nL/Us5C2C4UVHty8RRiU7E+E5fD48+5zOAGRMoe7Y3LYXwWI8FXpgE1wkzBlEkfddb2gEzlTqMqeX3PuziT+ad2Khr2ewbrIdE7CgwdD/+Nqjuj96m3H8aepKrhxR9DeHG1nKupgiLp/BEIKf0fTo0wPpnXn2Tl8W/IAyfxUxNETugHi4Ld7HDD2/QpDxbBxXa8mRBOwQ1kIQkRzm2MVe35ekNmyYWFPNPAVGt2cVDbH6Gq+0XmUDcHv94A8Is/BXftraD3jqBcR7BBpd82k4A==;
Received: from [81.0.38.199] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jdHXP-00088n-Ih; Mon, 25 May 2020 20:09:23 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jdHXA-0002Nt-H8; Mon, 25 May 2020 20:09:08 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 32/32] iotests: Add tests for qcow2 images with extended L2
 entries
Date: Mon, 25 May 2020 20:08:57 +0200
Message-Id: <117ba99f5a1fbea62cfed60fe74a460cc628948f.1590429902.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1590429901.git.berto@igalia.com>
References: <cover.1590429901.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 14:09:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Derek Su <dereksu@qnap.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 tests/qemu-iotests/271     | 705 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/271.out | 603 +++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 1309 insertions(+)
 create mode 100755 tests/qemu-iotests/271
 create mode 100644 tests/qemu-iotests/271.out

diff --git a/tests/qemu-iotests/271 b/tests/qemu-iotests/271
new file mode 100755
index 0000000000..4dd11772cf
--- /dev/null
+++ b/tests/qemu-iotests/271
@@ -0,0 +1,705 @@
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
+_unsupported_imgopts extended_l2 compat=0.10 cluster_size data_file
+
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
+    entry_no="$1"            # L2 entry number, starting from 0
+    expected_alloc="$alloc"  # Space-separated list of allocated subcluster indexes
+    expected_zero="$zero"    # Space-separated list of zero subcluster indexes
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
+    l2_entry_idx="$2"
+    [ -n "$l2_entry_idx" ] || l2_entry_idx=0
+    raw_cmd=`echo $cmd | sed s/-c//` # Raw images don't support -c
+    echo "$cmd"
+    $QEMU_IO -c "$cmd" "$TEST_IMG" | _filter_qemu_io
+    $QEMU_IO -c "$raw_cmd" -f raw "$TEST_IMG.raw" | _filter_qemu_io
+    _verify_img
+    _verify_l2_bitmap "$l2_entry_idx"
+}
+
+_reset_img()
+{
+    size="$1"
+    $QEMU_IMG create -f raw "$TEST_IMG.raw" "$size" | _filter_img_create
+    if [ "$use_backing_file" = "yes" ]; then
+        $QEMU_IMG create -f raw "$TEST_IMG.base" "$size" | _filter_img_create
+        $QEMU_IO -c "write -q -P 0xFF 0 $size" -f raw "$TEST_IMG.base" | _filter_qemu_io
+        $QEMU_IO -c "write -q -P 0xFF 0 $size" -f raw "$TEST_IMG.raw" | _filter_qemu_io
+        _make_test_img -o extended_l2=on -b "$TEST_IMG.base" "$size"
+    else
+        _make_test_img -o extended_l2=on "$size"
+    fi
+}
+
+# Test that writing to an image with subclusters produces the expected
+# results, in images with and without backing files
+for use_backing_file in yes no; do
+    echo
+    echo "### Standard write tests (backing file: $use_backing_file) ###"
+    echo
+    _reset_img 1M
+    ### Write subcluster #0 (beginning of subcluster) ###
+    alloc="0"; zero=""
+    _test_write 'write -q -P 1 0 1k'
+
+    ### Write subcluster #1 (middle of subcluster) ###
+    alloc="0 1"; zero=""
+    _test_write 'write -q -P 2 3k 512'
+
+    ### Write subcluster #2 (end of subcluster) ###
+    alloc="0 1 2"; zero=""
+    _test_write 'write -q -P 3 5k 1k'
+
+    ### Write subcluster #3 (full subcluster) ###
+    alloc="0 1 2 3"; zero=""
+    _test_write 'write -q -P 4 6k 2k'
+
+    ### Write subclusters #4-6 (full subclusters) ###
+    alloc="`seq 0 6`"; zero=""
+    _test_write 'write -q -P 5 8k 6k'
+
+    ### Write subclusters #7-9 (partial subclusters) ###
+    alloc="`seq 0 9`"; zero=""
+    _test_write 'write -q -P 6 15k 4k'
+
+    ### Write subcluster #16 (partial subcluster) ###
+    alloc="`seq 0 9` 16"; zero=""
+    _test_write 'write -q -P 7 32k 1k'
+
+    ### Write subcluster #31-#33 (cluster overlap) ###
+    alloc="`seq 0 9` 16 31"; zero=""
+    _test_write 'write -q -P 8 63k 4k'
+    alloc="0 1" ; zero=""
+    _verify_l2_bitmap 1
+
+    ### Zero subcluster #1
+    alloc="0 `seq 2 9` 16 31"; zero="1"
+    _test_write 'write -q -z 2k 2k'
+
+    ### Zero cluster #0
+    alloc=""; zero="`seq 0 31`"
+    _test_write 'write -q -z 0 64k'
+
+    ### Fill cluster #0 with data
+    alloc="`seq 0 31`"; zero=""
+    _test_write 'write -q -P 9 0 64k'
+
+    ### Zero and unmap half of cluster #0 (this won't unmap it)
+    alloc="`seq 16 31`"; zero="`seq 0 15`"
+    _test_write 'write -q -z -u 0 32k'
+
+    ### Zero and unmap cluster #0
+    alloc=""; zero="`seq 0 31`"
+    _test_write 'write -q -z -u 0 64k'
+
+    ### Write subcluster #1 (middle of subcluster)
+    alloc="1"; zero="0 `seq 2 31`"
+    _test_write 'write -q -P 10 3k 512'
+
+    ### Fill cluster #0 with data
+    alloc="`seq 0 31`"; zero=""
+    _test_write 'write -q -P 11 0 64k'
+
+    ### Discard cluster #0
+    alloc=""; zero="`seq 0 31`"
+    _test_write 'discard -q 0 64k'
+
+    ### Write compressed data to cluster #0
+    alloc=""; zero=""
+    _test_write 'write -q -c -P 12 0 64k'
+
+    ### Write subcluster #2 (middle of subcluster)
+    alloc="`seq 0 31`"; zero=""
+    _test_write 'write -q -P 13 3k 512'
+done
+
+# calculate_l2_meta() checks if none of the clusters affected by a
+# write operation need COW or changes to their L2 metadata and simply
+# returns when they don't. This is a test for that optimization.
+# Here clusters #0-#3 are overwritten but only #1 and #2 need changes.
+echo
+echo '### Overwriting several clusters without COW ###'
+echo
+use_backing_file="no" _reset_img 1M
+# Write cluster #0, subclusters #12-#31
+alloc="`seq 12 31`"; zero=""
+_test_write 'write -q 24k 40k' 0
+
+# Write cluster #1, subcluster #13
+alloc="13"; zero=""
+_test_write 'write -q 90k 2k' 1
+
+# Zeroize cluster #2, subcluster #14
+alloc="14"; zero=""
+_test_write 'write -q 156k 2k' 2
+alloc=""; zero="14"
+_test_write 'write -q -z 156k 2k' 2
+
+# Write cluster #3, subclusters #15-#31
+alloc="`seq 0 16`"; zero=""
+_test_write 'write -q 192k 34k' 3
+
+# Write from cluster #0, subcluster #12 to cluster #3, subcluster #11
+alloc="`seq 12 31`"; zero=""
+_test_write 'write -q 24k 192k' 0
+
+alloc="`seq 0 31`"; zero=""
+_verify_l2_bitmap 1
+_verify_l2_bitmap 2
+
+alloc="`seq 0 16`"; zero=""
+_verify_l2_bitmap 3
+
+# Test different patterns of writing zeroes
+for use_backing_file in yes no; do
+    echo
+    echo "### Writing zeroes 1: unallocated clusters (backing file: $use_backing_file) ###"
+    echo
+    # Note that the image size is not a multiple of the cluster size
+    _reset_img 2083k
+
+    # Cluster-aligned request from clusters #0 to #2
+    alloc=""; zero="`seq 0 31`"
+    _test_write 'write -q -z 0 192k' 0
+    _verify_l2_bitmap 1
+    _verify_l2_bitmap 2
+
+    # Subcluster-aligned request from clusters #3 to #5
+    alloc=""; zero="`seq 16 31`"
+    _test_write 'write -q -z 224k 128k' 3
+    alloc=""; zero="`seq 0 31`"
+    _verify_l2_bitmap 4
+    alloc=""; zero="`seq 0 15`"
+    _verify_l2_bitmap 5
+
+    # Unaligned request from clusters #6 to #8
+    if [ "$use_backing_file" = "yes" ]; then
+        alloc="15"; zero="`seq 16 31`" # copy-on-write happening here
+    else
+        alloc=""; zero="`seq 15 31`"
+    fi
+    _test_write 'write -q -z 415k 128k' 6
+    alloc=""; zero="`seq 0 31`"
+    _verify_l2_bitmap 7
+    if [ "$use_backing_file" = "yes" ]; then
+        alloc="15"; zero="`seq 0 14`" # copy-on-write happening here
+    else
+        alloc=""; zero="`seq 0 15`"
+    fi
+    _verify_l2_bitmap 8
+
+    echo
+    echo "### Writing zeroes 2: allocated clusters (backing file: $use_backing_file) ###"
+    echo
+    alloc="`seq 0 31`"; zero=""
+    _test_write 'write -q -P 1 576k 576k' 9
+    _verify_l2_bitmap 10
+    _verify_l2_bitmap 11
+    _verify_l2_bitmap 12
+    _verify_l2_bitmap 13
+    _verify_l2_bitmap 14
+    _verify_l2_bitmap 15
+    _verify_l2_bitmap 16
+    _verify_l2_bitmap 17
+
+    # Cluster-aligned request from clusters #9 to #11
+    alloc=""; zero="`seq 0 31`"
+    _test_write 'write -q -z 576k 192k' 9
+    _verify_l2_bitmap 10
+    _verify_l2_bitmap 11
+
+    # Subcluster-aligned request from clusters #12 to #14
+    alloc="`seq 0 15`"; zero="`seq 16 31`"
+    _test_write 'write -q -z 800k 128k' 12
+    alloc=""; zero="`seq 0 31`"
+    _verify_l2_bitmap 13
+    alloc="`seq 16 31`"; zero="`seq 0 15`"
+    _verify_l2_bitmap 14
+
+    # Unaligned request from clusters #15 to #17
+    alloc="`seq 0 15`"; zero="`seq 16 31`"
+    _test_write 'write -q -z 991k 128k' 15
+    alloc=""; zero="`seq 0 31`"
+    _verify_l2_bitmap 16
+    alloc="`seq 15 31`"; zero="`seq 0 14`"
+    _verify_l2_bitmap 17
+
+    echo
+    echo "### Writing zeroes 3: compressed clusters (backing file: $use_backing_file) ###"
+    echo
+    alloc=""; zero=""
+    for c in `seq 18 28`; do
+        _test_write "write -q -c -P 2 $(($c*64))k 64k" $c
+    done
+
+    # Cluster-aligned request from clusters #18 to #20
+    alloc=""; zero="`seq 0 31`"
+    _test_write 'write -q -z 1152k 192k' 18
+    _verify_l2_bitmap 19
+    _verify_l2_bitmap 20
+
+    # Subcluster-aligned request from clusters #21 to #23.
+    # We cannot partially zero a compressed cluster so the code
+    # returns -ENOTSUP, which means copy-on-write of the compressed
+    # data and fill the rest with actual zeroes on disk.
+    # TODO: cluster #22 should use the 'all zeroes' bits.
+    alloc="`seq 0 31`"; zero=""
+    _test_write 'write -q -z 1376k 128k' 21
+    _verify_l2_bitmap 22
+    _verify_l2_bitmap 23
+
+    # Unaligned request from clusters #24 to #26
+    # In this case QEMU internally sends a 1k request followed by a
+    # subcluster-aligned 128k request. The first request decompresses
+    # cluster #24, but that's not enough to perform efficiently the
+    # second request because it partially writes to cluster #26 (which
+    # is compressed) so we hit the same problem as before.
+    alloc="`seq 0 31`"; zero=""
+    _test_write 'write -q -z 1567k 129k' 24
+    _verify_l2_bitmap 25
+    _verify_l2_bitmap 26
+
+    # Unaligned request from clusters #27 to #29
+    # Similar to the previous case, but this time the tail of the
+    # request does not correspond to a compressed cluster, so it can
+    # be zeroed efficiently.
+    # Note that the very last subcluster is partially written, so if
+    # there's a backing file we need to perform cow.
+    alloc="`seq 0 15`"; zero="`seq 16 31`"
+    _test_write 'write -q -z 1759k 128k' 27
+    alloc=""; zero="`seq 0 31`"
+    _verify_l2_bitmap 28
+    if [ "$use_backing_file" = "yes" ]; then
+        alloc="15"; zero="`seq 0 14`" # copy-on-write happening here
+    else
+        alloc=""; zero="`seq 0 15`"
+    fi
+    _verify_l2_bitmap 29
+
+    echo
+    echo "### Writing zeroes 4: other tests (backing file: $use_backing_file) ###"
+    echo
+    # Unaligned request in the middle of cluster #30.
+    # If there's a backing file we need to allocate and do
+    # copy-on-write on the partially zeroed subclusters.
+    # If not we can set the 'all zeroes' bit on them.
+    if [ "$use_backing_file" = "yes" ]; then
+        alloc="15 19"; zero="`seq 16 18`" # copy-on-write happening here
+    else
+        alloc=""; zero="`seq 15 19`"
+    fi
+    _test_write 'write -q -z 1951k 8k' 30
+
+    # Fill the last cluster with zeroes, up to the end of the image
+    # (the image size is not a multiple of the cluster or subcluster size).
+    alloc=""; zero="`seq 0 17`"
+    _test_write 'write -q -z 2048k 35k' 32
+done
+
+# Zero + unmap
+for use_backing_file in yes no; do
+    echo
+    echo "### Zero + unmap 1: allocated clusters (backing file: $use_backing_file) ###"
+    echo
+    # Note that the image size is not a multiple of the cluster size
+    _reset_img 2083k
+    alloc="`seq 0 31`"; zero=""
+    _test_write 'write -q -P 1 576k 576k' 9
+    _verify_l2_bitmap 10
+    _verify_l2_bitmap 11
+    _verify_l2_bitmap 12
+    _verify_l2_bitmap 13
+    _verify_l2_bitmap 14
+    _verify_l2_bitmap 15
+    _verify_l2_bitmap 16
+    _verify_l2_bitmap 17
+
+    # Cluster-aligned request from clusters #9 to #11
+    alloc=""; zero="`seq 0 31`"
+    _test_write 'write -q -z -u 576k 192k' 9
+    _verify_l2_bitmap 10
+    _verify_l2_bitmap 11
+
+    # Subcluster-aligned request from clusters #12 to #14
+    alloc="`seq 0 15`"; zero="`seq 16 31`"
+    _test_write 'write -q -z -u 800k 128k' 12
+    alloc=""; zero="`seq 0 31`"
+    _verify_l2_bitmap 13
+    alloc="`seq 16 31`"; zero="`seq 0 15`"
+    _verify_l2_bitmap 14
+
+    # Unaligned request from clusters #15 to #17
+    alloc="`seq 0 15`"; zero="`seq 16 31`"
+    _test_write 'write -q -z -u 991k 128k' 15
+    alloc=""; zero="`seq 0 31`"
+    _verify_l2_bitmap 16
+    alloc="`seq 15 31`"; zero="`seq 0 14`"
+    _verify_l2_bitmap 17
+
+    echo
+    echo "### Zero + unmap 2: compressed clusters (backing file: $use_backing_file) ###"
+    echo
+    alloc=""; zero=""
+    for c in `seq 18 28`; do
+        _test_write "write -q -c -P 2 $(($c*64))k 64k" $c
+    done
+
+    # Cluster-aligned request from clusters #18 to #20
+    alloc=""; zero="`seq 0 31`"
+    _test_write 'write -q -z -u 1152k 192k' 18
+    _verify_l2_bitmap 19
+    _verify_l2_bitmap 20
+
+    # Subcluster-aligned request from clusters #21 to #23.
+    # We cannot partially zero a compressed cluster so the code
+    # returns -ENOTSUP, which means copy-on-write of the compressed
+    # data and fill the rest with actual zeroes on disk.
+    # TODO: cluster #22 should use the 'all zeroes' bits.
+    alloc="`seq 0 31`"; zero=""
+    _test_write 'write -q -z -u 1376k 128k' 21
+    _verify_l2_bitmap 22
+    _verify_l2_bitmap 23
+
+    # Unaligned request from clusters #24 to #26
+    # In this case QEMU internally sends a 1k request followed by a
+    # subcluster-aligned 128k request. The first request decompresses
+    # cluster #24, but that's not enough to perform efficiently the
+    # second request because it partially writes to cluster #26 (which
+    # is compressed) so we hit the same problem as before.
+    alloc="`seq 0 31`"; zero=""
+    _test_write 'write -q -z -u 1567k 129k' 24
+    _verify_l2_bitmap 25
+    _verify_l2_bitmap 26
+
+    # Unaligned request from clusters #27 to #29
+    # Similar to the previous case, but this time the tail of the
+    # request does not correspond to a compressed cluster, so it can
+    # be zeroed efficiently.
+    # Note that the very last subcluster is partially written, so if
+    # there's a backing file we need to perform cow.
+    alloc="`seq 0 15`"; zero="`seq 16 31`"
+    _test_write 'write -q -z -u 1759k 128k' 27
+    alloc=""; zero="`seq 0 31`"
+    _verify_l2_bitmap 28
+    if [ "$use_backing_file" = "yes" ]; then
+        alloc="15"; zero="`seq 0 14`" # copy-on-write happening here
+    else
+        alloc=""; zero="`seq 0 15`"
+    fi
+    _verify_l2_bitmap 29
+done
+
+# Test qcow2_cluster_discard() with full and normal discards
+for use_backing_file in yes no; do
+    echo
+    echo "### Discarding clusters with non-zero bitmaps (backing file: $use_backing_file) ###"
+    echo
+    if [ "$use_backing_file" = "yes" ]; then
+        _make_test_img -o extended_l2=on -b "$TEST_IMG.base" 1M
+    else
+        _make_test_img -o extended_l2=on 1M
+    fi
+    # Write clusters #0-#2 and then discard them
+    $QEMU_IO -c 'write -q 0 128k' "$TEST_IMG"
+    $QEMU_IO -c 'discard -q 0 128k' "$TEST_IMG"
+    # 'qemu-io discard' doesn't do a full discard, it zeroizes the
+    # cluster, so both clusters have all zero bits set now
+    alloc=""; zero="`seq 0 31`"
+    _verify_l2_bitmap 0
+    _verify_l2_bitmap 1
+    # Now mark the 2nd half of the subclusters from cluster #0 as unallocated
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
+    _verify_l2_bitmap 0
+    # A full discard should clear the L2 entry completely. However
+    # when growing an image with a backing file the new clusters are
+    # zeroized to hide the stale data from the backing file
+    if [ "$use_backing_file" = "yes" ]; then
+        alloc=""; zero="`seq 0 31`"
+    else
+        alloc=""; zero=""
+    fi
+    _verify_l2_bitmap 1
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
+    # We actually don't consider this a corrupted image.
+    # The 'cluster is zero' bit is unused is unused in extended L2 entries
+    # so QEMU ignores it.
+    # TODO: maybe treat the image as corrupted and make qemu-img check fix it?
+    _make_test_img -o extended_l2=on 1M
+    $QEMU_IO -c 'write -q -P 0x11 0 2k' "$TEST_IMG"
+    poke_file "$TEST_IMG" $(($l2_offset+7)) "\x01"
+    alloc="0"; zero=""
+    _verify_l2_bitmap 0
+    $QEMU_IO -c "$corruption_test_cmd -q -P 0x11 0 1k" "$TEST_IMG"
+    if [ "$corruption_test_cmd" = "write" ]; then
+        alloc="0"; zero=""
+    fi
+    _verify_l2_bitmap 0
+
+    echo
+    echo "# Both 'subcluster is zero' and 'subcluster is allocated' bits set"
+    echo
+    _make_test_img -o extended_l2=on 1M
+    # Write from the middle of cluster #0 to the middle of cluster #2
+    $QEMU_IO -c 'write -q 32k 128k' "$TEST_IMG"
+    # Corrupt the L2 entry from cluster #1
+    poke_file "$TEST_IMG" $(($l2_offset+24)) "\x00\x00\x00\x01"
+    alloc="`seq 0 31`"; zero="0"
+    _verify_l2_bitmap 1
+    $QEMU_IO -c "$corruption_test_cmd 0 192k" "$TEST_IMG"
+
+    echo
+    echo "### Corrupted L2 entries - $corruption_test_cmd test (unallocated) ###"
+    echo
+    echo "# 'cluster is zero' bit set on the standard cluster descriptor"
+    echo
+    # We actually don't consider this a corrupted image.
+    # The 'cluster is zero' bit is unused is unused in extended L2 entries
+    # so QEMU ignores it.
+    # TODO: maybe treat the image as corrupted and make qemu-img check fix it?
+    _make_test_img -o extended_l2=on 1M
+    # We want to modify the (empty) L2 entry from cluster #0,
+    # but we write to #4 in order to initialize the L2 table first
+    $QEMU_IO -c 'write -q 256k 1k' "$TEST_IMG"
+    poke_file "$TEST_IMG" $(($l2_offset+7)) "\x01"
+    alloc=""; zero=""
+    _verify_l2_bitmap 0
+    $QEMU_IO -c "$corruption_test_cmd -q 0 1k" "$TEST_IMG"
+    if [ "$corruption_test_cmd" = "write" ]; then
+        alloc="0"; zero=""
+    fi
+    _verify_l2_bitmap 0
+
+    echo
+    echo "# 'subcluster is allocated' bit set"
+    echo
+    _make_test_img -o extended_l2=on 1M
+    # We want to corrupt the (empty) L2 entry from cluster #0,
+    # but we write to #4 in order to initialize the L2 table first
+    $QEMU_IO -c 'write -q 256k 1k' "$TEST_IMG"
+    poke_file "$TEST_IMG" $(($l2_offset+15)) "\x01"
+    alloc="0"; zero=""
+    _verify_l2_bitmap 0
+    $QEMU_IO -c "$corruption_test_cmd 0 1k" "$TEST_IMG"
+
+    echo
+    echo "# Both 'subcluster is zero' and 'subcluster is allocated' bits set"
+    echo
+    _make_test_img -o extended_l2=on 1M
+    # We want to corrupt the (empty) L2 entry from cluster #1,
+    # but we write to #4 in order to initialize the L2 table first
+    $QEMU_IO -c 'write -q 256k 1k' "$TEST_IMG"
+    # Corrupt the L2 entry from cluster #1
+    poke_file "$TEST_IMG" $(($l2_offset+24)) "\x00\x00\x00\x01\x00\x00\x00\x01"
+    alloc="0"; zero="0"
+    _verify_l2_bitmap 1
+    $QEMU_IO -c "$corruption_test_cmd 0 192k" "$TEST_IMG"
+
+    echo
+    echo "### Compressed cluster with subcluster bitmap != 0 - $corruption_test_cmd test ###"
+    echo
+    # We actually don't consider this a corrupted image.
+    # The bitmap in compressed clusters is unused so QEMU should just ignore it.
+    _make_test_img -o extended_l2=on 1M
+    $QEMU_IO -c 'write -q -P 11 -c 0 64k' "$TEST_IMG"
+    # Change the L2 bitmap to allocate subcluster #31 and zeroize subcluster #0
+    poke_file "$TEST_IMG" $(($l2_offset+11)) "\x01\x80"
+    alloc="31"; zero="0"
+    _verify_l2_bitmap 0
+    $QEMU_IO -c "$corruption_test_cmd -P 11 0 64k" "$TEST_IMG" | _filter_qemu_io
+    # Writing allocates a new uncompressed cluster so we get a new bitmap
+    if [ "$corruption_test_cmd" = "write" ]; then
+        alloc="`seq 0 31`"; zero=""
+    fi
+    _verify_l2_bitmap 0
+done
+
+echo
+echo "### Image creation options ###"
+echo
+echo "# cluster_size < 16k"
+_make_test_img -o extended_l2=on,cluster_size=8k 1M
+
+# TODO: allow preallocation with backing files when subclusters are used
+echo "# backing file and preallocation=metadata"
+_make_test_img -o extended_l2=on,preallocation=metadata -b "$TEST_IMG.base" 1M
+
+echo "# backing file and preallocation=falloc"
+_make_test_img -o extended_l2=on,preallocation=falloc -b "$TEST_IMG.base" 1M
+
+echo "# backing file and preallocation=full"
+_make_test_img -o extended_l2=on,preallocation=full -b "$TEST_IMG.base" 1M
+
+echo
+echo "### qemu-img measure ###"
+echo
+echo "# 512MB, extended_l2=off" # This needs one L2 table
+$QEMU_IMG measure --size 512M -O qcow2 -o extended_l2=off
+echo "# 512MB, extended_l2=on"  # This needs two L2 tables
+$QEMU_IMG measure --size 512M -O qcow2 -o extended_l2=on
+
+echo "# 16K clusters, 64GB, extended_l2=off" # This needs one full L1 table cluster
+$QEMU_IMG measure --size 64G -O qcow2 -o cluster_size=16k,extended_l2=off
+echo "# 16K clusters, 64GB, extended_l2=on"  # This needs two full L2 table clusters
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
+echo
+echo "### qemu-img amend ###"
+echo
+_make_test_img -o extended_l2=on 1M
+$QEMU_IMG amend -o extended_l2=off "$TEST_IMG"
+
+_make_test_img -o extended_l2=off 1M
+$QEMU_IMG amend -o extended_l2=on "$TEST_IMG"
+
+echo
+echo "### Test copy-on-write on an image with snapshots ###"
+echo
+_make_test_img -o extended_l2=on 1M
+
+# For each cluster from #0 to #9 this loop zeroes subcluster #7
+# and allocates subclusters #13 and #18.
+alloc="13 18"; zero="7"
+for c in `seq 0 9`; do
+    $QEMU_IO -c "write -q -z $((64*$c+14))k 2k" \
+             -c "write -q -P $((0xd0+$c)) $((64*$c+26))k 2k" \
+             -c "write -q -P $((0xe0+$c)) $((64*$c+36))k 2k" "$TEST_IMG"
+    _verify_l2_bitmap "$c"
+done
+
+# Create a snapshot and set l2_offset to the new L2 table
+$QEMU_IMG snapshot -c snap1 "$TEST_IMG"
+l2_offset=1114112 # 0x110000
+
+# Write different patterns to each one of the clusters
+# in order to see how copy-on-write behaves in each case.
+$QEMU_IO -c "write -q -P 0xf0 $((64*0+30))k 1k" \
+         -c "write -q -P 0xf1 $((64*1+20))k 1k" \
+         -c "write -q -P 0xf2 $((64*2+40))k 1k" \
+         -c "write -q -P 0xf3 $((64*3+26))k 1k" \
+         -c "write -q -P 0xf4 $((64*4+14))k 1k" \
+         -c "write -q -P 0xf5 $((64*5+1))k  1k" \
+         -c "write -q -z      $((64*6+30))k 3k" \
+         -c "write -q -z      $((64*7+26))k 2k" \
+         -c "write -q -z      $((64*8+26))k 1k" \
+         -c "write -q -z      $((64*9+12))k 1k" \
+         "$TEST_IMG"
+alloc="`seq 13 18`"; zero="7" _verify_l2_bitmap 0
+alloc="`seq 10 18`"; zero="7" _verify_l2_bitmap 1
+alloc="`seq 13 20`"; zero="7" _verify_l2_bitmap 2
+alloc="`seq 13 18`"; zero="7" _verify_l2_bitmap 3
+alloc="`seq 7 18`";  zero=""  _verify_l2_bitmap 4
+alloc="`seq 0 18`";  zero=""  _verify_l2_bitmap 5
+alloc="13 18"; zero="7 15 16" _verify_l2_bitmap 6
+alloc="18";       zero="7 13" _verify_l2_bitmap 7
+alloc="`seq 13 18`"; zero="7" _verify_l2_bitmap 8
+alloc="13 18";     zero="6 7" _verify_l2_bitmap 9
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/271.out b/tests/qemu-iotests/271.out
new file mode 100644
index 0000000000..6ac53d5e10
--- /dev/null
+++ b/tests/qemu-iotests/271.out
@@ -0,0 +1,603 @@
+QA output created by 271
+
+### Standard write tests (backing file: yes) ###
+
+Formatting 'TEST_DIR/t.IMGFMT.raw', fmt=raw size=1048576
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=raw size=1048576
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.base
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
+L2 entry #0: 0x8000000000050000 00000002800103fd
+write -q -z 0 64k
+L2 entry #0: 0x8000000000050000 ffffffff00000000
+write -q -P 9 0 64k
+L2 entry #0: 0x8000000000050000 00000000ffffffff
+write -q -z -u 0 32k
+L2 entry #0: 0x8000000000050000 0000ffffffff0000
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
+L2 entry #0: 0x8000000000050000 00000002800103fd
+write -q -z 0 64k
+L2 entry #0: 0x8000000000050000 ffffffff00000000
+write -q -P 9 0 64k
+L2 entry #0: 0x8000000000050000 00000000ffffffff
+write -q -z -u 0 32k
+L2 entry #0: 0x8000000000050000 0000ffffffff0000
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
+
+### Overwriting several clusters without COW ###
+
+Formatting 'TEST_DIR/t.IMGFMT.raw', fmt=raw size=1048576
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+write -q 24k 40k
+L2 entry #0: 0x8000000000050000 00000000fffff000
+write -q 90k 2k
+L2 entry #1: 0x8000000000060000 0000000000002000
+write -q 156k 2k
+L2 entry #2: 0x8000000000070000 0000000000004000
+write -q -z 156k 2k
+L2 entry #2: 0x8000000000070000 0000400000000000
+write -q 192k 34k
+L2 entry #3: 0x8000000000080000 000000000001ffff
+write -q 24k 192k
+L2 entry #0: 0x8000000000050000 00000000fffff000
+L2 entry #1: 0x8000000000060000 00000000ffffffff
+L2 entry #2: 0x8000000000070000 00000000ffffffff
+L2 entry #3: 0x8000000000080000 000000000001ffff
+
+### Writing zeroes 1: unallocated clusters (backing file: yes) ###
+
+Formatting 'TEST_DIR/t.IMGFMT.raw', fmt=raw size=2132992
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=raw size=2132992
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2132992 backing_file=TEST_DIR/t.IMGFMT.base
+write -q -z 0 192k
+L2 entry #0: 0x0000000000000000 ffffffff00000000
+L2 entry #1: 0x0000000000000000 ffffffff00000000
+L2 entry #2: 0x0000000000000000 ffffffff00000000
+write -q -z 224k 128k
+L2 entry #3: 0x0000000000000000 ffff000000000000
+L2 entry #4: 0x0000000000000000 ffffffff00000000
+L2 entry #5: 0x0000000000000000 0000ffff00000000
+write -q -z 415k 128k
+L2 entry #6: 0x8000000000050000 ffff000000008000
+L2 entry #7: 0x0000000000000000 ffffffff00000000
+L2 entry #8: 0x8000000000060000 00007fff00008000
+
+### Writing zeroes 2: allocated clusters (backing file: yes) ###
+
+write -q -P 1 576k 576k
+L2 entry #9: 0x8000000000070000 00000000ffffffff
+L2 entry #10: 0x8000000000080000 00000000ffffffff
+L2 entry #11: 0x8000000000090000 00000000ffffffff
+L2 entry #12: 0x80000000000a0000 00000000ffffffff
+L2 entry #13: 0x80000000000b0000 00000000ffffffff
+L2 entry #14: 0x80000000000c0000 00000000ffffffff
+L2 entry #15: 0x80000000000d0000 00000000ffffffff
+L2 entry #16: 0x80000000000e0000 00000000ffffffff
+L2 entry #17: 0x80000000000f0000 00000000ffffffff
+write -q -z 576k 192k
+L2 entry #9: 0x8000000000070000 ffffffff00000000
+L2 entry #10: 0x8000000000080000 ffffffff00000000
+L2 entry #11: 0x8000000000090000 ffffffff00000000
+write -q -z 800k 128k
+L2 entry #12: 0x80000000000a0000 ffff00000000ffff
+L2 entry #13: 0x80000000000b0000 ffffffff00000000
+L2 entry #14: 0x80000000000c0000 0000ffffffff0000
+write -q -z 991k 128k
+L2 entry #15: 0x80000000000d0000 ffff00000000ffff
+L2 entry #16: 0x80000000000e0000 ffffffff00000000
+L2 entry #17: 0x80000000000f0000 00007fffffff8000
+
+### Writing zeroes 3: compressed clusters (backing file: yes) ###
+
+write -q -c -P 2 1152k 64k
+L2 entry #18: 0x4000000000100000 0000000000000000
+write -q -c -P 2 1216k 64k
+L2 entry #19: 0x4000000000110000 0000000000000000
+write -q -c -P 2 1280k 64k
+L2 entry #20: 0x4000000000120000 0000000000000000
+write -q -c -P 2 1344k 64k
+L2 entry #21: 0x4000000000130000 0000000000000000
+write -q -c -P 2 1408k 64k
+L2 entry #22: 0x4000000000140000 0000000000000000
+write -q -c -P 2 1472k 64k
+L2 entry #23: 0x4000000000150000 0000000000000000
+write -q -c -P 2 1536k 64k
+L2 entry #24: 0x4000000000160000 0000000000000000
+write -q -c -P 2 1600k 64k
+L2 entry #25: 0x4000000000170000 0000000000000000
+write -q -c -P 2 1664k 64k
+L2 entry #26: 0x4000000000180000 0000000000000000
+write -q -c -P 2 1728k 64k
+L2 entry #27: 0x4000000000190000 0000000000000000
+write -q -c -P 2 1792k 64k
+L2 entry #28: 0x40000000001a0000 0000000000000000
+write -q -z 1152k 192k
+L2 entry #18: 0x0000000000000000 ffffffff00000000
+L2 entry #19: 0x0000000000000000 ffffffff00000000
+L2 entry #20: 0x0000000000000000 ffffffff00000000
+write -q -z 1376k 128k
+L2 entry #21: 0x8000000000100000 00000000ffffffff
+L2 entry #22: 0x8000000000110000 00000000ffffffff
+L2 entry #23: 0x8000000000120000 00000000ffffffff
+write -q -z 1567k 129k
+L2 entry #24: 0x8000000000130000 00000000ffffffff
+L2 entry #25: 0x8000000000140000 00000000ffffffff
+L2 entry #26: 0x8000000000150000 00000000ffffffff
+write -q -z 1759k 128k
+L2 entry #27: 0x8000000000160000 ffff00000000ffff
+L2 entry #28: 0x0000000000000000 ffffffff00000000
+L2 entry #29: 0x8000000000170000 00007fff00008000
+
+### Writing zeroes 4: other tests (backing file: yes) ###
+
+write -q -z 1951k 8k
+L2 entry #30: 0x8000000000180000 0007000000088000
+write -q -z 2048k 35k
+L2 entry #32: 0x0000000000000000 0003ffff00000000
+
+### Writing zeroes 1: unallocated clusters (backing file: no) ###
+
+Formatting 'TEST_DIR/t.IMGFMT.raw', fmt=raw size=2132992
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2132992
+write -q -z 0 192k
+L2 entry #0: 0x0000000000000000 ffffffff00000000
+L2 entry #1: 0x0000000000000000 ffffffff00000000
+L2 entry #2: 0x0000000000000000 ffffffff00000000
+write -q -z 224k 128k
+L2 entry #3: 0x0000000000000000 ffff000000000000
+L2 entry #4: 0x0000000000000000 ffffffff00000000
+L2 entry #5: 0x0000000000000000 0000ffff00000000
+write -q -z 415k 128k
+L2 entry #6: 0x0000000000000000 ffff800000000000
+L2 entry #7: 0x0000000000000000 ffffffff00000000
+L2 entry #8: 0x0000000000000000 0000ffff00000000
+
+### Writing zeroes 2: allocated clusters (backing file: no) ###
+
+write -q -P 1 576k 576k
+L2 entry #9: 0x8000000000050000 00000000ffffffff
+L2 entry #10: 0x8000000000060000 00000000ffffffff
+L2 entry #11: 0x8000000000070000 00000000ffffffff
+L2 entry #12: 0x8000000000080000 00000000ffffffff
+L2 entry #13: 0x8000000000090000 00000000ffffffff
+L2 entry #14: 0x80000000000a0000 00000000ffffffff
+L2 entry #15: 0x80000000000b0000 00000000ffffffff
+L2 entry #16: 0x80000000000c0000 00000000ffffffff
+L2 entry #17: 0x80000000000d0000 00000000ffffffff
+write -q -z 576k 192k
+L2 entry #9: 0x8000000000050000 ffffffff00000000
+L2 entry #10: 0x8000000000060000 ffffffff00000000
+L2 entry #11: 0x8000000000070000 ffffffff00000000
+write -q -z 800k 128k
+L2 entry #12: 0x8000000000080000 ffff00000000ffff
+L2 entry #13: 0x8000000000090000 ffffffff00000000
+L2 entry #14: 0x80000000000a0000 0000ffffffff0000
+write -q -z 991k 128k
+L2 entry #15: 0x80000000000b0000 ffff00000000ffff
+L2 entry #16: 0x80000000000c0000 ffffffff00000000
+L2 entry #17: 0x80000000000d0000 00007fffffff8000
+
+### Writing zeroes 3: compressed clusters (backing file: no) ###
+
+write -q -c -P 2 1152k 64k
+L2 entry #18: 0x40000000000e0000 0000000000000000
+write -q -c -P 2 1216k 64k
+L2 entry #19: 0x40000000000f0000 0000000000000000
+write -q -c -P 2 1280k 64k
+L2 entry #20: 0x4000000000100000 0000000000000000
+write -q -c -P 2 1344k 64k
+L2 entry #21: 0x4000000000110000 0000000000000000
+write -q -c -P 2 1408k 64k
+L2 entry #22: 0x4000000000120000 0000000000000000
+write -q -c -P 2 1472k 64k
+L2 entry #23: 0x4000000000130000 0000000000000000
+write -q -c -P 2 1536k 64k
+L2 entry #24: 0x4000000000140000 0000000000000000
+write -q -c -P 2 1600k 64k
+L2 entry #25: 0x4000000000150000 0000000000000000
+write -q -c -P 2 1664k 64k
+L2 entry #26: 0x4000000000160000 0000000000000000
+write -q -c -P 2 1728k 64k
+L2 entry #27: 0x4000000000170000 0000000000000000
+write -q -c -P 2 1792k 64k
+L2 entry #28: 0x4000000000180000 0000000000000000
+write -q -z 1152k 192k
+L2 entry #18: 0x0000000000000000 ffffffff00000000
+L2 entry #19: 0x0000000000000000 ffffffff00000000
+L2 entry #20: 0x0000000000000000 ffffffff00000000
+write -q -z 1376k 128k
+L2 entry #21: 0x80000000000e0000 00000000ffffffff
+L2 entry #22: 0x80000000000f0000 00000000ffffffff
+L2 entry #23: 0x8000000000100000 00000000ffffffff
+write -q -z 1567k 129k
+L2 entry #24: 0x8000000000110000 00000000ffffffff
+L2 entry #25: 0x8000000000120000 00000000ffffffff
+L2 entry #26: 0x8000000000130000 00000000ffffffff
+write -q -z 1759k 128k
+L2 entry #27: 0x8000000000140000 ffff00000000ffff
+L2 entry #28: 0x0000000000000000 ffffffff00000000
+L2 entry #29: 0x0000000000000000 0000ffff00000000
+
+### Writing zeroes 4: other tests (backing file: no) ###
+
+write -q -z 1951k 8k
+L2 entry #30: 0x0000000000000000 000f800000000000
+write -q -z 2048k 35k
+L2 entry #32: 0x0000000000000000 0003ffff00000000
+
+### Zero + unmap 1: allocated clusters (backing file: yes) ###
+
+Formatting 'TEST_DIR/t.IMGFMT.raw', fmt=raw size=2132992
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=raw size=2132992
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2132992 backing_file=TEST_DIR/t.IMGFMT.base
+write -q -P 1 576k 576k
+L2 entry #9: 0x8000000000050000 00000000ffffffff
+L2 entry #10: 0x8000000000060000 00000000ffffffff
+L2 entry #11: 0x8000000000070000 00000000ffffffff
+L2 entry #12: 0x8000000000080000 00000000ffffffff
+L2 entry #13: 0x8000000000090000 00000000ffffffff
+L2 entry #14: 0x80000000000a0000 00000000ffffffff
+L2 entry #15: 0x80000000000b0000 00000000ffffffff
+L2 entry #16: 0x80000000000c0000 00000000ffffffff
+L2 entry #17: 0x80000000000d0000 00000000ffffffff
+write -q -z -u 576k 192k
+L2 entry #9: 0x0000000000000000 ffffffff00000000
+L2 entry #10: 0x0000000000000000 ffffffff00000000
+L2 entry #11: 0x0000000000000000 ffffffff00000000
+write -q -z -u 800k 128k
+L2 entry #12: 0x8000000000080000 ffff00000000ffff
+L2 entry #13: 0x0000000000000000 ffffffff00000000
+L2 entry #14: 0x80000000000a0000 0000ffffffff0000
+write -q -z -u 991k 128k
+L2 entry #15: 0x80000000000b0000 ffff00000000ffff
+L2 entry #16: 0x0000000000000000 ffffffff00000000
+L2 entry #17: 0x80000000000d0000 00007fffffff8000
+
+### Zero + unmap 2: compressed clusters (backing file: yes) ###
+
+write -q -c -P 2 1152k 64k
+L2 entry #18: 0x4000000000050000 0000000000000000
+write -q -c -P 2 1216k 64k
+L2 entry #19: 0x4000000000060000 0000000000000000
+write -q -c -P 2 1280k 64k
+L2 entry #20: 0x4000000000070000 0000000000000000
+write -q -c -P 2 1344k 64k
+L2 entry #21: 0x4000000000090000 0000000000000000
+write -q -c -P 2 1408k 64k
+L2 entry #22: 0x40000000000c0000 0000000000000000
+write -q -c -P 2 1472k 64k
+L2 entry #23: 0x40000000000e0000 0000000000000000
+write -q -c -P 2 1536k 64k
+L2 entry #24: 0x40000000000f0000 0000000000000000
+write -q -c -P 2 1600k 64k
+L2 entry #25: 0x4000000000100000 0000000000000000
+write -q -c -P 2 1664k 64k
+L2 entry #26: 0x4000000000110000 0000000000000000
+write -q -c -P 2 1728k 64k
+L2 entry #27: 0x4000000000120000 0000000000000000
+write -q -c -P 2 1792k 64k
+L2 entry #28: 0x4000000000130000 0000000000000000
+write -q -z -u 1152k 192k
+L2 entry #18: 0x0000000000000000 ffffffff00000000
+L2 entry #19: 0x0000000000000000 ffffffff00000000
+L2 entry #20: 0x0000000000000000 ffffffff00000000
+write -q -z -u 1376k 128k
+L2 entry #21: 0x8000000000050000 00000000ffffffff
+L2 entry #22: 0x8000000000060000 00000000ffffffff
+L2 entry #23: 0x8000000000070000 00000000ffffffff
+write -q -z -u 1567k 129k
+L2 entry #24: 0x8000000000090000 00000000ffffffff
+L2 entry #25: 0x80000000000e0000 00000000ffffffff
+L2 entry #26: 0x80000000000f0000 00000000ffffffff
+write -q -z -u 1759k 128k
+L2 entry #27: 0x80000000000c0000 ffff00000000ffff
+L2 entry #28: 0x0000000000000000 ffffffff00000000
+L2 entry #29: 0x8000000000100000 00007fff00008000
+
+### Zero + unmap 1: allocated clusters (backing file: no) ###
+
+Formatting 'TEST_DIR/t.IMGFMT.raw', fmt=raw size=2132992
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2132992
+write -q -P 1 576k 576k
+L2 entry #9: 0x8000000000050000 00000000ffffffff
+L2 entry #10: 0x8000000000060000 00000000ffffffff
+L2 entry #11: 0x8000000000070000 00000000ffffffff
+L2 entry #12: 0x8000000000080000 00000000ffffffff
+L2 entry #13: 0x8000000000090000 00000000ffffffff
+L2 entry #14: 0x80000000000a0000 00000000ffffffff
+L2 entry #15: 0x80000000000b0000 00000000ffffffff
+L2 entry #16: 0x80000000000c0000 00000000ffffffff
+L2 entry #17: 0x80000000000d0000 00000000ffffffff
+write -q -z -u 576k 192k
+L2 entry #9: 0x0000000000000000 ffffffff00000000
+L2 entry #10: 0x0000000000000000 ffffffff00000000
+L2 entry #11: 0x0000000000000000 ffffffff00000000
+write -q -z -u 800k 128k
+L2 entry #12: 0x8000000000080000 ffff00000000ffff
+L2 entry #13: 0x0000000000000000 ffffffff00000000
+L2 entry #14: 0x80000000000a0000 0000ffffffff0000
+write -q -z -u 991k 128k
+L2 entry #15: 0x80000000000b0000 ffff00000000ffff
+L2 entry #16: 0x0000000000000000 ffffffff00000000
+L2 entry #17: 0x80000000000d0000 00007fffffff8000
+
+### Zero + unmap 2: compressed clusters (backing file: no) ###
+
+write -q -c -P 2 1152k 64k
+L2 entry #18: 0x4000000000050000 0000000000000000
+write -q -c -P 2 1216k 64k
+L2 entry #19: 0x4000000000060000 0000000000000000
+write -q -c -P 2 1280k 64k
+L2 entry #20: 0x4000000000070000 0000000000000000
+write -q -c -P 2 1344k 64k
+L2 entry #21: 0x4000000000090000 0000000000000000
+write -q -c -P 2 1408k 64k
+L2 entry #22: 0x40000000000c0000 0000000000000000
+write -q -c -P 2 1472k 64k
+L2 entry #23: 0x40000000000e0000 0000000000000000
+write -q -c -P 2 1536k 64k
+L2 entry #24: 0x40000000000f0000 0000000000000000
+write -q -c -P 2 1600k 64k
+L2 entry #25: 0x4000000000100000 0000000000000000
+write -q -c -P 2 1664k 64k
+L2 entry #26: 0x4000000000110000 0000000000000000
+write -q -c -P 2 1728k 64k
+L2 entry #27: 0x4000000000120000 0000000000000000
+write -q -c -P 2 1792k 64k
+L2 entry #28: 0x4000000000130000 0000000000000000
+write -q -z -u 1152k 192k
+L2 entry #18: 0x0000000000000000 ffffffff00000000
+L2 entry #19: 0x0000000000000000 ffffffff00000000
+L2 entry #20: 0x0000000000000000 ffffffff00000000
+write -q -z -u 1376k 128k
+L2 entry #21: 0x8000000000050000 00000000ffffffff
+L2 entry #22: 0x8000000000060000 00000000ffffffff
+L2 entry #23: 0x8000000000070000 00000000ffffffff
+write -q -z -u 1567k 129k
+L2 entry #24: 0x8000000000090000 00000000ffffffff
+L2 entry #25: 0x80000000000e0000 00000000ffffffff
+L2 entry #26: 0x80000000000f0000 00000000ffffffff
+write -q -z -u 1759k 128k
+L2 entry #27: 0x80000000000c0000 ffff00000000ffff
+L2 entry #28: 0x0000000000000000 ffffffff00000000
+L2 entry #29: 0x0000000000000000 0000ffff00000000
+
+### Discarding clusters with non-zero bitmaps (backing file: yes) ###
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.base
+L2 entry #0: 0x0000000000000000 ffffffff00000000
+L2 entry #1: 0x0000000000000000 ffffffff00000000
+Image resized.
+Image resized.
+L2 entry #0: 0x0000000000000000 ffffffff00000000
+L2 entry #1: 0x0000000000000000 ffffffff00000000
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
+L2 entry #0: 0x8000000000050001 0000000000000001
+
+# Both 'subcluster is zero' and 'subcluster is allocated' bits set
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+L2 entry #1: 0x8000000000060000 00000001ffffffff
+qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0x1); further corruption events will be suppressed
+read failed: Input/output error
+
+### Corrupted L2 entries - read test (unallocated) ###
+
+# 'cluster is zero' bit set on the standard cluster descriptor
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+L2 entry #0: 0x0000000000000001 0000000000000000
+L2 entry #0: 0x0000000000000001 0000000000000000
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
+L2 entry #1: 0x0000000000000000 0000000100000001
+qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0x1); further corruption events will be suppressed
+read failed: Input/output error
+
+### Compressed cluster with subcluster bitmap != 0 - read test ###
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+L2 entry #0: 0x4000000000050000 0000000180000000
+read 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+L2 entry #0: 0x4000000000050000 0000000180000000
+
+### Corrupted L2 entries - write test (allocated) ###
+
+# 'cluster is zero' bit set on the standard cluster descriptor
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+L2 entry #0: 0x8000000000050001 0000000000000001
+L2 entry #0: 0x8000000000050001 0000000000000001
+
+# Both 'subcluster is zero' and 'subcluster is allocated' bits set
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+L2 entry #1: 0x8000000000060000 00000001ffffffff
+qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0x1); further corruption events will be suppressed
+write failed: Input/output error
+
+### Corrupted L2 entries - write test (unallocated) ###
+
+# 'cluster is zero' bit set on the standard cluster descriptor
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+L2 entry #0: 0x0000000000000001 0000000000000000
+L2 entry #0: 0x8000000000060000 0000000000000001
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
+L2 entry #1: 0x0000000000000000 0000000100000001
+qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0x1); further corruption events will be suppressed
+write failed: Input/output error
+
+### Compressed cluster with subcluster bitmap != 0 - write test ###
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+L2 entry #0: 0x4000000000050000 0000000180000000
+wrote 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+L2 entry #0: 0x8000000000060000 00000000ffffffff
+
+### Image creation options ###
+
+# cluster_size < 16k
+qemu-img: TEST_DIR/t.IMGFMT: Extended L2 entries are only supported with cluster sizes of at least 16384 bytes
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+# backing file and preallocation=metadata
+qemu-img: TEST_DIR/t.IMGFMT: Backing file and preallocation cannot be used at the same time
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.base preallocation=metadata
+# backing file and preallocation=falloc
+qemu-img: TEST_DIR/t.IMGFMT: Backing file and preallocation cannot be used at the same time
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.base preallocation=falloc
+# backing file and preallocation=full
+qemu-img: TEST_DIR/t.IMGFMT: Backing file and preallocation cannot be used at the same time
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.base preallocation=full
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
+
+### qemu-img amend ###
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+qemu-img: Toggling extended L2 entries is not supported
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+qemu-img: Toggling extended L2 entries is not supported
+
+### Test copy-on-write on an image with snapshots ###
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+L2 entry #0: 0x8000000000050000 0000008000042000
+L2 entry #1: 0x8000000000060000 0000008000042000
+L2 entry #2: 0x8000000000070000 0000008000042000
+L2 entry #3: 0x8000000000080000 0000008000042000
+L2 entry #4: 0x8000000000090000 0000008000042000
+L2 entry #5: 0x80000000000a0000 0000008000042000
+L2 entry #6: 0x80000000000b0000 0000008000042000
+L2 entry #7: 0x80000000000c0000 0000008000042000
+L2 entry #8: 0x80000000000d0000 0000008000042000
+L2 entry #9: 0x80000000000e0000 0000008000042000
+L2 entry #0: 0x8000000000120000 000000800007e000
+L2 entry #1: 0x8000000000130000 000000800007fc00
+L2 entry #2: 0x8000000000140000 00000080001fe000
+L2 entry #3: 0x8000000000150000 000000800007e000
+L2 entry #4: 0x8000000000160000 000000000007ff80
+L2 entry #5: 0x8000000000170000 000000000007ffff
+L2 entry #6: 0x00000000000b0000 0001808000042000
+L2 entry #7: 0x00000000000c0000 0000208000040000
+L2 entry #8: 0x8000000000180000 000000800007e000
+L2 entry #9: 0x00000000000e0000 000000c000042000
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 445c26f8d2..50c9bbc750 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -284,6 +284,7 @@
 267 rw auto quick snapshot
 268 rw auto quick
 270 rw backing quick
+271 rw auto
 272 rw
 273 backing quick
 274 rw backing
-- 
2.20.1


