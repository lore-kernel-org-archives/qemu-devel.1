Received: from eggs.gnu.org ([2001:4830:134:3::10]:55510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eReHr-0004Ow-Ah
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:19:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eReHq-0006Ao-EK
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:19:55 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 20 Dec 2017 14:19:28 +0100
Message-Id: <20171220131939.27543-4-kwolf@redhat.com>
In-Reply-To: <20171220131939.27543-1-kwolf@redhat.com>
References: <20171220131939.27543-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/14] iotests: fix 197 for vpc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: John Snow <jsnow@redhat.com>

VPC has some difficulty creating geometries of particular size.
However, we can indeed force it to use a literal one, so let's
do that for the sake of test 197, which is testing some specific
offsets.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
---
 tests/qemu-iotests/197           | 4 ++++
 tests/qemu-iotests/common.filter | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
index 887eb4f496..5e869fe2b7 100755
--- a/tests/qemu-iotests/197
+++ b/tests/qemu-iotests/197
@@ -60,6 +60,10 @@ echo '=3D=3D=3D Copy-on-read =3D=3D=3D'
 echo
=20
 # Prep the images
+# VPC rounds image sizes to a specific geometry, force a specific size.
+if [ "$IMGFMT" =3D "vpc" ]; then
+    IMGOPTS=3D$(_optstr_add "$IMGOPTS" "force_size")
+fi
 _make_test_img 4G
 $QEMU_IO -c "write -P 55 3G 1k" "$TEST_IMG" | _filter_qemu_io
 IMGPROTO=3Dfile IMGFMT=3Dqcow2 IMGOPTS=3D TEST_IMG_FILE=3D"$TEST_WRAP" \
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common=
.filter
index d9237799e9..f08248bfd9 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -134,7 +134,8 @@ _filter_img_create()
         -e "s# log_size=3D[0-9]\\+##g" \
         -e "s# refcount_bits=3D[0-9]\\+##g" \
         -e "s# key-secret=3D[a-zA-Z0-9]\\+##g" \
-        -e "s# iter-time=3D[0-9]\\+##g"
+        -e "s# iter-time=3D[0-9]\\+##g" \
+        -e "s# force_size=3D\\(on\\|off\\)##g"
 }
=20
 _filter_img_info()
--=20
2.13.6
