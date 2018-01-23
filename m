Received: from eggs.gnu.org ([2001:4830:134:3::10]:57821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edz9r-0003a6-OR
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:02:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edz9l-0005tI-SL
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:02:39 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 23 Jan 2018 15:01:42 +0100
Message-Id: <20180123140201.31163-11-kwolf@redhat.com>
In-Reply-To: <20180123140201.31163-1-kwolf@redhat.com>
References: <20180123140201.31163-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 10/29] qemu-iotests: Fix locking issue in 102
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

102 truncates a qcow2 file (the raw file) on purpose while a VM is
running.  However, image locking will usually prevent exactly this.

The fact that most people have not noticed until now (I suppose you may
have seen sporadic failures, but not taken them too seriously, like me)
further shows that this truncation is actually not really done
concurrently, but that the VM is still starting up by this point and has
not yet opened the image.  Remedy this by waiting for the monitor shell
to appear before the qemu-img invocation so we know the VM is up.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20171129185102.29390-1-mreitz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/102     | 7 ++++++-
 tests/qemu-iotests/102.out | 3 ++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/102 b/tests/qemu-iotests/102
index d7ad8d9840..04b3f28445 100755
--- a/tests/qemu-iotests/102
+++ b/tests/qemu-iotests/102
@@ -69,7 +69,12 @@ $QEMU_IO -c 'write 0 64k' "$TEST_IMG" | _filter_qemu_io
 
 qemu_comm_method=monitor _launch_qemu -drive if=none,file="$TEST_IMG",id=drv0
 
-$QEMU_IMG resize -f raw --shrink "$TEST_IMG" $((5 * 64 * 1024))
+# Wait for a prompt to appear (so we know qemu has opened the image)
+_send_qemu_cmd '' '(qemu)'
+
+$QEMU_IMG resize --shrink --image-opts \
+    "driver=raw,file.driver=file,file.filename=$TEST_IMG,file.locking=off" \
+    $((5 * 64 * 1024))
 
 _send_qemu_cmd $QEMU_HANDLE 'qemu-io drv0 map' 'allocated' \
     | sed -e 's/^(qemu).*qemu-io drv0 map...$/(qemu) qemu-io drv0 map/'
diff --git a/tests/qemu-iotests/102.out b/tests/qemu-iotests/102.out
index ccf172abd9..4401b08fee 100644
--- a/tests/qemu-iotests/102.out
+++ b/tests/qemu-iotests/102.out
@@ -14,8 +14,9 @@ Offset          Length          Mapped to       File
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=65536
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Image resized.
 QEMU X.Y.Z monitor - type 'help' for more information
+Image resized.
+(qemu)
 (qemu) qemu-io drv0 map
 64 KiB (0x10000) bytes     allocated at offset 0 bytes (0x0)
 *** done
-- 
2.13.6
