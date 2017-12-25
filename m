Received: from eggs.gnu.org ([2001:4830:134:3::10]:59248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eTM5z-0002x7-OX
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 01:18:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eTM5v-0004Go-P1
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 01:18:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eTM5v-0004Fh-HW
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 01:18:39 -0500
Date: Mon, 25 Dec 2017 14:18:25 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171225061825.GJ2443@xz-mi>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-19-peterx@redhat.com>
	<20171221114246.GO10812@lemon> <20171225051856.GF2443@xz-mi>
	<20171225055556.GC9418@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171225055556.GC9418@lemon>
Subject: Re: [Qemu-devel] [RFC v6 18/27] monitor: send event when command
 queue full
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Dec 25, 2017 at 01:55:56PM +0800, Fam Zheng wrote:
> On Mon, 12/25 13:18, Peter Xu wrote:
> > On Thu, Dec 21, 2017 at 07:42:46PM +0800, Fam Zheng wrote:
> > > On Tue, 12/19 16:45, Peter Xu wrote:
> > > > Set maximum QMP command queue length to 8.  If queue full, instead of
> > > > queue the command, we directly return a "command-dropped" event, telling
> > > > client that specific command is dropped.
> > > > 
> > > > Note that this flow control mechanism is only valid if OOB is enabled.
> > > > If it's not, the effective queue length will always be 1, which strictly
> > > > follows original behavior of QMP command handling (which never drop
> > > > messages).
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >  monitor.c | 17 ++++++++++++++++-
> > > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/monitor.c b/monitor.c
> > > > index ed9a741d06..b571866659 100644
> > > > --- a/monitor.c
> > > > +++ b/monitor.c
> > > > @@ -4038,6 +4038,8 @@ static void monitor_qmp_bh_dispatcher(void *data)
> > > >      }
> > > >  }
> > > >  
> > > > +#define  QMP_REQ_QUEUE_LEN_MAX  (8)
> > > 
> > > Is this limit introspectable on QMP?
> > 
> > Not yet.  IMHO it's really QMP internal stuff, and I see no benefit so
> > far for a client to know about this...
> 
> A client may need this number to batch (non-oob) commands without worrying about
> getting command-dropped event.

IMHO QMP batching will only be useful when performance matters, but
for now IMHO we don't need to worry much about QMP performance?  When
we do, I suspect we need to do more things to make sure of it, and
exposing this single parameter may not really help much, say, for now
even the client batches the stuff, they still need to wait for the
completion of commands.

A rule of mine for this (which may not be exactly correct, but that's
what I'm following) is that we only export things that we are very
sure to export.  For the rest, I would prefer to hide them, so that we
will make ourselves easier for compatibilities.  Thanks,

-- 
Peter Xu
