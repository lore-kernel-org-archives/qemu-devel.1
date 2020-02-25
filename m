Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C1DC35DEA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 01:00:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1545E20838
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 01:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CmEhJwVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1545E20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6OaJ-00078K-8e
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 20:00:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55847)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1j6OX5-0002bz-7C
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 19:57:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1j6OWu-00087p-4f
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 19:57:07 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47231
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1j6OWt-000872-Qt
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 19:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582592215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MF+W29R8kxyobCmE0u6fh0uYUjm26az6vcBOyE7oM8o=;
 b=CmEhJwVeL4QoGEzhmwREpbLNTOglCAHTfcTcwbenIdjJVdrtwNRq0HJHtb+Y+s5MppxJYa
 YLQxmUfLrl0bXUg6RPeb4rg5H4RoZP76qTHI//XEr5lNGrxBRvDdMsn3lMRJ40YT25Q2hM
 Ey+iFi9PA7uPcN9yVPsna7iULHxZ96E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-Yt-j7oZWNKqa-96bMCYmQg-1; Mon, 24 Feb 2020 19:56:51 -0500
X-MC-Unique: Yt-j7oZWNKqa-96bMCYmQg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F127A13E2;
 Tue, 25 Feb 2020 00:56:49 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-182.bos.redhat.com [10.18.17.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D100D1CB;
 Tue, 25 Feb 2020 00:56:48 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/6] iotests: add 287 for block-dirty-bitmap-populate
Date: Mon, 24 Feb 2020 19:56:41 -0500
Message-Id: <20200225005641.5478-7-jsnow@redhat.com>
In-Reply-To: <20200225005641.5478-1-jsnow@redhat.com>
References: <20200225005641.5478-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 pkrempa@redhat.com, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Give block-dirty-bitmap-populate a workout.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/287     |  233 ++
 tests/qemu-iotests/287.out | 4544 ++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |    1 +
 3 files changed, 4778 insertions(+)
 create mode 100755 tests/qemu-iotests/287
 create mode 100644 tests/qemu-iotests/287.out

