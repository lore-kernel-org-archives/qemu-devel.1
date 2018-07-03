Received: from eggs.gnu.org ([2001:4830:134:3::10]:41341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1faSJ1-0008Qw-Vk
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1faSIw-0000zO-Ld
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1faSIw-0000yj-DH
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:42 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w63KnEUj088419
	for <qemu-devel@nongnu.org>; Tue, 3 Jul 2018 16:53:41 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k0dpa6kfq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 16:53:41 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 3 Jul 2018 14:53:40 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  3 Jul 2018 15:52:08 -0500
In-Reply-To: <20180703205221.24788-1-mdroth@linux.vnet.ibm.com>
References: <20180703205221.24788-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180703205221.24788-2-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL 01/14] qga: unset frozen state if no mount
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
Cc: peter.maydell@linaro.org, Chen Hanxiao <chenhanxiao@gmail.com>

From: Chen Hanxiao <chenhanxiao@gmail.com>

If we set mountpoints to qmp_guest_fsfreeze_freeze_list,
we may got nothing to freeze as all mountpoints are
not valid.
So call ga_unset_frozen in this senario.

Also, if we return 0 frozen fs, there is no need to call
guest-fsfreeze-thaw.

Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Chen Hanxiao <chenhanxiao@gmail.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-posix.c | 6 ++++++
 qga/qapi-schema.json | 4 +++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index eae817191b..594d21ef3e 100644
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
2.11.0
