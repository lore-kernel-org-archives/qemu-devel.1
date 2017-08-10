Received: from eggs.gnu.org ([2001:4830:134:3::10]:35990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfrwm-0001t0-7l
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 14:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfrwk-00015D-Se
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 14:12:40 -0400
References: <20170810160451.32723-1-berrange@redhat.com>
	<20170810160451.32723-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <84729972-e3ab-676c-df66-4e28b754728d@redhat.com>
Date: Thu, 10 Aug 2017 13:12:25 -0500
MIME-Version: 1.0
In-Reply-To: <20170810160451.32723-3-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LrRtltb2NJK3QkHVOSKH2PVW2oGm8P4Ap"
Subject: Re: [Qemu-devel] [PATCH 2/8] io: introduce a network socket
 listener API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LrRtltb2NJK3QkHVOSKH2PVW2oGm8P4Ap
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org
Message-ID: <84729972-e3ab-676c-df66-4e28b754728d@redhat.com>
Subject: Re: [PATCH 2/8] io: introduce a network socket listener API
References: <20170810160451.32723-1-berrange@redhat.com>
 <20170810160451.32723-3-berrange@redhat.com>
In-Reply-To: <20170810160451.32723-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/10/2017 11:04 AM, Daniel P. Berrange wrote:
> The existing QIOChannelSocket class provides the ability to
> listen on a single socket at a time. This patch introduces
> a QIONetListener class that provides a higher level API
> concept around listening for network services, allowing
> for listening on multiple sockets.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---

> +++ b/include/io/net-listener.h
> @@ -0,0 +1,174 @@
> +/*
> + * QEMU I/O network listener
> + *
> + * Copyright (c) 2016 Red Hat, Inc.

Want to add 2017?

At least it's covered by MAINTAINERS :)


> +/**
> + * qio_net_listener_is_disconnected:
> + * @listener: the network listener object
> + *
> + * Determine if the listener is connected to any socket
> + * channels
> + *
> + * Returns: TRUE if connected, FALSE otherwise
> + */
> +gboolean qio_net_listener_is_disconnected(QIONetListener *listener);
> +

Must it return gboolean, or is bool sufficient?

TRUE if connected for a function named 'is_disconnected' sounds
backwards.  Avoid the double negative, name it:

qio_net_listener_is_connected(), returning true if connected

> +++ b/io/net-listener.c
> @@ -0,0 +1,315 @@
> +/*
> + * QEMU network listener
> + *
> + * Copyright (c) 2016 Red Hat, Inc.

More 2017.  Probably for the whole series :)


> +static gboolean qio_net_listener_channel_func(QIOChannel *ioc,
> +                                              GIOCondition condition,
> +                                              gpointer opaque)
> +{

Again, can we use bool instead of gboolean?

> +int qio_net_listener_open_sync(QIONetListener *listener,
> +                               SocketAddress *addr,
> +                               Error **errp)
> +{
> +    QIODNSResolver *resolver =3D qio_dns_resolver_get_instance();
> +    SocketAddress **resaddrs;
> +    size_t nresaddrs;
> +    size_t i;
> +    Error *err =3D NULL;
> +    bool success =3D false;
> +
> +    if (qio_dns_resolver_lookup_sync(resolver,
> +                                     addr,
> +                                     &nresaddrs,
> +                                     &resaddrs,
> +                                     errp) < 0) {
> +        return -1;
> +    }
> +
> +    for (i =3D 0; i < nresaddrs; i++) {
> +        QIOChannelSocket *sioc =3D qio_channel_socket_new();
> +
> +        if (qio_channel_socket_listen_sync(sioc, resaddrs[i],
> +                                           err ? NULL : &err) =3D=3D 0=
) {
> +            success =3D true;
> +        }

This says that as long as at least one address connected, we are
successful...

> +
> +        qio_net_listener_add(listener, sioc);

=2E..but this adds sioc as a listener regardless of whether listen_sync()=

succeeded.  Is that right?


> +gboolean qio_net_listener_is_disconnected(QIONetListener *listener)
> +{
> +    return listener->disconnected;

Documentation says it returns true on connected, but here you are
returning true on disconnected?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LrRtltb2NJK3QkHVOSKH2PVW2oGm8P4Ap
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmMogkACgkQp6FrSiUn
Q2rUAgf8DFXWoL8UVckxJseRjdUc7ZfyB3M6mqs/WDV5eeY7W4C5EU5Ll6RwARbo
FHhJLH9O1i893SQDBF9Vqs/KvPNTC6PFfvsY4DKY0hYamQa+PHhofHH5xD9PNKFD
LBqnzB9c3MlP1vMQ6PCPUrG46l5cmKYpWAW7RRBhG4UR4DiY9euW9vtQyBl+Ib+O
KJ0tSw8+vsuTt79OVWqD0qWmCeJ524/GK1ZSEPWjUxVi8qFzDkm38vrzk8M3XvM6
Kw5huLUchC1zFS7O325zkAiT9Z6E2DbP7Tc8z8EHvaWQKzIieeVqYy/HKZjF8aN/
ooljqKEGfc7inN86b3W83jeA9mQy5Q==
=BhvE
-----END PGP SIGNATURE-----

--LrRtltb2NJK3QkHVOSKH2PVW2oGm8P4Ap--
