Received: from eggs.gnu.org ([2001:4830:134:3::10]:49940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1co5G9-000113-IR
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 05:30:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1co5G8-0000bf-Bc
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 05:30:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1co5G8-0000bE-2f
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 05:30:20 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 15 Mar 2017 17:29:40 +0800
Message-Id: <20170315092940.1367-9-stefanha@redhat.com>
In-Reply-To: <20170315092940.1367-1-stefanha@redhat.com>
References: <20170315092940.1367-1-stefanha@redhat.com>
Subject: [Qemu-devel] [RFC v2 8/8] iotests: add test 178 for qemu-img measure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Nir Soffer <nsoffer@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/178           | 75 ++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/178.out.qcow2 | 33 ++++++++++++++++++
 tests/qemu-iotests/178.out.raw   | 33 ++++++++++++++++++
 tests/qemu-iotests/group         |  1 +
 4 files changed, 142 insertions(+)
 create mode 100755 tests/qemu-iotests/178
 create mode 100644 tests/qemu-iotests/178.out.qcow2
 create mode 100644 tests/qemu-iotests/178.out.raw

diff --git a/tests/qemu-iotests/178 b/tests/qemu-iotests/178
new file mode 100755
index 0000000..8db1241
--- /dev/null
+++ b/tests/qemu-iotests/178
@@ -0,0 +1,75 @@
+#!/bin/bash
+#
+# qemu-img measure sub-command tests
+#
+# Copyright (C) 2017 Red Hat, Inc.
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
+owner=stefanha@redhat.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+here=`pwd`
+status=1    # failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+. ./common.pattern
+
+_supported_fmt raw qcow2
+_supported_proto file
+_supported_os Linux
+
+echo "Input validation"
+echo
+
+_make_test_img 1G
+
+$QEMU_IMG measure # missing arguments
+$QEMU_IMG measure --size 2G "$TEST_IMG" # only one allowed
+$QEMU_IMG measure "$TEST_IMG" a # only one filename allowed
+$QEMU_IMG measure --object secret,id=sec0,data=MTIzNDU2,format=base64 # missing filename
+$QEMU_IMG measure --image-opts # missing filename
+$QEMU_IMG measure -f qcow2 # missing filename
+$QEMU_IMG measure -l snap1 # missing filename
+$QEMU_IMG measure -o , # invalid option list
+$QEMU_IMG measure -l snapshot.foo # invalid snapshot option
+$QEMU_IMG measure --output foo # invalid output format
+$QEMU_IMG measure --size -1 # invalid image size
+$QEMU_IMG measure -O foo "$TEST_IMG" # unknown image file format
+
+echo
+echo "Size calculation"
+echo
+
+for ofmt in human json; do
+    $QEMU_IMG measure --output=$ofmt -O "$IMGFMT" --size 2G
+    $QEMU_IMG measure --output=$ofmt -f "$IMGFMT" -O "$IMGFMT" "$TEST_IMG"
+done
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/178.out.qcow2 b/tests/qemu-iotests/178.out.qcow2
new file mode 100644
index 0000000..3fe3f5f
--- /dev/null
+++ b/tests/qemu-iotests/178.out.qcow2
@@ -0,0 +1,33 @@
+QA output created by 178
+Input validation
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
+qemu-img: Either --size N or one filename must be specified.
+qemu-img: --size N cannot be used together with a filename.
+qemu-img: At most one filename argument is allowed.
+qemu-img: --object, --image-opts, -f, and -l require a filename argument.
+qemu-img: --object, --image-opts, -f, and -l require a filename argument.
+qemu-img: --object, --image-opts, -f, and -l require a filename argument.
+qemu-img: --object, --image-opts, -f, and -l require a filename argument.
+qemu-img: Invalid option list: ,
+qemu-img: Invalid parameter 'snapshot.foo'
+qemu-img: Failed in parsing snapshot param 'snapshot.foo'
+qemu-img: --output must be used with human or json as argument.
+qemu-img: Image size must be less than 8 EiB!
+qemu-img: Unknown file format 'foo'
+
+Size calculation
+
+required bytes: 589824
+fully allocated bytes: 2148073472
+required bytes: 327680
+fully allocated bytes: 1074069504
+{
+    "required-bytes": 589824,
+    "fully-allocated-bytes": 2148073472
+}
+{
+    "required-bytes": 327680,
+    "fully-allocated-bytes": 1074069504
+}
+*** done
diff --git a/tests/qemu-iotests/178.out.raw b/tests/qemu-iotests/178.out.raw
new file mode 100644
index 0000000..4b89dd0
--- /dev/null
+++ b/tests/qemu-iotests/178.out.raw
@@ -0,0 +1,33 @@
+QA output created by 178
+Input validation
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
+qemu-img: Either --size N or one filename must be specified.
+qemu-img: --size N cannot be used together with a filename.
+qemu-img: At most one filename argument is allowed.
+qemu-img: --object, --image-opts, -f, and -l require a filename argument.
+qemu-img: --object, --image-opts, -f, and -l require a filename argument.
+qemu-img: --object, --image-opts, -f, and -l require a filename argument.
+qemu-img: --object, --image-opts, -f, and -l require a filename argument.
+qemu-img: Invalid option list: ,
+qemu-img: Invalid parameter 'snapshot.foo'
+qemu-img: Failed in parsing snapshot param 'snapshot.foo'
+qemu-img: --output must be used with human or json as argument.
+qemu-img: Image size must be less than 8 EiB!
+qemu-img: Unknown file format 'foo'
+
+Size calculation
+
+required bytes: 2147483648
+fully allocated bytes: 2147483648
+required bytes: 1073741824
+fully allocated bytes: 1073741824
+{
+    "required-bytes": 2147483648,
+    "fully-allocated-bytes": 2147483648
+}
+{
+    "required-bytes": 1073741824,
+    "fully-allocated-bytes": 1073741824
+}
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 1f4bf03..846f962 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -168,3 +168,4 @@
 173 rw auto
 174 auto
 175 auto quick
+178 auto quick
-- 
2.9.3
