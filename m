Received: from eggs.gnu.org ([2001:4830:134:3::10]:51964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fxqjK-0005jC-NR
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 05:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fxqjG-0003ag-RS
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 05:37:38 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu,  6 Sep 2018 12:37:02 +0300
Message-Id: <4bb3cec113bfbe7ae087b18f860cdc8dc3685a34.1536226505.git.berto@igalia.com>
In-Reply-To: <cover.1536226505.git.berto@igalia.com>
References: <cover.1536226505.git.berto@igalia.com>
In-Reply-To: <cover.1536226505.git.berto@igalia.com>
References: <cover.1536226505.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v3 02/10] file-posix: x-check-cache-dropped
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
