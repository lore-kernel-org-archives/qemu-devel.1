Received: from eggs.gnu.org ([2001:4830:134:3::10]:52124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZt5j-0001yt-E1
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 01:45:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZt5i-0002EJ-Je
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 01:45:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eZt5i-0002Dw-9y
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 01:45:26 -0500
Date: Fri, 12 Jan 2018 14:44:55 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180112064455.GN2551@xz-mi>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-23-peterx@redhat.com>
	<20180109142435.GG31400@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180109142435.GG31400@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC v6 22/27] qmp: isolate responses into io
 thread
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

On Tue, Jan 09, 2018 at 02:24:35PM +0000, Stefan Hajnoczi wrote:
> On Tue, Dec 19, 2017 at 04:45:52PM +0800, Peter Xu wrote:
> > +static void monitor_qmp_bh_responder(void *opaque)
> > +{
> > +    QMPResponse response;
> > +
> > +    while (true) {
> > +        response = monitor_qmp_response_pop_one();
> > +        if (!response.data) {
> > +            break;
> > +        }
> > +        monitor_json_emitter_raw(response.mon, response.data);
> 
> Have you audited all mon->out_lock users to ensure that guest memory is
> never touched while the lock is held?
> 
> If guest memory is touched then the main loop could be blocked due to
> postcopy and when the IOThread executes monitor_qmp_bh_responder() ->
> monitor_json_emitter_raw() -> monitor_puts() it will also hang!

Yes, I am mostly certain that it never touches guest memory.  IMHO
it's a pure lock for monitor's output buffer since day one of its
occurence in 6cff3e8594c.

An extreme case I can think of is when someone wants to dump some data
from guest memory in QMP (I suspect who will use it though...).  In
that case we will still be safe, since the guest memory access should
be happening in g_strdup_vprintf() rather than monitor_puts(), so even
if it happens we will hang at g_strdup_vprintf() without the lock taken.

> 
> Please add a comment above the out_lock declaration letting users know
> that they must not touch guest memory while holding the lock.

I'm not sure whether adding a comment like this for the lock would be
a bit strange, but I agree it should be better than nothing.  Thanks,

-- 
Peter Xu
