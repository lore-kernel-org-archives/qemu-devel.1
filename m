Received: from eggs.gnu.org ([2001:4830:134:3::10]:44127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fk9oV-0003NY-BZ
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fk9oR-0008LD-Cq
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:10:23 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 30 Jul 2018 17:09:53 +0200
Message-Id: <20180730150958.14607-9-kwolf@redhat.com>
In-Reply-To: <20180730150958.14607-1-kwolf@redhat.com>
References: <20180730150958.14607-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 08/13] iotests: Add test for 'qemu-img convert
 -C' compatibility
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

From: Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/082     |  8 ++++++++
 tests/qemu-iotests/082.out | 11 +++++++++++
 2 files changed, 19 insertions(+)

diff --git a/tests/qemu-iotests/082 b/tests/qemu-iotests/082
index a872f771a6..3e605d52d1 100755
--- a/tests/qemu-iotests/082
+++ b/tests/qemu-iotests/082
@@ -158,6 +158,14 @@ run_qemu_img convert -o help
 run_qemu_img convert -O bochs -o help
 
 echo
+echo === convert: -C and other options ===
+
+# Adding the help option to a command without other -o options
+run_qemu_img convert -C -S 4k -O $IMGFMT "$TEST_IMG" "$TEST_IMG".target
+run_qemu_img convert -C -S 8k -O $IMGFMT "$TEST_IMG" "$TEST_IMG".target
+run_qemu_img convert -C -c -O $IMGFMT "$TEST_IMG" "$TEST_IMG".target
+
+echo
 echo === amend: Options specified more than once ===
 
 # Last -f should win
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index 60ef87c276..19e9fb13ff 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -508,6 +508,17 @@ size             Virtual disk size
 Testing: convert -O bochs -o help
 qemu-img: Format driver 'bochs' does not support image creation
 
+=== convert: -C and other options ===
+
+Testing: convert -C -S 4k -O qcow2 TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.target
+qemu-img: Cannot enable copy offloading when -S is used
+
+Testing: convert -C -S 8k -O qcow2 TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.target
+qemu-img: Cannot enable copy offloading when -S is used
+
+Testing: convert -C -c -O qcow2 TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.target
+qemu-img: Cannot enable copy offloading when -c is used
+
 === amend: Options specified more than once ===
 
 Testing: amend -f foo -f qcow2 -o lazy_refcounts=on TEST_DIR/t.qcow2
-- 
2.13.6
