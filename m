Received: from eggs.gnu.org ([2001:4830:134:3::10]:32837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dvK2l-00021d-7j
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 05:14:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dvK2h-0007if-8i
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 05:14:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dvK2g-0007h1-WB
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 05:14:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B52DBC047B82
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 09:14:37 +0000 (UTC)
Date: Fri, 22 Sep 2017 17:14:30 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170922091430.GJ30661@pxdev.xzpeter.org>
References: <1506070572-7549-1-git-send-email-peterx@redhat.com>
	<1506070572-7549-2-git-send-email-peterx@redhat.com>
	<20170922090433.GC12725@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170922090433.GC12725@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] iothread: provide helpers for internal
 use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Sep 22, 2017 at 10:04:33AM +0100, Daniel P. Berrange wrote:
> On Fri, Sep 22, 2017 at 04:56:10PM +0800, Peter Xu wrote:
> > IOThread is a general framework that contains IO loop environment and a
> > real thread behind.  It's also good to be used internally inside qemu.
> > Provide some helpers for it to create iothreads to be used internally.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/sysemu/iothread.h |  8 ++++++++
> >  iothread.c                | 21 +++++++++++++++++++++
> >  2 files changed, 29 insertions(+)
> > 
> > diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
> > index d2985b3..b07663f 100644
> > --- a/include/sysemu/iothread.h
> > +++ b/include/sysemu/iothread.h
> > @@ -46,4 +46,12 @@ AioContext *iothread_get_aio_context(IOThread *iothread);
> >  void iothread_stop_all(void);
> >  GMainContext *iothread_get_g_main_context(IOThread *iothread);
> >  
> > +/*
> > + * Helpers used to allocate iothreads for internal use.  These
> > + * iothreads will not be seen by monitor clients when query using
> > + * "query-iothreads".
> > + */
> > +IOThread *iothread_create(const char *id, Error **errp);
> > +void iothread_destroy(IOThread *iothread);
> > +
> >  #endif /* IOTHREAD_H */
> > diff --git a/iothread.c b/iothread.c
> > index 44c8944..74e400c 100644
> > --- a/iothread.c
> > +++ b/iothread.c
> > @@ -354,3 +354,24 @@ GMainContext *iothread_get_g_main_context(IOThread *iothread)
> >  
> >      return iothread->worker_context;
> >  }
> > +
> > +static Object *iothread_get_internal_parent(void)
> > +{
> > +    return container_get(object_get_root(), "/internal-iothreads");
> > +}
> 
> I tend to think we might benefit from having this generalized in the
> QOM API instead. We have object_get_objects_root() for things that
> are created by the mgmt app / user via CLI / QMP.  A parallel method
> object_get_internal_root() could be useful for cases like this where
> we want to create user-creatable objects, but not have them be
> visible to the mgmt app / user, as that would confuse the mgmt app.
> 
> Example for this scenario - libvirt calls query-iothreads to identify
> IO thread PIDs, and would get very unhappy if the IOThread used by
> the monitor would appear in that response, which is why Peter has
> put it under /internal-iothreads. I think this scenario will apply
> more broadly, so benefit from us having a general helper in QOM.

Yeah, I can split the patch if we want it to be exposed to public.

In that case, would the name "object_get_internal_root" be good?

Thanks,

-- 
Peter Xu
