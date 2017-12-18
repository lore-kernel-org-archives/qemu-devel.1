Received: from eggs.gnu.org ([2001:4830:134:3::10]:38235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQsNz-0001rM-8B
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:11:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQsNv-0000HH-7L
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:11:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eQsNv-0000Fw-1G
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:10:59 -0500
Date: Mon, 18 Dec 2017 18:10:43 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171218101043.GU22308@xz-mi>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-8-peterx@redhat.com>
	<20171213154806.GH7173@stefanha-x1.localdomain>
	<20171215081141.GN7780@xz-mi>
	<20171215124711.GF26982@stefanha-x1.localdomain>
	<20171216035228.GT7780@xz-mi>
	<20171216090112.GA12533@stefanha-x1.localdomain>
	<20171218032702.GI22308@xz-mi>
	<20171218092457.GE18648@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171218092457.GE18648@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC v5 07/26] monitor: unify global init
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

On Mon, Dec 18, 2017 at 09:24:57AM +0000, Stefan Hajnoczi wrote:
> On Mon, Dec 18, 2017 at 11:27:02AM +0800, Peter Xu wrote:
> > On Sat, Dec 16, 2017 at 09:01:12AM +0000, Stefan Hajnoczi wrote:
> > > On Sat, Dec 16, 2017 at 11:52:28AM +0800, Peter Xu wrote:
> > > > On Fri, Dec 15, 2017 at 12:47:11PM +0000, Stefan Hajnoczi wrote:
> > > > > On Fri, Dec 15, 2017 at 04:11:41PM +0800, Peter Xu wrote:
> > > > > > On Wed, Dec 13, 2017 at 03:48:06PM +0000, Stefan Hajnoczi wrote:
> > > > > > > On Tue, Dec 05, 2017 at 01:51:41PM +0800, Peter Xu wrote:
> > >  }
> > > 
> > > Now vl.c:main() doesn't need to initialize the monitor.
> > > 
> > > We still need to handle the qtest_enabled() dependency:
> > > 
> > > -static QEMUClockType event_clock_type = QEMU_CLOCK_REALTIME;
> > > +static inline QEMUClockType event_clock_type(void)
> > > +{
> > > +    return qtest_enabled() ? QEMU_CLOCK_VIRTUAL : QEMU_CLOCK_REALTIME;
> > > +}
> > > 
> > > This way the qtest_enabled() call is deferred until later when the
> > > accelerators have been initialized.
> > 
> > Or... to be much simpler... How about we just use my patch?  IMHO it
> > calls monitor_init_globals() after configure_accelerator() so
> > monitor_qapi_event_init() and everything else would just work as
> > expected?
> 
> Ordering is complex in vl.c:main() so I think it's more maintainable to
> put initialization in a monitor.c constructor function and/or
> monitor_init().
> 
> If you want to keep your approach please add a comment about the
> qtest_enabled() dependency in vl.c:main().

Actually I still think this patch is the cleanest solution considering
all the above limitations. So I'll keep this one.  But for sure I can
add a comment mentioning about the dependency to accelerator codes.

Thanks!

-- 
Peter Xu
