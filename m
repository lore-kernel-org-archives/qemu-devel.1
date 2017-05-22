Received: from eggs.gnu.org ([2001:4830:134:3::10]:42618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dCrkD-0006OE-Mm
	for qemu-devel@nongnu.org; Mon, 22 May 2017 14:07:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dCrkC-0000f3-E5
	for qemu-devel@nongnu.org; Mon, 22 May 2017 14:07:49 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 22 May 2017 20:07:35 +0200
Message-Id: <20170522180735.26677-3-mreitz@redhat.com>
In-Reply-To: <20170522180735.26677-1-mreitz@redhat.com>
References: <20170522180735.26677-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] iotests: Add test for colon handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
I apologize for the patch title for sounding a bit squishy. But I like
it so I won't change it.
---
 tests/qemu-iotests/126     | 76 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/126.out | 16 ++++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 93 insertions(+)
 create mode 100755 tests/qemu-iotests/126
 create mode 100644 tests/qemu-iotests/126.out

diff --git a/tests/qemu-iotests/126 b/tests/qemu-iotests/126
new file mode 100755
index 0000000..1445a81
--- /dev/null
+++ b/tests/qemu-iotests/126
@@ -0,0 +1,76 @@
+#!/bin/bash
+#
+# Tests handling of colons in filenames (which may be confused with protocol
+# prefixes)
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
+owner=mreitz@redhat.com
+
+seq="$(basename $0)"
+echo "QA output created by $seq"
+
+here="$PWD"
+status=1	# failure is the default!
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+# Needs backing file support
+_supported_fmt qcow qcow2 qed vmdk
+# This is the default protocol (and we want to test the difference between
+# colons which separate a protocol prefix from the rest and colons which are
+# just part of the filename, so we cannot test protocols which require a prefix)
+_supported_proto file
+_supported_os Linux
+
+echo
+echo '=== Testing plain files ==='
+echo
+
+# A colon after a slash is not a protocol prefix separator
+TEST_IMG="$TEST_DIR/a:b.$IMGFMT" _make_test_img 64M
+_rm_test_img "$TEST_DIR/a:b.$IMGFMT"
+
+# But if you want to be really sure, you can do this
+TEST_IMG="file:$TEST_DIR/a:b.$IMGFMT" _make_test_img 64M
+_rm_test_img "$TEST_DIR/a:b.$IMGFMT"
+
+
+echo
+echo '=== Testing relative backing filename resolution ==='
+echo
+
+BASE_IMG="$TEST_DIR/image:base.$IMGFMT"
+TOP_IMG="$TEST_DIR/image:top.$IMGFMT"
+
+TEST_IMG=$BASE_IMG _make_test_img 64M
+TEST_IMG=$TOP_IMG _make_test_img -b ./image:base.$IMGFMT
+
+# The default cluster size depends on the image format
+TEST_IMG=$TOP_IMG _img_info | grep -v 'cluster_size'
+
+_rm_test_img "$BASE_IMG"
+_rm_test_img "$TOP_IMG"
+
+
+# success, all done
+echo '*** done'
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/126.out b/tests/qemu-iotests/126.out
new file mode 100644
index 0000000..52991bb
--- /dev/null
+++ b/tests/qemu-iotests/126.out
@@ -0,0 +1,16 @@
+QA output created by 126
+
+=== Testing plain files ===
+
+Formatting 'TEST_DIR/a:b.IMGFMT', fmt=IMGFMT size=67108864
+Formatting 'TEST_DIR/a:b.IMGFMT', fmt=IMGFMT size=67108864
+
+=== Testing relative backing filename resolution ===
+
+Formatting 'TEST_DIR/image:base.IMGFMT', fmt=IMGFMT size=67108864
+Formatting 'TEST_DIR/image:top.IMGFMT', fmt=IMGFMT size=67108864 backing_file=./image:base.IMGFMT
+image: TEST_DIR/image:top.IMGFMT
+file format: IMGFMT
+virtual size: 64M (67108864 bytes)
+backing file: ./image:base.IMGFMT (actual path: TEST_DIR/./image:base.IMGFMT)
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 5c8ea0f..30717cb 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -130,6 +130,7 @@
 122 rw auto
 123 rw auto quick
 124 rw auto backing
+126 rw auto backing
 128 rw auto quick
 129 rw auto quick
 130 rw auto quick
-- 
2.9.4
