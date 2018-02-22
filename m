Received: from eggs.gnu.org ([2001:4830:134:3::10]:46651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1eolnu-0007i3-BY
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 03:00:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1eolnq-0005vY-FT
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 03:00:34 -0500
Received: from m15-112.126.com ([220.181.15.112]:53010)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1eolnp-0005r2-9W
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 03:00:30 -0500
From: Chen Hanxiao <chen_han_xiao@126.com>
Date: Thu, 22 Feb 2018 15:59:21 +0800
Message-Id: <20180222075921.9444-1-chen_han_xiao@126.com>
Subject: [Qemu-devel] [PATCH v2] qga: unset frozen state if no mount point
 is frozen
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
So call ga_unset_frozen in this senario.

Also, if we return 0 frozen fs, there is no need to call
guest-fsfreeze-thaw.

Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Chen Hanxiao <chenhanxiao@gmail.com>
---
v2:
  remove has_mountpoints special case
  add qapi-schema.json section

 qga/commands-posix.c | 6 ++++++
 qga/qapi-schema.json | 4 +++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 967061444a..05cf9caa04 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1274,6 +1274,12 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
     }
 
     free_fs_mount_list(&mounts);
+    /* We may not issue any FIFREEZE here.
+     * Just unset ga_state here and ready for the next call.
+     */
+    if (i == 0) {
+        ga_unset_frozen(ga_state);
+    }
     return i;
 
 error:
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 17884c7c70..1045cef386 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -435,7 +435,9 @@
 # for up to 10 seconds by VSS.
 #
 # Returns: Number of file systems currently frozen. On error, all filesystems
-# will be thawed.
+# will be thawed. If no filesystems are frozen as a result of this call,
+# then @guest-fsfreeze-status will remain "thawed" and calling
+# @guest-fsfreeze-thaw is not necessary.
 #
 # Since: 0.15.0
 ##
-- 
2.14.3
