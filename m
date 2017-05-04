Received: from eggs.gnu.org ([2001:4830:134:3::10]:40380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6BMk-0003Vw-Tn
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:39:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6BMk-0008TF-7w
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:39:58 -0400
Date: Thu, 4 May 2017 15:39:49 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170504073949.GA4725@lemon.lan>
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-14-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170420120058.28404-14-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 13/17] coroutine-lock: introduce
 qemu_co_mutex_lock_unlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Thu, 04/20 14:00, Paolo Bonzini wrote:
> +    if (atomic_cmpxchg(&mutex->locked, waiters, waiters + 1) != waiters) {

Is it still useful to try the fast path again if there are now even more
waiters, i.e.  "atomic_cmpxchg(...) > waiters"?

> +        goto retry_fast_path;
> +    }
> +
> +    qemu_co_mutex_lock_slowpath(ctx, mutex);
> +    qemu_co_mutex_unlock(mutex);
> +}
> +
>  void coroutine_fn qemu_co_mutex_unlock(CoMutex *mutex)
>  {
>      Coroutine *self = qemu_coroutine_self();
> -- 
> 2.9.3
> 
> 
> 
