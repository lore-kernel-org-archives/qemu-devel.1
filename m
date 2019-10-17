Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8FEFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 22:08:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC11F21D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 22:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC11F21D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLDwe-0005us-CE
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 18:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iLDk5-0007eM-6S
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 17:55:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iLDk3-0002hA-BR
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 17:55:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55692)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iLDjz-0002fB-Lu; Thu, 17 Oct 2019 17:55:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DA35910C0932;
 Thu, 17 Oct 2019 21:55:26 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-173.bos.redhat.com [10.18.17.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 77D9A5D9CA;
 Thu, 17 Oct 2019 21:55:25 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, jsnow@redhat.com,
 qemu-devel@nongnu.org
Subject: [PULL v3 15/19] iotests: add test 260 to check bitmap life after
 snapshot + commit
Date: Thu, 17 Oct 2019 17:54:32 -0400
Message-Id: <20191017215436.14252-16-jsnow@redhat.com>
In-Reply-To: <20191017215436.14252-1-jsnow@redhat.com>
References: <20191017215436.14252-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Thu, 17 Oct 2019 21:55:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190927122355.7344-8-vsementsov@virtuozzo.com
[Maintainer edit: removed 260 from auto group per Peter Maydell. --js]
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/260     | 89 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/260.out | 52 ++++++++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 142 insertions(+)
 create mode 100755 tests/qemu-iotests/260
 create mode 100644 tests/qemu-iotests/260.out

diff --git a/tests/qemu-iotests/260 b/tests/qemu-iotests/260
new file mode 100755
index 0000000000..4f6082c9d2
--- /dev/null
+++ b/tests/qemu-iotests/260
@@ -0,0 +1,89 @@
+#!/usr/bin/env python
+#
+# Tests for temporary external snapshot when we have bitmaps.
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
+from iotests import qemu_img_create, file_path, log, filter_qmp_event
+
+iotests.verify_image_format(supported_fmts=3D['qcow2'])
+
+base, top =3D file_path('base', 'top')
+size =3D 64 * 1024 * 3
+
+
+def print_bitmap(msg, vm):
+    result =3D vm.qmp('query-block')['return'][0]
+    if 'dirty-bitmaps' in result:
+        bitmap =3D result['dirty-bitmaps'][0]
+        log('{}: name=3D{} dirty-clusters=3D{}'.format(msg, bitmap['name=
'],
+            bitmap['count'] // 64 // 1024))
+    else:
+        log(msg + ': not found')
+
+
+def test(persistent, restart):
+    assert persistent or not restart
+    log("\nTestcase {}persistent {} restart\n".format(
+            '' if persistent else 'non-', 'with' if restart else 'withou=
t'))
+
+    qemu_img_create('-f', iotests.imgfmt, base, str(size))
+
+    vm =3D iotests.VM().add_drive(base)
+    vm.launch()
+
+    vm.qmp_log('block-dirty-bitmap-add', node=3D'drive0', name=3D'bitmap=
0',
+               persistent=3Dpersistent)
+    vm.hmp_qemu_io('drive0', 'write 0 64K')
+    print_bitmap('initial bitmap', vm)
+
+    vm.qmp_log('blockdev-snapshot-sync', device=3D'drive0', snapshot_fil=
e=3Dtop,
+               format=3Diotests.imgfmt, filters=3D[iotests.filter_qmp_te=
stfiles])
+    vm.hmp_qemu_io('drive0', 'write 64K 512')
+    print_bitmap('check that no bitmaps are in snapshot', vm)
+
+    if restart:
+        log("... Restart ...")
+        vm.shutdown()
+        vm =3D iotests.VM().add_drive(top)
+        vm.launch()
+
+    vm.qmp_log('block-commit', device=3D'drive0', top=3Dtop,
+               filters=3D[iotests.filter_qmp_testfiles])
+    ev =3D vm.events_wait((('BLOCK_JOB_READY', None),
+                         ('BLOCK_JOB_COMPLETED', None)))
+    log(filter_qmp_event(ev))
+    if (ev['event'] =3D=3D 'BLOCK_JOB_COMPLETED'):
+        vm.shutdown()
+        log(vm.get_log())
+        exit()
+
+    vm.qmp_log('block-job-complete', device=3D'drive0')
+    ev =3D vm.event_wait('BLOCK_JOB_COMPLETED')
+    log(filter_qmp_event(ev))
+    print_bitmap('check bitmap after commit', vm)
+
+    vm.hmp_qemu_io('drive0', 'write 128K 64K')
+    print_bitmap('check updated bitmap', vm)
+
+    vm.shutdown()
+
+
+test(persistent=3DFalse, restart=3DFalse)
+test(persistent=3DTrue, restart=3DFalse)
+test(persistent=3DTrue, restart=3DTrue)
diff --git a/tests/qemu-iotests/260.out b/tests/qemu-iotests/260.out
new file mode 100644
index 0000000000..2f0d98d036
--- /dev/null
+++ b/tests/qemu-iotests/260.out
@@ -0,0 +1,52 @@
+
+Testcase non-persistent without restart
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "bitmap0", "=
node": "drive0", "persistent": false}}
+{"return": {}}
+initial bitmap: name=3Dbitmap0 dirty-clusters=3D1
+{"execute": "blockdev-snapshot-sync", "arguments": {"device": "drive0", =
"format": "qcow2", "snapshot-file": "TEST_DIR/PID-top"}}
+{"return": {}}
+check that no bitmaps are in snapshot: not found
+{"execute": "block-commit", "arguments": {"device": "drive0", "top": "TE=
ST_DIR/PID-top"}}
+{"return": {}}
+{"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed": 0,=
 "type": "commit"}, "event": "BLOCK_JOB_READY", "timestamp": {"microsecon=
ds": "USECS", "seconds": "SECS"}}
+{"execute": "block-job-complete", "arguments": {"device": "drive0"}}
+{"return": {}}
+{"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed": 0,=
 "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"micros=
econds": "USECS", "seconds": "SECS"}}
+check bitmap after commit: name=3Dbitmap0 dirty-clusters=3D2
+check updated bitmap: name=3Dbitmap0 dirty-clusters=3D3
+
+Testcase persistent without restart
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "bitmap0", "=
node": "drive0", "persistent": true}}
+{"return": {}}
+initial bitmap: name=3Dbitmap0 dirty-clusters=3D1
+{"execute": "blockdev-snapshot-sync", "arguments": {"device": "drive0", =
"format": "qcow2", "snapshot-file": "TEST_DIR/PID-top"}}
+{"return": {}}
+check that no bitmaps are in snapshot: not found
+{"execute": "block-commit", "arguments": {"device": "drive0", "top": "TE=
ST_DIR/PID-top"}}
+{"return": {}}
+{"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed": 0,=
 "type": "commit"}, "event": "BLOCK_JOB_READY", "timestamp": {"microsecon=
ds": "USECS", "seconds": "SECS"}}
+{"execute": "block-job-complete", "arguments": {"device": "drive0"}}
+{"return": {}}
+{"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed": 0,=
 "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"micros=
econds": "USECS", "seconds": "SECS"}}
+check bitmap after commit: name=3Dbitmap0 dirty-clusters=3D2
+check updated bitmap: name=3Dbitmap0 dirty-clusters=3D3
+
+Testcase persistent with restart
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "bitmap0", "=
node": "drive0", "persistent": true}}
+{"return": {}}
+initial bitmap: name=3Dbitmap0 dirty-clusters=3D1
+{"execute": "blockdev-snapshot-sync", "arguments": {"device": "drive0", =
"format": "qcow2", "snapshot-file": "TEST_DIR/PID-top"}}
+{"return": {}}
+check that no bitmaps are in snapshot: not found
+... Restart ...
+{"execute": "block-commit", "arguments": {"device": "drive0", "top": "TE=
ST_DIR/PID-top"}}
+{"return": {}}
+{"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed": 0,=
 "type": "commit"}, "event": "BLOCK_JOB_READY", "timestamp": {"microsecon=
ds": "USECS", "seconds": "SECS"}}
+{"execute": "block-job-complete", "arguments": {"device": "drive0"}}
+{"return": {}}
+{"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed": 0,=
 "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"micros=
econds": "USECS", "seconds": "SECS"}}
+check bitmap after commit: name=3Dbitmap0 dirty-clusters=3D2
+check updated bitmap: name=3Dbitmap0 dirty-clusters=3D3
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 7dac79a783..a73df279e5 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -273,6 +273,7 @@
 256 rw quick
 257 rw
 258 rw quick
+260 rw quick
 262 rw quick migration
 263 rw quick
 265 rw auto quick
--=20
2.21.0


