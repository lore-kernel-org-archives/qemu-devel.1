Received: from eggs.gnu.org ([2001:4830:134:3::10]:44425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dACPB-0001Tl-FD
	for qemu-devel@nongnu.org; Mon, 15 May 2017 05:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dACP6-0001xS-JC
	for qemu-devel@nongnu.org; Mon, 15 May 2017 05:35:05 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Mon, 15 May 2017 12:34:24 +0300
Message-Id: <20170515093424.28954-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH] stream: fix crash in stream_start() when
 block_job_create() fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>

The code that tries to reopen a BlockDriverState in stream_start()
when the creation of a new block job fails crashes because it attempts
to dereference a pointer that is known to be NULL.

This is a regression introduced in a170a91fd3eab6155da39e740381867e,
likely because the code was copied from stream_complete().

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/stream.c b/block/stream.c
index 0113710845..52d329f5c6 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -280,6 +280,6 @@ void stream_start(const char *job_id, BlockDriverState *bs,
 
 fail:
     if (orig_bs_flags != bdrv_get_flags(bs)) {
-        bdrv_reopen(bs, s->bs_flags, NULL);
+        bdrv_reopen(bs, orig_bs_flags, NULL);
     }
 }
-- 
2.11.0
