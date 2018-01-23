Received: from eggs.gnu.org ([2001:4830:134:3::10]:58120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edzAD-0003z2-Ls
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:03:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edzA9-0006L5-Lc
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:03:01 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 23 Jan 2018 15:01:58 +0100
Message-Id: <20180123140201.31163-27-kwolf@redhat.com>
In-Reply-To: <20180123140201.31163-1-kwolf@redhat.com>
References: <20180123140201.31163-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 26/29] iotests: Filter compat-dependent info in
 198
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

There is a bit of image-specific information which depends on the qcow2
compat level.  Filter it so that 198 works with compat=0.10 (and any
refcount_bits value).

Note that we cannot simply drop the --format-specific switch because we
do need the "encrypt" information.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20171123020832.8165-18-mreitz@redhat.com
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/198     | 6 ++++--
 tests/qemu-iotests/198.out | 8 --------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/tests/qemu-iotests/198 b/tests/qemu-iotests/198
index a84a058396..54eaaf5153 100755
--- a/tests/qemu-iotests/198
+++ b/tests/qemu-iotests/198
@@ -92,12 +92,14 @@ $QEMU_IO --object $SECRET0 --object $SECRET1 -c "read -P 0x9 0 $size" --image-op
 echo
 echo "== checking image base =="
 $QEMU_IMG info --image-opts $IMGSPECBASE | _filter_img_info --format-specific \
-    | sed -e "/^disk size:/ D"
+    | sed -e "/^disk size:/ D" -e '/refcount bits:/ D' -e '/compat:/ D' \
+          -e '/lazy refcounts:/ D' -e '/corrupt:/ D'
 
 echo
 echo "== checking image layer =="
 $QEMU_IMG info --image-opts $IMGSPECLAYER | _filter_img_info --format-specific \
-    | sed -e "/^disk size:/ D"
+    | sed -e "/^disk size:/ D" -e '/refcount bits:/ D' -e '/compat:/ D' \
+          -e '/lazy refcounts:/ D' -e '/corrupt:/ D'
 
 
 # success, all done
diff --git a/tests/qemu-iotests/198.out b/tests/qemu-iotests/198.out
index 2db565e16b..adb805cce9 100644
--- a/tests/qemu-iotests/198.out
+++ b/tests/qemu-iotests/198.out
@@ -36,9 +36,6 @@ image: json:{"encrypt.key-secret": "sec0", "driver": "IMGFMT", "file": {"driver"
 file format: IMGFMT
 virtual size: 16M (16777216 bytes)
 Format specific information:
-    compat: 1.1
-    lazy refcounts: false
-    refcount bits: 16
     encrypt:
         ivgen alg: plain64
         hash alg: sha256
@@ -75,7 +72,6 @@ Format specific information:
                 key offset: 1810432
         payload offset: 2068480
         master key iters: 1024
-    corrupt: false
 
 == checking image layer ==
 image: json:{"encrypt.key-secret": "sec1", "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}}
@@ -83,9 +79,6 @@ file format: IMGFMT
 virtual size: 16M (16777216 bytes)
 backing file: TEST_DIR/t.IMGFMT.base
 Format specific information:
-    compat: 1.1
-    lazy refcounts: false
-    refcount bits: 16
     encrypt:
         ivgen alg: plain64
         hash alg: sha256
@@ -122,5 +115,4 @@ Format specific information:
                 key offset: 1810432
         payload offset: 2068480
         master key iters: 1024
-    corrupt: false
 *** done
-- 
2.13.6
