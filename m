Received: from eggs.gnu.org ([2001:4830:134:3::10]:39704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPWMc-0007tE-Ga
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:23:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPWMZ-0005Lr-97
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:23:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPWMZ-0005LB-0O
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:23:27 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E8DB97F7B7
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:23:26 +0000 (UTC)
References: <20170105160701.22118-1-berrange@redhat.com>
	<20170105160701.22118-4-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b9fc5446-b9d9-cede-2b1a-b3012f904b8d@redhat.com>
Date: Fri, 6 Jan 2017 09:23:24 -0600
MIME-Version: 1.0
In-Reply-To: <20170105160701.22118-4-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1Idalf02aAcA16e9VTgoUDRjIpEDVR4qn"
Subject: Re: [Qemu-devel] [PATCH 3/8] ui: refactor VncDisplay to allow
 multiple listening sockets
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
--1Idalf02aAcA16e9VTgoUDRjIpEDVR4qn
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <b9fc5446-b9d9-cede-2b1a-b3012f904b8d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/8] ui: refactor VncDisplay to allow
 multiple listening sockets
References: <20170105160701.22118-1-berrange@redhat.com>
 <20170105160701.22118-4-berrange@redhat.com>
In-Reply-To: <20170105160701.22118-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 10:06 AM, Daniel P. Berrange wrote:
> Currently there is only a single listener for plain VNC and
> a single listener for websockets VNC. This means that is

s/is/if/

> getaddrinfo() returns multiple IP addresses, for a hostname,
> the VNC server can only listen on one of them. This is
> just bearable if listening on wildcard interface, or if
> the host only has a single network interface to listen on,
> but if there are multiple NICs and the VNC server needs
> to listen on 2 or more specific IP addresses, it can't be
> done.
>=20
> This refactors the VncDisplay state so that it holds an
> array of listening sockets, but still only listens on
> one socket.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  ui/vnc.c | 103 +++++++++++++++++++++++++++++++++++++++++--------------=
--------
>  ui/vnc.h |  10 ++++---
>  2 files changed, 73 insertions(+), 40 deletions(-)

Are you using git's order directives to put .h files first?


> @@ -3819,30 +3843,36 @@ void vnc_display_open(const char *id, Error **e=
rrp)
>          vnc_connect(vd, sioc, false, false);
>          object_unref(OBJECT(sioc));
>      } else {
> -        vd->lsock =3D qio_channel_socket_new();
> -        qio_channel_set_name(QIO_CHANNEL(vd->lsock), "vnc-listen");
> -        if (qio_channel_socket_listen_sync(vd->lsock, saddr, errp) < 0=
) {
> +        vd->nlsock =3D 1;
> +        vd->lsock =3D g_new0(QIOChannelSocket *, 1);
> +        vd->lsock_tag =3D g_new0(guint, 1);

Is guint really the best type here...

> +++ b/ui/vnc.h
> @@ -146,10 +146,12 @@ struct VncDisplay
>      int num_exclusive;
>      int connections_limit;
>      VncSharePolicy share_policy;
> -    QIOChannelSocket *lsock;
> -    guint lsock_tag;
> -    QIOChannelSocket *lwebsock;
> -    guint lwebsock_tag;
> +    size_t nlsock;
> +    QIOChannelSocket **lsock;
> +    guint *lsock_tag;

=2E..and here?

> +    size_t nlwebsock;
> +    QIOChannelSocket **lwebsock;
> +    guint *lwebsock_tag;
>      DisplaySurface *ds;
>      DisplayChangeListener dcl;
>      kbd_layout_t *kbd_layout;
>=20

Whether or not you tweak the types to something a little more direct (I
thing guint is more hassle than it's worth when not directly passing the
field to glib functions),
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--1Idalf02aAcA16e9VTgoUDRjIpEDVR4qn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYb7ZsAAoJEKeha0olJ0Nq0sAIAJWAcS9DdFTdK/7WXossp7SI
YRqL5+tGda8rov8RQqoin9pSfT3jKHyFSxY4Y+YV6xA1Kcot39SDdPcwnmyi12eR
kq5gtEra3cyf3SW2S47C9kBO3pxoKZWZ0s990pSwEe0nv8REH35XvqZLwo41ORYC
G+58yA1bwPBAbxjqUqxOATAmLynztSKVQPvrmAc6Kcnrkyupg9KotJYlc9DvNnML
9T1UV+uHLdA5cRJCBUqzu/+x99k4MbaqmYVD5A094+mBVHjwAvEcP7TK94p/XL+S
jXQpewJI+ktYZXgI6m/vZtSC9LUNJG24MmA+T0oVJUZBa7SE4M0vqLIPeXaAeFs=
=Sugu
-----END PGP SIGNATURE-----

--1Idalf02aAcA16e9VTgoUDRjIpEDVR4qn--
