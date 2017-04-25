Received: from eggs.gnu.org ([2001:4830:134:3::10]:53356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d2pd0-0006gF-Fv
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 21:50:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d2pcz-0007XO-BJ
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 21:50:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d2pcz-0007Wj-1Z
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 21:50:53 -0400
Date: Tue, 25 Apr 2017 09:50:47 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170425015047.GA13555@lemon.lan>
References: <1493054398-26013-1-git-send-email-joserz@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493054398-26013-1-git-send-email-joserz@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] trace: add qemu mutex lock and unlock
 trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, pbonzini@redhat.com

On Mon, 04/24 14:19, Jose Ricardo Ziviani wrote:
> These trace events were very useful to help me to understand and find a
> reordering issue in vfio, for example:
> 
> qemu_mutex_lock locked mutex 0x10905ad8
>   vfio_region_write  (0001:03:00.0:region1+0xc0, 0x2020c, 4)
> qemu_mutex_unlock unlocked mutex 0x10905ad8
> qemu_mutex_lock locked mutex 0x10905ad8
>   vfio_region_write  (0001:03:00.0:region1+0xc4, 0xa0000, 4)
> qemu_mutex_unlock unlocked mutex 0x10905ad8
> 
> that also helped me to see the desired result after the fix:
> 
> qemu_mutex_lock locked mutex 0x10905ad8
>   vfio_region_write  (0001:03:00.0:region1+0xc0, 0x2000c, 4)
>   vfio_region_write  (0001:03:00.0:region1+0xc4, 0xb0000, 4)
> qemu_mutex_unlock unlocked mutex 0x10905ad8
> 
> So it could be a good idea to have these traces implemented. It's worth
> mentioning that they should be surgically enabled during the debugging,
> otherwise it can flood the trace logs with lock/unlock messages.
> 
> How to use it:
> trace-event qemu_mutex_lock on|off
> trace-event qemu_mutex_unlock on|off
> or
> trace-event qemu_mutex* on|off
> 
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> ---
> v2:
>   - removed unecessary (void*) cast
>   - renamed parameter name to lock instead of qemu_global_mutex
> 
>  util/qemu-thread-posix.c | 5 +++++
>  util/trace-events        | 4 ++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index 73e3a0e..4f77d7b 100644
> --- a/util/qemu-thread-posix.c
> +++ b/util/qemu-thread-posix.c
> @@ -14,6 +14,7 @@
>  #include "qemu/thread.h"
>  #include "qemu/atomic.h"
>  #include "qemu/notify.h"
> +#include "trace.h"
>  
>  static bool name_threads;
>  
> @@ -60,6 +61,8 @@ void qemu_mutex_lock(QemuMutex *mutex)
>      err = pthread_mutex_lock(&mutex->lock);
>      if (err)
>          error_exit(err, __func__);
> +
> +    trace_qemu_mutex_lock(&mutex->lock);
>  }
>  
>  int qemu_mutex_trylock(QemuMutex *mutex)
> @@ -74,6 +77,8 @@ void qemu_mutex_unlock(QemuMutex *mutex)
>      err = pthread_mutex_unlock(&mutex->lock);
>      if (err)
>          error_exit(err, __func__);
> +
> +    trace_qemu_mutex_unlock(&mutex->lock);
>  }
>  
>  void qemu_rec_mutex_init(QemuRecMutex *mutex)
> diff --git a/util/trace-events b/util/trace-events
> index b44ef4f..70f6212 100644
> --- a/util/trace-events
> +++ b/util/trace-events
> @@ -55,3 +55,7 @@ lockcnt_futex_wait_prepare(const void *lockcnt, int expected, int new) "lockcnt
>  lockcnt_futex_wait(const void *lockcnt, int val) "lockcnt %p waiting on %d"
>  lockcnt_futex_wait_resume(const void *lockcnt, int new) "lockcnt %p after wait: %d"
>  lockcnt_futex_wake(const void *lockcnt) "lockcnt %p waking up one waiter"
> +
> +# util/qemu-thread-posix.c
> +qemu_mutex_lock(void *lock) "locked mutex %p"
> +qemu_mutex_unlock(void *lock) "unlocked mutex %p"
> -- 
> 2.7.4
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
