Received: from eggs.gnu.org ([2001:4830:134:3::10]:38349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGVh8-0004Ry-RM
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:23:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGVh7-0004u8-V1
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:23:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dGVh7-0004tp-Ol
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:23:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B914837E72
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 19:23:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  1 Jun 2017 21:23:17 +0200
Message-Id: <20170601192327.29712-6-quintela@redhat.com>
In-Reply-To: <20170601192327.29712-1-quintela@redhat.com>
References: <20170601192327.29712-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 05/15] migration: shut src return path
 unconditionally
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

From: Peter Xu <peterx@redhat.com>

We were do the shutting off only for postcopy. Now we do this as long as
the source return path is there.

Moving the cleanup of from_src_file there too.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c    | 8 +++++++-
 migration/postcopy-ram.c | 1 -
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index b90e399..5d9ccf1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -134,10 +134,17 @@ void migration_incoming_state_destroy(void)
     struct MigrationIncomingState *mis = migration_incoming_get_current();
 
     if (mis->to_src_file) {
+        /* Tell source that we are done */
+        migrate_send_rp_shut(mis, qemu_file_get_error(mis->from_src_file) != 0);
         qemu_fclose(mis->to_src_file);
         mis->to_src_file = NULL;
     }
 
+    if (mis->from_src_file) {
+        qemu_fclose(mis->from_src_file);
+        mis->from_src_file = NULL;
+    }
+
     qemu_event_destroy(&mis->main_thread_load_event);
 }
 
@@ -435,7 +442,6 @@ static void process_incoming_migration_co(void *opaque)
         exit(EXIT_FAILURE);
     }
 
-    qemu_fclose(f);
     free_xbzrle_decoded_buf();
 
     mis->bh = qemu_bh_new(process_incoming_migration_bh, mis);
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 3f9ae1b..5ceb623 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -333,7 +333,6 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
     }
 
     postcopy_state_set(POSTCOPY_INCOMING_END);
-    migrate_send_rp_shut(mis, qemu_file_get_error(mis->from_src_file) != 0);
 
     if (mis->postcopy_tmp_page) {
         munmap(mis->postcopy_tmp_page, mis->largest_page_size);
-- 
2.9.4