diff --git a/tests/qemu-iotests/287 b/tests/qemu-iotests/287
new file mode 100755
index 0000000000..0ab58dc011
--- /dev/null
+++ b/tests/qemu-iotests/287
@@ -0,0 +1,233 @@
+#!/usr/bin/env python3
+#
+# Test block-dirty-bitmap-populate
+#
+# Copyright (c) 2020 John Snow for Red Hat, Inc.
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
+from collections import namedtuple
+import itertools
+import math
+import os
+
+import iotests
+from iotests import log, qemu_img
+from bitmaps import EmulatedBitmap, GROUPS
+
+SIZE =3D 64 * 1024 * 1024
+GRANULARITY =3D 64 * 1024
+
+
+class Drive:
+    def __init__(self, path, vm):
+        self.path =3D path
+        self.vm =3D vm
+        self.fmt =3D None
+        self.size =3D None
+        self.node =3D None
+
+    def img_create(self, fmt, size):
+        self.fmt =3D fmt
+        self.size =3D size
+        iotests.qemu_img_create('-f', self.fmt, self.path, str(self.size))
+
+
+def block_dirty_bitmap_populate(vm, node, bitmap, job_id, pattern, **kwarg=
s):
+    # Strip any arguments explicitly nulled by the caller:
+    kwargs =3D {key: val for key, val in kwargs.items() if val is not None=
}
+    result =3D vm.qmp_log('block-dirty-bitmap-populate',
+                        node=3Dnode,
+                        name=3Dbitmap,
+                        job_id=3Djob_id,
+                        pattern=3Dpattern,
+                        **kwargs)
+    return result
+
+
+def populate(drive, bitmap, job_id, pattern=3D'allocation-top', **kwargs):
+    kwargs.setdefault('pattern', pattern)
+    kwargs.setdefault('auto-finalize', False)
+    kwargs.setdefault('auto-dismiss', False)
+    ret =3D block_dirty_bitmap_populate(drive.vm, drive.node,
+                                      bitmap, job_id, **kwargs)
+    return {
+        'id': job_id,
+        'auto-finalize': kwargs['auto-finalize'],
+        'auto-dismiss': kwargs['auto-dismiss'],
+        'return': ret,
+    }
+
+
+def perform_writes(drive, n, filter_node_name=3DNone):
+    log("-- Write #{:d}:".format(n))
+    node_name =3D filter_node_name or drive.node
+    for pattern in GROUPS[n].patterns:
+        cmd =3D "write -P{:s} 0x{:07x} 0x{:x}".format(
+            pattern.byte,
+            pattern.offset,
+            pattern.size)
+        drive.vm.hmp_qemu_io(node_name, cmd, log=3DTrue)
+    log('')
+
+
+TestConfig =3D namedtuple('TestConfig', [
+    'base_pattern',
+    'disabled',
+    'pre_writes',
+    'mid_writes',
+    'cancel',
+    'post_writes',
+])
+
+
+def test_bitmap_populate(config):
+    """
+    Test bitmap populate.
+
+    :param base_pattern: Write a base pattern?
+    :param disabled:     Disable the target bitmap?
+    :param pre_writes:   Write a pattern after bitmap creation, but before=
 job?
+    :param mid_writes:   Write a pattern before job finalizes?
+    :param cancel:       Cancel the job instead of finalizing it?
+    :param post_writes:  Write a pattern after the job?
+    """
+    with iotests.FilePaths(['img']) as (img_path,), iotests.VM() as vm:
+        log("\n=3D=3D=3D Bitmap Populate {:s} =3D=3D=3D\n".format(str(conf=
ig)))
+
+        log('-- Prepare image & VM:')
+        drive0 =3D Drive(img_path, vm=3Dvm)
+        drive0.img_create(iotests.imgfmt, SIZE)
+        vm.add_device("{},id=3Dscsi0".format(iotests.get_virtio_scsi_devic=
e()))
+        vm.launch()
+
+        file_config =3D {
+            'driver': 'file',
+            'filename': drive0.path
+        }
+
+        drive0.node =3D 'drive0'
+        vm.qmp_log('blockdev-add',
+                   filters=3D[iotests.filter_qmp_testfiles],
+                   node_name=3Ddrive0.node,
+                   driver=3Ddrive0.fmt,
+                   file=3Dfile_config)
+        log('')
+
+
+        # Step 0: Prepare & Base Allocation Pattern
+
+        if config.base_pattern:
+            perform_writes(drive0, 0)
+
+
+        # Step 1: Add test bitmap
+
+        log('-- Add Bitmap:')
+        vm.qmp_log('block-dirty-bitmap-add',
+                   node=3Ddrive0.node,
+                   name=3D"target",
+                   granularity=3DGRANULARITY,
+                   disabled=3Dconfig.disabled)
+        ebitmap =3D EmulatedBitmap()
+        log('')
+
+        # Step 2: Pre-Writes
+
+        if config.pre_writes:
+            perform_writes(drive0, 1)
+            if not config.disabled:
+                ebitmap.dirty_group(1)
+            bitmap =3D vm.get_bitmap(drive0.node, 'target')
+            ebitmap.compare(bitmap)
+
+
+        # Step 3: Launch job & Mid-Writes
+
+        log('-- Test block-dirty-bitmap-populate (bitpop0):')
+        def pre_finalize():
+            # Writes issued prior to job finalization:
+            if config.mid_writes:
+                perform_writes(drive0, 2)
+                if not config.disabled:
+                    ebitmap.dirty_group(2)
+
+        job =3D populate(drive0, 'target', 'bitpop0')
+        assert job['return'] =3D=3D {'return': {}}
+        vm.run_job(job['id'],
+                   auto_dismiss=3Djob['auto-dismiss'],
+                   auto_finalize=3Djob['auto-finalize'],
+                   pre_finalize=3Dpre_finalize,
+                   cancel=3Dconfig.cancel)
+        log('')
+
+
+        # Step 4: Post-job verification
+
+        if not config.cancel:
+            # Any writes made prior to the job finishing should now be vis=
ible.
+            if config.base_pattern:
+                ebitmap.dirty_group(0)
+            if config.pre_writes:
+                ebitmap.dirty_group(1)
+            if config.mid_writes:
+                ebitmap.dirty_group(2)
+
+        bitmap =3D vm.get_bitmap(drive0.node, 'target')
+        ebitmap.compare(bitmap)
+
+
+        # Step 5: Post-Writes
+
+        if config.post_writes:
+            perform_writes(drive0, 3)
+            if not config.disabled:
+                ebitmap.dirty_group(3)
+
+
+        # Step 6: Final Verification
+
+        log('-- Verification:')
+        bitmaps =3D vm.query_bitmaps()
+        log({'bitmaps': bitmaps}, indent=3D2)
+        log('')
+        bitmap =3D vm.get_bitmap(drive0.node, 'target', bitmaps=3Dbitmaps)
+        ebitmap.compare(bitmap)
+
+
+        log('-- Cleanup:')
+        vm.qmp_log("block-dirty-bitmap-remove",
+                   node=3Ddrive0.node, name=3D"target")
+
+        bitmaps =3D vm.query_bitmaps()
+        if bitmaps:
+            log("ERROR: bitmaps unaccounted for:")
+            log(bitmaps)
+        else:
+            log('OK: All bitmaps removed')
+        vm.shutdown()
+        log('')
+
+
+def main():
+    for args in itertools.product((True, False), repeat=3D6):
+        cfg =3D TestConfig(*args)
+        test_bitmap_populate(cfg)
+
+
+if __name__ =3D=3D '__main__':
+    iotests.script_main(main, supported_fmts=3D['qcow2'],
+                        supported_protocols=3D['file'])
diff --git a/tests/qemu-iotests/287.out b/tests/qemu-iotests/287.out
new file mode 100644
index 0000000000..7c0afc7192
--- /dev/null
+++ b/tests/qemu-iotests/287.out
@@ -0,0 +1,4544 @@
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DTrue, disabled=3DTrue,=
 pre_writes=3DTrue, mid_writes=3DTrue, cancel=3DTrue, post_writes=3DTrue) =
