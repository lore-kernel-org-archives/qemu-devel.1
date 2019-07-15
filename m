Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33800C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 16:08:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECAF1204FD
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 16:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECAF1204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn3Wg-0000Sx-79
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 12:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56834)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hn3WR-0008VS-Un
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 12:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hn3WO-0000QL-GF
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 12:08:15 -0400
Received: from relay.sw.ru ([185.231.240.75]:52368)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hn3WO-0000Pv-4e; Mon, 15 Jul 2019 12:08:12 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hn3WL-0003Hq-UX; Mon, 15 Jul 2019 19:08:10 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Mon, 15 Jul 2019 19:07:59 +0300
Message-Id: <1563206879-396579-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH] iotests: Set read-zeroes on in null block
 driver for Valgrind
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, mreitz@redhat.com,
 andrey.shinkevich@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Valgrind tool reports about the uninitialised buffer 'buf'
instantiated on the stack of the function guess_disk_lchs().
Pass 'read-zeroes=on' to the null block driver to make it deterministic.
The output of the tests 051, 186 and 227 now includes the parameter
'read-zeroes'. So, the benchmark output files are being changed too.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
Note:
The change in the tests 093 and 136 reveals the race condition in chardev.
The patch "chardev: race condition with tcp_chr_disconnect" has been emailed
to qemu-devel@nongnu.org on July, 12 of 2019 with the Message ID
<1562959033-223586-1-git-send-email-andrey.shinkevich@virtuozzo.com>

 tests/qemu-iotests/051        |  10 +--
 tests/qemu-iotests/051.pc.out |  10 +--
 tests/qemu-iotests/093        |   9 +--
 tests/qemu-iotests/136        |   1 +
 tests/qemu-iotests/186        |  20 +++---
 tests/qemu-iotests/186.out    | 152 +++++++++++++++++++++---------------------
 tests/qemu-iotests/227        |   4 +-
 tests/qemu-iotests/227.out    |   4 +-
 tests/qemu-iotests/238        |   2 +-
 tests/qemu-iotests/240        |   8 +--
 10 files changed, 111 insertions(+), 109 deletions(-)

diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index 200660f..ce942a5 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -251,11 +251,11 @@ echo
 # Cannot use the test image because cache=none might not work on the host FS
 # Use cdrom so that we won't get errors about missing media
 
-run_qemu -drive driver=null-co,cache=none
-run_qemu -drive driver=null-co,cache=directsync
-run_qemu -drive driver=null-co,cache=writeback
-run_qemu -drive driver=null-co,cache=writethrough
-run_qemu -drive driver=null-co,cache=unsafe
+run_qemu -drive driver=null-co,read-zeroes=on,cache=none
+run_qemu -drive driver=null-co,read-zeroes=on,cache=directsync
+run_qemu -drive driver=null-co,read-zeroes=on,cache=writeback
+run_qemu -drive driver=null-co,read-zeroes=on,cache=writethrough
+run_qemu -drive driver=null-co,read-zeroes=on,cache=unsafe
 run_qemu -drive driver=null-co,cache=invalid_value
 
 # Can't test direct=on here because O_DIRECT might not be supported on this FS
diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
index 2d811c1..000557c 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -245,23 +245,23 @@ QEMU X.Y.Z monitor - type 'help' for more information
 
 === Cache modes ===
 
-Testing: -drive driver=null-co,cache=none
+Testing: -drive driver=null-co,read-zeroes=on,cache=none
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) quit
 
-Testing: -drive driver=null-co,cache=directsync
+Testing: -drive driver=null-co,read-zeroes=on,cache=directsync
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) quit
 
-Testing: -drive driver=null-co,cache=writeback
+Testing: -drive driver=null-co,read-zeroes=on,cache=writeback
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) quit
 
-Testing: -drive driver=null-co,cache=writethrough
+Testing: -drive driver=null-co,read-zeroes=on,cache=writethrough
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) quit
 
