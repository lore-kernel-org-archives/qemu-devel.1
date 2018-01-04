Received: from eggs.gnu.org ([2001:4830:134:3::10]:37242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eWybs-00048R-OF
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:02:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eWybr-0004YQ-Sq
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:02:36 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:35592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1eWybr-0004Xy-N4
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:02:35 -0500
Received: by mail-pf0-x241.google.com with SMTP id j124so375294pfc.2
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 22:02:35 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu,  4 Jan 2018 14:01:15 +0800
Message-Id: <1515045675-6993-17-git-send-email-zhangckid@gmail.com>
In-Reply-To: <1515045675-6993-1-git-send-email-zhangckid@gmail.com>
References: <1515045675-6993-1-git-send-email-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH RESEND V3 16/16] COLO: quick failover process
 by kick COLO thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>

From: zhanghailiang <zhang.zhanghailiang@huawei.com>

COLO thread may sleep at qemu_sem_wait(&s->colo_checkpoint_sem),
while failover works begin, It's better to wakeup it to quick
the process.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 migration/colo.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index 10bc80c..cc616d9 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -134,6 +134,11 @@ static void primary_vm_do_failover(void)
 
     migrate_set_state(&s->state, MIGRATION_STATUS_COLO,
                       MIGRATION_STATUS_COMPLETED);
+    /*
+     * kick COLO thread which might wait at
+     * qemu_sem_wait(&s->colo_checkpoint_sem).
+     */
+    colo_checkpoint_notify(migrate_get_current());
 
     /*
      * Wake up COLO thread which may blocked in recv() or send(),
@@ -519,6 +524,9 @@ static void colo_process_checkpoint(MigrationState *s)
 
         qemu_sem_wait(&s->colo_checkpoint_sem);
 
+        if (s->state != MIGRATION_STATUS_COLO) {
+            goto out;
+        }
         ret = colo_do_checkpoint_transaction(s, bioc, fb);
         if (ret < 0) {
             goto out;
-- 
2.7.4
