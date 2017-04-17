Received: from eggs.gnu.org ([2001:4830:134:3::10]:52075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0CpP-0005yP-JX
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:00:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0CpO-0004Mp-Ma
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:00:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0CpO-0004Mg-DY
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:00:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A43E8FCE2
	for <qemu-devel@nongnu.org>; Mon, 17 Apr 2017 20:00:49 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 17 Apr 2017 22:00:26 +0200
Message-Id: <20170417200041.2451-5-quintela@redhat.com>
In-Reply-To: <20170417200041.2451-1-quintela@redhat.com>
References: <20170417200041.2451-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 04/19] migration: Remove MigrationState from
 migration_channel_incomming()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

All callers were calling migrate_get_current(), so do it inside the function.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/channel.h | 3 +--
 migration/channel.c         | 5 +++--
 migration/exec.c            | 2 +-
 migration/fd.c              | 2 +-
 migration/socket.c          | 3 +--
 migration/tls.c             | 2 +-
 6 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/migration/channel.h b/include/migration/channel.h
index 618acb7..fbc4bfb 100644
--- a/include/migration/channel.h
+++ b/include/migration/channel.h
@@ -16,8 +16,7 @@
 
 #include "io/channel.h"
 
-void migration_channel_process_incoming(MigrationState *s,
-                                        QIOChannel *ioc);
+void migration_channel_process_incoming(QIOChannel *ioc);
 
 void migration_channel_connect(MigrationState *s,
                                QIOChannel *ioc,
diff --git a/migration/channel.c b/migration/channel.c
index c66c6db..6f11a1a 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -20,9 +20,10 @@
 #include "qapi/error.h"
 #include "io/channel-tls.h"
 
-void migration_channel_process_incoming(MigrationState *s,
-                                        QIOChannel *ioc)
+void migration_channel_process_incoming(QIOChannel *ioc)
 {
+    MigrationState *s = migrate_get_current();
+
     trace_migration_set_incoming_channel(
         ioc, object_get_typename(OBJECT(ioc)));
 
diff --git a/migration/exec.c b/migration/exec.c
index 7d13fc3..2779c9c 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -48,7 +48,7 @@ static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
                                                GIOCondition condition,
                                                gpointer opaque)
 {
-    migration_channel_process_incoming(migrate_get_current(), ioc);
+    migration_channel_process_incoming(ioc);
     object_unref(OBJECT(ioc));
     return FALSE; /* unregister */
 }
diff --git a/migration/fd.c b/migration/fd.c
index f9c230e..fba3852 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -48,7 +48,7 @@ static gboolean fd_accept_incoming_migration(QIOChannel *ioc,
                                              GIOCondition condition,
                                              gpointer opaque)
 {
-    migration_channel_process_incoming(migrate_get_current(), ioc);
+    migration_channel_process_incoming(ioc);
     object_unref(OBJECT(ioc));
     return FALSE; /* unregister */
 }
diff --git a/migration/socket.c b/migration/socket.c
index 7171635..b06cde3 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -149,8 +149,7 @@ static gboolean socket_accept_incoming_migration(QIOChannel *ioc,
     trace_migration_socket_incoming_accepted();
 
     qio_channel_set_name(QIO_CHANNEL(sioc), "migration-socket-incoming");
-    migration_channel_process_incoming(migrate_get_current(),
-                                       QIO_CHANNEL(sioc));
+    migration_channel_process_incoming(QIO_CHANNEL(sioc));
     object_unref(OBJECT(sioc));
 
 out:
diff --git a/migration/tls.c b/migration/tls.c
index 4ee3349..2b28ebd 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -73,7 +73,7 @@ static void migration_tls_incoming_handshake(QIOTask *task,
         error_report_err(err);
     } else {
         trace_migration_tls_incoming_handshake_complete();
-        migration_channel_process_incoming(migrate_get_current(), ioc);
+        migration_channel_process_incoming(ioc);
     }
     object_unref(OBJECT(ioc));
 }
-- 
2.9.3
