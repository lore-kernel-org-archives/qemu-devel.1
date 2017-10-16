Received: from eggs.gnu.org ([2001:4830:134:3::10]:33709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e40VS-0002sG-4C
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 04:12:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e40VO-00074q-Rz
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 04:12:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e40VO-00074C-Df
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 04:12:10 -0400
Date: Mon, 16 Oct 2017 16:11:58 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171016081158.GE4166@pxdev.xzpeter.org>
References: <20170929033844.26935-1-peterx@redhat.com>
	<20170929033844.26935-16-peterx@redhat.com>
	<20171012125620.GG5957@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171012125620.GG5957@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC v2 15/22] monitor: send event when request
 queue full
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

On Thu, Oct 12, 2017 at 01:56:20PM +0100, Stefan Hajnoczi wrote:
> On Fri, Sep 29, 2017 at 11:38:37AM +0800, Peter Xu wrote:
> > Set maximum QMP request queue length to 8.  If queue full, instead of
> > queue the command, we directly return a "request-dropped" event, telling
> > client that specific command is dropped.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  monitor.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/monitor.c b/monitor.c
> > index 1e9a6cb6a5..d9bed31248 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -3971,6 +3971,8 @@ static void monitor_qmp_bh_dispatcher(void *data)
> >      }
> >  }
> >  
> > +#define  QMP_ASYNC_QUEUE_LEN_MAX  (8)
> 
> Why 8?

I proposed this in previous discussion and no one objected, so I just
used it. It's here:

  https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg03989.html
  (please don't go over the thread; I'll copy the related paragraphs)

"""
  ...
  Regarding to queue size: I am afraid max_size=1 may not suffice?
  Otherwise a simple batch of:

  {"execute": "query-status"} {"execute": "query-status"}

  Will trigger the failure.  But I definitely agree it should not be
  something very large.  The total memory will be this:

    json limit * queue length limit * monitor count limit
        (X)            (Y)                    (Z)

  Now we have (X) already (in form of a few tunables for JSON token
  counts, etc.), we don't have (Z), and we definitely need (Y).

  How about we add limits on Y=16 and Z=8?

  We can do some math if we want some more exact number though.
  ...
"""

Oops, I proposed "16", but I used "8"; I hope 8 is good enough, but I
am definitely not sure whether "1" is good.

> 
> My understanding is that this patch series is not about asynchronous QMP
> commands.  Instead it's about executing certain commands immediately in
> the parser thread.

Indeed, but IMHO the series does something further than that - we do
have async queues for QMP requests/responses now.  IMHO that's real
async, though totally different from the idea of "async QMP commands"
for sure.

> 
> Therefore, I suggest hardcoding length 1 for now and not calling it
> "async".  You may also be able to simplify the code since a queue isn't
> actually needed.

For the queue length: discussed above, I'm not sure whether queue=1 is
really what we want.  Again, I may be wrong.

For the naming: how about QMP_REQ_QUEUE_LEN_MAX?

Thanks,

-- 
Peter Xu
