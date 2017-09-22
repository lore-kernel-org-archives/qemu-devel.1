Received: from eggs.gnu.org ([2001:4830:134:3::10]:52880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dvN1A-00027t-OZ
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dvN19-0001UG-Or
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:25:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dvN19-0001Tp-IL
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:25:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A96B85F7BC
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 12:25:14 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 22 Sep 2017 14:24:49 +0200
Message-Id: <20170922122505.9413-3-quintela@redhat.com>
In-Reply-To: <20170922122505.9413-1-quintela@redhat.com>
References: <20170922122505.9413-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 02/18] migration: Teach it about G_SOURCE_REMOVE
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

As this is defined on glib 2.32, add compatibility macros for older glibs.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/glib-compat.h | 2 ++
 migration/exec.c      | 2 +-
 migration/fd.c        | 2 +-
 migration/socket.c    | 2 +-
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/glib-compat.h b/include/glib-compat.h
index fcffcd3f07..e15aca2d40 100644
--- a/include/glib-compat.h
+++ b/include/glib-compat.h
@@ -223,6 +223,8 @@ static inline gboolean g_hash_table_contains(GHashTable *hash_table,
 {
     return g_hash_table_lookup_extended(hash_table, key, NULL, NULL);
 }
+#define G_SOURCE_CONTINUE TRUE
+#define G_SOURCE_REMOVE FALSE
 #endif
 
 #ifndef g_assert_true
diff --git a/migration/exec.c b/migration/exec.c
index 08b599e0e2..f3be1baf2e 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -49,7 +49,7 @@ static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
 {
     migration_channel_process_incoming(ioc);
     object_unref(OBJECT(ioc));
-    return FALSE; /* unregister */
+    return G_SOURCE_REMOVE;
 }
 
 void exec_start_incoming_migration(const char *command, Error **errp)
diff --git a/migration/fd.c b/migration/fd.c
index 30f5258a6a..30de4b9847 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -49,7 +49,7 @@ static gboolean fd_accept_incoming_migration(QIOChannel *ioc,
 {
     migration_channel_process_incoming(ioc);
     object_unref(OBJECT(ioc));
-    return FALSE; /* unregister */
+    return G_SOURCE_REMOVE;
 }
 
 void fd_start_incoming_migration(const char *infd, Error **errp)
diff --git a/migration/socket.c b/migration/socket.c
index 757d3821a1..b02d37d7a3 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -154,7 +154,7 @@ static gboolean socket_accept_incoming_migration(QIOChannel *ioc,
 out:
     /* Close listening socket as its no longer needed */
     qio_channel_close(ioc, NULL);
-    return FALSE; /* unregister */
+    return G_SOURCE_REMOVE;
 }
 
 
-- 
2.13.5
