Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEC1C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:06:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9856206CB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WX0R0kVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9856206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaNBL-0002mh-JJ
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 13:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kaN9w-0001le-2G; Wed, 04 Nov 2020 13:05:24 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:46051)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kaN9s-0004rK-Cs; Wed, 04 Nov 2020 13:05:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
 bh=gtd9Tg542K0wQioF1xmn/MRaJPlJXkUvLkYKFr2Xd1M=; 
 b=WX0R0kVCZbPgQ1Je0O6LTN2xfMVbo/becQnRY6ObUJr2XJItKASl2eauqkaBSmA7SA0WWU4uGMeYSufPvmj2OHRyYhacSpOJyxdjykPmCF7VB+9Ri3G/z2tU3q3lmAl0eA/MUfNNTrnJGStmeXTL7PHIBt3sgl7mqk4ej/2CckiffGcFKnlVN9EWXIpfOai/zvJ4lK9bpFoVBSZUCGIat61Qv5vVWfO5xQbz2t/AkTQWK/LmOhnLMWC23+/DLNw0UjskV1bfm1UWBeZ1SWYPzY+xtNf+2vNVqZEY/v20SMo7A4Ue/vCL8vzNjTztMEVFkg58Y1IQAW6WxB/FliPgfA==;
Received: from [81.0.39.127] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1kaN9U-0008AF-Os; Wed, 04 Nov 2020 19:04:56 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1kaN9H-0002Sb-Mr; Wed, 04 Nov 2020 19:04:43 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] quorum: Implement bdrv_co_block_status()
Date: Wed,  4 Nov 2020 19:04:34 +0100
Message-Id: <20201104180434.9412-1-berto@igalia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 13:04:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Tao Xu <tao3.xu@intel.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The quorum driver does not implement bdrv_co_block_status() and
because of that it always reports to contain data even if all its
children are known to be empty.

One consequence of this is that if we for example create a quorum with
a size of 10GB and we mirror it to a new image the operation will
write 10GB of actual zeroes to the destination image wasting a lot of
time and disk space.

Since a quorum has an arbitrary number of children of potentially
different formats there is no way to report all possible allocation
status flags in a way that makes sense, so this implementation only
reports when a given region is known to contain zeroes
(BDRV_BLOCK_ZERO) or not (BDRV_BLOCK_DATA).

If all children agree that a region contains zeroes then we can return
BDRV_BLOCK_ZERO using the smallest size reported by the children
(because all agree that a region of at least that size contains
zeroes).

If at least one child disagrees we have to return BDRV_BLOCK_DATA.
In this case we use the largest of the sizes reported by the children
that didn't return BDRV_BLOCK_ZERO (because we know that there won't
be an agreement for at least that size).

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/quorum.c             |  49 ++++++++++++
 tests/qemu-iotests/312     | 148 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/312.out |  67 +++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 4 files changed, 265 insertions(+)
 create mode 100755 tests/qemu-iotests/312
 create mode 100644 tests/qemu-iotests/312.out

diff --git a/block/quorum.c b/block/quorum.c
index e846a7e892..29cee42705 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -18,6 +18,7 @@
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "block/block_int.h"
+#include "block/coroutines.h"
 #include "block/qdict.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-block.h"
@@ -1174,6 +1175,53 @@ static void quorum_child_perm(BlockDriverState *bs, BdrvChild *c,
              | DEFAULT_PERM_UNCHANGED;
 }
 
