Received: from eggs.gnu.org ([2001:4830:134:3::10]:34367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e5AdY-0008CM-TE
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 09:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e5AdU-0002Sm-TJ
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 09:13:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1e5AdU-0002SZ-KA
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 09:13:20 -0400
Date: Thu, 19 Oct 2017 15:13:11 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171019131311.GE6205@stefanha-x1.localdomain>
References: <20170929033844.26935-1-peterx@redhat.com>
	<20170929033844.26935-14-peterx@redhat.com>
	<20171012125045.GF5957@stefanha-x1.localdomain>
	<20171016075039.GD4166@pxdev.xzpeter.org>
	<20171018153115.GD31848@stefanha-x1.localdomain>
	<20171019063649.GX4166@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171019063649.GX4166@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [RFC v2 13/22] monitor: separate QMP parser and
 dispatcher
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Oct 19, 2017 at 02:36:49PM +0800, Peter Xu wrote:
> On Wed, Oct 18, 2017 at 05:31:15PM +0200, Stefan Hajnoczi wrote:
> > On Mon, Oct 16, 2017 at 03:50:39PM +0800, Peter Xu wrote:
> > > On Thu, Oct 12, 2017 at 01:50:45PM +0100, Stefan Hajnoczi wrote:
> > > > On Fri, Sep 29, 2017 at 11:38:35AM +0800, Peter Xu wrote:
> > > > > +    qdict = qobject_to_qdict(req);
> > > > > +    if (qdict) {
> > > > > +        id = qdict_get(qdict, "id");
> > > > > +        qobject_incref(id);
> > > > > +        qdict_del(qdict, "id");
> > > > > +    } /* else will fail qmp_dispatch() */
> > > > > +
> > > > > +    req_obj = g_new0(QMPRequest, 1);
> > > > > +    req_obj->mon = mon;
> > > > > +    req_obj->id = id;
> > > > > +    req_obj->req = req;
> > > > > +
> > > > > +    /*
> > > > > +     * Put the request to the end of queue so that requests will be
> > > > > +     * handled in time order.  Ownership for req_obj, req, id,
> > > > > +     * etc. will be delivered to the handler side.
> > > > > +     */
> > > > > +    g_queue_push_tail(mon->qmp_requests, req_obj);
> > > > > +
> > > > > +    /* Kick the dispatcher routine */
> > > > > +    qemu_bh_schedule(mon_global.qmp_dispatcher_bh);
> > > > 
> > > > How is thread-safety ensured when accessing qmp_requests?
> > > 
> > > It's a GQueue.  I assume GQueue is thread safe itself as long as
> > > g_thread_init() is called?
> > 
> > No, glib data structures are not automatically thread-safe unless the
> > documentation says so.
> > 
> > Here is the implementation where you can see that no locking is
> > performed:
> > 
> >   void
> >   g_queue_push_tail (GQueue   *queue,
> >                      gpointer  data)
> >   {
> >     g_return_if_fail (queue != NULL);
> > 
> >     queue->tail = g_list_append (queue->tail, data);
> >     if (queue->tail->next)
> >       queue->tail = queue->tail->next;
> >     else
> >       queue->head = queue->tail;
> >     queue->length++;
> >   }
> 
> Oops. Yes then I possibly need a lock...  Thanks.
> 
> I think maybe I can rename the Monitor.out_lock into a more general
> name, then to use it as a per-monitor lock (instead of introducing
> another one).

Up to you.  I don't remember the details of out_lock usage well enough
to know whether using the lock for the queues is good or bad.

Stefan
