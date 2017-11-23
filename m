Received: from eggs.gnu.org ([2001:4830:134:3::10]:33852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eHgxP-00059l-Cy
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 21:09:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eHgxJ-0001ih-8B
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 21:09:39 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 23 Nov 2017 03:08:24 +0100
Message-Id: <20171123020832.8165-10-mreitz@redhat.com>
In-Reply-To: <20171123020832.8165-1-mreitz@redhat.com>
References: <20171123020832.8165-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 09/17] iotests: Disable some tests for
 compat=0.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>

Tests 080, 130, 137, and 176 simply do not work with compat=0.10 for the
reasons stated there.

177 is a bit more interesting:  Originally, it was actually very much
intended to work with compat=0.10 (it even had a special case for that).
However, it now prints the test image's map twice, and short of just not
doing that, there is no solution I can imagine that is both simple and
would leave compat=0.10 support intact.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/080 |  5 +++--
 tests/qemu-iotests/130 |  2 ++
 tests/qemu-iotests/137 |  2 ++
 tests/qemu-iotests/176 |  2 ++
 tests/qemu-iotests/177 | 13 +++----------
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tests/qemu-iotests/080 b/tests/qemu-iotests/080
index 55044c700b..1c2bd85742 100755
--- a/tests/qemu-iotests/080
+++ b/tests/qemu-iotests/080
@@ -41,8 +41,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
-# Internal snapshots are (currently) impossible with refcount_bits=1
-_unsupported_imgopts 'refcount_bits=1[^0-9]'
+# - Internal snapshots are (currently) impossible with refcount_bits=1
+# - This is generally a test for compat=1.1 images
+_unsupported_imgopts 'refcount_bits=1[^0-9]' 'compat=0.10'
 
 header_size=104
 
diff --git a/tests/qemu-iotests/130 b/tests/qemu-iotests/130
index e7e43de6d6..2c4b94da1b 100755
--- a/tests/qemu-iotests/130
+++ b/tests/qemu-iotests/130
@@ -45,6 +45,8 @@ _supported_fmt qcow2
 _supported_proto generic
 _unsupported_proto vxhs
 _supported_os Linux
+# We are going to use lazy-refcounts
+_unsupported_imgopts 'compat=0.10'
 
 qemu_comm_method="monitor"
 
diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
index eb91e517d7..5a01250005 100755
--- a/tests/qemu-iotests/137
+++ b/tests/qemu-iotests/137
@@ -41,6 +41,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
+# We are going to use lazy-refcounts
+_unsupported_imgopts 'compat=0.10'
 
 
 _make_test_img 64M
diff --git a/tests/qemu-iotests/176 b/tests/qemu-iotests/176
index b8dc17c592..d38b3aeb91 100755
--- a/tests/qemu-iotests/176
+++ b/tests/qemu-iotests/176
@@ -48,6 +48,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
+# Persistent dirty bitmaps require compat=1.1
+_unsupported_imgopts 'compat=0.10'
 
 function run_qemu()
 {
diff --git a/tests/qemu-iotests/177 b/tests/qemu-iotests/177
index 28990977f1..86cf25f855 100755
--- a/tests/qemu-iotests/177
+++ b/tests/qemu-iotests/177
@@ -39,6 +39,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file
+# This test assumes that discard leaves zero clusters
+_unsupported_imgopts 'compat=0.10'
 
 CLUSTER_SIZE=1M
 size=128M
@@ -93,15 +95,6 @@ echo "== verify image content =="
 
 function verify_io()
 {
-    if ($QEMU_IMG info -f "$IMGFMT" "$TEST_IMG" |
-	    grep "compat: 0.10" > /dev/null); then
-        # For v2 images, discarded clusters are read from the backing file
-        discarded=11
-    else
-        # Discarded clusters are zeroed for v3 or later
-        discarded=0
-    fi
-
     echo read -P 22 0 1000
     echo read -P 33 1000 128k
     echo read -P 22 132072 7871512
@@ -109,7 +102,7 @@ function verify_io()
     echo read -P 22 10096640 23457792
     echo read -P 0 32M 32M
     echo read -P 22 64M 13M
-    echo read -P $discarded 77M 29M
+    echo read -P 0 77M 29M
     echo read -P 22 106M 4M
     echo read -P 11 110M 18M
 }
-- 
2.13.6
