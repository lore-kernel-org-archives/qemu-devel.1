Received: from eggs.gnu.org ([209.51.188.92]:56983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1gzP1D-0005OK-9A
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:58:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1gzP1B-0007L6-9Q
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:58:46 -0500
Received: from mga17.intel.com ([192.55.52.151]:63406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1gzP1A-0007D6-RG
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:58:45 -0500
From: Zhang Chen <chen.zhang@intel.com >
Date: Fri,  1 Mar 2019 00:55:07 +0800
Message-Id: <20190228165508.21594-7-chen.zhang@intel.com>
In-Reply-To: <20190228165508.21594-1-chen.zhang@intel.com>
References: <20190228165508.21594-1-chen.zhang@intel.com>
Subject: [Qemu-devel] [PATCH V2 6/7] Migration/colo.c: Add the necessary
 checks for colo_do_failover
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-dev <qemu-devel@nongnu.org>
Cc: Zhang Chen <chen.zhang@intel.com>

From: Zhang Chen <chen.zhang@intel.com>

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 migration/colo.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index dbe2b88807..d1ae2e6d11 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -197,10 +197,16 @@ void colo_do_failover(MigrationState *s)
         vm_stop_force_state(RUN_STATE_COLO);
     }
 
-    if (get_colo_mode() == COLO_MODE_PRIMARY) {
+    switch (get_colo_mode()) {
+    case COLO_MODE_PRIMARY:
         primary_vm_do_failover();
-    } else {
+        break;
+    case COLO_MODE_SECONDARY:
         secondary_vm_do_failover();
+        break;
+    default:
+        error_report("colo_do_failover failed because the colo mode"
+                     " could not be obtained");
     }
 }
 
-- 
2.17.GIT
