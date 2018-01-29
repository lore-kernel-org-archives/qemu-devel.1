Received: from eggs.gnu.org ([2001:4830:134:3::10]:41283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eg8Fy-0005WQ-LQ
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:09:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eg8Fs-0001CH-OC
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:09:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eg8Fs-0001B5-JE
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:09:44 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F182518B25B
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 12:09:43 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 29 Jan 2018 13:09:20 +0100
Message-Id: <20180129120932.12874-2-quintela@redhat.com>
In-Reply-To: <20180129120932.12874-1-quintela@redhat.com>
References: <20180129120932.12874-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 01/13] migration: Allow migrate_fd_connect to
 take an Error *
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Allow whatever is performing the connection to pass migrate_fd_connect
an error to indicate there was a problem during connection, an allow
us to clean up.

The caller must free the error.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
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
index c99a4e62d7..1fbd304c66 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2378,10 +2378,15 @@ static void *migration_thread(void *opaque)
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
index 786d971ce2..d3b214e5ba 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -190,7 +190,7 @@ uint64_t migrate_max_downtime(void);
 void migrate_set_error(MigrationState *s, const Error *error);
 void migrate_fd_error(MigrationState *s, const Error *error);
 
-void migrate_fd_connect(MigrationState *s);
+void migrate_fd_connect(MigrationState *s, Error *error_in);
 
 MigrationState *migrate_init(void);
 bool migration_is_blocked(Error **errp);
diff --git a/migration/rdma.c b/migration/rdma.c
index 9d5a424011..da474fc19f 100644
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
