Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E13DC10F12
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 10:12:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D527C21773
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 10:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D527C21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50053 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGhYK-0004ul-5d
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 06:12:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hGhVY-00038N-1Z
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 06:09:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hGhVW-0003u4-Pz
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 06:09:36 -0400
Received: from relay.sw.ru ([185.231.240.75]:47100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hGhVW-0003sv-F4; Wed, 17 Apr 2019 06:09:34 -0400
Received: from [10.28.8.145] (helo=kvm.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hGhVS-0005Kr-MR; Wed, 17 Apr 2019 13:09:30 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Wed, 17 Apr 2019 13:09:29 +0300
Message-Id: <20190417100929.39943-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190417100929.39943-1-vsementsov@virtuozzo.com>
References: <20190417100929.39943-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 2/2] iotests: test big qcow2 shrink
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
	den@virtuozzo.com, mreitz@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190417100929.MGwepSGBm2maH4zioIDCCTh0pFRJB58-Ux2xi3G-wO4@z>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/249     | 69 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/249.out | 30 +++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 100 insertions(+)
 create mode 100755 tests/qemu-iotests/249
 create mode 100644 tests/qemu-iotests/249.out

diff --git a/tests/qemu-iotests/249 b/tests/qemu-iotests/249
new file mode 100755
index 0000000000..f0140461ad
--- /dev/null
+++ b/tests/qemu-iotests/249
@@ -0,0 +1,69 @@
+#!/usr/bin/env bash
+#
+# Test big discard in qcow2 shrink
+#
+# Copyright (c) 2019 Virtuozzo International GmbH. All rights reserved.
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
+owner=vsementsov@virtuozzo.com
+
+seq=`basename $0`
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
+# Requires backing files and .bdrv_change_backing_file support
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+# This test checks bug in qcow2_process_discards, fixed by previous commit.
+# The problem was that bdrv_pdiscard was called with uint64_t bytes parameter
+# which was cropped to int.
+# To reproduce bug we need to overflow int by one sequential discard, so we
+# need size > 2G, bigger cluster size (as with default 64k we may have maximum
+# of 512M sequential data, corresponding to one L1 entry, and we need to write
+# at offset 0 at last, to prevent bdrv_co_truncate(bs->file) in
+# qcow2_co_truncate to stole the whole effect of failed discard.
+
+size=2300M
+IMGOPTS="cluster_size=1M"
+
+_make_test_img $size
+$QEMU_IO -c 'write 100M 2000M' -c 'write 2100M 200M' \
+    -c 'write 0 100M' "$TEST_IMG" | _filter_qemu_io
+
+$QEMU_IMG info "$TEST_IMG" | _filter_testdir
+
+$QEMU_IMG resize --shrink "$TEST_IMG" 50M
+
+$QEMU_IMG info "$TEST_IMG" | _filter_testdir
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/249.out b/tests/qemu-iotests/249.out
new file mode 100644
index 0000000000..18bf7b2fb2
--- /dev/null
+++ b/tests/qemu-iotests/249.out
@@ -0,0 +1,30 @@
+QA output created by 249
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2411724800
+wrote 2097152000/2097152000 bytes at offset 104857600
+1.953 GiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 209715200/209715200 bytes at offset 2202009600
+200 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 104857600/104857600 bytes at offset 0
+100 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+image: TEST_DIR/t.qcow2
+file format: qcow2
+virtual size: 2.2G (2411724800 bytes)
+disk size: 2.3G
+cluster_size: 1048576
+Format specific information:
+    compat: 1.1
+    lazy refcounts: false
+    refcount bits: 16
+    corrupt: false
+Image resized.
+image: TEST_DIR/t.qcow2
+file format: qcow2
+virtual size: 50M (52428800 bytes)
+disk size: 54M
+cluster_size: 1048576
+Format specific information:
+    compat: 1.1
+    lazy refcounts: false
+    refcount bits: 16
+    corrupt: false
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index bae7718380..3a40dbfe69 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -248,3 +248,4 @@
 246 rw auto quick
 247 rw auto quick
 248 rw auto quick
+249 rw auto
-- 
2.18.0