=3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "gra=
nularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
+{"return": ""}
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DTrue, disabled=3DTrue,=
 pre_writes=3DTrue, mid_writes=3DTrue, cancel=3DTrue, post_writes=3DFalse) =
=3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "gra=
nularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DTrue, disabled=3DTrue,=
 pre_writes=3DTrue, mid_writes=3DTrue, cancel=3DFalse, post_writes=3DTrue) =
=3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "gra=
nularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 10 dirty sectors; have 10. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
+{"return": ""}
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 655360,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 10 dirty sectors; have 10. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DTrue, disabled=3DTrue,=
 pre_writes=3DTrue, mid_writes=3DTrue, cancel=3DFalse, post_writes=3DFalse)=
 =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "gra=
nularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 10 dirty sectors; have 10. OK!
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 655360,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 10 dirty sectors; have 10. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DTrue, disabled=3DTrue,=
 pre_writes=3DTrue, mid_writes=3DFalse, cancel=3DTrue, post_writes=3DTrue) =
=3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "gra=
nularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
+{"return": ""}
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DTrue, disabled=3DTrue,=
 pre_writes=3DTrue, mid_writes=3DFalse, cancel=3DTrue, post_writes=3DFalse)=
 =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "gra=
nularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DTrue, disabled=3DTrue,=
 pre_writes=3DTrue, mid_writes=3DFalse, cancel=3DFalse, post_writes=3DTrue)=
 =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "gra=
nularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 7 dirty sectors; have 7. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
+{"return": ""}
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 458752,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 7 dirty sectors; have 7. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DTrue, disabled=3DTrue,=
 pre_writes=3DTrue, mid_writes=3DFalse, cancel=3DFalse, post_writes=3DFalse=
) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "gra=
nularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 7 dirty sectors; have 7. OK!
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 458752,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 7 dirty sectors; have 7. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DTrue, disabled=3DTrue,=
 pre_writes=3DFalse, mid_writes=3DTrue, cancel=3DTrue, post_writes=3DTrue) =
