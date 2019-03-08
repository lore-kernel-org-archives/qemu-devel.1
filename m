Received: from eggs.gnu.org ([209.51.188.92]:60012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F62-0000Jr-1I
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:59:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5z-0000L8-Vs
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:59:29 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  8 Mar 2019 13:58:18 +0100
Message-Id: <20190308125823.32535-29-kwolf@redhat.com>
In-Reply-To: <20190308125823.32535-1-kwolf@redhat.com>
References: <20190308125823.32535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 28/33] qemu-iotests: Preallocation with external
 data file
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

Test that preallocating metadata results in a somewhat larger qcow2
file, but preallocating data only affects the disk usage of the data
file and the qcow2 file stays small.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/243     | 22 ++++++++++++++++++++++
 tests/qemu-iotests/243.out | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/tests/qemu-iotests/243 b/tests/qemu-iotests/243
index 6a19919add..5838c6e89c 100755
--- a/tests/qemu-iotests/243
+++ b/tests/qemu-iotests/243
@@ -29,6 +29,7 @@ status=3D1	# failure is the default!
 _cleanup()
 {
     _cleanup_test_img
+    rm -f $TEST_IMG.data
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
@@ -57,6 +58,27 @@ for mode in off metadata falloc full; do
=20
 done
=20
+for mode in off metadata falloc full; do
+
+    echo
+    echo "=3D=3D=3D External data file: preallocation=3D$mode =3D=3D=3D"
+    echo
+
+    IMGOPTS=3D"data_file=3D$TEST_IMG.data,preallocation=3D$mode" _make_t=
est_img 64M
+
+    echo -n "qcow2 file size: "
+    du -b $TEST_IMG | cut -f1
+    echo -n "data file size:  "
+    du -b $TEST_IMG.data | cut -f1
+
+    # Can't use precise numbers here because they differ between filesys=
tems
+    echo -n "qcow2 disk usage: "
+    [ $(du -B1 $TEST_IMG | cut -f1) -lt 1048576 ] && echo "low" || echo =
"high"
+    echo -n "data disk usage:  "
+    [ $(du -B1 $TEST_IMG.data | cut -f1) -lt 1048576 ] && echo "low" || =
echo "high"
+
+done
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/243.out b/tests/qemu-iotests/243.out
index e531753ad1..dcb33fac32 100644
--- a/tests/qemu-iotests/243.out
+++ b/tests/qemu-iotests/243.out
@@ -23,4 +23,36 @@ Disk usage: high
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 preallocati=
on=3Dfull
 File size: 67436544
 Disk usage: high
+
+=3D=3D=3D External data file: preallocation=3Doff =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 data_file=3D=
TEST_DIR/t.IMGFMT.data preallocation=3Doff
+qcow2 file size: 196616
+data file size:  67108864
+qcow2 disk usage: low
+data disk usage:  low
+
+=3D=3D=3D External data file: preallocation=3Dmetadata =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 data_file=3D=
TEST_DIR/t.IMGFMT.data preallocation=3Dmetadata
+qcow2 file size: 327680
+data file size:  67108864
+qcow2 disk usage: low
+data disk usage:  low
+
+=3D=3D=3D External data file: preallocation=3Dfalloc =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 data_file=3D=
TEST_DIR/t.IMGFMT.data preallocation=3Dfalloc
+qcow2 file size: 327680
+data file size:  67108864
+qcow2 disk usage: low
+data disk usage:  high
+
+=3D=3D=3D External data file: preallocation=3Dfull =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 data_file=3D=
TEST_DIR/t.IMGFMT.data preallocation=3Dfull
+qcow2 file size: 327680
+data file size:  67108864
+qcow2 disk usage: low
+data disk usage:  high
 *** done
--=20
2.20.1
