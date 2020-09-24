Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF30C2D0E2
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:31:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54DE623741
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/I9nGnS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54DE623741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLU9I-0008T5-BL
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 12:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLTB4-000283-FC
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:28:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46029)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLTAj-0005fa-MR
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600961316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ZDjzDFwn5i4Yyqhodki0W9lRL1qvHYEBQy3fGtzYLM=;
 b=L/I9nGnSVJHF2f1+I2qNuRReJJ143nq72iy7/WKb/Sdy/Df8C02PEj6Zr92UFQSqfRDNIl
 HzsWzoixXeA1fy5zM9y+vRRitBpOOSxwaYJLslYAvd/onzPLyaH2yLFxA8vGvWJTjQ5QDs
 RPn/eKdZx4ICSyYqXKLkB4++VRhRFy0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-cBmGQ-dxN2uMI10G-U5R6g-1; Thu, 24 Sep 2020 11:28:26 -0400
X-MC-Unique: cBmGQ-dxN2uMI10G-U5R6g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D05A2884E5F;
 Thu, 24 Sep 2020 15:28:22 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-72.ams2.redhat.com [10.36.114.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 84AA760C04;
 Thu, 24 Sep 2020 15:28:21 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 31/31] iotests: Test block-export-* QMP interface
Date: Thu, 24 Sep 2020 17:27:17 +0200
Message-Id: <20200924152717.287415-32-kwolf@redhat.com>
In-Reply-To: <20200924152717.287415-1-kwolf@redhat.com>
References: <20200924152717.287415-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/307     | 132 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/307.out | 124 ++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 257 insertions(+)
 create mode 100755 tests/qemu-iotests/307
 create mode 100644 tests/qemu-iotests/307.out

