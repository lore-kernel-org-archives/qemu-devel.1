Received: from eggs.gnu.org ([2001:4830:134:3::10]:55357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3Ot2-0006qE-8r
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 12:34:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3Ot1-0006as-2J
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 12:34:20 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  3 Apr 2018 18:33:58 +0200
Message-Id: <20180403163400.6307-8-kwolf@redhat.com>
In-Reply-To: <20180403163400.6307-1-kwolf@redhat.com>
References: <20180403163400.6307-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 7/9] iotests: Test preallocated truncate of 2G
 image
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

From: Max Reitz <mreitz@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20180228131315.30194-3-mreitz@redhat.com
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/106     | 24 ++++++++++++++++++++++++
 tests/qemu-iotests/106.out | 10 ++++++++++
 2 files changed, 34 insertions(+)

diff --git a/tests/qemu-iotests/106 b/tests/qemu-iotests/106
index bfe71f4e60..5e51f88a78 100755
--- a/tests/qemu-iotests/106
+++ b/tests/qemu-iotests/106
@@ -86,6 +86,30 @@ for growth_mode in falloc full off; do
     $QEMU_IMG resize -f "$IMGFMT" --shrink --preallocation=3D$growth_mod=
e "$TEST_IMG" -${GROWTH_SIZE}K
 done
=20
+echo
+echo '=3D=3D=3D Testing image growth on 2G empty image =3D=3D=3D'
+
+for growth_mode in falloc full; do
+    echo
+    echo "--- growth_mode=3D$growth_mode ---"
+
+    # Maybe we want to do an lseek() to the end of the file before the
+    # preallocation; if the file has a length of 2 GB, that would
+    # return an integer that overflows to negative when put into a
+    # plain int.  We should use the correct type for the result, and
+    # this tests we do.
+
+    _make_test_img 2G
+    $QEMU_IMG resize -f "$IMGFMT" --preallocation=3D$growth_mode "$TEST_=
IMG" +${GROWTH_SIZE}K
+
+    actual_size=3D$($QEMU_IMG info -f "$IMGFMT" "$TEST_IMG" | grep 'disk=
 size')
+    actual_size=3D$(echo "$actual_size" | sed -e 's/^[^0-9]*\([0-9]\+\).=
*$/\1/')
+
+    if [ $actual_size -lt $GROWTH_SIZE ]; then
+        echo "ERROR: Image should have at least ${GROWTH_SIZE}K, but has=
 ${actual_size}K"
+    fi
+done
+
 # success, all done
 echo '*** done'
 rm -f $seq.full
diff --git a/tests/qemu-iotests/106.out b/tests/qemu-iotests/106.out
index 0a42312301..c459957660 100644
--- a/tests/qemu-iotests/106.out
+++ b/tests/qemu-iotests/106.out
@@ -47,4 +47,14 @@ qemu-img: Preallocation can only be used for growing i=
mages
=20
 --- growth_mode=3Doff ---
 Image resized.
+
+=3D=3D=3D Testing image growth on 2G empty image =3D=3D=3D
+
+--- growth_mode=3Dfalloc ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2147483648
+Image resized.
+
+--- growth_mode=3Dfull ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2147483648
+Image resized.
 *** done
--=20
2.13.6
