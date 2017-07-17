Received: from eggs.gnu.org ([2001:4830:134:3::10]:45958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX6IX-0003mU-UR
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:42:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX6IU-0005JH-Sn
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:42:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13525)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dX6IU-0005J4-Jl
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:42:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 896FE61BAC
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 13:42:49 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 17 Jul 2017 15:42:22 +0200
Message-Id: <20170717134238.1966-2-quintela@redhat.com>
In-Reply-To: <20170717134238.1966-1-quintela@redhat.com>
References: <20170717134238.1966-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v5 01/17] migrate: Add gboolean return type to
 migrate_channel_process_incoming
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/channel.c |  3 ++-
 migration/channel.h |  2 +-
 migration/exec.c    |  6 ++++--
 migration/socket.c  | 12 ++++++++----
 4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 3b7252f..719055d 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -19,7 +19,7 @@
 #include "qapi/error.h"
 #include "io/channel-tls.h"
 
-void migration_channel_process_incoming(QIOChannel *ioc)
+gboolean migration_channel_process_incoming(QIOChannel *ioc)
 {
     MigrationState *s = migrate_get_current();
 
@@ -39,6 +39,7 @@ void migration_channel_process_incoming(QIOChannel *ioc)
         QEMUFile *f = qemu_fopen_channel_input(ioc);
         migration_fd_process_incoming(f);
     }
+    return FALSE; /* unregister */
 }
 
 
diff --git a/migration/channel.h b/migration/channel.h
index e4b4057..72cbc9f 100644
--- a/migration/channel.h
+++ b/migration/channel.h
@@ -18,7 +18,7 @@
 
 #include "io/channel.h"
 
-void migration_channel_process_incoming(QIOChannel *ioc);
+gboolean migration_channel_process_incoming(QIOChannel *ioc);
 
 void migration_channel_connect(MigrationState *s,
                                QIOChannel *ioc,
diff --git a/migration/exec.c b/migration/exec.c
index 08b599e..2827f15 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -47,9 +47,11 @@ static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
                                                GIOCondition condition,
                                                gpointer opaque)
 {
-    migration_channel_process_incoming(ioc);
+    gboolean result;
+
+    result = migration_channel_process_incoming(ioc);
     object_unref(OBJECT(ioc));
-    return FALSE; /* unregister */
+    return result;
 }
 
 void exec_start_incoming_migration(const char *command, Error **errp)
diff --git a/migration/socket.c b/migration/socket.c
index 757d382..6195596 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -136,25 +136,29 @@ static gboolean socket_accept_incoming_migration(QIOChannel *ioc,
 {
     QIOChannelSocket *sioc;
     Error *err = NULL;
+    gboolean result;
 
     sioc = qio_channel_socket_accept(QIO_CHANNEL_SOCKET(ioc),
                                      &err);
     if (!sioc) {
         error_report("could not accept migration connection (%s)",
                      error_get_pretty(err));
+        result = FALSE; /* unregister */
         goto out;
     }
 
     trace_migration_socket_incoming_accepted();
 
     qio_channel_set_name(QIO_CHANNEL(sioc), "migration-socket-incoming");
-    migration_channel_process_incoming(QIO_CHANNEL(sioc));
+    result = migration_channel_process_incoming(QIO_CHANNEL(sioc));
     object_unref(OBJECT(sioc));
 
 out:
-    /* Close listening socket as its no longer needed */
-    qio_channel_close(ioc, NULL);
-    return FALSE; /* unregister */
+    if (result == FALSE) {
+        /* Close listening socket as its no longer needed */
+        qio_channel_close(ioc, NULL);
+    }
+    return result;
 }
 
 
-- 
2.9.4
