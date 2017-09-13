Received: from eggs.gnu.org ([2001:4830:134:3::10]:42452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ds5PW-0006dh-Pu
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:00:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ds5PQ-000724-C5
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:00:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ds5PQ-00071F-4E
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:00:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1AF96C04B92A
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 11:00:43 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 13 Sep 2017 12:59:49 +0200
Message-Id: <20170913105953.13760-17-quintela@redhat.com>
In-Reply-To: <20170913105953.13760-1-quintela@redhat.com>
References: <20170913105953.13760-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v8 16/20] migration: Create thread
 infrastructure for multifd recv side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

We make the locking and the transfer of information specific, even if we
are still receiving things through the main thread.

Signed-off-by: Juan Quintela <quintela@redhat.com>

--

We split when we create the main channel and where we start the main
migration thread, so we wait for the creation of the other threads.

Use multifd_clear_pages().
Don't remove object_unref()
---
 migration/migration.c |  7 ++++---
 migration/migration.h |  1 +
 migration/ram.c       | 55 +++++++++++++++++++++++++++++++++++++++++++++++----
 migration/socket.c    |  2 +-
 4 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 085177ca26..674c254c3f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -388,7 +388,7 @@ static void migration_incoming_setup(QEMUFile *f)
     qemu_file_set_blocking(f, false);
 }
 
-static void migration_incoming_process(void)
+void migration_incoming_process(void)
 {
     Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, NULL);
     qemu_coroutine_enter(co);
@@ -406,9 +406,10 @@ void migration_ioc_process_incoming(QIOChannel *ioc)
 
     if (!mis->from_src_file) {
         QEMUFile *f = qemu_fopen_channel_input(ioc);
-        migration_fd_process_incoming(f);
+        migration_incoming_setup(f);
+        return;
     }
-    /* We still only have a single channel.  Nothing to do here yet */
+    multifd_new_channel(ioc);
 }
 
 /**
diff --git a/migration/migration.h b/migration/migration.h
index da39d4c711..382a0449d5 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -158,6 +158,7 @@ void migrate_set_state(int *state, int old_state, int new_state);
 
 void migration_fd_process_incoming(QEMUFile *f);
 void migration_ioc_process_incoming(QIOChannel *ioc);
+void migration_incoming_process(void);
 
 bool  migration_has_all_channels(void);
 
diff --git a/migration/ram.c b/migration/ram.c
index 3f60f7e40c..d6aa516f6d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -601,13 +601,18 @@ static uint16_t multifd_send_page(uint8_t *address, bool last_page)
 }
 
 struct MultiFDRecvParams {
+    /* not changed */
     uint8_t id;
     char *name;
     QemuThread thread;
     QIOChannel *c;
+    QemuSemaphore ready;
     QemuSemaphore sem;
     QemuMutex mutex;
+    /* proteced by param mutex */
     bool quit;
+    multifd_pages_t pages;
+    bool done;
 };
 typedef struct MultiFDRecvParams MultiFDRecvParams;
 
@@ -617,6 +622,7 @@ struct {
     int count;
     /* Should we finish */
     bool quit;
+    multifd_pages_t pages;
 } *multifd_recv_state;
 
 static void terminate_multifd_recv_threads(Error *errp)
@@ -638,6 +644,7 @@ static void terminate_multifd_recv_threads(Error *errp)
         p->quit = true;
         qemu_sem_post(&p->sem);
         qemu_mutex_unlock(&p->mutex);
+        multifd_clear_pages(&p->pages);
     }
 }
 
@@ -662,6 +669,7 @@ int multifd_load_cleanup(Error **errp)
     }
     g_free(multifd_recv_state->params);
     multifd_recv_state->params = NULL;
+    multifd_clear_pages(&multifd_recv_state->pages);
     g_free(multifd_recv_state);
     multifd_recv_state = NULL;
 
@@ -672,12 +680,20 @@ static void *multifd_recv_thread(void *opaque)
 {
     MultiFDRecvParams *p = opaque;
 
+    qemu_sem_post(&p->ready);
     while (true) {
         qemu_mutex_lock(&p->mutex);
         if (p->quit) {
             qemu_mutex_unlock(&p->mutex);
             break;
         }
+        if (p->pages.num) {
+            p->pages.num = 0;
+            p->done = true;
+            qemu_mutex_unlock(&p->mutex);
+            qemu_sem_post(&p->ready);
+            continue;
+        }
         qemu_mutex_unlock(&p->mutex);
         qemu_sem_wait(&p->sem);
     }
@@ -723,8 +739,11 @@ void multifd_new_channel(QIOChannel *ioc)
     }
     qemu_mutex_init(&p->mutex);
     qemu_sem_init(&p->sem, 0);
+    qemu_sem_init(&p->ready, 0);
     p->quit = false;
     p->id = id;
+    p->done = false;
+    multifd_init_pages(&p->pages);
     p->c = ioc;
     multifd_recv_state->count++;
     p->name = g_strdup_printf("multifdrecv_%d", id);
@@ -744,6 +763,7 @@ int multifd_load_setup(void)
     multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
     multifd_recv_state->count = 0;
     multifd_recv_state->quit = false;
+    multifd_init_pages(&multifd_recv_state->pages);
     return 0;
 }
 
@@ -752,6 +772,36 @@ int multifd_created_channels(void)
     return multifd_recv_state->count;
 }
 
+static void multifd_recv_page(uint8_t *address, uint16_t fd_num)
+{
+    int thread_count;
+    MultiFDRecvParams *p;
+    multifd_pages_t *pages = &multifd_recv_state->pages;
+
+    pages->iov[pages->num].iov_base = address;
+    pages->iov[pages->num].iov_len = TARGET_PAGE_SIZE;
+    pages->num++;
+
+    if (fd_num == MULTIFD_CONTINUE) {
+        return;
+    }
+
+    thread_count = migrate_multifd_channels();
+    assert(fd_num < thread_count);
+    p = &multifd_recv_state->params[fd_num];
+
+    qemu_sem_wait(&p->ready);
+
+    qemu_mutex_lock(&p->mutex);
+    p->done = false;
+    iov_copy(p->pages.iov, pages->num, pages->iov, pages->num, 0,
+             iov_size(pages->iov, pages->num));
+    p->pages.num = pages->num;
+    pages->num = 0;
+    qemu_mutex_unlock(&p->mutex);
+    qemu_sem_post(&p->sem);
+}
+
 /**
  * save_page_header: write page header to wire
  *
@@ -3063,10 +3113,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
 
         case RAM_SAVE_FLAG_MULTIFD_PAGE:
             fd_num = qemu_get_be16(f);
-            if (fd_num != 0) {
-                /* this is yet an unused variable, changed later */
-                fd_num = fd_num;
-            }
+            multifd_recv_page(host, fd_num);
             qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
             break;
 
diff --git a/migration/socket.c b/migration/socket.c
index 22fb05edc8..63dedb22e8 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -180,12 +180,12 @@ static gboolean socket_accept_incoming_migration(QIOChannel *ioc,
 
     qio_channel_set_name(QIO_CHANNEL(sioc), "migration-socket-incoming");
     migration_channel_process_incoming(QIO_CHANNEL(sioc));
-    object_unref(OBJECT(sioc));
 
 out:
     if (migration_has_all_channels()) {
         /* Close listening socket as its no longer needed */
         qio_channel_close(ioc, NULL);
+        migration_incoming_process();
         return G_SOURCE_REMOVE;
     } else {
         return G_SOURCE_CONTINUE;
-- 
2.13.5
