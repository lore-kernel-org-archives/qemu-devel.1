Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EABEC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 09:57:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB2FC206B5
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 09:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2FC206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k54YF-00049q-87
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 05:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.reiter@proxmox.com>)
 id 1k54Wx-0002Kr-CI; Mon, 10 Aug 2020 05:55:47 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:51472)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.reiter@proxmox.com>)
 id 1k54Wu-0003yk-PN; Mon, 10 Aug 2020 05:55:46 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 65F9644562;
 Mon, 10 Aug 2020 11:55:31 +0200 (CEST)
From: Stefan Reiter <s.reiter@proxmox.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.1 v2 2/2] iotests: add test for unaligned granularity
 bitmap backup
Date: Mon, 10 Aug 2020 11:55:23 +0200
Message-Id: <20200810095523.15071-2-s.reiter@proxmox.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200810095523.15071-1-s.reiter@proxmox.com>
References: <20200810095523.15071-1-s.reiter@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.186.127.180;
 envelope-from=s.reiter@proxmox.com; helo=proxmox-new.maurer-it.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 05:55:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Start a VM with a 4097 byte image attached, add a 4096 byte granularity
dirty bitmap, mark it dirty, and then do a backup.

This used to run into an assert and fail, check that it works as
expected and also check the created image to ensure that misaligned
backups in general work correctly.

Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>
---

I saw Andrey's big series covering iotest 303 so I went for 304. Never submitted
one before so I hope that's okay, if not feel free to renumber it.

 tests/qemu-iotests/304     | 68 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/304.out |  2 ++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 71 insertions(+)
 create mode 100755 tests/qemu-iotests/304
 create mode 100644 tests/qemu-iotests/304.out

diff --git a/tests/qemu-iotests/304 b/tests/qemu-iotests/304
new file mode 100755
index 0000000000..9a3b0224fa
--- /dev/null
+++ b/tests/qemu-iotests/304
@@ -0,0 +1,68 @@
+#!/usr/bin/env python3
+#
+# Tests dirty-bitmap backup with unaligned bitmap granularity
+#
+# Copyright (c) 2020 Proxmox Server Solutions
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
+# owner=s.reiter@proxmox.com
+
+import iotests
+from iotests import qemu_img_create, qemu_img_log, file_path
+
+iotests.script_initialize(supported_fmts=['qcow2'],
+                          supported_protocols=['file'])
+
+test_img = file_path('test.qcow2')
+target_img = file_path('target.qcow2')
+
+# unaligned by one byte
+image_len = 4097
+bitmap_granularity = 4096
+
+qemu_img_create('-f', iotests.imgfmt, test_img, str(image_len))
+
+# create VM and add dirty bitmap
+vm = iotests.VM().add_drive(test_img)
+vm.launch()
+
+vm.qmp('block-dirty-bitmap-add', **{
+    'node': 'drive0',
+    'name': 'bitmap0',
+    'granularity': bitmap_granularity
+})
+
+# mark entire bitmap as dirty
+vm.hmp_qemu_io('drive0', 'write -P0x16 0 4096');
+vm.hmp_qemu_io('drive0', 'write -P0x17 4097 1');
+
+# do backup and wait for completion
+vm.qmp('drive-backup', **{
+    'device': 'drive0',
+    'sync': 'full',
+    'target': target_img,
+    'bitmap': 'bitmap0',
+    'bitmap-mode': 'on-success'
+})
+
+event = vm.event_wait(name='BLOCK_JOB_COMPLETED',
+                      match={'data': {'device': 'drive0'}},
+                      timeout=5.0)
+
+# shutdown to sync images
+vm.shutdown()
+
+# backup succeeded, check if image is correct
+qemu_img_log('compare', test_img, target_img)
diff --git a/tests/qemu-iotests/304.out b/tests/qemu-iotests/304.out
new file mode 100644
index 0000000000..381cc056f7
--- /dev/null
+++ b/tests/qemu-iotests/304.out
@@ -0,0 +1,2 @@
+Images are identical.
+
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 025ed5238d..7f76066640 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -309,3 +309,4 @@
 299 auto quick
 301 backing quick
 302 quick
+304 rw quick
-- 
2.20.1



