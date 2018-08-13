Received: from eggs.gnu.org ([2001:4830:134:3::10]:53401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fp2TU-0003nt-4S
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fp2TT-0008LP-DG
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:20:52 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 13 Aug 2018 04:20:04 +0200
Message-Id: <20180813022006.7216-16-mreitz@redhat.com>
In-Reply-To: <20180813022006.7216-1-mreitz@redhat.com>
References: <20180813022006.7216-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 15/17] mirror: Release AioCtx before
 queue_restart_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, Fam Zheng <famz@redhat.com>

Calling qemu_co_queue_restart_all() with a held AioContext looks a bit
strange.  There is no reason why we would hold the context any longer
(as this coroutine is not going to perform any further operations that
would necessitate it), so release it before restarting the waiting
requests.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 053c37b6a6..cba7de610e 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -395,10 +395,10 @@ static void coroutine_fn mirror_co_perform(void *opaque)
         }
     }
 
+    aio_context_release(aio_context);
+
     qemu_co_queue_restart_all(&op->waiting_requests);
     g_free(op);
-
-    aio_context_release(aio_context);
 }
 
 /* If mirror_method == MIRROR_METHOD_COPY, *offset and *bytes will be
-- 
2.17.1
