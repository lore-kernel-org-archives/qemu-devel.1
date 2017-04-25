Received: from eggs.gnu.org ([2001:4830:134:3::10]:55666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38ax-0007ez-0M
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:06:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38av-0005zW-Jt
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:06:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d38av-0005yL-9x
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:06:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4FD317E9D6
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:06:00 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:04:43 +0200
Message-Id: <20170425220451.6028-34-quintela@redhat.com>
In-Reply-To: <20170425220451.6028-1-quintela@redhat.com>
References: <20170425220451.6028-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 33/41] migration: Commands are only used inside
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
---
 include/migration/migration.h | 15 --------------
 migration/migration.c         | 46 +++++++++++++++++++++++++++----------------
 2 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index ac6e545..9884be6 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -25,18 +25,6 @@
 /* for vl.c */
 extern int only_migratable;
 
-/* Messages sent on the return path from destination to source */
-enum mig_rp_message_type {
-    MIG_RP_MSG_INVALID = 0,  /* Must be 0 */
-    MIG_RP_MSG_SHUT,         /* sibling will not send any more RP messages */
-    MIG_RP_MSG_PONG,         /* Response to a PING; data (seq: be32 ) */
-
-    MIG_RP_MSG_REQ_PAGES_ID, /* data (start: be64, len: be32, id: string) */
-    MIG_RP_MSG_REQ_PAGES,    /* data (start: be64, len: be32) */
-
-    MIG_RP_MSG_MAX
-};
-
 typedef QLIST_HEAD(, LoadStateEntry) LoadStateEntry_Head;
 
 /* State for the incoming migration */
@@ -181,9 +169,6 @@ int migrate_decompress_threads(void);
 bool migrate_use_events(void);
 
 /* Sending on the return path - generic and then for each message type */
-void migrate_send_rp_message(MigrationIncomingState *mis,
-                             enum mig_rp_message_type message_type,
-                             uint16_t len, void *data);
 void migrate_send_rp_shut(MigrationIncomingState *mis,
                           uint32_t value);
 void migrate_send_rp_pong(MigrationIncomingState *mis,
diff --git a/migration/migration.c b/migration/migration.c
index d2f3c5e..6e43ae3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -85,6 +85,18 @@ static NotifierList migration_state_notifiers =
 
 static bool deferred_incoming;
 
+/* Messages sent on the return path from destination to source */
+enum mig_rp_message_type {
+    MIG_RP_MSG_INVALID = 0,  /* Must be 0 */
+    MIG_RP_MSG_SHUT,         /* sibling will not send any more RP messages */
+    MIG_RP_MSG_PONG,         /* Response to a PING; data (seq: be32 ) */
+
+    MIG_RP_MSG_REQ_PAGES_ID, /* data (start: be64, len: be32, id: string) */
+    MIG_RP_MSG_REQ_PAGES,    /* data (start: be64, len: be32) */
+
+    MIG_RP_MSG_MAX
+};
+
 /* When we add fault tolerance, we could have several
    migrations at once.  For now we don't need to add
    dynamic creation of migration */
@@ -281,6 +293,23 @@ static void deferred_incoming_migration(Error **errp)
     deferred_incoming = true;
 }
 
+/*
+ * Send a message on the return channel back to the source
+ * of the migration.
+ */
+static void migrate_send_rp_message(MigrationIncomingState *mis,
+                                    enum mig_rp_message_type message_type,
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
  *   rbname: Name of the RAMBlock to request the page in, if NULL it's the same
@@ -461,23 +490,6 @@ void migration_fd_process_incoming(QEMUFile *f)
 }
 
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
-- 
2.9.3
