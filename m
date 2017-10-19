Received: from eggs.gnu.org ([2001:4830:134:3::10]:33797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e5AcK-0007Wm-6Q
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 09:12:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e5AcD-0001CF-UP
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 09:12:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1e5AcD-0001B1-LZ
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 09:12:01 -0400
Date: Thu, 19 Oct 2017 15:11:50 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171019131150.GD6205@stefanha-x1.localdomain>
References: <20170929033844.26935-1-peterx@redhat.com>
	<20170929033844.26935-16-peterx@redhat.com>
	<20171012125620.GG5957@stefanha-x1.localdomain>
	<20171016081158.GE4166@pxdev.xzpeter.org>
	<20171018152804.GC31848@stefanha-x1.localdomain>
	<20171019071611.GY4166@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171019071611.GY4166@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [RFC v2 15/22] monitor: send event when request
 queue full
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

On Thu, Oct 19, 2017 at 03:16:11PM +0800, Peter Xu wrote:
> On Wed, Oct 18, 2017 at 05:28:04PM +0200, Stefan Hajnoczi wrote:
> > On Mon, Oct 16, 2017 at 04:11:58PM +0800, Peter Xu wrote:
> > > On Thu, Oct 12, 2017 at 01:56:20PM +0100, Stefan Hajnoczi wrote:
> > > > On Fri, Sep 29, 2017 at 11:38:37AM +0800, Peter Xu wrote:
> > > > > Set maximum QMP request queue length to 8.  If queue full, instead of
> > > > > queue the command, we directly return a "request-dropped" event, telling
> > > > > client that specific command is dropped.
> > > > > 
> > > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > > ---
> > > > >  monitor.c | 15 +++++++++++++++
> > > > >  1 file changed, 15 insertions(+)
> > > > > 
> > > > > diff --git a/monitor.c b/monitor.c
> > > > > index 1e9a6cb6a5..d9bed31248 100644
> > > > > --- a/monitor.c
> > > > > +++ b/monitor.c
> > > > > @@ -3971,6 +3971,8 @@ static void monitor_qmp_bh_dispatcher(void *data)
> > > > >      }
> > > > >  }
> > > > >  
> > > > > +#define  QMP_ASYNC_QUEUE_LEN_MAX  (8)
> > > > 
> > > > Why 8?
> > > 
> > > I proposed this in previous discussion and no one objected, so I just
> > > used it. It's here:
> > > 
> > >   https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg03989.html
> > >   (please don't go over the thread; I'll copy the related paragraphs)
> > > 
> > > """
> > >   ...
> > >   Regarding to queue size: I am afraid max_size=1 may not suffice?
> > >   Otherwise a simple batch of:
> > > 
> > >   {"execute": "query-status"} {"execute": "query-status"}
> > > 
> > >   Will trigger the failure.  But I definitely agree it should not be
> > >   something very large.  The total memory will be this:
> > > 
> > >     json limit * queue length limit * monitor count limit
> > >         (X)            (Y)                    (Z)
> > > 
> > >   Now we have (X) already (in form of a few tunables for JSON token
> > >   counts, etc.), we don't have (Z), and we definitely need (Y).
> > > 
> > >   How about we add limits on Y=16 and Z=8?
> > > 
> > >   We can do some math if we want some more exact number though.
> > >   ...
> > > """
> > > 
> > > Oops, I proposed "16", but I used "8"; I hope 8 is good enough, but I
> > > am definitely not sure whether "1" is good.
> > 
> > I understand the concern about breaking existing clients but choosing an
> > arbitrary magic number isn't a correct solution to that problem because
> > existing clients may exceed the magic number!
> 
> I agree.
> 
> > 
> > Instead I think QMP should only look ahead if the out-of-band feature
> > has been negotatiated.  This way existing clients continue to work.  New
> > clients will have to avoid sending a batch of requests or they must
> > handle the queue size limit error.
> 
> Hmm yes I just noticed that although I broadcasted the "OOB"
> capability but actually I skipped the negociation phase (so OOB is
> always enabled). I think I should have that for sure.
> 
> IIUC below new handle_qmp_command() should be always compatible with
> old clients then:
> 
> handle_qmp_command ()
> {
>   ...
>   if (oob_enabled) {
>     if (cmd_is_oob (req)) {
>       // execute command
>       qmp_dispatch (req);
>       return;
>     }
>     if (queue_full (mon)) {
>       // drop req
>       send_full_event (mon);
>       return;
>     }
>   }
> 
>   queue (req);
>   kick (task);
> 
>   if (!oob_enabled) {
>     // if oob not enabled, we don't process next request before previous
>     // one finishes, and queue length will always be either 0 or 1.
>     // Note: this means the parsing thread can block now.
>     wait_until_req_handled (req);
>   }
> }
> 
> This will be somehow more complicated than before though, since if
> with this, we need to make sure all the QMP clients have enabled OOB
> feature to make sure OOB command can work. Otherwise even if only one
> QMP client didn't enable OOB, then it may block at waiting for the
> request to finish, and it will block the whole monitor IOThread as
> well (which is currently shared by OOB and non-OOB monitors).
> 
> Or, maybe, I should just create one IOThread for each QMP monitor.

Or temporarily stop monitoring a client's chardev while the request is
being processed if OOB isn't negotiated.  That way a single IOThread can
still service multiple QMP monitors with differing OOB settings.

Stefan
