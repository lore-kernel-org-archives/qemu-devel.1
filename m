Received: from eggs.gnu.org ([2001:4830:134:3::10]:43644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fWn9V-0002l7-E2
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 14:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fWn9U-00047r-2z
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 14:20:49 -0400
Date: Sat, 23 Jun 2018 14:20:39 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180623182039.GA4920@flamenco>
References: <20180621173635.21537-1-richard.henderson@linaro.org>
	<20180622211244.GA11346@flamenco>
	<1319a0f0-0009-ebfc-dab4-eec196ba8ba5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1319a0f0-0009-ebfc-dab4-eec196ba8ba5@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 0/2] linux-user: Change mmap_lock to rwlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, qemu-arm@nongnu.org

On Sat, Jun 23, 2018 at 08:25:52 -0700, Richard Henderson wrote:
> On 06/22/2018 02:12 PM, Emilio G. Cota wrote:
> > I'm curious to see how much perf could be gained. It seems that the hold
> > times in SVE code for readers might not be very large, which
> > then wouldn't let us amortize the atomic inc of the read lock
> > (IOW, we might not see much of a difference compared to a regular
> > mutex).
> 
> In theory, the uncontended case for rwlocks is the same as a mutex.

In the fast path, wr_lock/unlock have one more atomic than
mutex_lock/unlock. The perf difference is quite large in
microbenchmarks, e.g. changing tests/atomic_add-bench to
use pthread_mutex or pthread_rwlock_wrlock instead of
an atomic operation (this is enabled with the added -m flag):

$ taskset -c 0 perf record tests/atomic_add-bench-mutex  -d 4 -m
 Throughput:         62.05 Mops/s

$ taskset -c 0 perf record tests/atomic_add-bench-rwlock  -d 4 -m
 Throughput:         37.68 Mops/s

That said, it's unlikely to have real user-space code
(i.e. not from microbenchmarks) that would be sensitive to
the additional delay and/or lower scalability. It is common to
avoid frequent calls to mmap(2) due to potential serialization
in the kernel -- think for instance of memory allocators, they
do a few large mmap calls and then manage the memory themselves.

To double-check I ran some multi-threaded benchmarks from
Hoard[1] under qemu-linux-user, with and without the rwlock change,
and couldn't measure a significant difference.

[1] https://github.com/emeryberger/Hoard/tree/master/benchmarks

> > Are you using any benchmark that shows any perf difference?
> 
> Not so far.  Glibc has some microbenchmarks for strings, which I will try next
> week, but they are not multi-threaded.  Maybe just run 4 threads of those
> benchmark?

I'd run more threads if possible. I have access to a 64-core machine,
so ping me once you identify benchmarks that are of interest.

		Emilio
