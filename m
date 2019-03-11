Received: from eggs.gnu.org ([209.51.188.92]:59362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h3O9Y-0003FI-EB
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h3O8C-0007Xh-DG
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:50:29 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 11 Mar 2019 17:50:09 +0100
Message-Id: <20190311165017.32247-3-kwolf@redhat.com>
In-Reply-To: <20190311165017.32247-1-kwolf@redhat.com>
References: <20190311165017.32247-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 02/10] qemu-iotests: commit to backing file
 with auto-read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pkrempa@redhat.com, berto@igalia.com, qemu-devel@nongnu.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/232     | 31 +++++++++++++++++++++++++++++++
 tests/qemu-iotests/232.out | 20 ++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/tests/qemu-iotests/232 b/tests/qemu-iotests/232
index 71fd48eff0..0de097fc88 100755
--- a/tests/qemu-iotests/232
+++ b/tests/qemu-iotests/232
@@ -29,6 +29,7 @@ status=3D1	# failure is the default!
 _cleanup()
 {
     _cleanup_test_img
+    rm -f $TEST_IMG.[01234]
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
@@ -143,6 +144,36 @@ run_qemu_info_block -blockdev driver=3Dfile,filename=
=3D"$TEST_IMG",node-name=3Dnode0,a
 run_qemu_info_block -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-=
name=3Dnode0,auto-read-only=3Don
 run_qemu_info_block -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-=
name=3Dnode0
=20
+echo
+echo "=3D=3D=3D Try commit to backing file with auto-read-only =3D=3D=3D=
"
+echo
+
+TEST_IMG=3D"$TEST_IMG.0" _make_test_img $size
+TEST_IMG=3D"$TEST_IMG.1" _make_test_img $size
+TEST_IMG=3D"$TEST_IMG.2" _make_test_img $size
+TEST_IMG=3D"$TEST_IMG.3" _make_test_img $size
+TEST_IMG=3D"$TEST_IMG.4" _make_test_img $size
+
+(cat <<EOF
+{"execute":"qmp_capabilities"}
+{"execute":"block-commit",
+ "arguments":{"device":"format-4", "top-node": "format-2", "base-node":"=
format-0", "job-id":"job0"}}
+EOF
+sleep 1
+echo '{"execute":"quit"}'
+) | $QEMU -qmp stdio -nographic -nodefaults \
+    -blockdev file,node-name=3Dfile-0,filename=3D$TEST_IMG.0,auto-read-o=
nly=3Don \
+    -blockdev qcow2,node-name=3Dformat-0,file=3Dfile-0,read-only=3Don \
+    -blockdev file,node-name=3Dfile-1,filename=3D$TEST_IMG.1,auto-read-o=
nly=3Don \
+    -blockdev qcow2,node-name=3Dformat-1,file=3Dfile-1,read-only=3Don,ba=
cking=3Dformat-0 \
+    -blockdev file,node-name=3Dfile-2,filename=3D$TEST_IMG.2,auto-read-o=
nly=3Don \
+    -blockdev qcow2,node-name=3Dformat-2,file=3Dfile-2,read-only=3Don,ba=
cking=3Dformat-1 \
+    -blockdev file,node-name=3Dfile-3,filename=3D$TEST_IMG.3,auto-read-o=
nly=3Don \
+    -blockdev qcow2,node-name=3Dformat-3,file=3Dfile-3,read-only=3Don,ba=
cking=3Dformat-2 \
+    -blockdev file,node-name=3Dfile-4,filename=3D$TEST_IMG.4,auto-read-o=
nly=3Don \
+    -blockdev qcow2,node-name=3Dformat-4,file=3Dfile-4,read-only=3Don,ba=
cking=3Dformat-3 |
+    _filter_qmp
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/232.out b/tests/qemu-iotests/232.out
index dcb683afa3..5036ef13d4 100644
--- a/tests/qemu-iotests/232.out
+++ b/tests/qemu-iotests/232.out
@@ -56,4 +56,24 @@ QEMU_PROG: -blockdev driver=3Dfile,filename=3DTEST_DIR=
/t.IMGFMT,node-name=3Dnode0,read
 QEMU_PROG: -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT,node-nam=
e=3Dnode0,auto-read-only=3Doff: Could not open 'TEST_DIR/t.IMGFMT': Permi=
ssion denied
 node0: TEST_DIR/t.IMGFMT (file, read-only)
 QEMU_PROG: -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT,node-nam=
e=3Dnode0: Could not open 'TEST_DIR/t.IMGFMT': Permission denied
+
+=3D=3D=3D Try commit to backing file with auto-read-only =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT.0', fmt=3DIMGFMT size=3D134217728
+Formatting 'TEST_DIR/t.IMGFMT.1', fmt=3DIMGFMT size=3D134217728
+Formatting 'TEST_DIR/t.IMGFMT.2', fmt=3DIMGFMT size=3D134217728
+Formatting 'TEST_DIR/t.IMGFMT.3', fmt=3DIMGFMT size=3D134217728
+Formatting 'TEST_DIR/t.IMGFMT.4', fmt=3DIMGFMT size=3D134217728
+QMP_VERSION
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "BLOCK_JOB_COMPLETED", "data": {"device": "job0", "len": 134217728, "=
offset": 134217728, "speed": 0, "type": "commit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 *** done
--=20
2.20.1
