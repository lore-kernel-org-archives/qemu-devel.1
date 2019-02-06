Received: from eggs.gnu.org ([209.51.188.92]:38381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1grTIz-0000Kn-6c
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 14:56:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1grTIy-00086s-31
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 14:56:21 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  6 Feb 2019 20:55:51 +0100
Message-Id: <20190206195551.28893-9-mreitz@redhat.com>
In-Reply-To: <20190206195551.28893-1-mreitz@redhat.com>
References: <20190206195551.28893-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 8/8] iotests: qcow2's encrypt.format is now
 optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>

Remove the encrypt.format option from the two blockdev-add test cases
for encrypted qcow2 images in 087 to explicitly test that this parameter
is now optional.

Additionally, show that explicitly specifying encrypt.format=3Dauto works
just as well, the same for specifying the correct format
(encrypt.format=3Dluks here), and that specifying the wrong format
(encrypt.format=3Daes) results in an error.

While touching this test case, reduce the LUKS iteration time to 10 so
the test stays reasonably fast.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/qemu-iotests/087     | 65 +++++++++++++++++++++++---------------
 tests/qemu-iotests/087.out | 26 ++++++++++++++-
 2 files changed, 64 insertions(+), 27 deletions(-)

diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
index f625887082..78c953ec50 100755
--- a/tests/qemu-iotests/087
+++ b/tests/qemu-iotests/087
@@ -149,7 +149,6 @@ run_qemu <<EOF
           "filename": "$TEST_IMG"
       },
       "encrypt": {
-          "format": "aes",
           "key-secret": "sec0"
       }
     }
@@ -161,34 +160,48 @@ echo
 echo =3D=3D=3D Encrypted image LUKS =3D=3D=3D
 echo
=20
-_make_test_img --object secret,id=3Dsec0,data=3D123456 -o encrypt.format=
=3Dluks,encrypt.key-secret=3Dsec0 $size
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
+    --object secret,id=3Dsec0,data=3D123456 \
+    -o encrypt.format=3Dluks,encrypt.key-secret=3Dsec0,encrypt.iter-time=
=3D10 \
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
+luks_test ''                    # Implicit encrypt.format=3Dauto
+luks_test '"format": "auto",'   # Explicit encrypt.format=3Dauto
+luks_test '"format": "luks",'   # Explicit encrypt.format=3Dluks
+luks_test '"format": "aes",'    # Explicit encrypt.format=3Daes (wrong)
=20
 echo
 echo =3D=3D=3D Missing driver =3D=3D=3D
diff --git a/tests/qemu-iotests/087.out b/tests/qemu-iotests/087.out
index 2d92ea847b..6c1d83519b 100644
--- a/tests/qemu-iotests/087.out
+++ b/tests/qemu-iotests/087.out
@@ -46,7 +46,7 @@ QMP_VERSION
=20
 =3D=3D=3D Encrypted image LUKS =3D=3D=3D
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 encrypt.fo=
rmat=3Dluks encrypt.key-secret=3Dsec0
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 encrypt.fo=
rmat=3Dluks encrypt.key-secret=3Dsec0 encrypt.iter-time=3D10
 Testing:
 QMP_VERSION
 {"return": {}}
@@ -55,6 +55,30 @@ QMP_VERSION
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
=20
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "Header reported 'luks' encr=
yption format but options specify 'aes'"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+
=20
 =3D=3D=3D Missing driver =3D=3D=3D
=20
--=20
2.20.1
