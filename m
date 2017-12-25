Received: from eggs.gnu.org ([2001:4830:134:3::10]:45876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eTL6A-0002YL-MK
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 00:14:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eTL67-000479-HL
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 00:14:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eTL67-00046Z-BB
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 00:14:47 -0500
Date: Mon, 25 Dec 2017 13:14:35 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171225051435.GE2443@xz-mi>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-17-peterx@redhat.com>
	<20171221114013.GN10812@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171221114013.GN10812@lemon>
Subject: Re: [Qemu-devel] [RFC v6 16/27] monitor: separate QMP parser and
 dispatcher
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Dec 21, 2017 at 07:40:13PM +0800, Fam Zheng wrote:

[...]

> > +/*
> > + * Pop one QMP request from monitor queues, return NULL if not found.
> > + * We are using round-robin fasion to pop the request, to avoid
> 
> s/fasion/fashion/

Fixed.

[...]

> >  static void monitor_qmp_read(void *opaque, const uint8_t *buf, int size)
> >  {
> >      Monitor *mon = opaque;
> > @@ -4150,6 +4292,15 @@ static void monitor_iothread_init(void)
> >  {
> >      mon_global.mon_iothread = iothread_create("mon_iothread",
> >                                                &error_abort);
> > +
> > +    /*
> > +     * This MUST be on main loop thread since we have commands that
> > +     * have assumption to be run on main loop thread (Yeah, we'd
> > +     * better remove this assumption in the future).
> 
> Assert and move this comment in monitor_qmp_bh_dispatcher?

I would still prefer to keep it here.  IMHO what really matters is the
first parameter that passed in to aio_bh_new() below, rather than
monitor_qmp_bh_dispatcher itself?  Thanks,

> 
> > +     */
> > +    mon_global.qmp_dispatcher_bh = aio_bh_new(qemu_get_aio_context(),
> > +                                              monitor_qmp_bh_dispatcher,
> > +                                              NULL);
> >  }
> >  
> 
> Fam

-- 
Peter Xu
