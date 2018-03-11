Received: from eggs.gnu.org ([2001:4830:134:3::10]:59450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1euvgu-0006tN-7o
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 03:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1euvgr-0001BX-19
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 03:46:48 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:46063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1euvgq-0001B1-Qv
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 03:46:44 -0400
Received: by mail-pg0-x244.google.com with SMTP id s13so2337868pgn.12
	for <qemu-devel@nongnu.org>; Sat, 10 Mar 2018 23:46:44 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
Date: Sun, 11 Mar 2018 15:45:14 +0800
Message-Id: <1520754314-5969-19-git-send-email-zhangckid@gmail.com>
In-Reply-To: <1520754314-5969-1-git-send-email-zhangckid@gmail.com>
References: <1520754314-5969-1-git-send-email-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V6 17/17] COLO: quick failover process by kick
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

From: zhanghailiang <zhang.zhanghailiang@huawei.com>

COLO thread may sleep at qemu_sem_wait(&s->colo_checkpoint_sem),
while failover works begin, It's better to wakeup it to quick
the process.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 migration/colo.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index 1a59baa..1bc5f02 100644
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
@@ -549,6 +554,9 @@ static void colo_process_checkpoint(MigrationState *s)
 
         qemu_sem_wait(&s->colo_checkpoint_sem);
 
+        if (s->state != MIGRATION_STATUS_COLO) {
+            goto out;
+        }
         ret = colo_do_checkpoint_transaction(s, bioc, fb);
         if (ret < 0) {
             goto out;
-- 
2.7.4
