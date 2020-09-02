Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CE6C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 18:23:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D055C207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 18:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DY3n4jyH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D055C207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDXPT-0004gh-U9
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 14:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kDXLO-00075S-U7
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 14:18:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50890
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kDXLJ-0001ly-P4
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 14:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599070725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xOuIoHDieN3vrpusxjXF9hJFDSrkGI/4XKNvL619xqQ=;
 b=DY3n4jyHmkcXWSmMX+leYxxxSGEYzRfSL78M4qk4eosWfV0kDxBIMNyc8jLbdGkFBTAiVp
 jlDHWafdaBX7a6eOiK4lyN+rYIF/WTCG36ydjXT0fDN+G9a2021KVNukmtshY4M9Ryul3K
 gCY8ynVYGXR9Wm3dik0kAtFFDXLa/Zs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-WiCVvCJOMpeouxHmP1Uibg-1; Wed, 02 Sep 2020 14:18:40 -0400
X-MC-Unique: WiCVvCJOMpeouxHmP1Uibg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 516661019625;
 Wed,  2 Sep 2020 18:18:39 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-128.phx2.redhat.com [10.3.113.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 313B710013BD;
 Wed,  2 Sep 2020 18:18:38 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 5/5] iotests: add 298 for block-dirty-bitmap-populate
Date: Wed,  2 Sep 2020 13:18:31 -0500
Message-Id: <20200902181831.2570048-6-eblake@redhat.com>
In-Reply-To: <20200902181831.2570048-1-eblake@redhat.com>
References: <20200902181831.2570048-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:26:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, vsementsov@virtuozzo.com,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

Give block-dirty-bitmap-populate a workout.

Signed-off-by: John Snow <jsnow@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/298     |  232 ++
 tests/qemu-iotests/298.out | 4544 ++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |    1 +
 3 files changed, 4777 insertions(+)
 create mode 100755 tests/qemu-iotests/298
 create mode 100644 tests/qemu-iotests/298.out

