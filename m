Received: from eggs.gnu.org ([2001:4830:134:3::10]:48246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dhVAS-0005pG-Uv
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 02:17:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dhVAR-00018h-PV
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 02:17:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dhVAR-00018Y-Jt
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 02:17:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A248D3E2BD
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 06:17:30 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue, 15 Aug 2017 14:17:05 +0800
Message-Id: <1502777827-18874-5-git-send-email-peterx@redhat.com>
In-Reply-To: <1502777827-18874-1-git-send-email-peterx@redhat.com>
References: <1502777827-18874-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 4/6] migration: return incoming task tag for fd
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

Allow to return the task tag in fd_start_incoming_migration().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/fd.c | 18 +++++++++++-------
 migration/fd.h |  2 +-
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/migration/fd.c b/migration/fd.c
index 30f5258..e9a548c 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -52,7 +52,11 @@ static gboolean fd_accept_incoming_migration(QIOChannel *ioc,
     return FALSE; /* unregister */
 }
 
-void fd_start_incoming_migration(const char *infd, Error **errp)
+/*
+ * Returns the tag ID of the watch that is attached to global main
+ * loop (>0), or zero if failure detected.
+ */
+guint fd_start_incoming_migration(const char *infd, Error **errp)
 {
     QIOChannel *ioc;
     int fd;
@@ -63,13 +67,13 @@ void fd_start_incoming_migration(const char *infd, Error **errp)
     ioc = qio_channel_new_fd(fd, errp);
     if (!ioc) {
         close(fd);
-        return;
+        return 0;
     }
 
     qio_channel_set_name(QIO_CHANNEL(ioc), "migration-fd-incoming");
-    qio_channel_add_watch(ioc,
-                          G_IO_IN,
-                          fd_accept_incoming_migration,
-                          NULL,
-                          NULL);
+    return qio_channel_add_watch(ioc,
+                                 G_IO_IN,
+                                 fd_accept_incoming_migration,
+                                 NULL,
+                                 NULL);
 }
diff --git a/migration/fd.h b/migration/fd.h
index a14a63c..94cdea8 100644
--- a/migration/fd.h
+++ b/migration/fd.h
@@ -16,7 +16,7 @@
 
 #ifndef QEMU_MIGRATION_FD_H
 #define QEMU_MIGRATION_FD_H
-void fd_start_incoming_migration(const char *path, Error **errp);
+guint fd_start_incoming_migration(const char *path, Error **errp);
 
 void fd_start_outgoing_migration(MigrationState *s, const char *fdname,
                                  Error **errp);
-- 
2.7.4
