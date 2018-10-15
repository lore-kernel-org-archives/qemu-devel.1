Received: from eggs.gnu.org ([2001:4830:134:3::10]:45643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gByXC-0004Vm-Bn
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gByX8-0004It-QQ
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gByX8-0004EH-AT
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:26 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Oct 2018 16:46:18 +0800
Message-Id: <1539593186-32183-19-git-send-email-jasowang@redhat.com>
In-Reply-To: <1539593186-32183-1-git-send-email-jasowang@redhat.com>
References: <1539593186-32183-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 18/26] COLO: quick failover process by kick COLO
 thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Jason Wang <jasowang@redhat.com>

From: zhanghailiang <zhang.zhanghailiang@huawei.com>

COLO thread may sleep at qemu_sem_wait(&s->colo_checkpoint_sem),
while failover works begin, It's better to wakeup it to quick
the process.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 migration/colo.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index 57a8542..956ac23 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -131,6 +131,11 @@ static void primary_vm_do_failover(void)
 
     migrate_set_state(&s->state, MIGRATION_STATUS_COLO,
                       MIGRATION_STATUS_COMPLETED);
+    /*
+     * kick COLO thread which might wait at
+     * qemu_sem_wait(&s->colo_checkpoint_sem).
+     */
+    colo_checkpoint_notify(migrate_get_current());
 
     /*
      * Wake up COLO thread which may blocked in recv() or send(),
@@ -539,6 +544,9 @@ static void colo_process_checkpoint(MigrationState *s)
 
         qemu_sem_wait(&s->colo_checkpoint_sem);
 
+        if (s->state != MIGRATION_STATUS_COLO) {
+            goto out;
+        }
         ret = colo_do_checkpoint_transaction(s, bioc, fb);
         if (ret < 0) {
             goto out;
-- 
2.5.0
