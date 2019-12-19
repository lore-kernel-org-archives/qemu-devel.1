Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2654C2D0D1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:57:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4127D2465E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gp7wR17O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4127D2465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii03O-00059N-JN
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 12:57:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihzYk-0007F1-Js
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:26:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihzYi-0008Bt-8P
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:58 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26915
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihzYf-00087i-6b
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576776352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e3TfjD0fS7Mp3hQfmRnugCBI6yIIHc/ijdcZX5e1m5I=;
 b=gp7wR17OtCPDjtnz/+Ij79SLe4ci63R6vQ+0cQp6+9ktQGcLVFyWPgokxn6uZ/ntC+Gq/B
 dgC6KpqOCdzFprU9Rvt0uSvkYn7sHZ/rE0rv2BiULvfgGUPw9t3f78zs2YcjIQNApg0lh0
 bUjadMS4WPhXPJgS91kG5R5Q61yaG4E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-cS1cljoJO2-oHGtnnKg7Ww-1; Thu, 19 Dec 2019 12:25:46 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCEA41005502;
 Thu, 19 Dec 2019 17:25:44 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E728A620C0;
 Thu, 19 Dec 2019 17:25:43 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 30/30] iotests: Test external snapshot with VM state
Date: Thu, 19 Dec 2019 18:24:41 +0100
Message-Id: <20191219172441.7289-31-kwolf@redhat.com>
In-Reply-To: <20191219172441.7289-1-kwolf@redhat.com>
References: <20191219172441.7289-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: cS1cljoJO2-oHGtnnKg7Ww-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This tests creating an external snapshot with VM state (which results in
an active overlay over an inactive backing file, which is also the root
node of an inactive BlockBackend), re-activating the images and
performing some operations to test that the re-activation worked as
intended.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/280     | 83 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/280.out | 50 +++++++++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 134 insertions(+)
 create mode 100755 tests/qemu-iotests/280
 create mode 100644 tests/qemu-iotests/280.out

