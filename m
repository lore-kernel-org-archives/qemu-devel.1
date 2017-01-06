Received: from eggs.gnu.org ([2001:4830:134:3::10]:50825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPX9k-0004xM-JJ
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:14:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPX9h-0005qr-4f
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:14:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPX9g-0005qW-SL
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:14:13 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E622BC0567A1
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 16:14:12 +0000 (UTC)
References: <20170105160701.22118-1-berrange@redhat.com>
	<20170105160701.22118-7-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <83869235-00b3-3417-79ff-28bd2df5df8f@redhat.com>
Date: Fri, 6 Jan 2017 10:14:10 -0600
MIME-Version: 1.0
In-Reply-To: <20170105160701.22118-7-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="T89K37DrQhlCcaJcuXEpgHUlqcsJ1DXh1"
Subject: Re: [Qemu-devel] [PATCH 6/8] ui: let VNC server listen on all
 resolved IP addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T89K37DrQhlCcaJcuXEpgHUlqcsJ1DXh1
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <83869235-00b3-3417-79ff-28bd2df5df8f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 6/8] ui: let VNC server listen on all
 resolved IP addresses
References: <20170105160701.22118-1-berrange@redhat.com>
 <20170105160701.22118-7-berrange@redhat.com>
In-Reply-To: <20170105160701.22118-7-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 10:06 AM, Daniel P. Berrange wrote:
> Remove the limitation that the VNC server can only listen on
> a single resolved IP address. This uses the new DNS resolver
> API to resolve a SocketAddress struct into an array of
> SocketAddress structs containing raw IP addresses. The VNC
> server will then attempt to listen on all resolve IP addresses.

s/resolve/resolved/

> An error will be returned if it was not possible to listen on
> all of the IP addresses.

s/all/any/ ?  That is, we fail only if we don't get at least one working
listener, or do we fail if even one listener fails while the other work?

>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  ui/vnc.c | 52 +++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 43 insertions(+), 9 deletions(-)
>=20

> -    (*lsock_tag)[0] =3D qio_channel_add_watch(
> -        QIO_CHANNEL((*lsock)[0]),
> -        G_IO_IN, vnc_listen_io, vd, NULL);
> +    for (i =3D 0; i < nrawaddrs; i++) {
> +        QIOChannelSocket *sioc =3D qio_channel_socket_new();
> +
> +        qio_channel_set_name(QIO_CHANNEL(sioc), name);
> +        if (qio_channel_socket_listen_sync(
> +                sioc, rawaddrs[i], listenerr =3D=3D NULL ? &listenerr =
: NULL) < 0) {
> +            continue;
> +        }
> +        (*nlsock)++;
> +        *lsock =3D g_renew(QIOChannelSocket *, *lsock, *nlsock);
> +        *lsock_tag =3D g_renew(guint, *lsock_tag, *nlsock);
> +
> +        (*lsock)[*nlsock - 1] =3D sioc;
> +        (*lsock_tag)[*nlsock - 1] =3D 0;
> +    }
> +
> +    for (i =3D 0; i < nrawaddrs; i++) {
> +        qapi_free_SocketAddress(rawaddrs[i]);
> +    }
> +    g_free(rawaddrs);
> +
> +    if (listenerr) {
> +        if (*nlsock =3D=3D 0) {
> +            error_propagate(errp, listenerr);
> +            return -1;
> +        } else {
> +            error_free(listenerr);
> +        }
> +    }

Answering my question - you fail only if ALL resolved addresses fail. If
at least one succeeds, the overall function succeeds.

With the commit message improved,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--T89K37DrQhlCcaJcuXEpgHUlqcsJ1DXh1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYb8JSAAoJEKeha0olJ0Nqe1EH/iVrw6bpdr00AmWWMV4ZY8N3
CNLKBTsbvYiDiq4x9Q4e1UmyPdzB0ifaM3vK6Vh5p7CWiMt6Gwspz5obi8IJg2BG
C6tToKjsXmQLGMzlPf2av0/f5CqenLjxOP6hh9IUi7QinLMonCEv2ZcXE4g7vCKU
Brx6P4L5CQz01zlKmwYRCAaShGtk/Nc7QnMpXxSn8PBOsYeAUwCNJIbDBkYst4Ni
RZdvdVNSWIqOYjWwwefZ/9SPqFBUsnO0FxDC0uzi+ZgKvu65/AO/4CHBOxZYt0Z7
CIH4/71KEgWNjH1GuLIkVl9YTRzVmciO1vU25WWYot+FNFqxCY7dgUeWpcVGcvs=
=1jZH
-----END PGP SIGNATURE-----

--T89K37DrQhlCcaJcuXEpgHUlqcsJ1DXh1--
