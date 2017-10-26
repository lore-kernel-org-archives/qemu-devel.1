Received: from eggs.gnu.org ([2001:4830:134:3::10]:59492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i4H-0001Nu-Kb
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i4D-0002nm-4H
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:19:29 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 26 Oct 2017 15:17:41 +0200
Message-Id: <20171026131741.5059-36-kwolf@redhat.com>
In-Reply-To: <20171026131741.5059-1-kwolf@redhat.com>
References: <20171026131741.5059-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 35/35] iotests: Add cluster_size=64k to 125
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

Apparently it would be a good idea to test that, too.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20171009215533.12530-4-mreitz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/125     |   7 +-
 tests/qemu-iotests/125.out | 480 ++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 437 insertions(+), 50 deletions(-)

diff --git a/tests/qemu-iotests/125 b/tests/qemu-iotests/125
index 9424313e82..c20c71570c 100755
--- a/tests/qemu-iotests/125
+++ b/tests/qemu-iotests/125
@@ -69,13 +69,15 @@ fi
 # in B
 CREATION_SIZE=$((2 * 1024 * 1024 - 48 * 1024))
 
+# 512 is the actual test -- but it's good to test 64k as well, just to be sure.
+for cluster_size in 512 64k; do
 # in kB
 for GROWTH_SIZE in 16 48 80; do
     for create_mode in off metadata falloc full; do
         for growth_mode in off metadata falloc full; do
-            echo "--- growth_size=$GROWTH_SIZE create_mode=$create_mode growth_mode=$growth_mode ---"
+            echo "--- cluster_size=$cluster_size growth_size=$GROWTH_SIZE create_mode=$create_mode growth_mode=$growth_mode ---"
 
-            IMGOPTS="preallocation=$create_mode,cluster_size=512" _make_test_img ${CREATION_SIZE}
+            IMGOPTS="preallocation=$create_mode,cluster_size=$cluster_size" _make_test_img ${CREATION_SIZE}
             $QEMU_IMG resize -f "$IMGFMT" --preallocation=$growth_mode "$TEST_IMG" +${GROWTH_SIZE}K
 
             host_size_0=$(get_image_size_on_host)
@@ -123,6 +125,7 @@ for GROWTH_SIZE in 16 48 80; do
         done
     done
 done
+done
 
 # success, all done
 echo '*** done'
diff --git a/tests/qemu-iotests/125.out b/tests/qemu-iotests/125.out
index 3f4d6e31a6..596905f533 100644
--- a/tests/qemu-iotests/125.out
+++ b/tests/qemu-iotests/125.out
@@ -1,5 +1,5 @@
 QA output created by 125
