Received: from eggs.gnu.org ([2001:4830:134:3::10]:38265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJZk-0006x0-9D
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:11:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJZj-00016j-AB
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:11:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eCJZj-00015V-2W
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:10:59 -0500
From: Peter Xu <peterx@redhat.com>
Date: Wed,  8 Nov 2017 14:01:23 +0800
Message-Id: <20171108060130.3772-26-peterx@redhat.com>
In-Reply-To: <20171108060130.3772-1-peterx@redhat.com>
References: <20171108060130.3772-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 25/32] migration: return incoming task tag
 for exec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Return the async task tag for exec typed incoming migration in
exec_start_incoming_migration().

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/exec.c | 18 +++++++++++-------
 migration/exec.h |  2 +-
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/migration/exec.c b/migration/exec.c
index f3be1baf2e..a0796c2c70 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -52,7 +52,11 @@ static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
     return G_SOURCE_REMOVE;
 }
 
-void exec_start_incoming_migration(const char *command, Error **errp)
+/*
+ * Returns the tag ID of the watch that is attached to global main
+ * loop (>0), or zero if failure detected.
+ */
+guint exec_start_incoming_migration(const char *command, Error **errp)
 {
     QIOChannel *ioc;
     const char *argv[] = { "/bin/sh", "-c", command, NULL };
@@ -62,13 +66,13 @@ void exec_start_incoming_migration(const char *command, Error **errp)
                                                     O_RDWR,
                                                     errp));
     if (!ioc) {
-        return;
+        return 0;
     }
 
     qio_channel_set_name(ioc, "migration-exec-incoming");
-    qio_channel_add_watch(ioc,
-                          G_IO_IN,
-                          exec_accept_incoming_migration,
-                          NULL,
-                          NULL);
+    return qio_channel_add_watch(ioc,
+                                 G_IO_IN,
+                                 exec_accept_incoming_migration,
+                                 NULL,
+                                 NULL);
 }
diff --git a/migration/exec.h b/migration/exec.h
index b210ffde7a..0a7aadacd3 100644
--- a/migration/exec.h
+++ b/migration/exec.h
@@ -19,7 +19,7 @@
 
 #ifndef QEMU_MIGRATION_EXEC_H
 #define QEMU_MIGRATION_EXEC_H
-void exec_start_incoming_migration(const char *host_port, Error **errp);
+guint exec_start_incoming_migration(const char *host_port, Error **errp);
 
 void exec_start_outgoing_migration(MigrationState *s, const char *host_port,
                                    Error **errp);
-- 
2.13.6