-Testing: -drive driver=null-co,cache=unsafe
+Testing: -drive driver=null-co,read-zeroes=on,cache=unsafe
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) quit
 
diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
index d88fbc1..4b2cac1 100755
--- a/tests/qemu-iotests/093
+++ b/tests/qemu-iotests/093
@@ -38,7 +38,7 @@ class ThrottleTestCase(iotests.QMPTestCase):
     def setUp(self):
         self.vm = iotests.VM()
         for i in range(0, self.max_drives):
-            self.vm.add_drive(self.test_img)
+            self.vm.add_drive(self.test_img, "file.read-zeroes=on")
         self.vm.launch()
 
     def tearDown(self):
@@ -273,7 +273,8 @@ class ThrottleTestGroupNames(iotests.QMPTestCase):
     def setUp(self):
         self.vm = iotests.VM()
         for i in range(0, self.max_drives):
-            self.vm.add_drive(self.test_img, "throttling.iops-total=100")
+            self.vm.add_drive(self.test_img,
+                              "throttling.iops-total=100,file.read-zeroes=on")
         self.vm.launch()
 
     def tearDown(self):
@@ -378,10 +379,10 @@ class ThrottleTestRemovableMedia(iotests.QMPTestCase):
     def test_removable_media(self):
         # Add a couple of dummy nodes named cd0 and cd1
         result = self.vm.qmp("blockdev-add", driver="null-aio",
-                             node_name="cd0")
+                             read_zeroes=True, node_name="cd0")
         self.assert_qmp(result, 'return', {})
         result = self.vm.qmp("blockdev-add", driver="null-aio",
-                             node_name="cd1")
+                             read_zeroes=True, node_name="cd1")
         self.assert_qmp(result, 'return', {})
 
         # Attach a CD drive with cd0 inserted
diff --git a/tests/qemu-iotests/136 b/tests/qemu-iotests/136
index af7ffa4..a46a7b7 100755
--- a/tests/qemu-iotests/136
+++ b/tests/qemu-iotests/136
@@ -74,6 +74,7 @@ sector = "%d"
                           (self.account_invalid and "on" or "off"))
         drive_args.append("stats-account-failed=%s" %
                           (self.account_failed and "on" or "off"))
