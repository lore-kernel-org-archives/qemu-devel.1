Received: from eggs.gnu.org ([2001:4830:134:3::10]:35847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ePtbd-0000bi-JD
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:17:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ePtbb-0001oM-RF
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:17:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ePtbb-0001lR-Ko
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:17:03 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E04202CE95C
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 17:17:02 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 15 Dec 2017 17:16:54 +0000
Message-Id: <20171215171655.7818-2-dgilbert@redhat.com>
In-Reply-To: <20171215171655.7818-1-dgilbert@redhat.com>
References: <20171215171655.7818-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] migration: Allow migrate_fd_connect to
 take an Error *
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, berrange@redhat.com
Cc: quintela@redhat.com, peterx@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Allow whatever is performing the connection to pass migrate_fd_connect
an error to indicate there was a problem during connection, an allow
us to clean up.

The caller must free the error.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/channel.c   | 2 +-
 migration/migration.c | 7 ++++++-
 migration/migration.h | 2 +-
 migration/rdma.c      | 2 +-
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 70ec7ea3b7..fdb7ddbd17 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -78,6 +78,6 @@ void migration_channel_connect(MigrationState *s,
 
         s->to_dst_file = f;
 
-        migrate_fd_connect(s);
+        migrate_fd_connect(s, NULL);
     }
 }
diff --git a/migration/migration.c b/migration/migration.c
index 4de3b551fe..10a4260f27 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2333,10 +2333,15 @@ static void *migration_thread(void *opaque)
     return NULL;
 }
 
-void migrate_fd_connect(MigrationState *s)
+void migrate_fd_connect(MigrationState *s, Error *error_in)
 {
     s->expected_downtime = s->parameters.downtime_limit;
     s->cleanup_bh = qemu_bh_new(migrate_fd_cleanup, s);
+    if (error_in) {
+        migrate_fd_error(s, error_in);
+        migrate_fd_cleanup(s);
+        return;
+    }
 
     qemu_file_set_blocking(s->to_dst_file, true);
     qemu_file_set_rate_limit(s->to_dst_file,
diff --git a/migration/migration.h b/migration/migration.h
index 663415fe48..e67e5e87c2 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -168,7 +168,7 @@ uint64_t migrate_max_downtime(void);
 void migrate_set_error(MigrationState *s, const Error *error);
 void migrate_fd_error(MigrationState *s, const Error *error);
 
-void migrate_fd_connect(MigrationState *s);
+void migrate_fd_connect(MigrationState *s, Error *error_in);
 
 MigrationState *migrate_init(void);
 bool migration_is_blocked(Error **errp);
diff --git a/migration/rdma.c b/migration/rdma.c
index ca56594328..cc7049c594 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3758,7 +3758,7 @@ void rdma_start_outgoing_migration(void *opaque,
     trace_rdma_start_outgoing_migration_after_rdma_connect();
 
     s->to_dst_file = qemu_fopen_rdma(rdma, "wb");
-    migrate_fd_connect(s);
+    migrate_fd_connect(s, NULL);
     return;
 err:
     g_free(rdma);
-- 
2.14.3
