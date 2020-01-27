Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6553BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 18:03:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2489621739
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 18:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMUxnHbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2489621739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw8jI-0003Ek-B9
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 13:03:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iw8cd-0002Qi-I4
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:56:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iw8ca-0002w9-0t
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:56:27 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33818
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iw8cZ-0002vs-SQ
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:56:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580147783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4lLlOqbMbLKMqokwuyfhJlJ7LYn0AhIBA8RZ84mtuNM=;
 b=EMUxnHbulWe9v/myhSuri0xJI9LG7bUPVqgG2rMavoiXMkY6UdE9A9zBXidjuS5YJjTFos
 YpgeHKJLG1BQjofwKjsopOAV3CBLak4Dd4UaWnYUn1t6zM3ETMv00GsGqfBg0AQZyr8RZ0
 BQJIP9KPPMSF+iBExsqDvQO6065XQQ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-MzoWjmFGMveUKubD7IZlWg-1; Mon, 27 Jan 2020 12:56:19 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49B82107ACC4;
 Mon, 27 Jan 2020 17:56:18 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-108.ams2.redhat.com
 [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 52C95811FA;
 Mon, 27 Jan 2020 17:56:17 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 10/13] iotests: Test handling of AioContexts with some blockdev
 actions
Date: Mon, 27 Jan 2020 18:55:56 +0100
Message-Id: <20200127175559.18173-11-kwolf@redhat.com>
In-Reply-To: <20200127175559.18173-1-kwolf@redhat.com>
References: <20200127175559.18173-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: MzoWjmFGMveUKubD7IZlWg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

From: Sergio Lopez <slp@redhat.com>

Includes the following tests:

 - Adding a dirty bitmap.
   * RHBZ: 1782175

 - Starting a drive-mirror to an NBD-backed target.
   * RHBZ: 1746217, 1773517

 - Aborting an external snapshot transaction.
   * RHBZ: 1779036

 - Aborting a blockdev backup transaction.
   * RHBZ: 1782111

For each one of them, a VM with a number of disks running in an
IOThread AioContext is used.

Signed-off-by: Sergio Lopez <slp@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/281     | 247 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/281.out |   5 +
 tests/qemu-iotests/group   |   1 +
 3 files changed, 253 insertions(+)
 create mode 100755 tests/qemu-iotests/281
 create mode 100644 tests/qemu-iotests/281.out

