Received: from eggs.gnu.org ([2001:4830:134:3::10]:57077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKiU7-0001AX-D1
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKiU4-0003LW-AA
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dKiU4-0003LL-29
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A23F120D2
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 09:51:35 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 13 Jun 2017 11:51:11 +0200
Message-Id: <20170613095120.11373-6-quintela@redhat.com>
In-Reply-To: <20170613095120.11373-1-quintela@redhat.com>
References: <20170613095120.11373-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/14] migration: Remove MigrationState from
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
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

All callers were calling migrate_get_current(), so do it inside the funct=
ion.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
---
 migration/channel.c | 5 +++--
 migration/channel.h | 3 +--
 migration/exec.c    | 2 +-
 migration/fd.c      | 2 +-
 migration/socket.c  | 3 +--
 migration/tls.c     | 2 +-
 6 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index eae1d9e..92f6f99 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -19,9 +19,10 @@
 #include "qapi/error.h"
 #include "io/channel-tls.h"
=20
-void migration_channel_process_incoming(MigrationState *s,
-                                        QIOChannel *ioc)
+void migration_channel_process_incoming(QIOChannel *ioc)
 {
+    MigrationState *s =3D migrate_get_current();
+
     trace_migration_set_incoming_channel(
         ioc, object_get_typename(OBJECT(ioc)));
=20
diff --git a/migration/channel.h b/migration/channel.h
index 2e0a7e3..e4b4057 100644
--- a/migration/channel.h
+++ b/migration/channel.h
@@ -18,8 +18,7 @@
=20
 #include "io/channel.h"
=20
-void migration_channel_process_incoming(MigrationState *s,
-                                        QIOChannel *ioc);
+void migration_channel_process_incoming(QIOChannel *ioc);
=20
 void migration_channel_connect(MigrationState *s,
                                QIOChannel *ioc,
diff --git a/migration/exec.c b/migration/exec.c
index 9077024..fc78eeb 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -49,7 +49,7 @@ static gboolean exec_accept_incoming_migration(QIOChann=
el *ioc,
                                                GIOCondition condition,
                                                gpointer opaque)
 {
-    migration_channel_process_incoming(migrate_get_current(), ioc);
+    migration_channel_process_incoming(ioc);
     object_unref(OBJECT(ioc));
     return FALSE; /* unregister */
 }
diff --git a/migration/fd.c b/migration/fd.c
index 0077a50..8a04dcd 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -49,7 +49,7 @@ static gboolean fd_accept_incoming_migration(QIOChannel=
 *ioc,
                                              GIOCondition condition,
                                              gpointer opaque)
 {
-    migration_channel_process_incoming(migrate_get_current(), ioc);
+    migration_channel_process_incoming(ioc);
     object_unref(OBJECT(ioc));
     return FALSE; /* unregister */
 }
diff --git a/migration/socket.c b/migration/socket.c
index 85bfdcc..50dc8d8 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -148,8 +148,7 @@ static gboolean socket_accept_incoming_migration(QIOC=
hannel *ioc,
     trace_migration_socket_incoming_accepted();
=20
     qio_channel_set_name(QIO_CHANNEL(sioc), "migration-socket-incoming")=
;
-    migration_channel_process_incoming(migrate_get_current(),
-                                       QIO_CHANNEL(sioc));
+    migration_channel_process_incoming(QIO_CHANNEL(sioc));
     object_unref(OBJECT(sioc));
=20
 out:
diff --git a/migration/tls.c b/migration/tls.c
index bae9aca..d3abd6e 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -74,7 +74,7 @@ static void migration_tls_incoming_handshake(QIOTask *t=
ask,
         error_report_err(err);
     } else {
         trace_migration_tls_incoming_handshake_complete();
-        migration_channel_process_incoming(migrate_get_current(), ioc);
+        migration_channel_process_incoming(ioc);
     }
     object_unref(OBJECT(ioc));
 }
--=20
2.9.4
