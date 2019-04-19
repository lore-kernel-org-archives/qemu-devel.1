Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC5DC282DA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 14:08:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8436222C8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 14:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8436222C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57024 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHUBq-00079J-Qe
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 10:08:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hHU8A-00048M-2U
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 10:04:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hHTvg-00075f-Dj
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 09:51:49 -0400
Received: from relay.sw.ru ([185.231.240.75]:33728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hHTvg-0006z4-5D; Fri, 19 Apr 2019 09:51:48 -0400
Received: from [10.28.8.145] (helo=kvm.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hHTvb-0008V2-Fg; Fri, 19 Apr 2019 16:51:43 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Fri, 19 Apr 2019 16:51:42 +0300
Message-Id: <20190419135142.91810-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190419135142.91810-1-vsementsov@virtuozzo.com>
References: <20190419135142.91810-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v2 3/3] iotests: test big qcow2 shrink
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
Message-ID: <20190419135142.HRLngcfSzBp33YhfjXhJFmR1rLJ29zrdCDnlWGuTQ8I@z>

This test checks bug in qcow2_process_discards, fixed by previous
commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/250     | 72 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/250.out | 21 +++++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 94 insertions(+)
 create mode 100755 tests/qemu-iotests/250
 create mode 100644 tests/qemu-iotests/250.out

diff --git a/tests/qemu-iotests/250 b/tests/qemu-iotests/250
new file mode 100755
index 0000000000..ab64019dd2
--- /dev/null
+++ b/tests/qemu-iotests/250
@@ -0,0 +1,72 @@
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
+# bdrv_co_truncate(bs->file) call in qcow2_co_truncate(), which may success
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
+# Otherwise test will may pass even if bdrv_pdiscard() fails in
+# qcow2_process_discards()
+$QEMU_IMG map "$TEST_IMG" | _filter_qemu_img_map
+$QEMU_IMG info "$TEST_IMG" | grep size |  _filter_testdir
+
+$QEMU_IMG -T 'qcow2_process_discards_failed*' resize --shrink "$TEST_IMG" 5M
+
+$QEMU_IMG info "$TEST_IMG" | grep size | _filter_testdir
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/250.out b/tests/qemu-iotests/250.out
new file mode 100644
index 0000000000..62ab775e6c
--- /dev/null
+++ b/tests/qemu-iotests/250.out
@@ -0,0 +1,21 @@
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
+Offset          Length          File
+0               0xa00000        TEST_DIR/t.IMGFMT
+0x82a00000      0xa00000        TEST_DIR/t.IMGFMT
+virtual size: 2.1G (2202009600 bytes)
+disk size: 24M
+cluster_size: 1048576
+Image resized.
+virtual size: 5.0M (5242880 bytes)
+disk size: 9.0M
+cluster_size: 1048576
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


