Received: from eggs.gnu.org ([2001:4830:134:3::10]:57448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71qx-0002Gt-1Z
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71qo-0006y2-UH
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:20 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  1 Oct 2018 19:18:41 +0200
Message-Id: <20181001171901.11004-4-kwolf@redhat.com>
In-Reply-To: <20181001171901.11004-1-kwolf@redhat.com>
References: <20181001171901.11004-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 03/23] file-posix: x-check-cache-dropped should
 default to false on reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

The default value of x-check-cache-dropped is false. There's no reason
to use the previous value as a default in raw_reopen_prepare() because
bdrv_reopen_queue_child() already takes care of putting the old
options in the BDRVReopenState.options QDict.

If x-check-cache-dropped was previously set but is now missing from
the reopen QDict then it should be reset to false.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 327f39ca45..bc5e54560a 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -850,7 +850,7 @@ static int raw_reopen_prepare(BDRVReopenState *state,
     }
 
     rs->check_cache_dropped = qemu_opt_get_bool(opts, "x-check-cache-dropped",
-                                                s->check_cache_dropped);
+                                                false);
 
     if (s->type == FTYPE_CD) {
         rs->open_flags |= O_NONBLOCK;
-- 
2.13.6