+        drive_args.append("file.image.read-zeroes=on")
         self.create_blkdebug_file()
         self.vm = iotests.VM().add_drive('blkdebug:%s:%s' %
                                          (blkdebug_file, self.test_img),
diff --git a/tests/qemu-iotests/186 b/tests/qemu-iotests/186
index 7e7d45b..5f6b18c 100755
--- a/tests/qemu-iotests/186
+++ b/tests/qemu-iotests/186
@@ -86,8 +86,8 @@ echo "=== -blockdev/-device=<node-name> ==="
 echo
 
 for dev in $fixed $removable; do
-    check_info_block -blockdev driver=null-co,node-name=null -device $dev,drive=null
-    check_info_block -blockdev driver=null-co,node-name=null -device $dev,drive=null,id=qdev_id
+    check_info_block -blockdev driver=null-co,read-zeroes=on,node-name=null -device $dev,drive=null
+    check_info_block -blockdev driver=null-co,read-zeroes=on,node-name=null -device $dev,drive=null,id=qdev_id
 done
 
 echo
@@ -97,7 +97,7 @@ echo
 # This creates two BlockBackends that will show up in 'info block'!
 # A monitor-owned one from -drive, and anonymous one from -device
 for dev in $fixed $removable; do
-    check_info_block -drive if=none,driver=null-co,node-name=null -device $dev,drive=null,id=qdev_id
+    check_info_block -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device $dev,drive=null,id=qdev_id
 done
 
 echo
@@ -105,8 +105,8 @@ echo "=== -drive if=none/-device=<bb-name> (with medium) ==="
 echo
 
 for dev in $fixed $removable; do
-    check_info_block -drive if=none,driver=null-co,node-name=null -device $dev,drive=none0
-    check_info_block -drive if=none,driver=null-co,node-name=null -device $dev,drive=none0,id=qdev_id
+    check_info_block -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device $dev,drive=none0
+    check_info_block -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device $dev,drive=none0,id=qdev_id
 done
 
 echo
@@ -125,15 +125,15 @@ echo "=== -drive if=... ==="
 echo
 
 check_info_block -drive if=floppy
-check_info_block -drive if=floppy,driver=null-co
+check_info_block -drive if=floppy,driver=null-co,read-zeroes=on
 
-check_info_block -drive if=ide,driver=null-co
+check_info_block -drive if=ide,driver=null-co,read-zeroes=on
 check_info_block -drive if=ide,media=cdrom
-check_info_block -drive if=ide,driver=null-co,media=cdrom
+check_info_block -drive if=ide,driver=null-co,read-zeroes=on,media=cdrom
 
-check_info_block -drive if=virtio,driver=null-co
+check_info_block -drive if=virtio,driver=null-co,read-zeroes=on
 
-check_info_block -drive if=pflash,driver=null-co,size=1M
+check_info_block -drive if=pflash,driver=null-co,read-zeroes=on,size=1M
 
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/186.out b/tests/qemu-iotests/186.out
index 716b01a..5b35040 100644
--- a/tests/qemu-iotests/186.out
+++ b/tests/qemu-iotests/186.out
@@ -54,103 +54,103 @@ qdev_id: [not inserted]
 
 === -blockdev/-device=<node-name> ===
 
-Testing: -blockdev driver=null-co,node-name=null -device ide-hd,drive=null
+Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device ide-hd,drive=null
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: null-co:// (null-co)
+null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
     Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
 
-Testing: -blockdev driver=null-co,node-name=null -device ide-hd,drive=null,id=qdev_id
+Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device ide-hd,drive=null,id=qdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: null-co:// (null-co)
+null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
     Attached to:      qdev_id
     Cache mode:       writeback
 (qemu) quit
 
-Testing: -blockdev driver=null-co,node-name=null -device scsi-hd,drive=null
+Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device scsi-hd,drive=null
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: null-co:// (null-co)
+null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
     Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
 
-Testing: -blockdev driver=null-co,node-name=null -device scsi-hd,drive=null,id=qdev_id
+Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device scsi-hd,drive=null,id=qdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: null-co:// (null-co)
+null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
     Attached to:      qdev_id
     Cache mode:       writeback
 (qemu) quit
 
-Testing: -blockdev driver=null-co,node-name=null -device virtio-blk-pci,drive=null
+Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device virtio-blk-pci,drive=null
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: null-co:// (null-co)
+null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
     Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
 
-Testing: -blockdev driver=null-co,node-name=null -device virtio-blk-pci,drive=null,id=qdev_id
+Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device virtio-blk-pci,drive=null,id=qdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: null-co:// (null-co)
+null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
     Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
 
-Testing: -blockdev driver=null-co,node-name=null -device floppy,drive=null
+Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device floppy,drive=null
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: null-co:// (null-co)
+null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
     Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
 
-Testing: -blockdev driver=null-co,node-name=null -device floppy,drive=null,id=qdev_id
+Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device floppy,drive=null,id=qdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: null-co:// (null-co)
+null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
     Attached to:      qdev_id
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
 
-Testing: -blockdev driver=null-co,node-name=null -device ide-cd,drive=null
+Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device ide-cd,drive=null
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: null-co:// (null-co)
+null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
     Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
 
-Testing: -blockdev driver=null-co,node-name=null -device ide-cd,drive=null,id=qdev_id
+Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device ide-cd,drive=null,id=qdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: null-co:// (null-co)
+null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
     Attached to:      qdev_id
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
 
-Testing: -blockdev driver=null-co,node-name=null -device scsi-cd,drive=null
+Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device scsi-cd,drive=null
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: null-co:// (null-co)
+null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
     Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
 
-Testing: -blockdev driver=null-co,node-name=null -device scsi-cd,drive=null,id=qdev_id
+Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device scsi-cd,drive=null,id=qdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: null-co:// (null-co)
+null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
     Attached to:      qdev_id
     Removable device: not locked, tray closed
     Cache mode:       writeback
@@ -159,76 +159,76 @@ null: null-co:// (null-co)
 
 === -drive if=none/-device=<node-name> ===
 
-Testing: -drive if=none,driver=null-co,node-name=null -device ide-hd,drive=null,id=qdev_id
+Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device ide-hd,drive=null,id=qdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Removable device: not locked, tray closed
     Cache mode:       writeback
 
-null: null-co:// (null-co)
+null: json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      qdev_id
     Cache mode:       writeback
 (qemu) quit
 
-Testing: -drive if=none,driver=null-co,node-name=null -device scsi-hd,drive=null,id=qdev_id
+Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device scsi-hd,drive=null,id=qdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Removable device: not locked, tray closed
     Cache mode:       writeback
 
-null: null-co:// (null-co)
+null: json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      qdev_id
     Cache mode:       writeback
 (qemu) quit
 
-Testing: -drive if=none,driver=null-co,node-name=null -device virtio-blk-pci,drive=null,id=qdev_id
+Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device virtio-blk-pci,drive=null,id=qdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Removable device: not locked, tray closed
     Cache mode:       writeback
 
-null: null-co:// (null-co)
+null: json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
 
-Testing: -drive if=none,driver=null-co,node-name=null -device floppy,drive=null,id=qdev_id
+Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device floppy,drive=null,id=qdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Removable device: not locked, tray closed
     Cache mode:       writeback
 
-null: null-co:// (null-co)
+null: json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      qdev_id
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
 
-Testing: -drive if=none,driver=null-co,node-name=null -device ide-cd,drive=null,id=qdev_id
+Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device ide-cd,drive=null,id=qdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Removable device: not locked, tray closed
     Cache mode:       writeback
 
-null: null-co:// (null-co)
+null: json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      qdev_id
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
 
-Testing: -drive if=none,driver=null-co,node-name=null -device scsi-cd,drive=null,id=qdev_id
+Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device scsi-cd,drive=null,id=qdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Removable device: not locked, tray closed
     Cache mode:       writeback
 
-null: null-co:// (null-co)
+null: json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      qdev_id
     Removable device: not locked, tray closed
     Cache mode:       writeback
@@ -237,103 +237,103 @@ null: null-co:// (null-co)
 
 === -drive if=none/-device=<bb-name> (with medium) ===
 
-Testing: -drive if=none,driver=null-co,node-name=null -device ide-hd,drive=none0
+Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device ide-hd,drive=none0
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
 
-Testing: -drive if=none,driver=null-co,node-name=null -device ide-hd,drive=none0,id=qdev_id
+Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device ide-hd,drive=none0,id=qdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      qdev_id
     Cache mode:       writeback
 (qemu) quit
 
-Testing: -drive if=none,driver=null-co,node-name=null -device scsi-hd,drive=none0
+Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device scsi-hd,drive=none0
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
 
-Testing: -drive if=none,driver=null-co,node-name=null -device scsi-hd,drive=none0,id=qdev_id
+Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device scsi-hd,drive=none0,id=qdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      qdev_id
     Cache mode:       writeback
 (qemu) quit
 
-Testing: -drive if=none,driver=null-co,node-name=null -device virtio-blk-pci,drive=none0
+Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device virtio-blk-pci,drive=none0
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
 
-Testing: -drive if=none,driver=null-co,node-name=null -device virtio-blk-pci,drive=none0,id=qdev_id
+Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device virtio-blk-pci,drive=none0,id=qdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
 
-Testing: -drive if=none,driver=null-co,node-name=null -device floppy,drive=none0
+Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device floppy,drive=none0
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
 
-Testing: -drive if=none,driver=null-co,node-name=null -device floppy,drive=none0,id=qdev_id
+Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device floppy,drive=none0,id=qdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      qdev_id
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
 
-Testing: -drive if=none,driver=null-co,node-name=null -device ide-cd,drive=none0
+Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device ide-cd,drive=none0
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
 
-Testing: -drive if=none,driver=null-co,node-name=null -device ide-cd,drive=none0,id=qdev_id
+Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device ide-cd,drive=none0,id=qdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      qdev_id
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
 
-Testing: -drive if=none,driver=null-co,node-name=null -device scsi-cd,drive=none0
+Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device scsi-cd,drive=none0
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
 
-Testing: -drive if=none,driver=null-co,node-name=null -device scsi-cd,drive=none0,id=qdev_id
+Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device scsi-cd,drive=none0,id=qdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      qdev_id
     Removable device: not locked, tray closed
     Cache mode:       writeback
@@ -408,19 +408,19 @@ floppy0: [not inserted]
     Removable device: not locked, tray closed
 (qemu) quit
 
-Testing: -drive if=floppy,driver=null-co
+Testing: -drive if=floppy,driver=null-co,read-zeroes=on
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-floppy0 (NODE_NAME): null-co:// (null-co)
+floppy0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
 
-Testing: -drive if=ide,driver=null-co
+Testing: -drive if=ide,driver=null-co,read-zeroes=on
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-ide0-hd0 (NODE_NAME): null-co:// (null-co)
+ide0-hd0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
@@ -433,27 +433,27 @@ ide0-cd0: [not inserted]
     Removable device: not locked, tray closed
 (qemu) quit
 
-Testing: -drive if=ide,driver=null-co,media=cdrom
+Testing: -drive if=ide,driver=null-co,read-zeroes=on,media=cdrom
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-ide0-cd0 (NODE_NAME): null-co:// (null-co, read-only)
+ide0-cd0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co"} (null-co, read-only)
     Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
 
-Testing: -drive if=virtio,driver=null-co
+Testing: -drive if=virtio,driver=null-co,read-zeroes=on
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-virtio0 (NODE_NAME): null-co:// (null-co)
+virtio0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
 
-Testing: -drive if=pflash,driver=null-co,size=1M
+Testing: -drive if=pflash,driver=null-co,read-zeroes=on,size=1M
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-pflash0 (NODE_NAME): json:{"driver": "null-co", "size": "1M"} (null-co)
+pflash0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co", "size": "1M"} (null-co)
     Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
diff --git a/tests/qemu-iotests/227 b/tests/qemu-iotests/227
index bdd727a..637d7c3 100755
--- a/tests/qemu-iotests/227
+++ b/tests/qemu-iotests/227
@@ -57,7 +57,7 @@ echo
 echo '=== blockstats with -drive if=virtio ==='
 echo
 
-run_qemu -drive driver=null-co,if=virtio <<EOF
+run_qemu -drive driver=null-co,read-zeroes=on,if=virtio <<EOF
 { "execute": "qmp_capabilities" }
 { "execute": "query-blockstats"}
 { "execute": "quit" }
@@ -87,7 +87,7 @@ echo
 echo '=== blockstats with -blockdev and -device ==='
 echo
 
-run_qemu -blockdev driver=null-co,node-name=null -device virtio-blk,drive=null,id=virtio0 <<EOF
+run_qemu -blockdev driver=null-co,read-zeroes=on,node-name=null -device virtio-blk,drive=null,id=virtio0 <<EOF
 { "execute": "qmp_capabilities" }
 { "execute": "query-blockstats"}
 { "execute": "quit" }
diff --git a/tests/qemu-iotests/227.out b/tests/qemu-iotests/227.out
index e77efaf..3dd3ca5 100644
--- a/tests/qemu-iotests/227.out
+++ b/tests/qemu-iotests/227.out
@@ -2,7 +2,7 @@ QA output created by 227
 
 === blockstats with -drive if=virtio ===
 
-Testing: -drive driver=null-co,if=virtio
+Testing: -drive driver=null-co,read-zeroes=on,if=virtio
 {
     QMP_VERSION
 }
@@ -150,7 +150,7 @@ Testing: -blockdev driver=null-co,node-name=null
 
 === blockstats with -blockdev and -device ===
 
-Testing: -blockdev driver=null-co,node-name=null -device virtio-blk,drive=null,id=virtio0
+Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device virtio-blk,drive=null,id=virtio0
 {
     QMP_VERSION
 }
diff --git a/tests/qemu-iotests/238 b/tests/qemu-iotests/238
index 1c0a46f..08bc7e6 100755
--- a/tests/qemu-iotests/238
+++ b/tests/qemu-iotests/238
@@ -31,7 +31,7 @@ else:
 vm = iotests.VM()
 vm.launch()
 
-log(vm.qmp('blockdev-add', node_name='hd0', driver='null-co'))
+log(vm.qmp('blockdev-add', node_name='hd0', driver='null-co', read_zeroes=True))
 log(vm.qmp('object-add', qom_type='iothread', id='iothread0'))
 log(vm.qmp('device_add', id='scsi0', driver=virtio_scsi_device, iothread='iothread0'))
 log(vm.qmp('device_add', id='scsi-hd0', driver='scsi-hd', drive='hd0'))
diff --git a/tests/qemu-iotests/240 b/tests/qemu-iotests/240
index 5be6b9c..f73bc07 100755
--- a/tests/qemu-iotests/240
+++ b/tests/qemu-iotests/240
@@ -76,7 +76,7 @@ echo
 
 run_qemu <<EOF
 { "execute": "qmp_capabilities" }
-{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "hd0"}}
+{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "read-zeroes": true, "node-name": "hd0"}}
 { "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread0"}}
 { "execute": "device_add", "arguments": {"id": "scsi0", "driver": "${virtio_scsi}", "iothread": "iothread0"}}
 { "execute": "device_add", "arguments": {"id": "scsi-hd0", "driver": "scsi-hd", "drive": "hd0"}}
