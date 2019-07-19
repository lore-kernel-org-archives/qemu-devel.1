Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E12C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:45:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EC3B2173B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC3B2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoTCv-00021d-Vx
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 09:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40371)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hoTBB-0003ci-Kn
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hoTB7-0003Vq-7E
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:44:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39408)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hoTAz-0003QJ-VB; Fri, 19 Jul 2019 09:43:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 22FE4308404C;
 Fri, 19 Jul 2019 13:43:57 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 15506646B8;
 Fri, 19 Jul 2019 13:43:55 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 19 Jul 2019 15:43:33 +0200
Message-Id: <20190719134345.23526-2-kwolf@redhat.com>
In-Reply-To: <20190719134345.23526-1-kwolf@redhat.com>
References: <20190719134345.23526-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 19 Jul 2019 13:43:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 01/13] iotests: Set read-zeroes on in null block
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

The Valgrind tool reports about the uninitialised buffer 'buf'
instantiated on the stack of the function guess_disk_lchs().
Pass 'read-zeroes=3Don' to the null block driver to make it deterministic=
.
The output of the tests 051, 186 and 227 now includes the parameter
'read-zeroes'. So, the benchmark output files are being changed too.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/051        |  10 +--
 tests/qemu-iotests/051.pc.out |  10 +--
 tests/qemu-iotests/093        |   9 +-
 tests/qemu-iotests/136        |   1 +
 tests/qemu-iotests/186        |  20 ++---
 tests/qemu-iotests/186.out    | 152 +++++++++++++++++-----------------
 tests/qemu-iotests/227        |   4 +-
 tests/qemu-iotests/227.out    |   4 +-
 tests/qemu-iotests/238        |   2 +-
 tests/qemu-iotests/240        |   8 +-
 10 files changed, 111 insertions(+), 109 deletions(-)

diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index 200660f977..ce942a5444 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -251,11 +251,11 @@ echo
 # Cannot use the test image because cache=3Dnone might not work on the h=
ost FS
 # Use cdrom so that we won't get errors about missing media
=20
-run_qemu -drive driver=3Dnull-co,cache=3Dnone
-run_qemu -drive driver=3Dnull-co,cache=3Ddirectsync
-run_qemu -drive driver=3Dnull-co,cache=3Dwriteback
-run_qemu -drive driver=3Dnull-co,cache=3Dwritethrough
-run_qemu -drive driver=3Dnull-co,cache=3Dunsafe
+run_qemu -drive driver=3Dnull-co,read-zeroes=3Don,cache=3Dnone
+run_qemu -drive driver=3Dnull-co,read-zeroes=3Don,cache=3Ddirectsync
+run_qemu -drive driver=3Dnull-co,read-zeroes=3Don,cache=3Dwriteback
+run_qemu -drive driver=3Dnull-co,read-zeroes=3Don,cache=3Dwritethrough
+run_qemu -drive driver=3Dnull-co,read-zeroes=3Don,cache=3Dunsafe
 run_qemu -drive driver=3Dnull-co,cache=3Dinvalid_value
=20
 # Can't test direct=3Don here because O_DIRECT might not be supported on=
 this FS
diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.ou=
t
index 2d811c166c..000557c7c8 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -245,23 +245,23 @@ QEMU X.Y.Z monitor - type 'help' for more informati=
on
=20
 =3D=3D=3D Cache modes =3D=3D=3D
