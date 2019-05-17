Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5B1C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 15:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F3B2082E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 15:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F3B2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50093 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRehM-0003B7-1J
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 11:23:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hRefg-0001iD-C4
	for qemu-devel@nongnu.org; Fri, 17 May 2019 11:21:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hRefe-0003eQ-Vw
	for qemu-devel@nongnu.org; Fri, 17 May 2019 11:21:20 -0400
Received: from relay.sw.ru ([185.231.240.75]:33978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hRefe-0003PR-NT; Fri, 17 May 2019 11:21:18 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hRefZ-0005qt-W7; Fri, 17 May 2019 18:21:14 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Fri, 17 May 2019 18:21:11 +0300
Message-Id: <20190517152111.206494-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190517152111.206494-1-vsementsov@virtuozzo.com>
References: <20190517152111.206494-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v2 2/2] iotests: test external snapshot with
 bitmap copying
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
	den@virtuozzo.com, armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test shows that external snapshots and incremental backups are
friends.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/254     | 52 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/254.out | 52 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 105 insertions(+)
 create mode 100755 tests/qemu-iotests/254
 create mode 100644 tests/qemu-iotests/254.out

diff --git a/tests/qemu-iotests/254 b/tests/qemu-iotests/254
new file mode 100755
index 0000000000..33cb80a512
--- /dev/null
+++ b/tests/qemu-iotests/254
@@ -0,0 +1,52 @@
+#!/usr/bin/env python
+#
+# Test external snapshot with bitmap copying.
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
+import iotests
+from iotests import qemu_img_create, file_path, log
+
+disk, top = file_path('disk', 'top')
+size = 1024 * 1024
+
+qemu_img_create('-f', iotests.imgfmt, disk, str(size))
+
+vm = iotests.VM().add_drive(disk, opts='node-name=base')
+vm.launch()
+
+vm.qmp_log('block-dirty-bitmap-add', node='drive0', name='bitmap0')
+
+vm.hmp_qemu_io('drive0', 'write 0 512K')
+
+vm.qmp_log('transaction', indent=2, actions=[
+    {'type': 'blockdev-snapshot-sync',
+     'data': {'device': 'drive0', 'snapshot-file': top,
+              'snapshot-node-name': 'snap'}},
+    {'type': 'block-dirty-bitmap-add',
+     'data': {'node': 'snap', 'name': 'bitmap0'}},
+    {'type': 'block-dirty-bitmap-merge',
+     'data': {'node': 'snap', 'target': 'bitmap0',
+              'bitmaps': [{'node': 'base', 'name': 'bitmap0'}]}}
+], filters=[iotests.filter_qmp_testfiles])
+
+result = vm.qmp('query-block')['return'][0]
+log("query-block: device = {}, node-name = {}, dirty-bitmaps:".format(
+    result['device'], result['inserted']['node-name']))
+log(result['dirty-bitmaps'], indent=2)
+
+vm.shutdown()
diff --git a/tests/qemu-iotests/254.out b/tests/qemu-iotests/254.out
new file mode 100644
index 0000000000..d7394cf002
--- /dev/null
+++ b/tests/qemu-iotests/254.out
@@ -0,0 +1,52 @@
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+{
+  "execute": "transaction",
+  "arguments": {
+    "actions": [
+      {
+        "data": {
+          "device": "drive0",
+          "snapshot-file": "TEST_DIR/PID-top",
+          "snapshot-node-name": "snap"
+        },
+        "type": "blockdev-snapshot-sync"
+      },
+      {
+        "data": {
+          "name": "bitmap0",
+          "node": "snap"
+        },
+        "type": "block-dirty-bitmap-add"
+      },
+      {
+        "data": {
+          "bitmaps": [
+            {
+              "name": "bitmap0",
+              "node": "base"
+            }
+          ],
+          "node": "snap",
+          "target": "bitmap0"
+        },
+        "type": "block-dirty-bitmap-merge"
+      }
+    ]
+  }
+}
+{
+  "return": {}
+}
+query-block: device = drive0, node-name = snap, dirty-bitmaps:
+[
+  {
+    "busy": false,
+    "count": 524288,
+    "granularity": 65536,
+    "name": "bitmap0",
+    "persistent": false,
+    "recording": true,
+    "status": "active"
+  }
+]
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 00e474ab0a..5552d0153c 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -250,3 +250,4 @@
 248 rw auto quick
 249 rw auto quick
 252 rw auto backing quick
+254 rw auto backing quick
-- 
2.18.0


