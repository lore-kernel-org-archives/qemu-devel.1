Received: from eggs.gnu.org ([2001:4830:134:3::10]:41446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFFA8-0000CH-AX
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 03:04:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFF8i-00082Q-Qe
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 03:04:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:26086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eFF8i-00081F-DZ
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 03:03:12 -0500
Date: Thu, 16 Nov 2017 16:02:56 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171116080256.GA24928@xz-mi>
References: <20171106094643.14881-1-peterx@redhat.com>
	<20171106094643.14881-28-peterx@redhat.com>
	<20171115102116.GD8130@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171115102116.GD8130@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC v3 27/27] tests: qmp-test: add oob test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Nov 15, 2017 at 10:21:16AM +0000, Stefan Hajnoczi wrote:
> On Mon, Nov 06, 2017 at 05:46:43PM +0800, Peter Xu wrote:
> > +    /*
> > +     * Try a time-consuming command, following by a OOB command, make
> > +     * sure we get OOB command before the time-consuming one (which is
> > +     * run in the parser).
> > +     *
> > +     * When writting up this test script, the only command that
> > +     * support OOB is migrate-incoming.  It's not the best command to
> > +     * test OOB but we don't really have a choice here.  We will check
> > +     * arriving order but not command errors, which does not really
> > +     * matter to us.
> > +     */
> > +    qmp_async("{ 'execute': 'dump-guest-memory',"
> > +              "  'arguments': { 'paging': true, "
> > +              "                 'protocol': 'file:/dev/null' }, "
> > +              "  'id': 'time-consuming-cmd'}");
> > +    qmp_async("{ 'execute': 'migrate-incoming', "
> > +              "  'control': { 'run-oob': true }, "
> > +              "  'id': 'oob-cmd' }");
> > +
> > +    /* Ignore all events.  Wait for 2 acks */
> > +    while (acks < 2) {
> > +        resp = qmp_receive();
> > +        if (qdict_haskey(resp, "event")) {
> > +            /* Skip possible events */
> > +            continue;
> > +        }
> > +        cmd_id = qdict_get_str(resp, "id");
> > +        if (acks == 0) {
> > +            /* Need to receive OOB response first */
> > +            g_assert_cmpstr(cmd_id, ==, "oob-cmd");
> > +        } else if (acks == 1) {
> > +            g_assert_cmpstr(cmd_id, ==, "time-consuming-cmd");
> > +        }
> > +        acks++;
> > +    }
> 
> This test is non-deterministic.  The dump-guest-memory command could
> complete first on a fast machine.
> 
> On a slow machine this test might take a long time...
> 
> Please introduce a test command that is deterministic.  For example,
> when 'x-oob-test' is invoked without 'run-oob': true it waits until
> invoked again, this time with 'run-oob': true.

Yes this sounds good.

> 
> We have similar interfaces in the block layer for controlling the order
> in which parallel I/O requests are processed.  This allows test cases to
> deterministically take specific code paths.

It's great to know that I can create a command to test it.  That
should be much easier.  Thanks,

-- 
Peter Xu
