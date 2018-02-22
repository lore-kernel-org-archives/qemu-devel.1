Received: from eggs.gnu.org ([2001:4830:134:3::10]:56543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eooRE-0005tH-6B
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:49:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eooRB-0003l9-4R
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:49:20 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39208 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eooRA-0003kj-Vh
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:49:17 -0500
Date: Thu, 22 Feb 2018 18:49:01 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180222104901.GJ18962@xz-mi>
References: <20180124053957.29145-1-peterx@redhat.com>
	<20180124053957.29145-14-peterx@redhat.com>
	<20180221165058.GF21436@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180221165058.GF21436@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v7 13/23] monitor: let suspend/resume work
 even with QMPs
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

On Wed, Feb 21, 2018 at 04:50:58PM +0000, Stefan Hajnoczi wrote:
> On Wed, Jan 24, 2018 at 01:39:47PM +0800, Peter Xu wrote:
> > diff --git a/monitor.c b/monitor.c
> > index 60bcf67b3a..76137ba2a4 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -246,6 +246,21 @@ static inline bool monitor_is_qmp(const Monitor *mon)
> >      return (mon->flags & MONITOR_USE_CONTROL);
> >  }
> >  
> > +/**
> > + * Whether @mon is using readline?  Note: not all HMP monitors can are
> > + * using readline, e.g., gdbserver has non-interactive HMP monitor, so
> 
> s/can are using/use/
> 
> s/has non-interactive HMP monitor/has a non-interactive HMP monitor/
> 
> > @@ -3994,19 +4009,43 @@ static void monitor_command_cb(void *opaque, const char *cmdline,
> >  
> >  int monitor_suspend(Monitor *mon)
> >  {
> > -    if (!mon->rs)
> > +    if (monitor_is_hmp_non_interactive(mon)) {
> >          return -ENOTTY;
> > +    }
> > +
> > +    if (monitor_is_qmp(mon)) {
> > +        /*
> > +         * Kick iothread to make sure this takes effect.  It'll be
> > +         * evaluated again in prepare() of the watch object.
> > +         */
> > +        aio_notify(iothread_get_aio_context(mon_global.mon_iothread));
> 
> This must be done after incrementing suspend_cnt to avoid the race
> condition between the iothread and our thread.

Fixed both places.  Thanks,

-- 
Peter Xu
