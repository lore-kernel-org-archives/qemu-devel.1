Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26462C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:42:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D40EF2072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="K4bU6c/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40EF2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDsJK-0000cl-Ux
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kDsFZ-0002C1-Jk; Thu, 03 Sep 2020 12:38:13 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:40614)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kDsFX-0003uw-7P; Thu, 03 Sep 2020 12:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=XozAt5iAiJDu6m4UDYneszmTL3ezoOj/nHGdHJn0fxE=; 
 b=K4bU6c/1pw+7gq8LqDO2W43NEylFVOPmuEgNZnTydFBUD57R2BD6B1RFo85gUDIz5cJQMR5RvPwCAfoEC2loHVd3UU/yXBmYhiW46pNMy2YufTmRYOjiQAcPZfiVdipL8iJfnxWpHsSDmK9OSSv8vI5tEt0TRLMK/TaKDS6c4/cm5fS9wuDLXunxzC0oprnXzTP4VjS49x9JskrMpPSW1gg+krFWUjKlXGgH1Cte3NXd7aJ1L2BRBe4EkyCKO2f+LzYl9EuwQHuph5vIaFSSq5bjFpPadwgd+HHpiT5wydTITDmJC+eiiRFI4adp/CzsT4Qox52FsDLsVli+sCAo7Q==;
Received: from [81.0.33.67] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1kDsFV-0002F7-Ax; Thu, 03 Sep 2020 18:38:09 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1kDsFI-00082h-EG; Thu, 03 Sep 2020 18:37:56 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] qcow2: Fix removal of list members from
 BDRVQcow2State.cluster_allocs
Date: Thu,  3 Sep 2020 18:37:47 +0200
Message-Id: <3440a1c4d53c4fe48312b478c96accb338cbef7c.1599150873.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1599150873.git.berto@igalia.com>
References: <cover.1599150873.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 12:38:03
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When a write request needs to allocate new clusters (or change the L2
bitmap of existing ones) a QCowL2Meta structure is created so the L2
metadata can be later updated and any copy-on-write can be performed
if necessary.

A write request can span a region consisting of an arbitrary
combination of previously unallocated and allocated clusters, and if
the unallocated ones can be put contiguous to the existing ones then
QEMU will do so in order to minimize the number of write operations.

In practice this means that a write request has not just one but a
number of QCowL2Meta structures. All of them are added to the
cluster_allocs list that is stored in BDRVQcow2State and is used to
detect overlapping requests. After the write request finishes all its
associated QCowL2Meta are removed from that list. calculate_l2_meta()
takes care of creating and putting those structures in the list, and
qcow2_handle_l2meta() takes care of removing them.

The problem is that the error path in handle_alloc() also tries to
remove an item in that list, a remnant from the time when this was
handled there (that code would not even be correct anymore because
it only removes one struct and not all the ones from the same write
request).

This can trigger a double removal of the same item from the list,
causing a crash. This is not easy to reproduce in practice because
it requires that do_alloc_cluster_offset() fails after a successful
previous allocation during the same write request, but it can be
reproduced with the included test case.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c      |  3 --
 tests/qemu-iotests/305     | 74 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/305.out | 16 +++++++++
 tests/qemu-iotests/group   |  1 +
 4 files changed, 91 insertions(+), 3 deletions(-)
 create mode 100755 tests/qemu-iotests/305
 create mode 100644 tests/qemu-iotests/305.out

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 996b3314f4..25e38daa78 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1709,9 +1709,6 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
 
 out:
     qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
-    if (ret < 0 && *m && (*m)->nb_clusters > 0) {
-        QLIST_REMOVE(*m, next_in_flight);
-    }
     return ret;
 }
 
diff --git a/tests/qemu-iotests/305 b/tests/qemu-iotests/305
new file mode 100755
index 0000000000..768818af4a
--- /dev/null
+++ b/tests/qemu-iotests/305
@@ -0,0 +1,74 @@
+#!/usr/bin/env bash
+#
+# Test the handling of errors in write requests with multiple allocations
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
+status=1    # failure is the default!
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
+_unsupported_imgopts cluster_size refcount_bits extended_l2 compat=0.10 data_file
+
+echo '### Create the image'
+_make_test_img -o refcount_bits=64,cluster_size=1k 1M
+
+# The reference counts of the clusters for the first 123k of this
+# write request are stored in the first refcount block. The last
+# cluster (guest offset 123k) is referenced in the second refcount
+# block.
+echo '### Fill the first refcount block and one data cluster from the second'
+$QEMU_IO -c 'write 0 124k' "$TEST_IMG" | _filter_qemu_io
+
+echo '### Discard two of the last data clusters, leave one in the middle'
+$QEMU_IO -c 'discard 121k 1k' "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c 'discard 123k 1k' "$TEST_IMG" | _filter_qemu_io
+
+echo '### Corrupt the offset of the second refcount block'
+refcount_table_offset=$(peek_file_be "$TEST_IMG" 48 8)
+poke_file "$TEST_IMG" $(($refcount_table_offset+14)) "\x06"
+
+# This tries to allocate the two clusters discarded earlier (guest
+# offsets 121k and 123k). Their reference counts are in the first and
+# second refcount blocks respectively, but only the first one can be
+# allocated correctly because the second entry of the refcount table
+# is corrupted.
+echo '### Try to allocate the discarded clusters again'
+$QEMU_IO -c 'write 121k 3k' "$TEST_IMG" | _filter_qemu_io
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/305.out b/tests/qemu-iotests/305.out
new file mode 100644
index 0000000000..538019e726
--- /dev/null
+++ b/tests/qemu-iotests/305.out
@@ -0,0 +1,16 @@
+QA output created by 305
+### Create the image
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+### Fill the first refcount block and one data cluster from the second
+wrote 126976/126976 bytes at offset 0
+124 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+### Discard two of the last data clusters, leave one in the middle
+discard 1024/1024 bytes at offset 123904
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+discard 1024/1024 bytes at offset 125952
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+### Corrupt the offset of the second refcount block
+### Try to allocate the discarded clusters again
+qcow2: Marking image as corrupt: Refblock offset 0x20600 unaligned (reftable index: 0x1); further corruption events will be suppressed
+write failed: Input/output error
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 5cad015231..ff59cfd2d4 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -313,3 +313,4 @@
 302 quick
 303 rw quick
 304 rw quick
+305 rw quick
-- 
2.20.1


