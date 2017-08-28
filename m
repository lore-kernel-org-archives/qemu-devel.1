Received: from eggs.gnu.org ([2001:4830:134:3::10]:49085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dmPLP-00019B-Hs
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 15:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dmPLM-0005RW-CW
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 15:05:07 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47817)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dmPLM-0005Pa-6t
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 15:05:04 -0400
Date: Mon, 28 Aug 2017 15:05:01 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170828190501.GA7312@flamenco>
References: <20170828035327.17146-1-bobby.prani@gmail.com>
	<20170828035327.17146-2-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170828035327.17146-2-bobby.prani@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 2/3] cpus-common: Cache allocated work
 items
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Sergey Fedorov <serge.fdrv@gmail.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>

On Sun, Aug 27, 2017 at 23:53:25 -0400, Pranith Kumar wrote:
> Using heaptrack, I found that quite a few of our temporary allocations
> are coming from allocating work items. Instead of doing this
> continously, we can cache the allocated items and reuse them instead
> of freeing them.
> 
> This reduces the number of allocations by 25% (200000 -> 150000 for
> ARM64 boot+shutdown test).
> 

But what is the perf difference, if any?

Adding a lock (or a cmpxchg) here is not a great idea. However, this is not yet
immediately obvious because of other scalability bottlenecks. (if
you boot many arm64 cores you'll see most of the time is spent idling
on the BQL, see
  https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg05207.html )

You're most likely better off using glib's slices, see
  https://developer.gnome.org/glib/stable/glib-Memory-Slices.html
These slices use per-thread lists, so scalability should be OK.

I also suggest profiling with either or both of jemalloc/tcmalloc
(build with --enable-jemalloc/tcmalloc) in addition to using glibc's
allocator, and then based on perf numbers decide whether this is something
worth optimizing.

Thanks,

                Emilio