=20
-Testing: -drive driver=3Dnull-co,cache=3Dnone
+Testing: -drive driver=3Dnull-co,read-zeroes=3Don,cache=3Dnone
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) quit
=20
-Testing: -drive driver=3Dnull-co,cache=3Ddirectsync
+Testing: -drive driver=3Dnull-co,read-zeroes=3Don,cache=3Ddirectsync
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) quit
=20
-Testing: -drive driver=3Dnull-co,cache=3Dwriteback
+Testing: -drive driver=3Dnull-co,read-zeroes=3Don,cache=3Dwriteback
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) quit
=20
-Testing: -drive driver=3Dnull-co,cache=3Dwritethrough
+Testing: -drive driver=3Dnull-co,read-zeroes=3Don,cache=3Dwritethrough
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) quit
=20
-Testing: -drive driver=3Dnull-co,cache=3Dunsafe
+Testing: -drive driver=3Dnull-co,read-zeroes=3Don,cache=3Dunsafe
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) quit
=20
diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
index d88fbc182e..4b2cac1d0c 100755
--- a/tests/qemu-iotests/093
+++ b/tests/qemu-iotests/093
@@ -38,7 +38,7 @@ class ThrottleTestCase(iotests.QMPTestCase):
     def setUp(self):
         self.vm =3D iotests.VM()
         for i in range(0, self.max_drives):
-            self.vm.add_drive(self.test_img)
+            self.vm.add_drive(self.test_img, "file.read-zeroes=3Don")
         self.vm.launch()
=20
     def tearDown(self):
@@ -273,7 +273,8 @@ class ThrottleTestGroupNames(iotests.QMPTestCase):
     def setUp(self):
         self.vm =3D iotests.VM()
         for i in range(0, self.max_drives):
-            self.vm.add_drive(self.test_img, "throttling.iops-total=3D10=
0")
+            self.vm.add_drive(self.test_img,
+                              "throttling.iops-total=3D100,file.read-zer=
oes=3Don")
         self.vm.launch()
=20
     def tearDown(self):
@@ -378,10 +379,10 @@ class ThrottleTestRemovableMedia(iotests.QMPTestCas=
e):
     def test_removable_media(self):
         # Add a couple of dummy nodes named cd0 and cd1
         result =3D self.vm.qmp("blockdev-add", driver=3D"null-aio",
-                             node_name=3D"cd0")
+                             read_zeroes=3DTrue, node_name=3D"cd0")
         self.assert_qmp(result, 'return', {})
         result =3D self.vm.qmp("blockdev-add", driver=3D"null-aio",
-                             node_name=3D"cd1")
+                             read_zeroes=3DTrue, node_name=3D"cd1")
         self.assert_qmp(result, 'return', {})
=20
         # Attach a CD drive with cd0 inserted
diff --git a/tests/qemu-iotests/136 b/tests/qemu-iotests/136
index af7ffa4540..a46a7b7630 100755
--- a/tests/qemu-iotests/136
+++ b/tests/qemu-iotests/136
@@ -74,6 +74,7 @@ sector =3D "%d"
                           (self.account_invalid and "on" or "off"))
         drive_args.append("stats-account-failed=3D%s" %
                           (self.account_failed and "on" or "off"))
