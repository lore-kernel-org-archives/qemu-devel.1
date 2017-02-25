Received: from eggs.gnu.org ([2001:4830:134:3::10]:34000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1chi4c-0000X8-12
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 14:32:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1chi4Z-0007oR-B5
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 14:32:06 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Sat, 25 Feb 2017 22:31:53 +0300
Message-Id: <20170225193155.447462-3-vsementsov@virtuozzo.com>
In-Reply-To: <20170225193155.447462-1-vsementsov@virtuozzo.com>
References: <20170225193155.447462-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/4] qmp-cont: invalidate on RUN_STATE_PRELAUNCH
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

We must invalidate on RUN_STATE_PRELAUNCH too, as it is available
through qmp_system_reset from RUN_STATE_POSTMIGRATE. Otherwise, we will
come to

qemu-kvm: block/io.c:1406: bdrv_co_do_pwritev:
       Assertion `!(bs->open_flags & 0x0800)' failed.

on the first write after vm start.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qmp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qmp.c b/qmp.c
index dfaabac1a6..e61795d033 100644
--- a/qmp.c
+++ b/qmp.c
@@ -198,7 +198,8 @@ void qmp_cont(Error **errp)
     /* Continuing after completed migration. Images have been inactivated to
      * allow the destination to take control. Need to get control back now. */
     if (runstate_check(RUN_STATE_FINISH_MIGRATE) ||
-        runstate_check(RUN_STATE_POSTMIGRATE))
+        runstate_check(RUN_STATE_POSTMIGRATE) ||
+        runstate_check(RUN_STATE_PRELAUNCH))
     {
         bdrv_invalidate_cache_all(&local_err);
         if (local_err) {
-- 
2.11.1