+/*
+ * Each one of the children can report different status flags even
+ * when they contain the same data, so what this function does is
+ * return BDRV_BLOCK_ZERO if *all* children agree that a certain
+ * region contains zeroes, and BDRV_BLOCK_DATA otherwise.
+ */
+static int coroutine_fn quorum_co_block_status(BlockDriverState *bs,
+                                               bool want_zero,
+                                               int64_t offset, int64_t count,
+                                               int64_t *pnum, int64_t *map,
+                                               BlockDriverState **file)
+{
+    BDRVQuorumState *s = bs->opaque;
+    int i, ret;
+    int64_t pnum_zero = count;
+    int64_t pnum_data = 0;
+
+    for (i = 0; i < s->num_children; i++) {
+        int64_t bytes;
+        ret = bdrv_co_common_block_status_above(s->children[i]->bs, NULL, false,
+                                                want_zero, offset, count,
+                                                &bytes, NULL, NULL, NULL);
+        if (ret < 0) {
+            return ret;
+        }
+        /*
+         * Even if all children agree about whether there are zeroes
+         * or not at @offset they might disagree on the size, so use
+         * the smallest when reporting BDRV_BLOCK_ZERO and the largest
+         * when reporting BDRV_BLOCK_DATA.
+         */
+        if (ret & BDRV_BLOCK_ZERO) {
+            pnum_zero = MIN(pnum_zero, bytes);
+        } else {
+            pnum_data = MAX(pnum_data, bytes);
+        }
+    }
+
+    if (pnum_data) {
+        *pnum = pnum_data;
+        return BDRV_BLOCK_DATA;
+    } else {
+        *pnum = pnum_zero;
+        return BDRV_BLOCK_ZERO;
+    }
+}
+
 static const char *const quorum_strong_runtime_opts[] = {
     QUORUM_OPT_VOTE_THRESHOLD,
     QUORUM_OPT_BLKVERIFY,
@@ -1192,6 +1240,7 @@ static BlockDriver bdrv_quorum = {
     .bdrv_close                         = quorum_close,
     .bdrv_gather_child_options          = quorum_gather_child_options,
     .bdrv_dirname                       = quorum_dirname,
+    .bdrv_co_block_status               = quorum_co_block_status,
 
     .bdrv_co_flush_to_disk              = quorum_co_flush,
 
diff --git a/tests/qemu-iotests/312 b/tests/qemu-iotests/312
new file mode 100755
index 0000000000..1b08f1552f
--- /dev/null
+++ b/tests/qemu-iotests/312
@@ -0,0 +1,148 @@
+#!/usr/bin/env bash
+#
+# Test drive-mirror with quorum
+#
+# The goal of this test is to check how the quorum driver reports
+# regions that are known to read as zeroes (BDRV_BLOCK_ZERO). The idea
+# is that drive-mirror will try the efficient representation of zeroes
+# in the destination image instead of writing actual zeroes.
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
+owner=berto@igalia.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+
+_cleanup()
+{
+    _rm_test_img "$TEST_IMG.0"
+    _rm_test_img "$TEST_IMG.1"
+    _rm_test_img "$TEST_IMG.2"
+    _rm_test_img "$TEST_IMG.3"
+    _cleanup_qemu
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+. ./common.qemu
+
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+_unsupported_imgopts cluster_size data_file
+
+echo
+echo '### Create all images' # three source (quorum), one destination
+echo
+TEST_IMG="$TEST_IMG.0" _make_test_img -o cluster_size=64k 10M
+TEST_IMG="$TEST_IMG.1" _make_test_img -o cluster_size=64k 10M
+TEST_IMG="$TEST_IMG.2" _make_test_img -o cluster_size=64k 10M
+TEST_IMG="$TEST_IMG.3" _make_test_img -o cluster_size=64k 10M
+
+quorum="driver=raw,file.driver=quorum,file.vote-threshold=2"
+quorum="$quorum,file.children.0.file.filename=$TEST_IMG.0"
+quorum="$quorum,file.children.1.file.filename=$TEST_IMG.1"
+quorum="$quorum,file.children.2.file.filename=$TEST_IMG.2"
+quorum="$quorum,file.children.0.driver=$IMGFMT"
+quorum="$quorum,file.children.1.driver=$IMGFMT"
+quorum="$quorum,file.children.2.driver=$IMGFMT"
+
+echo
+echo '### Output of qemu-img map (empty quorum)'
+echo
+$QEMU_IMG map --image-opts $quorum | _filter_qemu_img_map
+
+# Now we write data to the quorum. All three images will read as
+# zeroes in all cases, but with different ways to represent them
+# (unallocated clusters, zero clusters, data clusters with zeroes)
+# that will have an effect on how the data will be mirrored and the
+# output of qemu-img map on the resulting image.
+echo
+echo '### Write data to the quorum'
+echo
+# Test 1: data regions surrounded by unallocated clusters.
+# Three data regions, the largest one (0x30000) will be picked, end result:
+# offset 0x10000, length 0x30000 -> data
+$QEMU_IO -c "write -P 0 $((0x10000)) $((0x10000))" "$TEST_IMG.0" | _filter_qemu_io
+$QEMU_IO -c "write -P 0 $((0x10000)) $((0x30000))" "$TEST_IMG.1" | _filter_qemu_io
+$QEMU_IO -c "write -P 0 $((0x10000)) $((0x20000))" "$TEST_IMG.2" | _filter_qemu_io
+
+# Test 2: zero regions surrounded by data clusters.
+# First we allocate the data clusters.
+$QEMU_IO -c "open -o $quorum" -c "write -P 0 $((0x100000)) $((0x40000))" | _filter_qemu_io
+
+# Three zero regions, the smallest one (0x10000) will be picked, end result:
+# offset 0x100000, length 0x10000 -> data
+# offset 0x110000, length 0x10000 -> zeroes
+# offset 0x120000, length 0x20000 -> data
+$QEMU_IO -c "write -z $((0x110000)) $((0x10000))" "$TEST_IMG.0" | _filter_qemu_io
+$QEMU_IO -c "write -z $((0x110000)) $((0x30000))" "$TEST_IMG.1" | _filter_qemu_io
+$QEMU_IO -c "write -z $((0x110000)) $((0x20000))" "$TEST_IMG.2" | _filter_qemu_io
+
+# Test 3: zero clusters surrounded by unallocated clusters.
+# Everything reads as zeroes, no effect on the end result.
+$QEMU_IO -c "write -z $((0x150000)) $((0x10000))" "$TEST_IMG.0" | _filter_qemu_io
+$QEMU_IO -c "write -z $((0x150000)) $((0x30000))" "$TEST_IMG.1" | _filter_qemu_io
+$QEMU_IO -c "write -z $((0x150000)) $((0x20000))" "$TEST_IMG.2" | _filter_qemu_io
+
+# Test 4: mix of data and zero clusters.
+# The zero region will be ignored in favor of the largest data region
+# (0x20000), end result:
+# offset 0x200000, length 0x20000 -> data
+$QEMU_IO -c "write -P 0 $((0x200000)) $((0x10000))" "$TEST_IMG.0" | _filter_qemu_io
+$QEMU_IO -c "write -z   $((0x200000)) $((0x30000))" "$TEST_IMG.1" | _filter_qemu_io
+$QEMU_IO -c "write -P 0 $((0x200000)) $((0x20000))" "$TEST_IMG.2" | _filter_qemu_io
+
+echo
+echo '### Launch the drive-mirror job'
+echo
+qemu_comm_method="qmp" _launch_qemu -drive if=virtio,"$quorum"
+h=$QEMU_HANDLE
+_send_qemu_cmd $h "{ 'execute': 'qmp_capabilities' }" 'return'
+
+_send_qemu_cmd $h \
+    "{'execute': 'drive-mirror',
+                 'arguments': {'device': 'virtio0',
+                               'format': '$IMGFMT',
+                               'target': '$TEST_IMG.3',
+                               'sync':   'full',
+                               'mode':   'existing' }}"    \
+     "BLOCK_JOB_READY.*virtio0"
+
+_send_qemu_cmd $h \
+    "{ 'execute': 'block-job-complete',
+       'arguments': { 'device': 'virtio0' } }" \
+    'BLOCK_JOB_COMPLETED'
+
+_send_qemu_cmd $h "{ 'execute': 'quit' }" ''
+
+echo
+echo '### Output of qemu-img map (destination image)'
+echo
+$QEMU_IMG map "$TEST_IMG.3" | _filter_qemu_img_map
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/312.out b/tests/qemu-iotests/312.out
new file mode 100644
index 0000000000..4ae749175b
--- /dev/null
+++ b/tests/qemu-iotests/312.out
@@ -0,0 +1,67 @@
+QA output created by 312
+
+### Create all images
+
+Formatting 'TEST_DIR/t.IMGFMT.0', fmt=IMGFMT size=10485760
+Formatting 'TEST_DIR/t.IMGFMT.1', fmt=IMGFMT size=10485760
+Formatting 'TEST_DIR/t.IMGFMT.2', fmt=IMGFMT size=10485760
+Formatting 'TEST_DIR/t.IMGFMT.3', fmt=IMGFMT size=10485760
+
+### Output of qemu-img map (empty quorum)
+
+Offset          Length          File
+
+### Write data to the quorum
+
+wrote 65536/65536 bytes at offset 65536
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 196608/196608 bytes at offset 65536
+192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 65536
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 262144/262144 bytes at offset 1048576
+256 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 1114112
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 196608/196608 bytes at offset 1114112
+192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 1114112
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 1376256
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 196608/196608 bytes at offset 1376256
+192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 1376256
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 2097152
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 196608/196608 bytes at offset 2097152
+192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 2097152
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+### Launch the drive-mirror job
+
+{ 'execute': 'qmp_capabilities' }
+{"return": {}}
+{'execute': 'drive-mirror', 'arguments': {'device': 'virtio0', 'format': 'IMGFMT', 'target': 'TEST_DIR/t.IMGFMT.3', 'sync': 'full', 'mode': 'existing' }}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "virtio0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "virtio0"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "virtio0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "virtio0", "len": 10485760, "offset": 10485760, "speed": 0, "type": "mirror"}}
+{ 'execute': 'block-job-complete', 'arguments': { 'device': 'virtio0' } }
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "virtio0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "virtio0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "virtio0", "len": 10485760, "offset": 10485760, "speed": 0, "type": "mirror"}}
+{ 'execute': 'quit' }
+
+### Output of qemu-img map (destination image)
+
+Offset          Length          File
+0x10000         0x30000         TEST_DIR/t.IMGFMT.3
+0x100000        0x10000         TEST_DIR/t.IMGFMT.3
+0x120000        0x20000         TEST_DIR/t.IMGFMT.3
+0x200000        0x20000         TEST_DIR/t.IMGFMT.3
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 2960dff728..2a218c8918 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -316,3 +316,4 @@
 305 rw quick
 307 rw quick export
 309 rw auto quick
+312 rw auto quick
-- 
2.20.1


