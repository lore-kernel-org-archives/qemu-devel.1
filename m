Received: from eggs.gnu.org ([2001:4830:134:3::10]:43958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSTnp-00021v-Bd
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSTno-0008WT-BP
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:52:37 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 11 Jun 2018 22:52:03 +0200
Message-Id: <20180611205203.2624-11-mreitz@redhat.com>
In-Reply-To: <20180611205203.2624-1-mreitz@redhat.com>
References: <20180611205203.2624-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 10/10] iotests: qcow2's encrypt.format is
 now optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>

Remove the encrypt.format option from the two blockdev-add test cases
for encrypted qcow2 images in 087 to explicitly test that this parameter
is now optional.

Additionally, show that explicitly specifying encrypt.format=auto works
just as well, the same for specifying the correct format
(encrypt.format=luks here), and that specifying the wrong format
(encrypt.format=aes) results in an error.

While touching this test case, reduce the LUKS iteration time to 10 so
the test stays reasonably fast.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/087     | 65 +++++++++++++++++++++++---------------
 tests/qemu-iotests/087.out | 26 ++++++++++++++-
 2 files changed, 64 insertions(+), 27 deletions(-)

diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
index 2561a14456..a267adf568 100755
--- a/tests/qemu-iotests/087
+++ b/tests/qemu-iotests/087
@@ -150,7 +150,6 @@ run_qemu <<EOF
           "filename": "$TEST_IMG"
       },
       "encrypt": {
-          "format": "aes",
           "key-secret": "sec0"
       }
     }
@@ -162,34 +161,48 @@ echo
 echo === Encrypted image LUKS ===
 echo
 
-_make_test_img --object secret,id=sec0,data=123456 -o encrypt.format=luks,encrypt.key-secret=sec0 $size
-run_qemu <<EOF
-{ "execute": "qmp_capabilities" }
-{ "execute": "object-add",
-  "arguments": {
-      "qom-type": "secret",
-      "id": "sec0",
-      "props": {
-          "data": "123456"
-      }
-  }
-}
-{ "execute": "blockdev-add",
-  "arguments": {
-      "driver": "$IMGFMT",
-      "node-name": "disk",
-      "file": {
-          "driver": "file",
-          "filename": "$TEST_IMG"
-      },
-      "encrypt": {
-        "format": "luks",
-        "key-secret": "sec0"
+_make_test_img \
+    --object secret,id=sec0,data=123456 \
+    -o encrypt.format=luks,encrypt.key-secret=sec0,encrypt.iter-time=10 \
+    $size
+
+# Adds the qcow2+LUKS image via blockdev-add.
+# First parameter: Optional entry for the 'encrypt' option dict
+function luks_test()
+{
+    run_qemu <<EOF
+    { "execute": "qmp_capabilities" }
+    { "execute": "object-add",
+      "arguments": {
+          "qom-type": "secret",
+          "id": "sec0",
+          "props": {
+              "data": "123456"
+          }
       }
     }
-  }
-{ "execute": "quit" }
+    { "execute": "blockdev-add",
+      "arguments": {
+          "driver": "$IMGFMT",
+          "node-name": "disk",
+          "file": {
+              "driver": "file",
+              "filename": "$TEST_IMG"
+          },
+          "encrypt": {
+            $1
+            "key-secret": "sec0"
+          }
+        }
+      }
+    { "execute": "quit" }
 EOF
+}
+
+luks_test ''                    # Implicit encrypt.format=auto
+luks_test '"format": "auto",'   # Explicit encrypt.format=auto
+luks_test '"format": "luks",'   # Explicit encrypt.format=luks
+luks_test '"format": "aes",'    # Explicit encrypt.format=aes (wrong)
 
 echo
 echo === Missing driver ===
diff --git a/tests/qemu-iotests/087.out b/tests/qemu-iotests/087.out
index b1318c6ed6..40b0a96ba7 100644
--- a/tests/qemu-iotests/087.out
+++ b/tests/qemu-iotests/087.out
@@ -46,7 +46,7 @@ QMP_VERSION
 
 === Encrypted image LUKS ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encrypt.format=luks encrypt.key-secret=sec0
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10
 Testing:
 QMP_VERSION
 {"return": {}}
@@ -55,6 +55,30 @@ QMP_VERSION
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "Header reported 'luks' encryption format but options specify 'aes'"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
 
 === Missing driver ===
 
-- 
2.17.1
