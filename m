Received: from eggs.gnu.org ([2001:4830:134:3::10]:47370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fI6gN-0006dK-1O
	for qemu-devel@nongnu.org; Mon, 14 May 2018 02:10:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fI47B-00015W-PU
	for qemu-devel@nongnu.org; Sun, 13 May 2018 23:25:34 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:45470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fI47B-00014F-Hm
	for qemu-devel@nongnu.org; Sun, 13 May 2018 23:25:33 -0400
Received: by mail-pf0-x244.google.com with SMTP id c10-v6so5305914pfi.12
	for <qemu-devel@nongnu.org>; Sun, 13 May 2018 20:25:33 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 14 May 2018 11:23:48 +0800
Message-Id: <1526268228-27951-18-git-send-email-zhangckid@gmail.com>
In-Reply-To: <1526268228-27951-1-git-send-email-zhangckid@gmail.com>
References: <1526268228-27951-1-git-send-email-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V7 17/17] COLO: quick failover process by kick
 COLO thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>

From: zhanghailiang <zhang.zhanghailiang@huawei.com>

COLO thread may sleep at qemu_sem_wait(&s->colo_checkpoint_sem),
while failover works begin, It's better to wakeup it to quick
the process.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 migration/colo.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index d67bdc2..a7e0eaa 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -135,6 +135,11 @@ static void primary_vm_do_failover(void)
 
     migrate_set_state(&s->state, MIGRATION_STATUS_COLO,
                       MIGRATION_STATUS_COMPLETED);
+    /*
+     * kick COLO thread which might wait at
+     * qemu_sem_wait(&s->colo_checkpoint_sem).
+     */
+    colo_checkpoint_notify(migrate_get_current());
 
     /*
      * Wake up COLO thread which may blocked in recv() or send(),
@@ -552,6 +557,9 @@ static void colo_process_checkpoint(MigrationState *s)
 
         qemu_sem_wait(&s->colo_checkpoint_sem);
 
+        if (s->state != MIGRATION_STATUS_COLO) {
+            goto out;
+        }
         ret = colo_do_checkpoint_transaction(s, bioc, fb);
         if (ret < 0) {
             goto out;
-- 
2.7.4