=3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "gra=
nularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
+{"return": ""}
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DTrue, disabled=3DTrue,=
 pre_writes=3DFalse, mid_writes=3DTrue, cancel=3DTrue, post_writes=3DFalse)=
 =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "gra=
nularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DTrue, disabled=3DTrue,=
 pre_writes=3DFalse, mid_writes=3DTrue, cancel=3DFalse, post_writes=3DTrue)=
 =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "gra=
nularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 10 dirty sectors; have 10. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
+{"return": ""}
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 655360,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 10 dirty sectors; have 10. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DTrue, disabled=3DTrue,=
 pre_writes=3DFalse, mid_writes=3DTrue, cancel=3DFalse, post_writes=3DFalse=
) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "gra=
nularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 10 dirty sectors; have 10. OK!
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 655360,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 10 dirty sectors; have 10. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DTrue, disabled=3DTrue,=
 pre_writes=3DFalse, mid_writes=3DFalse, cancel=3DTrue, post_writes=3DTrue)=
 =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "gra=
nularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
+{"return": ""}
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DTrue, disabled=3DTrue,=
 pre_writes=3DFalse, mid_writes=3DFalse, cancel=3DTrue, post_writes=3DFalse=
) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "gra=
nularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DTrue, disabled=3DTrue,=
 pre_writes=3DFalse, mid_writes=3DFalse, cancel=3DFalse, post_writes=3DTrue=
) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "gra=
nularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 4 dirty sectors; have 4. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
+{"return": ""}
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 262144,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 4 dirty sectors; have 4. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DTrue, disabled=3DTrue,=
 pre_writes=3DFalse, mid_writes=3DFalse, cancel=3DFalse, post_writes=3DFals=
e) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "gra=
nularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 4 dirty sectors; have 4. OK!
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 262144,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 4 dirty sectors; have 4. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DTrue, disabled=3DFalse=
, pre_writes=3DTrue, mid_writes=3DTrue, cancel=3DTrue, post_writes=3DTrue) =
=3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+=3D Checking Bitmap target =3D
+expecting 6 dirty sectors; have 6. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 10 dirty sectors; have 10. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
+{"return": ""}
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 983040,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 15 dirty sectors; have 15. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DTrue, disabled=3DFalse=
, pre_writes=3DTrue, mid_writes=3DTrue, cancel=3DTrue, post_writes=3DFalse)=
 =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+=3D Checking Bitmap target =3D
+expecting 6 dirty sectors; have 6. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 10 dirty sectors; have 10. OK!
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 655360,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 10 dirty sectors; have 10. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DTrue, disabled=3DFalse=
, pre_writes=3DTrue, mid_writes=3DTrue, cancel=3DFalse, post_writes=3DTrue)=
 =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+=3D Checking Bitmap target =3D
+expecting 6 dirty sectors; have 6. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 10 dirty sectors; have 10. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
+{"return": ""}
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 983040,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 15 dirty sectors; have 15. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DTrue, disabled=3DFalse=
, pre_writes=3DTrue, mid_writes=3DTrue, cancel=3DFalse, post_writes=3DFalse=
) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+=3D Checking Bitmap target =3D
+expecting 6 dirty sectors; have 6. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 10 dirty sectors; have 10. OK!
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 655360,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 10 dirty sectors; have 10. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DTrue, disabled=3DFalse=
, pre_writes=3DTrue, mid_writes=3DFalse, cancel=3DTrue, post_writes=3DTrue)=
 =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+=3D Checking Bitmap target =3D
