Received: from eggs.gnu.org ([2001:4830:134:3::10]:55338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3Ot1-0006qC-Lu
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 12:34:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3Osz-0006Zj-Tk
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 12:34:19 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  3 Apr 2018 18:33:55 +0200
Message-Id: <20180403163400.6307-5-kwolf@redhat.com>
In-Reply-To: <20180403163400.6307-1-kwolf@redhat.com>
References: <20180403163400.6307-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/9] iotests: Update 186 after commit
 ac64273c66ab136c44043259162
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

Commit ac64273c66ab136c44 modified the output of iotest 186, changing
the QOM path of floppy drives from /machine/unattached/device[17] to
/machine/unattached/device[13].

Instead of updating the test output to reflect this change, this patch
adds a new filter that hides all QOM paths from the 'Attached to:'
line of the 'info block' command.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/186           |  2 +-
 tests/qemu-iotests/186.out       | 56 ++++++++++++++++++++--------------=
------
 tests/qemu-iotests/common.filter |  5 ++++
 3 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/tests/qemu-iotests/186 b/tests/qemu-iotests/186
index 9687243d34..0aa4395a57 100755
--- a/tests/qemu-iotests/186
+++ b/tests/qemu-iotests/186
@@ -64,7 +64,7 @@ function check_info_block()
 {
     echo "info block" |
     do_run_qemu "$@" | _filter_win32 | _filter_hmp | _filter_qemu |
-        _filter_generated_node_ids
+        _filter_generated_node_ids | _filter_qom_path
 }
=20
=20
diff --git a/tests/qemu-iotests/186.out b/tests/qemu-iotests/186.out
index ec75c0fc60..716b01ac3d 100644
--- a/tests/qemu-iotests/186.out
+++ b/tests/qemu-iotests/186.out
@@ -7,7 +7,7 @@ Testing: -device floppy
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 /machine/peripheral-anon/device[1]: [not inserted]
-    Attached to:      /machine/peripheral-anon/device[1]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
=20
@@ -23,7 +23,7 @@ Testing: -device ide-cd
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 /machine/peripheral-anon/device[1]: [not inserted]
-    Attached to:      /machine/peripheral-anon/device[1]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
=20
@@ -39,7 +39,7 @@ Testing: -device scsi-cd
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 /machine/peripheral-anon/device[1]: [not inserted]
-    Attached to:      /machine/peripheral-anon/device[1]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
=20
@@ -58,7 +58,7 @@ Testing: -blockdev driver=3Dnull-co,node-name=3Dnull -d=
evice ide-hd,drive=3Dnull
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 null: null-co:// (null-co)
-    Attached to:      /machine/peripheral-anon/device[1]
+    Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
=20
@@ -74,7 +74,7 @@ Testing: -blockdev driver=3Dnull-co,node-name=3Dnull -d=
evice scsi-hd,drive=3Dnull
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 null: null-co:// (null-co)
-    Attached to:      /machine/peripheral-anon/device[1]
+    Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
=20
@@ -90,7 +90,7 @@ Testing: -blockdev driver=3Dnull-co,node-name=3Dnull -d=
evice virtio-blk-pci,drive=3Dnu
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 null: null-co:// (null-co)
-    Attached to:      /machine/peripheral-anon/device[1]/virtio-backend
+    Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
=20
@@ -98,7 +98,7 @@ Testing: -blockdev driver=3Dnull-co,node-name=3Dnull -d=
evice virtio-blk-pci,drive=3Dnu
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 null: null-co:// (null-co)
-    Attached to:      /machine/peripheral/qdev_id/virtio-backend
+    Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
=20
@@ -106,7 +106,7 @@ Testing: -blockdev driver=3Dnull-co,node-name=3Dnull =
-device floppy,drive=3Dnull
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 null: null-co:// (null-co)
-    Attached to:      /machine/peripheral-anon/device[1]
+    Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
@@ -124,7 +124,7 @@ Testing: -blockdev driver=3Dnull-co,node-name=3Dnull =
-device ide-cd,drive=3Dnull
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 null: null-co:// (null-co)
-    Attached to:      /machine/peripheral-anon/device[1]
+    Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
@@ -142,7 +142,7 @@ Testing: -blockdev driver=3Dnull-co,node-name=3Dnull =
-device scsi-cd,drive=3Dnull
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 null: null-co:// (null-co)
-    Attached to:      /machine/peripheral-anon/device[1]
+    Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
@@ -191,7 +191,7 @@ none0 (null): null-co:// (null-co)
     Cache mode:       writeback
=20
 null: null-co:// (null-co)
