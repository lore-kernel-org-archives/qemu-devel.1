Received: from eggs.gnu.org ([2001:4830:134:3::10]:50342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVcVX-0002we-Af
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:42:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVcVW-0002tE-Hl
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:42:11 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 13 Jul 2017 13:41:35 +0200
Message-Id: <1499946095-8224-10-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499946095-8224-1-git-send-email-kwolf@redhat.com>
References: <1499946095-8224-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 9/9] qemu-iotests: Test unplug of -device
 without drive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

This caused an assertion failure until recently because the BlockBackend
would be detached on unplug, but was in fact never attached in the first
place. Add a regression test.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/067     | 13 +++++++++++++
 tests/qemu-iotests/067.out | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/tests/qemu-iotests/067 b/tests/qemu-iotests/067
index 38d23fc..5d4ca4b 100755
--- a/tests/qemu-iotests/067
+++ b/tests/qemu-iotests/067
@@ -137,6 +137,19 @@ run_qemu <<EOF
 { "execute": "quit" }
 EOF
 
+echo
+echo === Empty drive with -device and device_del ===
+echo
+
+run_qemu -device virtio-scsi-pci -device scsi-cd,id=cd0 <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "query-block" }
+{ "execute": "device_del", "arguments": { "id": "cd0" } }
+{ "execute": "system_reset" }
+{ "execute": "query-block" }
+{ "execute": "quit" }
+EOF
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/067.out b/tests/qemu-iotests/067.out
index e3c4496..bd70557 100644
--- a/tests/qemu-iotests/067.out
+++ b/tests/qemu-iotests/067.out
@@ -416,4 +416,43 @@ Testing:
     "return": {
     }
 }
+
+=== Empty drive with -device and device_del ===
+
+Testing: -device virtio-scsi-pci -device scsi-cd,id=cd0
+{
+    QMP_VERSION
+}
+{
+    "return": {
+    }
+}
+{
+    "return": [
+        {
+            "device": "",
+            "locked": false,
+            "removable": true,
+            "qdev": "cd0",
+            "tray_open": false,
+            "type": "unknown"
+        }
+    ]
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "return": [
+    ]
+}
+{
+    "return": {
+    }
+}
 *** done
-- 
1.8.3.1
