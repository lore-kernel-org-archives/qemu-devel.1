Received: from eggs.gnu.org ([2001:4830:134:3::10]:46970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dcq5w-0005Co-9Z
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 05:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dcq5t-0007Yd-6E
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 05:37:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dcq5t-0007Xh-0i
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 05:37:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E1FC85AFC8
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 09:37:31 +0000 (UTC)
Date: Wed, 2 Aug 2017 17:37:27 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170802093727.GA5561@pxdev.xzpeter.org>
References: <1501644321-17721-1-git-send-email-peterx@redhat.com>
	<1501644321-17721-3-git-send-email-peterx@redhat.com>
	<20170802093020.GD4098@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170802093020.GD4098@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] io: fix qio_channel_socket_accept err
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Aug 02, 2017 at 10:30:20AM +0100, Daniel P. Berrange wrote:
> On Wed, Aug 02, 2017 at 11:25:21AM +0800, Peter Xu wrote:
> > When accept failed, we should setup errp with the reason. More
> > importantly, the caller may assume errp be non-NULL when error happens,
> > and not setting the errp may crash QEMU.
> > 
> > At the same time, move the trace_qio_channel_socket_accept_fail() after
> > the if check on EINTR. Two reasons:
> > 
> > 1. when EINTR happened, it's not really a fault (we should just try
> >    again), so we should not log with an "accept failure".
> > 
> > 2. trace_*() functions may overwrite errno, then the old errno will be
> >    missing. We need to either check errno before trace_*() calls, or
> >    reserve the errno.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  io/channel-socket.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/io/channel-socket.c b/io/channel-socket.c
> > index 53386b7..442f230 100644
> > --- a/io/channel-socket.c
> > +++ b/io/channel-socket.c
> > @@ -340,10 +340,11 @@ qio_channel_socket_accept(QIOChannelSocket *ioc,
> >      cioc->fd = qemu_accept(ioc->fd, (struct sockaddr *)&cioc->remoteAddr,
> >                             &cioc->remoteAddrLen);
> >      if (cioc->fd < 0) {
> > -        trace_qio_channel_socket_accept_fail(ioc);
> >          if (errno == EINTR) {
> >              goto retry;
> >          }
> > +        trace_qio_channel_socket_accept_fail(ioc);
> > +        error_setg_errno(errp, errno, "Unable to accept connection");
> 
> Err, you're still clobbering errno in trace_qio_channel_socket_accept_fail
> before calling error_setg_errno

Oops! I'll do a quick respin.  Thanks for pointing out.

-- 
Peter Xu
