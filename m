Received: from eggs.gnu.org ([2001:4830:134:3::10]:39195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxusx-0004FD-K3
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxusw-0003xp-Nl
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:27:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cxusw-0003xf-Il
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:27:02 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 11 Apr 2017 20:26:29 +0800
Message-Id: <20170411122632.14050-9-famz@redhat.com>
In-Reply-To: <20170411122632.14050-1-famz@redhat.com>
References: <20170411122632.14050-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 08/11] qemu-io-cmds: Use bdrv_coroutine_enter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, famz@redhat.com

qemu_coroutine_create associates @co to qemu_aio_context but we poll
blk's context below. If the coroutine yields, it may never get resumed
again.

Use bdrv_coroutine_enter to make sure we are starting the I/O on the
right context.

Signed-off-by: Fam Zheng <famz@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-io-cmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 883f53b..312fc6d 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -521,7 +521,7 @@ static int do_co_pwrite_zeroes(BlockBackend *blk, int64_t offset,
     }
 
     co = qemu_coroutine_create(co_pwrite_zeroes_entry, &data);
-    qemu_coroutine_enter(co);
+    bdrv_coroutine_enter(blk_bs(blk), co);
     while (!data.done) {
         aio_poll(blk_get_aio_context(blk), true);
     }
-- 
2.9.3
