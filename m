Received: from eggs.gnu.org ([2001:4830:134:3::10]:52908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f9FSa-0003DB-Pc
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 15:43:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f9FSW-0003To-47
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 15:43:12 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58339)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f9FSV-0003Rb-Me
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 15:43:08 -0400
Date: Thu, 19 Apr 2018 15:43:01 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180419194301.GA22127@flamenco>
References: <20180418090622.20073-1-peterx@redhat.com>
	<20180419015631.GE29462@lemon.usersys.redhat.com>
	<20180419031335.GH14841@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419031335.GH14841@xz-mi>
Subject: Re: [Qemu-devel] [PATCH v2] QemuMutex: support --enable-debug-mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, Apr 19, 2018 at 11:13:35 +0800, Peter Xu wrote:
> On Thu, Apr 19, 2018 at 09:56:31AM +0800, Fam Zheng wrote:
(snip)
> > > @@ -12,6 +12,10 @@ typedef QemuMutex QemuRecMutex;
> > >  
> > >  struct QemuMutex {
> > >      pthread_mutex_t lock;
> > > +#ifdef CONFIG_DEBUG_MUTEX
> > > +    const char *file;
> > > +    int line;
> > > +#endif
> > 
> > These look quite cheap, why we need a configure option to enable it?
> 
> Yeah; I am not 100% sure about whether it's cheap or not, hence with
> that.  I can remove that part if we are sure we want it always.

I can think of a few good reasons not to enable these by default.

* Adds 12 bytes to struct QemuMutex on 64-bit hosts.
* Increases slightly the critical region (the assignment happens
  once the lock has been acquired)
  + This is measurable for a single-thread with a microbenchmark:
Before (no --enable-debug-mutex):
$ taskset -c 0 tests/atomic_add-bench -n 1 -m -d 10
Parameters:
 # of threads:      1
 duration:          10
 ops' range:        1024
Results:
Duration:            10 s
 Throughput:         57.59 Mops/s
 Throughput/thread:  57.59 Mops/s/thread

After (with --enable-debug-mutex):
$ taskset -c 0 tests/atomic_add-bench -n 1 -m -d 10
Parameters:
 # of threads:      1
 duration:          10
 ops' range:        1024
Results:
Duration:            10 s
 Throughput:         56.25 Mops/s
 Throughput/thread:  56.25 Mops/s/thread

NB. The -m option for atomic_add-bench is not upstream yet, but
feel free to cherry-pick this commit: 
  https://github.com/cota/qemu/commit/f04f34df

  + A longer critical section can impact scalability, especially
    for large core counts.

Also note that there are some alternatives to this.
On POSIX systems when I need to debug mutexes I just revert
24fa904 ("qemu-thread: do not use PTHREAD_MUTEX_ERRORCHECK",
2015-03-10). Note that this doesn't work well with fork() in
linux-user, but I rarely need that.

Another alternative is to trace mutex_lock, that will give
you the same info although at higher overhead (in both runtime
and disk usage).

So I'm not against this, but please keep it configured out.
BTW you might also want to add the file/line pair to
qemu-thread-win32.c, or hide the configure option to Windows
users.

Thanks,

		Emilio
