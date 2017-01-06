Received: from eggs.gnu.org ([2001:4830:134:3::10]:48264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPWwg-0008Vq-KT
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:00:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPWwb-0007Lc-Oo
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:00:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPWwb-0007LA-Ez
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:00:41 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 55EFA7F7A6
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 16:00:41 +0000 (UTC)
References: <20170105160701.22118-1-berrange@redhat.com>
	<20170105160701.22118-6-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <eb839f71-6c80-9dce-583a-102586285616@redhat.com>
Date: Fri, 6 Jan 2017 10:00:33 -0600
MIME-Version: 1.0
In-Reply-To: <20170105160701.22118-6-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PxbP1XwNCm5jmesmG70R1fj7eWNvhlaUS"
Subject: Re: [Qemu-devel] [PATCH 5/8] ui: extract code to connect/listen
 from vnc_display_open
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
--PxbP1XwNCm5jmesmG70R1fj7eWNvhlaUS
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <eb839f71-6c80-9dce-583a-102586285616@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/8] ui: extract code to connect/listen from
 vnc_display_open
References: <20170105160701.22118-1-berrange@redhat.com>
 <20170105160701.22118-6-berrange@redhat.com>
In-Reply-To: <20170105160701.22118-6-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 10:06 AM, Daniel P. Berrange wrote:
> The code which takes a SocketAddress and connects/listens on the
> network is going to get more complicated to deal with multiple
> listeners. Pull it out into a separate method to avoid making the
> vnc_display_open method even more complex.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  ui/vnc.c | 122 +++++++++++++++++++++++++++++++++++++++++--------------=
--------
>  1 file changed, 80 insertions(+), 42 deletions(-)
>=20

> +static int vnc_display_listen(VncDisplay *vd,
> +                              SocketAddress *saddr,
> +                              SocketAddress *wsaddr,
> +                              Error **errp)
> +{
> +    vd->is_unix =3D saddr->type =3D=3D SOCKET_ADDRESS_KIND_UNIX;
> +
> +    if (vnc_display_listen_addr(vd, saddr,
> +                                "vnc-listen",
> +                                &vd->lsock,
> +                                &vd->lsock_tag,
> +                                &vd->nlsock,
> +                                errp) < 0) {
> +        return -1;

If this succeeds,

> +    }
> +    if (wsaddr &&
> +        vnc_display_listen_addr(vd, wsaddr,
> +                                "vnc-ws-listen",
> +                                &vd->lwebsock,
> +                                &vd->lwebsock_tag,
> +                                &vd->nlwebsock,
> +                                errp) < 0) {
> +        return -1;

but this fails, you are relying on the caller to clean up the successful
port allocation.  Then again, in the old code:

> @@ -3909,53 +3987,13 @@ void vnc_display_open(const char *id, Error **e=
rrp)

>      } else {
> -        vd->nlsock =3D 1;
> -        vd->lsock =3D g_new0(QIOChannelSocket *, 1);
> -        vd->lsock_tag =3D g_new0(guint, 1);
> -
> -        vd->lsock[0] =3D qio_channel_socket_new();
> -        qio_channel_set_name(QIO_CHANNEL(vd->lsock[0]), "vnc-listen");=

> -        if (qio_channel_socket_listen_sync(vd->lsock[0], saddr, errp) =
< 0) {
> +        if (vnc_display_listen(vd, saddr, wsaddr, errp) < 0) {
>              goto fail;
>          }
> -        vd->is_unix =3D saddr->type =3D=3D SOCKET_ADDRESS_KIND_UNIX;
> -
> -        if (wsaddr) {
> -            vd->nlwebsock =3D 1;
> -            vd->lwebsock =3D g_new0(QIOChannelSocket *, 1);
> -            vd->lwebsock_tag =3D g_new0(guint, 1);
> -
> -            vd->lwebsock[0] =3D qio_channel_socket_new();
> -            qio_channel_set_name(QIO_CHANNEL(vd->lwebsock[0]), "vnc-ws=
-listen");
> -            if (qio_channel_socket_listen_sync(vd->lwebsock[0],
> -                                               wsaddr, errp) < 0) {
> -                goto fail;
> -            }

this is all the more cleanup you do locally:

fail:
    qapi_free_SocketAddress(saddr);
    qapi_free_SocketAddress(wsaddr);
    ws_enabled =3D false;

so you already have cleanup at a distance when you have partial
allocation before failure (that is, the caller cleans up the
partially-constructed 'vd' object when errp is set).  So you aren't
making it worse.  Thus

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--PxbP1XwNCm5jmesmG70R1fj7eWNvhlaUS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYb78hAAoJEKeha0olJ0NqBG4H/iT4pYco3GMmFim4e91780ln
fbqhs5GUeLrJ1trfZ+9D/8HfoL2laa4F0zUuJi0Ot25eAWhU48rF2vJOjys14aDk
KnMrEAN99Rd7kAHhSNRxfhylxi7dA8+mdsRdGJX1ssYVx30l8EC1NsVAU1+ZA5BI
oEpXeOgBThwtsxvIJklQQCh56RZQfYleMq91T2DnBp/R68Ua5E+nCYjnBtYIRyym
hy08S0M5Ec7UA9PPSvpcmoTpEk3/e2SKjLotgPeyn9nBSq6uoDAZWf5IA0d+zlJh
W2+7SJIn9aiTkwg8fAM6/UtVIBEDMejytHX09caRlsLp+6qDIHMsWlr4fotA/LU=
=gyJV
-----END PGP SIGNATURE-----

--PxbP1XwNCm5jmesmG70R1fj7eWNvhlaUS--
