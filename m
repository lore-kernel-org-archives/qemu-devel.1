Received: from eggs.gnu.org ([2001:4830:134:3::10]:35159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1e4M3W-0005ur-JN
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 03:12:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1e4M3T-0001ah-EH
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 03:12:50 -0400
Received: from m15-113.126.com ([220.181.15.113]:55235)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1e4M3S-0001ZH-Mm
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 03:12:47 -0400
From: Chen Hanxiao <chen_han_xiao@126.com>
Date: Tue, 17 Oct 2017 14:41:42 +0800
Message-Id: <20171017064142.4519-1-chen_han_xiao@126.com>
Subject: [Qemu-devel] [Resend][PATCH] qga-win: don't hang if vss hold writes
 timeout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Chen Hanxiao <chen_han_xiao@126.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Tomoki Sekiyama <tomoki.sekiyama@gmail.com>

From: Chen Hanxiao <chenhanxiao@gmail.com>

When VM is in a heavy IO, if the command "guest-fsfreeze-freeze"
is executed, VSS may timeout when trying to hold writes.

Inside guest, Event ID 12298(VSS_ERROR_HOLD_WRITES_TIMEOUT)
is logged in the Event Viewer.

At that time, if we call AbortBackup, qga may hang forever.

This patch will solve this issue.

Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Tomoki Sekiyama <tomoki.sekiyama@gmail.com>

Reviewed-by: Tomoki Sekiyama <tomoki.sekiyama@gmail.com>
Signed-off-by: Chen Hanxiao <chenhanxiao@gmail.com>
---
 qga/vss-win32/requester.cpp | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index 301762d8b1..3d9c9716c0 100644
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
2.13.5
