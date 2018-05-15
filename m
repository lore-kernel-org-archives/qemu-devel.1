Received: from eggs.gnu.org ([2001:4830:134:3::10]:58175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fIjYe-00032S-7J
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:40:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fIjYc-0001ma-KQ
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:40:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56492 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fIjYc-0001mN-F2
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:40:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0EC1E40201A0
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 23:40:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 16 May 2018 01:39:50 +0200
Message-Id: <20180515234017.2277-14-quintela@redhat.com>
In-Reply-To: <20180515234017.2277-1-quintela@redhat.com>
References: <20180515234017.2277-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 13/40] migration: let incoming side use thread
 context
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

The old incoming migration is running in main thread and default
gcontext.  With the new qio_channel_add_watch_full() we can now let it
run in the thread's own gcontext (if there is one).

Currently this patch does nothing alone.  But when any of the incoming
migration is run in another iothread (e.g., the upcoming migrate-recover
command), this patch will bind the incoming logic to the iothread
instead of the main thread (which may already get page faulted and
hanged).

RDMA is not considered for now since it's not even using the QIO watch
framework at all.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180502104740.12123-2-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/exec.c   | 9 ++++-----
 migration/fd.c     | 9 ++++-----
 migration/socket.c | 7 ++++---
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/migration/exec.c b/migration/exec.c
index 0bc5a427dd..9d0f82f1f0 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -65,9 +65,8 @@ void exec_start_incoming_migration(const char *command, Error **errp)
     }
 
     qio_channel_set_name(ioc, "migration-exec-incoming");
-    qio_channel_add_watch(ioc,
-                          G_IO_IN,
-                          exec_accept_incoming_migration,
-                          NULL,
-                          NULL);
+    qio_channel_add_watch_full(ioc, G_IO_IN,
+                               exec_accept_incoming_migration,
+                               NULL, NULL,
+                               g_main_context_get_thread_default());
 }
diff --git a/migration/fd.c b/migration/fd.c
index cd06182d1e..9a380bbbc4 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -66,9 +66,8 @@ void fd_start_incoming_migration(const char *infd, Error **errp)
     }
 
     qio_channel_set_name(QIO_CHANNEL(ioc), "migration-fd-incoming");
-    qio_channel_add_watch(ioc,
-                          G_IO_IN,
-                          fd_accept_incoming_migration,
-                          NULL,
-                          NULL);
+    qio_channel_add_watch_full(ioc, G_IO_IN,
+                               fd_accept_incoming_migration,
+                               NULL, NULL,
+                               g_main_context_get_thread_default());
 }
diff --git a/migration/socket.c b/migration/socket.c
index 7a5eb562b8..3456eb76e9 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -190,9 +190,10 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
         return;
     }
 
-    qio_net_listener_set_client_func(listener,
-                                     socket_accept_incoming_migration,
-                                     NULL, NULL);
+    qio_net_listener_set_client_func_full(listener,
+                                          socket_accept_incoming_migration,
+                                          NULL, NULL,
+                                          g_main_context_get_thread_default());
 }
 
 void tcp_start_incoming_migration(const char *host_port, Error **errp)
-- 
2.17.0
