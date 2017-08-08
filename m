Received: from eggs.gnu.org ([2001:4830:134:3::10]:58439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df7J0-00082t-4U
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 12:24:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df7Iz-0006Ns-19
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 12:24:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1df7Iy-0006Mz-RN
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 12:24:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D19236573E
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 16:24:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue,  8 Aug 2017 18:22:09 +0200
Message-Id: <20170808162224.32419-5-quintela@redhat.com>
In-Reply-To: <20170808162224.32419-1-quintela@redhat.com>
References: <20170808162224.32419-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v6 04/19] migration: Create
 migration_has_all_channels
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

This functions allows us to decide when to close the listener socket.
For now, we only need one connection.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 11 +++++++++++
 migration/migration.h |  2 ++
 migration/socket.c    | 10 +++++++---
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 86e41e8..2c42834 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -386,6 +386,17 @@ void migration_ioc_process_incoming(QIOChannel *ioc)
     /* We still only have a single channel.  Nothing to do here yet */
 }
 
+/**
+ * @migration_has_all_channels: We have received all channels that we need
+ *
+ * Returns true when we have got connections to all the channels that
+ * we need for migration.
+ */
+bool migration_has_all_channels(void)
+{
+    return true;
+}
+
 /*
  * Send a 'SHUT' message on the return channel with the given value
  * to indicate that we've finished with the RP.  Non-0 value indicates
diff --git a/migration/migration.h b/migration/migration.h
index 99c398d..1881e4a 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -155,6 +155,8 @@ void migrate_set_state(int *state, int old_state, int new_state);
 void migration_fd_process_incoming(QEMUFile *f);
 void migration_ioc_process_incoming(QIOChannel *ioc);
 
+bool  migration_has_all_channels(void);
+
 uint64_t migrate_max_downtime(void);
 
 void migrate_fd_error(MigrationState *s, const Error *error);
diff --git a/migration/socket.c b/migration/socket.c
index b02d37d..dee8690 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -152,9 +152,13 @@ static gboolean socket_accept_incoming_migration(QIOChannel *ioc,
     object_unref(OBJECT(sioc));
 
 out:
-    /* Close listening socket as its no longer needed */
-    qio_channel_close(ioc, NULL);
-    return G_SOURCE_REMOVE;
+    if (migration_has_all_channels()) {
+        /* Close listening socket as its no longer needed */
+        qio_channel_close(ioc, NULL);
+        return G_SOURCE_REMOVE;
+    } else {
+        return G_SOURCE_CONTINUE;
+    }
 }
 
 
-- 
2.9.4
