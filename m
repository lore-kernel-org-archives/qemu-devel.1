Received: from eggs.gnu.org ([2001:4830:134:3::10]:48568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gDwyR-00027W-E4
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 15:31:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gDwyQ-0005DB-0h
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 15:31:47 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Sat, 20 Oct 2018 21:31:07 +0200
Message-Id: <20181020193107.11369-2-kwolf@redhat.com>
In-Reply-To: <20181019163013.11787-1-kwolf@redhat.com>
References: <20181019163013.11787-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 11/11] qemu-iotests: Test auto-read-only
 with -drive and -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/232     | 147 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/232.out |  59 +++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 207 insertions(+)
 create mode 100755 tests/qemu-iotests/232
 create mode 100644 tests/qemu-iotests/232.out

diff --git a/tests/qemu-iotests/232 b/tests/qemu-iotests/232
new file mode 100755
index 0000000000..bc2972d124
--- /dev/null
+++ b/tests/qemu-iotests/232
@@ -0,0 +1,147 @@
+#!/bin/bash
+#
+# Test for auto-read-only
+#
+# Copyright (C) 2018 Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+# creator
+owner=3Dkwolf@redhat.com
+
+seq=3D`basename $0`
+echo "QA output created by $seq"
+
+here=3D`pwd`
+status=3D1	# failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+    rm -f $TEST_IMG.snap
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt generic
+_supported_proto file
+_supported_os Linux
+
+function do_run_qemu()
+{
+    echo Testing: "$@"
+    (
+        if ! test -t 0; then
+            while read cmd; do
+                echo $cmd
+            done
+        fi
+        echo quit
+    ) | $QEMU -nographic -monitor stdio -nodefaults "$@"
+    echo
+}
+
+function run_qemu()
+{
+    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_hmp=
 |
+        _filter_generated_node_ids | _filter_imgfmt
+}
+
+function run_qemu_info_block()
+{
+    echo "info block -n" | run_qemu "$@" | grep -e "(file" -e "QEMU_PROG=
"
+}
+
+size=3D128M
+
+_make_test_img $size
+
+echo
+echo "=3D=3D=3D -drive with read-write image: read-only/auto-read-only c=
ombinations =3D=3D=3D"
+echo
+
+run_qemu_info_block -drive driver=3Dfile,file=3D"$TEST_IMG",if=3Dnone,re=
ad-only=3Don,auto-read-only=3Doff
+run_qemu_info_block -drive driver=3Dfile,file=3D"$TEST_IMG",if=3Dnone,re=
ad-only=3Don,auto-read-only=3Don
+run_qemu_info_block -drive driver=3Dfile,file=3D"$TEST_IMG",if=3Dnone,re=
ad-only=3Don
+echo
+run_qemu_info_block -drive driver=3Dfile,file=3D"$TEST_IMG",if=3Dnone,re=
ad-only=3Doff,auto-read-only=3Doff
+run_qemu_info_block -drive driver=3Dfile,file=3D"$TEST_IMG",if=3Dnone,re=
ad-only=3Doff,auto-read-only=3Don
+run_qemu_info_block -drive driver=3Dfile,file=3D"$TEST_IMG",if=3Dnone,re=
ad-only=3Doff
+echo
+run_qemu_info_block -drive driver=3Dfile,file=3D"$TEST_IMG",if=3Dnone,au=
to-read-only=3Doff
+run_qemu_info_block -drive driver=3Dfile,file=3D"$TEST_IMG",if=3Dnone,au=
to-read-only=3Don
+run_qemu_info_block -drive driver=3Dfile,file=3D"$TEST_IMG",if=3Dnone
+
+echo
+echo "=3D=3D=3D -drive with read-only image: read-only/auto-read-only co=
mbinations =3D=3D=3D"
+echo
+
+chmod a-w $TEST_IMG
+
+run_qemu_info_block -drive driver=3Dfile,file=3D"$TEST_IMG",if=3Dnone,re=
ad-only=3Don,auto-read-only=3Doff
+run_qemu_info_block -drive driver=3Dfile,file=3D"$TEST_IMG",if=3Dnone,re=
ad-only=3Don,auto-read-only=3Don
+run_qemu_info_block -drive driver=3Dfile,file=3D"$TEST_IMG",if=3Dnone,re=
ad-only=3Don
+echo
+run_qemu_info_block -drive driver=3Dfile,file=3D"$TEST_IMG",if=3Dnone,re=
ad-only=3Doff,auto-read-only=3Doff
+run_qemu_info_block -drive driver=3Dfile,file=3D"$TEST_IMG",if=3Dnone,re=
ad-only=3Doff,auto-read-only=3Don
+run_qemu_info_block -drive driver=3Dfile,file=3D"$TEST_IMG",if=3Dnone,re=
ad-only=3Doff
+echo
+run_qemu_info_block -drive driver=3Dfile,file=3D"$TEST_IMG",if=3Dnone,au=
to-read-only=3Doff
+run_qemu_info_block -drive driver=3Dfile,file=3D"$TEST_IMG",if=3Dnone,au=
to-read-only=3Don
+run_qemu_info_block -drive driver=3Dfile,file=3D"$TEST_IMG",if=3Dnone
+
+echo
+echo "=3D=3D=3D -blockdev with read-write image: read-only/auto-read-onl=
y combinations =3D=3D=3D"
+echo
+
+chmod a+w $TEST_IMG
+
+run_qemu_info_block -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-=
name=3Dnode0,read-only=3Don,auto-read-only=3Doff
+run_qemu_info_block -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-=
name=3Dnode0,read-only=3Don,auto-read-only=3Don
+run_qemu_info_block -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-=
name=3Dnode0,read-only=3Don
+echo
+run_qemu_info_block -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-=
name=3Dnode0,read-only=3Doff,auto-read-only=3Doff
+run_qemu_info_block -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-=
name=3Dnode0,read-only=3Doff,auto-read-only=3Don
+run_qemu_info_block -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-=
name=3Dnode0,read-only=3Doff
+echo
+run_qemu_info_block -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-=
name=3Dnode0,auto-read-only=3Doff
+run_qemu_info_block -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-=
name=3Dnode0,auto-read-only=3Don
+run_qemu_info_block -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-=
name=3Dnode0
+
+echo
+echo "=3D=3D=3D -blockdev with read-only image: read-only/auto-read-only=
 combinations =3D=3D=3D"
