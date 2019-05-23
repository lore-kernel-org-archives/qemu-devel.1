Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E520AC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 17:14:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACAD820815
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 17:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACAD820815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40925 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTrI7-0008Vq-17
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 13:14:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hTrBO-0003oW-CN
	for qemu-devel@nongnu.org; Thu, 23 May 2019 13:07:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hTrBM-0001mX-8O
	for qemu-devel@nongnu.org; Thu, 23 May 2019 13:07:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>)
	id 1hTrBD-0001aq-6K; Thu, 23 May 2019 13:06:59 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B15703079B76;
	Thu, 23 May 2019 17:06:53 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-187.bos.redhat.com [10.18.17.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D4A371017E2E;
	Thu, 23 May 2019 17:06:52 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Thu, 23 May 2019 13:06:43 -0400
Message-Id: <20190523170643.20794-6-jsnow@redhat.com>
In-Reply-To: <20190523170643.20794-1-jsnow@redhat.com>
References: <20190523170643.20794-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 23 May 2019 17:06:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 5/5] iotests: add iotest 250 for testing
 blockdev-backup across iothread contexts
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
	Markus Armbruster <armbru@redhat.com>,
	Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/250     | 122 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/250.out | 119 ++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 242 insertions(+)
 create mode 100755 tests/qemu-iotests/250
 create mode 100644 tests/qemu-iotests/250.out

