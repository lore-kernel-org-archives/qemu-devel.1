Received: from eggs.gnu.org ([2001:4830:134:3::10]:43823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ez1Ua-0003wX-Fs
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 10:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ez1UX-0007Jz-84
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 10:47:00 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:38303)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1ez1UW-00070R-PN
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 10:46:57 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 22 Mar 2018 16:45:51 +0200
Message-Id: <e81480c3296f69b32527170890249e0d7731df93.1521729843.git.berto@igalia.com>
In-Reply-To: <cover.1521729843.git.berto@igalia.com>
References: <cover.1521729843.git.berto@igalia.com>
In-Reply-To: <cover.1521729843.git.berto@igalia.com>
References: <cover.1521729843.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-2.12 v4 2/2] iotests: Update 186 after
 commit ac64273c66ab136c44043259162
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Commit ac64273c66ab136c44 modified the output of iotest 186, changing
the QOM path of floppy drives from /machine/unattached/device[17] to
/machine/unattached/device[13].

Instead of updating the test output to reflect this change, this patch
adds a new filter that hides all QOM paths from the 'Attached to:'
line of the 'info block' command.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/qemu-iotests/186           |  2 +-
 tests/qemu-iotests/186.out       | 56 ++++++++++++++++++++--------------------
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
 
@@ -23,7 +23,7 @@ Testing: -device ide-cd
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 /machine/peripheral-anon/device[1]: [not inserted]
-    Attached to:      /machine/peripheral-anon/device[1]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
 
@@ -39,7 +39,7 @@ Testing: -device scsi-cd
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 /machine/peripheral-anon/device[1]: [not inserted]
-    Attached to:      /machine/peripheral-anon/device[1]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
 
@@ -58,7 +58,7 @@ Testing: -blockdev driver=null-co,node-name=null -device ide-hd,drive=null
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 null: null-co:// (null-co)
-    Attached to:      /machine/peripheral-anon/device[1]
+    Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
 
@@ -74,7 +74,7 @@ Testing: -blockdev driver=null-co,node-name=null -device scsi-hd,drive=null
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 null: null-co:// (null-co)
-    Attached to:      /machine/peripheral-anon/device[1]
+    Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
 
@@ -90,7 +90,7 @@ Testing: -blockdev driver=null-co,node-name=null -device virtio-blk-pci,drive=nu
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 null: null-co:// (null-co)
-    Attached to:      /machine/peripheral-anon/device[1]/virtio-backend
+    Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
 
@@ -98,7 +98,7 @@ Testing: -blockdev driver=null-co,node-name=null -device virtio-blk-pci,drive=nu
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 null: null-co:// (null-co)
-    Attached to:      /machine/peripheral/qdev_id/virtio-backend
+    Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
 
@@ -106,7 +106,7 @@ Testing: -blockdev driver=null-co,node-name=null -device floppy,drive=null
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 null: null-co:// (null-co)
-    Attached to:      /machine/peripheral-anon/device[1]
+    Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
@@ -124,7 +124,7 @@ Testing: -blockdev driver=null-co,node-name=null -device ide-cd,drive=null
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 null: null-co:// (null-co)
-    Attached to:      /machine/peripheral-anon/device[1]
+    Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
@@ -142,7 +142,7 @@ Testing: -blockdev driver=null-co,node-name=null -device scsi-cd,drive=null
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
 
 null: null-co:// (null-co)
-    Attached to:      /machine/peripheral/qdev_id/virtio-backend
+    Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
 
@@ -241,7 +241,7 @@ Testing: -drive if=none,driver=null-co,node-name=null -device ide-hd,drive=none0
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 none0 (null): null-co:// (null-co)
-    Attached to:      /machine/peripheral-anon/device[1]
+    Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
 
@@ -257,7 +257,7 @@ Testing: -drive if=none,driver=null-co,node-name=null -device scsi-hd,drive=none
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 none0 (null): null-co:// (null-co)
-    Attached to:      /machine/peripheral-anon/device[1]
+    Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
 
