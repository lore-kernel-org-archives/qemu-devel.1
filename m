Received: from eggs.gnu.org ([2001:4830:134:3::10]:49729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYu6Z-00042c-Ol
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYu6Y-0004A9-1x
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:31 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 29 Jun 2018 16:09:47 +0200
Message-Id: <20180629140959.6690-18-kwolf@redhat.com>
In-Reply-To: <20180629140959.6690-1-kwolf@redhat.com>
References: <20180629140959.6690-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 17/29] qemu-iotests: Test qcow2 not leaking
 clusters on write error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

This adds a test for a temporary write failure, which simulates the
situation after werror=stop/enospc has stopped the VM. We shouldn't
leave leaked clusters behind in such cases.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/026             | 17 +++++++++++++++++
 tests/qemu-iotests/026.out         |  8 ++++++++
 tests/qemu-iotests/026.out.nocache |  8 ++++++++
 3 files changed, 33 insertions(+)

diff --git a/tests/qemu-iotests/026 b/tests/qemu-iotests/026
index 7fadfbace5..582d254195 100755
--- a/tests/qemu-iotests/026
+++ b/tests/qemu-iotests/026
@@ -200,6 +200,23 @@ done
 done
 done
 
+echo
+echo === Avoid cluster leaks after temporary failure ===
+echo
+
+cat > "$TEST_DIR/blkdebug.conf" <<EOF
+[inject-error]
+event = "write_aio"
+errno = "5"
+once = "on"
+EOF
+
+# After the failed first write, do a second write so that the updated refcount
+# block is actually written back
+_make_test_img 64M
+$QEMU_IO -c "write 0 1M" -c "write 0 1M" "$BLKDBG_TEST_IMG" | _filter_qemu_io
+_check_test_img
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/026.out b/tests/qemu-iotests/026.out
index 8e89416a86..dd10a82b51 100644
--- a/tests/qemu-iotests/026.out
+++ b/tests/qemu-iotests/026.out
@@ -675,4 +675,12 @@ write failed: No space left on device
 
 96 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
+
+=== Avoid cluster leaks after temporary failure ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+write failed: Input/output error
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+No errors were found on the image.
 *** done
diff --git a/tests/qemu-iotests/026.out.nocache b/tests/qemu-iotests/026.out.nocache
index 650ccd8b01..1ca6cda15c 100644
--- a/tests/qemu-iotests/026.out.nocache
+++ b/tests/qemu-iotests/026.out.nocache
@@ -683,4 +683,12 @@ write failed: No space left on device
 
 96 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
+
+=== Avoid cluster leaks after temporary failure ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+write failed: Input/output error
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+No errors were found on the image.
 *** done
-- 
2.13.6
