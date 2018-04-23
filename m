Received: from eggs.gnu.org ([2001:4830:134:3::10]:59558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fATsw-0005Ub-L2
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 01:19:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fATss-0007Cr-Je
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 01:19:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59742 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fATss-0007CH-Dk
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 01:19:26 -0400
Date: Mon, 23 Apr 2018 13:19:10 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180423051910.GA9036@xz-mi>
References: <20180420044212.28765-1-peterx@redhat.com>
	<20180420044212.28765-2-peterx@redhat.com>
	<20180420170734.GA8811@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180420170734.GA8811@flamenco>
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
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, Apr 20, 2018 at 01:07:34PM -0400, Emilio G. Cota wrote:
> On Fri, Apr 20, 2018 at 12:42:10 +0800, Peter Xu wrote:
> > Put all the shared qemu-thread implementations into these files.  The
> > header should be internal to qemu-thread but not for qemu-thread users.
> > 
> > Introduce some hooks correspondingly for the shared part.  Note that in
> > qemu_mutex_unlock_impl() we moved the call before unlock operation which
> > should make more sense.  And we don't need qemu_mutex_post_unlock() hook.
> > 
> > Currently the hooks only calls the tracepoints.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> (snip)
> > -    trace_qemu_mutex_lock(mutex, file, line);
> > -
> > +    qemu_mutex_pre_lock(mutex, file, line);
> >      err = pthread_mutex_lock(&mutex->lock);
> >      if (err)
> >          error_exit(err, __func__);
> > -
> > -    trace_qemu_mutex_locked(mutex, file, line);
> > +    qemu_mutex_post_lock(mutex, file, line);
> >  }
> 
> I see the value in consolidating these calls. However, having a separate
> object means that this adds two function calls to mutex_lock. This
> significantly reduces performance, even without --enable-debug-mutex:
> - Before:
> $ taskset -c 0 tests/atomic_add-bench -n 1 -m
> Parameters:
>  # of threads:      1
>  duration:          1
>  ops' range:        1024
> Results:
> Duration:            1 s
>  Throughput:         57.24 Mops/s
>  Throughput/thread:  57.24 Mops/s/thread
> 
> - After:
> $ taskset -c 0 tests/atomic_add-bench -n 1 -m
> Parameters:
>  # of threads:      1
>  duration:          1
>  ops' range:        1024
> Results:
> Duration:            1 s
>  Throughput:         49.22 Mops/s
>  Throughput/thread:  49.22 Mops/s/thread
> 
> So either inlines/macros should be used instead -- I'd prefer
> inlines but I'm not sure they'll work with the tracing calls.

Indeed, it's about 10% drop.  I never thought an extra call would
bring so much overhead, but after reading your patch I think I know -
the test is only about raw mutex locking, so the extra call will be
"amplified" comparing to real usages, where normally there can be much
more things to be done besides taking and releasing the lock.

But sure making it inline should be better, and your reasoning is
valid. Though I didn't see why it can't work with traces, I thought it
should work natually.  I'll see.

> 
> I think you should cherry-pick this patch[1] and add it to the
> series -- it'll let you make sure the series does not affect
> performance.

Sure!  I'll attach benchmark results in my next post with your tool.

Thanks,

-- 
Peter Xu
