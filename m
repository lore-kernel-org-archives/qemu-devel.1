Received: from eggs.gnu.org ([2001:4830:134:3::10]:60686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dtqrz-0005gY-Uj
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 03:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dtqrw-0003vC-RC
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 03:53:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dtqrw-0003um-IJ
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 03:53:28 -0400
Date: Mon, 18 Sep 2017 15:53:19 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170918075319.GB3617@pxdev.xzpeter.org>
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
	<1505375436-28439-15-git-send-email-peterx@redhat.com>
	<20170915155550.GS2170@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170915155550.GS2170@work-vm>
Subject: Re: [Qemu-devel] [RFC 14/15] qmp: support out-of-band (oob)
 execution
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>

On Fri, Sep 15, 2017 at 04:55:51PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > Having "allow-oob" to true for a command does not mean that this command
> > will always be run in out-of-band mode.  The out-of-band quick path will
> > only be executed if we specify the extra "run-oob" flag when sending the
> > QMP request:
> > 
> >   { "execute": "command-that-allows-oob",
> >     "arguments": { ... },
> >     "control": { "run-oob": true } }
> > 
> > The "control" key is introduced to store this extra flag.  "control"
> > field is used to store arguments that are shared by all the commands,
> > rather than command specific arguments.  Let "run-oob" be the first.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> I don't understand how this enforces the allowoob, that is it stops
> other commands being called with run-oob=true

Here's what I thought:

OOB commands are executed directly in the parser, and currently we
only have one single parser/IO thread, then we can't have two oob
commands in parallel, can we? Say, if we got one OOB command, we won't
handle anything else (no matter OOB or non-OOB) before we finished
processing that OOB command.

> 
> > ---
> >  docs/devel/qapi-code-gen.txt | 10 ++++++++++
> >  include/qapi/qmp/dispatch.h  |  1 +
> >  monitor.c                    | 11 +++++++++++
> >  qapi/qmp-dispatch.c          | 34 ++++++++++++++++++++++++++++++++++
> >  trace-events                 |  2 ++
> >  5 files changed, 58 insertions(+)
> > 
> > diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> > index 61fa167..47d16bb 100644
> > --- a/docs/devel/qapi-code-gen.txt
> > +++ b/docs/devel/qapi-code-gen.txt
> > @@ -665,6 +665,16 @@ allowed to run out-of-band can also be introspected using
> >  query-qmp-schema command.  Please see the section "Client JSON
> >  Protocol introspection" for more information.
> >  
> > +To execute a command in out-of-band way, we need to specify the
> > +"control" field in the request, with "run-oob" set to true. Example:
> > +
> > + => { "execute": "command-support-oob",
> > +      "arguments": { ... },
> > +      "control": { "run-oob": true } }
> > + <= { "return": { } }
> > +
> > +Without it, even the commands that supports out-of-band execution will
> > +still be run in-band.
> >  
> >  === Events ===
> >  
> > diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
> > index b767988..ee2b8ce 100644
> > --- a/include/qapi/qmp/dispatch.h
> > +++ b/include/qapi/qmp/dispatch.h
> > @@ -49,6 +49,7 @@ bool qmp_command_is_enabled(const QmpCommand *cmd);
> >  const char *qmp_command_name(const QmpCommand *cmd);
> >  bool qmp_has_success_response(const QmpCommand *cmd);
> >  QObject *qmp_build_error_object(Error *err);
> > +bool qmp_is_oob(const QObject *request);
> >  
> >  typedef void (*qmp_cmd_callback_fn)(QmpCommand *cmd, void *opaque);
> >  
> > diff --git a/monitor.c b/monitor.c
> > index 599ea36..cb96204 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -3928,6 +3928,7 @@ static void monitor_qmp_bh_dispatcher(void *data)
> >          if (!req_obj) {
> >              break;
> >          }
> > +        trace_monitor_qmp_cmd_in_band(qobject_get_str(req_obj->id));
> >          monitor_qmp_dispatch_one(req_obj);
> >      }
> >  }
> > @@ -3963,6 +3964,16 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
> >      req_obj->id = id;
> >      req_obj->req = req;
> >  
> > +    if (qmp_is_oob(req)) {
> > +        /*
> > +         * Trigger fast-path to handle the out-of-band request, by
> > +         * executing the command directly in parser.
> > +         */
> > +        trace_monitor_qmp_cmd_out_of_band(qobject_get_str(req_obj->id));
> > +        monitor_qmp_dispatch_one(req_obj);
> > +        return;
> > +    }
> 
> I wonder if there is a way to run all allowoob commands in this way;
> the only difference being if they're not started with run-oob
> you wiat for completion of !oob commands.
> That way the allowoob commands are always run from the same
> thread/context which feels like it should simplify them.

Maybe I misread the comment... Even with current patch, all OOB
commands will be run from the same thread/context (which is the newly
created parser thread), right?  Thanks,

-- 
Peter Xu
