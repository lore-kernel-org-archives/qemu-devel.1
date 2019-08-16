Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132F0C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 09:45:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF0382171F
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 09:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF0382171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyYnR-0003Yq-18
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 05:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1hyYdL-0008Kw-Ba
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 05:34:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hyYdJ-0003ao-Ch
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 05:34:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51790)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hyYdF-0003Wa-W8; Fri, 16 Aug 2019 05:34:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 506C73082B40;
 Fri, 16 Aug 2019 09:34:49 +0000 (UTC)
Received: from localhost.localdomain.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8BD575C1B2;
 Fri, 16 Aug 2019 09:34:48 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 16 Aug 2019 11:34:28 +0200
Message-Id: <20190816093439.14262-6-kwolf@redhat.com>
In-Reply-To: <20190816093439.14262-1-kwolf@redhat.com>
References: <20190816093439.14262-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 16 Aug 2019 09:34:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 05/16] iotests: Test migration with all kinds of
 filter nodes
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test case is motivated by commit 2b23f28639 ('block/copy-on-read:
Fix permissions for inactive node'). Instead of just testing
copy-on-read on migration, let's stack all sorts of filter nodes on top
of each other and try if the resulting VM can still migrate
successfully. For good measure, put everything into an iothread, because
why not?

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/262     | 82 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/262.out | 17 ++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 100 insertions(+)
 create mode 100755 tests/qemu-iotests/262
 create mode 100644 tests/qemu-iotests/262.out

diff --git a/tests/qemu-iotests/262 b/tests/qemu-iotests/262
new file mode 100755
index 0000000000..398f63587e
--- /dev/null
+++ b/tests/qemu-iotests/262
@@ -0,0 +1,82 @@
+#!/usr/bin/env python
+#
+# Copyright (C) 2019 Red Hat, Inc.
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
+# Creator/Owner: Kevin Wolf <kwolf@redhat.com>
+#
+# Test migration with filter drivers present. Keep everything in an
+# iothread just for fun.
+
+import iotests
+import os
+
+iotests.verify_image_format(supported_fmts=3D['qcow2'])
+iotests.verify_platform(['linux'])
+
+with iotests.FilePath('img') as img_path, \
+     iotests.FilePath('mig_fifo') as fifo, \
+     iotests.VM(path_suffix=3D'a') as vm_a, \
+     iotests.VM(path_suffix=3D'b') as vm_b:
+
+    def add_opts(vm):
+        vm.add_object('iothread,id=3Diothread0')
+        vm.add_object('throttle-group,id=3Dtg0,x-bps-total=3D65536')
+        vm.add_blockdev('file,filename=3D%s,node-name=3Ddrive0-file' % (=
img_path))
+        vm.add_blockdev('%s,file=3Ddrive0-file,node-name=3Ddrive0-fmt' %=
 (iotests.imgfmt))
+        vm.add_blockdev('copy-on-read,file=3Ddrive0-fmt,node-name=3Ddriv=
e0-cor')
+        vm.add_blockdev('throttle,file=3Ddrive0-cor,node-name=3Ddrive0-t=
hrottle,throttle-group=3Dtg0')
+        vm.add_blockdev('blkdebug,image=3Ddrive0-throttle,node-name=3Ddr=
ive0-dbg')
+        vm.add_blockdev('null-co,node-name=3Dnull,read-zeroes=3Don')
+        vm.add_blockdev('blkverify,test=3Ddrive0-dbg,raw=3Dnull,node-nam=
e=3Ddrive0-verify')
+
+        if iotests.supports_quorum():
+            vm.add_blockdev('quorum,children.0=3Ddrive0-verify,vote-thre=
shold=3D1,node-name=3Ddrive0-quorum')
+            root =3D "drive0-quorum"
+        else:
+            root =3D "drive0-verify"
+
+        vm.add_device('virtio-blk,drive=3D%s,iothread=3Diothread0' % roo=
t)
+
+    iotests.qemu_img_pipe('create', '-f', iotests.imgfmt, img_path, '64M=
')
+
+    os.mkfifo(fifo)
+
+    iotests.log('Launching source VM...')
+    add_opts(vm_a)
+    vm_a.launch()
+
+    vm_a.enable_migration_events('A')
+
+    iotests.log('Launching destination VM...')
+    add_opts(vm_b)
+    vm_b.add_incoming("exec: cat '%s'" % (fifo))
+    vm_b.launch()
+
+    vm_b.enable_migration_events('B')
+
+    iotests.log('Starting migration to B...')
+    iotests.log(vm_a.qmp('migrate', uri=3D'exec:cat >%s' % (fifo)))
+    with iotests.Timeout(3, 'Migration does not complete'):
+        # Wait for the source first (which includes setup=3Dsetup)
+        vm_a.wait_migration()
+        # Wait for the destination second (which does not)
+        vm_b.wait_migration()
+
+    iotests.log(vm_a.qmp('query-migrate')['return']['status'])
+    iotests.log(vm_b.qmp('query-migrate')['return']['status'])
+
+    iotests.log(vm_a.qmp('query-status'))
+    iotests.log(vm_b.qmp('query-status'))
diff --git a/tests/qemu-iotests/262.out b/tests/qemu-iotests/262.out
new file mode 100644
index 0000000000..5a58e5e9f8
--- /dev/null
+++ b/tests/qemu-iotests/262.out
@@ -0,0 +1,17 @@
+Launching source VM...
+Enabling migration QMP events on A...
+{"return": {}}
+Launching destination VM...
+Enabling migration QMP events on B...
+{"return": {}}
+Starting migration to B...
+{"return": {}}
+{"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"micro=
seconds": "USECS", "seconds": "SECS"}}
+{"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"micr=
oseconds": "USECS", "seconds": "SECS"}}
+{"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"m=
icroseconds": "USECS", "seconds": "SECS"}}
+{"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"micr=
oseconds": "USECS", "seconds": "SECS"}}
+{"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"m=
icroseconds": "USECS", "seconds": "SECS"}}
+completed
+completed
+{"return": {"running": false, "singlestep": false, "status": "postmigrat=
e"}}
+{"return": {"running": true, "singlestep": false, "status": "running"}}
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index f13e5f2e23..71ba3c05dc 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -271,3 +271,4 @@
 254 rw backing quick
 255 rw quick
 256 rw quick
+262 rw quick migration
--=20
2.20.1


