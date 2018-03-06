Received: from eggs.gnu.org ([2001:4830:134:3::10]:43141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1et9ze-0008LD-48
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:38:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1et9zc-0000co-9W
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:38:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58864 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1et9zc-0000cj-3V
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:38:48 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AE74B4023150
	for <qemu-devel@nongnu.org>; Tue,  6 Mar 2018 10:38:47 +0000 (UTC)
Date: Tue, 6 Mar 2018 10:38:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180306103845.GA27720@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180125155915.3226-1-berrange@redhat.com>
	<20180212174822.GZ4071@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180212174822.GZ4071@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: convert socket server to
 QIONetListener
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

Ping

On Mon, Feb 12, 2018 at 05:48:22PM +0000, Daniel P. Berrang=C3=A9 wrote:
> Ping, any thoughts on this ?
>=20
> NB, it will conflict with the multiple-sockets migration work I
> expect, since IIRC that assumes it can get the GSource ID of the
> migration listener, but that's not valid going forward, since
> the GSource's are private to the QIONetListener. The callers
> just register & unregister the callbacks.
>=20
> On Thu, Jan 25, 2018 at 03:59:15PM +0000, Daniel P. Berrang=C3=A9 wrote=
:
> > From: "Daniel P. Berrange" <berrange@redhat.com>
> >=20
> > Instead of creating a QIOChannelSocket directly for the migration
> > server socket, use a QIONetListener. This provides the ability
> > to listen on multiple sockets at the same time, so enables
> > full support for IPv4/IPv6 dual stack.
> >=20
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  migration/socket.c | 48 ++++++++++++++++----------------------------=
----
> >  1 file changed, 16 insertions(+), 32 deletions(-)
> >=20
> > diff --git a/migration/socket.c b/migration/socket.c
> > index 3a8232dd2d..d0ef50765c 100644
> > --- a/migration/socket.c
> > +++ b/migration/socket.c
> > @@ -24,6 +24,7 @@
> >  #include "migration.h"
> >  #include "qemu-file.h"
> >  #include "io/channel-socket.h"
> > +#include "io/net-listener.h"
> >  #include "trace.h"
> > =20
> > =20
> > @@ -130,34 +131,20 @@ void unix_start_outgoing_migration(MigrationSta=
te *s,
> >  }
> > =20
> > =20
> > -static gboolean socket_accept_incoming_migration(QIOChannel *ioc,
> > -                                                 GIOCondition condit=
ion,
> > -                                                 gpointer opaque)
> > +static void socket_accept_incoming_migration(QIONetListener *listene=
r,
> > +                                             QIOChannelSocket *cioc,
> > +                                             gpointer opaque)
> >  {
> > -    QIOChannelSocket *sioc;
> > -    Error *err =3D NULL;
> > -
> > -    sioc =3D qio_channel_socket_accept(QIO_CHANNEL_SOCKET(ioc),
> > -                                     &err);
> > -    if (!sioc) {
> > -        error_report("could not accept migration connection (%s)",
> > -                     error_get_pretty(err));
> > -        goto out;
> > -    }
> > -
> >      trace_migration_socket_incoming_accepted();
> > =20
> > -    qio_channel_set_name(QIO_CHANNEL(sioc), "migration-socket-incomi=
ng");
> > -    migration_channel_process_incoming(QIO_CHANNEL(sioc));
> > -    object_unref(OBJECT(sioc));
> > +    qio_channel_set_name(QIO_CHANNEL(cioc), "migration-socket-incomi=
ng");
> > +    migration_channel_process_incoming(QIO_CHANNEL(cioc));
> > =20
> > -out:
> >      if (migration_has_all_channels()) {
> >          /* Close listening socket as its no longer needed */
> > -        qio_channel_close(ioc, NULL);
> > -        return G_SOURCE_REMOVE;
> > -    } else {
> > -        return G_SOURCE_CONTINUE;
> > +        qio_net_listener_disconnect(listener);
> > +
> > +        object_unref(OBJECT(listener));
> >      }
> >  }
> > =20
> > @@ -165,21 +152,18 @@ out:
> >  static void socket_start_incoming_migration(SocketAddress *saddr,
> >                                              Error **errp)
> >  {
> > -    QIOChannelSocket *listen_ioc =3D qio_channel_socket_new();
> > +    QIONetListener *listener =3D qio_net_listener_new();
> > =20
> > -    qio_channel_set_name(QIO_CHANNEL(listen_ioc),
> > -                         "migration-socket-listener");
> > +    qio_net_listener_set_name(listener, "migration-socket-listener")=
;
> > =20
> > -    if (qio_channel_socket_listen_sync(listen_ioc, saddr, errp) < 0)=
 {
> > -        object_unref(OBJECT(listen_ioc));
> > +    if (qio_net_listener_open_sync(listener, saddr, errp) < 0) {
> > +        object_unref(OBJECT(listener));
> >          return;
> >      }
> > =20
> > -    qio_channel_add_watch(QIO_CHANNEL(listen_ioc),
> > -                          G_IO_IN,
> > -                          socket_accept_incoming_migration,
> > -                          listen_ioc,
> > -                          (GDestroyNotify)object_unref);
> > +    qio_net_listener_set_client_func(listener,
> > +                                     socket_accept_incoming_migratio=
n,
> > +                                     NULL, NULL);
> >  }
> > =20
> >  void tcp_start_incoming_migration(const char *host_port, Error **err=
p)
> > --=20
> > 2.14.3
> >=20
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
