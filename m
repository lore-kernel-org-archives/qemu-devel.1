Received: from eggs.gnu.org ([2001:4830:134:3::10]:36698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fwpwh-0004G3-SJ
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 10:35:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fwpwc-0000YE-KJ
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 10:35:15 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Mon,  3 Sep 2018 17:34:00 +0300
Message-Id: <986c6eea52cb87132f7d889856efd7c4c9db78bc.1535983918.git.berto@igalia.com>
In-Reply-To: <cover.1535983918.git.berto@igalia.com>
References: <cover.1535983918.git.berto@igalia.com>
In-Reply-To: <cover.1535983918.git.berto@igalia.com>
References: <cover.1535983918.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 02/10] file-posix: x-check-cache-dropped
 should default to false on reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

The default value of x-check-cache-dropped is false. There's no reason
to use the previous value as a default in raw_reopen_prepare() because
bdrv_reopen_queue_child() already takes care of putting the old
options in the BDRVReopenState.options QDict.

If x-check-cache-dropped was previously set but is now missing from
the reopen QDict then it should be reset to false.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/file-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index fe83cbf0eb..ddac0cc3e6 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -851,7 +851,7 @@ static int raw_reopen_prepare(BDRVReopenState *state,
     }
 
     rs->check_cache_dropped = qemu_opt_get_bool(opts, "x-check-cache-dropped",
-                                                s->check_cache_dropped);
+                                                false);
 
     if (s->type == FTYPE_CD) {
         rs->open_flags |= O_NONBLOCK;
-- 
2.11.0
