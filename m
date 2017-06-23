Received: from eggs.gnu.org ([2001:4830:134:3::10]:59231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORLf-0000WT-96
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORLe-0007V6-71
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:19 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Jun 2017 18:21:05 +0200
Message-Id: <1498234919-27316-8-git-send-email-kwolf@redhat.com>
In-Reply-To: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 07/61] migration: use bdrv_drain_all_begin/end()
 instead bdrv_drain_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Stefan Hajnoczi <stefanha@redhat.com>

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
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 migration/savevm.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 5846d9c..b08df04 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2107,6 +2107,8 @@ int save_snapshot(const char *name, Error **errp)
     }
     vm_stop(RUN_STATE_SAVE_VM);
 
+    bdrv_drain_all_begin();
+
     aio_context_acquire(aio_context);
 
     memset(sn, 0, sizeof(*sn));
@@ -2165,6 +2167,9 @@ int save_snapshot(const char *name, Error **errp)
     if (aio_context) {
         aio_context_release(aio_context);
     }
+
+    bdrv_drain_all_end();
+
     if (saved_vm_running) {
         vm_start();
     }
@@ -2273,20 +2278,21 @@ int load_snapshot(const char *name, Error **errp)
     }
 
     /* Flush all IO requests so they don't interfere with the new state.  */
-    bdrv_drain_all();
+    bdrv_drain_all_begin();
 
     ret = bdrv_all_goto_snapshot(name, &bs);
     if (ret < 0) {
         error_setg(errp, "Error %d while activating snapshot '%s' on '%s'",
                      ret, name, bdrv_get_device_name(bs));
-        return ret;
+        goto err_drain;
     }
 
     /* restore the VM state */
     f = qemu_fopen_bdrv(bs_vm_state, 0);
     if (!f) {
         error_setg(errp, "Could not open VM state file");
-        return -EINVAL;
+        ret = -EINVAL;
+        goto err_drain;
     }
 
     qemu_system_reset(SHUTDOWN_CAUSE_NONE);
@@ -2296,6 +2302,8 @@ int load_snapshot(const char *name, Error **errp)
     ret = qemu_loadvm_state(f);
     aio_context_release(aio_context);
 
+    bdrv_drain_all_end();
+
     migration_incoming_state_destroy();
     if (ret < 0) {
         error_setg(errp, "Error %d while loading VM state", ret);
@@ -2303,6 +2311,10 @@ int load_snapshot(const char *name, Error **errp)
     }
 
     return 0;
+
+err_drain:
+    bdrv_drain_all_end();
+    return ret;
 }
 
 void vmstate_register_ram(MemoryRegion *mr, DeviceState *dev)
-- 
1.8.3.1
