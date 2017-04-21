Received: from eggs.gnu.org ([2001:4830:134:3::10]:59250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1PhG-0006j7-AA
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 23:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1PhC-0004GH-Bg
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 23:57:26 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 21 Apr 2017 11:56:06 +0800
Message-Id: <20170421035606.448-21-famz@redhat.com>
In-Reply-To: <20170421035606.448-1-famz@redhat.com>
References: <20170421035606.448-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v14 20/20] qemu-iotests: Add test case 153 for
 image locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/qemu-iotests/153     | 219 ++++++++++++++++
 tests/qemu-iotests/153.out | 627 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 847 insertions(+)
 create mode 100755 tests/qemu-iotests/153
 create mode 100644 tests/qemu-iotests/153.out

diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
new file mode 100755
index 0000000..ff22615
--- /dev/null
+++ b/tests/qemu-iotests/153
@@ -0,0 +1,219 @@
+#!/bin/bash
+#
+# Test image locking
+#
+# Copyright 2016, 2017 Red Hat, Inc.
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
+owner=famz@redhat.com
+
+seq="$(basename $0)"
+echo "QA output created by $seq"
+
+here="$PWD"
+tmp=/tmp/$$
+status=1	# failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+    rm -f "${TEST_IMG}.base"
+    rm -f "${TEST_IMG}.convert"
+    rm -f "${TEST_IMG}.a"
+    rm -f "${TEST_IMG}.b"
+    rm -f "${TEST_IMG}.lnk"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+. ./common.qemu
+
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+size=32M
+
+_run_cmd()
+{
+    echo
+    (echo "$@"; "$@" 2>&1 1>/dev/null) | _filter_testdir
+}
+
+function _do_run_qemu()
+{
+    (
+        if ! test -t 0; then
+            while read cmd; do
+                echo $cmd
+            done
+        fi
+        echo quit
+    ) | $QEMU -nographic -monitor stdio -serial none "$@" 1>/dev/null
+}
+
+function _run_qemu_with_images()
+{
+    _do_run_qemu \
+        $(for i in $@; do echo "-drive if=none,file=$i"; done) 2>&1 \
+        | _filter_testdir | _filter_qemu
+}
+
+test_opts="$(echo readonly={on,off},force-shared-write={on,off})"
+
+for opts1 in "" $test_opts; do
+    echo
+    echo "== Creating base image =="
+    TEST_IMG="${TEST_IMG}.base" _make_test_img $size
+
+    echo
+    echo "== Creating test image =="
+    $QEMU_IMG create -f $IMGFMT "${TEST_IMG}" -b ${TEST_IMG}.base | _filter_img_create
+
+    echo
+    echo "== Launching QEMU, opts: '$opts1' =="
+    _launch_qemu -drive file="${TEST_IMG}",if=none,$opts1
+    h=$QEMU_HANDLE
+
+    for opts2 in "" $test_opts; do
+        echo
+        echo "== Launching another QEMU, opts: '$opts2' =="
+        echo "quit" | \
+            $QEMU -nographic -monitor stdio \
+            -drive file="${TEST_IMG}",if=none,$opts2 2>&1 1>/dev/null | \
+            _filter_testdir | _filter_qemu
+    done
+
+    for L in "" "-U"; do
+
+        echo
+        echo "== Running utility commands $L =="
+        _run_cmd $QEMU_IO $L -c "read 0 512" "${TEST_IMG}"
+        _run_cmd $QEMU_IO $L -r -c "read 0 512" "${TEST_IMG}"
+        _run_cmd $QEMU_IO -c "open $L ${TEST_IMG}" -c "read 0 512"
+        _run_cmd $QEMU_IO -c "open -r $L ${TEST_IMG}" -c "read 0 512"
+        _run_cmd $QEMU_IMG info        $L "${TEST_IMG}"
+        _run_cmd $QEMU_IMG check       $L "${TEST_IMG}"
+        _run_cmd $QEMU_IMG compare     $L "${TEST_IMG}" "${TEST_IMG}"
+        _run_cmd $QEMU_IMG map         $L "${TEST_IMG}"
+        _run_cmd $QEMU_IMG amend -o "" $L "${TEST_IMG}"
+        _run_cmd $QEMU_IMG commit      $L "${TEST_IMG}"
+        _run_cmd $QEMU_IMG resize      $L "${TEST_IMG}" $size
+        _run_cmd $QEMU_IMG rebase      $L "${TEST_IMG}" -b "${TEST_IMG}.base"
+        _run_cmd $QEMU_IMG snapshot -l $L "${TEST_IMG}"
+        _run_cmd $QEMU_IMG convert     $L "${TEST_IMG}" "${TEST_IMG}.convert"
+        _run_cmd $QEMU_IMG dd          $L if="${TEST_IMG}" of="${TEST_IMG}.convert" bs=512 count=1
+        _run_cmd $QEMU_IMG bench       $L -c 1 "${TEST_IMG}"
+        _run_cmd $QEMU_IMG bench       $L -w -c 1 "${TEST_IMG}"
+    done
+    _send_qemu_cmd $h "{ 'execute': 'quit', }" ""
+    echo
+    echo "Round done"
+    _cleanup_qemu
+done
+
+for opt1 in $test_opts; do
+    for opt2 in $test_opts; do
+        echo
+        echo "== Two devices with the same image ($opt1 - $opt2) =="
+        _run_qemu_with_images "${TEST_IMG},$opt1" "${TEST_IMG},$opt2"
+    done
+done
+
+echo "== Creating ${TEST_IMG}.[abc] =="
+(
+    $QEMU_IMG create -f qcow2 "${TEST_IMG}.a" -b "${TEST_IMG}"
+    $QEMU_IMG create -f qcow2 "${TEST_IMG}.b" -b "${TEST_IMG}"
+    $QEMU_IMG create -f qcow2 "${TEST_IMG}.c" -b "${TEST_IMG}.b"
+) | _filter_img_create
+
+echo
+echo "== Two devices sharing the same file in backing chain =="
+_run_qemu_with_images "${TEST_IMG}.a" "${TEST_IMG}.b"
+_run_qemu_with_images "${TEST_IMG}.a" "${TEST_IMG}.c"
+
+echo
+echo "== Backing image also as an active device =="
+_run_qemu_with_images "${TEST_IMG}.a" "${TEST_IMG}"
+
+echo
+echo "== Backing image also as an active device (ro) =="
+_run_qemu_with_images "${TEST_IMG}.a" "${TEST_IMG},readonly=on"
+
+echo
+echo "== Symbolic link =="
+rm -f "${TEST_IMG}.lnk" &>/dev/null
+ln -s ${TEST_IMG} "${TEST_IMG}.lnk" || echo "Failed to create link"
+_run_qemu_with_images "${TEST_IMG}.lnk" "${TEST_IMG}"
+
+echo
+echo "== Closing an image should unlock it =="
+_launch_qemu
+
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'qmp_capabilities' }" \
+    'return'
+
+echo "Adding drive"
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'human-monitor-command',
+       'arguments': { 'command-line': 'drive_add 0 if=none,id=d0,file=${TEST_IMG}' } }" \
+    ""
+
+_run_cmd $QEMU_IO "${TEST_IMG}" -c 'write 0 512'
+
+echo "Closing drive"
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'human-monitor-command',
+       'arguments': { 'command-line': 'drive_del d0' } }" \
+    ""
+
+_run_cmd $QEMU_IO "${TEST_IMG}" -c 'write 0 512'
+
+echo "Adding two and closing one"
+for d in d0 d1; do
+    _send_qemu_cmd $QEMU_HANDLE \
+        "{ 'execute': 'human-monitor-command',
+           'arguments': { 'command-line': 'drive_add 0 if=none,id=$d,file=${TEST_IMG},readonly=on' } }" \
+        ""
+done
+
+_run_cmd $QEMU_IMG info "${TEST_IMG}"
+
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'human-monitor-command',
+       'arguments': { 'command-line': 'drive_del d0' } }" \
+    ""
+
+_run_cmd $QEMU_IO "${TEST_IMG}" -c 'write 0 512'
+
+echo "Closing the other"
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'human-monitor-command',
+       'arguments': { 'command-line': 'drive_del d1' } }" \
+    ""
+
+_run_cmd $QEMU_IO "${TEST_IMG}" -c 'write 0 512'
+
+_cleanup_qemu
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/153.out b/tests/qemu-iotests/153.out
new file mode 100644
index 0000000..786ff0b
--- /dev/null
+++ b/tests/qemu-iotests/153.out
@@ -0,0 +1,627 @@
+QA output created by 153
+
+== Creating base image ==
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=33554432
+
+== Creating test image ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT.base
+
+== Launching QEMU, opts: '' ==
+
+== Launching another QEMU, opts: '' ==
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=none,: Failed to lock image: Resource temporarily unavailable
+
+== Launching another QEMU, opts: 'readonly=on,force-shared-write=on' ==
+
+== Launching another QEMU, opts: 'readonly=on,force-shared-write=off' ==
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=none,readonly=on,force-shared-write=off: Failed to lock share byte: Resource temporarily unavailable
+
+== Launching another QEMU, opts: 'readonly=off,force-shared-write=on' ==
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=none,readonly=off,force-shared-write=on: Failed to lock write byte: Resource temporarily unavailable
+
+== Launching another QEMU, opts: 'readonly=off,force-shared-write=off' ==
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=none,readonly=off,force-shared-write=off: Failed to lock image: Resource temporarily unavailable
+
+== Running utility commands  ==
+
+_qemu_io_wrapper -c read 0 512 TEST_DIR/t.qcow2
+can't open device TEST_DIR/t.qcow2: Failed to lock image: Resource temporarily unavailable
+
+_qemu_io_wrapper -r -c read 0 512 TEST_DIR/t.qcow2
+can't open device TEST_DIR/t.qcow2: Failed to lock share byte: Resource temporarily unavailable
+
+_qemu_io_wrapper -c open  TEST_DIR/t.qcow2 -c read 0 512
+can't open device TEST_DIR/t.qcow2: Failed to lock image: Resource temporarily unavailable
+
+_qemu_io_wrapper -c open -r  TEST_DIR/t.qcow2 -c read 0 512
+can't open device TEST_DIR/t.qcow2: Failed to lock share byte: Resource temporarily unavailable
+
+_qemu_img_wrapper info TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock share byte: Resource temporarily unavailable
+
+_qemu_img_wrapper check TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock share byte: Resource temporarily unavailable
+
+_qemu_img_wrapper compare TEST_DIR/t.qcow2 TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock share byte: Resource temporarily unavailable
+
+_qemu_img_wrapper map TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock share byte: Resource temporarily unavailable
+
+_qemu_img_wrapper amend -o  TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock image: Resource temporarily unavailable
+
+_qemu_img_wrapper commit TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock image: Resource temporarily unavailable
+
+_qemu_img_wrapper resize TEST_DIR/t.qcow2 32M
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock image: Resource temporarily unavailable
+
+_qemu_img_wrapper rebase TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock image: Resource temporarily unavailable
+
+_qemu_img_wrapper snapshot -l TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock share byte: Resource temporarily unavailable
+
+_qemu_img_wrapper convert TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.convert
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock share byte: Resource temporarily unavailable
+
+_qemu_img_wrapper dd if=TEST_DIR/t.qcow2 of=TEST_DIR/t.qcow2.convert bs=512 count=1
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock share byte: Resource temporarily unavailable
+
+_qemu_img_wrapper bench -c 1 TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock share byte: Resource temporarily unavailable
+
+_qemu_img_wrapper bench -w -c 1 TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock image: Resource temporarily unavailable
+
+== Running utility commands -U ==
+
+_qemu_io_wrapper -U -c read 0 512 TEST_DIR/t.qcow2
+can't open device TEST_DIR/t.qcow2: Failed to lock write byte: Resource temporarily unavailable
+
+_qemu_io_wrapper -U -r -c read 0 512 TEST_DIR/t.qcow2
+
+_qemu_io_wrapper -c open -U TEST_DIR/t.qcow2 -c read 0 512
+can't open device TEST_DIR/t.qcow2: Failed to lock write byte: Resource temporarily unavailable
+
+_qemu_io_wrapper -c open -r -U TEST_DIR/t.qcow2 -c read 0 512
+
+_qemu_img_wrapper info -U TEST_DIR/t.qcow2
+
+_qemu_img_wrapper check -U TEST_DIR/t.qcow2
+
+_qemu_img_wrapper compare -U TEST_DIR/t.qcow2 TEST_DIR/t.qcow2
+
+_qemu_img_wrapper map -U TEST_DIR/t.qcow2
+
+_qemu_img_wrapper amend -o  -U TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock write byte: Resource temporarily unavailable
+
+_qemu_img_wrapper commit -U TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock write byte: Resource temporarily unavailable
+
+_qemu_img_wrapper resize -U TEST_DIR/t.qcow2 32M
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock write byte: Resource temporarily unavailable
+
+_qemu_img_wrapper rebase -U TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock write byte: Resource temporarily unavailable
+
+_qemu_img_wrapper snapshot -l -U TEST_DIR/t.qcow2
+
+_qemu_img_wrapper convert -U TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.convert
+
+_qemu_img_wrapper dd -U if=TEST_DIR/t.qcow2 of=TEST_DIR/t.qcow2.convert bs=512 count=1
+
+_qemu_img_wrapper bench -U -c 1 TEST_DIR/t.qcow2
+
+_qemu_img_wrapper bench -U -w -c 1 TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock write byte: Resource temporarily unavailable
+
+Round done
+
+== Creating base image ==
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=33554432
+
+== Creating test image ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT.base
+
+== Launching QEMU, opts: 'readonly=on,force-shared-write=on' ==
+
+== Launching another QEMU, opts: '' ==
+
+== Launching another QEMU, opts: 'readonly=on,force-shared-write=on' ==
+
+== Launching another QEMU, opts: 'readonly=on,force-shared-write=off' ==
+
+== Launching another QEMU, opts: 'readonly=off,force-shared-write=on' ==
+
+== Launching another QEMU, opts: 'readonly=off,force-shared-write=off' ==
+
+== Running utility commands  ==
+
+_qemu_io_wrapper -c read 0 512 TEST_DIR/t.qcow2
+
+_qemu_io_wrapper -r -c read 0 512 TEST_DIR/t.qcow2
+
+_qemu_io_wrapper -c open  TEST_DIR/t.qcow2 -c read 0 512
+
+_qemu_io_wrapper -c open -r  TEST_DIR/t.qcow2 -c read 0 512
+
+_qemu_img_wrapper info TEST_DIR/t.qcow2
+
+_qemu_img_wrapper check TEST_DIR/t.qcow2
+
+_qemu_img_wrapper compare TEST_DIR/t.qcow2 TEST_DIR/t.qcow2
+
+_qemu_img_wrapper map TEST_DIR/t.qcow2
+
+_qemu_img_wrapper amend -o  TEST_DIR/t.qcow2
+
+_qemu_img_wrapper commit TEST_DIR/t.qcow2
+
+_qemu_img_wrapper resize TEST_DIR/t.qcow2 32M
+
+_qemu_img_wrapper rebase TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
+
+_qemu_img_wrapper snapshot -l TEST_DIR/t.qcow2
+
+_qemu_img_wrapper convert TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.convert
+
+_qemu_img_wrapper dd if=TEST_DIR/t.qcow2 of=TEST_DIR/t.qcow2.convert bs=512 count=1
+
+_qemu_img_wrapper bench -c 1 TEST_DIR/t.qcow2
+
+_qemu_img_wrapper bench -w -c 1 TEST_DIR/t.qcow2
+
+== Running utility commands -U ==
+
+_qemu_io_wrapper -U -c read 0 512 TEST_DIR/t.qcow2
+
+_qemu_io_wrapper -U -r -c read 0 512 TEST_DIR/t.qcow2
+
+_qemu_io_wrapper -c open -U TEST_DIR/t.qcow2 -c read 0 512
+
+_qemu_io_wrapper -c open -r -U TEST_DIR/t.qcow2 -c read 0 512
+
+_qemu_img_wrapper info -U TEST_DIR/t.qcow2
+
+_qemu_img_wrapper check -U TEST_DIR/t.qcow2
+
+_qemu_img_wrapper compare -U TEST_DIR/t.qcow2 TEST_DIR/t.qcow2
+
+_qemu_img_wrapper map -U TEST_DIR/t.qcow2
+
+_qemu_img_wrapper amend -o  -U TEST_DIR/t.qcow2
+
+_qemu_img_wrapper commit -U TEST_DIR/t.qcow2
+
+_qemu_img_wrapper resize -U TEST_DIR/t.qcow2 32M
+
+_qemu_img_wrapper rebase -U TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
+
+_qemu_img_wrapper snapshot -l -U TEST_DIR/t.qcow2
+
+_qemu_img_wrapper convert -U TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.convert
+
+_qemu_img_wrapper dd -U if=TEST_DIR/t.qcow2 of=TEST_DIR/t.qcow2.convert bs=512 count=1
+
+_qemu_img_wrapper bench -U -c 1 TEST_DIR/t.qcow2
+
+_qemu_img_wrapper bench -U -w -c 1 TEST_DIR/t.qcow2
+
+Round done
+
+== Creating base image ==
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=33554432
+
+== Creating test image ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT.base
+
+== Launching QEMU, opts: 'readonly=on,force-shared-write=off' ==
+
+== Launching another QEMU, opts: '' ==
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=none,: Failed to lock image: Resource temporarily unavailable
+
+== Launching another QEMU, opts: 'readonly=on,force-shared-write=on' ==
+
+== Launching another QEMU, opts: 'readonly=on,force-shared-write=off' ==
+
+== Launching another QEMU, opts: 'readonly=off,force-shared-write=on' ==
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=none,readonly=off,force-shared-write=on: Share byte lock is taken: Resource temporarily unavailable
+
+== Launching another QEMU, opts: 'readonly=off,force-shared-write=off' ==
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=none,readonly=off,force-shared-write=off: Failed to lock image: Resource temporarily unavailable
+
+== Running utility commands  ==
+
+_qemu_io_wrapper -c read 0 512 TEST_DIR/t.qcow2
+can't open device TEST_DIR/t.qcow2: Failed to lock image: Resource temporarily unavailable
+
+_qemu_io_wrapper -r -c read 0 512 TEST_DIR/t.qcow2
+
+_qemu_io_wrapper -c open  TEST_DIR/t.qcow2 -c read 0 512
+can't open device TEST_DIR/t.qcow2: Failed to lock image: Resource temporarily unavailable
+
+_qemu_io_wrapper -c open -r  TEST_DIR/t.qcow2 -c read 0 512
+
+_qemu_img_wrapper info TEST_DIR/t.qcow2
+
+_qemu_img_wrapper check TEST_DIR/t.qcow2
+
+_qemu_img_wrapper compare TEST_DIR/t.qcow2 TEST_DIR/t.qcow2
+
+_qemu_img_wrapper map TEST_DIR/t.qcow2
+
+_qemu_img_wrapper amend -o  TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock image: Resource temporarily unavailable
+
+_qemu_img_wrapper commit TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock image: Resource temporarily unavailable
+
+_qemu_img_wrapper resize TEST_DIR/t.qcow2 32M
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock image: Resource temporarily unavailable
+
+_qemu_img_wrapper rebase TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock image: Resource temporarily unavailable
+
+_qemu_img_wrapper snapshot -l TEST_DIR/t.qcow2
+
+_qemu_img_wrapper convert TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.convert
+
+_qemu_img_wrapper dd if=TEST_DIR/t.qcow2 of=TEST_DIR/t.qcow2.convert bs=512 count=1
+
+_qemu_img_wrapper bench -c 1 TEST_DIR/t.qcow2
+
+_qemu_img_wrapper bench -w -c 1 TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock image: Resource temporarily unavailable
+
+== Running utility commands -U ==
+
+_qemu_io_wrapper -U -c read 0 512 TEST_DIR/t.qcow2
+can't open device TEST_DIR/t.qcow2: Share byte lock is taken: Resource temporarily unavailable
+
+_qemu_io_wrapper -U -r -c read 0 512 TEST_DIR/t.qcow2
+
+_qemu_io_wrapper -c open -U TEST_DIR/t.qcow2 -c read 0 512
+can't open device TEST_DIR/t.qcow2: Share byte lock is taken: Resource temporarily unavailable
+
+_qemu_io_wrapper -c open -r -U TEST_DIR/t.qcow2 -c read 0 512
+
+_qemu_img_wrapper info -U TEST_DIR/t.qcow2
+
+_qemu_img_wrapper check -U TEST_DIR/t.qcow2
+
+_qemu_img_wrapper compare -U TEST_DIR/t.qcow2 TEST_DIR/t.qcow2
+
+_qemu_img_wrapper map -U TEST_DIR/t.qcow2
+
+_qemu_img_wrapper amend -o  -U TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Share byte lock is taken: Resource temporarily unavailable
+
+_qemu_img_wrapper commit -U TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Share byte lock is taken: Resource temporarily unavailable
+
+_qemu_img_wrapper resize -U TEST_DIR/t.qcow2 32M
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Share byte lock is taken: Resource temporarily unavailable
+
+_qemu_img_wrapper rebase -U TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Share byte lock is taken: Resource temporarily unavailable
+
+_qemu_img_wrapper snapshot -l -U TEST_DIR/t.qcow2
+
+_qemu_img_wrapper convert -U TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.convert
+
+_qemu_img_wrapper dd -U if=TEST_DIR/t.qcow2 of=TEST_DIR/t.qcow2.convert bs=512 count=1
+
+_qemu_img_wrapper bench -U -c 1 TEST_DIR/t.qcow2
+
+_qemu_img_wrapper bench -U -w -c 1 TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Share byte lock is taken: Resource temporarily unavailable
+
+Round done
+
+== Creating base image ==
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=33554432
+
+== Creating test image ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT.base
+
+== Launching QEMU, opts: 'readonly=off,force-shared-write=on' ==
+
+== Launching another QEMU, opts: '' ==
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=none,: Failed to lock image: Resource temporarily unavailable
+
+== Launching another QEMU, opts: 'readonly=on,force-shared-write=on' ==
+
+== Launching another QEMU, opts: 'readonly=on,force-shared-write=off' ==
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=none,readonly=on,force-shared-write=off: Write byte lock is taken: Resource temporarily unavailable
+
+== Launching another QEMU, opts: 'readonly=off,force-shared-write=on' ==
+
+== Launching another QEMU, opts: 'readonly=off,force-shared-write=off' ==
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=none,readonly=off,force-shared-write=off: Failed to lock image: Resource temporarily unavailable
+
+== Running utility commands  ==
+
+_qemu_io_wrapper -c read 0 512 TEST_DIR/t.qcow2
+can't open device TEST_DIR/t.qcow2: Failed to lock image: Resource temporarily unavailable
+
+_qemu_io_wrapper -r -c read 0 512 TEST_DIR/t.qcow2
+can't open device TEST_DIR/t.qcow2: Write byte lock is taken: Resource temporarily unavailable
+
+_qemu_io_wrapper -c open  TEST_DIR/t.qcow2 -c read 0 512
+can't open device TEST_DIR/t.qcow2: Failed to lock image: Resource temporarily unavailable
+
+_qemu_io_wrapper -c open -r  TEST_DIR/t.qcow2 -c read 0 512
+can't open device TEST_DIR/t.qcow2: Write byte lock is taken: Resource temporarily unavailable
+
+_qemu_img_wrapper info TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Write byte lock is taken: Resource temporarily unavailable
+
+_qemu_img_wrapper check TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Write byte lock is taken: Resource temporarily unavailable
+
+_qemu_img_wrapper compare TEST_DIR/t.qcow2 TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Write byte lock is taken: Resource temporarily unavailable
+
+_qemu_img_wrapper map TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Write byte lock is taken: Resource temporarily unavailable
+
+_qemu_img_wrapper amend -o  TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock image: Resource temporarily unavailable
+
+_qemu_img_wrapper commit TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock image: Resource temporarily unavailable
+
+_qemu_img_wrapper resize TEST_DIR/t.qcow2 32M
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock image: Resource temporarily unavailable
+
+_qemu_img_wrapper rebase TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock image: Resource temporarily unavailable
+
+_qemu_img_wrapper snapshot -l TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Write byte lock is taken: Resource temporarily unavailable
+
+_qemu_img_wrapper convert TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.convert
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Write byte lock is taken: Resource temporarily unavailable
+
+_qemu_img_wrapper dd if=TEST_DIR/t.qcow2 of=TEST_DIR/t.qcow2.convert bs=512 count=1
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Write byte lock is taken: Resource temporarily unavailable
+
+_qemu_img_wrapper bench -c 1 TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Write byte lock is taken: Resource temporarily unavailable
+
+_qemu_img_wrapper bench -w -c 1 TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock image: Resource temporarily unavailable
+
+== Running utility commands -U ==
+
+_qemu_io_wrapper -U -c read 0 512 TEST_DIR/t.qcow2
+
+_qemu_io_wrapper -U -r -c read 0 512 TEST_DIR/t.qcow2
+
+_qemu_io_wrapper -c open -U TEST_DIR/t.qcow2 -c read 0 512
+
+_qemu_io_wrapper -c open -r -U TEST_DIR/t.qcow2 -c read 0 512
+
+_qemu_img_wrapper info -U TEST_DIR/t.qcow2
+
+_qemu_img_wrapper check -U TEST_DIR/t.qcow2
+
+_qemu_img_wrapper compare -U TEST_DIR/t.qcow2 TEST_DIR/t.qcow2
+
+_qemu_img_wrapper map -U TEST_DIR/t.qcow2
+
+_qemu_img_wrapper amend -o  -U TEST_DIR/t.qcow2
+
+_qemu_img_wrapper commit -U TEST_DIR/t.qcow2
+
+_qemu_img_wrapper resize -U TEST_DIR/t.qcow2 32M
+
+_qemu_img_wrapper rebase -U TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
+
+_qemu_img_wrapper snapshot -l -U TEST_DIR/t.qcow2
+
+_qemu_img_wrapper convert -U TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.convert
+
+_qemu_img_wrapper dd -U if=TEST_DIR/t.qcow2 of=TEST_DIR/t.qcow2.convert bs=512 count=1
+
+_qemu_img_wrapper bench -U -c 1 TEST_DIR/t.qcow2
+
+_qemu_img_wrapper bench -U -w -c 1 TEST_DIR/t.qcow2
+
+Round done
+
+== Creating base image ==
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=33554432
+
+== Creating test image ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT.base
+
+== Launching QEMU, opts: 'readonly=off,force-shared-write=off' ==
+
+== Launching another QEMU, opts: '' ==
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=none,: Failed to lock image: Resource temporarily unavailable
+
+== Launching another QEMU, opts: 'readonly=on,force-shared-write=on' ==
+
+== Launching another QEMU, opts: 'readonly=on,force-shared-write=off' ==
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=none,readonly=on,force-shared-write=off: Failed to lock share byte: Resource temporarily unavailable
+
+== Launching another QEMU, opts: 'readonly=off,force-shared-write=on' ==
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=none,readonly=off,force-shared-write=on: Failed to lock write byte: Resource temporarily unavailable
+
+== Launching another QEMU, opts: 'readonly=off,force-shared-write=off' ==
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=none,readonly=off,force-shared-write=off: Failed to lock image: Resource temporarily unavailable
+
+== Running utility commands  ==
+
+_qemu_io_wrapper -c read 0 512 TEST_DIR/t.qcow2
+can't open device TEST_DIR/t.qcow2: Failed to lock image: Resource temporarily unavailable
+
+_qemu_io_wrapper -r -c read 0 512 TEST_DIR/t.qcow2
+can't open device TEST_DIR/t.qcow2: Failed to lock share byte: Resource temporarily unavailable
+
+_qemu_io_wrapper -c open  TEST_DIR/t.qcow2 -c read 0 512
+can't open device TEST_DIR/t.qcow2: Failed to lock image: Resource temporarily unavailable
+
+_qemu_io_wrapper -c open -r  TEST_DIR/t.qcow2 -c read 0 512
+can't open device TEST_DIR/t.qcow2: Failed to lock share byte: Resource temporarily unavailable
+
+_qemu_img_wrapper info TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock share byte: Resource temporarily unavailable
+
+_qemu_img_wrapper check TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock share byte: Resource temporarily unavailable
+
+_qemu_img_wrapper compare TEST_DIR/t.qcow2 TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock share byte: Resource temporarily unavailable
+
+_qemu_img_wrapper map TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock share byte: Resource temporarily unavailable
+
+_qemu_img_wrapper amend -o  TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock image: Resource temporarily unavailable
+
+_qemu_img_wrapper commit TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock image: Resource temporarily unavailable
+
+_qemu_img_wrapper resize TEST_DIR/t.qcow2 32M
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock image: Resource temporarily unavailable
+
+_qemu_img_wrapper rebase TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock image: Resource temporarily unavailable
+
+_qemu_img_wrapper snapshot -l TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock share byte: Resource temporarily unavailable
+
+_qemu_img_wrapper convert TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.convert
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock share byte: Resource temporarily unavailable
+
+_qemu_img_wrapper dd if=TEST_DIR/t.qcow2 of=TEST_DIR/t.qcow2.convert bs=512 count=1
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock share byte: Resource temporarily unavailable
+
+_qemu_img_wrapper bench -c 1 TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock share byte: Resource temporarily unavailable
+
+_qemu_img_wrapper bench -w -c 1 TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock image: Resource temporarily unavailable
+
+== Running utility commands -U ==
+
+_qemu_io_wrapper -U -c read 0 512 TEST_DIR/t.qcow2
+can't open device TEST_DIR/t.qcow2: Failed to lock write byte: Resource temporarily unavailable
+
+_qemu_io_wrapper -U -r -c read 0 512 TEST_DIR/t.qcow2
+
+_qemu_io_wrapper -c open -U TEST_DIR/t.qcow2 -c read 0 512
+can't open device TEST_DIR/t.qcow2: Failed to lock write byte: Resource temporarily unavailable
+
+_qemu_io_wrapper -c open -r -U TEST_DIR/t.qcow2 -c read 0 512
+
+_qemu_img_wrapper info -U TEST_DIR/t.qcow2
+
+_qemu_img_wrapper check -U TEST_DIR/t.qcow2
+
+_qemu_img_wrapper compare -U TEST_DIR/t.qcow2 TEST_DIR/t.qcow2
+
+_qemu_img_wrapper map -U TEST_DIR/t.qcow2
+
+_qemu_img_wrapper amend -o  -U TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock write byte: Resource temporarily unavailable
+
+_qemu_img_wrapper commit -U TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock write byte: Resource temporarily unavailable
+
+_qemu_img_wrapper resize -U TEST_DIR/t.qcow2 32M
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock write byte: Resource temporarily unavailable
+
+_qemu_img_wrapper rebase -U TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock write byte: Resource temporarily unavailable
+
+_qemu_img_wrapper snapshot -l -U TEST_DIR/t.qcow2
+
+_qemu_img_wrapper convert -U TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.convert
+
+_qemu_img_wrapper dd -U if=TEST_DIR/t.qcow2 of=TEST_DIR/t.qcow2.convert bs=512 count=1
+
+_qemu_img_wrapper bench -U -c 1 TEST_DIR/t.qcow2
+
+_qemu_img_wrapper bench -U -w -c 1 TEST_DIR/t.qcow2
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to lock write byte: Resource temporarily unavailable
+
+Round done
+
+== Two devices with the same image (readonly=on,force-shared-write=on - readonly=on,force-shared-write=on) ==
+
+== Two devices with the same image (readonly=on,force-shared-write=on - readonly=on,force-shared-write=off) ==
+
+== Two devices with the same image (readonly=on,force-shared-write=on - readonly=off,force-shared-write=on) ==
+
+== Two devices with the same image (readonly=on,force-shared-write=on - readonly=off,force-shared-write=off) ==
+
+== Two devices with the same image (readonly=on,force-shared-write=off - readonly=on,force-shared-write=on) ==
+
+== Two devices with the same image (readonly=on,force-shared-write=off - readonly=on,force-shared-write=off) ==
+
+== Two devices with the same image (readonly=on,force-shared-write=off - readonly=off,force-shared-write=on) ==
+QEMU_PROG: -drive if=none,file=TEST_DIR/t.qcow2,readonly=off,force-shared-write=on: Share byte lock is taken: Resource temporarily unavailable
+
+== Two devices with the same image (readonly=on,force-shared-write=off - readonly=off,force-shared-write=off) ==
+QEMU_PROG: -drive if=none,file=TEST_DIR/t.qcow2,readonly=off,force-shared-write=off: Failed to lock image: Resource temporarily unavailable
+
+== Two devices with the same image (readonly=off,force-shared-write=on - readonly=on,force-shared-write=on) ==
+
+== Two devices with the same image (readonly=off,force-shared-write=on - readonly=on,force-shared-write=off) ==
+QEMU_PROG: -drive if=none,file=TEST_DIR/t.qcow2,readonly=on,force-shared-write=off: Write byte lock is taken: Resource temporarily unavailable
+
+== Two devices with the same image (readonly=off,force-shared-write=on - readonly=off,force-shared-write=on) ==
+
+== Two devices with the same image (readonly=off,force-shared-write=on - readonly=off,force-shared-write=off) ==
+QEMU_PROG: -drive if=none,file=TEST_DIR/t.qcow2,readonly=off,force-shared-write=off: Failed to lock image: Resource temporarily unavailable
+
+== Two devices with the same image (readonly=off,force-shared-write=off - readonly=on,force-shared-write=on) ==
+
+== Two devices with the same image (readonly=off,force-shared-write=off - readonly=on,force-shared-write=off) ==
+QEMU_PROG: -drive if=none,file=TEST_DIR/t.qcow2,readonly=on,force-shared-write=off: Failed to lock share byte: Resource temporarily unavailable
+
+== Two devices with the same image (readonly=off,force-shared-write=off - readonly=off,force-shared-write=on) ==
+QEMU_PROG: -drive if=none,file=TEST_DIR/t.qcow2,readonly=off,force-shared-write=on: Failed to lock write byte: Resource temporarily unavailable
+
+== Two devices with the same image (readonly=off,force-shared-write=off - readonly=off,force-shared-write=off) ==
+QEMU_PROG: -drive if=none,file=TEST_DIR/t.qcow2,readonly=off,force-shared-write=off: Failed to lock image: Resource temporarily unavailable
+== Creating /var/tmp/q/build/tests/qemu-iotests/scratch/t.qcow2.[abc] ==
+Formatting 'TEST_DIR/t.IMGFMT.a', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT.b', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT.c', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT.b
+
+== Two devices sharing the same file in backing chain ==
+
+== Backing image also as an active device ==
+QEMU_PROG: -drive if=none,file=TEST_DIR/t.qcow2: Failed to lock image: Resource temporarily unavailable
+
+== Backing image also as an active device (ro) ==
+
+== Symbolic link ==
+QEMU_PROG: -drive if=none,file=TEST_DIR/t.qcow2: Failed to lock image: Resource temporarily unavailable
+
+== Closing an image should unlock it ==
+{"return": {}}
+Adding drive
+
+_qemu_io_wrapper TEST_DIR/t.qcow2 -c write 0 512
+can't open device TEST_DIR/t.qcow2: Failed to lock image: Resource temporarily unavailable
+Closing drive
+
+_qemu_io_wrapper TEST_DIR/t.qcow2 -c write 0 512
+Adding two and closing one
+
+_qemu_img_wrapper info TEST_DIR/t.qcow2
+
+_qemu_io_wrapper TEST_DIR/t.qcow2 -c write 0 512
+can't open device TEST_DIR/t.qcow2: Failed to lock image: Resource temporarily unavailable
+Closing the other
+
+_qemu_io_wrapper TEST_DIR/t.qcow2 -c write 0 512
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 893962d..c8ae60e 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -154,6 +154,7 @@
 149 rw auto sudo
 150 rw auto quick
 152 rw auto quick
+153 rw auto quick
 154 rw auto backing quick
 155 rw auto
 156 rw auto quick
-- 
2.9.3
