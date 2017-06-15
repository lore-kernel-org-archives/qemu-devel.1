Received: from eggs.gnu.org ([2001:4830:134:3::10]:48328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dLXmu-000156-Hk
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 12:38:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dLXmt-00020I-Hl
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 12:38:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dLXmt-00020B-Bo
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 12:38:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 15 Jun 2017 17:38:10 +0100
Message-Id: <20170615163813.7255-3-stefanha@redhat.com>
In-Reply-To: <20170615163813.7255-1-stefanha@redhat.com>
References: <20170615163813.7255-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] migration: hold AioContext lock for loadvm
 qemu_fclose()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>, Stefan Hajnoczi <stefanha@redhat.com>

migration_incoming_state_destroy() uses qemu_fclose() on the vmstate
file.  Make sure to call it inside an AioContext acquire/release region.

This fixes an 'qemu: qemu_mutex_unlock: Operation not permitted' abort
in loadvm.

This patch closes the vmstate file before ending the drained region.
Previously we closed the vmstate file after ending the drained region.
The order does not matter.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 migration/savevm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index ff126a1..943a43c 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2292,11 +2292,11 @@ int load_snapshot(const char *name, Error **errp)
 
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
2.9.4
