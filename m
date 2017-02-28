Received: from eggs.gnu.org ([2001:4830:134:3::10]:40045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cih5n-0008CN-9q
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cih5m-0000J2-BS
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cih5m-0000Ir-6d
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:22 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 28 Feb 2017 12:40:40 +0000
Message-Id: <20170228124056.5074-12-dgilbert@redhat.com>
In-Reply-To: <20170228124056.5074-1-dgilbert@redhat.com>
References: <20170228124056.5074-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 11/27] migration: fix use-after-free of
 to_dst_file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, lvivier@redhat.com, marcandre.lureau@redhat.com, vsementsov@virtuozzo.com, danielhb@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, ashijeetacharya@gmail.com

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

hmp_savevm calls qemu_savevm_state(f), which sets to_dst_file=f in
global migration state. Then hmp_savevm closes f (g_free called).

Next access to to_dst_file in migration state (for example,
qmp_migrate_set_speed) will use it after it was freed.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20170225193155.447462-5-vsementsov@virtuozzo.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/savevm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 87c7a00..26d2c44 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1277,6 +1277,11 @@ done:
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
2.9.3
