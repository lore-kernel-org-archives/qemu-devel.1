Received: from eggs.gnu.org ([2001:4830:134:3::10]:46402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpsYt-0005cG-BB
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpsYs-0005xl-Kf
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:53:23 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  7 Sep 2017 10:53:10 +0200
Message-Id: <20170907085310.19353-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-iotests: Add missing -machine accel=qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, cohuck@redhat.com

A basic set of qemu options is initialised in ./common:

    export QEMU_OPTIONS="-nodefaults -machine accel=qtest"

However, two test cases (172 and 186) overwrite QEMU_OPTIONS and neglect
to manually set '-machine accel=qtest'. Add the missing option for 172.
186 probably only copied the code from 172, it doesn't actually need to
overwrite QEMU_OPTIONS, so remove that in 186.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
