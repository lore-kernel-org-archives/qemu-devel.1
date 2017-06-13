Received: from eggs.gnu.org ([2001:4830:134:3::10]:57177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKiUG-0001Hb-74
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKiUE-0003Of-Rn
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dKiUE-0003OG-JH
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:46 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 89A4AC074552
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 09:51:45 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 13 Jun 2017 11:51:16 +0200
Message-Id: <20170613095120.11373-11-quintela@redhat.com>
In-Reply-To: <20170613095120.11373-1-quintela@redhat.com>
References: <20170613095120.11373-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/14] migration: Commands are only used inside
 migration.c
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

So, move them there.  Notice that we export functions that send
commands, not the command themselves.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
---
 include/migration/migration.h | 15 --------------
 migration/migration.c         | 46 +++++++++++++++++++++++++++----------=
------
 2 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.=
h
index dd52d3c..108212c 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -22,18 +22,6 @@
 #include "exec/cpu-common.h"
 #include "qemu/coroutine_int.h"
=20
-/* Messages sent on the return path from destination to source */
-enum mig_rp_message_type {
-    MIG_RP_MSG_INVALID =3D 0,  /* Must be 0 */
-    MIG_RP_MSG_SHUT,         /* sibling will not send any more RP messag=
es */
-    MIG_RP_MSG_PONG,         /* Response to a PING; data (seq: be32 ) */
-
-    MIG_RP_MSG_REQ_PAGES_ID, /* data (start: be64, len: be32, id: string=
) */
-    MIG_RP_MSG_REQ_PAGES,    /* data (start: be64, len: be32) */
-
-    MIG_RP_MSG_MAX
-};
-
 /* State for the incoming migration */
 struct MigrationIncomingState {
     QEMUFile *from_src_file;
@@ -176,9 +164,6 @@ int migrate_decompress_threads(void);
 bool migrate_use_events(void);
=20
 /* Sending on the return path - generic and then for each message type *=
/
-void migrate_send_rp_message(MigrationIncomingState *mis,
-                             enum mig_rp_message_type message_type,
-                             uint16_t len, void *data);
 void migrate_send_rp_shut(MigrationIncomingState *mis,
                           uint32_t value);
 void migrate_send_rp_pong(MigrationIncomingState *mis,
diff --git a/migration/migration.c b/migration/migration.c
index b23dfd3..031cb43 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -86,6 +86,18 @@ static NotifierList migration_state_notifiers =3D
=20
 static bool deferred_incoming;
=20
+/* Messages sent on the return path from destination to source */
+enum mig_rp_message_type {
+    MIG_RP_MSG_INVALID =3D 0,  /* Must be 0 */
+    MIG_RP_MSG_SHUT,         /* sibling will not send any more RP messag=
es */
+    MIG_RP_MSG_PONG,         /* Response to a PING; data (seq: be32 ) */
+
+    MIG_RP_MSG_REQ_PAGES_ID, /* data (start: be64, len: be32, id: string=
) */
+    MIG_RP_MSG_REQ_PAGES,    /* data (start: be64, len: be32) */
+
+    MIG_RP_MSG_MAX
+};
+
 /* When we add fault tolerance, we could have several
    migrations at once.  For now we don't need to add
    dynamic creation of migration */
@@ -292,6 +304,23 @@ static void deferred_incoming_migration(Error **errp=
)
     deferred_incoming =3D true;
 }
=20
+/*
+ * Send a message on the return channel back to the source
+ * of the migration.
+ */
+static void migrate_send_rp_message(MigrationIncomingState *mis,
+                                    enum mig_rp_message_type message_typ=
e,
+                                    uint16_t len, void *data)
+{
+    trace_migrate_send_rp_message((int)message_type, len);
+    qemu_mutex_lock(&mis->rp_mutex);
+    qemu_put_be16(mis->to_src_file, (unsigned int)message_type);
+    qemu_put_be16(mis->to_src_file, len);
+    qemu_put_buffer(mis->to_src_file, data, len);
+    qemu_fflush(mis->to_src_file);
+    qemu_mutex_unlock(&mis->rp_mutex);
+}
+
 /* Request a range of pages from the source VM at the given
  * start address.
  *   rbname: Name of the RAMBlock to request the page in, if NULL it's t=
he same
@@ -462,23 +491,6 @@ void migration_fd_process_incoming(QEMUFile *f)
 }
=20
 /*
- * Send a message on the return channel back to the source
- * of the migration.
- */
-void migrate_send_rp_message(MigrationIncomingState *mis,
-                             enum mig_rp_message_type message_type,
-                             uint16_t len, void *data)
-{
-    trace_migrate_send_rp_message((int)message_type, len);
-    qemu_mutex_lock(&mis->rp_mutex);
-    qemu_put_be16(mis->to_src_file, (unsigned int)message_type);
-    qemu_put_be16(mis->to_src_file, len);
-    qemu_put_buffer(mis->to_src_file, data, len);
-    qemu_fflush(mis->to_src_file);
-    qemu_mutex_unlock(&mis->rp_mutex);
-}
-
-/*
  * Send a 'SHUT' message on the return channel with the given value
  * to indicate that we've finished with the RP.  Non-0 value indicates
  * error.
--=20
2.9.4
