Received: from eggsout.gnu.org ([209.51.188.92]:39908 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <npes87184@gmail.com>) id 1gfhYm-0002qv-NE
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 03:44:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <npes87184@gmail.com>) id 1gfhYg-0002MA-W5
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 03:43:59 -0500
From: yuchenlin <npes87184@gmail.com>
Date: Sat,  5 Jan 2019 16:42:43 +0800
Message-Id: <20190105084243.9524-1-npes87184@gmail.com>
Subject: [Qemu-devel] [PATCH] qemu-iotests: add test case for dmg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, yuchenlin <npes87184@gmail.com>

Recently, some bugs in dmg file have been fixed. To prevent reading dmg
is broken someday in the future, add a simple test which ensures the
conversion from dmg to raw should not hang or face any I/O error.

Signed-off-by: yuchenlin <npes87184@gmail.com>
---
 tests/qemu-iotests/236                        |  53 ++++++++++++++++++
 tests/qemu-iotests/236.out                    |   4 ++
 tests/qemu-iotests/check                      |   7 +++
 tests/qemu-iotests/group                      |   1 +
 .../sample_images/simple-dmg.dmg.bz2          | Bin 0 -> 3479 bytes
 5 files changed, 65 insertions(+)
 create mode 100755 tests/qemu-iotests/236
 create mode 100644 tests/qemu-iotests/236.out
 create mode 100644 tests/qemu-iotests/sample_images/simple-dmg.dmg.bz2

diff --git a/tests/qemu-iotests/236 b/tests/qemu-iotests/236
new file mode 100755
index 0000000000..6f085d573d
--- /dev/null
+++ b/tests/qemu-iotests/236
@@ -0,0 +1,53 @@
+#!/bin/bash
+#
+# Test case for dmg
+#
+# Copyright (C) 2019 yuchenlin <npes87184@gmail.com>
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
+owner=npes87184@gmail.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+
+_cleanup()
+{
+    rm -f "$TEST_IMG.raw"
+    _cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+
+_supported_fmt dmg
+_supported_proto file
+_supported_os Linux
+
+echo
+echo "== Testing conversion to raw should success =="
+_use_sample_img simple-dmg.dmg.bz2
+if ! $QEMU_IMG convert -f $IMGFMT -O raw "$TEST_IMG" "$TEST_IMG.raw" ; then
+    exit 1
+fi
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/236.out b/tests/qemu-iotests/236.out
new file mode 100644
index 0000000000..a92fc657dd
--- /dev/null
+++ b/tests/qemu-iotests/236.out
@@ -0,0 +1,4 @@
+QA output created by 236
+
+== Testing conversion to raw should success ==
+*** done
diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 89ed275988..895e1e3dcb 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -237,6 +237,7 @@ image format options
     -vhdx               test vhdx
     -vmdk               test vmdk
     -luks               test luks
+    -dmg                test dmg
 
 image protocol options
     -file               test file (default)
@@ -304,6 +305,12 @@ testlist options
             xpand=false
             ;;
 
+        -dmg)
+            IMGFMT=dmg
+            IMGFMT_GENERIC=false
+            xpand=false
+            ;;
+
         -qed)
             IMGFMT=qed
             xpand=false
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 61a6d98ebd..623ede30f5 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -233,3 +233,4 @@
 233 auto quick
 234 auto quick migration
 235 auto quick
+236 rw auto quick
diff --git a/tests/qemu-iotests/sample_images/simple-dmg.dmg.bz2 b/tests/qemu-iotests/sample_images/simple-dmg.dmg.bz2
new file mode 100644
index 0000000000000000000000000000000000000000..05e719d03d48d6df4f0e995dd8bae1ce54c9f5f0
GIT binary patch
literal 3479
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
FP^-7hd6WPE

literal 0
HcmV?d00001

-- 
2.17.1