-    Attached to:      /machine/peripheral/qdev_id/virtio-backend
+    Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
=20
@@ -241,7 +241,7 @@ Testing: -drive if=3Dnone,driver=3Dnull-co,node-name=3D=
null -device ide-hd,drive=3Dnone0
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 none0 (null): null-co:// (null-co)
-    Attached to:      /machine/peripheral-anon/device[1]
+    Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
=20
@@ -257,7 +257,7 @@ Testing: -drive if=3Dnone,driver=3Dnull-co,node-name=3D=
null -device scsi-hd,drive=3Dnone
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 none0 (null): null-co:// (null-co)
-    Attached to:      /machine/peripheral-anon/device[1]
+    Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
=20
@@ -273,7 +273,7 @@ Testing: -drive if=3Dnone,driver=3Dnull-co,node-name=3D=
null -device virtio-blk-pci,dri
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 none0 (null): null-co:// (null-co)
-    Attached to:      /machine/peripheral-anon/device[1]/virtio-backend
+    Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
=20
@@ -281,7 +281,7 @@ Testing: -drive if=3Dnone,driver=3Dnull-co,node-name=3D=
null -device virtio-blk-pci,dri
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 none0 (null): null-co:// (null-co)
-    Attached to:      /machine/peripheral/qdev_id/virtio-backend
+    Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
=20
@@ -289,7 +289,7 @@ Testing: -drive if=3Dnone,driver=3Dnull-co,node-name=3D=
null -device floppy,drive=3Dnone0
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 none0 (null): null-co:// (null-co)
-    Attached to:      /machine/peripheral-anon/device[1]
+    Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
@@ -307,7 +307,7 @@ Testing: -drive if=3Dnone,driver=3Dnull-co,node-name=3D=
null -device ide-cd,drive=3Dnone0
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 none0 (null): null-co:// (null-co)
-    Attached to:      /machine/peripheral-anon/device[1]
+    Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
@@ -325,7 +325,7 @@ Testing: -drive if=3Dnone,driver=3Dnull-co,node-name=3D=
null -device scsi-cd,drive=3Dnone
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 none0 (null): null-co:// (null-co)
-    Attached to:      /machine/peripheral-anon/device[1]
+    Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
@@ -353,7 +353,7 @@ Testing: -drive if=3Dnone -device floppy,drive=3Dnone=
0
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 none0: [not inserted]
-    Attached to:      /machine/peripheral-anon/device[1]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
=20
@@ -369,7 +369,7 @@ Testing: -drive if=3Dnone -device ide-cd,drive=3Dnone=
0
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 none0: [not inserted]
-    Attached to:      /machine/peripheral-anon/device[1]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
=20
@@ -385,7 +385,7 @@ Testing: -drive if=3Dnone -device scsi-cd,drive=3Dnon=
e0
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 none0: [not inserted]
-    Attached to:      /machine/peripheral-anon/device[1]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
=20
@@ -404,7 +404,7 @@ Testing: -drive if=3Dfloppy
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 floppy0: [not inserted]
-    Attached to:      /machine/unattached/device[17]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
=20
@@ -412,7 +412,7 @@ Testing: -drive if=3Dfloppy,driver=3Dnull-co
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 floppy0 (NODE_NAME): null-co:// (null-co)
-    Attached to:      /machine/unattached/device[17]
+    Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
@@ -421,7 +421,7 @@ Testing: -drive if=3Dide,driver=3Dnull-co
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 ide0-hd0 (NODE_NAME): null-co:// (null-co)
-    Attached to:      /machine/unattached/device[18]
+    Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
=20
@@ -429,7 +429,7 @@ Testing: -drive if=3Dide,media=3Dcdrom
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 ide0-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[18]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
=20
@@ -437,7 +437,7 @@ Testing: -drive if=3Dide,driver=3Dnull-co,media=3Dcdr=
om
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 ide0-cd0 (NODE_NAME): null-co:// (null-co, read-only)
-    Attached to:      /machine/unattached/device[18]
+    Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
@@ -446,7 +446,7 @@ Testing: -drive if=3Dvirtio,driver=3Dnull-co
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 virtio0 (NODE_NAME): null-co:// (null-co)
-    Attached to:      /machine/peripheral-anon/device[1]/virtio-backend
+    Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
=20
@@ -454,7 +454,7 @@ Testing: -drive if=3Dpflash,driver=3Dnull-co,size=3D1=
M
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 pflash0 (NODE_NAME): json:{"driver": "null-co", "size": "1M"} (null-co)
-    Attached to:      /machine/unattached/device[2]
+    Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
=20
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common=
.filter
index cb2be23340..c5f4bcf578 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -32,6 +32,11 @@ _filter_generated_node_ids()
      sed -re 's/\#block[0-9]{3,}/NODE_NAME/'
 }
=20
+_filter_qom_path()
+{
+    sed -e 's#\(Attached to: *\) /.*#\1 PATH#'
+}
+
 # replace occurrences of the actual TEST_DIR value with TEST_DIR
 _filter_testdir()
 {
--=20
2.13.6
