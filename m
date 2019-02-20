Received: from eggs.gnu.org ([209.51.188.92]:57291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gwWHS-0004VF-A2
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:07:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gwWHP-0006ip-PS
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:07:38 -0500
Date: Wed, 20 Feb 2019 19:07:24 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190220180724.GE6281@localhost.localdomain>
References: <20190220174843.8847-1-kwolf@redhat.com>
	<20190220174843.8847-6-kwolf@redhat.com>
	<bf7d55dc-e914-ad14-d542-175255dd0d1b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf7d55dc-e914-ad14-d542-175255dd0d1b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 05/13] io: Remove redundant
 read/write_coroutine assignments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

Am 20.02.2019 um 19:01 hat Paolo Bonzini geschrieben:
> On 20/02/19 18:48, Kevin Wolf wrote:
> > -static void qio_channel_set_aio_fd_handlers(QIOChannel *ioc);
> > -
> >  static void qio_channel_restart_read(void *opaque)
> >  {
> >      QIOChannel *ioc = opaque;
> >      Coroutine *co = ioc->read_coroutine;
> >  
> > -    ioc->read_coroutine = NULL;
> > -    qio_channel_set_aio_fd_handlers(ioc);
> > -    aio_co_wake(co);
> > +    assert(qemu_get_current_aio_context() ==
> > +           qemu_coroutine_get_aio_context(co));
> > +    qemu_coroutine_enter(co);
> >  }
> >  
> >  static void qio_channel_restart_write(void *opaque)
> > @@ -417,9 +415,9 @@ static void qio_channel_restart_write(void *opaque)
> >      QIOChannel *ioc = opaque;
> >      Coroutine *co = ioc->write_coroutine;
> >  
> > -    ioc->write_coroutine = NULL;
> > -    qio_channel_set_aio_fd_handlers(ioc);
> > -    aio_co_wake(co);
> > +    assert(qemu_get_current_aio_context() ==
> > +           qemu_coroutine_get_aio_context(co));
> > +    qemu_coroutine_enter(co);
> >  }
> >  
> >  static void qio_channel_set_aio_fd_handlers(QIOChannel *ioc)
> > 
> 
> aio_co_wake was also acquiring/releasing the AioContext, so
> that needs to stay for now.

True. Maybe I should leave the aio_co_wake call alone() and just add the
assertion to avoid complicating the code rather than simplifying it...

Kevin
