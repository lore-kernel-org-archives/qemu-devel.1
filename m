Received: from eggs.gnu.org ([2001:4830:134:3::10]:45332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQnxD-0007ad-Ec
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 00:27:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQnxA-00075c-A0
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 00:27:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eQnxA-000735-0P
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 00:27:04 -0500
Date: Mon, 18 Dec 2017 13:26:49 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171218052649.GK22308@xz-mi>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-17-peterx@redhat.com>
	<20171213200938.GG8317@stefanha-x1.localdomain>
	<20171216063703.GD22308@xz-mi>
	<20171216092322.GC12533@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171216092322.GC12533@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC v5 16/26] monitor: separate QMP parser and
 dispatcher
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

On Sat, Dec 16, 2017 at 09:23:22AM +0000, Stefan Hajnoczi wrote:
> On Sat, Dec 16, 2017 at 02:37:03PM +0800, Peter Xu wrote:
> > On Wed, Dec 13, 2017 at 08:09:38PM +0000, Stefan Hajnoczi wrote:
> > > On Tue, Dec 05, 2017 at 01:51:50PM +0800, Peter Xu wrote:
> > > > @@ -3956,12 +3968,122 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
> > > >          }
> > > >      }
> > > >  
> > > > -err_out:
> > > > -    monitor_qmp_respond(mon, rsp, err, id);
> > > > +    /* Respond if necessary */
> > > > +    monitor_qmp_respond(mon, rsp, NULL, id);
> > > > +
> > > > +    /* This pairs with the monitor_suspend() in handle_qmp_command(). */
> > > > +    if (!qmp_oob_enabled(mon)) {
> > > > +        monitor_resume(mon);
> > > 
> > > monitor_resume() does not work between threads: if the event loop is
> > > currently blocked in poll() it won't notice that the monitor fd should
> > > be watched again.
> > > 
> > > Please add aio_notify() to monitor_resume() and monitor_suspend().  That
> > > way the event loop is forced to check can_read() again.
> > 
> > Ah, yes.  I think monitor_suspend() does not need the notify?  Since
> > if it's sleeping it won't miss the next check in can_read() after all?
> 
> No, that would be a bug.  Imagine the IOThread is blocked in poll
> monitoring the chardev file descriptor when the main loop calls
> monitor_suspend().  If the file descriptors becomes readable then the
> handler function executes even though the monitor is supposed to be
> suspended!

When you say "the handler function executes", do you mean the handler
that has already added to the qmp request queue, or the one that
hasn't yet parsed by the parser?

For the previous case (the handler that has queued already): IMHO
that's what we expect it to behave, say, when we call
monitor_suspend(), we only stop accepting and parsing new inputs from
the user, but the requests on the queue should still be processed.

For the latter (the handler of a newly typed command):
monitor_suspend() should suspend the parser already, so
monitor_can_read() check should fail, then that command should never
be queued until we call another monitor_resume().

> 
> > Regarding to monitor_resume(), I noticed that I missed the fact that
> > it's only tailored for HMP before, which seems to be a bigger problem.
> > Do you agree with a change like this?
> > 
> > diff --git a/monitor.c b/monitor.c
> > index 9970418d6f..8f96880ad7 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -4244,10 +4244,12 @@ int monitor_suspend(Monitor *mon)
> >  
> >  void monitor_resume(Monitor *mon)
> >  {
> > -    if (!mon->rs)
> > -        return;
> >      if (atomic_dec_fetch(&mon->suspend_cnt) == 0) {
> > -        readline_show_prompt(mon->rs);
> > +        if (monitor_is_qmp(mon)) {
> > +            aio_notify(mon_global.mon_iothread->ctx);
> 
> Please use iothread_get_aio_context() instead of accessing struct
> members.

Ah, yes!

> 
> > +        } else {
> > +            assert(mon->rs);
> > +            readline_show_prompt(mon->rs);
> 
> I haven't studied the HMP and ->rs code.  I'll do that when reviewing
> the next revision of this series.

Sure.

> 
> > +        }
> >      }
> >  }
> > 
> > Even, I'm thinking about whether I should start to introduce
> > iothread_notify() now to mask out the IOThread.ctx details.
> 
> aio_notify() is a low-level AioContext operation that is somewhat
> bug-prone.  I think it's better to leave it directly exposed so callers
> have to think about what they are doing.

Sure.  Thanks!

-- 
Peter Xu
