Received: from eggs.gnu.org ([2001:4830:134:3::10]:38167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCCUm-000773-M9
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 17:37:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCCUh-0003mA-MX
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 17:37:24 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue,  7 Nov 2017 16:37:08 -0600
Message-Id: <20171107223708.17935-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] coroutine: Fix documentation of
 co_aio_sleep_ns()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

co_sleep_ns() was removed in commit 0b9caf9b, leaving behind a
stale comment.  Update the documentation to match the current
usage of this function.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/qemu/coroutine.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index 9aff9a735e..01ae415767 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -262,8 +262,11 @@ void qemu_co_rwlock_unlock(CoRwlock *lock);
 /**
  * Yield the coroutine for a given duration
  *
- * Behaves similarly to co_sleep_ns(), but the sleeping coroutine will be
- * resumed when using aio_poll().
+ * This function uses timers and hence needs to know the event loop
+ * (#AioContext) to place the timer on.  In any case, co_aio_sleep_ns()
+ * does not affect the #AioContext where the current coroutine is running,
+ * as the coroutine will restart on the same #AioContext that it is
+ * running on.
  */
 void coroutine_fn co_aio_sleep_ns(AioContext *ctx, QEMUClockType type,
                                   int64_t ns);
-- 
2.13.6