---- growth_size=16 create_mode=off growth_mode=off ---
+--- cluster_size=512 growth_size=16 create_mode=off growth_mode=off ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -7,7 +7,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=16 create_mode=off growth_mode=metadata ---
+--- cluster_size=512 growth_size=16 create_mode=off growth_mode=metadata ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -15,7 +15,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=16 create_mode=off growth_mode=falloc ---
+--- cluster_size=512 growth_size=16 create_mode=off growth_mode=falloc ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -23,7 +23,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=16 create_mode=off growth_mode=full ---
+--- cluster_size=512 growth_size=16 create_mode=off growth_mode=full ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -31,7 +31,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=16 create_mode=metadata growth_mode=off ---
+--- cluster_size=512 growth_size=16 create_mode=metadata growth_mode=off ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -39,7 +39,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=16 create_mode=metadata growth_mode=metadata ---
+--- cluster_size=512 growth_size=16 create_mode=metadata growth_mode=metadata ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -47,7 +47,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=16 create_mode=metadata growth_mode=falloc ---
+--- cluster_size=512 growth_size=16 create_mode=metadata growth_mode=falloc ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -55,7 +55,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=16 create_mode=metadata growth_mode=full ---
+--- cluster_size=512 growth_size=16 create_mode=metadata growth_mode=full ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -63,7 +63,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=16 create_mode=falloc growth_mode=off ---
+--- cluster_size=512 growth_size=16 create_mode=falloc growth_mode=off ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -71,7 +71,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=16 create_mode=falloc growth_mode=metadata ---
+--- cluster_size=512 growth_size=16 create_mode=falloc growth_mode=metadata ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -79,7 +79,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=16 create_mode=falloc growth_mode=falloc ---
+--- cluster_size=512 growth_size=16 create_mode=falloc growth_mode=falloc ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -87,7 +87,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=16 create_mode=falloc growth_mode=full ---
+--- cluster_size=512 growth_size=16 create_mode=falloc growth_mode=full ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -95,7 +95,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=16 create_mode=full growth_mode=off ---
+--- cluster_size=512 growth_size=16 create_mode=full growth_mode=off ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -103,7 +103,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=16 create_mode=full growth_mode=metadata ---
+--- cluster_size=512 growth_size=16 create_mode=full growth_mode=metadata ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -111,7 +111,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=16 create_mode=full growth_mode=falloc ---
+--- cluster_size=512 growth_size=16 create_mode=full growth_mode=falloc ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -119,7 +119,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=16 create_mode=full growth_mode=full ---
+--- cluster_size=512 growth_size=16 create_mode=full growth_mode=full ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -127,7 +127,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 16384/16384 bytes at offset 2048000
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=48 create_mode=off growth_mode=off ---
+--- cluster_size=512 growth_size=48 create_mode=off growth_mode=off ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -135,7 +135,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=48 create_mode=off growth_mode=metadata ---
+--- cluster_size=512 growth_size=48 create_mode=off growth_mode=metadata ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -143,7 +143,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=48 create_mode=off growth_mode=falloc ---
+--- cluster_size=512 growth_size=48 create_mode=off growth_mode=falloc ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -151,7 +151,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=48 create_mode=off growth_mode=full ---
+--- cluster_size=512 growth_size=48 create_mode=off growth_mode=full ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -159,7 +159,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=48 create_mode=metadata growth_mode=off ---
+--- cluster_size=512 growth_size=48 create_mode=metadata growth_mode=off ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -167,7 +167,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=48 create_mode=metadata growth_mode=metadata ---
+--- cluster_size=512 growth_size=48 create_mode=metadata growth_mode=metadata ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -175,7 +175,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=48 create_mode=metadata growth_mode=falloc ---
+--- cluster_size=512 growth_size=48 create_mode=metadata growth_mode=falloc ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -183,7 +183,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=48 create_mode=metadata growth_mode=full ---
+--- cluster_size=512 growth_size=48 create_mode=metadata growth_mode=full ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -191,7 +191,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=48 create_mode=falloc growth_mode=off ---
+--- cluster_size=512 growth_size=48 create_mode=falloc growth_mode=off ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -199,7 +199,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=48 create_mode=falloc growth_mode=metadata ---
+--- cluster_size=512 growth_size=48 create_mode=falloc growth_mode=metadata ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -207,7 +207,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=48 create_mode=falloc growth_mode=falloc ---
+--- cluster_size=512 growth_size=48 create_mode=falloc growth_mode=falloc ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -215,7 +215,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=48 create_mode=falloc growth_mode=full ---
+--- cluster_size=512 growth_size=48 create_mode=falloc growth_mode=full ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -223,7 +223,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=48 create_mode=full growth_mode=off ---
+--- cluster_size=512 growth_size=48 create_mode=full growth_mode=off ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -231,7 +231,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=48 create_mode=full growth_mode=metadata ---
+--- cluster_size=512 growth_size=48 create_mode=full growth_mode=metadata ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -239,7 +239,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=48 create_mode=full growth_mode=falloc ---
+--- cluster_size=512 growth_size=48 create_mode=full growth_mode=falloc ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -247,7 +247,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=48 create_mode=full growth_mode=full ---
+--- cluster_size=512 growth_size=48 create_mode=full growth_mode=full ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -255,7 +255,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 49152/49152 bytes at offset 2048000
 48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=80 create_mode=off growth_mode=off ---
