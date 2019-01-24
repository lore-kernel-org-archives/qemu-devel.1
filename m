Received: from eggs.gnu.org ([209.51.188.92]:37195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gme52-0000rA-OU
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:26:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gme52-0004rR-2r
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:26:00 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 24 Jan 2019 15:25:24 +0300
Message-Id: <20190124122525.145968-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190124122525.145968-1-vsementsov@virtuozzo.com>
References: <20190124122525.145968-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 1/2] qmp: forbid qmp_cont in
 RUN_STATE_FINISH_MIGRATE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, lcapitulino@redhat.com, dgilbert@redhat.com

qmp_cont in RUN_STATE_FINISH_MIGRATE may lead to moving vm to
RUN_STATE_RUNNING, before actual migration finish. So, when migration
thread will try to go to RUN_STATE_POSTMIGRATE, assuming transition
RUN_STATE_FINISH_MIGRATE->RUN_STATE_POSTMIGRATE, it will crash, as
current state is RUN_STATE_RUNNING, and transition
RUN_STATE_RUNNING->RUN_STATE_POSTMIGRATE is forbidden.

Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/qmp.c b/qmp.c
index 4c819dd8cf..c2ecf1d804 100644
--- a/qmp.c
+++ b/qmp.c
@@ -156,6 +156,9 @@ void qmp_cont(Error **errp)
         return;
     } else if (runstate_check(RUN_STATE_SUSPENDED)) {
         return;
+    } else if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
+        error_setg(errp, "Migration is not finalized yet");
+        return;
     }
 
     for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
-- 
2.18.0
