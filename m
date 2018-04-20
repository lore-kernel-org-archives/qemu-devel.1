Received: from eggs.gnu.org ([2001:4830:134:3::10]:43030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f9ZVd-0006da-2P
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 13:07:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f9ZVZ-00038t-24
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 13:07:41 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53135)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f9ZVY-00037M-C8
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 13:07:36 -0400
Date: Fri, 20 Apr 2018 13:07:34 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180420170734.GA8811@flamenco>
References: <20180420044212.28765-1-peterx@redhat.com>
	<20180420044212.28765-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420044212.28765-2-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/3] qemu-thread: introduce
 qemu-thread-common.[ch]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, Apr 20, 2018 at 12:42:10 +0800, Peter Xu wrote:
> Put all the shared qemu-thread implementations into these files.  The
> header should be internal to qemu-thread but not for qemu-thread users.
> 
> Introduce some hooks correspondingly for the shared part.  Note that in
> qemu_mutex_unlock_impl() we moved the call before unlock operation which
> should make more sense.  And we don't need qemu_mutex_post_unlock() hook.
> 
> Currently the hooks only calls the tracepoints.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
(snip)
> -    trace_qemu_mutex_lock(mutex, file, line);
> -
> +    qemu_mutex_pre_lock(mutex, file, line);
>      err = pthread_mutex_lock(&mutex->lock);
>      if (err)
>          error_exit(err, __func__);
> -
> -    trace_qemu_mutex_locked(mutex, file, line);
> +    qemu_mutex_post_lock(mutex, file, line);
>  }

I see the value in consolidating these calls. However, having a separate
object means that this adds two function calls to mutex_lock. This
significantly reduces performance, even without --enable-debug-mutex:
- Before:
$ taskset -c 0 tests/atomic_add-bench -n 1 -m
Parameters:
 # of threads:      1
 duration:          1
 ops' range:        1024
Results:
Duration:            1 s
 Throughput:         57.24 Mops/s
 Throughput/thread:  57.24 Mops/s/thread

- After:
$ taskset -c 0 tests/atomic_add-bench -n 1 -m
Parameters:
 # of threads:      1
 duration:          1
 ops' range:        1024
Results:
Duration:            1 s
 Throughput:         49.22 Mops/s
 Throughput/thread:  49.22 Mops/s/thread

So either inlines/macros should be used instead -- I'd prefer
inlines but I'm not sure they'll work with the tracing calls.

I think you should cherry-pick this patch[1] and add it to the
series -- it'll let you make sure the series does not affect
performance.

Cheers,

		Emilio

[1] https://github.com/cota/qemu/commit/f04f34df 
