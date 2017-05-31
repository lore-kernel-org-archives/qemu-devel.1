Received: from eggs.gnu.org ([2001:4830:134:3::10]:37583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dG4qz-00011Q-V5
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:44:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dG4qz-0004sX-5d
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:44:06 -0400
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Wed, 31 May 2017 17:43:31 +0300
Message-ID: <20170531144331.30173-3-pbutsykin@virtuozzo.com>
In-Reply-To: <20170531144331.30173-1-pbutsykin@virtuozzo.com>
References: <20170531144331.30173-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/2] qemu-iotests: add reducing image test in
 025
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, pbutsykin@virtuozzo.com

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 tests/qemu-iotests/025     | 19 +++++++++++++++++--
 tests/qemu-iotests/025.out | 12 +++++++++++-
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/025 b/tests/qemu-iotests/025
index f5e672e6b3..658601579b 100755
--- a/tests/qemu-iotests/025
+++ b/tests/qemu-iotests/025
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 . ./common.pattern
 
-_supported_fmt raw qcow2 qed
+_supported_fmt raw qcow2
 _supported_proto file sheepdog rbd nfs
 _supported_os Linux
 
@@ -46,6 +46,7 @@ echo "=== Creating image"
 echo
 small_size=$((128 * 1024 * 1024))
 big_size=$((384 * 1024 * 1024))
+bigger_size=$((512 * 1024 * 1024))
 _make_test_img $small_size
 
 echo
@@ -54,7 +55,20 @@ io_pattern write 0 $small_size 0 1 0xc5
 _check_test_img
 
 echo
-echo "=== Resizing image"
+echo "=== Growing image"
+$QEMU_IO "$TEST_IMG" <<EOF | _filter_qemu_io
+length
+truncate $bigger_size
+length
+EOF
+_check_test_img
+
+echo
+echo "=== Verifying image size after reopen"
+$QEMU_IO -c "length" "$TEST_IMG"
+
+echo
+echo "=== Reducing image"
 $QEMU_IO "$TEST_IMG" <<EOF | _filter_qemu_io
 length
 truncate $big_size
@@ -70,6 +84,7 @@ echo
 echo "=== Verifying resized image"
 io_pattern read 0 $small_size 0 1 0xc5
 io_pattern read $small_size $(($big_size - $small_size)) 0 1 0
+io_pattern read $big_size $(($bigger_size - $big_size)) 0 1 0
 
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/025.out b/tests/qemu-iotests/025.out
index f13fc2863c..a0293711c7 100644
--- a/tests/qemu-iotests/025.out
+++ b/tests/qemu-iotests/025.out
@@ -9,8 +9,16 @@ wrote 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
 
-=== Resizing image
+=== Growing image
 128 MiB
+512 MiB
+No errors were found on the image.
+
+=== Verifying image size after reopen
+512 MiB
+
+=== Reducing image
+512 MiB
 384 MiB
 No errors were found on the image.
 
@@ -24,4 +32,6 @@ read 134217728/134217728 bytes at offset 0
 === IO: pattern 0
 read 268435456/268435456 bytes at offset 134217728
 256 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+=== IO: pattern 0
+read failed: Input/output error
 *** done
-- 
2.11.0
