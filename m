Received: from eggs.gnu.org ([2001:4830:134:3::10]:52842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gCmuJ-0000D8-5M
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gCmuG-0006Gd-7g
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:34:43 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Wed, 17 Oct 2018 17:33:51 +0300
Message-Id: <3e64535f5e375a67890d3f912bc4618471d8e0ff.1539786605.git.berto@igalia.com>
In-Reply-To: <cover.1539786605.git.berto@igalia.com>
References: <cover.1539786605.git.berto@igalia.com>
In-Reply-To: <cover.1539786605.git.berto@igalia.com>
References: <cover.1539786605.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 3/3] iotest: Test the blkverify mode of the
 Quorum driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 tests/qemu-iotests/081     | 30 ++++++++++++++++++++++++++++++
 tests/qemu-iotests/081.out | 16 ++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/tests/qemu-iotests/081 b/tests/qemu-iotests/081
index da3fb0984b..0ea010afbf 100755
--- a/tests/qemu-iotests/081
+++ b/tests/qemu-iotests/081
@@ -168,6 +168,36 @@ echo "== checking that quorum is broken =="
 
 $QEMU_IO -c "open -o $quorum" -c "read -P 0x32 0 $size" | _filter_qemu_io
 
+echo
+echo "== checking the blkverify mode with broken content =="
+
+quorum="driver=raw,file.driver=quorum,file.vote-threshold=2,file.blkverify=on"
+quorum="$quorum,file.children.0.file.filename=$TEST_DIR/1.raw"
+quorum="$quorum,file.children.1.file.filename=$TEST_DIR/2.raw"
+quorum="$quorum,file.children.0.driver=raw"
+quorum="$quorum,file.children.1.driver=raw"
+
+$QEMU_IO -c "open -o $quorum" -c "read -P 0x32 0 $size" | _filter_qemu_io
+
+echo
+echo "== writing the same data to both files =="
+
+$QEMU_IO -c "write -P 0x32 0 $size" "$TEST_DIR/1.raw" | _filter_qemu_io
+$QEMU_IO -c "write -P 0x32 0 $size" "$TEST_DIR/2.raw" | _filter_qemu_io
+
+echo
+echo "== checking the blkverify mode with valid content =="
+
+$QEMU_IO -c "open -o $quorum" -c "read -P 0x32 0 $size" | _filter_qemu_io
+
+echo
+echo "== checking the blkverify mode with invalid settings =="
+
+quorum="$quorum,file.children.2.file.filename=$TEST_DIR/3.raw"
+quorum="$quorum,file.children.2.driver=raw"
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
 
 == checking that quorum is broken ==
 read failed: Input/output error
+
+== checking the blkverify mode with broken content ==
+quorum: offset=0 bytes=10485760 contents mismatch at offset 0
+
+== writing the same data to both files ==
+wrote 10485760/10485760 bytes at offset 0
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 10485760/10485760 bytes at offset 0
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== checking the blkverify mode with valid content ==
+read 10485760/10485760 bytes at offset 0
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== checking the blkverify mode with invalid settings ==
+can't open: blkverify=on can only be set if there are exactly two files and vote-threshold is 2
 *** done
-- 
2.11.0
