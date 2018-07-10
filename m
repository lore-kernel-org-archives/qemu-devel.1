Received: from eggs.gnu.org ([2001:4830:134:3::10]:40739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fcuaw-00035j-Uu
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fcuav-0003KG-0A
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38414 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fcuau-0003Ii-Li
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 361AD346F3
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 15:30:24 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 10 Jul 2018 16:30:05 +0100
Message-Id: <20180710153016.131258-5-dgilbert@redhat.com>
In-Reply-To: <20180710153016.131258-1-dgilbert@redhat.com>
References: <20180710153016.131258-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 04/15] migration: unify incoming processing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peterx@redhat.com, quintela@redhat.com

From: Peter Xu <peterx@redhat.com>

This is the 2nd patch to unbreak postcopy recovery.

Let's unify the migration_incoming_process() call at a single place
rather than calling it in connection setup codes.  This fixes a problem
that we will go into incoming migration procedure even if we are trying
to recovery from a paused postcopy migration.

Fixes: 36c2f8be2c ("migration: Delay start of migration main routines")
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180627132246.5576-5-peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/exec.c      |  3 ---
 migration/fd.c        |  3 ---
 migration/migration.c | 18 ++++++++++++++++--
 migration/socket.c    |  5 -----
 4 files changed, 16 insertions(+), 13 deletions(-)

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
index eb3e09e899..0404c53215 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -511,17 +511,31 @@ void migration_fd_process_incoming(QEMUFile *f)
 void migration_ioc_process_incoming(QIOChannel *ioc)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
+    bool start_migration;
 
     if (!mis->from_src_file) {
+        /* The first connection (multifd may have multiple) */
         QEMUFile *f = qemu_fopen_channel_input(ioc);
+
+        /* If it's a recovery, we're done */
         if (postcopy_try_recover(f)) {
             return;
         }
+
         migration_incoming_setup(f);
-        return;
+
+        /*
+         * Common migration only needs one channel, so we can start
+         * right now.  Multifd needs more than one channel, we wait.
+         */
+        start_migration = !migrate_use_multifd();
+    } else {
+        /* Multiple connections */
+        assert(migrate_use_multifd());
+        start_migration = multifd_recv_new_channel(ioc);
     }
 
-    if (multifd_recv_new_channel(ioc)) {
+    if (start_migration) {
         migration_incoming_process();
     }
 }
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
