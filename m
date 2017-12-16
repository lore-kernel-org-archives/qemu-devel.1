Received: from eggs.gnu.org ([2001:4830:134:3::10]:50588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQ5i2-0008Te-Hr
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 01:12:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQ5hz-00014w-Bz
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 01:12:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eQ5hz-000140-5X
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 01:12:27 -0500
Date: Sat, 16 Dec 2017 14:12:11 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171216061211.GC22308@xz-mi>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-16-peterx@redhat.com>
	<20171213184358.GF8317@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171213184358.GF8317@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC v5 15/26] monitor: let suspend_cnt be thread
 safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Dec 13, 2017 at 06:43:58PM +0000, Stefan Hajnoczi wrote:
> On Tue, Dec 05, 2017 at 01:51:49PM +0800, Peter Xu wrote:
> > Monitor code now can be run in more than one thread.  Let it be thread
> > safe when accessing suspend_cnt counter.
> 
> Please add doc comments to the functions explaining which thread they
> may be called from (especially public functions).  Without this
> information other people will have a hard time keeping code thread-safe.

The two public functions would be monitor_resume() and
monitor_suspend().  IIUC as long as these functions are using atomic
operations correctly they should be able to be called anywhere?

Could you help point out what I missed?

> 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  monitor.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> From docs/devel/atomics.txt:
> 
>   Macros defined by qemu/atomic.h fall in three camps:
> 
>   - compiler barriers: barrier();
> 
>   - weak atomic access and manual memory barriers: atomic_read(),
>     atomic_set(), smp_rmb(), smp_wmb(), smp_mb(), smp_mb_acquire(),
>     smp_mb_release(), smp_read_barrier_depends();
> 
>   - sequentially consistent atomic access: everything else.
> 
> The atomic_read() and atomic_set() calls in this patch aren't effective
> without memory barriers.  Please use atomic_mb_read() and
> atomic_mb_set() instead.

Will do.  Thanks,

-- 
Peter Xu