diff --git a/tests/qemu-iotests/281 b/tests/qemu-iotests/281
new file mode 100755
index 0000000000..269d583b2c
--- /dev/null
+++ b/tests/qemu-iotests/281
@@ -0,0 +1,247 @@
+#!/usr/bin/env python
+#
+# Test cases for blockdev + IOThread interactions
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
+
+import os
+import iotests
+from iotests import qemu_img
+
+image_len =3D 64 * 1024 * 1024
+
+# Test for RHBZ#1782175
+class TestDirtyBitmapIOThread(iotests.QMPTestCase):
+    drive0_img =3D os.path.join(iotests.test_dir, 'drive0.img')
+    images =3D { 'drive0': drive0_img }
+
+    def setUp(self):
+        for name in self.images:
+            qemu_img('create', '-f', iotests.imgfmt,
+                     self.images[name], str(image_len))
+
+        self.vm =3D iotests.VM()
+        self.vm.add_object('iothread,id=3Diothread0')
+
+        for name in self.images:
+            self.vm.add_blockdev('driver=3Dfile,filename=3D%s,node-name=3D=
file_%s'
+                                 % (self.images[name], name))
+            self.vm.add_blockdev('driver=3Dqcow2,file=3Dfile_%s,node-name=
=3D%s'
+                                 % (name, name))
+
+        self.vm.launch()
+        self.vm.qmp('x-blockdev-set-iothread',
+                    node_name=3D'drive0', iothread=3D'iothread0',
+                    force=3DTrue)
+
+    def tearDown(self):
+        self.vm.shutdown()
+        for name in self.images:
+            os.remove(self.images[name])
+
+    def test_add_dirty_bitmap(self):
+        result =3D self.vm.qmp(
+            'block-dirty-bitmap-add',
+            node=3D'drive0',
+            name=3D'bitmap1',
+            persistent=3DTrue,
+        )
+
+        self.assert_qmp(result, 'return', {})
+
+
+# Test for RHBZ#1746217 & RHBZ#1773517
+class TestNBDMirrorIOThread(iotests.QMPTestCase):
+    nbd_sock =3D os.path.join(iotests.sock_dir, 'nbd.sock')
+    drive0_img =3D os.path.join(iotests.test_dir, 'drive0.img')
+    mirror_img =3D os.path.join(iotests.test_dir, 'mirror.img')
+    images =3D { 'drive0': drive0_img, 'mirror': mirror_img }
+
+    def setUp(self):
+        for name in self.images:
+            qemu_img('create', '-f', iotests.imgfmt,
+                     self.images[name], str(image_len))
+
+        self.vm_src =3D iotests.VM(path_suffix=3D'src')
+        self.vm_src.add_object('iothread,id=3Diothread0')
+        self.vm_src.add_blockdev('driver=3Dfile,filename=3D%s,node-name=3D=
file0'
+                          % (self.drive0_img))
+        self.vm_src.add_blockdev('driver=3Dqcow2,file=3Dfile0,node-name=3D=
drive0')
+        self.vm_src.launch()
+        self.vm_src.qmp('x-blockdev-set-iothread',
+                        node_name=3D'drive0', iothread=3D'iothread0',
+                        force=3DTrue)
+
+        self.vm_tgt =3D iotests.VM(path_suffix=3D'tgt')
+        self.vm_tgt.add_object('iothread,id=3Diothread0')
+        self.vm_tgt.add_blockdev('driver=3Dfile,filename=3D%s,node-name=3D=
file0'
+                          % (self.mirror_img))
+        self.vm_tgt.add_blockdev('driver=3Dqcow2,file=3Dfile0,node-name=3D=
drive0')
+        self.vm_tgt.launch()
+        self.vm_tgt.qmp('x-blockdev-set-iothread',
+                        node_name=3D'drive0', iothread=3D'iothread0',
+                        force=3DTrue)
+
+    def tearDown(self):
+        self.vm_src.shutdown()
+        self.vm_tgt.shutdown()
+        for name in self.images:
+            os.remove(self.images[name])
+
+    def test_nbd_mirror(self):
+        result =3D self.vm_tgt.qmp(
+            'nbd-server-start',
+            addr=3D{
+                'type': 'unix',
+                'data': { 'path': self.nbd_sock }
+            }
+        )
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm_tgt.qmp(
+            'nbd-server-add',
+            device=3D'drive0',
+            writable=3DTrue
+        )
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm_src.qmp(
+            'drive-mirror',
+            device=3D'drive0',
+            target=3D'nbd+unix:///drive0?socket=3D' + self.nbd_sock,
+            sync=3D'full',
+            mode=3D'existing',
+            speed=3D64*1024*1024,
+            job_id=3D'j1'
+        )
+        self.assert_qmp(result, 'return', {})
+
+        self.vm_src.event_wait(name=3D"BLOCK_JOB_READY")
+
+
+# Test for RHBZ#1779036
+class TestExternalSnapshotAbort(iotests.QMPTestCase):
+    drive0_img =3D os.path.join(iotests.test_dir, 'drive0.img')
+    snapshot_img =3D os.path.join(iotests.test_dir, 'snapshot.img')
+    images =3D { 'drive0': drive0_img, 'snapshot': snapshot_img }
+
+    def setUp(self):
+        for name in self.images:
+            qemu_img('create', '-f', iotests.imgfmt,
+                     self.images[name], str(image_len))
+
+        self.vm =3D iotests.VM()
+        self.vm.add_object('iothread,id=3Diothread0')
+        self.vm.add_blockdev('driver=3Dfile,filename=3D%s,node-name=3Dfile=
0'
+                          % (self.drive0_img))
+        self.vm.add_blockdev('driver=3Dqcow2,file=3Dfile0,node-name=3Ddriv=
e0')
+        self.vm.launch()
+        self.vm.qmp('x-blockdev-set-iothread',
+                    node_name=3D'drive0', iothread=3D'iothread0',
+                    force=3DTrue)
+
+    def tearDown(self):
+        self.vm.shutdown()
+        for name in self.images:
+            os.remove(self.images[name])
+
+    def test_external_snapshot_abort(self):
+        # Use a two actions transaction with a bogus values on the second
+        # one to trigger an abort of the transaction.
+        result =3D self.vm.qmp('transaction', actions=3D[
+            {
+                'type': 'blockdev-snapshot-sync',
+                'data': { 'node-name': 'drive0',
+                          'snapshot-file': self.snapshot_img,
+                          'snapshot-node-name': 'snap1',
+                          'mode': 'absolute-paths',
+                          'format': 'qcow2' }
+            },
+            {
+                'type': 'blockdev-snapshot-sync',
+                'data': { 'node-name': 'drive0',
+                          'snapshot-file': '/fakesnapshot',
+                          'snapshot-node-name': 'snap2',
+                          'mode': 'absolute-paths',
+                          'format': 'qcow2' }
+            },
+        ])
+
+        # Crashes on failure, we expect this error.
+        self.assert_qmp(result, 'error/class', 'GenericError')
+
+
+# Test for RHBZ#1782111
+class TestBlockdevBackupAbort(iotests.QMPTestCase):
+    drive0_img =3D os.path.join(iotests.test_dir, 'drive0.img')
+    drive1_img =3D os.path.join(iotests.test_dir, 'drive1.img')
+    snap0_img =3D os.path.join(iotests.test_dir, 'snap0.img')
+    snap1_img =3D os.path.join(iotests.test_dir, 'snap1.img')
+    images =3D { 'drive0': drive0_img,
+               'drive1': drive1_img,
+               'snap0': snap0_img,
+               'snap1': snap1_img }
+
+    def setUp(self):
+        for name in self.images:
+            qemu_img('create', '-f', iotests.imgfmt,
+                     self.images[name], str(image_len))
+
+        self.vm =3D iotests.VM()
+        self.vm.add_object('iothread,id=3Diothread0')
+        self.vm.add_device('virtio-scsi,iothread=3Diothread0')
+
+        for name in self.images:
+            self.vm.add_blockdev('driver=3Dfile,filename=3D%s,node-name=3D=
file_%s'
+                                 % (self.images[name], name))
+            self.vm.add_blockdev('driver=3Dqcow2,file=3Dfile_%s,node-name=
=3D%s'
+                                 % (name, name))
+
+        self.vm.add_device('scsi-hd,drive=3Ddrive0')
+        self.vm.add_device('scsi-hd,drive=3Ddrive1')
+        self.vm.launch()
+
+    def tearDown(self):
+        self.vm.shutdown()
+        for name in self.images:
+            os.remove(self.images[name])
+
+    def test_blockdev_backup_abort(self):
+        # Use a two actions transaction with a bogus values on the second
+        # one to trigger an abort of the transaction.
+        result =3D self.vm.qmp('transaction', actions=3D[
+            {
+                'type': 'blockdev-backup',
+                'data': { 'device': 'drive0',
+                          'target': 'snap0',
+                          'sync': 'full',
+                          'job-id': 'j1' }
+            },
+            {
+                'type': 'blockdev-backup',
+                'data': { 'device': 'drive1',
+                          'target': 'snap1',
+                          'sync': 'full' }
+            },
+        ])
+
+        # Hangs on failure, we expect this error.
+        self.assert_qmp(result, 'error/class', 'GenericError')
+
+if __name__ =3D=3D '__main__':
+    iotests.main(supported_fmts=3D['qcow2'],
+                 supported_protocols=3D['file'])
diff --git a/tests/qemu-iotests/281.out b/tests/qemu-iotests/281.out
new file mode 100644
index 0000000000..89968f35d7
--- /dev/null
+++ b/tests/qemu-iotests/281.out
@@ -0,0 +1,5 @@
+....
+----------------------------------------------------------------------
+Ran 4 tests
+
+OK
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index cb2b789e44..e041cc1ee3 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -288,3 +288,4 @@
 277 rw quick
 279 rw backing quick
 280 rw migration quick
+281 rw quick
--=20
2.20.1


