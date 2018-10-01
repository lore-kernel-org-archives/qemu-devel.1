Received: from eggs.gnu.org ([2001:4830:134:3::10]:40631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g6vSi-0005BU-7S
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:30:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g6vSe-0002wJ-1C
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:30:00 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  1 Oct 2018 13:29:26 +0300
Message-Id: <20181001102928.20533-17-vsementsov@virtuozzo.com>
In-Reply-To: <20181001102928.20533-1-vsementsov@virtuozzo.com>
References: <20181001102928.20533-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 16/18] iotests: test new fleecing-hook
 driver in context of 222 iotest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com, stefanha@redhat.com, jsnow@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/222     | 59 +++++++++++++++++++++++++++-------
 tests/qemu-iotests/222.out | 66 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+), 11 deletions(-)

diff --git a/tests/qemu-iotests/222 b/tests/qemu-iotests/222
index 0ead56d574..3063dd0705 100644
--- a/tests/qemu-iotests/222
+++ b/tests/qemu-iotests/222
@@ -4,7 +4,9 @@
 # point-in-time snapshot of a node that can be queried over NBD.
 #
 # Copyright (C) 2018 Red Hat, Inc.
+# Copyright (c) 2018 Virtuozzo International GmbH. All rights reserved.
 # John helped, too.
+# And Vladimir, a bit.
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
@@ -46,11 +48,40 @@ remainder = [("0xd5", "0x108000",  "32k"), # Right-end of partial-left [1]
              ("0xdc", "32M",       "32k"), # Left-end of partial-right [2]
              ("0xcd", "0x3ff0000", "64k")] # patterns[3]
 
-with iotests.FilePath('base.img') as base_img_path, \
-     iotests.FilePath('fleece.img') as fleece_img_path, \
-     iotests.FilePath('nbd.sock') as nbd_sock_path, \
-     iotests.VM() as vm:
+class Fleecing():
+    def __init__(self, vm, src_node, tgt_node):
+        self.vm = vm
+        self.src_node = src_node
+        self.tgt_node = tgt_node
 
+class OldBackupFleecing(Fleecing):
+    def start(self):
+        log(self.vm.qmp("blockdev-backup",
+                        device=self.src_node,
+                        target=self.tgt_node,
+                        sync="none"))
+
+    def stop(self):
+        log(self.vm.qmp('block-job-cancel', device=self.src_node))
+        log(self.vm.event_wait('BLOCK_JOB_CANCELLED'),
+                filters=[iotests.filter_qmp_event])
+
+
+class FleecingHookFleecing(Fleecing):
+    def start(self):
+        log(self.vm.qmp("blockdev-add", **{
+            "driver": "fleecing-hook",
+            "node-name": "hook",
+            "append-to": self.src_node,
+            "target": self.tgt_node,
+        }))
+
+    def stop(self):
+        log(self.vm.qmp('x-drop-fleecing', node_name="hook"))
+
+
+def do_test(base_img_path, fleece_img_path, nbd_sock_path, fleecing):
+    vm = iotests.VM()
     log('--- Setting up images ---')
     log('')
 
@@ -77,6 +108,7 @@ with iotests.FilePath('base.img') as base_img_path, \
 
     src_node = "drive0"
     tgt_node = "fleeceNode"
+    fl = fleecing(vm, src_node, tgt_node)
 
     # create tgt_node backed by src_node
     log(vm.qmp("blockdev-add", **{
@@ -90,10 +122,7 @@ with iotests.FilePath('base.img') as base_img_path, \
     }))
 
     # Establish COW from source to fleecing node
-    log(vm.qmp("blockdev-backup",
-               device=src_node,
-               target=tgt_node,
-               sync="none"))
+    fl.start()
 
     log('')
     log('--- Setting up NBD Export ---')
@@ -137,10 +166,8 @@ with iotests.FilePath('base.img') as base_img_path, \
     log('--- Cleanup ---')
     log('')
 
-    log(vm.qmp('block-job-cancel', device=src_node))
-    log(vm.event_wait('BLOCK_JOB_CANCELLED'),
-        filters=[iotests.filter_qmp_event])
     log(vm.qmp('nbd-server-stop'))
+    fl.stop()
     log(vm.qmp('blockdev-del', node_name=tgt_node))
     vm.shutdown()
 
@@ -155,3 +182,13 @@ with iotests.FilePath('base.img') as base_img_path, \
 
     log('')
     log('Done')
+
+def test(fleecing):
+    with iotests.FilePath('base.img') as base_img_path, \
+         iotests.FilePath('fleece.img') as fleece_img_path, \
+         iotests.FilePath('nbd.sock') as nbd_sock_path:
+
+         do_test(base_img_path, fleece_img_path, nbd_sock_path, fleecing)
+
+test(OldBackupFleecing)
+test(FleecingHookFleecing)
diff --git a/tests/qemu-iotests/222.out b/tests/qemu-iotests/222.out
index 48f336a02b..28c3623ee8 100644
--- a/tests/qemu-iotests/222.out
+++ b/tests/qemu-iotests/222.out
@@ -49,9 +49,75 @@ read -P0 0x3fe0000 64k
 
 --- Cleanup ---
 
+{u'return': {}}
 {u'return': {}}
 {u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'device': u'drive0', u'type': u'backup', u'speed': 0, u'len': 67108864, u'offset': 393216}, u'event': u'BLOCK_JOB_CANCELLED'}
 {u'return': {}}
+
+--- Confirming writes ---
+
+read -P0xab 0 64k
+read -P0xad 0x00f8000 64k
+read -P0x1d 0x2008000 64k
+read -P0xea 0x3fe0000 64k
+read -P0xd5 0x108000 32k
+read -P0xdc 32M 32k
+read -P0xcd 0x3ff0000 64k
+
+Done
+--- Setting up images ---
+
+Done
+
+--- Launching VM ---
+
+Done
+
+--- Setting up Fleecing Graph ---
+
+{u'return': {}}
+{u'return': {}}
+
+--- Setting up NBD Export ---
+
+{u'return': {}}
+{u'return': {}}
+
+--- Sanity Check ---
+
+read -P0x5d 0 64k
+read -P0xd5 1M 64k
+read -P0xdc 32M 64k
+read -P0xcd 0x3ff0000 64k
+read -P0 0x00f8000 32k
+read -P0 0x2010000 32k
+read -P0 0x3fe0000 64k
+
+--- Testing COW ---
+
+write -P0xab 0 64k
+{u'return': u''}
+write -P0xad 0x00f8000 64k
+{u'return': u''}
+write -P0x1d 0x2008000 64k
+{u'return': u''}
+write -P0xea 0x3fe0000 64k
+{u'return': u''}
+
+--- Verifying Data ---
+
+read -P0x5d 0 64k
+read -P0xd5 1M 64k
+read -P0xdc 32M 64k
+read -P0xcd 0x3ff0000 64k
+read -P0 0x00f8000 32k
+read -P0 0x2010000 32k
+read -P0 0x3fe0000 64k
+
+--- Cleanup ---
+
+{u'return': {}}
+{u'return': {}}
 {u'return': {}}
 
 --- Confirming writes ---
-- 
2.18.0
