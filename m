Received: from eggs.gnu.org ([2001:4830:134:3::10]:45542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f0TEV-00035l-5S
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f0TEU-0004Bq-9I
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:36:23 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 26 Mar 2018 16:35:52 +0200
Message-Id: <20180326143600.7724-12-kwolf@redhat.com>
In-Reply-To: <20180326143600.7724-1-kwolf@redhat.com>
References: <20180326143600.7724-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/19] qemu-iotests: Enable 025 for luks
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

We want to test resizing even for luks. The only change that is needed
is to explicitly zero out new space for luks because it's undefined.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/qemu-iotests/025 | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/025 b/tests/qemu-iotests/025
index f5e672e6b3..70dd5f10aa 100755
--- a/tests/qemu-iotests/025
+++ b/tests/qemu-iotests/025
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 . ./common.pattern
=20
-_supported_fmt raw qcow2 qed
+_supported_fmt raw qcow2 qed luks
 _supported_proto file sheepdog rbd nfs
 _supported_os Linux
=20
@@ -62,6 +62,13 @@ length
 EOF
 _check_test_img
=20
+# bdrv_truncate() doesn't zero the new space, so we need to do that expl=
icitly.
+# We still want to test automatic zeroing for other formats even though
+# bdrv_truncate() doesn't guarantee it.
+if [ "$IMGFMT" =3D=3D "luks" ]; then
+    $QEMU_IO -c "write -z $small_size $((big_size - small_size))" "$TEST=
_IMG" > /dev/null
+fi
+
 echo
 echo "=3D=3D=3D Verifying image size after reopen"
 $QEMU_IO -c "length" "$TEST_IMG"
--=20
2.13.6
