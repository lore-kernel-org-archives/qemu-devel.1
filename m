Received: from eggs.gnu.org ([2001:4830:134:3::10]:40736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fcuaw-00035h-UB
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fcuat-0003Gz-2P
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45234 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fcuas-0003GU-Mz
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 50C2677889
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 15:30:22 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 10 Jul 2018 16:30:03 +0100
Message-Id: <20180710153016.131258-3-dgilbert@redhat.com>
In-Reply-To: <20180710153016.131258-1-dgilbert@redhat.com>
References: <20180710153016.131258-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 02/15] migration: move income process out of
 multifd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peterx@redhat.com, quintela@redhat.com

From: Peter Xu <peterx@redhat.com>

Move the call to migration_incoming_process() out of multifd code.  It's
a bit strange that we can migration generic calls in multifd code.
Instead, let multifd_recv_new_channel() return a boolean showing whether
it's ready to continue the incoming migration.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180627132246.5576-3-peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c |  5 ++++-
 migration/ram.c       | 11 +++++------
 migration/ram.h       |  2 +-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 94d71f8b24..aea6fb7444 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -507,7 +507,10 @@ void migration_ioc_process_incoming(QIOChannel *ioc)
         migration_incoming_setup(f);
         return;
     }
-    multifd_recv_new_channel(ioc);
+
+    if (multifd_recv_new_channel(ioc)) {
+        migration_incoming_process();
+    }
 }
 
 /**
diff --git a/migration/ram.c b/migration/ram.c
index 1cd98d6398..23cea47090 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1311,7 +1311,8 @@ bool multifd_recv_all_channels_created(void)
     return thread_count == atomic_read(&multifd_recv_state->count);
 }
 
-void multifd_recv_new_channel(QIOChannel *ioc)
+/* Return true if multifd is ready for the migration, otherwise false */
+bool multifd_recv_new_channel(QIOChannel *ioc)
 {
     MultiFDRecvParams *p;
     Error *local_err = NULL;
@@ -1320,7 +1321,7 @@ void multifd_recv_new_channel(QIOChannel *ioc)
     id = multifd_recv_initial_packet(ioc, &local_err);
     if (id < 0) {
         multifd_recv_terminate_threads(local_err);
-        return;
+        return false;
     }
 
     p = &multifd_recv_state->params[id];
@@ -1328,7 +1329,7 @@ void multifd_recv_new_channel(QIOChannel *ioc)
         error_setg(&local_err, "multifd: received id '%d' already setup'",
                    id);
         multifd_recv_terminate_threads(local_err);
-        return;
+        return false;
     }
     p->c = ioc;
     object_ref(OBJECT(ioc));
@@ -1339,9 +1340,7 @@ void multifd_recv_new_channel(QIOChannel *ioc)
     qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
                        QEMU_THREAD_JOINABLE);
     atomic_inc(&multifd_recv_state->count);
-    if (multifd_recv_state->count == migrate_multifd_channels()) {
-        migration_incoming_process();
-    }
+    return multifd_recv_state->count == migrate_multifd_channels();
 }
 
 /**
diff --git a/migration/ram.h b/migration/ram.h
index d386f4d641..457bf54b8c 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -46,7 +46,7 @@ int multifd_save_cleanup(Error **errp);
 int multifd_load_setup(void);
 int multifd_load_cleanup(Error **errp);
 bool multifd_recv_all_channels_created(void);
-void multifd_recv_new_channel(QIOChannel *ioc);
+bool multifd_recv_new_channel(QIOChannel *ioc);
 
 uint64_t ram_pagesize_summary(void);
 int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len);
-- 
2.17.1
