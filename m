Received: from eggs.gnu.org ([2001:4830:134:3::10]:55792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQryQ-0002yV-5H
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:44:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQryM-0005iF-WE
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:44:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eQryM-0005hJ-No
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:44:34 -0500
Date: Mon, 18 Dec 2017 17:44:19 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171218094419.GQ22308@xz-mi>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-25-peterx@redhat.com>
	<20171214143019.GM14433@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171214143019.GM14433@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC v5 24/26] docs: update QMP documents for OOB
 commands
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

On Thu, Dec 14, 2017 at 02:30:19PM +0000, Stefan Hajnoczi wrote:
> On Tue, Dec 05, 2017 at 01:51:58PM +0800, Peter Xu wrote:
> > diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> > index f04c63fe82..8597fdb087 100644
> > --- a/docs/devel/qapi-code-gen.txt
> > +++ b/docs/devel/qapi-code-gen.txt
> > @@ -556,7 +556,8 @@ following example objects:
> >  
> >  Usage: { 'command': STRING, '*data': COMPLEX-TYPE-NAME-OR-DICT,
> >           '*returns': TYPE-NAME, '*boxed': true,
> > -         '*gen': false, '*success-response': false }
> > +         '*gen': false, '*success-response': false,
> > +         '*allow-oob': false }
> >  
> >  Commands are defined by using a dictionary containing several members,
> >  where three members are most common.  The 'command' member is a
> > @@ -636,6 +637,44 @@ possible, the command expression should include the optional key
> >  'success-response' with boolean value false.  So far, only QGA makes
> >  use of this member.
> >  
> > +Most of the QMP commands are handled sequentially in such a order:
> > +Firstly, the JSON Parser parses the command request into some internal
> > +message, delivers the message to QMP dispatchers. Secondly, the QMP
> > +dispatchers will handle the commands one by one in time order, respond
> > +when necessary.
> 
> The important points to cover about normal commands:
> 1. They execute in order
> 2. They run the main loop
> 3. They run under the BQL
> 
> The other stuff about parsing requests into internal messages,
> dispatchers, etc is not relevant.  It's better not to include it in
> documentation because it can change and could also confuse readers
> (since they don't need this info).

Ah yes.  I'm thinking whether I should just remove most of the changes
to this file (qapi-code-gen.txt) since most of them are really not
related to code gen at all...  Maybe somewhere in qmp-spec.txt as
well?

> 
> > For some commands that always complete "quickly" can
> 
> I've mentioned before that "quickly" is misleading and not what oob
> commands are about.  I suggest changing this to:
> 
>   Certain urgent commands can
> 
> I've made similar comments further down where I think the text focusses
> on words like "quickly" or "asynchronous" too much.

I'll be more careful on the wording in next version on this.

> 
> > +instead be executed directly during parsing, at the QMP client's
> > +request.  This kind of commands that allow direct execution is called
> > +"out-of-band" ("oob" as shortcut) commands. The response can overtake
> > +prior in-band commands' responses.  By default, commands are always
> > +in-band.  We need to explicitly specify "allow-oob" to "True" to show
> 
> s/"True"/true/  (JSON is case-sensitive)

Ok.

> 
> > +that one command can be run out-of-band.
> > +
> > +One thing to mention for developers is that, although out-of-band
> > +execution of commands benefit from quick and asynchronous execution,
> > +it need to satisfy at least the following:
> > +
> > +(1) It is extremely quick and never blocks, so that its execution will
> > +    not block parsing routine of any other monitors.
> > +
> > +(2) It does not need BQL, since the parser can be run without BQL,
> > +    while the dispatcher is always with BQL held.
> 
> These conditions are not sufficient for postcopy recovery.  I suggest
> rephrasing this section as follows:
> 
>   An out-of-band command must:
> 
>   1. Complete extremely quickly
>   2. Not take locks
>   3. Not invoke blocking system calls
>   4. Not access guest RAM or memory that blocks when userfaultfd is
>      enabled for postcopy live migration
> 
> We could make #2 less strict by saying "Not take locks except for
> spinlocks (or mutexes that could be spinlocks because the critical
> regions are tiny) or indirectly via g_malloc()".

Ok.  I'm thinking whether I should also move these lines out too.

> 
> > Whether a command is
> > +allowed to run out-of-band can also be introspected using
> > +query-qmp-schema command.  Please see the section "Client JSON
> > +Protocol introspection" for more information.
> 
> This is relevant to client authors, not QEMU developers learning about
> qapi.  I suggest dropping it.

Ok.

> 
> > +
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
> This is relevant to client authors, not QEMU developers learning about
> qapi.  I suggest instead explaining how qmp functions need to test for
> qmp_is_oob() so that they know which mode they are executing in.
> 
> >  2.2.1 Capabilities
> >  ------------------
> >  
> > -As of the date this document was last revised, no server or client
> > -capability strings have been defined.
> > -
> > +Currently supported capabilities are:
> > +
> > +- "oob": it means the QMP server supports "Out-Of-Band" command
> > +  execution.  For more detail, please see "run-oob" parameter in
> > +  "Issuing Commands" section below.  Not all commands allow this "oob"
> > +  execution.  One can know whether one command supports "oob" by
> > +  "query-qmp-schema" command.
> > +
> > +  NOTE: Converting an existing QMP command to be OOB-capable can be
> > +  either very easy or extremely hard.  The most important thing is
> > +  that OOB-capable command should never be blocked for a long time.
> > +  Some bad examples: (1) doing IOs, especially when the backend can be
> > +  an NFS storage; or (2) accessing guest memories, which can be simply
> > +  blocked for a very long time when it triggers a page fault, which
> > +  may not be handled immediately.  It's still legal to take a mutex in
> > +  an OOB-capable command handler, however, we need to make sure that
> > +  all the other code paths that are protected by the same lock won't
> > +  be blocked very long as well, otherwise the OOB handler might be
> > +  blocked too when it tries to take the lock.
> 
> Please drop this paragraph, this is the qmp-spec.txt document so the
> implementation of QEMU's QMP commands shouldn't be discussed here.

Ok.

> 
> > For some commands that always complete
> > +  "quickly" can be executed directly during parsing at the QMP
> > +  client's request.
> 
> Please drop this sentence.  "quickly" isn't the important quality, it's
> urgency.  Also the description of execution in the QMP parser isn't
> relevant for qmp-spec.txt, what matters is that oob commands can execute
> while a normal monitor command is still running (this is described next
> so this whole sentence can be dropped).

Ok.

I'll try to re-arrange the sentences better in my next post.  Thanks,

-- 
Peter Xu
