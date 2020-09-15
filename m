Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769A7C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:53:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D28F7206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1R1tiW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28F7206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI8ai-00023z-V3
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 06:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8UG-0000Yp-6k
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:47:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32930)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8UC-0004Yh-2j
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600166814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W4TlSJjMROfvhgotRhNIJHzLDa6dGxPD7XOQl1qmuGs=;
 b=h1R1tiW2rffjnBtOnLv1EGX/VatBEZvghnJl3nJhz802eHUxMk/biV1Kot5QPRAt6FiRRG
 fyq9c4V7/QuaPO8492hqe0BIL++37re0k+6n0NMNoV07Qii1hi+JlVIpjiRpUiSBkYMMtg
 Ethd+9B5VG1Po+CioNgvVwRbAWxVg5I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-KbDM-RJfPYSLehqqwpTzbw-1; Tue, 15 Sep 2020 06:46:51 -0400
X-MC-Unique: KbDM-RJfPYSLehqqwpTzbw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00BF81084D62;
 Tue, 15 Sep 2020 10:46:50 +0000 (UTC)
Received: from localhost (ovpn-113-7.ams2.redhat.com [10.36.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8AD0E2C31E;
 Tue, 15 Sep 2020 10:46:49 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 09/22] qcow2: Fix removal of list members from
 BDRVQcow2State.cluster_allocs
Date: Tue, 15 Sep 2020 12:46:14 +0200
Message-Id: <20200915104627.699552-10-mreitz@redhat.com>
In-Reply-To: <20200915104627.699552-1-mreitz@redhat.com>
References: <20200915104627.699552-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:23:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

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
Message-Id: <3440a1c4d53c4fe48312b478c96accb338cbef7c.1599150873.git.berto@igalia.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c      |  3 --
 tests/qemu-iotests/305     | 74 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/305.out | 16 +++++++++
 tests/qemu-iotests/group   |  1 +
 4 files changed, 91 insertions(+), 3 deletions(-)
 create mode 100755 tests/qemu-iotests/305
 create mode 100644 tests/qemu-iotests/305.out

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 4530e5e471..f65ccc5840 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1710,9 +1710,6 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
 
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
2.26.2


