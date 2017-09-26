Received: from eggs.gnu.org ([2001:4830:134:3::10]:60854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwqkA-0001Dq-4R
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:21:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwqk9-0005DQ-6v
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:21:50 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 26 Sep 2017 16:21:10 +0200
Message-Id: <20170926142133.2498-2-kwolf@redhat.com>
In-Reply-To: <20170926142133.2498-1-kwolf@redhat.com>
References: <20170926142133.2498-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 01/24] qemu-iotests: Add missing -machine
 accel=qtest
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

A basic set of qemu options is initialised in ./common:

    export QEMU_OPTIONS="-nodefaults -machine accel=qtest"

However, two test cases (172 and 186) overwrite QEMU_OPTIONS and neglect
to manually set '-machine accel=qtest'. Add the missing option for 172.
186 probably only copied the code from 172, it doesn't actually need to
overwrite QEMU_OPTIONS, so remove that in 186.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Tested-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 tests/qemu-iotests/172 | 2 +-
 tests/qemu-iotests/186 | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/172 b/tests/qemu-iotests/172
index 826d6fecd3..02c5f79bab 100755
--- a/tests/qemu-iotests/172
+++ b/tests/qemu-iotests/172
@@ -56,7 +56,7 @@ function do_run_qemu()
             done
         fi
         echo quit
-    ) | $QEMU -nographic -monitor stdio -serial none "$@"
+    ) | $QEMU -machine accel=qtest -nographic -monitor stdio -serial none "$@"
     echo
 }
 
diff --git a/tests/qemu-iotests/186 b/tests/qemu-iotests/186
index 2b9f618f90..44cc01ed87 100755
--- a/tests/qemu-iotests/186
+++ b/tests/qemu-iotests/186
@@ -56,15 +56,15 @@ function do_run_qemu()
             done
         fi
         echo quit
-    ) | $QEMU -S -nodefaults -display none -device virtio-scsi-pci -monitor stdio "$@" 2>&1
+    ) | $QEMU -S -display none -device virtio-scsi-pci -monitor stdio "$@" 2>&1
     echo
 }
 
 function check_info_block()
 {
     echo "info block" |
-    QEMU_OPTIONS="" do_run_qemu "$@" | _filter_win32 | _filter_hmp |
-        _filter_qemu | _filter_generated_node_ids
+    do_run_qemu "$@" | _filter_win32 | _filter_hmp | _filter_qemu |
+        _filter_generated_node_ids
 }
 
 
-- 
2.13.5
