Received: from eggs.gnu.org ([2001:4830:134:3::10]:33352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1evEMv-0006At-M0
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 23:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1evEMq-0008Db-Md
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 23:43:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37796 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1evEMq-0008DP-Fs
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 23:43:20 -0400
Date: Mon, 12 Mar 2018 11:43:04 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180312034304.GC5234@xz-mi>
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-23-peterx@redhat.com>
	<43e12d53-0bbf-b485-6c99-05cec63804ab@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43e12d53-0bbf-b485-6c99-05cec63804ab@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 22/23] tests: qmp-test: verify command
 batching
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

On Sat, Mar 10, 2018 at 08:45:46PM -0600, Eric Blake wrote:
> On 03/09/2018 03:00 AM, Peter Xu wrote:
> > OOB introduced DROP event for flow control.  This should not affect old
> > QMP clients.  Add a command batching check to make sure of it.
> > 
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   tests/qmp-test.c | 22 ++++++++++++++++++++++
> >   1 file changed, 22 insertions(+)
> > 
> 
> > +    /*
> > +     * Test command batching.  In current test OOB is not enabled, we
> > +     * should be able to run as many commands in batch as we like.
> > +     * Using 16 (>8, which is OOB queue length) to make sure OOB won't
> > +     * break existing clients.  Note: this test does not control the
> > +     * scheduling of QEMU's QMP command processing threads so it may
> > +     * not really trigger batching inside QEMU.  This is just a
> > +     * best-effort test.
> > +     */
> > +    for (i = 0; i < 16; i++) {
> > +        qtest_async_qmp(qts, "{ 'execute': 'query-version' }");
> 
> Would the test be any more robust if we could generate a single string to
> send all at once, rather than multiple separate calls to qtest_async_qmp()
> (the overhead in generating separate strings means the monitor may have made
> progress before we send the next string).  But that can be a followup, if
> you want to pursue the idea.

Yes, a single string would be nicer.

As the comment said (which was actually pointed out by Stefan), the
test is only a best effort test considering that we cannot really
control how the QEMU QMP internal handles the requests.  E.g., even if
we send the strings in one write() call, it's still only buffered on
the receiver's side only, and it'll be QEMU who decide how to fetch
the buffer content.

I can fix this up if there is a new post, or do it separately
otherwise along with the other suggestion below.

> 
> > +    }
> > +    /* Verify the replies to make sure no command is dropped. */
> > +    for (i = 0; i < 16; i++) {
> > +        resp = qtest_qmp_receive(qts);
> > +        /* It should never be dropped.  Each of them should be a reply. */
> > +        g_assert(qdict_haskey(resp, "return"));
> > +        g_assert(!qdict_haskey(resp, "event"));
> > +        QDECREF(resp);
> 
> Should we also be sending unique ids, and ensure that the responses arrive
> with ids in the same order?  Again, idea for a followup.

Yes, it can be better.  Will apply the same idea as above, depending
on the fate of current series.

> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

-- 
Peter Xu
