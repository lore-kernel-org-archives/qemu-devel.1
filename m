Received: from eggs.gnu.org ([2001:4830:134:3::10]:35116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1evEa8-0001Qj-De
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 23:57:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1evEa5-0004H5-Ca
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 23:57:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35640 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1evEa5-0004Gw-6n
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 23:57:01 -0400
Date: Mon, 12 Mar 2018 11:56:44 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180312035644.GD5234@xz-mi>
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-24-peterx@redhat.com>
	<c4fbae90-a94e-be08-49c8-607d7ec5465c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c4fbae90-a94e-be08-49c8-607d7ec5465c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 23/23] tests: qmp-test: add oob test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Sat, Mar 10, 2018 at 08:49:42PM -0600, Eric Blake wrote:
> On 03/09/2018 03:00 AM, Peter Xu wrote:
> > Test the new OOB capability.  Here we used the new "x-oob-test" command.
> > Firstly, we send a lock=true and oob=false command to hang the main
> 
> s/Firstly/First/
> 
> > thread.  Then send another lock=false and oob=true command (which will
> > be run inside parser this time) to free that hanged command.
> > 
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   tests/qmp-test.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 65 insertions(+)
> > 
> 
> > +    /* Now, enable OOB in current QMP session, it should success. */
> 
> s/success/succeed/
> 
> > +
> > +    /*
> > +     * Firstly send the "x-oob-test" command with lock=true and
> 
> s/Firstly/First/
> 
> > +     * oob=false, it should hang the dispatcher and main thread;
> > +     * later, we send another lock=false with oob=true to continue
> > +     * that thread processing.  Finally we should receive replies from
> > +     * both commands.
> > +     */
> > +    qmp_async("{ 'execute': 'x-oob-test',"
> > +              "  'arguments': { 'lock': true }, "
> > +              "  'id': 'lock-cmd'}");
> > +    qmp_async("{ 'execute': 'x-oob-test', "
> > +              "  'arguments': { 'lock': false }, "
> > +              "  'control': { 'run-oob': true }, "
> > +              "  'id': 'unlock-cmd' }");
> > +
> > +    /* Ignore all events.  Wait for 2 acks */
> > +    while (acks < 2) {
> > +        resp = qmp_receive();
> > +        cmd_id = qdict_get_str(resp, "id");
> > +        if (!g_strcmp0(cmd_id, "lock-cmd") ||
> > +            !g_strcmp0(cmd_id, "unlock-cmd")) {
> > +            acks++;
> > +        }
> > +        QDECREF(resp);
> > +    }
> 
> Can you make the reply order deterministic?  Perhaps by having the lock
> command insert a sleep after locking but before replying, so that the unlock
> always gets to reply first?  But that can be a followup.

Yes, I could.  I'm just afraid that sleep might be undeterministic too
in some extreme cases, since IMHO it'll still depend on other things
(e.g., the scheduler of host, resources/workload on the host, etc.) to
make sure the order of the two commands will be exactly what we want.

So, even if current test seems to be undetermistic on the order of
received responses, IMHO it's very good on the other hand that it is
very determinstic on the test result...

> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks,

-- 
Peter Xu