+--- cluster_size=512 growth_size=80 create_mode=off growth_mode=off ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -263,7 +263,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=80 create_mode=off growth_mode=metadata ---
+--- cluster_size=512 growth_size=80 create_mode=off growth_mode=metadata ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -271,7 +271,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=80 create_mode=off growth_mode=falloc ---
+--- cluster_size=512 growth_size=80 create_mode=off growth_mode=falloc ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -279,7 +279,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=80 create_mode=off growth_mode=full ---
+--- cluster_size=512 growth_size=80 create_mode=off growth_mode=full ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -287,7 +287,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=80 create_mode=metadata growth_mode=off ---
+--- cluster_size=512 growth_size=80 create_mode=metadata growth_mode=off ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -295,7 +295,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=80 create_mode=metadata growth_mode=metadata ---
+--- cluster_size=512 growth_size=80 create_mode=metadata growth_mode=metadata ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -303,7 +303,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=80 create_mode=metadata growth_mode=falloc ---
+--- cluster_size=512 growth_size=80 create_mode=metadata growth_mode=falloc ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -311,7 +311,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=80 create_mode=metadata growth_mode=full ---
+--- cluster_size=512 growth_size=80 create_mode=metadata growth_mode=full ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -319,7 +319,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=80 create_mode=falloc growth_mode=off ---
+--- cluster_size=512 growth_size=80 create_mode=falloc growth_mode=off ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -327,7 +327,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=80 create_mode=falloc growth_mode=metadata ---
+--- cluster_size=512 growth_size=80 create_mode=falloc growth_mode=metadata ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -335,7 +335,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=80 create_mode=falloc growth_mode=falloc ---
+--- cluster_size=512 growth_size=80 create_mode=falloc growth_mode=falloc ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -343,7 +343,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=80 create_mode=falloc growth_mode=full ---
+--- cluster_size=512 growth_size=80 create_mode=falloc growth_mode=full ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -351,7 +351,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=80 create_mode=full growth_mode=off ---
+--- cluster_size=512 growth_size=80 create_mode=full growth_mode=off ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -359,7 +359,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=80 create_mode=full growth_mode=metadata ---
+--- cluster_size=512 growth_size=80 create_mode=full growth_mode=metadata ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -367,7 +367,7 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=80 create_mode=full growth_mode=falloc ---
+--- cluster_size=512 growth_size=80 create_mode=full growth_mode=falloc ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
@@ -375,7 +375,391 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
---- growth_size=80 create_mode=full growth_mode=full ---
+--- cluster_size=512 growth_size=80 create_mode=full growth_mode=full ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 81920/81920 bytes at offset 2048000
+80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=16 create_mode=off growth_mode=off ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16384/16384 bytes at offset 2048000
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=16 create_mode=off growth_mode=metadata ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16384/16384 bytes at offset 2048000
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=16 create_mode=off growth_mode=falloc ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16384/16384 bytes at offset 2048000
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=16 create_mode=off growth_mode=full ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16384/16384 bytes at offset 2048000
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=16 create_mode=metadata growth_mode=off ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16384/16384 bytes at offset 2048000
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=16 create_mode=metadata growth_mode=metadata ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16384/16384 bytes at offset 2048000
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=16 create_mode=metadata growth_mode=falloc ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16384/16384 bytes at offset 2048000
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=16 create_mode=metadata growth_mode=full ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16384/16384 bytes at offset 2048000
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=16 create_mode=falloc growth_mode=off ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16384/16384 bytes at offset 2048000
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=16 create_mode=falloc growth_mode=metadata ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16384/16384 bytes at offset 2048000
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=16 create_mode=falloc growth_mode=falloc ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16384/16384 bytes at offset 2048000
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=16 create_mode=falloc growth_mode=full ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16384/16384 bytes at offset 2048000
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=16 create_mode=full growth_mode=off ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16384/16384 bytes at offset 2048000
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=16 create_mode=full growth_mode=metadata ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16384/16384 bytes at offset 2048000
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=16 create_mode=full growth_mode=falloc ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16384/16384 bytes at offset 2048000
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=16 create_mode=full growth_mode=full ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16384/16384 bytes at offset 2048000
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=48 create_mode=off growth_mode=off ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 49152/49152 bytes at offset 2048000
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=48 create_mode=off growth_mode=metadata ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 49152/49152 bytes at offset 2048000
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=48 create_mode=off growth_mode=falloc ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 49152/49152 bytes at offset 2048000
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=48 create_mode=off growth_mode=full ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 49152/49152 bytes at offset 2048000
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=48 create_mode=metadata growth_mode=off ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 49152/49152 bytes at offset 2048000
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=48 create_mode=metadata growth_mode=metadata ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 49152/49152 bytes at offset 2048000
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=48 create_mode=metadata growth_mode=falloc ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 49152/49152 bytes at offset 2048000
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=48 create_mode=metadata growth_mode=full ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 49152/49152 bytes at offset 2048000
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=48 create_mode=falloc growth_mode=off ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 49152/49152 bytes at offset 2048000
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=48 create_mode=falloc growth_mode=metadata ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 49152/49152 bytes at offset 2048000
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=48 create_mode=falloc growth_mode=falloc ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 49152/49152 bytes at offset 2048000
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=48 create_mode=falloc growth_mode=full ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 49152/49152 bytes at offset 2048000
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=48 create_mode=full growth_mode=off ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 49152/49152 bytes at offset 2048000
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=48 create_mode=full growth_mode=metadata ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 49152/49152 bytes at offset 2048000
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=48 create_mode=full growth_mode=falloc ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 49152/49152 bytes at offset 2048000
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=48 create_mode=full growth_mode=full ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 49152/49152 bytes at offset 2048000
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=80 create_mode=off growth_mode=off ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 81920/81920 bytes at offset 2048000
+80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=80 create_mode=off growth_mode=metadata ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 81920/81920 bytes at offset 2048000
+80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=80 create_mode=off growth_mode=falloc ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 81920/81920 bytes at offset 2048000
+80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=80 create_mode=off growth_mode=full ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 81920/81920 bytes at offset 2048000
+80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=80 create_mode=metadata growth_mode=off ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 81920/81920 bytes at offset 2048000
+80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=80 create_mode=metadata growth_mode=metadata ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 81920/81920 bytes at offset 2048000
+80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=80 create_mode=metadata growth_mode=falloc ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 81920/81920 bytes at offset 2048000
+80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=80 create_mode=metadata growth_mode=full ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 81920/81920 bytes at offset 2048000
+80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=80 create_mode=falloc growth_mode=off ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 81920/81920 bytes at offset 2048000
+80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=80 create_mode=falloc growth_mode=metadata ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 81920/81920 bytes at offset 2048000
+80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=80 create_mode=falloc growth_mode=falloc ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 81920/81920 bytes at offset 2048000
+80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=80 create_mode=falloc growth_mode=full ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 81920/81920 bytes at offset 2048000
+80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=80 create_mode=full growth_mode=off ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 81920/81920 bytes at offset 2048000
+80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=80 create_mode=full growth_mode=metadata ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 81920/81920 bytes at offset 2048000
+80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=80 create_mode=full growth_mode=falloc ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 81920/81920 bytes at offset 2048000
+80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- cluster_size=64k growth_size=80 create_mode=full growth_mode=full ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
 Image resized.
 wrote 2048000/2048000 bytes at offset 0
-- 
2.13.6
