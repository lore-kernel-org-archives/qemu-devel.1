Received: from eggs.gnu.org ([2001:4830:134:3::10]:46483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQo2h-0000lF-QF
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 00:32:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQo2e-0002IQ-M6
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 00:32:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eQo2e-0002Hi-Ck
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 00:32:44 -0500
Date: Mon, 18 Dec 2017 13:32:31 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171218053231.GL22308@xz-mi>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-19-peterx@redhat.com>
	<20171214114136.GG14433@stefanha-x1.localdomain>
	<20171216071706.GG22308@xz-mi>
	<20171216092836.GD12533@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171216092836.GD12533@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC v5 18/26] monitor: send event when request
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

On Sat, Dec 16, 2017 at 09:28:36AM +0000, Stefan Hajnoczi wrote:
> On Sat, Dec 16, 2017 at 03:17:06PM +0800, Peter Xu wrote:
> > On Thu, Dec 14, 2017 at 11:41:36AM +0000, Stefan Hajnoczi wrote:
> > > On Tue, Dec 05, 2017 at 01:51:52PM +0800, Peter Xu wrote:
> > > > Set maximum QMP request queue length to 8.  If queue full, instead of
> > > > queue the command, we directly return a "request-dropped" event, telling
> > > > client that specific command is dropped.
> > > > 
> > > > Note that this flow control mechanism is only valid if OOB is enabled.
> > > > If it's not, the effective queue length will always be 1, which strictly
> > > > follows original behavior of QMP command handling (which never drop
> > > > messages).
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >  monitor.c | 15 +++++++++++++++
> > > >  1 file changed, 15 insertions(+)
> > > > 
> > > > diff --git a/monitor.c b/monitor.c
> > > > index c20e659740..f7923c4590 100644
> > > > --- a/monitor.c
> > > > +++ b/monitor.c
> > > > @@ -4029,6 +4029,8 @@ static void monitor_qmp_bh_dispatcher(void *data)
> > > >      }
> > > >  }
> > > >  
> > > > +#define  QMP_REQ_QUEUE_LEN_MAX  (8)
> > > > +
> > > >  static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
> > > >                                 void *opaque)
> > > >  {
> > > > @@ -4061,6 +4063,19 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
> > > >      req_obj->id = id;
> > > >      req_obj->req = req;
> > > >  
> > > > +    if (qmp_oob_enabled(mon)) {
> > > > +        /* Drop the request if queue is full. */
> > > > +        if (mon->qmp.qmp_requests->length >= QMP_REQ_QUEUE_LEN_MAX) {
> > > 
> > > qmp_queue_lock must be held.  Perhaps it's simplest to move this check
> > > into the qmp_queue_lock critical section below and unlock before calling
> > > qapi_event_send_request_dropped()...
> > > 
> > > > +            qapi_event_send_request_dropped(id,
> > > > +                                            REQUEST_DROP_REASON_QUEUE_FULL,
> > > > +                                            NULL);
> > > > +            qobject_decref(id);
> > > > +            qobject_decref(req);
> > > > +            g_free(req_obj);
> > > > +            return;
> > > > +        }
> > > > +    }
> > > > +
> > > >      /*
> > > >       * Put the request to the end of queue so that requests will be
> > > >       * handled in time order.  Ownership for req_obj, req, id,
> > > 
> > > ... down here.
> > 
> > Yeah can do.  I think it's not really a must (IMHO the worst case
> > won't be that worse if current queue length is 8)? but it's obviously
> > nicer.
> 
> That style of coding is risky.  People reading the code won't know if
> the lack of the lock was a mistake or intentional.  If not taking the
> lock is necessary for performance (it isn't in this case and we're going
> to take the lock anyway), then it should have a comment or nop
> function/macro that documents the intention.

I have seen no reason to care about performance for QMP yet especially
for this, so I fully agree with you.  Thanks,

-- 
Peter Xu
