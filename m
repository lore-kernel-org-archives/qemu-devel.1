Received: from eggs.gnu.org ([2001:4830:134:3::10]:48356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fob0j-0005bi-8d
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 17:01:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fob0i-0001kX-HQ
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 17:01:21 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fob0i-0001jx-AJ
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 17:01:20 -0400
Received: by mail-pf1-x442.google.com with SMTP id j26-v6so5995949pfi.10
	for <qemu-devel@nongnu.org>; Sat, 11 Aug 2018 14:01:20 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
Date: Sun, 12 Aug 2018 04:59:23 +0800
Message-Id: <20180811205924.4113-20-zhangckid@gmail.com>
In-Reply-To: <20180811205924.4113-1-zhangckid@gmail.com>
References: <20180811205924.4113-1-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V11 19/20] COLO: quick failover process by kick
 COLO thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

From: zhanghailiang <zhang.zhanghailiang@huawei.com>

COLO thread may sleep at qemu_sem_wait(&s->colo_checkpoint_sem),
while failover works begin, It's better to wakeup it to quick
the process.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/colo.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index 8221a18add..e951159071 100644
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
2.17.GIT