+echo
+
+chmod a-w $TEST_IMG
+
+run_qemu_info_block -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-=
name=3Dnode0,read-only=3Don,auto-read-only=3Doff
+run_qemu_info_block -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-=
name=3Dnode0,read-only=3Don,auto-read-only=3Don
+run_qemu_info_block -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-=
name=3Dnode0,read-only=3Don
+echo
+run_qemu_info_block -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-=
name=3Dnode0,read-only=3Doff,auto-read-only=3Doff
+run_qemu_info_block -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-=
name=3Dnode0,read-only=3Doff,auto-read-only=3Don
+run_qemu_info_block -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-=
name=3Dnode0,read-only=3Doff
+echo
+run_qemu_info_block -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-=
name=3Dnode0,auto-read-only=3Doff
+run_qemu_info_block -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-=
name=3Dnode0,auto-read-only=3Don
+run_qemu_info_block -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-=
name=3Dnode0
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/232.out b/tests/qemu-iotests/232.out
new file mode 100644
index 0000000000..dcb683afa3
--- /dev/null
+++ b/tests/qemu-iotests/232.out
@@ -0,0 +1,59 @@
+QA output created by 232
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
+
+=3D=3D=3D -drive with read-write image: read-only/auto-read-only combina=
tions =3D=3D=3D
+
+NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
+NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
+NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
+
+NODE_NAME: TEST_DIR/t.IMGFMT (file)
+NODE_NAME: TEST_DIR/t.IMGFMT (file)
+NODE_NAME: TEST_DIR/t.IMGFMT (file)
+
+NODE_NAME: TEST_DIR/t.IMGFMT (file)
+NODE_NAME: TEST_DIR/t.IMGFMT (file)
+NODE_NAME: TEST_DIR/t.IMGFMT (file)
+
+=3D=3D=3D -drive with read-only image: read-only/auto-read-only combinat=
ions =3D=3D=3D
+
+NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
+NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
+NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
+
+QEMU_PROG: -drive driver=3Dfile,file=3DTEST_DIR/t.IMGFMT,if=3Dnone,read-=
only=3Doff,auto-read-only=3Doff: Could not open 'TEST_DIR/t.IMGFMT': Perm=
ission denied
+NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
+NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
+
+QEMU_PROG: -drive driver=3Dfile,file=3DTEST_DIR/t.IMGFMT,if=3Dnone,auto-=
read-only=3Doff: Could not open 'TEST_DIR/t.IMGFMT': Permission denied
+NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
+NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
+
+=3D=3D=3D -blockdev with read-write image: read-only/auto-read-only comb=
inations =3D=3D=3D
+
+node0: TEST_DIR/t.IMGFMT (file, read-only)
+node0: TEST_DIR/t.IMGFMT (file, read-only)
+node0: TEST_DIR/t.IMGFMT (file, read-only)
+
+node0: TEST_DIR/t.IMGFMT (file)
+node0: TEST_DIR/t.IMGFMT (file)
+node0: TEST_DIR/t.IMGFMT (file)
+
+node0: TEST_DIR/t.IMGFMT (file)
+node0: TEST_DIR/t.IMGFMT (file)
+node0: TEST_DIR/t.IMGFMT (file)
+
+=3D=3D=3D -blockdev with read-only image: read-only/auto-read-only combi=
nations =3D=3D=3D
+
+node0: TEST_DIR/t.IMGFMT (file, read-only)
+node0: TEST_DIR/t.IMGFMT (file, read-only)
+node0: TEST_DIR/t.IMGFMT (file, read-only)
+
+QEMU_PROG: -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT,node-nam=
e=3Dnode0,read-only=3Doff,auto-read-only=3Doff: Could not open 'TEST_DIR/=
t.IMGFMT': Permission denied
+node0: TEST_DIR/t.IMGFMT (file, read-only)
+QEMU_PROG: -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT,node-nam=
e=3Dnode0,read-only=3Doff: Could not open 'TEST_DIR/t.IMGFMT': Permission=
 denied
+
+QEMU_PROG: -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT,node-nam=
e=3Dnode0,auto-read-only=3Doff: Could not open 'TEST_DIR/t.IMGFMT': Permi=
ssion denied
+node0: TEST_DIR/t.IMGFMT (file, read-only)
+QEMU_PROG: -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT,node-nam=
e=3Dnode0: Could not open 'TEST_DIR/t.IMGFMT': Permission denied
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 31f6e77dcb..ebe4fe78bc 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -227,3 +227,4 @@
 227 auto quick
 229 auto quick
 231 auto quick
+232 auto quick
--=20
2.19.1
