Received: from eggs.gnu.org ([2001:4830:134:3::10]:41898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cqAMs-0005EQ-FF
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:21:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cqAMr-0002ae-PI
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:21:54 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 21 Mar 2017 11:16:34 +0800
Message-Id: <20170321031635.22123-16-famz@redhat.com>
In-Reply-To: <20170321031635.22123-1-famz@redhat.com>
References: <20170321031635.22123-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 15/16] mirror: Lazily request aio context
 change permission on target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

What's done in the source's context change notifier is moving the
target's context to follow the new one, so we request this permission
here.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/mirror.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/mirror.c b/block/mirror.c
index ed26e8c..168cf60 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -983,6 +983,7 @@ static void mirror_attached_aio_context(BlockJob *job, AioContext *new_context)
 {
     MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
 
+    blk_request_perm(s->target, BLK_PERM_AIO_CONTEXT_CHANGE, &error_abort);
     blk_set_aio_context(s->target, new_context);
 }
 
-- 
2.9.3
