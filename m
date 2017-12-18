Received: from eggs.gnu.org ([2001:4830:134:3::10]:56957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQs2d-0004U3-DX
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:49:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQs2a-0000m1-BU
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:48:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eQs2a-0000la-4h
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:48:56 -0500
Date: Mon, 18 Dec 2017 17:48:38 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171218094838.GR22308@xz-mi>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-26-peterx@redhat.com>
	<20171214143934.GN14433@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171214143934.GN14433@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC v5 25/26] tests: qmp-test: verify command
 batching
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

On Thu, Dec 14, 2017 at 02:39:34PM +0000, Stefan Hajnoczi wrote:
> On Tue, Dec 05, 2017 at 01:51:59PM +0800, Peter Xu wrote:
> > OOB introduced DROP event for flow control.  This should not affect old
> > QMP clients.  Add a command batching check to make sure of it.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  tests/qmp-test.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/tests/qmp-test.c b/tests/qmp-test.c
> > index 292c5f135a..729ec59b0a 100644
> > --- a/tests/qmp-test.c
> > +++ b/tests/qmp-test.c
> > @@ -78,6 +78,7 @@ static void test_qmp_protocol(void)
> >      QList *capabilities;
> >      const QListEntry *entry;
> >      QString *qstr;
> > +    int i;
> >  
> >      global_qtest = qtest_init_without_qmp_handshake(common_args);
> >  
> > @@ -135,6 +136,24 @@ static void test_qmp_protocol(void)
> >      g_assert_cmpint(qdict_get_int(resp, "id"), ==, 2);
> >      QDECREF(resp);
> >  
> > +    /*
> > +     * Test command batching.  In current test OOB is not enabled, we
> > +     * should be able to run as many commands in batch as we like.
> > +     * Using 16 (>8, which is OOB queue length) to make sure OOB
> > +     * won't break existing clients.
> > +     */
> 
> It's possible that QEMU processes the command and responds before the
> test case submits the next one.  Please add:
> 
>   Note: this test does not control the scheduling of QEMU's QMP command
>   processing threads so it may not really trigger batching inside QEMU.
>   This is just a best-effort test.

True.

> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks,

-- 
Peter Xu
