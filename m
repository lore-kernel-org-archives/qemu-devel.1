Received: from eggs.gnu.org ([2001:4830:134:3::10]:40380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cxwTh-00041R-OP
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 10:09:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cxwTg-0004oZ-OD
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 10:09:05 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 11 Apr 2017 16:08:53 +0200
Message-Id: <1491919733-21065-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9] sheepdog: Fix crash in
 co_read_response()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mreitz@redhat.com, kchamart@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

This fixes a regression introduced in commit 9d456654.

aio_co_wake() can only be used to reenter a coroutine that was already
previously entered, otherwise co->ctx is uninitialised and we access
garbage. Using it immediately after qemu_coroutine_create() like in
co_read_response() is wrong and causes segfaults.

Replace the call with aio_co_enter(), which gets an explicit AioContext
parameter and works even for new coroutines.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Tested-by: Kashyap Chamarthy <kchamart@redhat.com>
---
 block/sheepdog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 1b71fc8..142eb4f 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -942,7 +942,7 @@ static void co_read_response(void *opaque)
         s->co_recv = qemu_coroutine_create(aio_read_response, opaque);
     }
 
-    aio_co_wake(s->co_recv);
+    aio_co_enter(s->aio_context, s->co_recv);
 }
 
 static void co_write_request(void *opaque)
-- 
1.8.3.1
