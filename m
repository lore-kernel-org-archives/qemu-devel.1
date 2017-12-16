Received: from eggs.gnu.org ([2001:4830:134:3::10]:37363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1eQ716-0002CM-TT
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 02:36:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1eQ713-0004p0-Qv
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 02:36:16 -0500
Received: from m15-114.126.com ([220.181.15.114]:36438)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1eQ713-0004gn-5G
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 02:36:13 -0500
From: Chen Hanxiao <chen_han_xiao@126.com>
Date: Sat, 16 Dec 2017 15:34:17 +0800
Message-Id: <20171216073417.29847-1-chen_han_xiao@126.com>
Subject: [Qemu-devel] [PATCH] qga: unset frozen state if no mount points are
 frozen
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
