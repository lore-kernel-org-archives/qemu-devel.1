Received: from eggs.gnu.org ([2001:4830:134:3::10]:48229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dhVAR-0005pD-VC
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 02:17:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dhVAO-00017y-QU
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 02:17:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dhVAO-00017J-KA
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 02:17:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 222DA4E334
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 06:17:26 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue, 15 Aug 2017 14:17:04 +0800
Message-Id: <1502777827-18874-4-git-send-email-peterx@redhat.com>
In-Reply-To: <1502777827-18874-1-git-send-email-peterx@redhat.com>
References: <1502777827-18874-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 3/6] migration: return incoming task tag for exec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Return the async task tag for exec typed incoming migration in
exec_start_incoming_migration().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/exec.c | 18 +++++++++++-------
 migration/exec.h |  2 +-
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/migration/exec.c b/migration/exec.c
index 08b599e..ef1fb4c 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -52,7 +52,11 @@ static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
     return FALSE; /* unregister */
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
index b210ffd..0a7aada 100644
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
2.7.4
