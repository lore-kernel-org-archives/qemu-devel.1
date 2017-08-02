Received: from eggs.gnu.org ([2001:4830:134:3::10]:59916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dcnfw-00021s-8o
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 03:02:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dcnfr-0006Jc-ED
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 03:02:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26475)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dcnfr-0006J6-4x
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 03:02:31 -0400
Date: Wed, 2 Aug 2017 15:02:24 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170802070224.GD4475@pxdev.xzpeter.org>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-20-git-send-email-peterx@redhat.com>
	<20170801105610.GG12670@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170801105610.GG12670@redhat.com>
Subject: Re: [Qemu-devel] [RFC 19/29] migration: let dst listen on port
 always
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Juan Quintela <quintela@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Aug 01, 2017 at 11:56:10AM +0100, Daniel P. Berrange wrote:
> On Fri, Jul 28, 2017 at 04:06:28PM +0800, Peter Xu wrote:
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/exec.c   | 2 +-
> >  migration/fd.c     | 2 +-
> >  migration/socket.c | 4 ++--
> >  3 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/migration/exec.c b/migration/exec.c
> > index 08b599e..b4412db 100644
> > --- a/migration/exec.c
> > +++ b/migration/exec.c
> > @@ -49,7 +49,7 @@ static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
> >  {
> >      migration_channel_process_incoming(ioc);
> >      object_unref(OBJECT(ioc));
> > -    return FALSE; /* unregister */
> > +    return TRUE; /* keep it registered */
> >  }
> >  
> >  void exec_start_incoming_migration(const char *command, Error **errp)
> > diff --git a/migration/fd.c b/migration/fd.c
> > index 30f5258..865277a 100644
> > --- a/migration/fd.c
> > +++ b/migration/fd.c
> > @@ -49,7 +49,7 @@ static gboolean fd_accept_incoming_migration(QIOChannel *ioc,
> >  {
> >      migration_channel_process_incoming(ioc);
> >      object_unref(OBJECT(ioc));
> > -    return FALSE; /* unregister */
> > +    return TRUE; /* keep it registered */
> >  }
> >  
> >  void fd_start_incoming_migration(const char *infd, Error **errp)
> > diff --git a/migration/socket.c b/migration/socket.c
> > index 757d382..f2c2d01 100644
> > --- a/migration/socket.c
> > +++ b/migration/socket.c
> > @@ -153,8 +153,8 @@ static gboolean socket_accept_incoming_migration(QIOChannel *ioc,
> >  
> >  out:
> >      /* Close listening socket as its no longer needed */
> > -    qio_channel_close(ioc, NULL);
> > -    return FALSE; /* unregister */
> > +    // qio_channel_close(ioc, NULL);
> > +    return TRUE; /* keep it registered */
> >  }
> 
> 
> This is not a very desirable approach IMHO.
> 
> There are two separate things at play - first we have the listener socket,
> and second we have the I/O watch that monitors for incoming clients.
> 
> The current code here closes the listener, and returns FALSE to unregister
> the event loop watch.
> 
> You're reversing both of these so that we keep the listener open and we
> keep monitoring for incoming clients. Ignoring migration resume for a
> minute, this means that the destination QEMU will now accept arbitrarily
> many incoming clients and keep trying to start a new incoming migration.
> 
> The behaviour we need is diferent. We *want* to unregister the event
> loop watch once we've accepted a client. We should only keep the socket
> listener in existance, but *not* accept any more clients. Only once we
> have hit a problem and want to accept a new client to do migration
> recovery, should we be re-adding the event loop watch.

I replied with another approach in the other thread: how about we
re-enable the listen port duing "postcopy-pause" state, and disable
the listen port when get out of that migration state?

Here "listen port" I mean both the IO watch and the socket object. Now
what I can think of: we keep these objects always there, meanwhile we
introduce a new bit for migration, say, "accept_incoming", to decide
whether we will really accept one connection. Then we drop the new
connection if that bit is not set.

(Or a new QIOChannelFeature to temporarily refuse incoming
 connection? E.g., QIO_CHANNEL_FEATURE_LISTEN_REFUSE?)

Thanks,

-- 
Peter Xu
