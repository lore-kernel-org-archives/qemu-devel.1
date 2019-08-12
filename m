Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3246DC31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 18:13:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 066B32067D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 18:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 066B32067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxEpB-0001sm-Cp
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 14:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41003)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxEnU-0007vX-Hf
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 14:11:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxEnT-0004eW-6n
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 14:11:56 -0400
Received: from relay.sw.ru ([185.231.240.75]:50628)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxEnQ-0004cJ-B2; Mon, 12 Aug 2019 14:11:52 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxEnM-0001oT-UB; Mon, 12 Aug 2019 21:11:49 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Mon, 12 Aug 2019 21:11:46 +0300
Message-Id: <20190812181146.26121-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190812181146.26121-1-vsementsov@virtuozzo.com>
References: <20190812181146.26121-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 2/2] iotests: test mirroring qcow2 under raw
 format
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Check that it is fixed by previous commit

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/263     | 46 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/263.out | 12 ++++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 59 insertions(+)
 create mode 100755 tests/qemu-iotests/263
 create mode 100644 tests/qemu-iotests/263.out

diff --git a/tests/qemu-iotests/263 b/tests/qemu-iotests/263
new file mode 100755
index 0000000000..dbe38e6c6c
--- /dev/null
+++ b/tests/qemu-iotests/263
@@ -0,0 +1,46 @@
+#!/usr/bin/env python
+#
+# Test mirroring qcow2 under raw-format
+#
+# Copyright (c) 2019 Virtuozzo International GmbH.
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
+import iotests
+from iotests import qemu_img_create, qemu_io, filter_qemu_io, file_path, log
+
+iotests.verify_image_format(supported_fmts=['qcow2'])
+
+base, top, target = file_path('base', 'top', 'target')
+size = 1024 * 1024
+
+qemu_img_create('-f', iotests.imgfmt, base, str(size))
+log(filter_qemu_io(qemu_io('-f', iotests.imgfmt,
+                           '-c', 'write -P 1 0 1M', base)))
+qemu_img_create('-f', iotests.imgfmt, '-b', base, top, str(size))
+
+vm = iotests.VM().add_drive(None, opts='driver=raw,size=' + str(size) +
+                            ',file.driver=qcow2,file.file.filename=' + top)
+vm.launch()
+
+vm.qmp_log('drive-mirror', device='drive0', target=target, sync='full',
+           filters=[iotests.filter_qmp_testfiles])
+log(vm.event_wait('BLOCK_JOB_READY'), filters=[iotests.filter_qmp_event])
+vm.qmp_log('block-job-complete', device='drive0')
+vm.shutdown()
+
+log(filter_qemu_io(qemu_io('-f', 'raw', '-c', 'read -P 1 0 1M', target)))
+
+log('-- finish --') # avoid extra new-line at the end of .out file
diff --git a/tests/qemu-iotests/263.out b/tests/qemu-iotests/263.out
new file mode 100644
index 0000000000..65e5c812c6
--- /dev/null
+++ b/tests/qemu-iotests/263.out
@@ -0,0 +1,12 @@
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+{"execute": "drive-mirror", "arguments": {"device": "drive0", "sync": "full", "target": "TEST_DIR/PID-target"}}
+{"return": {}}
+{"data": {"device": "drive0", "len": 1048576, "offset": 1048576, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "block-job-complete", "arguments": {"device": "drive0"}}
+{"return": {}}
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+-- finish --
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index f13e5f2e23..186a0220e5 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -271,3 +271,4 @@
 254 rw backing quick
 255 rw quick
 256 rw quick
+263 rw quick
-- 
2.18.0