+        drive_args.append("file.image.read-zeroes=3Don")
         self.create_blkdebug_file()
         self.vm =3D iotests.VM().add_drive('blkdebug:%s:%s' %
                                          (blkdebug_file, self.test_img),
diff --git a/tests/qemu-iotests/186 b/tests/qemu-iotests/186
index 7e7d45babc..5f6b18c150 100755
--- a/tests/qemu-iotests/186
+++ b/tests/qemu-iotests/186
@@ -86,8 +86,8 @@ echo "=3D=3D=3D -blockdev/-device=3D<node-name> =3D=3D=3D=
"
 echo
=20
 for dev in $fixed $removable; do
-    check_info_block -blockdev driver=3Dnull-co,node-name=3Dnull -device=
 $dev,drive=3Dnull
-    check_info_block -blockdev driver=3Dnull-co,node-name=3Dnull -device=
 $dev,drive=3Dnull,id=3Dqdev_id
+    check_info_block -blockdev driver=3Dnull-co,read-zeroes=3Don,node-na=
me=3Dnull -device $dev,drive=3Dnull
+    check_info_block -blockdev driver=3Dnull-co,read-zeroes=3Don,node-na=
me=3Dnull -device $dev,drive=3Dnull,id=3Dqdev_id
 done
=20
 echo
@@ -97,7 +97,7 @@ echo
 # This creates two BlockBackends that will show up in 'info block'!
 # A monitor-owned one from -drive, and anonymous one from -device
 for dev in $fixed $removable; do
-    check_info_block -drive if=3Dnone,driver=3Dnull-co,node-name=3Dnull =
-device $dev,drive=3Dnull,id=3Dqdev_id
+    check_info_block -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,=
node-name=3Dnull -device $dev,drive=3Dnull,id=3Dqdev_id
 done
=20
 echo
@@ -105,8 +105,8 @@ echo "=3D=3D=3D -drive if=3Dnone/-device=3D<bb-name> =
(with medium) =3D=3D=3D"
 echo
=20
 for dev in $fixed $removable; do
-    check_info_block -drive if=3Dnone,driver=3Dnull-co,node-name=3Dnull =
-device $dev,drive=3Dnone0
-    check_info_block -drive if=3Dnone,driver=3Dnull-co,node-name=3Dnull =
-device $dev,drive=3Dnone0,id=3Dqdev_id
+    check_info_block -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,=
node-name=3Dnull -device $dev,drive=3Dnone0
+    check_info_block -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,=
node-name=3Dnull -device $dev,drive=3Dnone0,id=3Dqdev_id
 done
=20
 echo
@@ -125,15 +125,15 @@ echo "=3D=3D=3D -drive if=3D... =3D=3D=3D"
 echo
=20
 check_info_block -drive if=3Dfloppy
-check_info_block -drive if=3Dfloppy,driver=3Dnull-co
+check_info_block -drive if=3Dfloppy,driver=3Dnull-co,read-zeroes=3Don
=20
-check_info_block -drive if=3Dide,driver=3Dnull-co
+check_info_block -drive if=3Dide,driver=3Dnull-co,read-zeroes=3Don
 check_info_block -drive if=3Dide,media=3Dcdrom
-check_info_block -drive if=3Dide,driver=3Dnull-co,media=3Dcdrom
+check_info_block -drive if=3Dide,driver=3Dnull-co,read-zeroes=3Don,media=
=3Dcdrom
=20
-check_info_block -drive if=3Dvirtio,driver=3Dnull-co
+check_info_block -drive if=3Dvirtio,driver=3Dnull-co,read-zeroes=3Don
=20
-check_info_block -drive if=3Dpflash,driver=3Dnull-co,size=3D1M
+check_info_block -drive if=3Dpflash,driver=3Dnull-co,read-zeroes=3Don,si=
ze=3D1M
=20
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/186.out b/tests/qemu-iotests/186.out
index 716b01ac3d..5b3504042a 100644
--- a/tests/qemu-iotests/186.out
+++ b/tests/qemu-iotests/186.out
@@ -54,103 +54,103 @@ qdev_id: [not inserted]
=20
 =3D=3D=3D -blockdev/-device=3D<node-name> =3D=3D=3D
=20
-Testing: -blockdev driver=3Dnull-co,node-name=3Dnull -device ide-hd,driv=
e=3Dnull
+Testing: -blockdev driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnull -d=
evice ide-hd,drive=3Dnull
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: null-co:// (null-co)
+null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
     Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
=20
-Testing: -blockdev driver=3Dnull-co,node-name=3Dnull -device ide-hd,driv=
e=3Dnull,id=3Dqdev_id
+Testing: -blockdev driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnull -d=
evice ide-hd,drive=3Dnull,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: null-co:// (null-co)
+null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
     Attached to:      qdev_id
     Cache mode:       writeback
 (qemu) quit
=20
-Testing: -blockdev driver=3Dnull-co,node-name=3Dnull -device scsi-hd,dri=
ve=3Dnull
+Testing: -blockdev driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnull -d=
evice scsi-hd,drive=3Dnull
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: null-co:// (null-co)
+null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
     Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
=20
-Testing: -blockdev driver=3Dnull-co,node-name=3Dnull -device scsi-hd,dri=
ve=3Dnull,id=3Dqdev_id
+Testing: -blockdev driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnull -d=
evice scsi-hd,drive=3Dnull,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: null-co:// (null-co)
+null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
     Attached to:      qdev_id
     Cache mode:       writeback
 (qemu) quit
=20
-Testing: -blockdev driver=3Dnull-co,node-name=3Dnull -device virtio-blk-=
pci,drive=3Dnull
+Testing: -blockdev driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnull -d=
evice virtio-blk-pci,drive=3Dnull
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: null-co:// (null-co)
+null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
     Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
=20
-Testing: -blockdev driver=3Dnull-co,node-name=3Dnull -device virtio-blk-=
pci,drive=3Dnull,id=3Dqdev_id
+Testing: -blockdev driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnull -d=
evice virtio-blk-pci,drive=3Dnull,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: null-co:// (null-co)
+null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
     Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
=20
-Testing: -blockdev driver=3Dnull-co,node-name=3Dnull -device floppy,driv=
e=3Dnull
+Testing: -blockdev driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnull -d=
evice floppy,drive=3Dnull
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: null-co:// (null-co)
+null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
     Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
=20
-Testing: -blockdev driver=3Dnull-co,node-name=3Dnull -device floppy,driv=
e=3Dnull,id=3Dqdev_id
+Testing: -blockdev driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnull -d=
evice floppy,drive=3Dnull,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: null-co:// (null-co)
+null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
     Attached to:      qdev_id
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
=20
-Testing: -blockdev driver=3Dnull-co,node-name=3Dnull -device ide-cd,driv=
e=3Dnull
+Testing: -blockdev driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnull -d=
evice ide-cd,drive=3Dnull
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: null-co:// (null-co)
+null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
     Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
=20
-Testing: -blockdev driver=3Dnull-co,node-name=3Dnull -device ide-cd,driv=
e=3Dnull,id=3Dqdev_id
+Testing: -blockdev driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnull -d=
evice ide-cd,drive=3Dnull,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: null-co:// (null-co)
+null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
     Attached to:      qdev_id
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
=20
-Testing: -blockdev driver=3Dnull-co,node-name=3Dnull -device scsi-cd,dri=
ve=3Dnull
+Testing: -blockdev driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnull -d=
evice scsi-cd,drive=3Dnull
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: null-co:// (null-co)
+null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
     Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
=20
-Testing: -blockdev driver=3Dnull-co,node-name=3Dnull -device scsi-cd,dri=
ve=3Dnull,id=3Dqdev_id
+Testing: -blockdev driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnull -d=
evice scsi-cd,drive=3Dnull,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: null-co:// (null-co)
+null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
     Attached to:      qdev_id
     Removable device: not locked, tray closed
     Cache mode:       writeback
@@ -159,76 +159,76 @@ null: null-co:// (null-co)
=20
 =3D=3D=3D -drive if=3Dnone/-device=3D<node-name> =3D=3D=3D
=20
-Testing: -drive if=3Dnone,driver=3Dnull-co,node-name=3Dnull -device ide-=
hd,drive=3Dnull,id=3Dqdev_id
+Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3D=
null -device ide-hd,drive=3Dnull,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Removable device: not locked, tray closed
     Cache mode:       writeback
=20
-null: null-co:// (null-co)
+null: json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      qdev_id
     Cache mode:       writeback
 (qemu) quit
=20
-Testing: -drive if=3Dnone,driver=3Dnull-co,node-name=3Dnull -device scsi=
-hd,drive=3Dnull,id=3Dqdev_id
+Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3D=
null -device scsi-hd,drive=3Dnull,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Removable device: not locked, tray closed
     Cache mode:       writeback
=20
-null: null-co:// (null-co)
+null: json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      qdev_id
     Cache mode:       writeback
 (qemu) quit
=20
-Testing: -drive if=3Dnone,driver=3Dnull-co,node-name=3Dnull -device virt=
io-blk-pci,drive=3Dnull,id=3Dqdev_id
+Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3D=
null -device virtio-blk-pci,drive=3Dnull,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Removable device: not locked, tray closed
     Cache mode:       writeback
=20
-null: null-co:// (null-co)
+null: json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
=20
-Testing: -drive if=3Dnone,driver=3Dnull-co,node-name=3Dnull -device flop=
py,drive=3Dnull,id=3Dqdev_id
+Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3D=
null -device floppy,drive=3Dnull,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Removable device: not locked, tray closed
     Cache mode:       writeback
=20
-null: null-co:// (null-co)
+null: json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      qdev_id
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
=20
-Testing: -drive if=3Dnone,driver=3Dnull-co,node-name=3Dnull -device ide-=
cd,drive=3Dnull,id=3Dqdev_id
+Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3D=
null -device ide-cd,drive=3Dnull,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Removable device: not locked, tray closed
     Cache mode:       writeback
=20
-null: null-co:// (null-co)
+null: json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      qdev_id
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
=20
-Testing: -drive if=3Dnone,driver=3Dnull-co,node-name=3Dnull -device scsi=
-cd,drive=3Dnull,id=3Dqdev_id
+Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3D=
null -device scsi-cd,drive=3Dnull,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Removable device: not locked, tray closed
     Cache mode:       writeback
=20
-null: null-co:// (null-co)
+null: json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      qdev_id
     Removable device: not locked, tray closed
     Cache mode:       writeback
@@ -237,103 +237,103 @@ null: null-co:// (null-co)
=20
 =3D=3D=3D -drive if=3Dnone/-device=3D<bb-name> (with medium) =3D=3D=3D
=20
-Testing: -drive if=3Dnone,driver=3Dnull-co,node-name=3Dnull -device ide-=
hd,drive=3Dnone0
+Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3D=
null -device ide-hd,drive=3Dnone0
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
=20
-Testing: -drive if=3Dnone,driver=3Dnull-co,node-name=3Dnull -device ide-=
hd,drive=3Dnone0,id=3Dqdev_id
+Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3D=
null -device ide-hd,drive=3Dnone0,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      qdev_id
     Cache mode:       writeback
 (qemu) quit
=20
-Testing: -drive if=3Dnone,driver=3Dnull-co,node-name=3Dnull -device scsi=
-hd,drive=3Dnone0
+Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3D=
null -device scsi-hd,drive=3Dnone0
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
=20
-Testing: -drive if=3Dnone,driver=3Dnull-co,node-name=3Dnull -device scsi=
-hd,drive=3Dnone0,id=3Dqdev_id
+Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3D=
null -device scsi-hd,drive=3Dnone0,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      qdev_id
     Cache mode:       writeback
 (qemu) quit
=20
-Testing: -drive if=3Dnone,driver=3Dnull-co,node-name=3Dnull -device virt=
io-blk-pci,drive=3Dnone0
+Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3D=
null -device virtio-blk-pci,drive=3Dnone0
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
=20
-Testing: -drive if=3Dnone,driver=3Dnull-co,node-name=3Dnull -device virt=
io-blk-pci,drive=3Dnone0,id=3Dqdev_id
+Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3D=
null -device virtio-blk-pci,drive=3Dnone0,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
=20
-Testing: -drive if=3Dnone,driver=3Dnull-co,node-name=3Dnull -device flop=
py,drive=3Dnone0
+Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3D=
null -device floppy,drive=3Dnone0
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
=20
-Testing: -drive if=3Dnone,driver=3Dnull-co,node-name=3Dnull -device flop=
py,drive=3Dnone0,id=3Dqdev_id
+Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3D=
null -device floppy,drive=3Dnone0,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      qdev_id
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
=20
-Testing: -drive if=3Dnone,driver=3Dnull-co,node-name=3Dnull -device ide-=
cd,drive=3Dnone0
+Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3D=
null -device ide-cd,drive=3Dnone0
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
=20
-Testing: -drive if=3Dnone,driver=3Dnull-co,node-name=3Dnull -device ide-=
cd,drive=3Dnone0,id=3Dqdev_id
+Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3D=
null -device ide-cd,drive=3Dnone0,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      qdev_id
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
=20
-Testing: -drive if=3Dnone,driver=3Dnull-co,node-name=3Dnull -device scsi=
-cd,drive=3Dnone0
+Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3D=
null -device scsi-cd,drive=3Dnone0
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): null-co:// (null-co)
+none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
     Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
