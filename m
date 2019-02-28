Received: from eggs.gnu.org ([209.51.188.92]:56886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1gzP14-0005H8-U4
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:58:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1gzP13-0007Go-AF
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:58:38 -0500
Received: from mga17.intel.com ([192.55.52.151]:63406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1gzP12-0007D6-Uu
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:58:37 -0500
From: Zhang Chen <chen.zhang@intel.com >
Date: Fri,  1 Mar 2019 00:55:03 +0800
Message-Id: <20190228165508.21594-3-chen.zhang@intel.com>
In-Reply-To: <20190228165508.21594-1-chen.zhang@intel.com>
References: <20190228165508.21594-1-chen.zhang@intel.com>
Subject: [Qemu-devel] [PATCH V2 2/7] Migration/colo.c: Fix COLO failover
 status error
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

When finished COLO failover, the status is FAILOVER_STATUS_COMPLETED.
The origin codes misunderstand the FAILOVER_STATUS_REQUIRE.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 migration/colo.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index a916dc178c..a13acac192 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -121,6 +121,7 @@ static void secondary_vm_do_failover(void)
     }
     /* Notify COLO incoming thread that failover work is finished */
     qemu_sem_post(&mis->colo_incoming_sem);
+
     /* For Secondary VM, jump to incoming co */
     if (mis->migration_incoming_co) {
         qemu_coroutine_enter(mis->migration_incoming_co);
@@ -262,7 +263,7 @@ COLOStatus *qmp_query_colo_status(Error **errp)
     case FAILOVER_STATUS_NONE:
         s->reason = COLO_EXIT_REASON_NONE;
         break;
-    case FAILOVER_STATUS_REQUIRE:
+    case FAILOVER_STATUS_COMPLETED:
         s->reason = COLO_EXIT_REASON_REQUEST;
         break;
     default:
@@ -582,7 +583,7 @@ out:
         qapi_event_send_colo_exit(COLO_MODE_PRIMARY,
                                   COLO_EXIT_REASON_ERROR);
         break;
-    case FAILOVER_STATUS_REQUIRE:
+    case FAILOVER_STATUS_COMPLETED:
         qapi_event_send_colo_exit(COLO_MODE_PRIMARY,
                                   COLO_EXIT_REASON_REQUEST);
         break;
@@ -854,7 +855,7 @@ out:
         qapi_event_send_colo_exit(COLO_MODE_SECONDARY,
                                   COLO_EXIT_REASON_ERROR);
         break;
-    case FAILOVER_STATUS_REQUIRE:
+    case FAILOVER_STATUS_COMPLETED:
         qapi_event_send_colo_exit(COLO_MODE_SECONDARY,
                                   COLO_EXIT_REASON_REQUEST);
         break;
-- 
2.17.GIT
