Received: from eggs.gnu.org ([2001:4830:134:3::10]:46301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX6JJ-0004ev-Tu
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:43:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX6JF-0005Z5-W3
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:43:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dX6JF-0005Yj-QE
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:43:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C5A854E04A
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 13:43:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 17 Jul 2017 15:42:35 +0200
Message-Id: <20170717134238.1966-15-quintela@redhat.com>
In-Reply-To: <20170717134238.1966-1-quintela@redhat.com>
References: <20170717134238.1966-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v5 14/17] migration: Delay the start of
 reception on main channel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, berrange@redhat.com

When we start multifd, we will want to delay the main channel until
the others are created.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index d9d5415..e122684 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -358,14 +358,11 @@ static void process_incoming_migration_co(void *opaque)
 
 static void migration_incoming_setup(QEMUFile *f)
 {
-    MigrationIncomingState *mis = migration_incoming_get_current();
-
     if (multifd_load_setup() != 0) {
         /* We haven't been able to create multifd threads
            nothing better to do */
         exit(EXIT_FAILURE);
     }
-    mis->from_src_file = f;
     qemu_file_set_blocking(f, false);
 }
 
@@ -384,18 +381,26 @@ void migration_fd_process_incoming(QEMUFile *f)
 gboolean migration_ioc_process_incoming(QIOChannel *ioc)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
+    gboolean result = FALSE;
 
     if (!mis->from_src_file) {
         QEMUFile *f = qemu_fopen_channel_input(ioc);
         mis->from_src_file = f;
-        migration_fd_process_incoming(f);
-        if (!migrate_use_multifd()) {
-            return FALSE;
-        } else {
-            return TRUE;
+        migration_incoming_setup(f);
+        if (migrate_use_multifd()) {
+            result = TRUE;
         }
+    } else {
+        /* we can only arrive here if multifd is on
+           and this is a new channel */
+        result = multifd_new_channel(ioc);
     }
-    return multifd_new_channel(ioc);
+    if (result == FALSE) {
+        /* called when !multifd and for last multifd channel */
+        migration_incoming_process();
+    }
+
+    return result;
 }
 
 /*
-- 
2.9.4
