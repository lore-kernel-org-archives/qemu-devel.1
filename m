Received: from eggs.gnu.org ([2001:4830:134:3::10]:45412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFMG8-0000pr-7u
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFMG7-0006Lr-CE
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:07:04 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 29 May 2017 17:06:40 +0200
Message-Id: <1496070414-6744-2-git-send-email-kwolf@redhat.com>
In-Reply-To: <1496070414-6744-1-git-send-email-kwolf@redhat.com>
References: <1496070414-6744-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 01/15] stream: fix crash in stream_start() when
 block_job_create() fails
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

From: Alberto Garcia <berto@igalia.com>

The code that tries to reopen a BlockDriverState in stream_start()
when the creation of a new block job fails crashes because it attempts
to dereference a pointer that is known to be NULL.

This is a regression introduced in a170a91fd3eab6155da39e740381867e,
likely because the code was copied from stream_complete().

Cc: qemu-stable@nongnu.org
Reported-by: Kashyap Chamarthy <kchamart@redhat.com>
Signed-off-by: Alberto Garcia <berto@igalia.com>
Tested-by: Kashyap Chamarthy <kchamart@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/stream.c b/block/stream.c
index 0113710..52d329f 100644
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
1.8.3.1