@@ -273,7 +273,7 @@ Testing: -drive if=none,driver=null-co,node-name=null -device virtio-blk-pci,dri
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 none0 (null): null-co:// (null-co)
-    Attached to:      /machine/peripheral-anon/device[1]/virtio-backend
+    Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
 
@@ -281,7 +281,7 @@ Testing: -drive if=none,driver=null-co,node-name=null -device virtio-blk-pci,dri
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 none0 (null): null-co:// (null-co)
-    Attached to:      /machine/peripheral/qdev_id/virtio-backend
+    Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
 
@@ -289,7 +289,7 @@ Testing: -drive if=none,driver=null-co,node-name=null -device floppy,drive=none0
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 none0 (null): null-co:// (null-co)
-    Attached to:      /machine/peripheral-anon/device[1]
+    Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
@@ -307,7 +307,7 @@ Testing: -drive if=none,driver=null-co,node-name=null -device ide-cd,drive=none0
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 none0 (null): null-co:// (null-co)
-    Attached to:      /machine/peripheral-anon/device[1]
+    Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
@@ -325,7 +325,7 @@ Testing: -drive if=none,driver=null-co,node-name=null -device scsi-cd,drive=none
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 none0 (null): null-co:// (null-co)
-    Attached to:      /machine/peripheral-anon/device[1]
+    Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
@@ -353,7 +353,7 @@ Testing: -drive if=none -device floppy,drive=none0
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 none0: [not inserted]
-    Attached to:      /machine/peripheral-anon/device[1]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
 
@@ -369,7 +369,7 @@ Testing: -drive if=none -device ide-cd,drive=none0
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 none0: [not inserted]
-    Attached to:      /machine/peripheral-anon/device[1]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
 
@@ -385,7 +385,7 @@ Testing: -drive if=none -device scsi-cd,drive=none0
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 none0: [not inserted]
-    Attached to:      /machine/peripheral-anon/device[1]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
 
@@ -404,7 +404,7 @@ Testing: -drive if=floppy
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 floppy0: [not inserted]
-    Attached to:      /machine/unattached/device[17]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
 
@@ -412,7 +412,7 @@ Testing: -drive if=floppy,driver=null-co
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 floppy0 (NODE_NAME): null-co:// (null-co)
-    Attached to:      /machine/unattached/device[17]
+    Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
@@ -421,7 +421,7 @@ Testing: -drive if=ide,driver=null-co
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 ide0-hd0 (NODE_NAME): null-co:// (null-co)
-    Attached to:      /machine/unattached/device[18]
+    Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
 
@@ -429,7 +429,7 @@ Testing: -drive if=ide,media=cdrom
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 ide0-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[18]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
 
@@ -437,7 +437,7 @@ Testing: -drive if=ide,driver=null-co,media=cdrom
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 ide0-cd0 (NODE_NAME): null-co:// (null-co, read-only)
-    Attached to:      /machine/unattached/device[18]
+    Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
@@ -446,7 +446,7 @@ Testing: -drive if=virtio,driver=null-co
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 virtio0 (NODE_NAME): null-co:// (null-co)
-    Attached to:      /machine/peripheral-anon/device[1]/virtio-backend
+    Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
 
@@ -454,7 +454,7 @@ Testing: -drive if=pflash,driver=null-co,size=1M
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 pflash0 (NODE_NAME): json:{"driver": "null-co", "size": "1M"} (null-co)
-    Attached to:      /machine/unattached/device[2]
+    Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
 
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index cb2be23340..c5f4bcf578 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -32,6 +32,11 @@ _filter_generated_node_ids()
      sed -re 's/\#block[0-9]{3,}/NODE_NAME/'
 }
 
+_filter_qom_path()
+{
+    sed -e 's#\(Attached to: *\) /.*#\1 PATH#'
+}
+
 # replace occurrences of the actual TEST_DIR value with TEST_DIR
 _filter_testdir()
 {
-- 
2.11.0
