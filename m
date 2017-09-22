Received: from eggs.gnu.org ([2001:4830:134:3::10]:49766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1dvDzJ-0002Je-4q
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 22:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1dvDzC-0005Dv-O9
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 22:46:45 -0400
Received: from m15-111.126.com ([220.181.15.111]:60931)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1dvDzB-00058A-Ts
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 22:46:38 -0400
From: Chen Hanxiao <chen_han_xiao@126.com>
Date: Fri, 22 Sep 2017 10:46:06 +0800
Message-Id: <1506048366-23368-1-git-send-email-chen_han_xiao@126.com>
Subject: [Qemu-devel] [PATCH] qga-win: don't hang if vss hold writes timeout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com
Cc: tomoki.sekiyama@gmail.com, qemu-devel@nongnu.org, Chen Hanxiao <chen_han_xiao@126.com>

From: Chen Hanxiao <chenhanxiao@gmail.com>

When VM is in a heavy IO, if the command "guest-fsfreeze-freeze"
is executed, VSS may timeout when trying to hold writes.

Inside guest, Event ID 12298(VSS_ERROR_HOLD_WRITES_TIMEOUT)
is logged in the Event Viewer.

At that time, if we call AbortBackup, qga may hang forever.

This patch will solve this issues.

Signed-off-by: Chen Hanxiao <chenhanxiao@gmail.com>
---
 qga/vss-win32/requester.cpp | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index 301762d..3d9c971 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -419,6 +419,16 @@ void requester_freeze(int *num_vols, ErrorSet *errset)
             break;
         }
     }
+
+    if (wait_status == WAIT_TIMEOUT) {
+        err_set(errset, E_FAIL,
+                "timeout when try to receive Frozen event from VSS provider");
+        /* If we are here, VSS had timeout.
+         * Don't call AbortBackup, just return directly.
+         */
+        goto out1;
+    }
+
     if (wait_status != WAIT_OBJECT_0) {
         err_set(errset, E_FAIL,
                 "couldn't receive Frozen event from VSS provider");
@@ -432,6 +442,8 @@ out:
     if (vss_ctx.pVssbc) {
         vss_ctx.pVssbc->AbortBackup();
     }
+
+out1:
     requester_cleanup();
     CoUninitialize();
 }
-- 
2.7.5