=20
-Testing: -drive if=3Dnone,driver=3Dnull-co,node-name=3Dnull -device scsi=
-cd,drive=3Dnone0,id=3Dqdev_id
+Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3D=
null -device scsi-cd,drive=3Dnone0,id=3Dqdev_id
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
=20
-Testing: -drive if=3Dfloppy,driver=3Dnull-co
+Testing: -drive if=3Dfloppy,driver=3Dnull-co,read-zeroes=3Don
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-floppy0 (NODE_NAME): null-co:// (null-co)
+floppy0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co"} (nu=
ll-co)
     Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
=20
-Testing: -drive if=3Dide,driver=3Dnull-co
+Testing: -drive if=3Dide,driver=3Dnull-co,read-zeroes=3Don
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-ide0-hd0 (NODE_NAME): null-co:// (null-co)
+ide0-hd0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co"} (n=
ull-co)
     Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
@@ -433,27 +433,27 @@ ide0-cd0: [not inserted]
     Removable device: not locked, tray closed
 (qemu) quit
=20
-Testing: -drive if=3Dide,driver=3Dnull-co,media=3Dcdrom
+Testing: -drive if=3Dide,driver=3Dnull-co,read-zeroes=3Don,media=3Dcdrom
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-ide0-cd0 (NODE_NAME): null-co:// (null-co, read-only)
+ide0-cd0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co"} (n=
ull-co, read-only)
     Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