diff --git a/tests/qemu-iotests/298 b/tests/qemu-iotests/298
new file mode 100755
index 000000000000..4bfcecd3bc88
--- /dev/null
+++ b/tests/qemu-iotests/298
@@ -0,0 +1,232 @@
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
+# owner=jsnow@redhat.com
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
+SIZE = 64 * 1024 * 1024
+GRANULARITY = 64 * 1024
+
+
+class Drive:
+    def __init__(self, path, vm):
+        self.path = path
+        self.vm = vm
+        self.fmt = None
+        self.size = None
+        self.node = None
+
+    def img_create(self, fmt, size):
+        self.fmt = fmt
+        self.size = size
+        iotests.qemu_img_create('-f', self.fmt, self.path, str(self.size))
+
+
+def block_dirty_bitmap_populate(vm, node, bitmap, job_id, pattern, **kwargs):
+    # Strip any arguments explicitly nulled by the caller:
+    kwargs = {key: val for key, val in kwargs.items() if val is not None}
+    result = vm.qmp_log('block-dirty-bitmap-populate',
+                        node=node,
+                        name=bitmap,
+                        job_id=job_id,
+                        pattern=pattern,
+                        **kwargs)
+    return result
+
+
+def populate(drive, bitmap, job_id, pattern='allocation-top', **kwargs):
+    kwargs.setdefault('pattern', pattern)
+    kwargs.setdefault('auto-finalize', False)
+    kwargs.setdefault('auto-dismiss', False)
+    ret = block_dirty_bitmap_populate(drive.vm, drive.node,
+                                      bitmap, job_id, **kwargs)
+    return {
+        'id': job_id,
+        'auto-finalize': kwargs['auto-finalize'],
+        'auto-dismiss': kwargs['auto-dismiss'],
+        'return': ret,
+    }
+
+
+def perform_writes(drive, n, filter_node_name=None):
+    log("-- Write #{:d}:".format(n))
+    node_name = filter_node_name or drive.node
+    for pattern in GROUPS[n].patterns:
+        cmd = "write -P{:s} 0x{:07x} 0x{:x}".format(
+            pattern.byte,
+            pattern.offset,
+            pattern.size)
+        drive.vm.hmp_qemu_io(node_name, cmd, use_log=True)
+    log('')
+
+
+TestConfig = namedtuple('TestConfig', [
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
+    :param pre_writes:   Write a pattern after bitmap creation, but before job?
+    :param mid_writes:   Write a pattern before job finalizes?
+    :param cancel:       Cancel the job instead of finalizing it?
+    :param post_writes:  Write a pattern after the job?
+    """
+    with iotests.FilePaths(['img']) as (img_path,), iotests.VM() as vm:
+        log("\n=== Bitmap Populate {:s} ===\n".format(str(config)))
+
+        log('-- Prepare image & VM:')
+        drive0 = Drive(img_path, vm=vm)
+        drive0.img_create(iotests.imgfmt, SIZE)
+        vm.add_device("{},id=scsi0".format(iotests.get_virtio_scsi_device()))
+        vm.launch()
+
+        file_config = {
+            'driver': 'file',
+            'filename': drive0.path
+        }
+
+        drive0.node = 'drive0'
+        vm.qmp_log('blockdev-add',
+                   filters=[iotests.filter_qmp_testfiles],
+                   node_name=drive0.node,
+                   driver=drive0.fmt,
+                   file=file_config)
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
+                   node=drive0.node,
+                   name="target",
+                   granularity=GRANULARITY,
+                   disabled=config.disabled)
+        ebitmap = EmulatedBitmap()
+        log('')
+
+        # Step 2: Pre-Writes
+
+        if config.pre_writes:
+            perform_writes(drive0, 1)
+            if not config.disabled:
+                ebitmap.dirty_group(1)
+            bitmap = vm.get_bitmap(drive0.node, 'target')
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
+        job = populate(drive0, 'target', 'bitpop0')
+        assert job['return'] == {'return': {}}
+        vm.run_job(job['id'], auto_dismiss=job['auto-dismiss'],
+                   auto_finalize=job['auto-finalize'],
+                   pre_finalize=pre_finalize,
+                   cancel=config.cancel)
+        log('')
+
+
+        # Step 4: Post-job verification
+
+        if not config.cancel:
+            # Any writes made prior to the job finishing should now be visible.
+            if config.base_pattern:
+                ebitmap.dirty_group(0)
+            if config.pre_writes:
+                ebitmap.dirty_group(1)
+            if config.mid_writes:
+                ebitmap.dirty_group(2)
+
+        bitmap = vm.get_bitmap(drive0.node, 'target')
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
+        bitmaps = vm.query_bitmaps()
+        log({'bitmaps': bitmaps}, indent=2)
+        log('')
+        bitmap = vm.get_bitmap(drive0.node, 'target', bitmaps=bitmaps)
+        ebitmap.compare(bitmap)
+
+
+        log('-- Cleanup:')
+        vm.qmp_log("block-dirty-bitmap-remove",
+                   node=drive0.node, name="target")
+
+        bitmaps = vm.query_bitmaps()
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
+    for args in itertools.product((True, False), repeat=6):
+        cfg = TestConfig(*args)
+        test_bitmap_populate(cfg)
+
+
+if __name__ == '__main__':
+    iotests.script_main(main, supported_fmts=['qcow2'],
+                        supported_protocols=['file'])
diff --git a/tests/qemu-iotests/298.out b/tests/qemu-iotests/298.out
new file mode 100644
index 000000000000..7c0afc71920c
--- /dev/null
+++ b/tests/qemu-iotests/298.out
@@ -0,0 +1,4544 @@
+
+=== Bitmap Populate TestConfig(base_pattern=True, disabled=True, pre_writes=True, mid_writes=True, cancel=True, post_writes=True) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
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
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=True, disabled=True, pre_writes=True, mid_writes=True, cancel=True, post_writes=False) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
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
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=True, disabled=True, pre_writes=True, mid_writes=True, cancel=False, post_writes=True) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
+expecting 10 dirty sectors; have 10. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
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
+= Checking Bitmap target =
+expecting 10 dirty sectors; have 10. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=True, disabled=True, pre_writes=True, mid_writes=True, cancel=False, post_writes=False) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
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
+= Checking Bitmap target =
+expecting 10 dirty sectors; have 10. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=True, disabled=True, pre_writes=True, mid_writes=False, cancel=True, post_writes=True) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
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
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=True, disabled=True, pre_writes=True, mid_writes=False, cancel=True, post_writes=False) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
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
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=True, disabled=True, pre_writes=True, mid_writes=False, cancel=False, post_writes=True) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
+expecting 7 dirty sectors; have 7. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
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
+= Checking Bitmap target =
+expecting 7 dirty sectors; have 7. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=True, disabled=True, pre_writes=True, mid_writes=False, cancel=False, post_writes=False) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
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
+= Checking Bitmap target =
+expecting 7 dirty sectors; have 7. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=True, disabled=True, pre_writes=False, mid_writes=True, cancel=True, post_writes=True) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
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
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=True, disabled=True, pre_writes=False, mid_writes=True, cancel=True, post_writes=False) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
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
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=True, disabled=True, pre_writes=False, mid_writes=True, cancel=False, post_writes=True) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
+expecting 10 dirty sectors; have 10. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
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
+= Checking Bitmap target =
+expecting 10 dirty sectors; have 10. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=True, disabled=True, pre_writes=False, mid_writes=True, cancel=False, post_writes=False) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
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
+= Checking Bitmap target =
+expecting 10 dirty sectors; have 10. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=True, disabled=True, pre_writes=False, mid_writes=False, cancel=True, post_writes=True) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
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
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=True, disabled=True, pre_writes=False, mid_writes=False, cancel=True, post_writes=False) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
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
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=True, disabled=True, pre_writes=False, mid_writes=False, cancel=False, post_writes=True) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
+expecting 4 dirty sectors; have 4. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
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
+= Checking Bitmap target =
+expecting 4 dirty sectors; have 4. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=True, disabled=True, pre_writes=False, mid_writes=False, cancel=False, post_writes=False) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
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
+= Checking Bitmap target =
+expecting 4 dirty sectors; have 4. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=True, disabled=False, pre_writes=True, mid_writes=True, cancel=True, post_writes=True) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+= Checking Bitmap target =
+expecting 6 dirty sectors; have 6. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
+expecting 10 dirty sectors; have 10. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
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
+= Checking Bitmap target =
+expecting 15 dirty sectors; have 15. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=True, disabled=False, pre_writes=True, mid_writes=True, cancel=True, post_writes=False) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+= Checking Bitmap target =
+expecting 6 dirty sectors; have 6. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
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
+= Checking Bitmap target =
+expecting 10 dirty sectors; have 10. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=True, disabled=False, pre_writes=True, mid_writes=True, cancel=False, post_writes=True) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+= Checking Bitmap target =
+expecting 6 dirty sectors; have 6. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
+expecting 10 dirty sectors; have 10. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
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
+= Checking Bitmap target =
+expecting 15 dirty sectors; have 15. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=True, disabled=False, pre_writes=True, mid_writes=True, cancel=False, post_writes=False) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+= Checking Bitmap target =
+expecting 6 dirty sectors; have 6. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
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
+= Checking Bitmap target =
+expecting 10 dirty sectors; have 10. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=True, disabled=False, pre_writes=True, mid_writes=False, cancel=True, post_writes=True) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+= Checking Bitmap target =
+expecting 6 dirty sectors; have 6. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
+expecting 6 dirty sectors; have 6. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
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
+= Checking Bitmap target =
+expecting 14 dirty sectors; have 14. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=True, disabled=False, pre_writes=True, mid_writes=False, cancel=True, post_writes=False) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+= Checking Bitmap target =
+expecting 6 dirty sectors; have 6. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
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
+= Checking Bitmap target =
+expecting 6 dirty sectors; have 6. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=True, disabled=False, pre_writes=True, mid_writes=False, cancel=False, post_writes=True) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+= Checking Bitmap target =
+expecting 6 dirty sectors; have 6. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
+expecting 7 dirty sectors; have 7. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
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
+= Checking Bitmap target =
+expecting 15 dirty sectors; have 15. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=True, disabled=False, pre_writes=True, mid_writes=False, cancel=False, post_writes=False) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+= Checking Bitmap target =
+expecting 6 dirty sectors; have 6. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
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
+= Checking Bitmap target =
+expecting 7 dirty sectors; have 7. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=True, disabled=False, pre_writes=False, mid_writes=True, cancel=True, post_writes=True) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
+expecting 7 dirty sectors; have 7. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
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
+= Checking Bitmap target =
+expecting 12 dirty sectors; have 12. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=True, disabled=False, pre_writes=False, mid_writes=True, cancel=True, post_writes=False) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
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
+= Checking Bitmap target =
+expecting 7 dirty sectors; have 7. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=True, disabled=False, pre_writes=False, mid_writes=True, cancel=False, post_writes=True) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
+expecting 10 dirty sectors; have 10. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
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
+= Checking Bitmap target =
+expecting 15 dirty sectors; have 15. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=True, disabled=False, pre_writes=False, mid_writes=True, cancel=False, post_writes=False) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
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
+= Checking Bitmap target =
+expecting 10 dirty sectors; have 10. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=True, disabled=False, pre_writes=False, mid_writes=False, cancel=True, post_writes=True) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
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
+= Checking Bitmap target =
+expecting 8 dirty sectors; have 8. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=True, disabled=False, pre_writes=False, mid_writes=False, cancel=True, post_writes=False) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
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
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=True, disabled=False, pre_writes=False, mid_writes=False, cancel=False, post_writes=True) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
+expecting 4 dirty sectors; have 4. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
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
+= Checking Bitmap target =
+expecting 12 dirty sectors; have 12. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=True, disabled=False, pre_writes=False, mid_writes=False, cancel=False, post_writes=False) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Write #0:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x49 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6c 0x0100000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6f 0x2000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x76 0x3ff0000 0x10000\""}}
+{"return": ""}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
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
+= Checking Bitmap target =
+expecting 4 dirty sectors; have 4. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=False, disabled=True, pre_writes=True, mid_writes=True, cancel=True, post_writes=True) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
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
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=False, disabled=True, pre_writes=True, mid_writes=True, cancel=True, post_writes=False) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
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
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=False, disabled=True, pre_writes=True, mid_writes=True, cancel=False, post_writes=True) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
+expecting 10 dirty sectors; have 10. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
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
+= Checking Bitmap target =
+expecting 10 dirty sectors; have 10. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=False, disabled=True, pre_writes=True, mid_writes=True, cancel=False, post_writes=False) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
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
+= Checking Bitmap target =
+expecting 10 dirty sectors; have 10. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=False, disabled=True, pre_writes=True, mid_writes=False, cancel=True, post_writes=True) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
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
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=False, disabled=True, pre_writes=True, mid_writes=False, cancel=True, post_writes=False) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
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
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=False, disabled=True, pre_writes=True, mid_writes=False, cancel=False, post_writes=True) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
+expecting 6 dirty sectors; have 6. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
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
+= Checking Bitmap target =
+expecting 6 dirty sectors; have 6. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=False, disabled=True, pre_writes=True, mid_writes=False, cancel=False, post_writes=False) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
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
+= Checking Bitmap target =
+expecting 6 dirty sectors; have 6. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=False, disabled=True, pre_writes=False, mid_writes=True, cancel=True, post_writes=True) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
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
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=False, disabled=True, pre_writes=False, mid_writes=True, cancel=True, post_writes=False) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
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
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=False, disabled=True, pre_writes=False, mid_writes=True, cancel=False, post_writes=True) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
+expecting 7 dirty sectors; have 7. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
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
+= Checking Bitmap target =
+expecting 7 dirty sectors; have 7. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=False, disabled=True, pre_writes=False, mid_writes=True, cancel=False, post_writes=False) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
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
+= Checking Bitmap target =
+expecting 7 dirty sectors; have 7. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=False, disabled=True, pre_writes=False, mid_writes=False, cancel=True, post_writes=True) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
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
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=False, disabled=True, pre_writes=False, mid_writes=False, cancel=True, post_writes=False) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
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
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=False, disabled=True, pre_writes=False, mid_writes=False, cancel=False, post_writes=True) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
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
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=False, disabled=True, pre_writes=False, mid_writes=False, cancel=False, post_writes=False) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": true, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
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
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=False, disabled=False, pre_writes=True, mid_writes=True, cancel=True, post_writes=True) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+= Checking Bitmap target =
+expecting 6 dirty sectors; have 6. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
+expecting 10 dirty sectors; have 10. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
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
+= Checking Bitmap target =
+expecting 15 dirty sectors; have 15. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=False, disabled=False, pre_writes=True, mid_writes=True, cancel=True, post_writes=False) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+= Checking Bitmap target =
+expecting 6 dirty sectors; have 6. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
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
+= Checking Bitmap target =
+expecting 10 dirty sectors; have 10. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=False, disabled=False, pre_writes=True, mid_writes=True, cancel=False, post_writes=True) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+= Checking Bitmap target =
+expecting 6 dirty sectors; have 6. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
+expecting 10 dirty sectors; have 10. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
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
+= Checking Bitmap target =
+expecting 15 dirty sectors; have 15. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=False, disabled=False, pre_writes=True, mid_writes=True, cancel=False, post_writes=False) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+= Checking Bitmap target =
+expecting 6 dirty sectors; have 6. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
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
+= Checking Bitmap target =
+expecting 10 dirty sectors; have 10. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=False, disabled=False, pre_writes=True, mid_writes=False, cancel=True, post_writes=True) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+= Checking Bitmap target =
+expecting 6 dirty sectors; have 6. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
+expecting 6 dirty sectors; have 6. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
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
+= Checking Bitmap target =
+expecting 14 dirty sectors; have 14. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=False, disabled=False, pre_writes=True, mid_writes=False, cancel=True, post_writes=False) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+= Checking Bitmap target =
+expecting 6 dirty sectors; have 6. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
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
+= Checking Bitmap target =
+expecting 6 dirty sectors; have 6. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=False, disabled=False, pre_writes=True, mid_writes=False, cancel=False, post_writes=True) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+= Checking Bitmap target =
+expecting 6 dirty sectors; have 6. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
+expecting 6 dirty sectors; have 6. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
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
+= Checking Bitmap target =
+expecting 14 dirty sectors; have 14. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=False, disabled=False, pre_writes=True, mid_writes=False, cancel=False, post_writes=False) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Write #1:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x65 0x0000000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x77 0x00f8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x72 0x2008000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x3fe0000 0x10000\""}}
+{"return": ""}
+
+= Checking Bitmap target =
+expecting 6 dirty sectors; have 6. OK!
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
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
+= Checking Bitmap target =
+expecting 6 dirty sectors; have 6. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=False, disabled=False, pre_writes=False, mid_writes=True, cancel=True, post_writes=True) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
+expecting 7 dirty sectors; have 7. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
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
+= Checking Bitmap target =
+expecting 12 dirty sectors; have 12. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=False, disabled=False, pre_writes=False, mid_writes=True, cancel=True, post_writes=False) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
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
+= Checking Bitmap target =
+expecting 7 dirty sectors; have 7. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=False, disabled=False, pre_writes=False, mid_writes=True, cancel=False, post_writes=True) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
+expecting 7 dirty sectors; have 7. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
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
+= Checking Bitmap target =
+expecting 12 dirty sectors; have 12. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=False, disabled=False, pre_writes=False, mid_writes=True, cancel=False, post_writes=False) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+-- Write #2:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x74 0x0010000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x69 0x00e8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x6e 0x2018000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0x67 0x3fe0000 0x20000\""}}
+{"return": ""}
+
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
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
+= Checking Bitmap target =
+expecting 7 dirty sectors; have 7. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=False, disabled=False, pre_writes=False, mid_writes=False, cancel=True, post_writes=True) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
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
+= Checking Bitmap target =
+expecting 8 dirty sectors; have 8. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=False, disabled=False, pre_writes=False, mid_writes=False, cancel=True, post_writes=False) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-cancel", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Job failed: Operation canceled
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
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
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=False, disabled=False, pre_writes=False, mid_writes=False, cancel=False, post_writes=True) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Write #3:
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xaa 0x0010000 0x30000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xbb 0x00d8000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xcc 0x2028000 0x10000\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io drive0 \"write -P0xdd 0x3fc0000 0x10000\""}}
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
+= Checking Bitmap target =
+expecting 8 dirty sectors; have 8. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
+
+=== Bitmap Populate TestConfig(base_pattern=False, disabled=False, pre_writes=False, mid_writes=False, cancel=False, post_writes=False) ===
+
+-- Prepare image & VM:
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+-- Add Bitmap:
+{"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 65536, "name": "target", "node": "drive0"}}
+{"return": {}}
+
+-- Test block-dirty-bitmap-populate (bitpop0):
+{"execute": "block-dirty-bitmap-populate", "arguments": {"auto-dismiss": false, "auto-finalize": false, "job-id": "bitpop0", "name": "target", "node": "drive0", "pattern": "allocation-top"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+{"data": {"id": "bitpop0", "type": "bitmap-populate"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitpop0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "bitmap-populate"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "bitpop0"}}
+{"return": {}}
+
+= Checking Bitmap target =
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
+= Checking Bitmap target =
+expecting 0 dirty sectors; have 0. OK!
+
+-- Cleanup:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "target", "node": "drive0"}}
+{"return": {}}
+OK: All bitmaps removed
+
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 5cad0152317a..f2c84c7b77c0 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -307,6 +307,7 @@
 295 rw
 296 rw
 297 meta
+298 rw
 299 auto quick
 300 migration
 301 backing quick
-- 
2.28.0


