Received: from eggs.gnu.org ([2001:4830:134:3::10]:42746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dueoD-0000AL-OV
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dueo7-0007ii-2u
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:12:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dueo6-0007i8-Rm
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:12:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9BE83C058EA8
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 10:46:52 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 20 Sep 2017 12:46:27 +0200
Message-Id: <20170920104639.2335-5-quintela@redhat.com>
In-Reply-To: <20170920104639.2335-1-quintela@redhat.com>
References: <20170920104639.2335-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 04/16] migration: Create
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

This function allows us to decide when to close the listener socket.
For now, we only need one connection.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
---
 migration/migration.c | 11 +++++++++++
 migration/migration.h |  2 ++
 migration/socket.c    | 10 +++++++---
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 2d4c56e612..bac4a99277 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -384,6 +384,17 @@ void migration_ioc_process_incoming(QIOChannel *ioc)
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
index 99c398d484..1881e4a754 100644
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
index b02d37d7a3..dee869044a 100644
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
2.13.5
