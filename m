Received: from eggs.gnu.org ([2001:4830:134:3::10]:33946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dBfDZ-0001Cw-UH
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dBfDZ-00082w-2F
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:33:09 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 19 May 2017 11:32:47 +0100
Message-Id: <20170519103247.4405-5-stefanha@redhat.com>
In-Reply-To: <20170519103247.4405-1-stefanha@redhat.com>
References: <20170519103247.4405-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/4] migration: use
 bdrv_drain_all_begin/end() instead bdrv_drain_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

blk/bdrv_drain_all() only takes effect for a single instant and then
resumes block jobs, guest devices, and other external clients like the
NBD server.  This can be handy when performing a synchronous drain
before terminating the program, for example.

Monitor commands usually need to quiesce I/O across an entire code
region so blk/bdrv_drain_all() is not suitable.  They must use
bdrv_drain_all_begin/end() to mark the region.  This prevents new I/O
requests from slipping in or worse - block jobs completing and modifying
the graph.

I audited other blk/bdrv_drain_all() callers but did not find anything
that needs a similar fix.  This patch fixes the savevm/loadvm commands.
Although I haven't encountered a read world issue this makes the code
safer.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 migration/savevm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 3ca319f..f134e48 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2113,6 +2113,8 @@ int save_vmstate(const char *name, Error **errp)
     }
     vm_stop(RUN_STATE_SAVE_VM);
 
+    bdrv_drain_all_begin();
+
     aio_context_acquire(aio_context);
 
     memset(sn, 0, sizeof(*sn));
@@ -2171,6 +2173,9 @@ int save_vmstate(const char *name, Error **errp)
     if (aio_context) {
         aio_context_release(aio_context);
     }
+
+    bdrv_drain_all_end();
+
     if (saved_vm_running) {
         vm_start();
     }
@@ -2279,7 +2284,7 @@ int load_vmstate(const char *name, Error **errp)
     }
 
     /* Flush all IO requests so they don't interfere with the new state.  */
-    bdrv_drain_all();
+    bdrv_drain_all_begin();
 
     ret = bdrv_all_goto_snapshot(name, &bs);
     if (ret < 0) {
@@ -2303,6 +2308,8 @@ int load_vmstate(const char *name, Error **errp)
     qemu_fclose(f);
     aio_context_release(aio_context);
 
+    bdrv_drain_all_end();
+
     migration_incoming_state_destroy();
     if (ret < 0) {
         error_setg(errp, "Error %d while loading VM state", ret);
-- 
2.9.3
