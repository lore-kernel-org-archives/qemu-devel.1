Received: from eggs.gnu.org ([2001:4830:134:3::10]:33995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1chi4b-0000Wy-W9
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 14:32:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1chi4Z-0007oW-BX
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 14:32:05 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Sat, 25 Feb 2017 22:31:55 +0300
Message-Id: <20170225193155.447462-5-vsementsov@virtuozzo.com>
In-Reply-To: <20170225193155.447462-1-vsementsov@virtuozzo.com>
References: <20170225193155.447462-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 4/4] migration: fix use-after-free of
 to_dst_file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, vsementsov@virtuozzo.com, lirans@il.ibm.com

hmp_savevm calls qemu_savevm_state(f), which sets to_dst_file=f in
global migration state. Then hmp_savevm closes f (g_free called).

Next access to to_dst_file in migration state (for example,
qmp_migrate_set_speed) will use it after it was freed.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 migration/savevm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 75e56d2d07..fcb8fd8acd 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1276,6 +1276,11 @@ done:
         status = MIGRATION_STATUS_COMPLETED;
     }
     migrate_set_state(&ms->state, MIGRATION_STATUS_SETUP, status);
+
+    /* f is outer parameter, it should not stay in global migration state after
+     * this function finished */
+    ms->to_dst_file = NULL;
+
     return ret;
 }
 
-- 
2.11.1
