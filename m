Received: from eggs.gnu.org ([2001:4830:134:3::10]:40075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1edWlO-0004ZQ-Mq
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 02:43:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1edWlJ-0006bq-O0
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 02:43:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1edWlJ-0006bX-HA
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 02:43:25 -0500
Date: Mon, 22 Jan 2018 15:43:13 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180122074313.GC29532@xz-mi>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-15-peterx@redhat.com>
	<30db45d4-66fa-167f-4f32-22ed47a3bfd2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <30db45d4-66fa-167f-4f32-22ed47a3bfd2@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 14/27] monitor: let suspend_cnt be thread
 safe
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

On Fri, Jan 12, 2018 at 03:48:10PM -0600, Eric Blake wrote:
> On 12/19/2017 02:45 AM, Peter Xu wrote:
> > Monitor code now can be run in more than one thread.  Let it be thread
> > safe when accessing suspend_cnt counter.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  monitor.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/monitor.c b/monitor.c
> > index cf1e5d881c..844508d134 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -3862,7 +3862,7 @@ static int monitor_can_read(void *opaque)
> >  {
> >      Monitor *mon = opaque;
> >  
> > -    return (mon->suspend_cnt == 0) ? 1 : 0;
> > +    return (atomic_mb_read(&mon->suspend_cnt) == 0) ? 1 : 0;
> 
> Worth a comment at the declaration of suspend_cnt that it must be
> accessed atomically?

Sure.

> 
> I find anything that does '(boolexpr) ? 1 : 0' to be a pointless waste
> of typing.  It is semantically equivalent and shorter to write either of:
> 
> return atomic_mb_read(&mon->suspend_cnt) == 0;
> return !atomic_mb_read(&mon->suspend_cnt);

Sure, will use the latter.

> 
> At any rate, I checked that all uses of suspend_cnt were converted over
> to atomic API, so this looks correct, whether or not you add my tweaks.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks for reviewing.

-- 
Peter Xu