=20
-Testing: -drive if=3Dvirtio,driver=3Dnull-co
+Testing: -drive if=3Dvirtio,driver=3Dnull-co,read-zeroes=3Don
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-virtio0 (NODE_NAME): null-co:// (null-co)
+virtio0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co"} (nu=
ll-co)
     Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
=20
-Testing: -drive if=3Dpflash,driver=3Dnull-co,size=3D1M
+Testing: -drive if=3Dpflash,driver=3Dnull-co,read-zeroes=3Don,size=3D1M
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-pflash0 (NODE_NAME): json:{"driver": "null-co", "size": "1M"} (null-co)
+pflash0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co", "si=
ze": "1M"} (null-co)
     Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
diff --git a/tests/qemu-iotests/227 b/tests/qemu-iotests/227
index bdd727a721..637d7c3726 100755
--- a/tests/qemu-iotests/227
+++ b/tests/qemu-iotests/227
@@ -57,7 +57,7 @@ echo
 echo '=3D=3D=3D blockstats with -drive if=3Dvirtio =3D=3D=3D'
 echo
=20
-run_qemu -drive driver=3Dnull-co,if=3Dvirtio <<EOF
+run_qemu -drive driver=3Dnull-co,read-zeroes=3Don,if=3Dvirtio <<EOF
 { "execute": "qmp_capabilities" }
 { "execute": "query-blockstats"}
 { "execute": "quit" }
