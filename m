Received: from eggs.gnu.org ([2001:4830:134:3::10]:42181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZY4K-0004D2-BK
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:18:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZY4F-000423-8v
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:18:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eZY4F-00041W-0C
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:18:31 -0500
Date: Thu, 11 Jan 2018 16:18:18 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180111081818.GB2551@xz-mi>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-8-peterx@redhat.com>
	<ab1775ac-be60-31cb-3c7c-c698c2adb1e8@redhat.com>
	<20180110082639.GH5984@xz-mi>
	<a2de0d5c-924d-6de8-4bb9-92991801fb3c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a2de0d5c-924d-6de8-4bb9-92991801fb3c@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 07/27] monitor: unify global init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Jan 10, 2018 at 06:54:45AM -0600, Eric Blake wrote:
> On 01/10/2018 02:26 AM, Peter Xu wrote:
> 
> >> The later initialization of the monitor_lock mutex is a potential
> >> semantic change.  Please beef up the commit message to document why it
> >> is safe.  In fact, I requested this back on my review of v1, but it
> >> still hasn't been done. :(
> >>
> >> https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg05421.html
> > 
> > Sorry for that! I thought you helped proved that somehow (which I
> > really appreciate)...
> > 
> >>
> >> If my read of history is correct, I think it is sufficient to point to
> >> commit 05875687 as a place where we no longer care about constructor
> >> semantics because we are no longer dealing with module_call_init().  But
> >> you may find a better place to point to.  You already found that
> >> d622cb587 was what introduced the constructor in the first place, but I
> >> didn't spend time today auditing the state of qemu back at that time to
> >> see if the constructor was really necessary back then or just a
> >> convenience for lack of a better initialization point.
> >>
> >> Alternatively, if you can't find a good commit message to point to, at
> >> least document how you (and I) tested things, using gdb watchpoints, to
> >> prove it is a safe delay.
> > 
> > I did that by observing all users of the lock in current repository:
> 
> 
> > AFAIK all of them are called even after monitor_init(), in other
> > words, they are all after global init too.
> > 
> > As a conclusion, we should be safe here.  Again, I may be wrong
> > somewhere, please correct me if so.
> 
> My gdb testing and your analysis match; we're safe.  So all that's
> needed is the paragraph documenting that we thought about the issue:
> 
> > 
> >>
> >> Only if you improve the commit message, you may add:
> >> Reviewed-by: Eric Blake <eblake@redhat.com>
> > 
> > Besides the English fix, how about I add one more paragraph to talk
> > about monitor_lock in commit message:
> > 
> >   monitor_lock won't be used before monitor_init().  So as long as we
> >   initialize the monitor globals before the first call to
> >   monitor_init(), we will be safe.
> 
> Or even:
> 
> monitor_lock is not used before monitor_init() (as confirmed by code
> analysis and gdb watchpoints); so we are safe delaying what was a
> constructor-time initialization of the mutex into the later first call
> to monitor_init().

Will take away this.

> 
> > 
> > With that, could I take your r-b?
> 
> Yes.

Thank you.

-- 
Peter Xu