diff --git a/tests/qemu-iotests/280 b/tests/qemu-iotests/280
new file mode 100755
index 0000000000..0b1fa8e1d8
--- /dev/null
+++ b/tests/qemu-iotests/280
@@ -0,0 +1,83 @@
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
+# Test migration to file for taking an external snapshot with VM state.
+
+import iotests
+import os
+
+iotests.verify_image_format(supported_fmts=3D['qcow2'])
+iotests.verify_protocol(supported=3D['file'])
+iotests.verify_platform(['linux'])
+
+with iotests.FilePath('base') as base_path , \
+     iotests.FilePath('top') as top_path, \
+     iotests.VM() as vm:
+
+    iotests.qemu_img_log('create', '-f', iotests.imgfmt, base_path, '64M')
+
+    iotests.log('=3D=3D=3D Launch VM =3D=3D=3D')
+    vm.add_object('iothread,id=3Diothread0')
+    vm.add_blockdev('file,filename=3D%s,node-name=3Dbase-file' % (base_pat=
h))
+    vm.add_blockdev('%s,file=3Dbase-file,node-name=3Dbase-fmt' % (iotests.=
imgfmt))
+    vm.add_device('virtio-blk,drive=3Dbase-fmt,iothread=3Diothread0,id=3Dv=
da')
+    vm.launch()
+
+    vm.enable_migration_events('VM')
+
+    iotests.log('\n=3D=3D=3D Migrate to file =3D=3D=3D')
+    vm.qmp_log('migrate', uri=3D'exec:cat > /dev/null')
+
+    with iotests.Timeout(3, 'Migration does not complete'):
+        vm.wait_migration()
+
+    iotests.log('\nVM is now stopped:')
+    iotests.log(vm.qmp('query-migrate')['return']['status'])
+    vm.qmp_log('query-status')
+
+    iotests.log('\n=3D=3D=3D Create a snapshot of the disk image =3D=3D=3D=
')
+    vm.blockdev_create({
+        'driver': 'file',
+        'filename': top_path,
+        'size': 0,
+    })
+    vm.qmp_log('blockdev-add', node_name=3D'top-file',
+               driver=3D'file', filename=3Dtop_path,
+               filters=3D[iotests.filter_qmp_testfiles])
+
+    vm.blockdev_create({
+        'driver': iotests.imgfmt,
+        'file': 'top-file',
+        'size': 1024 * 1024,
+    })
+    vm.qmp_log('blockdev-add', node_name=3D'top-fmt',
+               driver=3Diotests.imgfmt, file=3D'top-file')
+
+    vm.qmp_log('blockdev-snapshot', node=3D'base-fmt', overlay=3D'top-fmt'=
)
+
+    iotests.log('\n=3D=3D=3D Resume the VM and simulate a write request =
=3D=3D=3D')
+    vm.qmp_log('cont')
+    iotests.log(vm.hmp_qemu_io('-d vda/virtio-backend', 'write 4k 4k'))
+
+    iotests.log('\n=3D=3D=3D Commit it to the backing file =3D=3D=3D')
+    result =3D vm.qmp_log('block-commit', job_id=3D'job0', auto_dismiss=3D=
False,
+                        device=3D'top-fmt', top_node=3D'top-fmt',
+                        filters=3D[iotests.filter_qmp_testfiles])
+    if 'return' in result:
+        vm.run_job('job0')
diff --git a/tests/qemu-iotests/280.out b/tests/qemu-iotests/280.out
new file mode 100644
index 0000000000..5d382faaa8
--- /dev/null
+++ b/tests/qemu-iotests/280.out
@@ -0,0 +1,50 @@
+Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D67108864 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+
+=3D=3D=3D Launch VM =3D=3D=3D
+Enabling migration QMP events on VM...
+{"return": {}}
+
+=3D=3D=3D Migrate to file =3D=3D=3D
+{"execute": "migrate", "arguments": {"uri": "exec:cat > /dev/null"}}
+{"return": {}}
+{"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"microse=
conds": "USECS", "seconds": "SECS"}}
+{"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"micros=
econds": "USECS", "seconds": "SECS"}}
+{"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"mic=
roseconds": "USECS", "seconds": "SECS"}}
+
+VM is now stopped:
+completed
+{"execute": "query-status", "arguments": {}}
+{"return": {"running": false, "singlestep": false, "status": "postmigrate"=
}}
+
+=3D=3D=3D Create a snapshot of the disk image =3D=3D=3D
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": =
{"driver": "file", "filename": "TEST_DIR/PID-top", "size": 0}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+{"execute": "blockdev-add", "arguments": {"driver": "file", "filename": "T=
EST_DIR/PID-top", "node-name": "top-file"}}
+{"return": {}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": =
{"driver": "qcow2", "file": "top-file", "size": 1048576}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": "top-=
file", "node-name": "top-fmt"}}
+{"return": {}}
+{"execute": "blockdev-snapshot", "arguments": {"node": "base-fmt", "overla=
y": "top-fmt"}}
+{"return": {}}
+
+=3D=3D=3D Resume the VM and simulate a write request =3D=3D=3D
+{"execute": "cont", "arguments": {}}
+{"return": {}}
+{"return": ""}
+
+=3D=3D=3D Commit it to the backing file =3D=3D=3D
+{"execute": "block-commit", "arguments": {"auto-dismiss": false, "device":=
 "top-fmt", "job-id": "job0", "top-node": "top-fmt"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "job0"}}
+{"return": {}}
+{"data": {"device": "job0", "len": 65536, "offset": 65536, "speed": 0, "ty=
pe": "commit"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "=
USECS", "seconds": "SECS"}}
+{"data": {"device": "job0", "len": 65536, "offset": 65536, "speed": 0, "ty=
pe": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds=
": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index eb57ddc72c..cb2b789e44 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -287,3 +287,4 @@
 273 backing quick
 277 rw quick
 279 rw backing quick
+280 rw migration quick
--=20
2.20.1