+expecting 6 dirty sectors; have 6. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 6 dirty sectors; have 6. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
+{"return": ""}
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 917504,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 14 dirty sectors; have 14. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DTrue, disabled=3DFalse=
, pre_writes=3DTrue, mid_writes=3DFalse, cancel=3DTrue, post_writes=3DFalse=
) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+=3D Checking Bitmap target =3D
+expecting 6 dirty sectors; have 6. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 6 dirty sectors; have 6. OK!
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 6 dirty sectors; have 6. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DTrue, disabled=3DFalse=
, pre_writes=3DTrue, mid_writes=3DFalse, cancel=3DFalse, post_writes=3DTrue=
) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+=3D Checking Bitmap target =3D
+expecting 6 dirty sectors; have 6. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 7 dirty sectors; have 7. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
+{"return": ""}
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 983040,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 15 dirty sectors; have 15. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DTrue, disabled=3DFalse=
, pre_writes=3DTrue, mid_writes=3DFalse, cancel=3DFalse, post_writes=3DFals=
e) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+=3D Checking Bitmap target =3D
+expecting 6 dirty sectors; have 6. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 7 dirty sectors; have 7. OK!
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 458752,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 7 dirty sectors; have 7. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DTrue, disabled=3DFalse=
, pre_writes=3DFalse, mid_writes=3DTrue, cancel=3DTrue, post_writes=3DTrue)=
 =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 7 dirty sectors; have 7. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
+{"return": ""}
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 786432,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 12 dirty sectors; have 12. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DTrue, disabled=3DFalse=
, pre_writes=3DFalse, mid_writes=3DTrue, cancel=3DTrue, post_writes=3DFalse=
) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 7 dirty sectors; have 7. OK!
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 458752,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 7 dirty sectors; have 7. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DTrue, disabled=3DFalse=
, pre_writes=3DFalse, mid_writes=3DTrue, cancel=3DFalse, post_writes=3DTrue=
) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 10 dirty sectors; have 10. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
+{"return": ""}
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 983040,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 15 dirty sectors; have 15. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DTrue, disabled=3DFalse=
, pre_writes=3DFalse, mid_writes=3DTrue, cancel=3DFalse, post_writes=3DFals=
e) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 10 dirty sectors; have 10. OK!
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 655360,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 10 dirty sectors; have 10. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DTrue, disabled=3DFalse=
, pre_writes=3DFalse, mid_writes=3DFalse, cancel=3DTrue, post_writes=3DTrue=
) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
+{"return": ""}
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 524288,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 8 dirty sectors; have 8. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DTrue, disabled=3DFalse=
, pre_writes=3DFalse, mid_writes=3DFalse, cancel=3DTrue, post_writes=3DFals=
e) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DTrue, disabled=3DFalse=
, pre_writes=3DFalse, mid_writes=3DFalse, cancel=3DFalse, post_writes=3DTru=
e) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 4 dirty sectors; have 4. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
+{"return": ""}
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 786432,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 12 dirty sectors; have 12. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DTrue, disabled=3DFalse=
, pre_writes=3DFalse, mid_writes=3DFalse, cancel=3DFalse, post_writes=3DFal=
se) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 4 dirty sectors; have 4. OK!
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 262144,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 4 dirty sectors; have 4. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DFalse, disabled=3DTrue=
, pre_writes=3DTrue, mid_writes=3DTrue, cancel=3DTrue, post_writes=3DTrue) =
=3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "gra=
nularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
+{"return": ""}
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DFalse, disabled=3DTrue=
, pre_writes=3DTrue, mid_writes=3DTrue, cancel=3DTrue, post_writes=3DFalse)=
 =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "gra=
nularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DFalse, disabled=3DTrue=
, pre_writes=3DTrue, mid_writes=3DTrue, cancel=3DFalse, post_writes=3DTrue)=
 =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "gra=
nularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 10 dirty sectors; have 10. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
+{"return": ""}
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 655360,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 10 dirty sectors; have 10. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DFalse, disabled=3DTrue=
, pre_writes=3DTrue, mid_writes=3DTrue, cancel=3DFalse, post_writes=3DFalse=
) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "gra=
nularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 10 dirty sectors; have 10. OK!
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 655360,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 10 dirty sectors; have 10. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DFalse, disabled=3DTrue=
, pre_writes=3DTrue, mid_writes=3DFalse, cancel=3DTrue, post_writes=3DTrue)=
 =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "gra=
nularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
+{"return": ""}
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DFalse, disabled=3DTrue=
, pre_writes=3DTrue, mid_writes=3DFalse, cancel=3DTrue, post_writes=3DFalse=
) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "gra=
nularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DFalse, disabled=3DTrue=
, pre_writes=3DTrue, mid_writes=3DFalse, cancel=3DFalse, post_writes=3DTrue=
) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "gra=
nularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 6 dirty sectors; have 6. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
+{"return": ""}
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 6 dirty sectors; have 6. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DFalse, disabled=3DTrue=
, pre_writes=3DTrue, mid_writes=3DFalse, cancel=3DFalse, post_writes=3DFals=
e) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "gra=
nularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 6 dirty sectors; have 6. OK!
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 6 dirty sectors; have 6. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DFalse, disabled=3DTrue=
, pre_writes=3DFalse, mid_writes=3DTrue, cancel=3DTrue, post_writes=3DTrue)=
 =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "gra=
nularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
+{"return": ""}
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DFalse, disabled=3DTrue=
, pre_writes=3DFalse, mid_writes=3DTrue, cancel=3DTrue, post_writes=3DFalse=
) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "gra=
nularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DFalse, disabled=3DTrue=
, pre_writes=3DFalse, mid_writes=3DTrue, cancel=3DFalse, post_writes=3DTrue=
) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "gra=
nularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 7 dirty sectors; have 7. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
+{"return": ""}
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 458752,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 7 dirty sectors; have 7. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DFalse, disabled=3DTrue=
, pre_writes=3DFalse, mid_writes=3DTrue, cancel=3DFalse, post_writes=3DFals=
e) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "gra=
nularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 7 dirty sectors; have 7. OK!
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 458752,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 7 dirty sectors; have 7. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DFalse, disabled=3DTrue=
, pre_writes=3DFalse, mid_writes=3DFalse, cancel=3DTrue, post_writes=3DTrue=
) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "gra=
nularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
+{"return": ""}
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DFalse, disabled=3DTrue=
, pre_writes=3DFalse, mid_writes=3DFalse, cancel=3DTrue, post_writes=3DFals=
e) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "gra=
nularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DFalse, disabled=3DTrue=
, pre_writes=3DFalse, mid_writes=3DFalse, cancel=3DFalse, post_writes=3DTru=
e) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "gra=
nularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
+{"return": ""}
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DFalse, disabled=3DTrue=
, pre_writes=3DFalse, mid_writes=3DFalse, cancel=3DFalse, post_writes=3DFal=
se) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "gra=
nularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DFalse, disabled=3DFals=
e, pre_writes=3DTrue, mid_writes=3DTrue, cancel=3DTrue, post_writes=3DTrue)=
 =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+=3D Checking Bitmap target =3D
