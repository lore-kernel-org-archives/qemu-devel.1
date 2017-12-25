Received: from eggs.gnu.org ([2001:4830:134:3::10]:45006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eTLk9-0005Vt-5W
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 00:56:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eTLk4-0003UH-AL
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 00:56:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eTLk4-0003Tx-4h
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 00:56:04 -0500
Date: Mon, 25 Dec 2017 13:55:56 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171225055556.GC9418@lemon>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-19-peterx@redhat.com>
	<20171221114246.GO10812@lemon> <20171225051856.GF2443@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171225051856.GF2443@xz-mi>
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
To: Peter Xu <peterx@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, 12/25 13:18, Peter Xu wrote:
> On Thu, Dec 21, 2017 at 07:42:46PM +0800, Fam Zheng wrote:
> > On Tue, 12/19 16:45, Peter Xu wrote:
> > > Set maximum QMP command queue length to 8.  If queue full, instead of
> > > queue the command, we directly return a "command-dropped" event, telling
> > > client that specific command is dropped.
> > > 
> > > Note that this flow control mechanism is only valid if OOB is enabled.
> > > If it's not, the effective queue length will always be 1, which strictly
> > > follows original behavior of QMP command handling (which never drop
> > > messages).
> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  monitor.c | 17 ++++++++++++++++-
> > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/monitor.c b/monitor.c
> > > index ed9a741d06..b571866659 100644
> > > --- a/monitor.c
> > > +++ b/monitor.c
> > > @@ -4038,6 +4038,8 @@ static void monitor_qmp_bh_dispatcher(void *data)
> > >      }
> > >  }
> > >  
> > > +#define  QMP_REQ_QUEUE_LEN_MAX  (8)
> > 
> > Is this limit introspectable on QMP?
> 
> Not yet.  IMHO it's really QMP internal stuff, and I see no benefit so
> far for a client to know about this...

A client may need this number to batch (non-oob) commands without worrying about
getting command-dropped event.

Fam