@@ -87,7 +87,7 @@ echo
 echo '=3D=3D=3D blockstats with -blockdev and -device =3D=3D=3D'
 echo
=20
-run_qemu -blockdev driver=3Dnull-co,node-name=3Dnull -device virtio-blk,=
drive=3Dnull,id=3Dvirtio0 <<EOF
+run_qemu -blockdev driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnull -d=
evice virtio-blk,drive=3Dnull,id=3Dvirtio0 <<EOF
 { "execute": "qmp_capabilities" }
 { "execute": "query-blockstats"}
 { "execute": "quit" }
diff --git a/tests/qemu-iotests/227.out b/tests/qemu-iotests/227.out
index e77efaf4cf..3dd3ca5708 100644
--- a/tests/qemu-iotests/227.out
+++ b/tests/qemu-iotests/227.out
@@ -2,7 +2,7 @@ QA output created by 227
=20
 =3D=3D=3D blockstats with -drive if=3Dvirtio =3D=3D=3D
=20
-Testing: -drive driver=3Dnull-co,if=3Dvirtio
+Testing: -drive driver=3Dnull-co,read-zeroes=3Don,if=3Dvirtio
 {
     QMP_VERSION
 }
@@ -150,7 +150,7 @@ Testing: -blockdev driver=3Dnull-co,node-name=3Dnull
=20
 =3D=3D=3D blockstats with -blockdev and -device =3D=3D=3D
