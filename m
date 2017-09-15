Received: from eggs.gnu.org ([2001:4830:134:3::10]:46672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dsgrM-0005dX-B3
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:00:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dsgrJ-0002fw-AM
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:00:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dsgrJ-0002dr-23
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:00:01 -0400
Date: Fri, 15 Sep 2017 10:59:47 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170915025947.GL3617@pxdev.xzpeter.org>
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
	<1505375436-28439-15-git-send-email-peterx@redhat.com>
	<20170914153334.GC7370@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170914153334.GC7370@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Sep 14, 2017 at 04:33:34PM +0100, Stefan Hajnoczi wrote:
> On Thu, Sep 14, 2017 at 03:50:35PM +0800, Peter Xu wrote:
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
> 
> Is there a more relevant place to document QMP run-oob behavior than the
> "How to use the QAPI code generator document"?

I agree, but I don't really know it. :(

Markus, could you provide a hint?

> 
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
> A "fast-path" is a performance optimization.  OOB is not a performance
> optimization, it changes the semantics of command execution.  Please
> mention the semantics of OOB command execution instead.

I'll remove the "fast-path" wording and try to think out something
better than this comment.  After I know a good place to document, I
can put it there as well.  Thanks,

-- 
Peter Xu