diff --git a/tests/qemu-iotests/250 b/tests/qemu-iotests/250
new file mode 100755
index 0000000000..c594a43205
--- /dev/null
+++ b/tests/qemu-iotests/250
@@ -0,0 +1,122 @@
+#!/usr/bin/env python
+#
+# Test incremental/backup across iothread contexts
+#
+# Copyright (c) 2019 John Snow for Red Hat, Inc.
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
+# owner=3Djsnow@redhat.com
+
+import os
+import iotests
+from iotests import log
+
+iotests.verify_image_format(supported_fmts=3D['qcow2'])
+size =3D 64 * 1024 * 1024
+
+with iotests.FilePath('img0') as img0_path, \
+     iotests.FilePath('img1') as img1_path, \
+     iotests.FilePath('img0-full') as img0_full_path, \
+     iotests.FilePath('img1-full') as img1_full_path, \
+     iotests.FilePath('img0-incr') as img0_incr_path, \
+     iotests.FilePath('img1-incr') as img1_incr_path, \
+     iotests.VM() as vm:
+
+    def create_target(filepath, name, size):
+        basename =3D os.path.basename(filepath)
+        nodename =3D "file_{}".format(basename)
+        log(vm.command('blockdev-create', job_id=3D'job1',
+                       options=3D{
+                           'driver': 'file',
+                           'filename': filepath,
+                           'size': 0,
+                       }))
+        vm.run_job('job1')
+        log(vm.command('blockdev-add', driver=3D'file',
+                       node_name=3Dnodename, filename=3Dfilepath))
+        log(vm.command('blockdev-create', job_id=3D'job2',
+                       options=3D{
+                           'driver': iotests.imgfmt,
+                           'file': nodename,
+                           'size': size,
+                       }))
+        vm.run_job('job2')
+        log(vm.command('blockdev-add', driver=3Diotests.imgfmt,
+                       node_name=3Dname,
+                       file=3Dnodename))
+
+    log('--- Preparing images & VM ---\n')
+    vm.add_object('iothread,id=3Diothread0')
+    vm.add_object('iothread,id=3Diothread1')
+    vm.add_device('virtio-scsi-pci,id=3Dscsi0,iothread=3Diothread0')
+    vm.add_device('virtio-scsi-pci,id=3Dscsi1,iothread=3Diothread1')
+    iotests.qemu_img_create('-f', iotests.imgfmt, img0_path, str(size))
+    iotests.qemu_img_create('-f', iotests.imgfmt, img1_path, str(size))
+    vm.add_drive(img0_path, interface=3D'none')
+    vm.add_device('scsi-hd,id=3Ddevice0,drive=3Ddrive0,bus=3Dscsi0.0')
+    vm.add_drive(img1_path, interface=3D'none')
+    vm.add_device('scsi-hd,id=3Ddevice1,drive=3Ddrive1,bus=3Dscsi1.0')
+
+    log('--- Starting VM ---\n')
+    vm.launch()
+
+    log('--- Create Targets & Full Backups ---\n')
+    create_target(img0_full_path, 'img0-full', size)
+    create_target(img1_full_path, 'img1-full', size)
+    ret =3D vm.qmp_log('transaction', indent=3D2, actions=3D[
+        { 'type': 'block-dirty-bitmap-add',
+          'data': { 'node': 'drive0', 'name': 'bitmap0' }},
+        { 'type': 'block-dirty-bitmap-add',
+          'data': { 'node': 'drive1', 'name': 'bitmap1' }},
+        { 'type': 'blockdev-backup',
+          'data': { 'device': 'drive0',
+                    'target': 'img0-full',
+                    'sync': 'full',
+                    'job-id': 'j0' }},
+        { 'type': 'blockdev-backup',
+          'data': { 'device': 'drive1',
+                    'target': 'img1-full',
+                    'sync': 'full',
+                    'job-id': 'j1' }}
+    ])
+    if "error" in ret:
+        raise Exception(ret['error']['desc'])
+    vm.run_job('j0', auto_dismiss=3DTrue)
+    vm.run_job('j1', auto_dismiss=3DTrue)
+
+    log('\n--- Create Targets & Incremental Backups ---\n')
+    create_target(img0_incr_path, 'img0-incr', size)
+    create_target(img1_incr_path, 'img1-incr', size)
+    ret =3D vm.qmp_log('transaction', indent=3D2, actions=3D[
+        { 'type': 'blockdev-backup',
+          'data': { 'device': 'drive0',
+                    'target': 'img0-incr',
+                    'sync': 'incremental',
+                    'bitmap': 'bitmap0',
+                    'job-id': 'j2' }},
+        { 'type': 'blockdev-backup',
+          'data': { 'device': 'drive1',
+                    'target': 'img1-incr',
+                    'sync': 'incremental',
+                    'bitmap': 'bitmap1',
+                    'job-id': 'j3' }}
+    ])
+    if "error" in ret:
+        raise Exception(ret['error']['desc'])
+    vm.run_job('j2', auto_dismiss=3DTrue)
+    vm.run_job('j3', auto_dismiss=3DTrue)
+
+    log('\n--- Done ---')
+    vm.shutdown()
diff --git a/tests/qemu-iotests/250.out b/tests/qemu-iotests/250.out
new file mode 100644
index 0000000000..eec38614ec
--- /dev/null
+++ b/tests/qemu-iotests/250.out
@@ -0,0 +1,119 @@
+--- Preparing images & VM ---
+
+--- Starting VM ---
+
+--- Create Targets & Full Backups ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "job1"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "job2"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "job1"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "job2"}}
+{"return": {}}
+{}
+{
+  "execute": "transaction",
+  "arguments": {
+    "actions": [
+      {
+        "data": {
+          "name": "bitmap0",
+          "node": "drive0"
+        },
+        "type": "block-dirty-bitmap-add"
+      },
+      {
+        "data": {
+          "name": "bitmap1",
+          "node": "drive1"
+        },
+        "type": "block-dirty-bitmap-add"
+      },
+      {
+        "data": {
+          "device": "drive0",
+          "job-id": "j0",
+          "sync": "full",
+          "target": "img0-full"
+        },
+        "type": "blockdev-backup"
+      },
+      {
+        "data": {
+          "device": "drive1",
+          "job-id": "j1",
+          "sync": "full",
+          "target": "img1-full"
+        },
+        "type": "blockdev-backup"
+      }
+    ]
+  }
+}
+{
+  "return": {}
+}
+{"data": {"device": "j0", "len": 67108864, "offset": 67108864, "speed": =
0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"micr=
oseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "j1", "len": 67108864, "offset": 67108864, "speed": =
0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"micr=
oseconds": "USECS", "seconds": "SECS"}}
+
+--- Create Targets & Incremental Backups ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "job1"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "job2"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "job1"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "job2"}}
+{"return": {}}
+{}
+{
+  "execute": "transaction",
+  "arguments": {
+    "actions": [
+      {
+        "data": {
+          "bitmap": "bitmap0",
+          "device": "drive0",
+          "job-id": "j2",
+          "sync": "incremental",
+          "target": "img0-incr"
+        },
+        "type": "blockdev-backup"
+      },
+      {
+        "data": {
+          "bitmap": "bitmap1",
+          "device": "drive1",
+          "job-id": "j3",
+          "sync": "incremental",
+          "target": "img1-incr"
+        },
+        "type": "blockdev-backup"
+      }
+    ]
+  }
+}
+{
+  "return": {}
+}
+{"data": {"device": "j2", "len": 67108864, "offset": 67108864, "speed": =
0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"micr=
oseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "j3", "len": 67108864, "offset": 67108864, "speed": =
0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"micr=
oseconds": "USECS", "seconds": "SECS"}}
+
+--- Done ---
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 2758f48143..ea52e8660d 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -249,6 +249,7 @@
 247 rw auto quick
 248 rw auto quick
 249 rw auto quick
+250 rw auto quick
 252 rw auto backing quick
 253 rw auto quick
 255 rw auto quick
--=20
2.20.1