@@ -94,7 +94,7 @@ echo
 
 run_qemu <<EOF
 { "execute": "qmp_capabilities" }
-{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "hd0", "read-only": true}}
+{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "read-zeroes": true, "node-name": "hd0", "read-only": true}}
 { "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread0"}}
 { "execute": "device_add", "arguments": {"id": "scsi0", "driver": "${virtio_scsi}", "iothread": "iothread0"}}
 { "execute": "device_add", "arguments": {"id": "scsi-hd0", "driver": "scsi-hd", "drive": "hd0"}}
@@ -112,7 +112,7 @@ echo
 
 run_qemu <<EOF
 { "execute": "qmp_capabilities" }
-{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "hd0", "read-only": true}}
+{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "read-zeroes": true, "node-name": "hd0", "read-only": true}}
 { "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread0"}}
 { "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread1"}}
 { "execute": "device_add", "arguments": {"id": "scsi0", "driver": "${virtio_scsi}", "iothread": "iothread0"}}
@@ -134,7 +134,7 @@ echo
 
 run_qemu <<EOF
 { "execute": "qmp_capabilities" }
-{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "hd0", "read-only": true}}
+{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "read-zeroes": true, "node-name": "hd0", "read-only": true}}
 { "execute": "nbd-server-start", "arguments": {"addr":{"type":"unix","data":{"path":"$TEST_DIR/nbd"}}}}
 { "execute": "nbd-server-add", "arguments": {"device":"hd0"}}
 { "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread0"}}
-- 
1.8.3.1


