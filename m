Received: from eggs.gnu.org ([2001:4830:134:3::10]:46073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eAcon-0002Ku-2P
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:19:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eAcoi-0007v5-1b
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:19:32 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Fri,  3 Nov 2017 16:18:55 +0200
Message-Id: <7e48b0e2ae1a0a18e0ee303b3045f130feec0474.1509718618.git.berto@igalia.com>
In-Reply-To: <cover.1509718618.git.berto@igalia.com>
References: <cover.1509718618.git.berto@igalia.com>
In-Reply-To: <cover.1509718618.git.berto@igalia.com>
References: <cover.1509718618.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 6/7] qcow2: Add iotest for an empty refcount
 table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Thomas Huth <thuth@redhat.com>, "R . Nageswara Sastry" <nasastry@in.ibm.com>

This patch adds a simple iotest in which we try to write to an image
with an empty refcount table (i.e. with all entries set to 0).

This scenario was already handled by the existing consistency checks,
but we add an explicit test case for completeness.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/060     | 7 +++++++
 tests/qemu-iotests/060.out | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index dc5a517673..66a8fa4aea 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -243,6 +243,13 @@ poke_file "$TEST_IMG" "$(($l2_offset+8))" "\x80\x00\x00\x00\x00\x06\x2a\x00"
 $QEMU_IO -c "discard 0 64k" -c "read 64k 64k" "$TEST_IMG" | _filter_qemu_io
 
 echo
+echo "=== Testing empty refcount table ==="
+echo
+_make_test_img 64M
+poke_file "$TEST_IMG" "$rt_offset"        "\x00\x00\x00\x00\x00\x00\x00\x00"
+$QEMU_IO -c "write 0 64k" "$TEST_IMG" | _filter_qemu_io
+
+echo
 echo "=== Testing empty refcount table with valid L1 and L2 tables ==="
 echo
 _make_test_img 64M
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index 98f314c16d..cfd78f87a9 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -182,6 +182,12 @@ discard 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read failed: Input/output error
 
+=== Testing empty refcount table ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+qcow2: Marking image as corrupt: Preventing invalid write on metadata (overlaps with refcount table); further corruption events will be suppressed
+write failed: Input/output error
+
 === Testing empty refcount table with valid L1 and L2 tables ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-- 
2.11.0
