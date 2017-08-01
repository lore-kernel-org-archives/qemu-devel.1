Received: from eggs.gnu.org ([2001:4830:134:3::10]:44976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dcSbV-0001e3-4A
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 04:32:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dcSbR-0000kE-6h
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 04:32:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dcSbR-0000jz-0e
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 04:32:33 -0400
Date: Tue, 1 Aug 2017 09:32:20 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170801083220.GB12670@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-4-git-send-email-peterx@redhat.com>
	<20170731165339.GD2122@work-vm>
	<20170801022519.GB15697@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170801022519.GB15697@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [RFC 03/29] io: fix qio_channel_socket_accept err
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, stefanha@redhat.com

On Tue, Aug 01, 2017 at 10:25:19AM +0800, Peter Xu wrote:
> On Mon, Jul 31, 2017 at 05:53:39PM +0100, Dr. David Alan Gilbert wrote:
> > * Peter Xu (peterx@redhat.com) wrote:
> > > When accept failed, we should setup errp with the reason. More
> > > importantly, the caller may assume errp be non-NULL when error happens,
> > > and not setting the errp may crash QEMU.
> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  io/channel-socket.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/io/channel-socket.c b/io/channel-socket.c
> > > index 53386b7..7bc308e 100644
> > > --- a/io/channel-socket.c
> > > +++ b/io/channel-socket.c
> > > @@ -344,6 +344,7 @@ qio_channel_socket_accept(QIOChannelSocket *ioc,
> > >          if (errno == EINTR) {
> > >              goto retry;
> > >          }
> > > +        error_setg_errno(errp, errno, "Unable to accept connection");
> > >          goto error;
> > 
> > OK, but this code actually has a bigger problem as well:
> > 
> > the original is:
> > 
> >     cioc->fd = qemu_accept(ioc->fd, (struct sockaddr *)&cioc->remoteAddr,
> >                            &cioc->remoteAddrLen);
> >     if (cioc->fd < 0) {
> >         trace_qio_channel_socket_accept_fail(ioc);
> >         if (errno == EINTR) {
> >             goto retry;
> >         }
> >         goto error;
> >     }
> > 
> > Stefan confirmed that trace_ doesn't preserve errno; so the if
> > following it is wrong.  It needs to preserve errno.
> 
> Ah... If so, not sure whether we can do the reservation in trace codes
> in general?
> 
> For this one, I can just move the trace_*() below the errno check.
> After all, if EINTR is got, it's not really a fail, so imho we should
> not trace it with "accept fail".

Agreed, we just need to move the trace below the if.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
