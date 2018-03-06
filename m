Received: from eggs.gnu.org ([2001:4830:134:3::10]:45527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1etAEa-0006LL-BN
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:54:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1etAEZ-0007vG-Ld
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:54:16 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue,  6 Mar 2018 10:53:54 +0000
Message-Id: <20180306105354.15197-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] block: make BDRV_POLL_WHILE() re-entrancy safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "fuweiwei (C)" <fuweiwei2@huawei.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

Nested BDRV_POLL_WHILE() calls can occur.  Currently
assert(!bs_->wakeup) will fail when this happens.

This patch converts bs->wakeup from bool to a counter.

Nesting works correctly because outer BDRV_POLL_WHILE() callers evaluate
the condition again after the inner caller completes (invoking the inner
caller counts as aio_poll() progress).

Reported-by: "fuweiwei (C)" <fuweiwei2@huawei.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
Fu Weiwei: Please retest and let us know if this fixes the assertion
failure you hit.  Thanks!
---
 include/block/block.h     | 7 +++----
 include/block/block_int.h | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index fac401ba3e..990b97f0ad 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -385,9 +385,8 @@ void bdrv_drain_all(void);
          * other I/O threads' AioContexts (see for example \
          * block_job_defer_to_main_loop for how to do it). \
          */                                                \
-        assert(!bs_->wakeup);                              \
-        /* Set bs->wakeup before evaluating cond.  */      \
-        atomic_mb_set(&bs_->wakeup, true);                 \
+        /* Increment bs->wakeup before evaluating cond. */ \
+        atomic_inc(&bs_->wakeup);                          \
         while (busy_) {                                    \
             if ((cond)) {                                  \
                 waited_ = busy_ = true;                    \
@@ -399,7 +398,7 @@ void bdrv_drain_all(void);
                 waited_ |= busy_;                          \
             }                                              \
         }                                                  \
-        atomic_set(&bs_->wakeup, false);                   \
+        atomic_dec(&bs_->wakeup);                          \
     }                                                      \
     waited_; })
 
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 5ea63f8fa8..0f360c0ed5 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -712,7 +712,7 @@ struct BlockDriverState {
     /* Internal to BDRV_POLL_WHILE and bdrv_wakeup.  Accessed with atomic
      * ops.
      */
-    bool wakeup;
+    unsigned wakeup;
 
     /* counter for nested bdrv_io_plug.
      * Accessed with atomic ops.
-- 
2.14.3
