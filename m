Received: from eggs.gnu.org ([2001:4830:134:3::10]:57748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpfGw-00039J-5D
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:42:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpfGr-0001wa-Fa
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:41:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dpfGr-0001ue-9s
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:41:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 603766146E
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 18:41:52 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed,  6 Sep 2017 19:41:33 +0100
Message-Id: <20170906184133.25524-9-dgilbert@redhat.com>
In-Reply-To: <20170906184133.25524-1-dgilbert@redhat.com>
References: <20170906184133.25524-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 8/8] migration: dump str in migrate_set_state
 trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, armbru@redhat.com, kwolf@redhat.com

From: Peter Xu <peterx@redhat.com>

Strings are more readable for debugging.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1504081950-2528-5-git-send-email-peterx@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  Fixed up merge with 977c73
---
 migration/migration.c  | 3 ++-
 migration/trace-events | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 9838ccc885..959e8ec88e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -913,8 +913,9 @@ void qmp_migrate_start_postcopy(Error **errp)
 
 void migrate_set_state(int *state, int old_state, int new_state)
 {
+    assert(new_state < MIGRATION_STATUS__MAX);
     if (atomic_cmpxchg(state, old_state, new_state) == old_state) {
-        trace_migrate_set_state(new_state);
+        trace_migrate_set_state(MigrationStatus_str(new_state));
         migrate_generate_event(new_state);
     }
 }
diff --git a/migration/trace-events b/migration/trace-events
index 7a3b5144ff..d2910a6e7b 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -80,7 +80,7 @@ ram_save_queue_pages(const char *rbname, size_t start, size_t len) "%s: start: 0
 # migration/migration.c
 await_return_path_close_on_source_close(void) ""
 await_return_path_close_on_source_joining(void) ""
-migrate_set_state(int new_state) "new state %d"
+migrate_set_state(const char *new_state) "new state %s"
 migrate_fd_cleanup(void) ""
 migrate_fd_error(const char *error_desc) "error=%s"
 migrate_fd_cancel(void) ""
-- 
2.13.5
