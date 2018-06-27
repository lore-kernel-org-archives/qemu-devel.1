Received: from eggs.gnu.org ([2001:4830:134:3::10]:55719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fYAPT-0005vl-Jv
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fYAPS-0003d6-I7
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:22:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50458 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fYAPS-0003cT-9J
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:22:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E1EC2805A530
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 13:22:57 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 27 Jun 2018 21:22:44 +0800
Message-Id: <20180627132246.5576-3-peterx@redhat.com>
In-Reply-To: <20180627132246.5576-1-peterx@redhat.com>
References: <20180627132246.5576-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/4] migration: move income process out of
 multifd
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

Move the call to migration_incoming_process() out of multifd code.  It's
a bit strange that we can migration generic calls in multifd code.
Instead, let multifd_recv_new_channel() return a boolean showing whether
it's ready to continue the incoming migration.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.h       |  2 +-
 migration/migration.c |  5 ++++-
 migration/ram.c       | 11 +++++------
 3 files changed, 10 insertions(+), 8 deletions(-)

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
diff --git a/migration/migration.c b/migration/migration.c
index e1eaa97df4..6ecea2de30 100644
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
index cd5f55117d..52167d5142 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -873,7 +873,8 @@ bool multifd_recv_all_channels_created(void)
     return thread_count == atomic_read(&multifd_recv_state->count);
 }
 
-void multifd_recv_new_channel(QIOChannel *ioc)
+/* Return true if multifd is ready for the migration, otherwise false */
+bool multifd_recv_new_channel(QIOChannel *ioc)
 {
     MultiFDRecvParams *p;
     Error *local_err = NULL;
@@ -882,7 +883,7 @@ void multifd_recv_new_channel(QIOChannel *ioc)
     id = multifd_recv_initial_packet(ioc, &local_err);
     if (id < 0) {
         multifd_recv_terminate_threads(local_err);
-        return;
+        return false;
     }
 
     p = &multifd_recv_state->params[id];
@@ -890,7 +891,7 @@ void multifd_recv_new_channel(QIOChannel *ioc)
         error_setg(&local_err, "multifd: received id '%d' already setup'",
                    id);
         multifd_recv_terminate_threads(local_err);
-        return;
+        return false;
     }
     p->c = ioc;
     object_ref(OBJECT(ioc));
@@ -899,9 +900,7 @@ void multifd_recv_new_channel(QIOChannel *ioc)
     qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
                        QEMU_THREAD_JOINABLE);
     atomic_inc(&multifd_recv_state->count);
-    if (multifd_recv_state->count == migrate_multifd_channels()) {
-        migration_incoming_process();
-    }
+    return multifd_recv_state->count == migrate_multifd_channels();
 }
 
 /**
-- 
2.17.1
