Received: from eggs.gnu.org ([2001:4830:134:3::10]:35459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmyTS-00019l-AW
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmyTN-0004YK-BV
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:35:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dmyTN-0004Xp-5F
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:35:41 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 30 Aug 2017 16:32:27 +0800
Message-Id: <1504081950-2528-31-git-send-email-peterx@redhat.com>
In-Reply-To: <1504081950-2528-1-git-send-email-peterx@redhat.com>
References: <1504081950-2528-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v2 30/33] migration: return incoming task tag for
 fd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

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
