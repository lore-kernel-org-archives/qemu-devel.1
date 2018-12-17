Received: from eggs.gnu.org ([2001:4830:134:3::10]:33829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gZ1d0-0007VE-JM
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:44:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gZ1cz-0006QX-Hc
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:44:46 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 17 Dec 2018 23:43:37 +0100
Message-Id: <20181217224348.14922-21-mreitz@redhat.com>
In-Reply-To: <20181217224348.14922-1-mreitz@redhat.com>
References: <20181217224348.14922-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v12 20/31] iotests: Add quorum case to test 110
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>

Test 110 tests relative backing filenames for complex BDS trees.  Now
that the originally supposedly failing test passes, let us add a new
failing test: Quorum can never work automatically (without detecting
whether all child nodes have the same base directory, but that would be
rather inconsistent behavior).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 tests/qemu-iotests/110     | 26 ++++++++++++++++++++++++++
 tests/qemu-iotests/110.out |  7 +++++++
 2 files changed, 33 insertions(+)

diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
index 3e9d72d302..185ad5437e 100755
--- a/tests/qemu-iotests/110
+++ b/tests/qemu-iotests/110
@@ -29,6 +29,7 @@ status=3D1	# failure is the default!
 _cleanup()
 {
 	_cleanup_test_img
+        rm -f "$TEST_IMG.copy"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
@@ -86,6 +87,31 @@ echo
 # omit the image size; it should work anyway
 _make_test_img -b "$TEST_IMG_REL.base"
=20
+echo
+echo '=3D=3D=3D Nodes without a common directory =3D=3D=3D'
+echo
+
+cp "$TEST_IMG" "$TEST_IMG.copy"
+
+# Should inform us that the actual path of the backing file cannot be de=
termined
+TEST_IMG=3D"json:{
+    'driver': '$IMGFMT',
+    'file': {
+        'driver': 'quorum',
+        'vote-threshold': 1,
+        'children': [
+            {
+                'driver': 'file',
+                'filename': '$TEST_IMG'
+            },
+            {
+                'driver': 'file',
+                'filename': '$TEST_IMG.copy'
+            }
+        ]
+    }
+}" _img_info | _filter_img_info
+
=20
 # success, all done
 echo '*** done'
diff --git a/tests/qemu-iotests/110.out b/tests/qemu-iotests/110.out
index 5370bc1d26..1d0b2475cc 100644
--- a/tests/qemu-iotests/110.out
+++ b/tests/qemu-iotests/110.out
@@ -19,4 +19,11 @@ backing file: t.IMGFMT.base (actual path: TEST_DIR/t.I=
MGFMT.base)
 =3D=3D=3D Backing name is always relative to the backed image =3D=3D=3D
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_fil=
e=3Dt.IMGFMT.base
+
+=3D=3D=3D Nodes without a common directory =3D=3D=3D
+
+image: json:{"driver": "IMGFMT", "file": {"children": [{"driver": "file"=
, "filename": "TEST_DIR/t.IMGFMT"}, {"driver": "file", "filename": "TEST_=
DIR/t.IMGFMT.copy"}], "driver": "quorum", "blkverify": false, "rewrite-co=
rrupted": false, "vote-threshold": 1}}
+file format: IMGFMT
+virtual size: 64M (67108864 bytes)
+backing file: t.IMGFMT.base (cannot determine actual path)
 *** done
--=20
2.19.2
