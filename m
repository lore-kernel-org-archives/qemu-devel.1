Received: from eggs.gnu.org ([2001:4830:134:3::10]:48653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fLkIe-00031Q-Pt
	for qemu-devel@nongnu.org; Thu, 24 May 2018 03:04:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fLkIZ-0003XL-QD
	for qemu-devel@nongnu.org; Thu, 24 May 2018 03:04:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37478 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fLkIZ-0003XA-K1
	for qemu-devel@nongnu.org; Thu, 24 May 2018 03:04:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DB1994022407
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 07:04:30 +0000 (UTC)
Date: Thu, 24 May 2018 15:04:25 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180524070425.GB12122@xz-mi>
References: <20180523091411.1073-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180523091411.1073-1-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration: fix exec/fd migrations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Wed, May 23, 2018 at 11:14:11AM +0200, Juan Quintela wrote:
> Commit:
> 
> commit 36c2f8be2c4eb0003ac77a14910842b7ddd7337e
> Author: Juan Quintela <quintela@redhat.com>
> Date:   Wed Mar 7 08:40:52 2018 +0100
> 
>     migration: Delay start of migration main routines
> 
> Missed tcp and fd transports.  This fix its.
> 
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/exec.c | 4 ++++
>  migration/fd.c   | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/migration/exec.c b/migration/exec.c
> index 9d0f82f1f0..0bbeb63c97 100644
> --- a/migration/exec.c
> +++ b/migration/exec.c
> @@ -20,6 +20,7 @@
>  #include "qemu/osdep.h"
>  #include "channel.h"
>  #include "exec.h"
> +#include "migration.h"
>  #include "io/channel-command.h"
>  #include "trace.h"
>  
> @@ -48,6 +49,9 @@ static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
>  {
>      migration_channel_process_incoming(ioc);
>      object_unref(OBJECT(ioc));
> +    if (!migrate_use_multifd()) {
> +        migration_incoming_process();
> +    }
>      return G_SOURCE_REMOVE;
>  }
>  
> diff --git a/migration/fd.c b/migration/fd.c
> index 9a380bbbc4..fee34ffdc0 100644
> --- a/migration/fd.c
> +++ b/migration/fd.c
> @@ -17,6 +17,7 @@
>  #include "qemu/osdep.h"
>  #include "channel.h"
>  #include "fd.h"
> +#include "migration.h"
>  #include "monitor/monitor.h"
>  #include "io/channel-util.h"
>  #include "trace.h"
> @@ -48,6 +49,9 @@ static gboolean fd_accept_incoming_migration(QIOChannel *ioc,
>  {
>      migration_channel_process_incoming(ioc);
>      object_unref(OBJECT(ioc));
> +    if (!migrate_use_multifd()) {
> +        migration_incoming_process();
> +    }
>      return G_SOURCE_REMOVE;
>  }

We are calling migration_incoming_process() everywhere...  But
actually we have a single entrance at
migration_ioc_process_incoming().  How about we still use a single
entrance for migration instead (and actually I just noticed that
postcopy recovery should be broken now on master since now we don't
call migration_fd_process_incoming at all...).  I mean something like
this (even not tested with compile, just to show what I mean):

diff --git a/migration/migration.c b/migration/migration.c
index 05aec2c905..fb27daf940 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -468,7 +468,6 @@ void migration_fd_process_incoming(QEMUFile *f)
         qemu_sem_post(&mis->postcopy_pause_sem_dst);
     } else {
         /* New incoming migration */
-        migration_incoming_setup(f);
         migration_incoming_process();
     }
 }
@@ -476,13 +475,24 @@ void migration_fd_process_incoming(QEMUFile *f)
 void migration_ioc_process_incoming(QIOChannel *ioc)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
+    bool start_migration = true;
 
     if (!mis->from_src_file) {
         QEMUFile *f = qemu_fopen_channel_input(ioc);
         migration_incoming_setup(f);
-        return;
+        if (migrate_use_multifd()) {
+            /* We need to wait until all channels settled */
+            return;
+        }
+    }
+
+    if (migrate_use_multifd()) {
+        start_migration = multifd_recv_new_channel(ioc);
+    }
+
+    if (start_migration) {
+        migration_fd_process_incoming(mis->from_src_file);
     }
-    multifd_recv_new_channel(ioc);
 }
 
 /**
diff --git a/migration/ram.c b/migration/ram.c
index 5bcbf7a9f9..dad3ed03b8 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -866,7 +866,8 @@ bool multifd_recv_all_channels_created(void)
     return thread_count == atomic_read(&multifd_recv_state->count);
 }
 
-void multifd_recv_new_channel(QIOChannel *ioc)
+/* Return true if we have all the channels ready; otherwise false */
+bool multifd_recv_new_channel(QIOChannel *ioc)
 {
     MultiFDRecvParams *p;
     Error *local_err = NULL;
@@ -892,9 +893,8 @@ void multifd_recv_new_channel(QIOChannel *ioc)
     qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
                        QEMU_THREAD_JOINABLE);
     atomic_inc(&multifd_recv_state->count);
-    if (multifd_recv_state->count == migrate_multifd_channels()) {
-        migration_incoming_process();
-    }
+
+    return multifd_recv_state->count == migrate_multifd_channels();
 }
 
 /**
diff --git a/migration/rdma.c b/migration/rdma.c
index 7d233b0820..6f8c6d9abc 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3696,6 +3696,7 @@ static void rdma_accept_incoming_migration(void *opaque)
     }
 
     rdma->migration_started_on_destination = 1;
+    migration_incoming_setup(f);
     migration_fd_process_incoming(f);
 }
 
diff --git a/migration/socket.c b/migration/socket.c
index 3456eb76e9..18321c9605 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -170,10 +170,6 @@ static void socket_accept_incoming_migration(QIONetListener *listener,
         qio_net_listener_disconnect(listener);
 
         object_unref(OBJECT(listener));
-
-        if (!migrate_use_multifd()) {
-            migration_incoming_process();
-        }
     }
 }
 
This patch will make sure we call migration_incoming_process() only
once, logically speaking it should also fix the breakage of postcopy
recovery.

What do you think?

CC Dan too.

Thanks,

-- 
Peter Xu
