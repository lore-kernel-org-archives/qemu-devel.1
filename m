Received: from eggs.gnu.org ([2001:4830:134:3::10]:43111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQnmr-0005fZ-T4
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 00:16:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQnmm-0007Q9-Tt
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 00:16:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eQnmm-0007Pl-NQ
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 00:16:20 -0500
Date: Mon, 18 Dec 2017 13:16:05 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171218051605.GJ22308@xz-mi>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-16-peterx@redhat.com>
	<20171213184358.GF8317@stefanha-x1.localdomain>
	<20171216061211.GC22308@xz-mi>
	<20171216091108.GB12533@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171216091108.GB12533@stefanha-x1.localdomain>
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

On Sat, Dec 16, 2017 at 09:11:08AM +0000, Stefan Hajnoczi wrote:
> On Sat, Dec 16, 2017 at 02:12:11PM +0800, Peter Xu wrote:
> > On Wed, Dec 13, 2017 at 06:43:58PM +0000, Stefan Hajnoczi wrote:
> > > On Tue, Dec 05, 2017 at 01:51:49PM +0800, Peter Xu wrote:
> > > > Monitor code now can be run in more than one thread.  Let it be thread
> > > > safe when accessing suspend_cnt counter.
> > > 
> > > Please add doc comments to the functions explaining which thread they
> > > may be called from (especially public functions).  Without this
> > > information other people will have a hard time keeping code thread-safe.
> > 
> > The two public functions would be monitor_resume() and
> > monitor_suspend().  IIUC as long as these functions are using atomic
> > operations correctly they should be able to be called anywhere?
> > 
> > Could you help point out what I missed?
> 
> I don't mean just the public functions.  How are other people supposed
> to know which monitor function executes in which thread without first
> studying all the monitor code?  This is where comments, naming schemes,
> or grouping functions helps.
> 
> Not every function needs to be documented in detail, but there needs to
> be some structure to help people understand what happens in the IOThread
> and what happens in the main loop.
> 
> Just adding threading to the existing code without leaving clues for
> people who come after you is likely to result in future bugs.

Yes, I fully agree with you that we need to do better commenting when
doing things like this.

I am just not sure what you would prefer me to add since AFAICT these
functions (after with the atomic protections) are really free to be
called anywhere, and also in any thread (even newly created threads
rather than main thread or monitor IO thread), and they are free of
locks too, like monitor_lock.  Here I only mean monitor_suspend() and
monitor_resume() for sure.  For the rest of functions, IMHO since they
are internal to monitor code so people who will call them do need to
know something about monitors.

I would be more appreciated if you can provide some examples here to
show what you mean.  Thanks,

-- 
Peter Xu
