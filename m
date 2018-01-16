Received: from eggs.gnu.org ([2001:4830:134:3::10]:55711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ebQvS-0002lt-03
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:05:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ebQvM-0006X4-9G
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:05:13 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 16 Jan 2018 16:04:30 +0300
Message-Id: <1516107870-8110-10-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1516107870-8110-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1516107870-8110-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 9/9] iotest 134: test cluster-misaligned
 encrypted write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

COW (even empty/zero) areas require encryption too

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 tests/qemu-iotests/134     |  9 +++++++++
 tests/qemu-iotests/134.out | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
index 9914415..6083ae4 100755
--- a/tests/qemu-iotests/134
+++ b/tests/qemu-iotests/134
@@ -59,6 +59,15 @@ echo "== reading whole image =="
 $QEMU_IO --object $SECRET -c "read 0 $size" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
 
 echo
+echo "== rewriting cluster part =="
+$QEMU_IO --object $SECRET -c "write -P 0xb 512 512" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
+
+echo
+echo "== verify pattern =="
+$QEMU_IO --object $SECRET -c "read -P 0 0 512"  --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
+$QEMU_IO --object $SECRET -c "read -P 0xb 512 512"  --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
+
+echo
 echo "== rewriting whole image =="
 $QEMU_IO --object $SECRET -c "write -P 0xa 0 $size" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
 
diff --git a/tests/qemu-iotests/134.out b/tests/qemu-iotests/134.out
index 972be49..09d46f6 100644
--- a/tests/qemu-iotests/134.out
+++ b/tests/qemu-iotests/134.out
@@ -5,6 +5,16 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption=on encrypt.
 read 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
+== rewriting cluster part ==
+wrote 512/512 bytes at offset 512
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== verify pattern ==
+read 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 512
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
 == rewriting whole image ==
 wrote 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-- 
2.7.4
