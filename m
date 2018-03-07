Received: from eggs.gnu.org ([2001:4830:134:3::10]:60856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1etiLW-0000z0-5Q
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 18:19:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1etiLV-0000P0-1V
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 18:19:42 -0500
References: <20180307124619.6218-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <015d4216-88f1-ea17-fefa-c4e93ec56ddd@redhat.com>
Date: Wed, 7 Mar 2018 17:19:13 -0600
MIME-Version: 1.0
In-Reply-To: <20180307124619.6218-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] block: make BDRV_POLL_WHILE()
 re-entrancy safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, "fuweiwei (C)" <fuweiwei2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>

On 03/07/2018 06:46 AM, Stefan Hajnoczi wrote:
> Nested BDRV_POLL_WHILE() calls can occur.  Currently
> assert(!wait_->wakeup) fails in AIO_WAIT_WHILE() when this happens.
> 
> This patch converts the bool wait_->need_kick flag to an unsigned
> wait_->num_waiters counter.
> 
> Nesting works correctly because outer AIO_WAIT_WHILE() callers evaluate
> the condition again after the inner caller completes (invoking the inner
> caller counts as aio_poll() progress).
> 
> Reported-by: "fuweiwei (C)" <fuweiwei2@huawei.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
>   * Rebase onto qemu.git/master now that AIO_WAIT_WHILE() has landed
>     [Kevin]
> 
>   include/block/aio-wait.h | 61 ++++++++++++++++++++++++------------------------

Looks big due to whitespace change when column for trailing \ changed. 
Viewing the diff with whitespace ignored made it easier to review.

Reviewed-by: Eric Blake <eblake@redhat.com>

diff --git c/include/block/aio-wait.h w/include/block/aio-wait.h
index a48c744fa87..74cde07bef3 100644
--- c/include/block/aio-wait.h
+++ w/include/block/aio-wait.h
@@ -50,8 +50,8 @@
   *   }
   */
  typedef struct {
-    /* Is the main loop waiting for a kick?  Accessed with atomic ops. */
-    bool need_kick;
+    /* Number of waiting AIO_WAIT_WHILE() callers. Accessed with atomic 
ops. */
+    unsigned num_waiters;
  } AioWait;

  /**
@@ -84,9 +84,8 @@ typedef struct {
      } else {                                                       \
          assert(qemu_get_current_aio_context() ==                   \
                 qemu_get_aio_context());                            \
-        assert(!wait_->need_kick);                          \
-        /* Set wait_->need_kick before evaluating cond.  */ \
-        atomic_mb_set(&wait_->need_kick, true);             \
+        /* Increment wait_->num_waiters before evaluating cond. */ \
+        atomic_inc(&wait_->num_waiters);                           \
          while (busy_) {                                            \
              if ((cond)) {                                          \
                  waited_ = busy_ = true;                            \
@@ -98,7 +97,7 @@ typedef struct {
                  waited_ |= busy_;                                  \
              }                                                      \
          }                                                          \
-        atomic_set(&wait_->need_kick, false);               \
+        atomic_dec(&wait_->num_waiters);                           \
      }                                                              \
      waited_; })


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
