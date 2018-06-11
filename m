Received: from eggs.gnu.org ([2001:4830:134:3::10]:52980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNmI-0004Ra-MV
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:26:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNmH-0001ij-NG
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:26:38 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 11 Jun 2018 16:25:51 +0200
Message-Id: <20180611142611.6609-10-mreitz@redhat.com>
In-Reply-To: <20180611142611.6609-1-mreitz@redhat.com>
References: <20180611142611.6609-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 09/29] iotests: Test help option for
 unsupporting formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

This adds test cases to 082 for qemu-img create/convert/amend "-o help"
on formats that do not support creation or amendment, respectively.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20180509210023.20283-7-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/082     | 9 +++++++++
 tests/qemu-iotests/082.out | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/tests/qemu-iotests/082 b/tests/qemu-iotests/082
index d5c83d45ed..a872f771a6 100755
--- a/tests/qemu-iotests/082
+++ b/tests/qemu-iotests/082
@@ -97,6 +97,9 @@ run_qemu_img create -f $IMGFMT -o backing_file="$TEST_IMG" -o ,, -o help "$TEST_
 run_qemu_img create -f $IMGFMT -o help
 run_qemu_img create -o help
 
+# Try help option for a format that does not support creation
+run_qemu_img create -f bochs -o help
+
 echo
 echo === convert: Options specified more than once ===
 
@@ -151,6 +154,9 @@ run_qemu_img convert -O $IMGFMT -o backing_file="$TEST_IMG" -o ,, -o help "$TEST
 run_qemu_img convert -O $IMGFMT -o help
 run_qemu_img convert -o help
 
+# Try help option for a format that does not support creation
+run_qemu_img convert -O bochs -o help
+
 echo
 echo === amend: Options specified more than once ===
 
@@ -201,6 +207,9 @@ run_qemu_img amend -f $IMGFMT -o backing_file="$TEST_IMG" -o ,, -o help "$TEST_I
 run_qemu_img amend -f $IMGFMT -o help
 run_qemu_img convert -o help
 
+# Try help option for a format that does not support amendment
+run_qemu_img amend -f bochs -o help
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index 4e52dce8d6..60ef87c276 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -249,6 +249,9 @@ Testing: create -o help
 Supported options:
 size             Virtual disk size
 
+Testing: create -f bochs -o help
+qemu-img: Format driver 'bochs' does not support image creation
+
 === convert: Options specified more than once ===
 
 Testing: create -f qcow2 TEST_DIR/t.qcow2 128M
@@ -502,6 +505,9 @@ Testing: convert -o help
 Supported options:
 size             Virtual disk size
 
+Testing: convert -O bochs -o help
+qemu-img: Format driver 'bochs' does not support image creation
+
 === amend: Options specified more than once ===
 
 Testing: amend -f foo -f qcow2 -o lazy_refcounts=on TEST_DIR/t.qcow2
@@ -763,4 +769,7 @@ Note that not all of these options may be amendable.
 Testing: convert -o help
 Supported options:
 size             Virtual disk size
+
+Testing: amend -f bochs -o help
+qemu-img: Format driver 'bochs' does not support option amendment
 *** done
-- 
2.17.1
