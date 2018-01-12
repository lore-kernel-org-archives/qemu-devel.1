Received: from eggs.gnu.org ([2001:4830:134:3::10]:42454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZsTB-0006Co-IW
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 01:05:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZsT8-0000da-DH
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 01:05:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eZsT8-0000cd-3w
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 01:05:34 -0500
Date: Fri, 12 Jan 2018 14:05:15 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180112060515.GJ2551@xz-mi>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-17-peterx@redhat.com>
	<20180108170916.GH11758@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180108170916.GH11758@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Jan 08, 2018 at 05:09:16PM +0000, Stefan Hajnoczi wrote:
> On Tue, Dec 19, 2017 at 04:45:46PM +0800, Peter Xu wrote:
> > Originally QMP goes throw these steps:
> 
> s/throw/through/
> 
> > 
> >   JSON Parser --> QMP Dispatcher --> Respond
> >       /|\    (2)                (3)     |
> >    (1) |                               \|/ (4)
> >        +---------  main thread  --------+
> > 
> > This patch does this:
> > 
> >   JSON Parser     QMP Dispatcher --> Respond
> >       /|\ |           /|\       (4)     |
> >        |  | (2)        | (3)            |  (5)
> >    (1) |  +----->      |               \|/
> >        +---------  main thread  <-------+
> > 
> > So the parsing job and the dispatching job is isolated now.  It gives us
> > a chance in following up patches to totally move the parser outside.
> > 
> > The isloation is done using one QEMUBH. Only one dispatcher QEMUBH is
> 
> s/isloation/isolation/
> 
> > @@ -3897,30 +3920,39 @@ static void monitor_qmp_respond(Monitor *mon, QObject *rsp,
> >      qobject_decref(rsp);
> >  }
> >  
> > -static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
> > +struct QMPRequest {
> > +    /* Owner of the request */
> > +    Monitor *mon;
> > +    /* "id" field of the request */
> > +    QObject *id;
> > +    /* Request object to be handled */
> > +    QObject *req;
> > +    /*
> > +     * Whether we need to resume the monitor afterward.  This flag is
> > +     * used to emulate the old QMP server behavior that only one
> > +     * command is executed for each time.
> 
> s/only one command is executed for each time/the current command must
> complete before the next one executes/

Will address all the grammar issues.

> 
> > +     */
> > +    bool need_resume;
> 
> This isn't really a per-request decision so a QMPRequest field is not
> necessary.  If "oob" is enabled then we dispatch commands without
> waiting.  If "oob" is disabled then we complete the current command
> before dispatching the next one.

I explicitly added this to make sure the suspend and resume will be
paired up.  Actually there is at least one exception, which is the
initial "qmp_capabilities" command especially when used to enable the
OOB capability. For that case, OOB is not enabled before execution,
while OOB is enabled during the execution and after running the
command.  If without this field, monitor can hang.

> 
> If you want to keep this, I don't mind, but the field isn't necessary.

According to above, I would still like to keep it.

> 
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
> "we'd better ..." usually means that it will be necessary.  It is
> stronger than "it would be nice to ...".  I'm not sure which one you
> mean here.
> 
> There doesn't seem to be any immediate need or plan to run regular
> commands outside the main loop.  I'm not aware of active work to do
> that.  So what is this comment trying to say?

Yeah I mean "it would be nice to", I'll switch.

This comment explains why dispatcher bottom half is bound to the
default main thread and it cannot be bound to anything else.  Thanks,

-- 
Peter Xu
