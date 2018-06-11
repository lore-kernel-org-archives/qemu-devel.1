Received: from eggs.gnu.org ([2001:4830:134:3::10]:35557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fSFuX-0002uy-G4
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 02:02:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fSFuV-0001vd-SJ
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 02:02:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42218 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fSFuV-0001ul-OR
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 02:02:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4F5A68424B
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 06:02:35 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 11 Jun 2018 14:02:27 +0800
Message-Id: <20180611060228.2998-2-peterx@redhat.com>
In-Reply-To: <20180611060228.2998-1-peterx@redhat.com>
References: <20180611060228.2998-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] migration: unbreak postcopy recovery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

It was broken due to recent changes in two parts:

- migration_incoming_process() will be called now even for postcopy
  recovery sessions (while we shouldn't)

- Now we don't call migrate_fd_process_incoming() any more (unless in
  RDMA code), so actually the postcopy recovery logic is fully bypassed

Fix this up to make sure we only call migration_incoming_process() when
necessary, and move the postcopy recovery logic far earlier to the entry
point of incoming migration.  Renaming migration_fd_process_incoming()
into postcopy_try_recover() since it's mostly for the recovery process,
then touch up RDMA code to suite it.

Since at it, refactor the imcoming port handling to only have one singe
entry point for incoming migration.  Then we can avoid calling
migration_ioc_process_incoming() everywhere, which is really error
prone.

Fixes: 36c2f8be2c ("migration: Delay start of migration main routines")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.h       |  2 +-
 migration/exec.c      |  3 ---
 migration/fd.c        |  3 ---
 migration/migration.c | 34 ++++++++++++++++++++++++++--------
 migration/ram.c       | 11 +++++------
 migration/rdma.c      |  3 ++-
 migration/socket.c    |  5 -----
 7 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/migration/ram.h b/migration/ram.h
index d386f4d641..457bf54b8c 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -46,7 +46,7 @@ int multifd_save_cleanup(Error **errp);
 int multifd_load_setup(void);
 int multifd_load_cleanup(Error **errp);
 bool multifd_recv_all_channels_created(void);
-void multifd_recv_new_channel(QIOChannel *ioc);
+bool multifd_recv_new_channel(QIOChannel *ioc);
 
 uint64_t ram_pagesize_summary(void);
 int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len);
diff --git a/migration/exec.c b/migration/exec.c
index 0bbeb63c97..375d2e1b54 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -49,9 +49,6 @@ static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
 {
     migration_channel_process_incoming(ioc);
     object_unref(OBJECT(ioc));
-    if (!migrate_use_multifd()) {
-        migration_incoming_process();
-    }
     return G_SOURCE_REMOVE;
 }
 
diff --git a/migration/fd.c b/migration/fd.c
index fee34ffdc0..a7c13df4ad 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -49,9 +49,6 @@ static gboolean fd_accept_incoming_migration(QIOChannel *ioc,
 {
     migration_channel_process_incoming(ioc);
     object_unref(OBJECT(ioc));
-    if (!migrate_use_multifd()) {
-        migration_incoming_process();
-    }
     return G_SOURCE_REMOVE;
 }
 
diff --git a/migration/migration.c b/migration/migration.c
index 1e99ec9b7e..b8ed3dcd2f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -461,7 +461,8 @@ void migration_incoming_process(void)
     qemu_coroutine_enter(co);
 }
 
-void migration_fd_process_incoming(QEMUFile *f)
+/* Returns true if recovered from a paused migration, otherwise false */
+static bool postcopy_try_recover(QEMUFile *f)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
 
@@ -486,23 +487,40 @@ void migration_fd_process_incoming(QEMUFile *f)
          * that source is ready to reply to page requests.
          */
         qemu_sem_post(&mis->postcopy_pause_sem_dst);
-    } else {
-        /* New incoming migration */
-        migration_incoming_setup(f);
-        migration_incoming_process();
+        return true;
     }
+
+    return false;
 }
 
 void migration_ioc_process_incoming(QIOChannel *ioc)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
+    QEMUFile *f = qemu_fopen_channel_input(ioc);
+    bool start_migration;
+
+    /* If it's a recovery attempt, we're done */
+    if (postcopy_try_recover(f)) {
+        return;
+    }
 
     if (!mis->from_src_file) {
-        QEMUFile *f = qemu_fopen_channel_input(ioc);
+        /* The first connection (multifd may have multiple) */
         migration_incoming_setup(f);
-        return;
+        /*
+         * Common migration only needs one channel, so we can start
+         * right now.  Multifd needs more than one channel, we wait.
+         */
+        start_migration = !migrate_use_multifd();
+    } else {
+        /* Multiple connections */
+        assert(migrate_use_multifd());
+        start_migration = multifd_recv_new_channel(ioc);
+    }
+
+    if (start_migration) {
+        migration_incoming_process();
     }
-    multifd_recv_new_channel(ioc);
 }
 
 /**
diff --git a/migration/ram.c b/migration/ram.c
index a500015a2f..0d8f38d968 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -871,7 +871,8 @@ bool multifd_recv_all_channels_created(void)
     return thread_count == atomic_read(&multifd_recv_state->count);
 }
 
-void multifd_recv_new_channel(QIOChannel *ioc)
+/* Return true if multifd is ready for the migration, otherwise false */
+bool multifd_recv_new_channel(QIOChannel *ioc)
 {
     MultiFDRecvParams *p;
     Error *local_err = NULL;
@@ -880,7 +881,7 @@ void multifd_recv_new_channel(QIOChannel *ioc)
     id = multifd_recv_initial_packet(ioc, &local_err);
     if (id < 0) {
         multifd_recv_terminate_threads(local_err);
-        return;
+        return false;
     }
 
     p = &multifd_recv_state->params[id];
@@ -888,7 +889,7 @@ void multifd_recv_new_channel(QIOChannel *ioc)
         error_setg(&local_err, "multifd: received id '%d' already setup'",
                    id);
         multifd_recv_terminate_threads(local_err);
-        return;
+        return false;
     }
     p->c = ioc;
     object_ref(OBJECT(ioc));
@@ -897,9 +898,7 @@ void multifd_recv_new_channel(QIOChannel *ioc)
     qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
                        QEMU_THREAD_JOINABLE);
     atomic_inc(&multifd_recv_state->count);
-    if (multifd_recv_state->count == migrate_multifd_channels()) {
-        migration_incoming_process();
-    }
+    return multifd_recv_state->count == migrate_multifd_channels();
 }
 
 /**
diff --git a/migration/rdma.c b/migration/rdma.c
index 05aee3d591..0f5ee987c6 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3687,7 +3687,8 @@ static void rdma_accept_incoming_migration(void *opaque)
     }
 
     rdma->migration_started_on_destination = 1;
-    migration_fd_process_incoming(f);
+    migration_incoming_setup(f);
+    migration_incoming_process();
 }
 
 void rdma_start_incoming_migration(const char *host_port, Error **errp)
diff --git a/migration/socket.c b/migration/socket.c
index 3456eb76e9..f4c8174400 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -168,12 +168,7 @@ static void socket_accept_incoming_migration(QIONetListener *listener,
     if (migration_has_all_channels()) {
         /* Close listening socket as its no longer needed */
         qio_net_listener_disconnect(listener);
-
         object_unref(OBJECT(listener));
-
-        if (!migrate_use_multifd()) {
-            migration_incoming_process();
-        }
     }
 }
 
-- 
2.17.1
