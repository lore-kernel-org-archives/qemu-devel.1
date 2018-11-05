Received: from eggs.gnu.org ([2001:4830:134:3::10]:53834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhzs-0000Ya-99
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:45:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhzq-0001pd-82
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:45:04 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  5 Nov 2018 17:37:24 +0100
Message-Id: <20181105163744.25139-17-kwolf@redhat.com>
In-Reply-To: <20181105163744.25139-1-kwolf@redhat.com>
References: <20181105163744.25139-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/36] iotest: Test the blkverify mode of the
 Quorum driver
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

From: Alberto Garcia <berto@igalia.com>

Signed-off-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/081     | 30 ++++++++++++++++++++++++++++++
 tests/qemu-iotests/081.out | 16 ++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/tests/qemu-iotests/081 b/tests/qemu-iotests/081
index da3fb0984b..0ea010afbf 100755
--- a/tests/qemu-iotests/081
+++ b/tests/qemu-iotests/081
@@ -168,6 +168,36 @@ echo "=3D=3D checking that quorum is broken =3D=3D"
=20
 $QEMU_IO -c "open -o $quorum" -c "read -P 0x32 0 $size" | _filter_qemu_i=
o
=20
+echo
+echo "=3D=3D checking the blkverify mode with broken content =3D=3D"
+
+quorum=3D"driver=3Draw,file.driver=3Dquorum,file.vote-threshold=3D2,file=
.blkverify=3Don"
+quorum=3D"$quorum,file.children.0.file.filename=3D$TEST_DIR/1.raw"
+quorum=3D"$quorum,file.children.1.file.filename=3D$TEST_DIR/2.raw"
+quorum=3D"$quorum,file.children.0.driver=3Draw"
+quorum=3D"$quorum,file.children.1.driver=3Draw"
+
+$QEMU_IO -c "open -o $quorum" -c "read -P 0x32 0 $size" | _filter_qemu_i=
o
+
+echo
+echo "=3D=3D writing the same data to both files =3D=3D"
+
+$QEMU_IO -c "write -P 0x32 0 $size" "$TEST_DIR/1.raw" | _filter_qemu_io
+$QEMU_IO -c "write -P 0x32 0 $size" "$TEST_DIR/2.raw" | _filter_qemu_io
+
+echo
+echo "=3D=3D checking the blkverify mode with valid content =3D=3D"
+
+$QEMU_IO -c "open -o $quorum" -c "read -P 0x32 0 $size" | _filter_qemu_i=
o
+
+echo
+echo "=3D=3D checking the blkverify mode with invalid settings =3D=3D"
+
+quorum=3D"$quorum,file.children.2.file.filename=3D$TEST_DIR/3.raw"
+quorum=3D"$quorum,file.children.2.driver=3Draw"
+
+$QEMU_IO -c "open -o $quorum" | _filter_qemu_io
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/081.out b/tests/qemu-iotests/081.out
index 2533c31c78..2f12c890e9 100644
--- a/tests/qemu-iotests/081.out
+++ b/tests/qemu-iotests/081.out
@@ -55,4 +55,20 @@ wrote 10485760/10485760 bytes at offset 0
=20
 =3D=3D checking that quorum is broken =3D=3D
 read failed: Input/output error
+
+=3D=3D checking the blkverify mode with broken content =3D=3D
+quorum: offset=3D0 bytes=3D10485760 contents mismatch at offset 0
+
+=3D=3D writing the same data to both files =3D=3D
+wrote 10485760/10485760 bytes at offset 0
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 10485760/10485760 bytes at offset 0
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=3D=3D checking the blkverify mode with valid content =3D=3D
+read 10485760/10485760 bytes at offset 0
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=3D=3D checking the blkverify mode with invalid settings =3D=3D
+can't open: blkverify=3Don can only be set if there are exactly two file=
s and vote-threshold is 2
 *** done
--=20
2.19.1
