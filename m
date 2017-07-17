Received: from eggs.gnu.org ([2001:4830:134:3::10]:46300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX6JJ-0004eu-Tt
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:43:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX6JI-0005aE-2r
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:43:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dX6JH-0005Zk-PX
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:43:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C32434E4D6
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 13:43:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 17 Jul 2017 15:42:36 +0200
Message-Id: <20170717134238.1966-16-quintela@redhat.com>
In-Reply-To: <20170717134238.1966-1-quintela@redhat.com>
References: <20170717134238.1966-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v5 15/17] migration: Test new fd infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, berrange@redhat.com

We just send the address through the alternate channels and test that it
is ok.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 49c4880..b55b243 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -468,8 +468,26 @@ static void *multifd_send_thread(void *opaque)
             break;
         }
         if (p->pages.num) {
+            int i;
+            int num;
+
+            num = p->pages.num;
             p->pages.num = 0;
             qemu_mutex_unlock(&p->mutex);
+
+            for (i = 0; i < num; i++) {
+                if (qio_channel_write(p->c,
+                                      (const char *)&p->pages.iov[i].iov_base,
+                                      sizeof(uint8_t *), &error_abort)
+                    != sizeof(uint8_t *)) {
+                    MigrationState *s = migrate_get_current();
+
+                    migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
+                                      MIGRATION_STATUS_FAILED);
+                    terminate_multifd_send_threads();
+                    return NULL;
+                }
+            }
             qemu_mutex_lock(&multifd_send_state->mutex);
             p->done = true;
             qemu_mutex_unlock(&multifd_send_state->mutex);
@@ -636,6 +654,7 @@ void multifd_load_cleanup(void)
 static void *multifd_recv_thread(void *opaque)
 {
     MultiFDRecvParams *p = opaque;
+    uint8_t *recv_address;
 
     qemu_sem_post(&p->ready);
     while (true) {
@@ -645,7 +664,38 @@ static void *multifd_recv_thread(void *opaque)
             break;
         }
         if (p->pages.num) {
+            int i;
+            int num;
+
+            num = p->pages.num;
             p->pages.num = 0;
+
+            for (i = 0; i < num; i++) {
+                if (qio_channel_read(p->c,
+                                     (char *)&recv_address,
+                                     sizeof(uint8_t *), &error_abort)
+                    != sizeof(uint8_t *)) {
+                    MigrationState *s = migrate_get_current();
+
+                    migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
+                                      MIGRATION_STATUS_FAILED);
+                    terminate_multifd_recv_threads();
+                    return NULL;
+                }
+                if (recv_address != p->pages.iov[i].iov_base) {
+                    MigrationState *s = migrate_get_current();
+
+                    printf("We received %p what we were expecting %p (%d)\n",
+                           recv_address,
+                           p->pages.iov[i].iov_base, i);
+
+                    migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
+                                      MIGRATION_STATUS_FAILED);
+                    terminate_multifd_recv_threads();
+                    return NULL;
+                }
+            }
+
             p->done = true;
             qemu_mutex_unlock(&p->mutex);
             qemu_sem_post(&p->ready);
-- 
2.9.4
