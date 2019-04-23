Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC932C282DD
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 12:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E4C9214AE
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 12:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4C9214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53416 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIv0W-0005Dq-Pc
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 08:58:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIuz2-0004J2-RG
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 08:57:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIuz1-0004wi-DA
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 08:57:12 -0400
Received: from relay.sw.ru ([185.231.240.75]:42554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hIuz1-0004um-50; Tue, 23 Apr 2019 08:57:11 -0400
Received: from [10.28.8.145] (helo=kvm.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hIuyx-0001B4-7h; Tue, 23 Apr 2019 15:57:07 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue, 23 Apr 2019 15:57:06 +0300
Message-Id: <20190423125706.26989-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190423125706.26989-1-vsementsov@virtuozzo.com>
References: <20190423125706.26989-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v5 3/3] iotests: test big qcow2 shrink
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
Message-ID: <20190423125706.PBvzkM4qCyV6nr4W797S2YgOS1DTCKk-rVJCvsDY0LI@z>

This test checks bug in qcow2_process_discards, fixed by previous
commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/250     | 73 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/250.out | 23 ++++++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 97 insertions(+)
 create mode 100755 tests/qemu-iotests/250
 create mode 100644 tests/qemu-iotests/250.out

diff --git a/tests/qemu-iotests/250 b/tests/qemu-iotests/250
new file mode 100755
index 0000000000..850e3546ca
--- /dev/null
+++ b/tests/qemu-iotests/250
@@ -0,0 +1,73 @@
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
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+# This test checks that qcow2_process_discards does not truncate a discard
+# request > 2G.
+# To reproduce bug we need to overflow int by one sequential discard, so we
+# need size > 2G, bigger cluster size (as with default 64k we may have maximum
+# of 512M sequential data, corresponding to one L1 entry), and we need some
+# data of the beginning of the disk mapped to the end of file to prevent
+# bdrv_co_truncate(bs->file) call in qcow2_co_truncate(), which might succeed
+# anyway.
+
+size=2100M
+IMGOPTS="cluster_size=1M,preallocation=metadata"
+
+_make_test_img $size
+$QEMU_IO -c 'discard 0 10M' -c 'discard 2090M 10M' \
+         -c 'write 2090M 10M' -c 'write 0 10M' "$TEST_IMG" | _filter_qemu_io
+
+# Check that our trick with swapping first and last 10M chunks succeeded.
+# Otherwise test may pass even if bdrv_pdiscard() fails in
+# qcow2_process_discards()
+$QEMU_IMG map "$TEST_IMG" | _filter_testdir
+
+$QEMU_IMG map -f raw "$TEST_IMG" |  _filter_testdir
+
+$QEMU_IMG resize --shrink "$TEST_IMG" 5M
+
+$QEMU_IMG map -f raw "$TEST_IMG" | _filter_testdir
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/250.out b/tests/qemu-iotests/250.out
new file mode 100644
index 0000000000..49baee5eee
--- /dev/null
+++ b/tests/qemu-iotests/250.out
@@ -0,0 +1,23 @@
+QA output created by 250
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202009600 preallocation=metadata
+discard 10485760/10485760 bytes at offset 0
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+discard 10485760/10485760 bytes at offset 2191523840
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 10485760/10485760 bytes at offset 2191523840
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 10485760/10485760 bytes at offset 0
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Offset          Length          Mapped to       File
+0               0xa00000        0x82f00000      TEST_DIR/t.qcow2
+0x82a00000      0xa00000        0x500000        TEST_DIR/t.qcow2
+Offset          Length          Mapped to       File
+0               0x301000        0               TEST_DIR/t.qcow2
+0x400000        0xb00000        0x400000        TEST_DIR/t.qcow2
+0x82f00000      0xa00000        0x82f00000      TEST_DIR/t.qcow2
+Image resized.
+Offset          Length          Mapped to       File
+0               0x301000        0               TEST_DIR/t.qcow2
+0x400000        0x100000        0x400000        TEST_DIR/t.qcow2
+0x82f00000      0x500000        0x82f00000      TEST_DIR/t.qcow2
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index bae7718380..588ae8b8b1 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -248,3 +248,4 @@
 246 rw auto quick
 247 rw auto quick
 248 rw auto quick
+250 rw auto quick
-- 
2.18.0


