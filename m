Received: from eggs.gnu.org ([2001:4830:134:3::10]:43221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dFj5A-0008D7-Jf
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:29:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dFj57-0004MT-SU
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:29:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dFj57-0004M6-Gc
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:29:13 -0400
Date: Tue, 30 May 2017 16:29:11 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170530152911.GS21566@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
	<20170530143052.165002-12-vsementsov@virtuozzo.com>
	<20170530150422.GR21566@redhat.com>
	<e5f7afa3-c05d-b11c-d02e-5a5b2cb01603@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e5f7afa3-c05d-b11c-d02e-5a5b2cb01603@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 11/19] io/channel-socket:
 qio_channel_socket_writev handle EPIPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, den@openvz.org

On Tue, May 30, 2017 at 06:15:07PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> 30.05.2017 18:04, Daniel P. Berrange wrote:
> > On Tue, May 30, 2017 at 05:30:44PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > Return QIO_CHANNEL_ERR_EPIPE on EPIPE, we will need it to improve error
> > > path in nbd server.
> > > 
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > > ---
> > >   include/io/channel.h | 1 +
> > >   io/channel-socket.c  | 2 +-
> > >   2 files changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/io/channel.h b/include/io/channel.h
> > > index 5d48906998..5529c2da31 100644
> > > --- a/include/io/channel.h
> > > +++ b/include/io/channel.h
> > > @@ -38,6 +38,7 @@ typedef struct QIOChannel QIOChannel;
> > >   typedef struct QIOChannelClass QIOChannelClass;
> > >   #define QIO_CHANNEL_ERR_BLOCK -2
> > > +#define QIO_CHANNEL_ERR_EPIPE -3
> > >   typedef enum QIOChannelFeature QIOChannelFeature;
> > > diff --git a/io/channel-socket.c b/io/channel-socket.c
> > > index 53386b7ba3..50f9f966c6 100644
> > > --- a/io/channel-socket.c
> > > +++ b/io/channel-socket.c
> > > @@ -542,7 +542,7 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
> > >           }
> > >           error_setg_errno(errp, errno,
> > >                            "Unable to write to socket");
> > > -        return -1;
> > > +        return errno == EPIPE ? QIO_CHANNEL_ERR_EPIPE : -1;
> > >       }
> > >       return ret;
> > Ewwww, no. We don't want to go down the road of special casing
> > further errno values for every error scenario.
> 
> I need to distinguish client socket closed without reading nbd server reply
> from other errors, because this is a valid behavior accordingly to the
> protocol.
> Any way to do this? Hmm, I can examine the contents of errp, of course, but
> I'm afraid it would be even less appropriate. This is funny: user has this
> information in errp message, but the code - doesn't..
> 
> Alternatively:
> 1. not report errors on sending reply after OPT_ABORT at all
> 2. report all errors, (including this EPIPE, which actually is not a
> failure)
> 
> Paolo, what do you think?
> 
> (current behavior is (1))

I'm not seeing any problem with continuing with (1). Once we've received
an OPT_ABORT msg from the client, we know it is going away, so no further
errors we get matter from that point onwards.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
