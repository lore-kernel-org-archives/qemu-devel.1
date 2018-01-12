Received: from eggs.gnu.org ([2001:4830:134:3::10]:41833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1eZpQA-0000Pd-2S
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 21:50:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1eZpQ6-0002sv-TY
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 21:50:18 -0500
Received: from m15-114.126.com ([220.181.15.114]:56065)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1eZpQ6-0002oJ-8y
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 21:50:14 -0500
From: Chen Hanxiao <chen_han_xiao@126.com>
Date: Fri, 12 Jan 2018 10:47:45 +0800
Message-Id: <20180112024745.7609-1-chen_han_xiao@126.com>
Subject: [Qemu-devel] [resend][PATCH] qga: unset frozen state if no mount
 points are frozen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Chen Hanxiao <chen_han_xiao@126.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

From: Chen Hanxiao <chenhanxiao@gmail.com>

If we set mountpoints to qmp_guest_fsfreeze_freeze_list,
we may got nothing to freeze as all mountpoints are
not valid.
Call ga_unset_frozen in this senario.

Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Chen Hanxiao <chenhanxiao@gmail.com>
---
Rebase on master

 qga/commands-posix.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index e809e382eb..9fd51f1d7a 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1273,6 +1273,12 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
     }
 
     free_fs_mount_list(&mounts);
+    /* We may not issue any FIFREEZE here when had mountpoints.
+     * Just unset ga_state here and ready for the next call.
+     */
+    if (has_mountpoints && i == 0) {
+        ga_unset_frozen(ga_state);
+    }
     return i;
 
 error:
-- 
2.14.3
