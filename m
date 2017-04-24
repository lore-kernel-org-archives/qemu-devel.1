Received: from eggs.gnu.org ([2001:4830:134:3::10]:55251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d2fFa-0006X3-CQ
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 10:46:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d2fFX-0007fu-9W
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 10:46:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d2fFW-0007fe-PO
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 10:45:59 -0400
Date: Mon, 24 Apr 2017 22:45:52 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170424144552.GA6511@lemon.lan>
References: <1493044126-21488-1-git-send-email-joserz@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493044126-21488-1-git-send-email-joserz@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] trace: add qemu mutex lock and unlock
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, stefanha@redhat.com

On Mon, 04/24 11:28, Jose Ricardo Ziviani wrote:
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
> that also helped to see desired result after the fix:
> 
> qemu_mutex_lock locked mutex 0x10905ad8
>   vfio_region_write  (0001:03:00.0:region1+0xc0, 0x2000c, 4)
>   vfio_region_write  (0001:03:00.0:region1+0xc4, 0xb0000, 4)
> qemu_mutex_unlock unlocked mutex 0x10905ad8
> 
> So it could be a good idea to have these traces implemented. It's worth
> mentioning that they should be surgically enabled during the debugging,
> otherwise it'd flood the trace logs with lock/unlock messages.
> 
> How to use it:
> trace-event qemu_mutex_lock on|off
> trace-event qemu_mutex_unlock on|off
> or
> trace-event qemu_mutex* on|off
> 
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> ---
>  util/qemu-thread-posix.c | 5 +++++
>  util/trace-events        | 4 ++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index 73e3a0e..909c2ac 100644
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
> +    trace_qemu_mutex_lock((void *)&mutex->lock);

You don't need these casts as the parameter type is void * which accepts any
pointers.

>  }
>  
>  int qemu_mutex_trylock(QemuMutex *mutex)
> @@ -74,6 +77,8 @@ void qemu_mutex_unlock(QemuMutex *mutex)
>      err = pthread_mutex_unlock(&mutex->lock);
>      if (err)
>          error_exit(err, __func__);
> +
> +    trace_qemu_mutex_unlock((void *)&mutex->lock);
>  }
>  
>  void qemu_rec_mutex_init(QemuRecMutex *mutex)
> diff --git a/util/trace-events b/util/trace-events
> index b44ef4f..65c33fe 100644
> --- a/util/trace-events
> +++ b/util/trace-events
> @@ -55,3 +55,7 @@ lockcnt_futex_wait_prepare(const void *lockcnt, int expected, int new) "lockcnt
>  lockcnt_futex_wait(const void *lockcnt, int val) "lockcnt %p waiting on %d"
>  lockcnt_futex_wait_resume(const void *lockcnt, int new) "lockcnt %p after wait: %d"
>  lockcnt_futex_wake(const void *lockcnt) "lockcnt %p waking up one waiter"
> +
> +# util/qemu-thread-posix.c
> +qemu_mutex_lock(void *qemu_global_mutex) "locked mutex %p"
> +qemu_mutex_unlock(void *qemu_global_mutex) "unlocked mutex %p"

Parameter name is slightly misleading, maybe s/qemu_global_mutex/lock/ for both
lines?

Fam
