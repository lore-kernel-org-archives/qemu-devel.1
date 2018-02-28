Received: from eggs.gnu.org ([2001:4830:134:3::10]:44168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1er1R4-00058k-Gk
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 08:06:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1er1Qy-0007mO-Ck
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 08:06:18 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38004 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1er1Qy-0007m6-7H
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 08:06:12 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D6AEC818B12D
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 13:06:11 +0000 (UTC)
Date: Wed, 28 Feb 2018 13:06:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180228130608.GH17774@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180228050633.7410-1-peterx@redhat.com>
	<20180228050633.7410-8-peterx@redhat.com>
	<20180228092511.GG31550@redhat.com> <20180228125216.GH27381@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180228125216.GH27381@xz-mi>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/14] qio/chardev: update net listener
 gcontext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Feb 28, 2018 at 08:52:16PM +0800, Peter Xu wrote:
> On Wed, Feb 28, 2018 at 09:25:11AM +0000, Daniel P. Berrang=C3=A9 wrote=
:
> > On Wed, Feb 28, 2018 at 01:06:26PM +0800, Peter Xu wrote:
> > > TCP chardevs can be using QIO network listeners working in the
> > > background when in listening mode.  However the network listeners a=
re
> > > always running in main context.  This can race with chardevs that a=
re
> > > running in non-main contexts.
> > >=20
> > > To solve this: firstly introduce qio_net_listener_set_context() to =
allow
> > > caller to set gcontext for network listeners.  Then call it in
> > > tcp_chr_update_read_handler(), with the newly cached gcontext.
> > >=20
> > > It's fairly straightforward after we have introduced some net liste=
ner
> > > helper functions - basically we unregister the GSources and add the=
m
> > > back with the correct context.
> > >=20
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  chardev/char-socket.c     |  9 +++++++++
> > >  include/io/net-listener.h | 12 ++++++++++++
> > >  io/net-listener.c         |  7 +++++++
> > >  3 files changed, 28 insertions(+)
> > >=20
> > > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > > index 43a2cc2c1c..8f0935cd15 100644
> > > --- a/chardev/char-socket.c
> > > +++ b/chardev/char-socket.c
> > > @@ -559,6 +559,15 @@ static void tcp_chr_update_read_handler(Charde=
v *chr)
> > >  {
> > >      SocketChardev *s =3D SOCKET_CHARDEV(chr);
> > > =20
> > > +    if (s->listener) {
> > > +        /*
> > > +         * It's possible that chardev context is changed in
> > > +         * qemu_chr_be_update_read_handlers().  Reset it for QIO n=
et
> > > +         * listener if there is.
> > > +         */
> > > +        qio_net_listener_set_context(s->listener, chr->gcontext);
> > > +    }
> > > +
> > >      if (!s->connected) {
> > >          return;
> > >      }
> > > diff --git a/include/io/net-listener.h b/include/io/net-listener.h
> > > index 566be283b3..39dede9d6f 100644
> > > --- a/include/io/net-listener.h
> > > +++ b/include/io/net-listener.h
> > > @@ -106,6 +106,18 @@ int qio_net_listener_open_sync(QIONetListener =
*listener,
> > >                                 SocketAddress *addr,
> > >                                 Error **errp);
> > > =20
> > > +/**
> > > + * qio_net_listener_set_context:
> > > + * @listener: the net listener object
> > > + * @context: the context that we'd like to bind the sources to
> > > + *
> > > + * This helper does not do anything but moves existing net listene=
r
> > > + * sources from the old one to the new one.  It can be seen as a
> > > + * no-operation if there is no listening source at all.
> > > + */
> > > +void qio_net_listener_set_context(QIONetListener *listener,
> > > +                                  GMainContext *context);
> >=20
> > I don't think this is a good design. The GMainContext should be provi=
ded
> > to the qio_net_listener_set_client_func method immediately, not updat=
ed
> > after the fact
>=20
> After the patches, this is qio_net_listener_set_client_func_full():
>=20
> void qio_net_listener_set_client_func_full(QIONetListener *listener,
>                                            QIONetListenerClientFunc fun=
c,
>                                            gpointer data,
>                                            GDestroyNotify notify,
>                                            GMainContext *context)
> {
>     if (listener->io_notify) {
>         listener->io_notify(listener->io_data);
>     }
>     listener->io_func =3D func;
>     listener->io_data =3D data;
>     listener->io_notify =3D notify;
>=20
>     qio_net_listener_sources_clear(listener);
>     qio_net_listener_sources_update(listener, context);
> }
>=20
> This is qio_net_listener_set_context():
>=20
> void qio_net_listener_set_context(QIONetListener *listener,
>                                   GMainContext *context)
> {
>     qio_net_listener_sources_clear(listener);
>     qio_net_listener_sources_update(listener, context);
> }
>=20
> So... Basically qio_net_listener_set_context() is just a simplified
> version of qio_net_listener_set_client_func_full(), but without
> passing in the funcs again.  So do you mean that I can just avoid
> introducing this function and call
> qio_net_listener_set_client_func_full() directly?

Yes, I don't see any reason to allow GMainContext to be changed separatel=
y
from setting the callback functions. The caller can easily just call
qio_net_listener_set_client_func_full() directly with the new GMainContex=
t

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
