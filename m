Received: from eggs.gnu.org ([2001:4830:134:3::10]:36346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJSY-0000kw-Bj
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:03:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJSV-0007DX-0g
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:03:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eCJSU-0007DA-Qv
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:03:30 -0500
From: Peter Xu <peterx@redhat.com>
Date: Wed,  8 Nov 2017 14:01:28 +0800
Message-Id: <20171108060130.3772-31-peterx@redhat.com>
In-Reply-To: <20171108060130.3772-1-peterx@redhat.com>
References: <20171108060130.3772-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 30/32] migration: delay the postcopy-active
 state switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Switch the state until we try to start the VM on destination side.  The
problem is that without doing this we may have a very small window that
we'll be in such a state:

- dst VM is in postcopy-active state,
- main thread is handling MIG_CMD_PACKAGED message, which loads all the
  device states,
- ram load thread is reading memory data from source.

Then if we failed at this point when reading the migration stream we'll
also switch to postcopy-paused state, but that is not what we want.  If
device states failed to load, we should fail the migration directly
instead of pause.

Postponing the state switch to the point when we have already loaded the
devices' states and been ready to start running destination VM.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index bc87b0e5b1..3bc792e320 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1584,8 +1584,6 @@ static void *postcopy_ram_listen_thread(void *opaque)
     QEMUFile *f = mis->from_src_file;
     int load_res;
 
-    migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
-                                   MIGRATION_STATUS_POSTCOPY_ACTIVE);
     qemu_sem_post(&mis->listen_thread_sem);
     trace_postcopy_ram_listen_thread_start();
 
@@ -1748,6 +1746,14 @@ static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
         return -1;
     }
 
+    /*
+     * Declare that we are in postcopy now.  We should already have
+     * all the device states loaded ready when reach here, and also
+     * the ram load thread running.
+     */
+    migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
+                                   MIGRATION_STATUS_POSTCOPY_ACTIVE);
+
     data = g_new(HandleRunBhData, 1);
     data->bh = qemu_bh_new(loadvm_postcopy_handle_run_bh, data);
     qemu_bh_schedule(data->bh);
-- 
2.13.6