+expecting 6 dirty sectors; have 6. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 10 dirty sectors; have 10. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
+{"return": ""}
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 983040,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 15 dirty sectors; have 15. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DFalse, disabled=3DFals=
e, pre_writes=3DTrue, mid_writes=3DTrue, cancel=3DTrue, post_writes=3DFalse=
) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+=3D Checking Bitmap target =3D
+expecting 6 dirty sectors; have 6. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 10 dirty sectors; have 10. OK!
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 655360,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 10 dirty sectors; have 10. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DFalse, disabled=3DFals=
e, pre_writes=3DTrue, mid_writes=3DTrue, cancel=3DFalse, post_writes=3DTrue=
) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+=3D Checking Bitmap target =3D
+expecting 6 dirty sectors; have 6. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 10 dirty sectors; have 10. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
+{"return": ""}
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 983040,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 15 dirty sectors; have 15. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DFalse, disabled=3DFals=
e, pre_writes=3DTrue, mid_writes=3DTrue, cancel=3DFalse, post_writes=3DFals=
e) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+=3D Checking Bitmap target =3D
+expecting 6 dirty sectors; have 6. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 10 dirty sectors; have 10. OK!
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 655360,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 10 dirty sectors; have 10. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DFalse, disabled=3DFals=
e, pre_writes=3DTrue, mid_writes=3DFalse, cancel=3DTrue, post_writes=3DTrue=
) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+=3D Checking Bitmap target =3D
+expecting 6 dirty sectors; have 6. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 6 dirty sectors; have 6. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
+{"return": ""}
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 917504,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 14 dirty sectors; have 14. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DFalse, disabled=3DFals=
e, pre_writes=3DTrue, mid_writes=3DFalse, cancel=3DTrue, post_writes=3DFals=
e) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+=3D Checking Bitmap target =3D
+expecting 6 dirty sectors; have 6. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 6 dirty sectors; have 6. OK!
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 6 dirty sectors; have 6. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DFalse, disabled=3DFals=
e, pre_writes=3DTrue, mid_writes=3DFalse, cancel=3DFalse, post_writes=3DTru=
e) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+=3D Checking Bitmap target =3D
+expecting 6 dirty sectors; have 6. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 6 dirty sectors; have 6. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
+{"return": ""}
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 917504,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 14 dirty sectors; have 14. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DFalse, disabled=3DFals=
e, pre_writes=3DTrue, mid_writes=3DFalse, cancel=3DFalse, post_writes=3DFal=
se) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+=3D Checking Bitmap target =3D
+expecting 6 dirty sectors; have 6. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 6 dirty sectors; have 6. OK!
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 6 dirty sectors; have 6. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DFalse, disabled=3DFals=
e, pre_writes=3DFalse, mid_writes=3DTrue, cancel=3DTrue, post_writes=3DTrue=
) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 7 dirty sectors; have 7. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
+{"return": ""}
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 786432,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 12 dirty sectors; have 12. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DFalse, disabled=3DFals=
e, pre_writes=3DFalse, mid_writes=3DTrue, cancel=3DTrue, post_writes=3DFals=
e) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 7 dirty sectors; have 7. OK!
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 458752,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 7 dirty sectors; have 7. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DFalse, disabled=3DFals=
e, pre_writes=3DFalse, mid_writes=3DTrue, cancel=3DFalse, post_writes=3DTru=
e) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 7 dirty sectors; have 7. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
+{"return": ""}
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 786432,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 12 dirty sectors; have 12. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DFalse, disabled=3DFals=
e, pre_writes=3DFalse, mid_writes=3DTrue, cancel=3DFalse, post_writes=3DFal=
se) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 7 dirty sectors; have 7. OK!
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 458752,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 7 dirty sectors; have 7. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DFalse, disabled=3DFals=
e, pre_writes=3DFalse, mid_writes=3DFalse, cancel=3DTrue, post_writes=3DTru=
e) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
+{"return": ""}
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 524288,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 8 dirty sectors; have 8. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DFalse, disabled=3DFals=
e, pre_writes=3DFalse, mid_writes=3DFalse, cancel=3DTrue, post_writes=3DFal=
se) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DFalse, disabled=3DFals=
e, pre_writes=3DFalse, mid_writes=3DFalse, cancel=3DFalse, post_writes=3DTr=
ue) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-i=
o drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
+{"return": ""}
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 524288,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 8 dirty sectors; have 8. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=3D=3D=3D Bitmap Populate TestConfig(base_pattern=3DFalse, disabled=3DFals=
e, pre_writes=3DFalse, mid_writes=3DFalse, cancel=3DFalse, post_writes=3DFa=
lse) =3D=3D=3D
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"dri=
ver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": f=
alse, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node"=
: "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB=
_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed=
": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Verification:
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "target",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap target =3D
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "=
node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 0317667695..5e80d7deab 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -293,3 +293,4 @@
 283 auto quick
 284 rw
 286 rw quick
+287 rw
--=20
2.21.1


