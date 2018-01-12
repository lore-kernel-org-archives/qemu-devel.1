Received: from eggs.gnu.org ([2001:4830:134:3::10]:53970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZrRg-0004hG-5f
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 00:00:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZrRd-0004Wh-5O
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 00:00:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eZrRc-0004WA-Ui
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 23:59:57 -0500
Date: Fri, 12 Jan 2018 12:59:41 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180112045941.GI2551@xz-mi>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-19-peterx@redhat.com>
	<20180109134208.GD31400@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180109134208.GD31400@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC v6 18/27] monitor: send event when command
 queue full
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

On Tue, Jan 09, 2018 at 01:42:08PM +0000, Stefan Hajnoczi wrote:
> On Tue, Dec 19, 2017 at 04:45:48PM +0800, Peter Xu wrote:
> > @@ -4071,6 +4073,9 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
> >      req_obj->req = req;
> >      req_obj->need_resume = false;
> >  
> > +    /* Protect qmp_requests and fetching its length. */
> > +    qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
> > +
> >      /*
> >       * If OOB is not enabled on current monitor, we'll emulate the old
> >       * behavior that we won't process current monitor any more until
> > @@ -4080,6 +4085,17 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
> >      if (!qmp_oob_enabled(mon)) {
> >          monitor_suspend(mon);
> >          req_obj->need_resume = true;
> > +    } else {
> > +        /* Drop the request if queue is full. */
> > +        if (mon->qmp.qmp_requests->length >= QMP_REQ_QUEUE_LEN_MAX) {
> > +            qapi_event_send_command_dropped(id,
> > +                                            COMMAND_DROP_REASON_QUEUE_FULL,
> > +                                            NULL);
> > +            qobject_decref(id);
> > +            qobject_decref(req);
> > +            g_free(req_obj);
> > +            return;
> 
> qmp_queue_lock is still locked!  I suggest releasing the lock before
> calling qapi_event_send_command_dropped().

Yes.  It took me some time to rebase and move that lock out, even if
so I still got one more bug...  Thanks for catching it.

And yes, I agree I should unlock before sending the event.

-- 
Peter Xu