diff --git a/tests/qemu-iotests/307 b/tests/qemu-iotests/307
new file mode 100755
index 0000000000..de7c25fcfc
--- /dev/null
+++ b/tests/qemu-iotests/307
@@ -0,0 +1,132 @@
+#!/usr/bin/env python3
+#
+# Copyright (C) 2020 Red Hat, Inc.
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
+# Test the block export QAPI interfaces
+
+import iotests
+import os
+
+# Need a writable image format (but not vpc, which rounds the image size, nor
+# luks which requires special command lines)
+iotests.script_initialize(
+    supported_fmts=['generic'],
+    unsupported_fmts=['luks', 'vpc'],
+    supported_platforms=['linux'],
+)
+
+with iotests.FilePath('image') as img, \
+     iotests.FilePath('socket', base_dir=iotests.sock_dir) as socket, \
+     iotests.VM() as vm:
+
+    iotests.qemu_img('create', '-f', iotests.imgfmt, img, '64M')
+    iotests.qemu_io_log('-f', iotests.imgfmt, '-c', 'write -P 0x11 0 4k', img)
+
+    iotests.log('=== Launch VM ===')
+
+    virtio_scsi_device = iotests.get_virtio_scsi_device()
+
+    vm.add_object('iothread,id=iothread0')
+    vm.add_blockdev(f'file,filename={img},node-name=file')
+    vm.add_blockdev(f'{iotests.imgfmt},file=file,node-name=fmt')
+    vm.add_blockdev('raw,file=file,node-name=ro,read-only=on')
+    vm.add_device(f'id=scsi0,driver={virtio_scsi_device},iothread=iothread0')
+    vm.launch()
+
+    vm.qmp_log('nbd-server-start',
+               addr={'type': 'unix', 'data': {'path': socket}},
+               filters=(iotests.filter_qmp_testfiles, ))
+    vm.qmp_log('query-block-exports')
+
+    iotests.log('\n=== Create a read-only NBD export ===')
+
+    vm.qmp_log('block-export-add', id='export0', type='nbd', node_name='fmt')
+    vm.qmp_log('query-block-exports')
+
+    iotests.qemu_nbd_list_log('-k', socket)
+
+    iotests.log('\n=== Try a few invalid things ===')
+
+    vm.qmp_log('block-export-add', id='#invalid', type='nbd', node_name='fmt')
+    vm.qmp_log('block-export-add', id='export0', type='nbd', node_name='fmt')
+    vm.qmp_log('block-export-add', id='export1', type='nbd', node_name='ro',
+               writable=True)
+    vm.qmp_log('block-export-del', id='export1')
+    vm.qmp_log('query-block-exports')
+
+    iotests.log('\n=== Move export to an iothread ===')
+
+    vm.qmp_log('device_add', id='sda', driver='scsi-hd', drive='fmt')
+    vm.qmp_log('query-block-exports')
+    iotests.qemu_nbd_list_log('-k', socket)
+
+    iotests.log('\n=== Add a writable export ===')
+
+    # This fails because share-rw=off
+    vm.qmp_log('block-export-add', id='export1', type='nbd', node_name='fmt',
+               name='export1', writable=True, writethrough=True,
+               description='This is the writable second export')
+
+    vm.qmp_log('device_del', id='sda')
+    event = vm.event_wait(name="DEVICE_DELETED",
+                          match={'data': {'device': 'sda'}})
+    iotests.log(event, filters=[iotests.filter_qmp_event])
+    vm.qmp_log('device_add', id='sda', driver='scsi-hd', drive='fmt',
+               share_rw=True)
+
+    # Now it should work
+    vm.qmp_log('block-export-add', id='export1', type='nbd', node_name='fmt',
+               name='export1', writable=True, writethrough=True,
+               description='This is the writable second export')
+
+    vm.qmp_log('query-block-exports')
+    iotests.qemu_nbd_list_log('-k', socket)
+
+    iotests.log('\n=== Connect qemu-io to export1, try removing exports ===')
+
+    nbd_url = f'nbd+unix:///export1?socket={socket}'
+    qemu_io = iotests.QemuIoInteractive('-f', 'raw', nbd_url)
+
+    iotests.log(qemu_io.cmd('read -P 0x11 0 4k'),
+                filters=[iotests.filter_qemu_io])
+    iotests.log(qemu_io.cmd('write -P 0x22 4k 4k'),
+                filters=[iotests.filter_qemu_io])
+
+    vm.qmp_log('block-export-del', id='export1')
+    vm.qmp_log('block-export-del', id='export0')
+    iotests.log(vm.get_qmp_events_filtered())
+    qemu_io.close()
+
+    vm.qmp_log('query-block-exports')
+    iotests.qemu_nbd_list_log('-k', socket)
+
+    iotests.log('\n=== Connect qemu-io again, try force removing ===')
+
+    qemu_io = iotests.QemuIoInteractive('-f', 'raw', nbd_url)
+    vm.qmp_log('block-export-del', id='export1')
+    vm.qmp_log('block-export-del', id='export1', mode='hard')
+
+    # This should fail now
+    iotests.log(qemu_io.cmd('read -P 0x11 0 4k'))
+    qemu_io.close()
+
+    vm.qmp_log('query-block-exports')
+    iotests.qemu_nbd_list_log('-k', socket)
+
+    iotests.log('\n=== Shut down QEMU ===')
+    vm.shutdown()
diff --git a/tests/qemu-iotests/307.out b/tests/qemu-iotests/307.out
new file mode 100644
index 0000000000..daa8ad2da0
--- /dev/null
+++ b/tests/qemu-iotests/307.out
@@ -0,0 +1,124 @@
+wrote 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== Launch VM ===
+{"execute": "nbd-server-start", "arguments": {"addr": {"data": {"path": "SOCK_DIR/PID-socket"}, "type": "unix"}}}
+{"return": {}}
+{"execute": "query-block-exports", "arguments": {}}
+{"return": []}
+
+=== Create a read-only NBD export ===
+{"execute": "block-export-add", "arguments": {"id": "export0", "node-name": "fmt", "type": "nbd"}}
+{"return": {}}
+{"execute": "query-block-exports", "arguments": {}}
+{"return": [{"id": "export0", "node-name": "fmt", "shutting-down": false, "type": "nbd"}]}
+exports available: 1
+ export: 'fmt'
+  size:  67108864
+  flags: 0x58f ( readonly flush fua df multi cache )
+  min block: XXX
+  opt block: XXX
+  max block: XXX
+  available meta contexts: 1
+   base:allocation
+
+
+=== Try a few invalid things ===
+{"execute": "block-export-add", "arguments": {"id": "#invalid", "node-name": "fmt", "type": "nbd"}}
+{"error": {"class": "GenericError", "desc": "Invalid block export id"}}
+{"execute": "block-export-add", "arguments": {"id": "export0", "node-name": "fmt", "type": "nbd"}}
+{"error": {"class": "GenericError", "desc": "Block export id 'export0' is already in use"}}
+{"execute": "block-export-add", "arguments": {"id": "export1", "node-name": "ro", "type": "nbd", "writable": true}}
+{"error": {"class": "GenericError", "desc": "Cannot export read-only node as writable"}}
+{"execute": "block-export-del", "arguments": {"id": "export1"}}
+{"error": {"class": "GenericError", "desc": "Export 'export1' is not found"}}
+{"execute": "query-block-exports", "arguments": {}}
+{"return": [{"id": "export0", "node-name": "fmt", "shutting-down": false, "type": "nbd"}]}
+
+=== Move export to an iothread ===
+{"execute": "device_add", "arguments": {"drive": "fmt", "driver": "scsi-hd", "id": "sda"}}
+{"return": {}}
+{"execute": "query-block-exports", "arguments": {}}
+{"return": [{"id": "export0", "node-name": "fmt", "shutting-down": false, "type": "nbd"}]}
+exports available: 1
+ export: 'fmt'
+  size:  67108864
+  flags: 0x58f ( readonly flush fua df multi cache )
+  min block: XXX
+  opt block: XXX
+  max block: XXX
+  available meta contexts: 1
+   base:allocation
+
+
+=== Add a writable export ===
+{"execute": "block-export-add", "arguments": {"description": "This is the writable second export", "id": "export1", "name": "export1", "node-name": "fmt", "type": "nbd", "writable": true, "writethrough": true}}
+{"error": {"class": "GenericError", "desc": "Conflicts with use by sda as 'root', which does not allow 'write' on fmt"}}
+{"execute": "device_del", "arguments": {"id": "sda"}}
+{"return": {}}
+{"data": {"device": "sda", "path": "/machine/peripheral/sda"}, "event": "DEVICE_DELETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "device_add", "arguments": {"drive": "fmt", "driver": "scsi-hd", "id": "sda", "share-rw": true}}
+{"return": {}}
+{"execute": "block-export-add", "arguments": {"description": "This is the writable second export", "id": "export1", "name": "export1", "node-name": "fmt", "type": "nbd", "writable": true, "writethrough": true}}
+{"return": {}}
+{"execute": "query-block-exports", "arguments": {}}
+{"return": [{"id": "export1", "node-name": "fmt", "shutting-down": false, "type": "nbd"}, {"id": "export0", "node-name": "fmt", "shutting-down": false, "type": "nbd"}]}
+exports available: 2
+ export: 'fmt'
+  size:  67108864
+  flags: 0x58f ( readonly flush fua df multi cache )
+  min block: XXX
+  opt block: XXX
+  max block: XXX
+  available meta contexts: 1
+   base:allocation
+ export: 'export1'
+  description: This is the writable second export
+  size:  67108864
+  flags: 0xced ( flush fua trim zeroes df cache fast-zero )
+  min block: XXX
+  opt block: XXX
+  max block: XXX
+  available meta contexts: 1
+   base:allocation
+
+
+=== Connect qemu-io to export1, try removing exports ===
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+wrote 4096/4096 bytes at offset 4096
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+{"execute": "block-export-del", "arguments": {"id": "export1"}}
+{"error": {"class": "GenericError", "desc": "export 'export1' still in use"}}
+{"execute": "block-export-del", "arguments": {"id": "export0"}}
+{"return": {}}
+[{"data": {"id": "export0"}, "event": "BLOCK_EXPORT_DELETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}]
+{"execute": "query-block-exports", "arguments": {}}
+{"return": [{"id": "export1", "node-name": "fmt", "shutting-down": false, "type": "nbd"}]}
+exports available: 1
+ export: 'export1'
+  description: This is the writable second export
+  size:  67108864
+  flags: 0xced ( flush fua trim zeroes df cache fast-zero )
+  min block: XXX
+  opt block: XXX
+  max block: XXX
+  available meta contexts: 1
+   base:allocation
+
+
+=== Connect qemu-io again, try force removing ===
+{"execute": "block-export-del", "arguments": {"id": "export1"}}
+{"error": {"class": "GenericError", "desc": "export 'export1' still in use"}}
+{"execute": "block-export-del", "arguments": {"id": "export1", "mode": "hard"}}
+{"return": {}}
+read failed: Input/output error
+
+{"execute": "query-block-exports", "arguments": {}}
+{"return": []}
+exports available: 0
+
+
+=== Shut down QEMU ===
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index ff59cfd2d4..9e4f7c0153 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -314,3 +314,4 @@
 303 rw quick
 304 rw quick
 305 rw quick
+307 rw quick export
-- 
2.25.4


