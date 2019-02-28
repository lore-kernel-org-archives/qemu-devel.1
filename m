Received: from eggs.gnu.org ([209.51.188.92]:56902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1gzP16-0005Ir-S9
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:58:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1gzP14-0007I0-Ux
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:58:40 -0500
Received: from mga17.intel.com ([192.55.52.151]:63409)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1gzP13-0007Dq-A8
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:58:38 -0500
From: Zhang Chen <chen.zhang@intel.com >
Date: Fri,  1 Mar 2019 00:55:04 +0800
Message-Id: <20190228165508.21594-4-chen.zhang@intel.com>
In-Reply-To: <20190228165508.21594-1-chen.zhang@intel.com>
References: <20190228165508.21594-1-chen.zhang@intel.com>
Subject: [Qemu-devel] [PATCH V2 3/7] Migration/colo.c: Make COLO node
 running after failover
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

Delay to close COLO for auto start VM after failover.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/colo.c      | 1 -
 migration/migration.c | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/colo.c b/migration/colo.c
index a13acac192..89325952c7 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -875,7 +875,6 @@ out:
         qemu_fclose(mis->to_src_file);
         mis->to_src_file = NULL;
     }
-    migration_incoming_disable_colo();
 
     rcu_unregister_thread();
     return NULL;
diff --git a/migration/migration.c b/migration/migration.c
index 37e06b76dc..cec5f529c3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -383,6 +383,9 @@ static void process_incoming_migration_bh(void *opaque)
         } else {
             runstate_set(RUN_STATE_PAUSED);
         }
+    } else if (migration_incoming_colo_enabled()) {
+        migration_incoming_disable_colo();
+        vm_start();
     } else {
         runstate_set(global_state_get_runstate());
     }
-- 
2.17.GIT
