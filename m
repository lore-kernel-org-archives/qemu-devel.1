Received: from eggs.gnu.org ([209.51.188.92]:40209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gmFqu-0007qQ-Be
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:33:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gmFqs-00087u-Pw
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:33:48 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 23 Jan 2019 10:33:23 +0000
Message-Id: <20190123103323.4516-3-stefanha@redhat.com>
In-Reply-To: <20190123103323.4516-1-stefanha@redhat.com>
References: <20190123103323.4516-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/2] iotests: add LUKS payload overhead to
 178 qemu-img measure test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Daniel Berrange <berrange@redhat.com>, qemu-block@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The previous patch includes the LUKS payload overhead into the qemu-img
measure calculation for qcow2.  Update qemu-iotests 178 to exercise this
new code path.

Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/178           |  8 ++++++++
 tests/qemu-iotests/178.out.qcow2 | 24 ++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/tests/qemu-iotests/178 b/tests/qemu-iotests/178
index 3f4b4a4564..23eb017ea1 100755
--- a/tests/qemu-iotests/178
+++ b/tests/qemu-iotests/178
@@ -142,6 +142,14 @@ for ofmt in human json; do
             # The backing file doesn't need to exist :)
             $QEMU_IMG measure --output=3D$ofmt -o backing_file=3Dx \
                               -f "$fmt" -O "$IMGFMT" "$TEST_IMG"
+
+            echo
+            echo "=3D=3D $fmt input image and LUKS encryption =3D=3D"
+            echo
+            $QEMU_IMG measure --output=3D$ofmt \
+                              --object secret,id=3Dsec0,data=3Dbase \
+                              -o encrypt.format=3Dluks,encrypt.key-secre=
t=3Dsec0 \
+                              -f "$fmt" -O "$IMGFMT" "$TEST_IMG"
         fi
=20
         echo
diff --git a/tests/qemu-iotests/178.out.qcow2 b/tests/qemu-iotests/178.ou=
t.qcow2
index d42d4a4597..55a8dc926f 100644
--- a/tests/qemu-iotests/178.out.qcow2
+++ b/tests/qemu-iotests/178.out.qcow2
@@ -68,6 +68,11 @@ converted image file size in bytes: 458752
 required size: 1074135040
 fully allocated size: 1074135040
=20
+=3D=3D qcow2 input image and LUKS encryption =3D=3D
+
+required size: 2686976
+fully allocated size: 1076232192
+
 =3D=3D qcow2 input image and preallocation (human) =3D=3D
=20
 required size: 1074135040
@@ -114,6 +119,11 @@ converted image file size in bytes: 524288
 required size: 1074135040
 fully allocated size: 1074135040
=20
+=3D=3D raw input image and LUKS encryption =3D=3D
+
+required size: 2686976
+fully allocated size: 1076232192
+
 =3D=3D raw input image and preallocation (human) =3D=3D
=20
 required size: 1074135040
@@ -205,6 +215,13 @@ converted image file size in bytes: 458752
     "fully-allocated": 1074135040
 }
=20
+=3D=3D qcow2 input image and LUKS encryption =3D=3D
+
+{
+    "required": 2686976,
+    "fully-allocated": 1076232192
+}
+
 =3D=3D qcow2 input image and preallocation (json) =3D=3D
=20
 {
@@ -263,6 +280,13 @@ converted image file size in bytes: 524288
     "fully-allocated": 1074135040
 }
=20
+=3D=3D raw input image and LUKS encryption =3D=3D
+
+{
+    "required": 2686976,
+    "fully-allocated": 1076232192
+}
+
 =3D=3D raw input image and preallocation (json) =3D=3D
=20
 {
--=20
2.20.1
