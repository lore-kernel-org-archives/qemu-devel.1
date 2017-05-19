Received: from eggs.gnu.org ([2001:4830:134:3::10]:33906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dBfDW-000190-7E
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:33:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dBfDS-00081T-HV
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:33:06 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 19 May 2017 11:32:45 +0100
Message-Id: <20170519103247.4405-3-stefanha@redhat.com>
In-Reply-To: <20170519103247.4405-1-stefanha@redhat.com>
References: <20170519103247.4405-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/4] block: use BDRV_POLL_WHILE() in
 bdrv_rw_vmstate()
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

Calling aio_poll() directly may have been fine previously, but this is
the future, man!  The difference between an aio_poll() loop and
BDRV_POLL_WHILE() is that BDRV_POLL_WHILE() releases the AioContext
around aio_poll().

This allows the IOThread to run fd handlers or BHs to complete the
request.  Failure to release the AioContext causes deadlocks.

Using BDRV_POLL_WHILE() partially fixes a 'savevm' hang with -object
iothread.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/io.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/io.c b/block/io.c
index cc56e90..f0041cd 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2031,9 +2031,7 @@ bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
         Coroutine *co = qemu_coroutine_create(bdrv_co_rw_vmstate_entry, &data);
 
         bdrv_coroutine_enter(bs, co);
-        while (data.ret == -EINPROGRESS) {
-            aio_poll(bdrv_get_aio_context(bs), true);
-        }
+        BDRV_POLL_WHILE(bs, data.ret == -EINPROGRESS);
         return data.ret;
     }
 }
-- 
2.9.3