=20
-Testing: -blockdev driver=3Dnull-co,node-name=3Dnull -device virtio-blk,=
drive=3Dnull,id=3Dvirtio0
+Testing: -blockdev driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnull -d=
evice virtio-blk,drive=3Dnull,id=3Dvirtio0
 {
     QMP_VERSION
 }
diff --git a/tests/qemu-iotests/238 b/tests/qemu-iotests/238
index 1c0a46fa90..08bc7e6b4b 100755
--- a/tests/qemu-iotests/238
+++ b/tests/qemu-iotests/238
@@ -31,7 +31,7 @@ else:
 vm =3D iotests.VM()
 vm.launch()
=20
-log(vm.qmp('blockdev-add', node_name=3D'hd0', driver=3D'null-co'))
+log(vm.qmp('blockdev-add', node_name=3D'hd0', driver=3D'null-co', read_z=
eroes=3DTrue))
 log(vm.qmp('object-add', qom_type=3D'iothread', id=3D'iothread0'))
 log(vm.qmp('device_add', id=3D'scsi0', driver=3Dvirtio_scsi_device, ioth=
read=3D'iothread0'))
 log(vm.qmp('device_add', id=3D'scsi-hd0', driver=3D'scsi-hd', drive=3D'h=
d0'))
diff --git a/tests/qemu-iotests/240 b/tests/qemu-iotests/240
index 5be6b9c0f7..f73bc07d80 100755
--- a/tests/qemu-iotests/240
+++ b/tests/qemu-iotests/240
@@ -76,7 +76,7 @@ echo
=20
 run_qemu <<EOF
 { "execute": "qmp_capabilities" }
-{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "node-na=
me": "hd0"}}
+{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "read-ze=
roes": true, "node-name": "hd0"}}
 { "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "=
iothread0"}}
 { "execute": "device_add", "arguments": {"id": "scsi0", "driver": "${vir=
tio_scsi}", "iothread": "iothread0"}}
 { "execute": "device_add", "arguments": {"id": "scsi-hd0", "driver": "sc=
si-hd", "drive": "hd0"}}
@@ -94,7 +94,7 @@ echo
=20
 run_qemu <<EOF
 { "execute": "qmp_capabilities" }
-{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "node-na=
me": "hd0", "read-only": true}}
+{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "read-ze=
roes": true, "node-name": "hd0", "read-only": true}}
 { "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "=
iothread0"}}
 { "execute": "device_add", "arguments": {"id": "scsi0", "driver": "${vir=
tio_scsi}", "iothread": "iothread0"}}
 { "execute": "device_add", "arguments": {"id": "scsi-hd0", "driver": "sc=
si-hd", "drive": "hd0"}}
@@ -112,7 +112,7 @@ echo
=20
 run_qemu <<EOF
 { "execute": "qmp_capabilities" }
-{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "node-na=
me": "hd0", "read-only": true}}
+{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "read-ze=
roes": true, "node-name": "hd0", "read-only": true}}
 { "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "=
iothread0"}}
 { "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "=
iothread1"}}
 { "execute": "device_add", "arguments": {"id": "scsi0", "driver": "${vir=
tio_scsi}", "iothread": "iothread0"}}
@@ -134,7 +134,7 @@ echo
=20
 run_qemu <<EOF
 { "execute": "qmp_capabilities" }
-{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "node-na=
me": "hd0", "read-only": true}}
+{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "read-ze=
roes": true, "node-name": "hd0", "read-only": true}}
 { "execute": "nbd-server-start", "arguments": {"addr":{"type":"unix","da=
ta":{"path":"$TEST_DIR/nbd"}}}}
 { "execute": "nbd-server-add", "arguments": {"device":"hd0"}}
 { "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "=
iothread0"}}
--=20
2.20.1


