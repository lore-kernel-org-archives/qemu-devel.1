Received: from eggs.gnu.org ([2001:4830:134:3::10]:36760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBbdp-0000f7-Ky
	for qemu-devel@nongnu.org; Fri, 19 May 2017 02:44:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBbdo-0004Bh-PO
	for qemu-devel@nongnu.org; Fri, 19 May 2017 02:44:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dBbdo-0004B2-Iy
	for qemu-devel@nongnu.org; Fri, 19 May 2017 02:44:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7EA48C057FA8
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 06:43:59 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri, 19 May 2017 14:43:30 +0800
Message-Id: <1495176212-14446-5-git-send-email-peterx@redhat.com>
In-Reply-To: <1495176212-14446-1-git-send-email-peterx@redhat.com>
References: <1495176212-14446-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 4/6] migration: shut src return path
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
Cc: Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

We were do the shutting off only for postcopy. Now we do this as long as
the source return path is there.

Moving the cleanup of from_src_file there too.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c    | 8 +++++++-
 migration/postcopy-ram.c | 1 -
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 92617fc..a4006b4 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -131,10 +131,17 @@ void migration_incoming_state_destroy(void)
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
     loadvm_free_handlers(mis);
 }
@@ -433,7 +440,6 @@ static void process_incoming_migration_co(void *opaque)
         exit(EXIT_FAILURE);
     }
 
-    qemu_fclose(f);
     free_xbzrle_decoded_buf();
 
     mis->bh = qemu_bh_new(process_incoming_migration_bh, mis);
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index a0489f6..57aa208 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -320,7 +320,6 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
     }
 
     postcopy_state_set(POSTCOPY_INCOMING_END);
-    migrate_send_rp_shut(mis, qemu_file_get_error(mis->from_src_file) != 0);
 
     if (mis->postcopy_tmp_page) {
         munmap(mis->postcopy_tmp_page, mis->largest_page_size);
-- 
2.7.4
