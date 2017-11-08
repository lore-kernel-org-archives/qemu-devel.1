Received: from eggs.gnu.org ([2001:4830:134:3::10]:55542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCTdX-00042F-Cc
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:55:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCTdS-0000lw-GY
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:55:35 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed,  8 Nov 2017 10:55:19 -0600
Message-Id: <20171108165519.8931-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2] coroutine: Fix documentation of
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
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com, stefanha@redhat.com, Kevin Wolf <kwolf@redhat.com>

co_sleep_ns() was removed in commit 0b9caf9b, leaving behind a
stale comment.  Update the documentation to match the current
usage of this function.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: instead of just blindly cribbing from Paolo's email, try to incorporate
the feedback given on the wording
---
 include/qemu/coroutine.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index 9aff9a735e..10ab50a98c 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -262,8 +262,11 @@ void qemu_co_rwlock_unlock(CoRwlock *lock);
 /**
  * Yield the coroutine for a given duration
  *
- * Behaves similarly to co_sleep_ns(), but the sleeping coroutine will be
- * resumed when using aio_poll().
+ * This function uses timers and hence needs to know the event loop
+ * (#AioContext) to place the timer on.  After the time elapses, the
+ * current coroutine will restart with the same #AioContext it is
+ * currently running in, even if that is different than the timer
+ * context passed to co_aio_sleep_ns().
  */
 void coroutine_fn co_aio_sleep_ns(AioContext *ctx, QEMUClockType type,
                                   int64_t ns);
-- 
2.13.6
