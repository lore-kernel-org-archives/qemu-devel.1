Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6490C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:41:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7953C2253D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7953C2253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ituim-0000gf-6V
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 09:41:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ituVz-0001WI-AV
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:28:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ituVx-0000hv-He
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:28:23 -0500
Received: from relay.sw.ru ([185.231.240.75]:50832)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ituVt-0000dj-5v; Tue, 21 Jan 2020 09:28:17 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1ituVp-0000mn-3N; Tue, 21 Jan 2020 17:28:13 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 2/2] iotests: add test for backup-top failure on permission
 activation
Date: Tue, 21 Jan 2020 17:28:02 +0300
Message-Id: <20200121142802.21467-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200121142802.21467-1-vsementsov@virtuozzo.com>
References: <20200121142802.21467-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: kwolf@redhat.com, qemu-stable@nongnu.org, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test checks that bug is really fixed by previous commit.

Cc: qemu-stable@nongnu.org # v4.2.0
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/283     | 92 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/283.out |  8 ++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 101 insertions(+)
 create mode 100644 tests/qemu-iotests/283
 create mode 100644 tests/qemu-iotests/283.out

diff --git a/tests/qemu-iotests/283 b/tests/qemu-iotests/283
new file mode 100644
index 0000000000..293e557bd9
--- /dev/null
+++ b/tests/qemu-iotests/283
@@ -0,0 +1,92 @@
+#!/usr/bin/env python
+#
+# Test for backup-top filter permission activation failure
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
+
+# The test is unrelated to formats, restrict it to qcow2 to avoid extra runs
+iotests.verify_image_format(supported_fmts=['qcow2'])
+
+size = 1024 * 1024
+
+""" Test description
+
+When performing a backup, all writes on the source subtree must go through the
+backup-top filter so it can copy all data to the target before it is changed.
+backup-top filter is appended above source node, to achieve this thing, so all
+parents of source node are handled. A configuration with side parents of source
+sub-tree with write permission is unsupported (we'd have append several
+backup-top filter like nodes to handle such parents). The test create an
+example of such configuration and checks that a backup is then not allowed
+(blockdev-backup command should fail).
+
+The configuration:
+
+    ┌────────┐  target  ┌─────────────┐
+    │ target │ ◀─────── │ backup_top  │
+    └────────┘          └─────────────┘
+                            │
+                            │ backing
+                            ▼
+                        ┌─────────────┐
+                        │   source    │
+                        └─────────────┘
+                            │
+                            │ file
+                            ▼
+                        ┌─────────────┐  write perm   ┌───────┐
+                        │    base     │ ◀──────────── │ other │
+                        └─────────────┘               └───────┘
+
+On activation (see .active field of backup-top state in block/backup-top.c),
+backup-top is going to unshare write permission on its source child. Write
+unsharing will be propagated to the "source->base" link and will conflict with
+other node write permission. So permission update will fail and backup job will
+not be started.
+
+Note, that the only thing which prevents backup of running on such
+configuration is default permission propagation scheme. It may be altered by
+different block drivers, so backup will run in invalid configuration. But
+something is better than nothing. Also, before the previous commit (commit
+preceding this test creation), starting backup on such configuration led to
+crash, so current "something" is a lot better, and this test actual goal is
+to check that crash is fixed :)
+"""
+
+vm = iotests.VM()
+vm.launch()
+
+vm.qmp_log('blockdev-add', **{'node-name': 'target', 'driver': 'null-co'})
+
+vm.qmp_log('blockdev-add', **{
+    'node-name': 'source',
+    'driver': 'blkdebug',
+    'image': {'node-name': 'base', 'driver': 'null-co', 'size': size}
+})
+
+vm.qmp_log('blockdev-add', **{
+    'node-name': 'other',
+    'driver': 'blkdebug',
+    'image': 'base',
+    'take-child-perms': ['write']
+})
+
+vm.qmp_log('blockdev-backup', sync='full', device='source', target='target')
+
+vm.shutdown()
diff --git a/tests/qemu-iotests/283.out b/tests/qemu-iotests/283.out
new file mode 100644
index 0000000000..daaf5828c1
--- /dev/null
+++ b/tests/qemu-iotests/283.out
@@ -0,0 +1,8 @@
+{"execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "target"}}
+{"return": {}}
+{"execute": "blockdev-add", "arguments": {"driver": "blkdebug", "image": {"driver": "null-co", "node-name": "base", "size": 1048576}, "node-name": "source"}}
+{"return": {}}
+{"execute": "blockdev-add", "arguments": {"driver": "blkdebug", "image": "base", "node-name": "other", "take-child-perms": ["write"]}}
+{"return": {}}
+{"execute": "blockdev-backup", "arguments": {"device": "source", "sync": "full", "target": "target"}}
+{"error": {"class": "GenericError", "desc": "Cannot set permissions for backup-top filter: Conflicts with use by other as 'image', which uses 'write' on base"}}
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 9d30a4b6c4..1904223020 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -289,3 +289,4 @@
 279 rw backing quick
 280 rw migration quick
 281 rw quick
+283 auto quick
-- 
2.21.0


