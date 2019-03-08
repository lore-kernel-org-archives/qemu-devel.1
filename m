Received: from eggs.gnu.org ([209.51.188.92]:60113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F69-0000QV-EK
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:59:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F65-0000nA-9a
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:59:36 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  8 Mar 2019 13:58:20 +0100
Message-Id: <20190308125823.32535-31-kwolf@redhat.com>
In-Reply-To: <20190308125823.32535-1-kwolf@redhat.com>
References: <20190308125823.32535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 30/33] qemu-iotests: amend with external data
 file
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

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/061     | 45 ++++++++++++++++++-
 tests/qemu-iotests/061.out | 89 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
index d2e68c0203..d7dbd7e2c7 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -28,7 +28,8 @@ status=3D1	# failure is the default!
=20
 _cleanup()
 {
-	_cleanup_test_img
+    _cleanup_test_img
+    rm -f $TEST_IMG.data
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
@@ -250,6 +251,48 @@ $QEMU_IMG snapshot -c foo "$TEST_IMG"
 $QEMU_IMG amend -p -o "compat=3D0.10" "$TEST_IMG"
 _check_test_img
=20
+echo
+echo "=3D=3D=3D Testing version downgrade with external data file =3D=3D=
=3D"
+echo
+IMGOPTS=3D"compat=3D1.1,data_file=3D$TEST_IMG.data" _make_test_img 64M
+$QEMU_IMG amend -o "compat=3D0.10" "$TEST_IMG"
+_img_info --format-specific
+_check_test_img
+
+echo
+echo "=3D=3D=3D Try changing the external data file =3D=3D=3D"
+echo
+IMGOPTS=3D"compat=3D1.1" _make_test_img 64M
+$QEMU_IMG amend -o "data_file=3Dfoo" "$TEST_IMG"
+
+echo
+IMGOPTS=3D"compat=3D1.1,data_file=3D$TEST_IMG.data" _make_test_img 64M
+$QEMU_IMG amend -o "data_file=3Dfoo" "$TEST_IMG"
+_img_info --format-specific
+TEST_IMG=3D"data-file.filename=3D$TEST_IMG.data,file.filename=3D$TEST_IM=
G" _img_info --format-specific --image-opts
+
+echo
+$QEMU_IMG amend -o "data_file=3D" --image-opts "data-file.filename=3D$TE=
ST_IMG.data,file.filename=3D$TEST_IMG"
+_img_info --format-specific
+TEST_IMG=3D"data-file.filename=3D$TEST_IMG.data,file.filename=3D$TEST_IM=
G" _img_info --format-specific --image-opts
+
+echo
+echo "=3D=3D=3D Clearing and setting data-file-raw =3D=3D=3D"
+echo
+IMGOPTS=3D"compat=3D1.1,data_file=3D$TEST_IMG.data,data_file_raw=3Don" _=
make_test_img 64M
+$QEMU_IMG amend -o "data_file_raw=3Don" "$TEST_IMG"
+_img_info --format-specific
+_check_test_img
+
+$QEMU_IMG amend -o "data_file_raw=3Doff" "$TEST_IMG"
+_img_info --format-specific
+_check_test_img
+
+$QEMU_IMG amend -o "data_file_raw=3Don" "$TEST_IMG"
+_img_info --format-specific
+_check_test_img
+
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index 758284011b..9fe1ec702f 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -488,4 +488,93 @@ wrote 65536/65536 bytes at offset 3221225472
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
     (0.00/100%)=0D    (6.25/100%)=0D    (12.50/100%)=0D    (18.75/100%)=0D=
    (25.00/100%)=0D    (31.25/100%)=0D    (37.50/100%)=0D    (43.75/100%)=
=0D    (50.00/100%)=0D    (56.25/100%)=0D    (62.50/100%)=0D    (68.75/10=
0%)=0D    (75.00/100%)=0D    (81.25/100%)=0D    (87.50/100%)=0D    (93.75=
/100%)=0D    (100.00/100%)=0D    (100.00/100%)
 No errors were found on the image.
+
+=3D=3D=3D Testing version downgrade with external data file =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 data_file=3D=
TEST_DIR/t.IMGFMT.data
+qemu-img: Cannot downgrade an image with a data file
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 64M (67108864 bytes)
+cluster_size: 65536
+Format specific information:
+    compat: 1.1
+    lazy refcounts: false
+    refcount bits: 16
+    data file: TEST_DIR/t.IMGFMT.data
+    data file raw: false
+    corrupt: false
+No errors were found on the image.
+
+=3D=3D=3D Try changing the external data file =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
+qemu-img: data-file can only be set for images that use an external data=
 file
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 data_file=3D=
TEST_DIR/t.IMGFMT.data
+qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Could not open 'foo': No s=
uch file or directory
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 64M (67108864 bytes)
+cluster_size: 65536
+Format specific information:
+    compat: 1.1
+    lazy refcounts: false
+    refcount bits: 16
+    data file: foo
+    data file raw: false
+    corrupt: false
+
+qemu-img: Could not open 'TEST_DIR/t.IMGFMT': 'data-file' is required fo=
r this image
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 64M (67108864 bytes)
+cluster_size: 65536
+Format specific information:
+    compat: 1.1
+    lazy refcounts: false
+    refcount bits: 16
+    data file raw: false
+    corrupt: false
+
+=3D=3D=3D Clearing and setting data-file-raw =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 data_file=3D=
TEST_DIR/t.IMGFMT.data data_file_raw=3Don
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 64M (67108864 bytes)
+cluster_size: 65536
+Format specific information:
+    compat: 1.1
+    lazy refcounts: false
+    refcount bits: 16
+    data file: TEST_DIR/t.IMGFMT.data
+    data file raw: true
+    corrupt: false
+No errors were found on the image.
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 64M (67108864 bytes)
+cluster_size: 65536
+Format specific information:
+    compat: 1.1
+    lazy refcounts: false
+    refcount bits: 16
+    data file: TEST_DIR/t.IMGFMT.data
+    data file raw: false
+    corrupt: false
+No errors were found on the image.
+qemu-img: data-file-raw cannot be set on existing images
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 64M (67108864 bytes)
+cluster_size: 65536
+Format specific information:
+    compat: 1.1
+    lazy refcounts: false
+    refcount bits: 16
+    data file: TEST_DIR/t.IMGFMT.data
+    data file raw: false
+    corrupt: false
+No errors were found on the image.
 *** done
--=20
2.20.1
