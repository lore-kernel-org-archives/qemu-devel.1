Received: from eggs.gnu.org ([2001:4830:134:3::10]:59333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORLi-0000kK-QW
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORLh-0007Xd-QW
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:22 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Jun 2017 18:21:10 +0200
Message-Id: <1498234919-27316-13-git-send-email-kwolf@redhat.com>
In-Reply-To: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 12/61] migration: hold AioContext lock for
 loadvm qemu_fclose()
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

migration_incoming_state_destroy() uses qemu_fclose() on the vmstate
file.  Make sure to call it inside an AioContext acquire/release region.

This fixes an 'qemu: qemu_mutex_unlock: Operation not permitted' abort
in loadvm.

This patch closes the vmstate file before ending the drained region.
Previously we closed the vmstate file after ending the drained region.
The order does not matter.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 migration/savevm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index b08df04..c7a49c9 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2300,11 +2300,11 @@ int load_snapshot(const char *name, Error **errp)
 
     aio_context_acquire(aio_context);
     ret = qemu_loadvm_state(f);
+    migration_incoming_state_destroy();
     aio_context_release(aio_context);
 
     bdrv_drain_all_end();
 
-    migration_incoming_state_destroy();
     if (ret < 0) {
         error_setg(errp, "Error %d while loading VM state", ret);
         return ret;
-- 
1.8.3.1
