Received: from eggs.gnu.org ([2001:4830:134:3::10]:60661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f4T7w-0003Zy-O6
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f4T7v-0004L5-UA
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:18:08 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri,  6 Apr 2018 17:17:59 +0200
Message-Id: <20180406151759.11223-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH] iotests: 122 needs at least two refcount bits
 now
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

The new test case for compressed clusters (added in commit
abd3622cc03cf41ed542126a540385f30a4c0175) requires two refcount bits to
succeed, so we need to skip the test when refcount_bits=1 was requested.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/122 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
index 6cf4fcb866..95e7c51e72 100755
--- a/tests/qemu-iotests/122
+++ b/tests/qemu-iotests/122
@@ -42,6 +42,10 @@ _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
 
+# Repairing the compressed image requires qemu-img check to store a
+# refcount up to 3, which requires at least two refcount bits.
+_unsupported_imgopts 'refcount_bits=1[^0-9]'
+
 
 TEST_IMG="$TEST_IMG".base _make_test_img 64M
 $QEMU_IO -c "write -P 0x11 0 64M" "$TEST_IMG".base 2>&1 | _filter_qemu_io | _filter_testdir
-- 
2.14.3
