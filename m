Received: from eggs.gnu.org ([2001:4830:134:3::10]:59389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fzIae-0006XK-B4
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 05:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fzIWk-0006aZ-40
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 05:30:43 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Mon, 10 Sep 2018 12:29:23 +0300
Message-Id: <20180910092924.23403-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH] qemu-iotests: Test snapshot=on with
 nonexistent TMPDIR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

We just fixed a bug that was causing a use-after-free when QEMU was
unable to create a temporary snapshot. This is a test case for this
scenario.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 tests/qemu-iotests/051        | 3 +++
 tests/qemu-iotests/051.out    | 3 +++
 tests/qemu-iotests/051.pc.out | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index ee9c820d0f..25d3b2d478 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -354,6 +354,9 @@ printf %b "qemu-io $device_id \"write -P 0x33 0 4k\"\ncommit $device_id\n" |
 
 $QEMU_IO -c "read -P 0x33 0 4k" "$TEST_IMG" | _filter_qemu_io
 
+# Using snapshot=on with a non-existent TMPDIR
+TMPDIR=/nonexistent run_qemu -drive driver=null-co,snapshot=on
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/051.out b/tests/qemu-iotests/051.out
index b7273505c7..793af2ab96 100644
--- a/tests/qemu-iotests/051.out
+++ b/tests/qemu-iotests/051.out
@@ -455,4 +455,7 @@ wrote 4096/4096 bytes at offset 0
 
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Testing: -drive driver=null-co,snapshot=on
+QEMU_PROG: -drive driver=null-co,snapshot=on: Could not get temporary filename: No such file or directory
+
 *** done
diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
index e9257fe318..ca64edae6a 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -527,4 +527,7 @@ wrote 4096/4096 bytes at offset 0
 
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Testing: -drive driver=null-co,snapshot=on
+QEMU_PROG: -drive driver=null-co,snapshot=on: Could not get temporary filename: No such file or directory
+
 *** done
-- 
2.11.0
